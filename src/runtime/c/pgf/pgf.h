/* 
 * Copyright 2010 University of Helsinki.
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
#include <gu/in.h>
#include <gu/string.h>


typedef GuString PgfCId;
extern GU_DECLARE_TYPE(PgfCId, typedef);


/// A single lexical token			      
typedef GuString PgfToken;			      

/// @name PGF Grammar objects
/// @{

typedef struct PgfPGF PgfPGF;

/**< A representation of a PGF grammar. 
 */


PgfPGF*
pgf_read(GuIn* in, GuPool* pool, GuExn* err); 

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


#include <gu/type.h>
extern GU_DECLARE_TYPE(PgfPGF, struct);

/// @}

void
pgf_print(PgfPGF* pgf, GuWriter* wtr, GuExn* err); 

#endif // PGF_H_
