#include "sqlite3.c"
#include "pgf/pgf.h"
#include "gu/file.h"

#define SG_EXPRS   "sg_exprs"
#define SG_PAIRS   "sg_pairs"
#define SG_IDENTS  "sg_idents"
#define SG_TRIPLES "sg_triples"
#define SG_TRIPLES_SPO "sg_triples_spo"

typedef struct {
	sqlite3 *db;
	BtCursor* crsExprs;
	BtCursor* crsPairs;
	BtCursor* crsIdents;
	i64 key_seed;
	int file_format;
} StoreContext;

int
sg_create_tables(sqlite3 *db)
{
	return sqlite3_exec(db, "create table if not exists " SG_EXPRS "(fun not null, arg integer);"
	                        "create unique index if not exists " SG_IDENTS " on " SG_EXPRS "(fun) where arg is null;"
	                        "create unique index if not exists " SG_PAIRS " on " SG_EXPRS "(fun,arg) where arg is not null;"
	                        "create table if not exists " SG_TRIPLES "(subj integer, pred integer, obj integer);"
	                        "create unique index if not exists " SG_TRIPLES_SPO " on " SG_TRIPLES "(subj,pred,obj);",
	                    NULL, NULL, NULL);
}

static int
store_expr(StoreContext* ctxt, PgfExpr expr, i64* pKey)
{
	int rc = SQLITE_OK;

	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS: {
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;

		Mem mem[3];

		mem[0].flags = MEM_Int;
		rc = store_expr(ctxt, app->fun, &mem[0].u.i);
		if (rc != SQLITE_OK)
			return rc;

		mem[1].flags = MEM_Int;
		rc = store_expr(ctxt, app->arg, &mem[1].u.i);
		if (rc != SQLITE_OK)
			return rc;

		UnpackedRecord idxKey;
		idxKey.pKeyInfo = ctxt->crsPairs->pKeyInfo;
		idxKey.nField = 2;
		idxKey.default_rc = 0;
		idxKey.aMem = mem;
		
		int res = 0;
		rc = sqlite3BtreeMovetoUnpacked(ctxt->crsPairs,
		                                &idxKey, 0,  0, &res);
		if (rc != SQLITE_OK) {
			return rc;
		}

		if (res == 0) {
			rc = sqlite3VdbeIdxRowid(ctxt->db, ctxt->crsPairs, pKey);
		} else {
			*pKey = ++ctxt->key_seed;

			unsigned char buf[32];  // enough for record with three integers
			buf[1] = 3;

			u32 serial_type;
			unsigned char* p = buf+4;

			serial_type = sqlite3VdbeSerialType(&mem[0], ctxt->file_format);
			buf[2] = serial_type;
			p += sqlite3VdbeSerialPut(p, &mem[0], serial_type);

			serial_type = sqlite3VdbeSerialType(&mem[1], ctxt->file_format);
			buf[3] = serial_type;
			p += sqlite3VdbeSerialPut(p, &mem[1], serial_type);

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
			serial_type = sqlite3VdbeSerialType(&mem[2], ctxt->file_format);
			buf[3] = serial_type;
			p += sqlite3VdbeSerialPut(p, &mem[2], serial_type);

			rc = sqlite3BtreeInsert(ctxt->crsPairs, buf, p-buf,
			                        0, *pKey, 0,
			                        0, 0);
        }
		break;
	}
	case PGF_EXPR_LIT: {
		break;
	}
	case PGF_EXPR_META: {
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;

		Mem mem[2];
		mem[0].flags = MEM_Str;
		mem[0].n = strlen(fun->fun);
		mem[0].z = fun->fun;

		UnpackedRecord idxKey;
		idxKey.pKeyInfo = ctxt->crsIdents->pKeyInfo;
		idxKey.nField = 1;
		idxKey.default_rc = 0;
		idxKey.aMem = mem;

		int res = 0;
		rc = sqlite3BtreeMovetoUnpacked(ctxt->crsIdents,
		                                &idxKey, 0,  0, &res);
		if (rc != SQLITE_OK) {
			return rc;
		}

		if (res == 0) {
			rc = sqlite3VdbeIdxRowid(ctxt->db, ctxt->crsIdents, pKey);
		} else {
			*pKey = ++ctxt->key_seed;

			int serial_type_fun = sqlite3VdbeSerialType(&mem[0], ctxt->file_format);
			int serial_type_fun_hdr_len = sqlite3VarintLen(serial_type_fun);

			mem[1].flags = MEM_Int;
			mem[1].u.i = *pKey;

			int serial_type_key = sqlite3VdbeSerialType(&mem[1], ctxt->file_format);
			int serial_type_key_hdr_len = sqlite3VarintLen(serial_type_key);

			unsigned char* buf = malloc(1+serial_type_fun_hdr_len+MAX(1,serial_type_key_hdr_len)+mem[0].n);
			unsigned char* p = buf;
			*p++ = 1+serial_type_fun_hdr_len+1;
			p += putVarint32(p, serial_type_fun);
			*p++ = 0;
			memcpy(p, fun->fun, mem[0].n);
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
			memcpy(p, fun->fun, mem[0].n);
			p += mem[0].n;
			p += sqlite3VdbeSerialPut(p, &mem[1], serial_type_key);
			rc = sqlite3BtreeInsert(ctxt->crsIdents, buf, p-buf,
			                        0, *pKey, 0,
			                        0, 0);

free:
			free(buf);
		}
        break;
	}
	case PGF_EXPR_VAR: {
		break;
	}
	case PGF_EXPR_TYPED: {
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		break;
	}
	default:
		gu_impossible();
	}

	return rc;
}

int
sg_insert_expr(sqlite3 *db, PgfExpr expr, i64* pKey)
{
	Table *exprsTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_EXPRS);
    if (!exprsTbl) return SQLITE_ERROR;
    
	Index *pairsIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_PAIRS);
    if (!pairsIdx) return SQLITE_ERROR;

	Index *identsIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_IDENTS);
    if (!identsIdx) return SQLITE_ERROR;

	int rc;
	rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 1);
	if (rc != SQLITE_OK) {
		return rc;
	}

	BtCursor crsExprs;
	memset(&crsExprs, 0, sizeof(crsExprs));
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, exprsTbl->tnum, 1, NULL, &crsExprs);
	if (rc != SQLITE_OK) {
		goto rollback;
	}

	BtCursor crsPairs;
	memset(&crsPairs, 0, sizeof(crsPairs));
	KeyInfo *infPairs = sqlite3KeyInfoAlloc(db, 2, 0);
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, pairsIdx->tnum, 1, infPairs, &crsPairs);
	if (rc != SQLITE_OK) {
		goto close1;
	}

	BtCursor crsIdents;
	memset(&crsIdents, 0, sizeof(crsIdents));
	KeyInfo *infIdents = sqlite3KeyInfoAlloc(db, 1, 1);
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, identsIdx->tnum, 1, infIdents, &crsIdents);
	if (rc != SQLITE_OK) {
		goto close2;
	}

	int res;
	rc = sqlite3BtreeLast(&crsExprs, &res);
	if (rc != SQLITE_OK) {
		goto close;
	}

	i64 key = 0;
	rc = sqlite3BtreeKeySize(&crsExprs, &key);
	if (rc != SQLITE_OK) {
		goto close;
	}

	StoreContext ctxt;
	ctxt.db       = db;
	ctxt.crsExprs = &crsExprs;
	ctxt.crsPairs = &crsPairs;
	ctxt.crsIdents = &crsIdents;
	ctxt.key_seed = key;
	ctxt.file_format = db->aDb[0].pSchema->file_format;
	rc = store_expr(&ctxt, expr, pKey);
	if (rc != SQLITE_OK) {
		goto close;
	}

	sqlite3KeyInfoUnref(infIdents);
	rc = sqlite3BtreeCloseCursor(&crsIdents);
	if (rc != SQLITE_OK) {
		goto close2;
	}

	sqlite3KeyInfoUnref(infPairs);
	rc = sqlite3BtreeCloseCursor(&crsPairs);
	if (rc != SQLITE_OK) {
		goto close1;
	}

	rc = sqlite3BtreeCloseCursor(&crsExprs);
	if (rc != SQLITE_OK) {
		goto rollback;
	}

    rc = sqlite3BtreeCommit(db->aDb[0].pBt);
    return rc;

close:
	sqlite3KeyInfoUnref(infIdents);
	sqlite3BtreeCloseCursor(&crsIdents);

close2:
	sqlite3KeyInfoUnref(infPairs);
	sqlite3BtreeCloseCursor(&crsPairs);

close1:
	sqlite3BtreeCloseCursor(&crsExprs);

rollback:
	sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
	return rc;
}

static int
load_expr(BtCursor* crsExprs, i64 key, PgfExpr *pExpr, GuPool* out_pool)
{
	int res;
	int rc = sqlite3BtreeMovetoUnpacked(crsExprs, 0, key, 0, &res);
	if (rc != SQLITE_OK)
		return rc;

	if (res != 0) {
		*pExpr = gu_null_variant;
		return SQLITE_OK;
	}

	int payloadSize;
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
	
	if (serial_type_arg == 0) {
		u32 len = sqlite3VdbeSerialTypeLen(serial_type_fun);

		PgfExprFun *efun =
			gu_new_flex_variant(PGF_EXPR_FUN,
			                    PgfExprFun,
			                    fun, len+1,
			                    pExpr, out_pool);
		memcpy(efun->fun, mem[0].z, len);
		efun->fun[len] = 0;
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

int
sg_select_expr(sqlite3 *db, i64 key, PgfExpr* pExpr, GuPool* out_pool)
{
	Table *exprsTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_EXPRS);
    if (!exprsTbl) return SQLITE_ERROR;

	int rc;
	rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 0);
	if (rc != SQLITE_OK) {
		return rc;
	}

	BtCursor crsExprs;
	memset(&crsExprs, 0, sizeof(crsExprs));
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, exprsTbl->tnum, 1, NULL, &crsExprs);
	if (rc != SQLITE_OK) {
		goto rollback;
	}

	rc = load_expr(&crsExprs, key, pExpr, out_pool);
	if (rc != SQLITE_OK) {
		goto close;
	}

	rc = sqlite3BtreeCloseCursor(&crsExprs);
	if (rc != SQLITE_OK) {
		goto rollback;
	}

    rc = sqlite3BtreeCommit(db->aDb[0].pBt);
    return rc;

close:
	sqlite3BtreeCloseCursor(&crsExprs);

rollback:
	sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
	return rc;
}

int
sg_insert_triple(sqlite3 *db, i64 subj, i64 pred, i64 obj, i64 *pKey)
{
	Table *triplesTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_TRIPLES);
    if (!triplesTbl) return SQLITE_ERROR;

	Index *spoIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_TRIPLES_SPO);
    if (!spoIdx) return SQLITE_ERROR;

	int rc;
	rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 1);
	if (rc != SQLITE_OK) {
		return rc;
	}

	BtCursor crsTriples;
	memset(&crsTriples, 0, sizeof(crsTriples));
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, triplesTbl->tnum, 1, NULL, &crsTriples);
	if (rc != SQLITE_OK) {
		goto rollback;
	}

	BtCursor crsSPO;
	memset(&crsSPO, 0, sizeof(crsSPO));
	KeyInfo *infSPO = sqlite3KeyInfoAlloc(db, 3, 0);
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, spoIdx->tnum, 1, infSPO, &crsSPO);
	if (rc != SQLITE_OK) {
		goto close1;
	}

	Mem mem[4];
	mem[0].flags = MEM_Int;
	mem[0].u.i = subj;
	mem[1].flags = MEM_Int;
	mem[1].u.i = pred;
	mem[2].flags = MEM_Int;
	mem[2].u.i = obj;

	UnpackedRecord idxKey;
	idxKey.pKeyInfo = crsSPO.pKeyInfo;
	idxKey.nField = 3;
	idxKey.default_rc = 0;
	idxKey.aMem = mem;

	int res = 0;
	rc = sqlite3BtreeMovetoUnpacked(&crsSPO,
	                                &idxKey, 0,  0, &res);
	if (rc != SQLITE_OK) {
		goto close;
	}

	if (res == 0) {
		rc = sqlite3VdbeIdxRowid(db, &crsSPO, pKey);
	} else {
		rc = sqlite3BtreeLast(&crsTriples, &res);
		if (rc != SQLITE_OK) {
			goto close;
		}

		rc = sqlite3BtreeKeySize(&crsTriples, pKey);
		if (rc != SQLITE_OK) {
			goto close;
		}
		(*pKey)++;

		int file_format = db->aDb[0].pSchema->file_format;

		unsigned char buf[41];  // enough for record with three integers
		buf[0] = 5;

		u32 serial_type;
		unsigned char* p = buf+5;

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

		rc = sqlite3BtreeInsert(&crsTriples, 0, *pKey,
								buf, p-buf, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			return rc;
		}

		p = tmp;

		mem[3].flags = MEM_Int;
		mem[3].u.i = *pKey;
		serial_type = sqlite3VdbeSerialType(&mem[3], file_format);
		buf[4] = serial_type;
		p += sqlite3VdbeSerialPut(p, &mem[3], serial_type);

		rc = sqlite3BtreeInsert(&crsSPO, buf, p-buf,
								0, *pKey, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			return rc;
		}
	}

	sqlite3KeyInfoUnref(infSPO);
	rc = sqlite3BtreeCloseCursor(&crsSPO);
	if (rc != SQLITE_OK) {
		goto close1;
	}

	rc = sqlite3BtreeCloseCursor(&crsTriples);
	if (rc != SQLITE_OK) {
		goto rollback;
	}

	rc = sqlite3BtreeCommit(db->aDb[0].pBt);
	return rc;

close:
	sqlite3KeyInfoUnref(infSPO);
	sqlite3BtreeCloseCursor(&crsSPO);

close1:
	sqlite3BtreeCloseCursor(&crsTriples);

rollback:
	sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
	return rc;
}

void main()
{
	sqlite3 *db = NULL;
	sqlite3_open("test.db", &db);

	sg_create_tables(db);

	char* str = "f x (g y)";
	GuPool* tmp_pool = gu_local_pool();

	GuExn* err = gu_exn(tmp_pool);
	GuIn* in = gu_data_in((uint8_t*) str, strlen(str), tmp_pool);
	GuOut* out = gu_file_out(stdout, tmp_pool);

	PgfExpr e = pgf_read_expr(in, tmp_pool, err);

	i64 key;
	sg_insert_expr(db, e, &key);

	sg_select_expr(db, key, &e, tmp_pool);
	pgf_print_expr(e, NULL, 0, out, err);
	printf("\n");

	sg_insert_triple(db, 2, 2, 2, &key);
	printf("%d\n", (int) key);

	gu_pool_free(tmp_pool);

    sqlite3_close(db);
}
