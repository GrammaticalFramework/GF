#ifndef PGF_LINEARIZER_H_
#define PGF_LINEARIZER_H_

#include <gu/type.h>
#include <gu/enum.h>

/// Linearization of abstract syntax trees.
/// @file

/** @}
 *
 * @name Enumerating concrete syntax trees
 *
 * Because of the \c variants construct in GF, there may be several
 * possible concrete syntax trees that correspond to a given abstract
 * syntax tree. These can be enumerated with #pgf_lzr_concretize and
 * #pgf_cnc_trees_next.
 *
 * @{
 */


/// A concrete syntax tree
typedef GuVariant PgfCncTree;

/// An enumeration of #PgfCncTree trees.
typedef GuEnum PgfCncTreeEnum;

/// Begin enumerating concrete syntax variants.
PgfCncTreeEnum*
pgf_lzr_concretize(PgfConcr* concr, PgfExpr expr, GuPool* pool);

typedef struct {
} PgfLinNonExist;

extern GU_DECLARE_TYPE(PgfLinNonExist, abstract);

typedef struct PgfLinFuncs PgfLinFuncs;

struct PgfLinFuncs
{
	/// Output tokens
	void (*symbol_token)(PgfLinFuncs** self, PgfToken tok);

	/// Output literal
	void (*expr_literal)(PgfLinFuncs** self, PgfLiteral lit);

	/// Begin phrase
	void (*begin_phrase)(PgfLinFuncs** self, PgfCId cat, int fid, int lindex, PgfCId fun);

	/// End phrase
	void (*end_phrase)(PgfLinFuncs** self, PgfCId cat, int fid, int lindex, PgfCId fun);

	/// handling nonExist
	void (*symbol_ne)(PgfLinFuncs** self);

	/// token binding
	void (*symbol_bind)(PgfLinFuncs** self);
};




/// Linearize a concrete syntax tree.
void
pgf_lzr_linearize(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx,
		  PgfLinFuncs** fnsp);


/// Linearize a concrete syntax tree as space-separated tokens.
void
pgf_lzr_linearize_simple(PgfConcr* concr, PgfCncTree ctree,
			 size_t lin_idx, GuOut* out, GuExn* err);


void
pgf_lzr_linearize_table(PgfConcr* concr, PgfCncTree ctree, 
                        size_t* n_lins, GuString** labels);
#endif

#ifdef PGF_PARSER_H_
// Used internally in the parser
GuString
pgf_get_tokens(PgfSymbols* sym, uint16_t sym_idx, GuPool* pool);
#endif
