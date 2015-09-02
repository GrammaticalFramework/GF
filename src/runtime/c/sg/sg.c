#define SQLITE_API static
#include "sqlite3.c"

#include "sg/sg.h"

#define SG_EXPRS   "sg_exprs"
#define SG_PAIRS   "sg_pairs"
#define SG_IDENTS  "sg_idents"
#define SG_TRIPLES "sg_triples"
#define SG_TRIPLES_SPO "sg_triples_spo"
#define SG_TRIPLES_PO  "sg_triples_po"
#define SG_TRIPLES_O   "sg_triples_o"

typedef struct {
	sqlite3 *db;
	BtCursor* crsExprs;
	BtCursor* crsPairs;
	BtCursor* crsIdents;
	SgId key_seed;
	int file_format;
} StoreContext;

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
	                      "create unique index if not exists " SG_PAIRS " on " SG_EXPRS "(fun,arg) where arg is not null;"
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

static int
store_expr(StoreContext* ctxt, PgfExpr expr, SgId* pKey)
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

SgId
sg_insert_expr(SgSG *sg, PgfExpr expr, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	Table *exprsTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_EXPRS);
    if (!exprsTbl) {
		sg_raise_err("Table " SG_EXPRS " is missing", err);
		return 0;
	}
    
	Index *pairsIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_PAIRS);
    if (!pairsIdx) {
		sg_raise_err("Index " SG_PAIRS " is missing", err);
		return 0;
	}

	Index *identsIdx = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_IDENTS);
    if (!identsIdx) {
		sg_raise_err("Index " SG_IDENTS " is missing", err);
		return 0;
	}

	int rc;
	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, 1);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return 0;
		}
	}

	BtCursor crsExprs;
	memset(&crsExprs, 0, sizeof(crsExprs));
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, exprsTbl->tnum, 1, NULL, &crsExprs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto rollback;
	}

	BtCursor crsPairs;
	memset(&crsPairs, 0, sizeof(crsPairs));
	KeyInfo *infPairs = sqlite3KeyInfoAlloc(db, 2, 0);
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, pairsIdx->tnum, 1, infPairs, &crsPairs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close1;
	}

	BtCursor crsIdents;
	memset(&crsIdents, 0, sizeof(crsIdents));
	KeyInfo *infIdents = sqlite3KeyInfoAlloc(db, 1, 1);
	rc = sqlite3BtreeCursor(db->aDb[0].pBt, identsIdx->tnum, 1, infIdents, &crsIdents);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close2;
	}

	int res;
	rc = sqlite3BtreeLast(&crsExprs, &res);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	SgId key = 0;
	rc = sqlite3BtreeKeySize(&crsExprs, &key);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	StoreContext ctxt;
	ctxt.db       = db;
	ctxt.crsExprs = &crsExprs;
	ctxt.crsPairs = &crsPairs;
	ctxt.crsIdents = &crsIdents;
	ctxt.key_seed = key;
	ctxt.file_format = db->aDb[0].pSchema->file_format;
	rc = store_expr(&ctxt, expr, &key);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	sqlite3KeyInfoUnref(infIdents);
	rc = sqlite3BtreeCloseCursor(&crsIdents);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close2;
	}

	sqlite3KeyInfoUnref(infPairs);
	rc = sqlite3BtreeCloseCursor(&crsPairs);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close1;
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
			return 0;
		}
	}

    return key;

close:
	sqlite3KeyInfoUnref(infIdents);
	sqlite3BtreeCloseCursor(&crsIdents);

close2:
	sqlite3KeyInfoUnref(infPairs);
	sqlite3BtreeCloseCursor(&crsPairs);

close1:
	sqlite3BtreeCloseCursor(&crsExprs);

rollback:
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

PgfExpr
sg_select_expr(SgSG *sg, SgId key, GuPool* out_pool, GuExn* err)
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

static void
open_triples(sqlite3 *db, int wrFlag, BtCursor cursor[], int *n_cursors, GuExn* err)
{
	Index *idx[3];
	idx[0] = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_TRIPLES_SPO);
    if (!idx[0]) {
		sg_raise_err("Index " SG_TRIPLES_SPO " is missing", err);
		return;
	}

	idx[1] = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_TRIPLES_PO);
    if (!idx[1]) {
		sg_raise_err("Index " SG_TRIPLES_PO " is missing", err);
		return;
	}

	idx[2] = sqlite3HashFind(&db->aDb[0].pSchema->idxHash, SG_TRIPLES_O);
    if (!idx[2]) {
		sg_raise_err("Index " SG_TRIPLES_O " is missing", err);
		return;
	}

	Table *triplesTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_TRIPLES);
    if (!triplesTbl) {
		sg_raise_err("Table " SG_TRIPLES " is missing", err);
		return;
	}

	int rc;
	if (db->autoCommit) {
		rc = sqlite3BtreeBeginTrans(db->aDb[0].pBt, wrFlag);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return;
		}
	}

	memset(cursor, 0, sizeof(BtCursor)*4);

	*n_cursors = 0;
	while (*n_cursors < 3) {
		KeyInfo *inf = sqlite3KeyInfoAlloc(db, 3-*n_cursors, *n_cursors);
		rc = sqlite3BtreeCursor(db->aDb[0].pBt, idx[*n_cursors]->tnum, wrFlag, inf, &cursor[*n_cursors]);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			return;
		}
		(*n_cursors)++;
	}

	rc = sqlite3BtreeCursor(db->aDb[0].pBt, triplesTbl->tnum, wrFlag, NULL, &cursor[*n_cursors]);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		return;
	}
	(*n_cursors)++;
}

static void
close_triples(sqlite3 *db, BtCursor cursor[], int *n_cursors, int rc, GuExn* err)
{
	while (*n_cursors > 0) {
		(*n_cursors)--;
		if (cursor[*n_cursors].pKeyInfo != NULL) {
			sqlite3KeyInfoUnref(cursor[*n_cursors].pKeyInfo);
		}
		sqlite3BtreeCloseCursor(&cursor[*n_cursors]);
	}

	if (db->autoCommit) {
		if (rc == SQLITE_OK || rc == SQLITE_DONE) {
			rc = sqlite3BtreeCommit(db->aDb[0].pBt);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(db, err);
				return;
			}
		} else {
			sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
		}
	}
}

SgId
sg_insert_triple(SgSG *sg, SgTriple triple, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	int rc;

	BtCursor cursor[4];
	int n_cursors = 0;
	open_triples(db, 1, cursor, &n_cursors, err);
	if (gu_exn_is_raised(err)) {
		goto close;
	}

	Mem mem[4];
	mem[0].flags = MEM_Int;
	mem[0].u.i = triple[0];
	mem[1].flags = MEM_Int;
	mem[1].u.i = triple[1];
	mem[2].flags = MEM_Int;
	mem[2].u.i = triple[2];

	UnpackedRecord idxKey;
	idxKey.pKeyInfo = cursor[0].pKeyInfo;
	idxKey.nField = 3;
	idxKey.default_rc = 0;
	idxKey.aMem = mem;

	int res = 0;
	rc = sqlite3BtreeMovetoUnpacked(&cursor[0],
	                                &idxKey, 0,  0, &res);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	SgId key = 0;

	if (res == 0) {
		rc = sqlite3VdbeIdxRowid(db, &cursor[0], &key);
	} else {
		rc = sqlite3BtreeLast(&cursor[3], &res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}

		rc = sqlite3BtreeKeySize(&cursor[3], &key);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}
		key++;

		u32 serial_type;
		unsigned char buf[41];  // enough for record with three integers
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

		rc = sqlite3BtreeInsert(&cursor[3], 0, key,
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

		rc = sqlite3BtreeInsert(&cursor[0], buf, p-buf,
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

		rc = sqlite3BtreeInsert(&cursor[1], buf, p-buf,
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

		rc = sqlite3BtreeInsert(&cursor[2], buf, p-buf,
								0, key, 0,
								0, 0);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}
	}

close:
	close_triples(db, cursor, &n_cursors, rc, err);
	return key;
}

static int
load_triple(BtCursor* crsTriples, SgTriple triple)
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

	triple[0] = mem[0].u.i;
	triple[1] = mem[1].u.i;
	triple[2] = mem[2].u.i;
	
	return SQLITE_OK;
}

bool
sg_select_triple(SgSG *sg, SgId key, SgTriple triple, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	Table *triplesTbl =
		sqlite3HashFind(&db->aDb[0].pSchema->tblHash, SG_TRIPLES);
      if (!triplesTbl) {
		sg_raise_err("Table " SG_TRIPLES " is missing", err);
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

	int res;
	rc = sqlite3BtreeMovetoUnpacked(&crsTriples, 0, key, 0, &res);
	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	if (res == 0) {
		rc = load_triple(&crsTriples, triple);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(db, err);
			goto close;
		}
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
	sqlite3BtreeCloseCursor(&crsTriples);

rollback:
	if (db->autoCommit) {
		sqlite3BtreeRollback(db->aDb[0].pBt, SQLITE_ABORT_ROLLBACK, 0);
	}
	return false;
}

struct SgTripleResult {
	sqlite3 *db;

	int n_cursors;
	BtCursor cursors[4];
	BtCursor* cursor;

	int res;
	Mem mem[3];
	UnpackedRecord idxKey;
};

SgTripleResult*
sg_query_triple(SgSG *sg, SgTriple triple, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	SgTripleResult* tres = malloc(sizeof(SgTripleResult));
	tres->db = db;

	open_triples(db, 0, tres->cursors, &tres->n_cursors, err);
	if (gu_exn_is_raised(err))
		goto close;

	for (int i = 0; i < 3; i++) {
		if (triple[i] == 0)
			tres->mem[i].flags = MEM_Null;
		else {
			tres->mem[i].flags = MEM_Int;
			tres->mem[i].u.i = triple[i];
		}
	}

	int i = 0;
	while (i < 3) {
		if (triple[i] != 0)
			break;
		i++;
	}

	tres->cursor = &tres->cursors[i];
	tres->idxKey.pKeyInfo = tres->cursor->pKeyInfo;
	tres->idxKey.nField = 0;
	tres->idxKey.aMem = &tres->mem[i];
	tres->res = 0;

	while (i+tres->idxKey.nField < 3) {
		tres->idxKey.nField++;

		if (triple[i+tres->idxKey.nField] == 0)
			break;
	}

	int rc;
	if (tres->idxKey.nField > 0) {
		tres->idxKey.default_rc = 1;
		rc = sqlite3BtreeMovetoUnpacked(tres->cursor,
										&tres->idxKey, 0,  0, &tres->res);
		if (rc == SQLITE_OK) {
			if (tres->res < 0) {
				rc = sqlite3BtreeNext(tres->cursor, &tres->res);
			}
			tres->res = 0;
		}
	} else {
		rc = sqlite3BtreeFirst(tres->cursor, &tres->res);
	}

	if (rc != SQLITE_OK) {
		sg_raise_sqlite(db, err);
		goto close;
	}

	return tres;

close:
	close_triples(db, tres->cursors, &tres->n_cursors, rc, err);
	free(tres);
	return NULL;
}

bool
sg_triple_result_fetch(SgTripleResult* tres, SgId* pKey, SgTriple triple, GuExn* err)
{
	while (tres->res == 0) {
		int rc;

		if (tres->idxKey.nField > 0) {
			i64 szData;
			const unsigned char *zData;
			rc = sqlite3BtreeKeySize(tres->cursor, &szData);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(tres->db, err);
				return false;
			}

			u32 available = 0;
			zData = sqlite3BtreeKeyFetch(tres->cursor, &available);
			if (szData > available)
				gu_impossible();

			tres->idxKey.default_rc = 0;
			tres->res = sqlite3VdbeRecordCompare(available, zData, &tres->idxKey);
			if (tres->res != 0)
				return false;

			if (tres->idxKey.nField == 1 && tres->mem[2].flags != MEM_Null) {
				int offset = 
					zData[0] + 
					sqlite3VdbeSerialTypeLen(zData[1]) + 
					sqlite3VdbeSerialTypeLen(zData[2]);
				zData+offset;
				Mem mem;
				sqlite3VdbeSerialGet(zData+offset, zData[3], &mem);
				if (mem.u.i != tres->mem[2].u.i) {
					sqlite3BtreeNext(tres->cursor, &tres->res);
					if (rc != SQLITE_OK) {
						sg_raise_sqlite(tres->db, err);
						return false;
					}
					continue;
				}
			}
		}

		if (tres->idxKey.nField > 0) {
			rc = sqlite3VdbeIdxRowid(tres->db, tres->cursor, pKey);
			if (rc != SQLITE_OK) {
				sg_raise_sqlite(tres->db, err);
				return false;
			}

			rc = sqlite3BtreeMovetoUnpacked(&tres->cursors[3], 0, *pKey, 0, &tres->res);
		} else {
			rc = sqlite3BtreeKeySize(tres->cursor, pKey);
		}
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(tres->db, err);
			return false;
		}

		rc = load_triple(&tres->cursors[3], triple);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(tres->db, err);
			return false;
		}
		
		sqlite3BtreeNext(tres->cursor, &tres->res);
		if (rc != SQLITE_OK) {
			sg_raise_sqlite(tres->db, err);
			return false;
		}
		
		return true;
	}

	return false;
}

void
sg_triple_result_close(SgTripleResult* tres, GuExn* err)
{
	close_triples(tres->db, tres->cursors, &tres->n_cursors, SQLITE_OK, err);
	free(tres);
}

struct SgQueryResult {
	sqlite3 *db;
	SgQuery* query;

	int n_results;
	SgTripleResult* results[];
};

SgQueryResult*
sg_query(SgSG *sg, SgQuery* query, GuExn* err)
{
	sqlite3 *db = (sqlite3 *) sg;

	SgQueryResult* qres = 
		malloc(sizeof(SgQueryResult)+
		       sizeof(SgTripleResult*)*query->n_patterns);
	qres->db = db;
	qres->query = query;
	qres->n_results = 0;
	
	return qres;
}

bool
sg_query_result_fetch(SgQueryResult* qres, SgId* res, GuExn* err)
{
	size_t i = 0;
	while (i < qres->query->n_patterns) {
		SgTriple triple;
		triple[0] = qres->query->vars[qres->query->patterns[i][0]];
		triple[1] = qres->query->vars[qres->query->patterns[i][1]];
		triple[2] = qres->query->vars[qres->query->patterns[i][2]];
		qres->results[i] = sg_query_triple((SgSG *) qres->db, triple, err);

		SgId key;
		for (;;) {
			bool found = sg_triple_result_fetch(qres->results[i], &key, triple, err);
			if (gu_exn_is_raised(err)) {
				return false;
			}

			if (!found) {
				sg_triple_result_close(qres->results[i], err);
				if (gu_exn_is_raised(err)) {
					return false;
				}
				
				if (i == 0)
					break;
				
				i--;
			}
		}

		qres->query->vars[qres->query->patterns[i][0]] = triple[0];
		qres->query->vars[qres->query->patterns[i][1]] = triple[1];
		qres->query->vars[qres->query->patterns[i][2]] = triple[2];

		i++;
	}
	
	return false;
}
