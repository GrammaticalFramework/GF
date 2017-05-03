#ifndef PGF_H_
#define PGF_H_

#include <gu/exn.h>
#include <gu/mem.h>
#include <gu/map.h>
#include <gu/enum.h>
#include <gu/string.h>

#if defined(_MSC_VER)

#if defined(COMPILING_PGF)
#define PGF_API_DECL __declspec(dllexport)
#define PGF_API      __declspec(dllexport)
#else
#define PGF_API_DECL __declspec(dllimport)
#define PGF_API      ERROR_NOT_COMPILING_LIBPGF
#endif
#define PGF_INTERNAL_DECL
#define PGF_INTERNAL

#else

#define PGF_API_DECL
#define PGF_API

#define PGF_INTERNAL_DECL  __attribute__ ((visibility ("hidden")))
#define PGF_INTERNAL       __attribute__ ((visibility ("hidden")))

#endif


typedef GuString PgfCId;

typedef GuString PgfToken;

typedef struct PgfPGF PgfPGF;

typedef struct PgfConcr PgfConcr;

#include <pgf/expr.h>
#include <pgf/graphviz.h>

typedef GuEnum PgfExprEnum;

PGF_API_DECL PgfPGF*
pgf_read(const char* fpath,
         GuPool* pool, GuExn* err);

PGF_API_DECL PgfPGF*
pgf_read_in(GuIn* in,
            GuPool* pool, GuPool* tmp_pool, GuExn* err);

PGF_API_DECL void
pgf_concrete_load(PgfConcr* concr, GuIn* in, GuExn* err);

PGF_API_DECL void
pgf_concrete_unload(PgfConcr* concr);

PGF_API_DECL GuString
pgf_abstract_name(PgfPGF*);

PGF_API_DECL void
pgf_iter_languages(PgfPGF*, GuMapItor* itor, GuExn* err);

PGF_API_DECL PgfConcr*
pgf_get_language(PgfPGF*, PgfCId lang);

PGF_API_DECL GuString
pgf_concrete_name(PgfConcr*);

PGF_API_DECL GuString
pgf_language_code(PgfConcr* concr);

PGF_API_DECL void
pgf_iter_categories(PgfPGF* pgf, GuMapItor* itor, GuExn* err);

PGF_API_DECL PgfType*
pgf_start_cat(PgfPGF* pgf, GuPool* pool);

PGF_API_DECL void
pgf_iter_functions(PgfPGF* pgf, GuMapItor* itor, GuExn* err);

PGF_API_DECL void
pgf_iter_functions_by_cat(PgfPGF* pgf, PgfCId catname,
                          GuMapItor* itor, GuExn* err);

PGF_API_DECL PgfType*
pgf_function_type(PgfPGF* pgf, PgfCId funname);

PGF_API_DECL double
pgf_function_prob(PgfPGF* pgf, PgfCId funname);

PGF_API_DECL GuString
pgf_print_name(PgfConcr*, PgfCId id);

PGF_API_DECL bool
pgf_has_linearization(PgfConcr* concr, PgfCId id);

PGF_API_DECL void
pgf_linearize(PgfConcr* concr, PgfExpr expr, GuOut* out, GuExn* err);

typedef struct {
	GuString phrase;
	size_t n_fids;
	int fids[];
} PgfAlignmentPhrase;

PGF_API_DECL GuSeq*
pgf_align_words(PgfConcr* concr, PgfExpr expr,
                GuExn* err, GuPool* pool);

PGF_API_DECL bool
pgf_parseval(PgfConcr* concr, PgfExpr expr, PgfType* type, 
             double *precision, double *recall, double *exact);

PGF_API_DECL PgfExpr
pgf_compute(PgfPGF* pgf, PgfExpr expr, GuExn* err,
            GuPool* pool, GuPool* out_pool);

PGF_API_DECL PgfExprEnum*
pgf_generate_all(PgfPGF* pgf, PgfType* ty,
                 GuExn* err, GuPool* pool, GuPool* out_pool);

PGF_API_DECL PgfExprEnum*
pgf_parse(PgfConcr* concr, PgfType* typ, GuString sentence,
          GuExn* err, GuPool* pool, GuPool* out_pool);

PGF_API_DECL GuEnum*
pgf_lookup_sentence(PgfConcr* concr, GuString sentence, GuPool* pool, GuPool* out_pool);

typedef struct PgfMorphoCallback PgfMorphoCallback;
struct PgfMorphoCallback {
	void (*callback)(PgfMorphoCallback* self,
	                 PgfCId lemma, GuString analysis, prob_t prob,
	                 GuExn* err);
};

PGF_API_DECL void
pgf_lookup_morpho(PgfConcr *concr, GuString sentence,
                  PgfMorphoCallback* callback, GuExn* err);

typedef struct PgfFullFormEntry PgfFullFormEntry;

PGF_API_DECL GuEnum*
pgf_fullform_lexicon(PgfConcr *concr, GuPool* pool);

PGF_API_DECL GuString
pgf_fullform_get_string(PgfFullFormEntry* entry);

PGF_API_DECL void
pgf_fullform_get_analyses(PgfFullFormEntry* entry,
                          PgfMorphoCallback* callback, GuExn* err);

PGF_API_DECL GuEnum*
pgf_lookup_word_prefix(PgfConcr *concr, GuString prefix,
                       GuPool* pool, GuExn* err);

typedef GuMap PgfCallbacksMap;

PGF_API_DECL PgfExprEnum*
pgf_parse_with_heuristics(PgfConcr* concr, PgfType* typ, 
                          GuString sentence, double heuristics,
                          PgfCallbacksMap* callbacks,
                          GuExn* err,
                          GuPool* pool, GuPool* out_pool);

typedef struct PgfOracleCallback PgfOracleCallback;

struct PgfOracleCallback {
    bool (*predict) (PgfOracleCallback* self,
	                 PgfCId cat,
	                 GuString label,
	                 size_t offset);
	bool (*complete)(PgfOracleCallback* self,
	                 PgfCId cat,
	                 GuString label,
	                 size_t offset);
    PgfExprProb* (*literal)(PgfOracleCallback* self,
                            PgfCId cat,
	                        GuString label,
	                        size_t* poffset,
	                        GuPool *out_pool);
};

PGF_API_DECL PgfExprEnum*
pgf_parse_with_oracle(PgfConcr* concr, PgfType* typ,
                      GuString sentence,
                      PgfOracleCallback* oracle,
                      GuExn* err,
                      GuPool* pool, GuPool* out_pool);

typedef struct {
	PgfToken tok;
	PgfCId cat;
	prob_t prob;
} PgfTokenProb;

PGF_API_DECL GuEnum*
pgf_complete(PgfConcr* concr, PgfType* type, GuString string, 
             GuString prefix, GuExn* err, GuPool* pool);

typedef struct PgfLiteralCallback PgfLiteralCallback;

struct PgfLiteralCallback {
	PgfExprProb* (*match)(PgfLiteralCallback* self, PgfConcr* concr,
	                      size_t lin_idx,
	                      GuString sentence, size_t* poffset,
	                      GuPool *out_pool);
    GuEnum*    (*predict)(PgfLiteralCallback* self, PgfConcr* concr,
	                      size_t lin_idx,
	                      GuString prefix,
	                      GuPool *out_pool);
};

PGF_API_DECL PgfCallbacksMap*
pgf_new_callbacks_map(PgfConcr* concr, GuPool *pool);

PGF_API_DECL void
pgf_callbacks_map_add_literal(PgfConcr* concr, PgfCallbacksMap* callbacks,
                              PgfCId cat, PgfLiteralCallback* callback);

PGF_API_DECL void
pgf_print(PgfPGF* pgf, GuOut* out, GuExn* err); 

PGF_API_DECL void
pgf_check_expr(PgfPGF* gr, PgfExpr* pe, PgfType* ty,
               GuExn* exn, GuPool* pool);

PGF_API_DECL PgfType*
pgf_infer_expr(PgfPGF* gr, PgfExpr* pe, 
               GuExn* exn, GuPool* pool);

PGF_API_DECL void
pgf_check_type(PgfPGF* gr, PgfType** ty,
               GuExn* exn, GuPool* pool);

// internal
PGF_API_DECL PgfExprProb*
pgf_fun_get_ep(void* value);

#endif // PGF_H_
