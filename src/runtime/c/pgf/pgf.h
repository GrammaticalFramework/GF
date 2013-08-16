/* 
 * Copyright 2010 University of Gothenburg.
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

/** @file
 *
 * The public libpgf API.
 */

#ifndef PGF_H_
#define PGF_H_

#include <gu/exn.h>
#include <gu/mem.h>
#include <gu/map.h>
#include <gu/enum.h>
#include <gu/string.h>


typedef GuString PgfCId;
extern GU_DECLARE_TYPE(PgfCId, typedef);


extern GU_DECLARE_TYPE(PgfExn, abstract);

/// @name PGF Grammar objects
/// @{

typedef struct PgfPGF PgfPGF;

typedef struct PgfConcr PgfConcr;


/**< A representation of a PGF grammar. 
 */

#include <pgf/expr.h>
#include <pgf/lexer.h>
#include <pgf/graphviz.h>

/// An enumeration of #PgfExpr elements.
typedef GuEnum PgfExprEnum;

PgfPGF*
pgf_read(const char* fpath,
         GuPool* pool, GuExn* err);

/**< Read a grammar from a PGF file.
 *
 * @param from  PGF input stream.
 * The stream must be positioned in the beginning of a binary
 * PGF representation. After a succesful invocation, the stream is
 * still open and positioned at the end of the representation.
 *
 * @param[out] err_out  Raised error.
 * If non-\c NULL, \c *err_out should be \c NULL. Then, upon
 * failure, \c *err_out is set to point to a newly allocated
 * error object, which the caller must free with #g_exn_free
 * or #g_exn_propagate.
 *
 * @return A new PGF object, or \c NULL upon failure. The returned
 * object must later be freed with #pgf_free.
 *
 */


void
pgf_load_meta_child_probs(PgfPGF*, const char* fpath, 
                          GuPool* pool, GuExn* err);

GuString
pgf_abstract_name(PgfPGF*);

void
pgf_iter_languages(PgfPGF*, GuMapItor*, GuExn* err);

PgfConcr*
pgf_get_language(PgfPGF*, PgfCId lang);

GuString
pgf_concrete_name(PgfConcr*);

void
pgf_iter_categories(PgfPGF* pgf, GuMapItor* fn, GuExn* err);

PgfCId
pgf_start_cat(PgfPGF* pgf, GuPool* pool);

void
pgf_iter_functions(PgfPGF* pgf, GuMapItor* fn, GuExn* err);

void
pgf_iter_functions_by_cat(PgfPGF* pgf, PgfCId catname,
                          GuMapItor* fn, GuExn* err);

PgfType*
pgf_function_type(PgfPGF* pgf, PgfCId funname);

GuString
pgf_print_name(PgfConcr*, PgfCId id);

void
pgf_linearize(PgfConcr* concr, PgfExpr expr, GuWriter* wtr, GuExn* err);

PgfExprEnum*
pgf_parse(PgfConcr* concr, PgfCId cat, PgfLexer *lexer, 
          GuPool* pool, GuPool* out_pool);

PgfExprEnum*
pgf_parse_with_heuristics(PgfConcr* concr, PgfCId cat, PgfLexer *lexer, 
                          double heuristics, 
                          GuPool* pool, GuPool* out_pool);

GuEnum*
pgf_complete(PgfConcr* concr, PgfCId cat, PgfLexer *lexer, 
             GuString prefix, GuPool* pool);

bool
pgf_parseval(PgfConcr* concr, PgfExpr expr, PgfCId cat, 
             double *precision, double *recall, double *exact);
                    
PgfExprEnum*
pgf_generate_all(PgfPGF* pgf, PgfCId cat, GuPool* pool);

/// @}

void
pgf_print(PgfPGF* pgf, GuWriter* wtr, GuExn* err); 

#endif // PGF_H_
