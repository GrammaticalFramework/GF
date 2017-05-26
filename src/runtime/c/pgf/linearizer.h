#ifndef PGF_LINEARIZER_H_
#define PGF_LINEARIZER_H_

#include <gu/enum.h>

/// Linearization of abstract syntax trees.

//
// PgfCncTree
//

/// A concrete syntax tree
typedef GuVariant PgfCncTree;

#ifdef PGF_DATA_H_

typedef enum {
	PGF_CNC_TREE_APP,
	PGF_CNC_TREE_CHUNKS,
	PGF_CNC_TREE_LIT,
} PgfCncTreeTag;

typedef struct {
	PgfCCat* ccat;
	PgfCncFun* fun;
	int fid;

	size_t n_vars;
	PgfPrintContext* context;

	size_t n_args;
	PgfCncTree args[];
} PgfCncTreeApp;

typedef struct {
	size_t n_vars;
	PgfPrintContext* context;

	size_t n_args;
	PgfCncTree args[];
} PgfCncTreeChunks;

typedef struct {
	size_t n_vars;
	PgfPrintContext* context;

	int fid;
	PgfLiteral lit;
} PgfCncTreeLit;

#endif

/// An enumeration of #PgfCncTree trees.
typedef GuEnum PgfCncTreeEnum;

/// Begin enumerating concrete syntax variants.
PGF_API_DECL PgfCncTreeEnum*
pgf_lzr_concretize(PgfConcr* concr, PgfExpr expr, GuExn* err, GuPool* pool);

typedef struct {
	char nothing[0]; // Empty struct
} PgfLinNonExist;

PGF_API_DECL PgfCncTree
pgf_lzr_wrap_linref(PgfCncTree ctree, GuPool* pool);



typedef struct PgfLinFuncs PgfLinFuncs;

typedef enum {
	PGF_CAPIT_NONE,
	PGF_CAPIT_FIRST,
	PGF_CAPIT_ALL,
	PGF_CAPIT_NEXT
} PgfCapitState;

struct PgfLinFuncs
{
	/// Output tokens
	void (*symbol_token)(PgfLinFuncs** self, PgfToken tok);

	/// Begin phrase
	void (*begin_phrase)(PgfLinFuncs** self, PgfCId cat, int fid, int lindex, PgfCId fun);

	/// End phrase
	void (*end_phrase)(PgfLinFuncs** self, PgfCId cat, int fid, int lindex, PgfCId fun);

	/// handling nonExist
	void (*symbol_ne)(PgfLinFuncs** self);

	/// token binding
	void (*symbol_bind)(PgfLinFuncs** self);

	/// capitalization
	void (*symbol_capit)(PgfLinFuncs** self, PgfCapitState capit);
};

/// Linearize a concrete syntax tree.
PGF_API_DECL void
pgf_lzr_linearize(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx, 
                  PgfLinFuncs** funcs, GuPool* tmp_pool);

/// Linearize a concrete syntax tree as space-separated tokens.
PGF_API_DECL void
pgf_lzr_linearize_simple(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx, 
                         GuOut* out, GuExn* err,
                         GuPool* tmp_pool);


PGF_API_DECL void
pgf_lzr_get_table(PgfConcr* concr, PgfCncTree ctree, 
                  size_t* n_lins, GuString** labels);

#ifdef PGF_DATA_H_
// Used internally in the parser
PGF_INTERNAL_DECL GuString
pgf_get_tokens(PgfSymbols* sym, uint16_t sym_idx, GuPool* pool);
#endif

#endif
