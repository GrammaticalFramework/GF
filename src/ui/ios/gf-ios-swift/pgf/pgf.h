#ifndef PGF_H_
#define PGF_H_

#include <gu/exn.h>
#include <gu/mem.h>
#include <gu/map.h>
#include <gu/enum.h>
#include <gu/string.h>


typedef GuString PgfCId;

typedef GuString PgfToken;

typedef struct PgfPGF PgfPGF;

typedef struct PgfConcr PgfConcr;

#include <pgf/expr.h>
#include <pgf/graphviz.h>

typedef GuEnum PgfExprEnum;

PgfPGF*
pgf_read(const char* fpath,
         GuPool* pool, GuExn* err);

void
pgf_concrete_load(PgfConcr* concr, GuIn* in, GuExn* err);

void
pgf_concrete_unload(PgfConcr* concr);

GuString
pgf_abstract_name(PgfPGF*);

void
pgf_iter_languages(PgfPGF*, GuMapItor* itor, GuExn* err);

PgfConcr*
pgf_get_language(PgfPGF*, PgfCId lang);

GuString
pgf_concrete_name(PgfConcr*);

GuString
pgf_language_code(PgfConcr* concr);

void
pgf_iter_categories(PgfPGF* pgf, GuMapItor* itor, GuExn* err);

PgfCId
pgf_start_cat(PgfPGF* pgf);

void
pgf_iter_functions(PgfPGF* pgf, GuMapItor* itor, GuExn* err);

void
pgf_iter_functions_by_cat(PgfPGF* pgf, PgfCId catname,
                          GuMapItor* itor, GuExn* err);

PgfType*
pgf_function_type(PgfPGF* pgf, PgfCId funname);

GuString
pgf_print_name(PgfConcr*, PgfCId id);

bool
pgf_has_linearization(PgfConcr* concr, PgfCId id);

void
pgf_linearize(PgfConcr* concr, PgfExpr expr, GuOut* out, GuExn* err);

bool
pgf_parseval(PgfConcr* concr, PgfExpr expr, PgfCId cat, 
             double *precision, double *recall, double *exact);

PgfExpr
pgf_compute(PgfPGF* pgf, PgfExpr expr, GuExn* err, 
            GuPool* pool, GuPool* out_pool);

PgfExprEnum*
pgf_generate_all(PgfPGF* pgf, PgfCId cat, GuPool* pool);

PgfExprEnum*
pgf_parse(PgfConcr* concr, PgfCId cat, GuString sentence,
          GuExn* err,
          GuPool* pool, GuPool* out_pool);

typedef struct PgfMorphoCallback PgfMorphoCallback;
struct PgfMorphoCallback {
	void (*callback)(PgfMorphoCallback* self,
	                 PgfCId lemma, GuString analysis, prob_t prob,
	                 GuExn* err);
};

void
pgf_lookup_morpho(PgfConcr *concr, GuString sentence,
                  PgfMorphoCallback* callback, GuExn* err);

typedef struct PgfFullFormEntry PgfFullFormEntry;

GuEnum*
pgf_fullform_lexicon(PgfConcr *concr, GuPool* pool);

GuString
pgf_fullform_get_string(PgfFullFormEntry* entry);

void
pgf_fullform_get_analyses(PgfFullFormEntry* entry,
                          PgfMorphoCallback* callback, GuExn* err);

GuEnum*
pgf_lookup_word_prefix(PgfConcr *concr, GuString prefix,
                       GuPool* pool, GuExn* err);

PgfExprEnum*
pgf_parse_with_heuristics(PgfConcr* concr, PgfCId cat, 
                          GuString sentence, double heuristics,
                          GuExn* err,
                          GuPool* pool, GuPool* out_pool);

typedef struct {
	PgfToken tok;
	PgfCId cat;
	prob_t prob;
} PgfTokenProb;

GuEnum*
pgf_complete(PgfConcr* concr, PgfCId cat, GuString string, 
             GuString prefix, GuExn* err, GuPool* pool);

GuPool*
pgf_concr_get_pool(PgfConcr* concr);

typedef struct PgfLiteralCallback PgfLiteralCallback;

struct PgfLiteralCallback {
	PgfExprProb* (*match)(PgfLiteralCallback* self,
	                      size_t lin_idx,
	                      GuString sentence, size_t* poffset,
	                      GuPool *out_pool);
    GuEnum*    (*predict)(PgfLiteralCallback* self,
	                      size_t lin_idx,
	                      GuString prefix,
	                      GuPool *out_pool);
};

void
pgf_concr_add_literal(PgfConcr *concr, PgfCId cat,
                      PgfLiteralCallback* callback,
                      GuExn* err);

void
pgf_print(PgfPGF* pgf, GuOut* out, GuExn* err); 

void
pgf_check_expr(PgfPGF* gr, PgfExpr* pe, PgfType* ty,
               GuExn* exn, GuPool* pool);

PgfType*
pgf_infer_expr(PgfPGF* gr, PgfExpr* pe, 
               GuExn* exn, GuPool* pool);

void
pgf_check_type(PgfPGF* gr, PgfType** ty,
               GuExn* exn, GuPool* pool);

// internal
PgfExprProb*
pgf_fun_get_ep(void* value);

#endif // PGF_H_
