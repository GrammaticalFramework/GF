#ifndef PGF_LINEARIZER_H_
#define PGF_LINEARIZER_H_

#include <gu/enum.h>

/// Linearization of abstract syntax trees.
/// @file

/** @}
 *
 * @name Enumerating concrete syntax trees
 *
 * Because of the \c variants construct in GF, there may be several
 * possible concrete syntax trees that correspond to a given abstract
 * syntax tree. These can be enumerated with #pgf_concretize.
 *
 * @{
 */


/// A concrete syntax tree
typedef GuVariant PgfCncTree;

/// An enumeration of #PgfCncTree trees.
typedef GuEnum PgfCncTreeEnum;

/// Begin enumerating concrete syntax variants.
PgfCncTreeEnum*
pgf_lzr_concretize(PgfConcr* concr, PgfExpr expr, GuExn* err, GuPool* pool);

typedef struct {
} PgfLinNonExist;

PgfCncTree
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
void
pgf_lzr_linearize(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx, 
                  PgfLinFuncs** funcs, GuPool* tmp_pool);

/// Linearize a concrete syntax tree as space-separated tokens.
void
pgf_lzr_linearize_simple(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx, 
                         GuOut* out, GuExn* err,
                         GuPool* tmp_pool);


void
pgf_lzr_get_table(PgfConcr* concr, PgfCncTree ctree, 
                  size_t* n_lins, GuString** labels);

#ifdef PGF_DATA_H_
// Used internally in the parser
GuString
pgf_get_tokens(PgfSymbols* sym, uint16_t sym_idx, GuPool* pool);
#endif

#endif
