#define SQLITE_API static
#include "sqlite3.c"

#include "sg/sg.h"
#include "pgf/data.h"

#define SG_EXPRS    "sg_exprs"
#define SG_PAIRS    "sg_pairs"
#define SG_IDENTS   "sg_idents"
#define SG_LITERALS "sg_literals"
#define SG_TOKENS   "sg_tokens"
#define SG_TRIPLES  "sg_triples"
#define SG_TRIPLES_SPO "sg_triples_spo"
#define SG_TRIPLES_PO  "sg_triples_po"
#define SG_TRIPLES_O   "sg_triples_o"

void
sg_raise_sqlite(sqlite3* db, GuExn* err)
{
	const char *msg = sqlite3_errmsg(db);

	GuExnData* err_data = gu_raise(err, SgError);
	if (err_data) {
		err_data->data = gu_malloc(err_data->pool, strlen(msg+1));
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

SgSG*
sg_open(const char *filename,
        GuExn* err)
{
	int rc;
	
	sqlite3* db = NULL;
	rc = sqlite3_open(filename, &db);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return NULL;
	}

	rc = sqlite3_exec(db, "create table if not exists " SG_EXPRS "(fun not null, arg integer);"
	                      "create unique index if not exists " SG_IDENTS " on " SG_EXPRS "(fun) where arg is null;"
	                      "create index if not exists " SG_TOKENS " on " SG_EXPRS "(fun) where arg <> arg;"   // actually used for full text search
	                      "create unique index if not exists " SG_LITERALS " on " SG_EXPRS "(fun) where arg = 0;"
	                      "create unique index if not exists " SG_PAIRS " on " SG_EXPRS "(fun,arg) where arg > 0;"
	                      "create table if not exists " SG_TRIPLES "(subj integer, pred integer, obj integer, state integer);"
	                      "create unique index if not exists " SG_TRIPLES_SPO " on " SG_TRIPLES "(subj,pred,obj);"
	                      "create index if not exists " SG_TRIPLES_PO  " on " SG_TRIPLES "(pred,obj);"
	                      "create index if not exists " SG_TRIPLES_O   " on " SG_TRIPLES "(obj);",
	                  NULL, NULL, NULL);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return NULL;
	}

	return (SgSG*) db;
}

void
sg_close(SgSG* sg, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	int rc;
	rc = sqlite3_close((sqlite3*) db);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
	}
}

void
sg_shutdown()
{
	sqlite3_shutdown();
}

void
sg_begin_trans(SgSG* sg, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	int rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 1);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return;
	}
	db->autoCommit = 0;
}

void
sg_commit(SgSG* sg, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	int rc = sqlite3BtreeCommit(db->aDb[0].pBt);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return;
	}
	db->autoCommit = 1;
}

void
sg_rollback(SgSG* sg, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	int rc = sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return;
	}
	db->autoCommit = 1;
}

typedef struct {
	int n_cursors;
	BtCursor crsExprs;
	BtCursor crsIdents;
	BtCursor crsLiterals;
	BtCursor crsPairs;
	SgId key_seed;
} ExprContext;

static int
open_exprs(sqlite3 *db, int wrFlag, bool identsOnly,
           ExprContext* ctxt, GuExn* err)
{
	ctxt->n_cursors = 0;
	
	Table *exprsTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_EXPRS);
    if (!exprsTbl) {
		sg_raise_err("Table " SG_EXPRS " is missing", err);
		return SQLITE_ERROR;
	}

	Index *identsIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_IDENTS);
    if (!identsIdx) {
		sg_raise_err("Index " SG_IDENTS " is missing", err);
		return SQLITE_ERROR;
	}

	Index *literalsIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_LITERALS);
    if (!literalsIdx) {
		sg_raise_err("Index " SG_LITERALS " is missing", err);
		return SQLITE_ERROR;
	}

	Index *pairsIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_PAIRS);
    if (!pairsIdx) {
		sg_raise_err("Index " SG_PAIRS " is missing", err);
		return SQLITE_ERROR;
	}

	int rc;

	memset(&ctxt->crsExprs, 0, sizeof(ctxt->crsExprs));
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, exprsTbl->tnum, wrFlag, NULL, &ctxt->crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return rc;
	}
	ctxt->n_cursors++;

	memset(&ctxt->crsIdents, 0, sizeof(ctxt->crsIdents));
	KeyInfo *infIdents = sqlite3KeyInfoAlloc(db, 1, 1);
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, identsIdx->tnum, wrFlag, infIdents, &ctxt->crsIdents);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return rc;
	}
	ctxt->n_cursors++;

	if (!identsOnly) {
		memset(&ctxt->crsLiterals, 0, sizeof(ctxt->crsLiterals));
		KeyInfo *infLiterals = sqlite3KeyInfoAlloc(db, 1, 1);
		rc = sqlite3BtreeCursor(db->aDb[0].pBt, literalsIdx->tnum, wrFlag, infLiterals, &ctxt->crsLiterals);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return rc;
		}
		ctxt->n_cursors++;

		memset(&ctxt->crsPairs, 0, sizeof(ctxt->crsPairs));
		KeyInfo *infPairs = sqlite3KeyInfoAlloc(db, 2, 0);
		rc = sqlite3BtreeCursor(db->aDb[0].pBt, pairsIdx->tnum, wrFlag, infPairs, &ctxt->crsPairs);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return rc;
		}
		ctxt->n_cursors++;
	}

	if (wrFlag) {
		int res;
		rc = sqlite3BtreeLast(&ctxt->crsExprs, &res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return rc;
		}

		rc = sqlite3BtreeKeySize(&ctxt->crsExprs, &ctxt->key_seed);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
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
		sqlite3KeyInfoUnref(ctxt->crsPairs.pKeyInfo);
		sqlite3BtreeCloseCursor(&ctxt->crsPairs);
	}

	if (ctxt->n_cursors >= 3) {
		sqlite3KeyInfoUnref(ctxt->crsLiterals.pKeyInfo);
		sqlite3BtreeCloseCursor(&ctxt->crsLiterals);
	}

	if (ctxt->n_cursors >= 2) {
		sqlite3KeyInfoUnref(ctxt->crsIdents.pKeyInfo);
		sqlite3BtreeCloseCursor(&ctxt->crsIdents);
	}

	if (ctxt->n_cursors >= 1) {
		sqlite3BtreeCloseCursor(&ctxt->crsExprs);
	}
	
	ctxt->n_cursors = 0;
}

static int
find_function_rowid(sqlite3* db, ExprContext* ctxt,
                    GuString fun, SgId* pKey, int wrFlag)
{
	int rc = SQLITE_OK;
	int file_format = db->aDb[0].pSchema->file_format;

	Mem mem[2];
	mem[0].flags = MEM_Str;
	mem[0].n = strlen(fun);
	mem[0].z = (void*) fun;

	UnpackedRecord idxKey;
	idxKey.pKeyInfo = ctxt->crsIdents.pKeyInfo;
	idxKey.nField = 1;
	idxKey.default_rc = 0;
	idxKey.aMem = mem;

	int res = 0;
	rc = sqlite3BtreeMovetoUnpacked(&ctxt->crsIdents,
									&idxKey, 0,  0, &res);
	if (rc != SQLITE_OK) {
		return rc;
	}

	if (res == 0) {
		rc = sqlite3VdbeIdxRowid(db, &ctxt->crsIdents, pKey);
	} else {
		if (wrFlag == 0) {
			*pKey = 0;
			return SQLITE_OK;
		}

		*pKey = ++ctxt->key_seed;

		int serial_type_fun = sqlite3VdbeSerialType(&mem[0], file_format);
		int serial_type_fun_hdr_len = sqlite3VarintLen(serial_type_fun);

		mem[1].flags = MEM_Int;
		mem[1].u.i = *pKey;

		int serial_type_key = sqlite3VdbeSerialType(&mem[1], file_format);
		int serial_type_key_hdr_len = sqlite3VarintLen(serial_type_key);

		unsigned char* buf = malloc(1+serial_type_fun_hdr_len+MAX(1,serial_type_key_hdr_len)+mem[0].n+8);
		unsigned char* p = buf;
		*p++ = 1+serial_type_fun_hdr_len+1;
		p += putVarint32(p, serial_type_fun);
		*p++ = 0;
		memcpy(p, fun, mem[0].n);
		p += mem[0].n;

		rc = sqlite3BtreeInsert(&ctxt->crsExprs, 0, *pKey,
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
		p += sqlite3VdbeSerialPut(p, &mem[1], serial_type_key);
		rc = sqlite3BtreeInsert(&ctxt->crsIdents, buf, p-buf,
		                        0, *pKey, 0,
		                        0, 0);

free:
		free(buf);
	}

	return rc;
}

static int
store_expr(sqlite3* db,
           ExprContext* ctxt, PgfExpr expr, SgId* pKey, int wrFlag)
{
	int rc = SQLITE_OK;
	int file_format = db->aDb[0].pSchema->file_format;

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
		rc = store_expr(db, ctxt, app->fun, &mem[0].u.i, wrFlag);
		if (rc != SQLITE_OK)
			return rc;
		if (wrFlag == 0 && mem[0].u.i == 0) {
			*pKey = 0;
			return SQLITE_OK;
		}

		mem[1].flags = MEM_Int;
		rc = store_expr(db, ctxt, app->arg, &mem[1].u.i, wrFlag);
		if (rc != SQLITE_OK)
			return rc;
		if (wrFlag == 0 && mem[1].u.i == 0) {
			*pKey = 0;
			return SQLITE_OK;
		}

		UnpackedRecord idxKey;
		idxKey.pKeyInfo = ctxt->crsPairs.pKeyInfo;
		idxKey.nField = 2;
		idxKey.default_rc = 0;
		idxKey.aMem = mem;

		int res = 0;
		rc = sqlite3BtreeMovetoUnpacked(&ctxt->crsPairs,
		                                &idxKey, 0,  0, &res);
		if (rc != SQLITE_OK) {
			return rc;
		}

		if (res == 0) {
			rc = sqlite3VdbeIdxRowid(db, &ctxt->crsPairs, pKey);
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

			serial_type = sqlite3VdbeSerialType(&mem[0], file_format);
			buf[2] = serial_type;
			p += sqlite3VdbeSerialPut(p, &mem[0], serial_type);

			serial_type = sqlite3VdbeSerialType(&mem[1], file_format);
			buf[3] = serial_type;
			p += sqlite3VdbeSerialPut(p, &mem[1], serial_type);

			rc = sqlite3BtreeInsert(&ctxt->crsExprs, 0, *pKey,
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
			serial_type = sqlite3VdbeSerialType(&mem[2], file_format);
			buf[3] = serial_type;
			p += sqlite3VdbeSerialPut(p, &mem[2], serial_type);

			rc = sqlite3BtreeInsert(&ctxt->crsPairs, buf, p-buf,
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
		idxKey.pKeyInfo = ctxt->crsIdents.pKeyInfo;
		idxKey.nField = 1;
		idxKey.default_rc = 0;
		idxKey.aMem = mem;

		int res = 0;
		rc = sqlite3BtreeMovetoUnpacked(&ctxt->crsLiterals,
		                                &idxKey, 0,  0, &res);
		if (rc != SQLITE_OK) {
			return rc;
		}

		if (res == 0) {
			rc = sqlite3VdbeIdxRowid(db, &ctxt->crsLiterals, pKey);
		} else {
			if (wrFlag == 0) {
				*pKey = 0;
				return SQLITE_OK;
			}

			*pKey = ++ctxt->key_seed;

			mem[1].flags = MEM_Int;
			mem[1].u.i = 0;

			int serial_type_lit = sqlite3VdbeSerialType(&mem[0], file_format);
			int serial_type_lit_hdr_len = sqlite3VarintLen(serial_type_lit);
			int serial_type_arg = sqlite3VdbeSerialType(&mem[1], file_format);
			int serial_type_arg_hdr_len = sqlite3VarintLen(serial_type_arg);

			unsigned char* buf = malloc(1+serial_type_lit_hdr_len+MAX(1,serial_type_arg_hdr_len)+mem[0].n+8);
			unsigned char* p = buf;
			*p++ = 1+serial_type_lit_hdr_len+serial_type_arg_hdr_len;
			p += putVarint32(p, serial_type_lit);
			p += putVarint32(p, serial_type_arg);
			p += sqlite3VdbeSerialPut(p, &mem[0], serial_type_lit);
			p += sqlite3VdbeSerialPut(p, &mem[1], serial_type_arg);

			rc = sqlite3BtreeInsert(&ctxt->crsExprs, 0, *pKey,
			                        buf, p-buf, 0,
			                        0, 0);
			if (rc == SQLITE_OK) {
				mem[1].flags = MEM_Int;
				mem[1].u.i = *pKey;

				int serial_type_key = sqlite3VdbeSerialType(&mem[1], file_format);
				int serial_type_key_hdr_len = sqlite3VarintLen(serial_type_key);

				p = buf;
				*p++ = 1+serial_type_lit_hdr_len+serial_type_key_hdr_len;
				p += putVarint32(p, serial_type_lit);
				p += putVarint32(p, serial_type_key);
				p += sqlite3VdbeSerialPut(p, &mem[0], serial_type_lit);
				p += sqlite3VdbeSerialPut(p, &mem[1], serial_type_key);
				rc = sqlite3BtreeInsert(&ctxt->crsLiterals, buf, p-buf,
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
		rc = find_function_rowid(db, ctxt, fun->fun, pKey, wrFlag);
        break;
	}
	case PGF_EXPR_VAR: {
		gu_impossible();
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* etyped = ei.data;
		rc = store_expr(db, ctxt, etyped->expr, pKey, wrFlag);
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* eimpl = ei.data;
		rc = store_expr(db, ctxt, eimpl->expr, pKey, wrFlag);
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
	sqlite3 *db = (sqlite3 *) sg;

	int rc;

	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, wrFlag);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return 0;
		}
	}

	ExprContext ctxt;
	rc = open_exprs(db, wrFlag, false, &ctxt, err);
	if (rc != SQLITE_OK)
		goto close;

	SgId key;
	rc = store_expr(db, &ctxt, expr, &key, wrFlag);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	close_exprs(&ctxt);

	if (db->autoCommit) {
		rc = sqlite3BtreeCommit(db->aDb[0].pBt);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return 0;
		}
	}

    return key;

close:
	close_exprs(&ctxt);

	if (db->autoCommit) {
		sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
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
	row += sqlite3VdbeSerialGet(row, serial_type_fun, &mem[0]);
	row += sqlite3VdbeSerialGet(row, serial_type_arg, &mem[1]);

	if (mem[1].flags & MEM_Null) {
		u32 len = sqlite3VdbeSerialTypeLen(serial_type_fun);

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
			u32 len = sqlite3VdbeSerialTypeLen(serial_type_fun);

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
	sqlite3 *db = (sqlite3 *) sg;

	Table *exprsTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_EXPRS);
    if (!exprsTbl) {
		sg_raise_err("Table " SG_EXPRS " is missing", err);
		return gu_null_variant;
	}

	int rc;
	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return gu_null_variant;
		}
	}

	BtCursor crsExprs;
	memset(&crsExprs, 0, sizeof(crsExprs));
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, exprsTbl->tnum, 0, NULL, &crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto rollback;
	}

	PgfExpr expr = gu_null_variant;
	rc = load_expr(&crsExprs, key, &expr, out_pool);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	rc = sqlite3BtreeCloseCursor(&crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto rollback;
	}

	if (db->autoCommit) {
		rc = sqlite3BtreeCommit(db->aDb[0].pBt);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto rollback;
		}
	}

    return expr;

close:
	sqlite3BtreeCloseCursor(&crsExprs);

rollback:
	if (db->autoCommit) {
		sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
	}
	return gu_null_variant;
}

static int
insert_token(sqlite3 *db, BtCursor* crsTokens, GuString tok, SgId key)
{
	int rc = SQLITE_OK;
	int file_format = db->aDb[0].pSchema->file_format;

	Mem mem[2];
	mem[0].flags = MEM_Str;
	mem[0].n = strlen(tok);
	mem[0].z = (void*) tok;

	int serial_type_tok = sqlite3VdbeSerialType(&mem[0], file_format);
	int serial_type_tok_hdr_len = sqlite3VarintLen(serial_type_tok);

	mem[1].flags = MEM_Int;
	mem[1].u.i = key;

	int serial_type_key = sqlite3VdbeSerialType(&mem[1], file_format);
	int serial_type_key_hdr_len = sqlite3VarintLen(serial_type_key);

	unsigned char* buf = malloc(1+serial_type_tok_hdr_len+serial_type_key_hdr_len+mem[0].n+8);
	unsigned char* p = buf;
	*p++ = 1+serial_type_tok_hdr_len+serial_type_key_hdr_len;
	p += putVarint32(p, serial_type_tok);
	p += putVarint32(p, serial_type_key);
	memcpy(p, tok, mem[0].n);
	p += mem[0].n;
	p += sqlite3VdbeSerialPut(p, &mem[1], serial_type_key);
	rc = sqlite3BtreeInsert(crsTokens, buf, p-buf,
	                        0, key, 0,
	                        0, 0);
	free(buf);

	return rc;
}

static int
insert_syms(sqlite3 *db, BtCursor* crsTokens, PgfSymbols* syms, SgId key)
{
	int rc;
	size_t n_syms = gu_seq_length(syms);
	for (size_t sym_idx = 0; sym_idx < n_syms; sym_idx++) {
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, sym_idx);
		GuVariantInfo sym_i = gu_variant_open(sym);
		switch (sym_i.tag) {
		case PGF_SYMBOL_KS: {
			PgfSymbolKS* ks = sym_i.data;
			rc = insert_token(db, crsTokens, ks->token, key);
			if (rc != SQLITE_OK)
				return rc;
			break;
		}
		case PGF_SYMBOL_KP: {
			PgfSymbolKP* kp = sym_i.data;
			rc = insert_syms(db, crsTokens, kp->default_form, key);
			if (rc != SQLITE_OK)
				return rc;
				
			for (size_t i = 0; i < kp->n_forms; i++) {
				rc = insert_syms(db, crsTokens, kp->forms[i].form, key);
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
	sqlite3 *db = (sqlite3 *) sg;

	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 1);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return;
		}
	}

	ExprContext ctxt;
	rc = open_exprs(db, 1, true, &ctxt, err);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	Index *tokensIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_TOKENS);
    if (!tokensIdx) {
		sg_raise_err("Index " SG_TOKENS " is missing", err);
		return;
	}
	
	rc = sqlite3BtreeClearTable(db->aDb[0].pBt, tokensIdx->tnum, NULL);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return;
	}

	BtCursor crsTokens;
	memset(&crsTokens, 0, sizeof(crsTokens));
	KeyInfo *infTokens = sqlite3KeyInfoAlloc(db, 1, 1);
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, tokensIdx->tnum, 1, infTokens, &crsTokens);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
	}
	ctxt.n_cursors++;

	size_t n_concrs = gu_seq_length(pgf->concretes);
	for (size_t i = 0; i < n_concrs; i++) {
		PgfConcr* concr = gu_seq_index(pgf->concretes, PgfConcr, i);
		
		size_t n_funs = gu_seq_length(concr->cncfuns);
		for (size_t funid = 0; funid < n_funs; funid++) {
			PgfCncFun* cncfun = gu_seq_get(concr->cncfuns, PgfCncFun*, funid);

			SgId key = 0;
			rc = find_function_rowid(db, &ctxt, cncfun->absfun->name, &key, 1);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(db, err);
				goto close;
			}

			for (size_t lin_idx = 0; lin_idx < cncfun->n_lins; lin_idx++) {
				PgfSequence* seq = cncfun->lins[lin_idx];
				rc = insert_syms(db, &crsTokens, seq->syms, key);
				if (rc != SQLITE_OK) {
					sg_raise_sqlite(db, err);
					goto close;
				}
			}
		}
	}

	if (ctxt.n_cursors >= 3) {
		sqlite3KeyInfoUnref(crsTokens.pKeyInfo);
		sqlite3BtreeCloseCursor(&crsTokens);
		ctxt.n_cursors--;
	}

	close_exprs(&ctxt);
	
	if (db->autoCommit) {
		rc = sqlite3BtreeCommit(db->aDb[0].pBt);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
		}
	}

    return;

close:
	if (ctxt.n_cursors >= 3) {
		sqlite3KeyInfoUnref(crsTokens.pKeyInfo);
		sqlite3BtreeCloseCursor(&crsTokens);
		ctxt.n_cursors--;
	}

	close_exprs(&ctxt);

	if (db->autoCommit) {
		sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
	}
}

GuSeq*
sg_query_linearization(SgSG *sg, GuString tok, GuPool *pool, GuExn* err)
{
	int rc;
	sqlite3 *db = (sqlite3 *) sg;

	Index *tokensIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_TOKENS);
    if (!tokensIdx) {
		sg_raise_err("Index " SG_TOKENS " is missing", err);
		return NULL;
	}

	BtCursor crsTokens;
	memset(&crsTokens, 0, sizeof(crsTokens));
	KeyInfo *infTokens = sqlite3KeyInfoAlloc(db, 1, 1);
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, tokensIdx->tnum, 1, infTokens, &crsTokens);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return NULL;
	}

	Mem mem[1];
	mem[0].flags = MEM_Str;
	mem[0].n = strlen(tok);
	mem[0].z = (void*) tok;

	UnpackedRecord idxKey;
	idxKey.pKeyInfo = crsTokens.pKeyInfo;
	idxKey.nField = 1;
	idxKey.default_rc = 0;
	idxKey.aMem = mem;

	int res = 0;
	rc = sqlite3BtreeMovetoUnpacked(&crsTokens,
									&idxKey, 0,  0, &res);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return NULL;
	}
	
	GuBuf* ids = gu_new_buf(SgId, pool);

	while (res == 0) {
		SgId key;
		rc = sqlite3VdbeIdxRowid(db, &crsTokens, &key);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return NULL;
		}

		gu_buf_push(ids, SgId, key);

		sqlite3BtreeNext(&crsTokens, &res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return NULL;
		}

		i64 szData;
		const unsigned char *zData;
		rc = sqlite3BtreeKeySize(&crsTokens, &szData);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return NULL;
		}

		u32 available = 0;
		zData = sqlite3BtreeKeyFetch(&crsTokens, &available);
		if (szData > available)
			gu_impossible();

		res = sqlite3VdbeRecordCompare(available, zData, &idxKey);
		if (res != 0)
			break;
	}

	return gu_buf_data_seq(ids);
}

typedef struct {
	int n_cursors;
	BtCursor cursor[4];
} TripleContext;

static int
open_triples(sqlite3 *db, int wrFlag, TripleContext* ctxt, GuExn* err)
{
	Index *idx[3];
	idx[0] = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_TRIPLES_SPO);
    if (!idx[0]) {
		sg_raise_err("Index " SG_TRIPLES_SPO " is missing", err);
		return SQLITE_ERROR;
	}

	idx[1] = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_TRIPLES_PO);
    if (!idx[1]) {
		sg_raise_err("Index " SG_TRIPLES_PO " is missing", err);
		return SQLITE_ERROR;
	}

	idx[2] = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_TRIPLES_O);
    if (!idx[2]) {
		sg_raise_err("Index " SG_TRIPLES_O " is missing", err);
		return SQLITE_ERROR;
	}

	Table *triplesTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_TRIPLES);
    if (!triplesTbl) {
		sg_raise_err("Table " SG_TRIPLES " is missing", err);
		return SQLITE_ERROR;
	}

	int rc;

	memset(ctxt->cursor, 0, sizeof(ctxt->cursor));

	ctxt->n_cursors = 0;
	while (ctxt->n_cursors < 3) {
		KeyInfo *inf = sqlite3KeyInfoAlloc(db, 3-ctxt->n_cursors, ctxt->n_cursors);
		rc = sqlite3BtreeCursor(db->aDb[0].pBt, idx[ctxt->n_cursors]->tnum, wrFlag, inf, &ctxt->cursor[ctxt->n_cursors]);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return rc;
		}
		ctxt->n_cursors++;
	}

	rc = sqlite3BtreeCursor(db->aDb[0].pBt, triplesTbl->tnum, wrFlag, NULL, &ctxt->cursor[ctxt->n_cursors]);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
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
		if (ctxt->cursor[ctxt->n_cursors].pKeyInfo != NULL) {
			sqlite3KeyInfoUnref(ctxt->cursor[ctxt->n_cursors].pKeyInfo);
		}
		sqlite3BtreeCloseCursor(&ctxt->cursor[ctxt->n_cursors]);
	}
}

SgId
sg_insert_triple(SgSG *sg, SgTriple triple, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	int rc;

	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 1);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return 0;
		}
	}

	TripleContext tctxt;
	rc = open_triples(db, 1, &tctxt, err);
	if (rc != SQLITE_OK)
		goto close;

	Mem mem[4];

	ExprContext ectxt;
	rc = open_exprs(db, 1, false, &ectxt, err);
	if (rc != SQLITE_OK)
		goto close;

	for (size_t i = 0; i < 3; i++) {
		mem[i].flags = MEM_Int;

		rc = store_expr(db, &ectxt, triple[i], &mem[i].u.i, 1);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}
	}

	UnpackedRecord idxKey;
	idxKey.pKeyInfo = tctxt.cursor[0].pKeyInfo;
	idxKey.nField = 3;
	idxKey.default_rc = 0;
	idxKey.aMem = mem;

	int res = 0;
	rc = sqlite3BtreeMovetoUnpacked(&tctxt.cursor[0],
	                                &idxKey, 0,  0, &res);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	SgId key = 0;

	if (res == 0) {
		rc = sqlite3VdbeIdxRowid(db, &tctxt.cursor[0], &key);
	} else {
		rc = sqlite3BtreeLast(&tctxt.cursor[3], &res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}

		rc = sqlite3BtreeKeySize(&tctxt.cursor[3], &key);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}
		key++;

		u32 serial_type;
		unsigned char buf[41];  // enough for a record with three integers
		int file_format = db->aDb[0].pSchema->file_format;

		unsigned char* p = buf+(buf[0] = 5);

		serial_type = sqlite3VdbeSerialType(&mem[0], file_format);
		buf[1] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[0], serial_type);

		serial_type = sqlite3VdbeSerialType(&mem[1], file_format);
		buf[2] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[1], serial_type);

		serial_type = sqlite3VdbeSerialType(&mem[2], file_format);
		buf[3] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[2], serial_type);

		unsigned char* tmp = p;

		mem[3].flags = MEM_Int;
		mem[3].u.i = 1;
		serial_type = sqlite3VdbeSerialType(&mem[3], file_format);
		buf[4] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[3], serial_type);

		rc = sqlite3BtreeInsert(&tctxt.cursor[3], 0, key,
								buf, p-buf, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}

		mem[3].flags = MEM_Int;
		mem[3].u.i = key;

		p = tmp;
		serial_type = sqlite3VdbeSerialType(&mem[3], file_format);
		buf[4] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[3], serial_type);

		rc = sqlite3BtreeInsert(&tctxt.cursor[0], buf, p-buf,
								0, key, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}

		p = buf+(buf[0] = 4);

		serial_type = sqlite3VdbeSerialType(&mem[1], file_format);
		buf[1] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[1], serial_type);

		serial_type = sqlite3VdbeSerialType(&mem[2], file_format);
		buf[2] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[2], serial_type);

		serial_type = sqlite3VdbeSerialType(&mem[3], file_format);
		buf[3] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[3], serial_type);

		rc = sqlite3BtreeInsert(&tctxt.cursor[1], buf, p-buf,
								0, key, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}

		p = buf+(buf[0] = 3);

		serial_type = sqlite3VdbeSerialType(&mem[2], file_format);
		buf[1] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[2], serial_type);

		serial_type = sqlite3VdbeSerialType(&mem[3], file_format);
		buf[2] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[3], serial_type);

		rc = sqlite3BtreeInsert(&tctxt.cursor[2], buf, p-buf,
								0, key, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}
	}

close:
	close_exprs(&ectxt);
	close_triples(&tctxt);

	if (db->autoCommit) {
		if (rc == SQLITE_OK || rc == SQLITE_DONE) {
			rc = sqlite3BtreeCommit(db->aDb[0].pBt);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(db, err);
				return 0;
			}
		} else {
			sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
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
	row += sqlite3VdbeSerialGet(row, serial_type_subj, &mem[0]);
	row += sqlite3VdbeSerialGet(row, serial_type_pred, &mem[1]);
	row += sqlite3VdbeSerialGet(row, serial_type_obj,  &mem[2]);

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
	sqlite3 *db = (sqlite3 *) sg;

	triple[0] = gu_null_variant;
	triple[1] = gu_null_variant;
	triple[2] = gu_null_variant;

	Table *triplesTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_TRIPLES);
      if (!triplesTbl) {
		sg_raise_err("Table " SG_TRIPLES " is missing", err);
		return false;
	}

	Table *exprsTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_EXPRS);
    if (!exprsTbl) {
		sg_raise_err("Table " SG_EXPRS " is missing", err);
		return false;
	}

	int rc;
	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return false;
		}
	}

	BtCursor crsTriples;
	memset(&crsTriples, 0, sizeof(crsTriples));
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, triplesTbl->tnum, 0, NULL, &crsTriples);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto rollback;
	}

	BtCursor crsExprs;
	memset(&crsExprs, 0, sizeof(crsExprs));
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, exprsTbl->tnum, 0, NULL, &crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close1;
	}

	int res;
	rc = sqlite3BtreeMovetoUnpacked(&crsTriples, 0, key, 0, &res);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	if (res == 0) {
		rc = load_triple(&crsTriples, &crsExprs, triple, out_pool);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}
	}

	rc = sqlite3BtreeCloseCursor(&crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close1;
	}

	rc = sqlite3BtreeCloseCursor(&crsTriples);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto rollback;
	}

	if (db->autoCommit) {
		rc = sqlite3BtreeCommit(db->aDb[0].pBt);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return false;
		}
	}

	return (res == 0);

close:
	sqlite3BtreeCloseCursor(&crsExprs);

close1:
	sqlite3BtreeCloseCursor(&crsTriples);

rollback:
	if (db->autoCommit) {
		sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
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
	sqlite3 *db;
	SgTriple triple;
	ExprContext ectxt;
	
	SgTripleResultInt i;
};

static int
init_triple_result_int(sqlite3 *db, SgTripleResultInt* tresi, GuExn* err)
{
	int rc;

	rc = open_triples(db, 0, &tresi->tctxt, err);
	if (rc != SQLITE_OK)
		return rc;

	int i = 0;
	while (i < 3) {
		if (tresi->mem[i].flags != MEM_Null)
			break;
		i++;
	}

	tresi->cursor = &tresi->tctxt.cursor[i];
	tresi->idxKey.pKeyInfo = tresi->cursor->pKeyInfo;
	tresi->idxKey.nField = 0;
	tresi->idxKey.aMem = &tresi->mem[i];
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
		sg_raise_sqlite(db, err);
	}

	return rc;
}

SgTripleResult*
sg_query_triple(SgSG *sg, SgTriple triple, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	int rc;

	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return NULL;
		}
	}

	SgTripleResult* tres = malloc(sizeof(SgTripleResult));
	tres->db = db;
	tres->triple[0] = triple[0];
	tres->triple[1] = triple[1];
	tres->triple[2] = triple[2];

	rc = open_exprs(db, 0, false, &tres->ectxt, err);
	if (rc != SQLITE_OK)
		goto close;

	for (int i = 0; i < 3; i++) {
		if (gu_variant_is_null(triple[i]))
			tres->i.mem[i].flags = MEM_Null;
		else {
			tres->i.mem[i].flags = MEM_Int;
			rc = store_expr(db, &tres->ectxt, triple[i], &tres->i.mem[i].u.i, 0);
			if (rc != SQLITE_OK)
				goto close;
			if (tres->i.mem[i].u.i == 0) {
				tres->i.res = 1;
				return tres;
			}
		}
	}

	rc = init_triple_result_int(db, &tres->i, err);
	if (rc != SQLITE_OK) {
		return NULL;
	}

	return tres;

close:
	close_exprs(&tres->ectxt);
	close_triples(&tres->i.tctxt);

	if (db->autoCommit) {
		sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
	}

	free(tres);
	return NULL;
}

static bool
triple_result_fetch_int(sqlite3* db, SgTripleResultInt* tresi,
                        SgId* pKey, GuExn* err)
{
	while (tresi->res == 0) {
		int rc;

		if (tresi->idxKey.nField > 0) {
			i64 szData;
			const unsigned char *zData;
			rc = sqlite3BtreeKeySize(tresi->cursor, &szData);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(db, err);
				return false;
			}

			u32 available = 0;
			zData = sqlite3BtreeKeyFetch(tresi->cursor, &available);
			if (szData > available)
				gu_impossible();

			tresi->idxKey.default_rc = 0;
			tresi->res = sqlite3VdbeRecordCompare(available, zData, &tresi->idxKey);
			if (tresi->res != 0)
				return false;

			if (tresi->idxKey.aMem == &tresi->mem[0] &&
			    tresi->idxKey.nField == 1 &&
			    tresi->mem[2].flags != MEM_Null) {
				int offset = 
					zData[0] + 
					sqlite3VdbeSerialTypeLen(zData[1]) + 
					sqlite3VdbeSerialTypeLen(zData[2]);
				zData+offset;
				Mem mem;
				sqlite3VdbeSerialGet(zData+offset, zData[3], &mem);
				if (mem.u.i != tresi->mem[2].u.i) {
					sqlite3BtreeNext(tresi->cursor, &tresi->res);
					if (rc != SQLITE_OK) {
						sg_raise_sqlite(db, err);
						return false;
					}
					continue;
				}
			}
		}

		if (tresi->idxKey.nField > 0) {
			rc = sqlite3VdbeIdxRowid(db, tresi->cursor, pKey);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(db, err);
				return false;
			}

			rc = sqlite3BtreeMovetoUnpacked(&tresi->tctxt.cursor[3], 0, *pKey, 0, &tresi->res);
		} else {
			rc = sqlite3BtreeKeySize(tresi->cursor, pKey);
		}
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return false;
		}
		
		sqlite3BtreeNext(tresi->cursor, &tresi->res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
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
				sg_raise_sqlite(tres->db, err);
				return false;
			}

			u32 available = 0;
			zData = sqlite3BtreeKeyFetch(tres->i.cursor, &available);
			if (szData > available)
				gu_impossible();

			tres->i.idxKey.default_rc = 0;
			tres->i.res = sqlite3VdbeRecordCompare(available, zData, &tres->i.idxKey);
			if (tres->i.res != 0)
				return false;

			if (tres->i.idxKey.aMem == &tres->i.mem[0] &&
			    tres->i.idxKey.nField == 1 &&
			    tres->i.mem[2].flags != MEM_Null) {
				int offset = 
					zData[0] + 
					sqlite3VdbeSerialTypeLen(zData[1]) + 
					sqlite3VdbeSerialTypeLen(zData[2]);
				zData+offset;
				Mem mem;
				sqlite3VdbeSerialGet(zData+offset, zData[3], &mem);
				if (mem.u.i != tres->i.mem[2].u.i) {
					sqlite3BtreeNext(tres->i.cursor, &tres->i.res);
					if (rc != SQLITE_OK) {
						sg_raise_sqlite(tres->db, err);
						return false;
					}
					continue;
				}
			}
		}

		if (tres->i.idxKey.nField > 0) {
			rc = sqlite3VdbeIdxRowid(tres->db, tres->i.cursor, pKey);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(tres->db, err);
				return false;
			}

			rc = sqlite3BtreeMovetoUnpacked(&tres->i.tctxt.cursor[3], 0, *pKey, 0, &tres->i.res);
		} else {
			rc = sqlite3BtreeKeySize(tres->i.cursor, pKey);
		}
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(tres->db, err);
			return false;
		}

		rc = load_triple(&tres->i.tctxt.cursor[3], &tres->ectxt.crsExprs,
		                 triple, out_pool);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(tres->db, err);
			return false;
		}
		
		sqlite3BtreeNext(tres->i.cursor, &tres->i.res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(tres->db, err);
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

	if (tres->db->autoCommit) {
		int rc = sqlite3BtreeCommit(tres->db->aDb[0].pBt);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(tres->db, err);
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
	sqlite3* db;
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
	sqlite3 *db = (sqlite3 *) sg;

	int rc;

	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return NULL;
		}
	}

	ExprContext ectxt;
	rc = open_exprs(db, 0, false, &ectxt, err);
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
					rc = store_expr(db, &ectxt, expr, &query->vars[j].id, 0);
					if (rc != SQLITE_OK) {
						sg_raise_sqlite(db, err);
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
	
	if (db->autoCommit) {
		rc = sqlite3BtreeCommit(db->aDb[0].pBt);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return 0;
		}
	}

	return query;

close:
	close_exprs(&ectxt);
	
	if (db->autoCommit) {
		sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
	}

	return NULL;
}

SgQueryResult*
sg_query(SgSG *sg, SgQuery* query, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	int rc;

	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return NULL;
		}
	}

	SgQueryResult* qres = 
		malloc(sizeof(SgQueryResult)+
		       sizeof(SgTripleResultInt)*query->n_patterns);
	qres->db = db;
	qres->is_empty = false;
	qres->query = query;
	qres->n_results = 0;

	rc = open_exprs(db, 0, false, &qres->ectxt, err);
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

		rc = init_triple_result_int(qres->db, &qres->results[i], err);
		if (rc != SQLITE_OK)
			goto close;

		SgTriple triple;

		SgId key;
		for (;;) {
			bool found = 
				triple_result_fetch_int(qres->db, &qres->results[i],
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
			rc = load_expr(&qres->ectxt.crsExprs,
			               qres->query->vars[qres->query->sel[i]].id,
			               &res[i], out_pool);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(qres->db, err);
				goto close;
			}

			qres->query->vars[qres->query->sel[i]].expr = res[i];
		}
	}

	return true;
	
close:
	return false;
}
