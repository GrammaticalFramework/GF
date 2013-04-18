/* 
 * Copyright 2010-2011 University of Helsinki.
 *   
 * This file is part of libpgf.
 * 
 * Libpgf is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 * 
 * Libpgf is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
 * License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with libpgf. If not, see <http://www.gnu.org/licenses/>.
 */

#include <gu/type.h>
#include <gu/dump.h>
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

typedef struct PgfLinFuncs PgfLinFuncs;

struct PgfLinFuncs
{
	/// Output tokens
	void (*symbol_tokens)(PgfLinFuncs** self, PgfTokens toks);

	/// Output literal
	void (*expr_literal)(PgfLinFuncs** self, PgfLiteral lit);

	/// Begin phrase
	void (*begin_phrase)(PgfLinFuncs** self, PgfCId cat, int fid, int lindex, PgfCId fun);

	/// End phrase
	void (*end_phrase)(PgfLinFuncs** self, PgfCId cat, int fid, int lindex, PgfCId fun);
};




/// Linearize a concrete syntax tree.
void
pgf_lzr_linearize(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx,
		  PgfLinFuncs** fnsp);


/// Linearize a concrete syntax tree as space-separated tokens.
void
pgf_lzr_linearize_simple(PgfConcr* concr, PgfCncTree ctree,
			 size_t lin_idx, GuWriter* wtr, GuExn* err);
