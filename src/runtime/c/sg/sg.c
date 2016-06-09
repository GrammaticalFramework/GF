#include <stdlib.h>
#include "sqlite3Btree.h"

#include "sg/sg.h"
#include "gu/mem.h"
#include "pgf/data.h"

#define SG_EXPRS       1
#define SG_PAIRS       2
#define SG_IDENTS      3
#define SG_LITERALS    4
#define SG_TOKENS      5
#define SG_TRIPLES     6
#define SG_TRIPLES_SPO 7
#define SG_TRIPLES_PO  8
#define SG_TRIPLES_O   9

struct SgSG {
	Btree *pBtree;
	int exprsTNum;                /* The page number for the table of expressions */
	int identsTNum;               /* The page number for the index on identifiers */
	int literalsTNum;             /* The page number for the index on literals */
	int pairsTNum;                /* The page number for the index on application pairs */
	int tokensTNum;               /* The page number for the index on linearization tokens */
	int triplesTNum;              /* The page number for the table of triples */
	int triplesIdxTNum[3];        /* The page number for the three indexes on triples */
	int autoCommit;
};

void
sg_raise_sqlite(int rc, GuExn* err)
{
	const char *msg = sqlite3BtreeErrName(rc);

	GuExnData* err_data = gu_raise(err, SgError);
	if (err_data) {
		err_data->data = gu_malloc(err_data->pool, strlen(msg)+1);
		strcpy(err_data->data, msg);
	}
}

void
sg_raise_err(GuString msg, GuExn* err)
{
	GuExnData* err_data = gu_raise(err, SgError);
	if (err_data) {
		err_data->data = (char*) msg;
	}
}

static int
sg_create_table(Btree* pBtree, BtCursor* crsSchema, int tblKey, int* pTNum, int flags)
{
	int rc;
	int file_format = sqlite3BtreeFileFormat(pBtree);

	int res = 0;
	rc = sqlite3BtreeMovetoUnpacked(crsSchema, 0, tblKey, 0, &res);
	if (rc != SQLITE_OK) {
		return rc;
	}

	Mem mem;
	int serial_type;

	if (res == 0) {
		u32 payloadSize;
		rc = sqlite3BtreeDataSize(crsSchema, &payloadSize);
		if (rc != SQLITE_OK)
			return rc;

		u32 avail = 0;
		const unsigned char* row = sqlite3BtreeDataFetch(crsSchema, &avail);
		row++;

		row += getVarint32(row, serial_type);
		row += sqlite3BtreeSerialGet(row, serial_type, &mem);
		assert(mem.flags & MEM_Int);

		*pTNum = mem.u.i;
	} else {
		rc = sqlite3BtreeCreateTable(pBtree, pTNum, flags);
		if (rc != SQLITE_OK) {
			return rc;
		}

		mem.flags = MEM_Int;
		mem.u.i = *pTNum;

		unsigned char buf[32];
		unsigned char *p;

        buf[0] = 2;
		serial_type = sqlite3BtreeSerialType(&mem, file_format);
		buf[1] = serial_type;
		
		p = buf+2;
		p += sqlite3BtreeSerialPut(buf+2, &mem, serial_type);

		rc = sqlite3BtreeInsert(crsSchema, 0, tblKey,
			                        buf, p-buf, 0,
			                        0, 0);
		if (rc != SQLITE_OK)
			return rc;		
	}

	return SQLITE_OK;
}

SgSG*
sg_open(const char *filename,
        GuExn* err)
{
	int rc;

	Btree* pBtree;
    rc = sqlite3BtreeOpen(0, filename, &pBtree,
                          0, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_MAIN_DB);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return NULL;
	}

	rc = sqlite3BtreeBeginTrans(pBtree, 1);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		sqlite3BtreeClose(pBtree);
		return NULL;
	}

	BtCursor* crsSchema = NULL;
	rc = sqlite3BtreeCursor(pBtree, 1, 1, 0, 0, &crsSchema);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		sqlite3BtreeClose(pBtree);
		return NULL;
	}

	SgSG* sg = malloc(sizeof(SgSG));
	sg->pBtree = pBtree;
	sg->autoCommit = 1;

	rc = sg_create_table(pBtree, crsSchema, SG_EXPRS, &sg->exprsTNum, BTREE_INTKEY);
	if (rc != SQLITE_OK)
		goto fail;

	rc = sg_create_table(pBtree, crsSchema, SG_IDENTS, &sg->identsTNum, 0);
	if (rc != SQLITE_OK)
		goto fail;

	rc = sg_create_table(pBtree, crsSchema, SG_LITERALS, &sg->literalsTNum, 0);
	if (rc != SQLITE_OK)
		goto fail;

	rc = sg_create_table(pBtree, crsSchema, SG_PAIRS, &sg->pairsTNum, 0);
	if (rc != SQLITE_OK)
		goto fail;

	rc = sg_create_table(pBtree, crsSchema, SG_TOKENS, &sg->tokensTNum, 0);
	if (rc != SQLITE_OK)
		goto fail;

	rc = sg_create_table(pBtree, crsSchema, SG_TRIPLES, &sg->triplesTNum, BTREE_INTKEY);
	if (rc != SQLITE_OK)
		goto fail;

	rc = sg_create_table(pBtree, crsSchema, SG_TRIPLES_SPO, &sg->triplesIdxTNum[0], 0);
	if (rc != SQLITE_OK)
		goto fail;

	rc = sg_create_table(pBtree, crsSchema, SG_TRIPLES_PO, &sg->triplesIdxTNum[1], 0);
	if (rc != SQLITE_OK)
		goto fail;

	rc = sg_create_table(pBtree, crsSchema, SG_TRIPLES_O, &sg->triplesIdxTNum[2], 0);
	if (rc != SQLITE_OK)
		goto fail;

	sqlite3BtreeCloseCursor(crsSchema);

	rc = sqlite3BtreeCommit(pBtree);
	if (rc != SQLITE_OK)
		goto fail;

	return sg;
	
fail:
	sg_raise_sqlite(rc, err);
	if (crsSchema != NULL)
		sqlite3BtreeCloseCursor(crsSchema);
	sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
	sqlite3BtreeClose(pBtree);
	free(sg);
	return NULL;
}

void
sg_close(SgSG* sg, GuExn* err)
{
	sqlite3BtreeClose(sg->pBtree);
}

void
sg_shutdown()
{
	sqlite3BtreeShutdown();
}

void
sg_begin_trans(SgSG* sg, GuExn* err)
{
	int rc = sqlite3BtreeBeginTrans(sg->pBtree, 1);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return;
	}
	sg->autoCommit = 0;
}

void
sg_commit(SgSG* sg, GuExn* err)
{
	int rc = sqlite3BtreeCommit(sg->pBtree);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return;
	}
	sg->autoCommit = 1;
}

void
sg_rollback(SgSG* sg, GuExn* err)
{
	int rc = sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return;
	}
	sg->autoCommit = 1;
}

typedef struct {
	int n_cursors;
	BtCursor* crsExprs;
	BtCursor* crsIdents;
	BtCursor* crsLiterals;
	BtCursor* crsPairs;
	SgId key_seed;
} ExprContext;

static int
open_exprs(SgSG *sg, int wrFlag, bool identsOnly,
           ExprContext* ctxt, GuExn* err)
{
	ctxt->n_cursors = 0;

	int rc;

	rc = sqlite3BtreeCursor(sg->pBtree, sg->exprsTNum, wrFlag, 0, 0, &ctxt->crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return rc;
	}
	ctxt->n_cursors++;

	rc = sqlite3BtreeCursor(sg->pBtree, sg->identsTNum, wrFlag, 1, 1, &ctxt->crsIdents);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return rc;
	}
	ctxt->n_cursors++;

	if (!identsOnly) {
		rc = sqlite3BtreeCursor(sg->pBtree, sg->literalsTNum, wrFlag, 1, 1, &ctxt->crsLiterals);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return rc;
		}
		ctxt->n_cursors++;

		rc = sqlite3BtreeCursor(sg->pBtree, sg->pairsTNum, wrFlag, 2, 0, &ctxt->crsPairs);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return rc;
		}
		ctxt->n_cursors++;
	}

	if (wrFlag) {
		int res;
		rc = sqlite3BtreeLast(ctxt->crsExprs, &res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return rc;
		}

		rc = sqlite3BtreeKeySize(ctxt->crsExprs, &ctxt->key_seed);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return rc;
		}
	} else {
		ctxt->key_seed = 0;
	}

	return SQLITE_OK;
}

static void
close_exprs(ExprContext* ctxt)
{
	if (ctxt->n_cursors >= 4) {
		sqlite3BtreeCloseCursor(ctxt->crsPairs);
	}

	if (ctxt->n_cursors >= 3) {
		sqlite3BtreeCloseCursor(ctxt->crsLiterals);
	}

	if (ctxt->n_cursors >= 2) {
		sqlite3BtreeCloseCursor(ctxt->crsIdents);
	}

	if (ctxt->n_cursors >= 1) {
		sqlite3BtreeCloseCursor(ctxt->crsExprs);
	}
	
	ctxt->n_cursors = 0;
}

static int
find_function_rowid(SgSG* sg, ExprContext* ctxt,
                    GuString fun, SgId* pKey, int wrFlag)
{
	int rc = SQLITE_OK;
	int file_format = sqlite3BtreeFileFormat(sg->pBtree);

	Mem mem[2];
	mem[0].flags = MEM_Str;
	mem[0].n = strlen(fun);
	mem[0].z = (void*) fun;

	UnpackedRecord idxKey;
	sqlite3BtreeInitUnpackedRecord(&idxKey, ctxt->crsIdents, 1, 0, mem);

	int res = 0;
	rc = sqlite3BtreeMovetoUnpacked(ctxt->crsIdents,
									&idxKey, 0,  0, &res);
	if (rc != SQLITE_OK) {
		return rc;
	}

	if (res == 0) {
		rc = sqlite3BtreeIdxRowid(sg->pBtree, ctxt->crsIdents, pKey);
	} else {
		if (wrFlag == 0) {
			*pKey = 0;
			return SQLITE_OK;
		}

		*pKey = ++ctxt->key_seed;

		int serial_type_fun = sqlite3BtreeSerialType(&mem[0], file_format);
		int serial_type_fun_hdr_len = sqlite3BtreeVarintLen(serial_type_fun);

		mem[1].flags = MEM_Int;
		mem[1].u.i = *pKey;

		int serial_type_key = sqlite3BtreeSerialType(&mem[1], file_format);
		int serial_type_key_hdr_len = sqlite3BtreeVarintLen(serial_type_key);

		unsigned char* buf = malloc(1+serial_type_fun_hdr_len+(serial_type_key_hdr_len > 1 ? serial_type_key_hdr_len : 1)+mem[0].n+8);
		unsigned char* p = buf;
		*p++ = 1+serial_type_fun_hdr_len+1;
		p += putVarint32(p, serial_type_fun);
		*p++ = 0;
		memcpy(p, fun, mem[0].n);
		p += mem[0].n;

		rc = sqlite3BtreeInsert(ctxt->crsExprs, 0, *pKey,
		                        buf, p-buf, 0,
		                        0, 0);
		if (rc != SQLITE_OK) {
			goto free;
		}

		p = buf;
		*p++ = 1+serial_type_fun_hdr_len+serial_type_key_hdr_len;
		p += putVarint32(p, serial_type_fun);
		p += putVarint32(p, serial_type_key);
		memcpy(p, fun, mem[0].n);
		p += mem[0].n;
		p += sqlite3BtreeSerialPut(p, &mem[1], serial_type_key);
		rc = sqlite3BtreeInsert(ctxt->crsIdents, buf, p-buf,
		                        0, *pKey, 0,
		                        0, 0);

free:
		free(buf);
	}

	return rc;
}

static int
store_expr(SgSG* sg,
           ExprContext* ctxt, PgfExpr expr, SgId* pKey, int wrFlag)
{
	int rc = SQLITE_OK;
	int file_format = sqlite3BtreeFileFormat(sg->pBtree);

	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS: {
		gu_impossible();
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;

		Mem mem[3];

		mem[0].flags = MEM_Int;
		rc = store_expr(sg, ctxt, app->fun, &mem[0].u.i, wrFlag);
		if (rc != SQLITE_OK)
			return rc;
		if (wrFlag == 0 && mem[0].u.i == 0) {
			*pKey = 0;
			return SQLITE_OK;
		}

		mem[1].flags = MEM_Int;
		rc = store_expr(sg, ctxt, app->arg, &mem[1].u.i, wrFlag);
		if (rc != SQLITE_OK)
			return rc;
		if (wrFlag == 0 && mem[1].u.i == 0) {
			*pKey = 0;
			return SQLITE_OK;
		}

		UnpackedRecord idxKey;
		sqlite3BtreeInitUnpackedRecord(&idxKey, ctxt->crsPairs, 2, 0, mem);

		int res = 0;
		rc = sqlite3BtreeMovetoUnpacked(ctxt->crsPairs,
		                                &idxKey, 0,  0, &res);
		if (rc != SQLITE_OK) {
			return rc;
		}

		if (res == 0) {
			rc = sqlite3BtreeIdxRowid(sg->pBtree, ctxt->crsPairs, pKey);
		} else {
			if (wrFlag == 0) {
				*pKey = 0;
				return SQLITE_OK;
			}

			*pKey = ++ctxt->key_seed;

			unsigned char buf[32];  // enough for a record with three integers
			buf[1] = 3;

			u32 serial_type;
			unsigned char* p = buf+4;

			serial_type = sqlite3BtreeSerialType(&mem[0], file_format);
			buf[2] = serial_type;
			p += sqlite3BtreeSerialPut(p, &mem[0], serial_type);

			serial_type = sqlite3BtreeSerialType(&mem[1], file_format);
			buf[3] = serial_type;
			p += sqlite3BtreeSerialPut(p, &mem[1], serial_type);

			rc = sqlite3BtreeInsert(ctxt->crsExprs, 0, *pKey,
			                        buf+1, p-(buf+1), 0,
			                        0, 0);
			if (rc != SQLITE_OK) {
				return rc;
			}

			buf[0] = 4;
			buf[1] = buf[2];
			buf[2] = buf[3];

			mem[2].flags = MEM_Int;
			mem[2].u.i = *pKey;
			serial_type = sqlite3BtreeSerialType(&mem[2], file_format);
			buf[3] = serial_type;
			p += sqlite3BtreeSerialPut(p, &mem[2], serial_type);

			rc = sqlite3BtreeInsert(ctxt->crsPairs, buf, p-buf,
			                        0, *pKey, 0,
			                        0, 0);
        }
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* elit = ei.data;

		Mem mem[2];

		GuVariantInfo li = gu_variant_open(elit->lit);
		switch (li.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lstr = li.data;

			mem[0].flags = MEM_Str;
			mem[0].n = strlen(lstr->val);
			mem[0].z = lstr->val;
			break;
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lint = li.data;

			mem[0].flags = MEM_Int;
			mem[0].u.i = lint->val;
			break;
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lflt = li.data;

			mem[0].flags = MEM_Real;
			mem[0].u.r = lflt->val;
			break;
		}
		default:
			gu_impossible();
		}

		UnpackedRecord idxKey;
		sqlite3BtreeInitUnpackedRecord(&idxKey, ctxt->crsIdents, 1, 0, mem);

		int res = 0;
		rc = sqlite3BtreeMovetoUnpacked(ctxt->crsLiterals,
		                                &idxKey, 0,  0, &res);
		if (rc != SQLITE_OK) {
			return rc;
		}

		if (res == 0) {
			rc = sqlite3BtreeIdxRowid(sg->pBtree, ctxt->crsLiterals, pKey);
		} else {
			if (wrFlag == 0) {
				*pKey = 0;
				return SQLITE_OK;
			}

			*pKey = ++ctxt->key_seed;

			mem[1].flags = MEM_Int;
			mem[1].u.i = 0;

			int serial_type_lit = sqlite3BtreeSerialType(&mem[0], file_format);
			int serial_type_lit_hdr_len = sqlite3BtreeVarintLen(serial_type_lit);
			int serial_type_arg = sqlite3BtreeSerialType(&mem[1], file_format);
			int serial_type_arg_hdr_len = sqlite3BtreeVarintLen(serial_type_arg);

			unsigned char* buf = malloc(1+serial_type_lit_hdr_len+(serial_type_arg_hdr_len > 1 ? serial_type_arg_hdr_len : 1)+mem[0].n+8);
			unsigned char* p = buf;
			*p++ = 1+serial_type_lit_hdr_len+serial_type_arg_hdr_len;
			p += putVarint32(p, serial_type_lit);
			p += putVarint32(p, serial_type_arg);
			p += sqlite3BtreeSerialPut(p, &mem[0], serial_type_lit);
			p += sqlite3BtreeSerialPut(p, &mem[1], serial_type_arg);

			rc = sqlite3BtreeInsert(ctxt->crsExprs, 0, *pKey,
			                        buf, p-buf, 0,
			                        0, 0);
			if (rc == SQLITE_OK) {
				mem[1].flags = MEM_Int;
				mem[1].u.i = *pKey;

				int serial_type_key = sqlite3BtreeSerialType(&mem[1], file_format);
				int serial_type_key_hdr_len = sqlite3BtreeVarintLen(serial_type_key);

				p = buf;
				*p++ = 1+serial_type_lit_hdr_len+serial_type_key_hdr_len;
				p += putVarint32(p, serial_type_lit);
				p += putVarint32(p, serial_type_key);
				p += sqlite3BtreeSerialPut(p, &mem[0], serial_type_lit);
				p += sqlite3BtreeSerialPut(p, &mem[1], serial_type_key);
				rc = sqlite3BtreeInsert(ctxt->crsLiterals, buf, p-buf,
										0, *pKey, 0,
										0, 0);
			}

			free(buf);
		}
		break;
	}
	case PGF_EXPR_META: {
		gu_impossible();
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;
		rc = find_function_rowid(sg, ctxt, fun->fun, pKey, wrFlag);
        break;
	}
	case PGF_EXPR_VAR: {
		gu_impossible();
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* etyped = ei.data;
		rc = store_expr(sg, ctxt, etyped->expr, pKey, wrFlag);
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* eimpl = ei.data;
		rc = store_expr(sg, ctxt, eimpl->expr, pKey, wrFlag);
		break;
	}
	default:
		gu_impossible();
	}

	return rc;
}

SgId
sg_insert_expr(SgSG *sg, PgfExpr expr, int wrFlag, GuExn* err)
{
	int rc;

	if (sg->autoCommit) {
		rc = sqlite3BtreeBeginTrans(sg->pBtree, wrFlag);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return 0;
		}
	}

	ExprContext ctxt;
	rc = open_exprs(sg, wrFlag, false, &ctxt, err);
	if (rc != SQLITE_OK)
		goto close;

	SgId key;
	rc = store_expr(sg, &ctxt, expr, &key, wrFlag);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto close;
	}

	close_exprs(&ctxt);

	if (sg->autoCommit) {
		rc = sqlite3BtreeCommit(sg->pBtree);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return 0;
		}
	}

    return key;

close:
	close_exprs(&ctxt);

	if (sg->autoCommit) {
		sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
	}
	return 0;
}

static int
load_expr(BtCursor* crsExprs, SgId key, PgfExpr *pExpr, GuPool* out_pool)
{
	int res;
	int rc = sqlite3BtreeMovetoUnpacked(crsExprs, 0, key, 0, &res);
	if (rc != SQLITE_OK)
		return rc;

	if (res != 0) {
		*pExpr = gu_null_variant;
		return SQLITE_OK;
	}

	u32 payloadSize;
	rc = sqlite3BtreeDataSize(crsExprs, &payloadSize);
	if (rc != SQLITE_OK)
		return rc;

	u32 avail = 0;
	const unsigned char* row = sqlite3BtreeDataFetch(crsExprs, &avail);
	row++;

	int serial_type_fun, serial_type_arg;
	row += getVarint32(row, serial_type_fun);
	row += getVarint32(row, serial_type_arg);

	Mem mem[2];
	row += sqlite3BtreeSerialGet(row, serial_type_fun, &mem[0]);
	row += sqlite3BtreeSerialGet(row, serial_type_arg, &mem[1]);

	if (mem[1].flags & MEM_Null) {
		u32 len = sqlite3BtreeSerialTypeLen(serial_type_fun);

		PgfExprFun *efun =
			gu_new_flex_variant(PGF_EXPR_FUN,
			                    PgfExprFun,
			                    fun, len+1,
			                    pExpr, out_pool);
		memcpy(efun->fun, mem[0].z, len);
		efun->fun[len] = 0;
	} else if (mem[1].u.i == 0) {
		PgfExprLit *elit =
			gu_new_variant(PGF_EXPR_LIT,
			               PgfExprLit,
			               pExpr, out_pool);

		if (mem[0].flags & MEM_Str) {
			u32 len = sqlite3BtreeSerialTypeLen(serial_type_fun);

			PgfLiteralStr *lstr =
				gu_new_flex_variant(PGF_LITERAL_STR,
				                    PgfLiteralStr,
				                    val, len+1,
				                    &elit->lit, out_pool);
			memcpy(lstr->val, mem[0].z, len);
			lstr->val[len] = 0;
		} else if (mem[0].flags & MEM_Int) {
			PgfLiteralInt *lint =
				gu_new_variant(PGF_LITERAL_INT,
				               PgfLiteralInt,
				               &elit->lit, out_pool);
			lint->val = mem[0].u.i;
		} else if (mem[0].flags & MEM_Real) {
			PgfLiteralFlt *lflt =
				gu_new_variant(PGF_LITERAL_FLT,
				               PgfLiteralFlt,
				               &elit->lit, out_pool);
			lflt->val = mem[0].u.r;
		} else {
			gu_impossible();
		}
	} else {
		PgfExprApp* papp =
			gu_new_variant(PGF_EXPR_APP, PgfExprApp, pExpr, out_pool);

		rc = load_expr(crsExprs, mem[0].u.i, &papp->fun, out_pool);
		if (rc != SQLITE_OK)
			return rc;

		rc = load_expr(crsExprs, mem[1].u.i, &papp->arg, out_pool);
		if (rc != SQLITE_OK)
			return rc;
	}

	return SQLITE_OK;
}

PgfExpr
sg_get_expr(SgSG *sg, SgId key, GuPool* out_pool, GuExn* err)
{
	int rc;
	if (sg->autoCommit) {
		rc = sqlite3BtreeBeginTrans(sg->pBtree, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return gu_null_variant;
		}
	}

	BtCursor* crsExprs;
	rc = sqlite3BtreeCursor(sg->pBtree, sg->exprsTNum, 0, 0, 0, &crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto rollback;
	}

	PgfExpr expr = gu_null_variant;
	rc = load_expr(crsExprs, key, &expr, out_pool);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto close;
	}

	rc = sqlite3BtreeCloseCursor(crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto rollback;
	}

	if (sg->autoCommit) {
		rc = sqlite3BtreeCommit(sg->pBtree);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			goto rollback;
		}
	}

    return expr;

close:
	sqlite3BtreeCloseCursor(crsExprs);

rollback:
	if (sg->autoCommit) {
		sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
	}
	return gu_null_variant;
}

// A query is compiled into a sequence of instructions with
// the following codes:
#define QI_PUSH   1
#define QI_VAR    2
#define QI_APPLY  3
#define QI_RETURN 4

typedef struct {
	int  code;
	SgId arg;
} QueryInstr;

struct SgQueryExprResult {
	ExprContext ectxt;
	GuBuf* instrs;
	GuBuf* queue;
	size_t iState;
	PgfMetaId min_meta_id;
	PgfMetaId max_meta_id;
};

typedef struct QueryArg QueryArg;
struct QueryArg {
	QueryArg* prev;
	SgId arg;
};

typedef struct {
	QueryArg* args;  // a stack of arguments
	int pc;          // program counter
} QueryState;

static int
build_expr_query(SgSG* sg,
                 SgQueryExprResult* ctxt, PgfExpr expr)
{
	int rc = SQLITE_OK;

	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS: {
		gu_impossible();
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;

		rc = build_expr_query(sg, ctxt, app->fun);
		if (rc != SQLITE_OK)
			return rc;
		QueryInstr* first =
			gu_buf_index_last(ctxt->instrs, QueryInstr);

		rc = build_expr_query(sg, ctxt, app->arg);
		if (rc != SQLITE_OK)
			return rc;
		QueryInstr* second =
			gu_buf_index_last(ctxt->instrs, QueryInstr);

		if (first->code == QI_PUSH && second->code == QI_PUSH &&
		    second - first == 1) {
			// we could directly combine the two expressions

			Mem mem[2];
			mem[0].flags = MEM_Int;
			mem[0].u.i   = first->arg;
			mem[1].flags = MEM_Int;
			mem[1].u.i   = second->arg;

			UnpackedRecord idxKey;
			sqlite3BtreeInitUnpackedRecord(&idxKey, ctxt->ectxt.crsPairs, 2, 0, mem);

			int res = 0;
			rc = sqlite3BtreeMovetoUnpacked(ctxt->ectxt.crsPairs,
											&idxKey, 0,  0, &res);
			if (rc != SQLITE_OK)
				return rc;
			if (res != 0)
				return SQLITE_DONE;

			gu_buf_pop(ctxt->instrs, QueryInstr);

			rc = sqlite3BtreeIdxRowid(sg->pBtree, ctxt->ectxt.crsPairs, &first->arg);
   		} else if (gu_variant_tag(app->arg) != PGF_EXPR_META) {
			QueryInstr* instr = gu_buf_extend(ctxt->instrs);
			instr->code = QI_APPLY;
			instr->arg  = 0;
		}
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* elit = ei.data;

		Mem mem;

		GuVariantInfo li = gu_variant_open(elit->lit);
		switch (li.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lstr = li.data;

			mem.flags = MEM_Str;
			mem.n = strlen(lstr->val);
			mem.z = lstr->val;
			break;
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lint = li.data;

			mem.flags = MEM_Int;
			mem.u.i = lint->val;
			break;
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lflt = li.data;

			mem.flags = MEM_Real;
			mem.u.r = lflt->val;
			break;
		}
		default:
			gu_impossible();
		}

		UnpackedRecord idxKey;
		sqlite3BtreeInitUnpackedRecord(&idxKey, ctxt->ectxt.crsIdents, 1, 0, &mem);

		int res = 0;
		rc = sqlite3BtreeMovetoUnpacked(ctxt->ectxt.crsLiterals,
		                                &idxKey, 0,  0, &res);
		if (rc != SQLITE_OK)
			return rc;
		if (res != 0)
			return SQLITE_DONE;

		QueryInstr* instr = gu_buf_extend(ctxt->instrs);
		instr->code = QI_PUSH;
		rc = sqlite3BtreeIdxRowid(sg->pBtree, ctxt->ectxt.crsLiterals, &instr->arg);
		break;
	}
	case PGF_EXPR_META: {
		PgfExprMeta* emeta = ei.data;
		QueryInstr* instr = gu_buf_extend(ctxt->instrs);
		instr->code = QI_VAR;
		instr->arg  = emeta->id;
		
		if (ctxt->min_meta_id > emeta->id)
			ctxt->min_meta_id = emeta->id;
		if (ctxt->max_meta_id < emeta->id)
			ctxt->max_meta_id = emeta->id;
		break;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;

		QueryInstr* instr = gu_buf_extend(ctxt->instrs);
		instr->code = QI_PUSH;
		rc = find_function_rowid(sg, &ctxt->ectxt, fun->fun, &instr->arg, 0);
		if (rc == SQLITE_OK && instr->arg == 0)
			return SQLITE_DONE;
        break;
	}
	case PGF_EXPR_VAR: {
		gu_impossible();
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* etyped = ei.data;
		rc = build_expr_query(sg, ctxt, etyped->expr);
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* eimpl = ei.data;
		rc = build_expr_query(sg, ctxt, eimpl->expr);
		break;
	}
	default:
		gu_impossible();
	}

	return rc;
}

static int
run_expr_query(SgSG* sg, SgQueryExprResult* ctxt, GuPool* pool)
{
	int rc;

	while (ctxt->iState < gu_buf_length(ctxt->queue)) {
		QueryState* state =
			gu_buf_index(ctxt->queue, QueryState, ctxt->iState);
		QueryInstr* instr =
			gu_buf_index(ctxt->instrs, QueryInstr, state->pc);

		switch (instr->code) {
		case QI_PUSH: {
			QueryArg* arg = gu_new(QueryArg, pool);
			arg->arg  = instr->arg;
			arg->prev = state->args;
			state->args = arg;
			break;
		}
		case QI_VAR: {
			assert(state->args != NULL);

			Mem mem;
			mem.flags = MEM_Int;
			mem.u.i   = state->args->arg;

			UnpackedRecord idxKey;
			sqlite3BtreeInitUnpackedRecord(&idxKey, ctxt->ectxt.crsPairs, 1, 1, &mem);

			int res = 0;
			rc = sqlite3BtreeMovetoUnpacked(ctxt->ectxt.crsPairs,
											&idxKey, 0,  0, &res);
			if (rc != SQLITE_OK)
				return rc;
			if (res < 0) {
				rc = sqlite3BtreeNext(ctxt->ectxt.crsPairs, &res);
			}
			res = 0;

			while (res == 0) {
				i64 szData;
				const unsigned char *zData;
				rc = sqlite3BtreeKeySize(ctxt->ectxt.crsPairs, &szData);
				if (rc != SQLITE_OK)
					return rc;

				u32 available = 0;
				zData = sqlite3BtreeKeyFetch(ctxt->ectxt.crsPairs, &available);
				if (szData > available)
					gu_impossible();

				idxKey.default_rc = 0;
				res = sqlite3BtreeRecordCompare(available, zData, &idxKey);
				if (res != 0)
					break;

				QueryArg* arg = gu_new(QueryArg, pool);
				arg->prev = state->args->prev;

				QueryState* state1 = gu_buf_extend(ctxt->queue);
				state1->args = arg;
				state1->pc   = state->pc+1;

				rc = sqlite3BtreeIdxRowid(sg->pBtree, ctxt->ectxt.crsPairs, &arg->arg);
				if (rc != SQLITE_OK)
					return rc;

				sqlite3BtreeNext(ctxt->ectxt.crsPairs, &res);
				if (rc != SQLITE_OK)
					return rc;
			}

			ctxt->iState++;
			break;
		}
		case QI_APPLY: {
			assert(state->args != NULL && state->args->prev);

			Mem mem[2];
			mem[0].flags = MEM_Int;
			mem[0].u.i   = state->args->prev->arg;
			mem[1].flags = MEM_Int;
			mem[1].u.i   = state->args->arg;

			UnpackedRecord idxKey;
			sqlite3BtreeInitUnpackedRecord(&idxKey, ctxt->ectxt.crsPairs, 2, 0, mem);

			int res = 0;
			rc = sqlite3BtreeMovetoUnpacked(ctxt->ectxt.crsPairs,
											&idxKey, 0,  0, &res);
			if (rc != SQLITE_OK)
				return rc;
			if (res != 0) {
				ctxt->iState++;
				continue;
			}

			state->args = state->args->prev;

			rc = sqlite3BtreeIdxRowid(sg->pBtree, ctxt->ectxt.crsPairs, &state->args->arg);
			if (rc != SQLITE_OK)
				return rc;
			break;
		}
		case QI_RETURN:
			return SQLITE_OK;
		}

		state->pc++;
	}

	return SQLITE_DONE;
}

SgQueryExprResult*
sg_query_expr(SgSG *sg, PgfExpr expr, GuPool* pool, GuExn* err)
{
	int rc;

	if (sg->autoCommit) {
		rc = sqlite3BtreeBeginTrans(sg->pBtree, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return NULL;
		}
	}

	SgQueryExprResult* ctxt = gu_new(SgQueryExprResult, pool);
	rc = open_exprs(sg, 0, false, &ctxt->ectxt, err);
	if (rc != SQLITE_OK)
		goto close;

	ctxt->instrs = gu_new_buf(QueryInstr, pool);
	ctxt->queue  = gu_new_buf(QueryState, pool);
	ctxt->iState = 0;
	ctxt->min_meta_id = INT_MAX;
	ctxt->max_meta_id = INT_MIN;

	rc = build_expr_query(sg, ctxt, expr);
	if (rc == SQLITE_OK) {
		QueryInstr* instr = gu_buf_extend(ctxt->instrs);
		instr->code = QI_RETURN;
		instr->arg  = 0;

		QueryState* state = gu_buf_extend(ctxt->queue);
		state->args = NULL;
		state->pc   = 0;
	} else if (rc != SQLITE_DONE) {
		sg_raise_sqlite(rc, err);
		goto close;
	}

    return ctxt;

close:
	close_exprs(&ctxt->ectxt);

	if (sg->autoCommit) {
		sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
	}
	return NULL;
}

PgfExpr
sg_query_next(SgSG *sg, SgQueryExprResult* ctxt, SgId* pKey, GuPool* pool, GuExn* err)
{
	int rc;

	rc = run_expr_query(sg, ctxt, pool);
	if (rc == SQLITE_DONE)
		return gu_null_variant;
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return gu_null_variant;
	}

	QueryState* state =
		gu_buf_index(ctxt->queue, QueryState, ctxt->iState);
	assert(state->args != NULL);
	ctxt->iState++;

	PgfExpr expr;
	rc = load_expr(ctxt->ectxt.crsExprs, state->args->arg, &expr, pool);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return gu_null_variant;
	}

	*pKey = state->args->arg;

	return expr;
}

void
sg_query_close(SgSG* sg, SgQueryExprResult* ctxt, GuExn* err)
{
	int rc;

	close_exprs(&ctxt->ectxt);

	if (sg->autoCommit) {
		rc = sqlite3BtreeCommit(sg->pBtree);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
		}
	}
}

static int
insert_token(SgSG *sg, BtCursor* crsTokens, GuString tok, SgId key)
{
	int rc = SQLITE_OK;
	int file_format = sqlite3BtreeFileFormat(sg->pBtree);

	Mem mem[2];
	mem[0].flags = MEM_Str;
	mem[0].n = strlen(tok);
	mem[0].z = (void*) tok;

	int serial_type_tok = sqlite3BtreeSerialType(&mem[0], file_format);
	int serial_type_tok_hdr_len = sqlite3BtreeVarintLen(serial_type_tok);

	mem[1].flags = MEM_Int;
	mem[1].u.i = key;

	int serial_type_key = sqlite3BtreeSerialType(&mem[1], file_format);
	int serial_type_key_hdr_len = sqlite3BtreeVarintLen(serial_type_key);

	unsigned char* buf = malloc(1+serial_type_tok_hdr_len+serial_type_key_hdr_len+mem[0].n+8);
	unsigned char* p = buf;
	*p++ = 1+serial_type_tok_hdr_len+serial_type_key_hdr_len;
	p += putVarint32(p, serial_type_tok);
	p += putVarint32(p, serial_type_key);
	memcpy(p, tok, mem[0].n);
	p += mem[0].n;
	p += sqlite3BtreeSerialPut(p, &mem[1], serial_type_key);
	rc = sqlite3BtreeInsert(crsTokens, buf, p-buf,
	                        0, key, 0,
	                        0, 0);
	free(buf);

	return rc;
}

static int
insert_syms(SgSG *sg, BtCursor* crsTokens, PgfSymbols* syms, SgId key)
{
	int rc;
	size_t n_syms = gu_seq_length(syms);
	for (size_t sym_idx = 0; sym_idx < n_syms; sym_idx++) {
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, sym_idx);
		GuVariantInfo sym_i = gu_variant_open(sym);
		switch (sym_i.tag) {
		case PGF_SYMBOL_KS: {
			PgfSymbolKS* ks = sym_i.data;
			rc = insert_token(sg, crsTokens, ks->token, key);
			if (rc != SQLITE_OK)
				return rc;
			break;
		}
		case PGF_SYMBOL_KP: {
			PgfSymbolKP* kp = sym_i.data;
			rc = insert_syms(sg, crsTokens, kp->default_form, key);
			if (rc != SQLITE_OK)
				return rc;
				
			for (size_t i = 0; i < kp->n_forms; i++) {
				rc = insert_syms(sg, crsTokens, kp->forms[i].form, key);
				if (rc != SQLITE_OK)
					return rc;
			}
			break;
		}
		}
	}
	
	return SQLITE_OK;
}

void
sg_update_fts_index(SgSG* sg, PgfPGF* pgf, GuExn* err)
{
	int rc = SQLITE_OK;

	if (sg->autoCommit) {
		rc = sqlite3BtreeBeginTrans(sg->pBtree, 1);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return;
		}
	}

	ExprContext ctxt;
	rc = open_exprs(sg, 1, true, &ctxt, err);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto close;
	}
	
	rc = sqlite3BtreeClearTable(sg->pBtree, sg->tokensTNum, NULL);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return;
	}

	BtCursor* crsTokens;
	rc = sqlite3BtreeCursor(sg->pBtree, sg->tokensTNum, 1, 1, 1, &crsTokens);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
	}
	ctxt.n_cursors++;

	size_t n_concrs = gu_seq_length(pgf->concretes);
	for (size_t i = 0; i < n_concrs; i++) {
		PgfConcr* concr = gu_seq_index(pgf->concretes, PgfConcr, i);
		
		size_t n_funs = gu_seq_length(concr->cncfuns);
		for (size_t funid = 0; funid < n_funs; funid++) {
			PgfCncFun* cncfun = gu_seq_get(concr->cncfuns, PgfCncFun*, funid);

			SgId key = 0;
			rc = find_function_rowid(sg, &ctxt, cncfun->absfun->name, &key, 1);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(rc, err);
				goto close;
			}

			for (size_t lin_idx = 0; lin_idx < cncfun->n_lins; lin_idx++) {
				PgfSequence* seq = cncfun->lins[lin_idx];
				rc = insert_syms(sg, crsTokens, seq->syms, key);
				if (rc != SQLITE_OK) {
					sg_raise_sqlite(rc, err);
					goto close;
				}
			}
		}
	}

	if (ctxt.n_cursors >= 3) {
		sqlite3BtreeCloseCursor(crsTokens);
		ctxt.n_cursors--;
	}

	close_exprs(&ctxt);
	
	if (sg->autoCommit) {
		rc = sqlite3BtreeCommit(sg->pBtree);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
		}
	}

    return;

close:
	if (ctxt.n_cursors >= 3) {
		sqlite3BtreeCloseCursor(crsTokens);
		ctxt.n_cursors--;
	}

	close_exprs(&ctxt);

	if (sg->autoCommit) {
		sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
	}
}

GuSeq*
sg_query_linearization(SgSG *sg, GuString tok, GuPool *pool, GuExn* err)
{
	int rc;

	BtCursor* crsTokens;
	rc = sqlite3BtreeCursor(sg->pBtree, sg->tokensTNum, 1, 1, 1, &crsTokens);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return NULL;
	}

	Mem mem[1];
	mem[0].flags = MEM_Str;
	mem[0].n = strlen(tok);
	mem[0].z = (void*) tok;

	UnpackedRecord idxKey;
	sqlite3BtreeInitUnpackedRecord(&idxKey, crsTokens, 1, 0, mem);

	int res = 0;
	rc = sqlite3BtreeMovetoUnpacked(crsTokens,
									&idxKey, 0,  0, &res);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return NULL;
	}
	
	GuBuf* ids = gu_new_buf(SgId, pool);

	while (res == 0) {
		SgId key;
		rc = sqlite3BtreeIdxRowid(sg->pBtree, crsTokens, &key);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			sqlite3BtreeClearCursor(crsTokens);
			return NULL;
		}

		gu_buf_push(ids, SgId, key);

		sqlite3BtreeNext(crsTokens, &res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			sqlite3BtreeClearCursor(crsTokens);
			return NULL;
		}

		i64 szData;
		const unsigned char *zData;
		rc = sqlite3BtreeKeySize(crsTokens, &szData);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			sqlite3BtreeClearCursor(crsTokens);
			return NULL;
		}

		u32 available = 0;
		zData = sqlite3BtreeKeyFetch(crsTokens, &available);
		if (szData > available)
			gu_impossible();

		res = sqlite3BtreeRecordCompare(available, zData, &idxKey);
		if (res != 0)
			break;
	}

	sqlite3BtreeClearCursor(crsTokens);
	return gu_buf_data_seq(ids);
}

typedef struct {
	int n_cursors;
	BtCursor* cursor[4];
} TripleContext;

static int
open_triples(SgSG *sg, int wrFlag, TripleContext* ctxt, GuExn* err)
{
	int rc;

	ctxt->n_cursors = 0;
	while (ctxt->n_cursors < 3) {
		rc = sqlite3BtreeCursor(sg->pBtree, sg->triplesIdxTNum[ctxt->n_cursors], wrFlag, 3-ctxt->n_cursors, ctxt->n_cursors, &ctxt->cursor[ctxt->n_cursors]);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return rc;
		}
		ctxt->n_cursors++;
	}

	rc = sqlite3BtreeCursor(sg->pBtree, sg->triplesTNum, wrFlag, 0, 0, &ctxt->cursor[ctxt->n_cursors]);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		return rc;
	}
	ctxt->n_cursors++;

	return SQLITE_OK;
}

static void
close_triples(TripleContext* ctxt)
{
	while (ctxt->n_cursors > 0) {
		ctxt->n_cursors--;
		sqlite3BtreeCloseCursor(ctxt->cursor[ctxt->n_cursors]);
	}
}

SgId
sg_insert_triple(SgSG *sg, SgTriple triple, GuExn* err)
{
	int rc;

	if (sg->autoCommit) {
		rc = sqlite3BtreeBeginTrans(sg->pBtree, 1);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return 0;
		}
	}

	TripleContext tctxt;
	rc = open_triples(sg, 1, &tctxt, err);
	if (rc != SQLITE_OK)
		goto close;

	Mem mem[4];

	ExprContext ectxt;
	rc = open_exprs(sg, 1, false, &ectxt, err);
	if (rc != SQLITE_OK)
		goto close;

	for (size_t i = 0; i < 3; i++) {
		mem[i].flags = MEM_Int;

		rc = store_expr(sg, &ectxt, triple[i], &mem[i].u.i, 1);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			goto close;
		}
	}

	UnpackedRecord idxKey;
	sqlite3BtreeInitUnpackedRecord(&idxKey, tctxt.cursor[0], 3, 0, mem);

	int res = 0;
	rc = sqlite3BtreeMovetoUnpacked(tctxt.cursor[0],
	                                &idxKey, 0,  0, &res);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto close;
	}

	SgId key = 0;

	if (res == 0) {
		rc = sqlite3BtreeIdxRowid(sg->pBtree, tctxt.cursor[0], &key);
	} else {
		rc = sqlite3BtreeLast(tctxt.cursor[3], &res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			goto close;
		}

		rc = sqlite3BtreeKeySize(tctxt.cursor[3], &key);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			goto close;
		}
		key++;

		u32 serial_type;
		unsigned char buf[41];  // enough for a record with three integers
		int file_format = sqlite3BtreeFileFormat(sg->pBtree);

		unsigned char* p = buf+(buf[0] = 5);

		serial_type = sqlite3BtreeSerialType(&mem[0], file_format);
		buf[1] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[0], serial_type);

		serial_type = sqlite3BtreeSerialType(&mem[1], file_format);
		buf[2] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[1], serial_type);

		serial_type = sqlite3BtreeSerialType(&mem[2], file_format);
		buf[3] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[2], serial_type);

		unsigned char* tmp = p;

		mem[3].flags = MEM_Int;
		mem[3].u.i = 1;
		serial_type = sqlite3BtreeSerialType(&mem[3], file_format);
		buf[4] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[3], serial_type);

		rc = sqlite3BtreeInsert(tctxt.cursor[3], 0, key,
								buf, p-buf, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			goto close;
		}

		mem[3].flags = MEM_Int;
		mem[3].u.i = key;

		p = tmp;
		serial_type = sqlite3BtreeSerialType(&mem[3], file_format);
		buf[4] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[3], serial_type);

		rc = sqlite3BtreeInsert(tctxt.cursor[0], buf, p-buf,
								0, key, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			goto close;
		}

		p = buf+(buf[0] = 4);

		serial_type = sqlite3BtreeSerialType(&mem[1], file_format);
		buf[1] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[1], serial_type);

		serial_type = sqlite3BtreeSerialType(&mem[2], file_format);
		buf[2] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[2], serial_type);

		serial_type = sqlite3BtreeSerialType(&mem[3], file_format);
		buf[3] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[3], serial_type);

		rc = sqlite3BtreeInsert(tctxt.cursor[1], buf, p-buf,
								0, key, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			goto close;
		}

		p = buf+(buf[0] = 3);

		serial_type = sqlite3BtreeSerialType(&mem[2], file_format);
		buf[1] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[2], serial_type);

		serial_type = sqlite3BtreeSerialType(&mem[3], file_format);
		buf[2] = serial_type;
		p += sqlite3BtreeSerialPut(p, &mem[3], serial_type);

		rc = sqlite3BtreeInsert(tctxt.cursor[2], buf, p-buf,
								0, key, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			goto close;
		}
	}

close:
	close_exprs(&ectxt);
	close_triples(&tctxt);

	if (sg->autoCommit) {
		if (rc == SQLITE_OK || rc == SQLITE_DONE) {
			rc = sqlite3BtreeCommit(sg->pBtree);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(rc, err);
				return 0;
			}
		} else {
			sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
		}
	}

	return key;
}

static int
load_triple(BtCursor* crsTriples, BtCursor* crsExprs, SgTriple triple,
            GuPool* out_pool)
{
	int rc;

	u32 payloadSize;
	rc = sqlite3BtreeDataSize(crsTriples, &payloadSize);
	if (rc != SQLITE_OK)
		return rc;

	u32 avail = 0;
	const unsigned char* row = sqlite3BtreeDataFetch(crsTriples, &avail);
	row++;

	int serial_type_subj, serial_type_pred, serial_type_obj;
	row += getVarint32(row, serial_type_subj);
	row += getVarint32(row, serial_type_pred);
	row += getVarint32(row, serial_type_obj);
	row++;

	Mem mem[3];
	row += sqlite3BtreeSerialGet(row, serial_type_subj, &mem[0]);
	row += sqlite3BtreeSerialGet(row, serial_type_pred, &mem[1]);
	row += sqlite3BtreeSerialGet(row, serial_type_obj,  &mem[2]);

	for (int i = 0; i < 3; i++) {
		if (gu_variant_is_null(triple[i])) {
			rc = load_expr(crsExprs, mem[i].u.i, &triple[i], out_pool);
			if (rc != SQLITE_OK)
				return rc;
		}
	}

	return SQLITE_OK;
}

int
sg_get_triple(SgSG *sg, SgId key, SgTriple triple,
              GuPool* out_pool, GuExn* err)
{
	triple[0] = gu_null_variant;
	triple[1] = gu_null_variant;
	triple[2] = gu_null_variant;

	int rc;
	if (sg->autoCommit) {
		rc = sqlite3BtreeBeginTrans(sg->pBtree, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return false;
		}
	}

	BtCursor* crsTriples;
	rc = sqlite3BtreeCursor(sg->pBtree, sg->triplesTNum, 0, 0, 0, &crsTriples);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto rollback;
	}

	BtCursor* crsExprs;
	rc = sqlite3BtreeCursor(sg->pBtree, sg->exprsTNum, 0, 0, 0, &crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto close1;
	}

	int res;
	rc = sqlite3BtreeMovetoUnpacked(crsTriples, 0, key, 0, &res);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto close;
	}

	if (res == 0) {
		rc = load_triple(crsTriples, crsExprs, triple, out_pool);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			goto close;
		}
	}

	rc = sqlite3BtreeCloseCursor(crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto close1;
	}

	rc = sqlite3BtreeCloseCursor(crsTriples);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
		goto rollback;
	}

	if (sg->autoCommit) {
		rc = sqlite3BtreeCommit(sg->pBtree);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return false;
		}
	}

	return (res == 0);

close:
	sqlite3BtreeCloseCursor(crsExprs);

close1:
	sqlite3BtreeCloseCursor(crsTriples);

rollback:
	if (sg->autoCommit) {
		sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
	}
	return false;
}

typedef struct {
	TripleContext tctxt;

	BtCursor* cursor;

	int res;
	Mem mem[3];
	UnpackedRecord idxKey;
}  SgTripleResultInt;

struct SgTripleResult {
	SgSG *sg;
	SgTriple triple;
	ExprContext ectxt;
	
	SgTripleResultInt i;
};

static int
init_triple_result_int(SgSG *sg, SgTripleResultInt* tresi, GuExn* err)
{
	int rc;

	rc = open_triples(sg, 0, &tresi->tctxt, err);
	if (rc != SQLITE_OK)
		return rc;

	int i = 0;
	while (i < 3) {
		if (tresi->mem[i].flags != MEM_Null)
			break;
		i++;
	}

	tresi->cursor = tresi->tctxt.cursor[i];
	sqlite3BtreeInitUnpackedRecord(&tresi->idxKey, tresi->cursor, 0, 0, &tresi->mem[i]);
	tresi->res = 0;

	while (i+tresi->idxKey.nField < 3) {
		tresi->idxKey.nField++;

		if (tresi->mem[i+tresi->idxKey.nField].flags == MEM_Null)
			break;
	}

	if (tresi->idxKey.nField > 0) {
		tresi->idxKey.default_rc = 1;
		rc = sqlite3BtreeMovetoUnpacked(tresi->cursor,
										&tresi->idxKey, 0,  0, &tresi->res);
		if (rc == SQLITE_OK) {
			if (tresi->res < 0) {
				rc = sqlite3BtreeNext(tresi->cursor, &tresi->res);
			}
			tresi->res = 0;
		}
	} else {
		rc = sqlite3BtreeFirst(tresi->cursor, &tresi->res);
	}

	if (rc != SQLITE_OK) {
		sg_raise_sqlite(rc, err);
	}

	return rc;
}

SgTripleResult*
sg_query_triple(SgSG *sg, SgTriple triple, GuExn* err)
{
	int rc;

	if (sg->autoCommit) {
		rc = sqlite3BtreeBeginTrans(sg->pBtree, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return NULL;
		}
	}

	SgTripleResult* tres = malloc(sizeof(SgTripleResult));
	tres->sg = sg;
	tres->triple[0] = triple[0];
	tres->triple[1] = triple[1];
	tres->triple[2] = triple[2];

	rc = open_exprs(sg, 0, false, &tres->ectxt, err);
	if (rc != SQLITE_OK)
		goto close;

	for (int i = 0; i < 3; i++) {
		if (gu_variant_is_null(triple[i]))
			tres->i.mem[i].flags = MEM_Null;
		else {
			tres->i.mem[i].flags = MEM_Int;
			rc = store_expr(sg, &tres->ectxt, triple[i], &tres->i.mem[i].u.i, 0);
			if (rc != SQLITE_OK)
				goto close;
			if (tres->i.mem[i].u.i == 0) {
				tres->i.res = 1;
				tres->i.tctxt.n_cursors = 0; // this is important since the triples are not initialized yet
				return tres;
			}
		}
	}

	rc = init_triple_result_int(sg, &tres->i, err);
	if (rc != SQLITE_OK) {
		return NULL;
	}

	return tres;

close:
	close_exprs(&tres->ectxt);

	if (sg->autoCommit) {
		sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
	}

	free(tres);
	return NULL;
}

static bool
triple_result_fetch_int(SgSG* sg, SgTripleResultInt* tresi,
                        SgId* pKey, GuExn* err)
{
	while (tresi->res == 0) {
		int rc;

		if (tresi->idxKey.nField > 0) {
			i64 szData;
			const unsigned char *zData;
			rc = sqlite3BtreeKeySize(tresi->cursor, &szData);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(rc, err);
				return false;
			}

			u32 available = 0;
			zData = sqlite3BtreeKeyFetch(tresi->cursor, &available);
			if (szData > available)
				gu_impossible();

			tresi->idxKey.default_rc = 0;
			tresi->res = sqlite3BtreeRecordCompare(available, zData, &tresi->idxKey);
			if (tresi->res != 0)
				return false;

			if (tresi->idxKey.aMem == &tresi->mem[0] &&
			    tresi->idxKey.nField == 1 &&
			    tresi->mem[2].flags != MEM_Null) {
				int offset = 
					zData[0] + 
					sqlite3BtreeSerialTypeLen(zData[1]) + 
					sqlite3BtreeSerialTypeLen(zData[2]);
				zData+offset;
				Mem mem;
				sqlite3BtreeSerialGet(zData+offset, zData[3], &mem);
				if (mem.u.i != tresi->mem[2].u.i) {
					sqlite3BtreeNext(tresi->cursor, &tresi->res);
					if (rc != SQLITE_OK) {
						sg_raise_sqlite(rc, err);
						return false;
					}
					continue;
				}
			}
		}

		if (tresi->idxKey.nField > 0) {
			rc = sqlite3BtreeIdxRowid(sg->pBtree, tresi->cursor, pKey);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(rc, err);
				return false;
			}

			rc = sqlite3BtreeMovetoUnpacked(tresi->tctxt.cursor[3], 0, *pKey, 0, &tresi->res);
		} else {
			rc = sqlite3BtreeKeySize(tresi->cursor, pKey);
		}
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return false;
		}
		
		sqlite3BtreeNext(tresi->cursor, &tresi->res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return false;
		}

		return true;
	}

	return false;
}

int
sg_triple_result_fetch(SgTripleResult* tres, SgId* pKey, SgTriple triple,
                       GuPool* out_pool, GuExn* err)
{
	triple[0] = tres->triple[0];
	triple[1] = tres->triple[1];
	triple[2] = tres->triple[2];

	while (tres->i.res == 0) {
		int rc;

		if (tres->i.idxKey.nField > 0) {
			i64 szData;
			const unsigned char *zData;
			rc = sqlite3BtreeKeySize(tres->i.cursor, &szData);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(rc, err);
				return false;
			}

			u32 available = 0;
			zData = sqlite3BtreeKeyFetch(tres->i.cursor, &available);
			if (szData > available)
				gu_impossible();

			tres->i.idxKey.default_rc = 0;
			tres->i.res = sqlite3BtreeRecordCompare(available, zData, &tres->i.idxKey);
			if (tres->i.res != 0)
				return false;

			if (tres->i.idxKey.aMem == &tres->i.mem[0] &&
			    tres->i.idxKey.nField == 1 &&
			    tres->i.mem[2].flags != MEM_Null) {
				int offset = 
					zData[0] + 
					sqlite3BtreeSerialTypeLen(zData[1]) + 
					sqlite3BtreeSerialTypeLen(zData[2]);
				zData+offset;
				Mem mem;
				sqlite3BtreeSerialGet(zData+offset, zData[3], &mem);
				if (mem.u.i != tres->i.mem[2].u.i) {
					sqlite3BtreeNext(tres->i.cursor, &tres->i.res);
					if (rc != SQLITE_OK) {
						sg_raise_sqlite(rc, err);
						return false;
					}
					continue;
				}
			}
		}

		if (tres->i.idxKey.nField > 0) {
			rc = sqlite3BtreeIdxRowid(tres->sg->pBtree, tres->i.cursor, pKey);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(rc, err);
				return false;
			}

			rc = sqlite3BtreeMovetoUnpacked(tres->i.tctxt.cursor[3], 0, *pKey, 0, &tres->i.res);
		} else {
			rc = sqlite3BtreeKeySize(tres->i.cursor, pKey);
		}
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return false;
		}

		rc = load_triple(tres->i.tctxt.cursor[3], tres->ectxt.crsExprs,
		                 triple, out_pool);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return false;
		}
		
		sqlite3BtreeNext(tres->i.cursor, &tres->i.res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return false;
		}
		
		return true;
	}

	return false;
}

void
sg_triple_result_get_query(SgTripleResult* tres, SgTriple triple)
{
	triple[0] = tres->triple[0];
	triple[1] = tres->triple[1];
	triple[2] = tres->triple[2];
}

void
sg_triple_result_close(SgTripleResult* tres, GuExn* err)
{
	close_exprs(&tres->ectxt);
	close_triples(&tres->i.tctxt);

	if (tres->sg->autoCommit) {
		int rc = sqlite3BtreeCommit(tres->sg->pBtree);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return;
		}
	}

	free(tres);
}

typedef int SgPattern[3];

struct SgQuery {
	size_t n_vars;
	struct {
		SgId id;
		PgfExpr expr;
	}* vars;

	size_t n_sels;
	int* sel;

	size_t n_patterns;
	SgPattern patterns[];
};

struct SgQueryResult {
	SgSG* sg;
	SgQuery* query;
	ExprContext ectxt;

	bool is_empty;

	int n_results;
	SgTripleResultInt results[];
};

SgQuery*
sg_prepare_query(SgSG *sg, size_t n_triples, SgTriple* triples,
                 GuPool* pool, GuExn* err)
{
	int rc;

	if (sg->autoCommit) {
		rc = sqlite3BtreeBeginTrans(sg->pBtree, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return NULL;
		}
	}

	ExprContext ectxt;
	rc = open_exprs(sg, 0, false, &ectxt, err);
	if (rc != SQLITE_OK)
		goto close;

	SgQuery* query = gu_new_flex(pool, SgQuery, patterns, n_triples);
	query->n_vars = 0;
	query->vars   = gu_malloc(pool, sizeof(query->vars[0])*n_triples*3);

	query->n_patterns = n_triples;
	for (size_t i = 0; i < n_triples; i++) {
		for (int k = 0; k < 3; k++) {
			PgfExpr expr = triples[i][k];

			size_t j = 0;
			while (j < query->n_vars) {
				if (pgf_expr_eq(expr, query->vars[j].expr))
					break;
				j++;
			}
			if (j >= query->n_vars) {
				query->vars[j].expr = expr;

				if (gu_variant_tag(expr) == PGF_EXPR_META)
					query->vars[j].id = 0;
				else {
					rc = store_expr(sg, &ectxt, expr, &query->vars[j].id, 0);
					if (rc != SQLITE_OK) {
						sg_raise_sqlite(rc, err);
						goto close;
					}
					
					if (query->vars[j].id == 0)
						goto close;
				}

				query->n_vars++;
			}

			query->patterns[i][k] = j;
		}
	}

	close_exprs(&ectxt);
	
	if (sg->autoCommit) {
		rc = sqlite3BtreeCommit(sg->pBtree);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return 0;
		}
	}

	return query;

close:
	close_exprs(&ectxt);
	
	if (sg->autoCommit) {
		sqlite3BtreeRollback(sg->pBtree, SQLITE_ABORT_ROLLBACK, 0);
	}

	return NULL;
}

SgQueryResult*
sg_query(SgSG *sg, SgQuery* query, GuExn* err)
{
	int rc;

	if (sg->autoCommit) {
		rc = sqlite3BtreeBeginTrans(sg->pBtree, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(rc, err);
			return NULL;
		}
	}

	SgQueryResult* qres = 
		malloc(sizeof(SgQueryResult)+
		       sizeof(SgTripleResultInt)*query->n_patterns);
	qres->sg = sg;
	qres->is_empty = false;
	qres->query = query;
	qres->n_results = 0;

	rc = open_exprs(sg, 0, false, &qres->ectxt, err);
	if (rc != SQLITE_OK)
		goto close;

	return qres;
	
close:
	return NULL;
}

bool
sg_query_result_fetch(SgQueryResult* qres, PgfExpr* res, GuPool* out_pool, GuExn* err)
{
	if (qres->is_empty)
		return false;

	int rc;

	size_t i = 0;
	while (i < qres->query->n_patterns) {
		for (int k = 0; k < 3; k++) {
			if (qres->query->vars[qres->query->patterns[i][k]].id == 0)
				qres->results[i].mem[k].flags = MEM_Null;
			else {
				qres->results[i].mem[k].flags = MEM_Int;
				qres->results[i].mem[i].u.i   = qres->query->vars[qres->query->patterns[i][k]].id;
			}
		}

		rc = init_triple_result_int(qres->sg, &qres->results[i], err);
		if (rc != SQLITE_OK)
			goto close;

		SgTriple triple;

		SgId key;
		for (;;) {
			bool found = 
				triple_result_fetch_int(qres->sg, &qres->results[i],
				                        &key, err);
			if (gu_exn_is_raised(err)) {
				return false;
			}

			if (found)
				break;

			close_triples(&qres->results[i].tctxt);

			if (i == 0)
				return false;

			i--;
		}

		qres->query->vars[qres->query->patterns[i][0]].id = triple[0];
		qres->query->vars[qres->query->patterns[i][1]].id = triple[1];
		qres->query->vars[qres->query->patterns[i][2]].id = triple[2];

		i++;
	}

	for (size_t i = 0; i < qres->query->n_sels; i++) {
		res[i] = qres->query->vars[qres->query->sel[i]].expr;
		if (gu_variant_is_null(res[i])) {
			rc = load_expr(qres->ectxt.crsExprs,
			               qres->query->vars[qres->query->sel[i]].id,
			               &res[i], out_pool);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(rc, err);
				goto close;
			}

			qres->query->vars[qres->query->sel[i]].expr = res[i];
		}
	}

	return true;
	
close:
	return false;
}
