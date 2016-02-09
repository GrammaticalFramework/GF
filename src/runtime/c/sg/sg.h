#ifndef SG_SG_H_
#define SG_SG_H_

typedef long long int SgId;

#include <gu/exn.h>
#include <pgf/pgf.h>

typedef struct SgSG SgSG;

SgSG*
sg_open(const char *filename, GuExn* err);

void
sg_close(SgSG *sg, GuExn* err);

void
sg_begin_trans(SgSG* sg, GuExn* err);

void
sg_commit(SgSG* sg, GuExn* err);

void
sg_rollback(SgSG* sg, GuExn* err);


SgId
sg_insert_expr(SgSG *sg, PgfExpr expr, int wrFlag, GuExn* err);

PgfExpr
sg_get_expr(SgSG *sg, SgId key, GuPool* out_pool, GuExn* err);

void
sg_update_fts_index(SgSG* sg, PgfPGF* pgf, GuExn* err);

GuSeq*
sg_query_linearization(SgSG *sg, GuString tok, GuPool* pool, GuExn* err);


typedef PgfExpr SgTriple[3];

SgId
sg_insert_triple(SgSG *sg, SgTriple triple, GuExn* err);

int
sg_get_triple(SgSG *sg, SgId key, SgTriple triple,
                 GuPool* out_pool, GuExn* err);

typedef struct SgTripleResult SgTripleResult;

SgTripleResult*
sg_query_triple(SgSG *sg, SgTriple triple, GuExn* err);

int
sg_triple_result_fetch(SgTripleResult* tres, SgId* pKey, SgTriple triple,
                       GuPool* out_pool, GuExn* err);

void
sg_triple_result_get_query(SgTripleResult* tres, SgTriple triple);

void
sg_triple_result_close(SgTripleResult* tres, GuExn* err);

typedef struct SgQuery SgQuery;
typedef struct SgQueryResult SgQueryResult;

SgQuery*
sg_prepare_query(SgSG *sg, size_t n_triples, SgTriple* triples,
                 GuPool* pool, GuExn* err);

SgQueryResult*
sg_query(SgSG *sg, SgQuery* query, GuExn* err);

#endif
