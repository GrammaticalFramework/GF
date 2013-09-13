/* 
 * Copyright 2011 University of Helsinki.
 *   
 * This file is part of libgu.
 * 
 * Libgu is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 * 
 * Libgu is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
 * License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with libgu. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef GU_STRING_H_
#define GU_STRING_H_

#include <gu/bits.h>
#include <gu/in.h>
#include <gu/out.h>

typedef GuOpaque() GuString;

extern const GuString gu_empty_string;

GuString
gu_string_copy(GuString string, GuPool* pool);

void
gu_string_write(GuString string, GuOut* out, GuExn* err);

GuString
gu_string_read(size_t len, GuPool* pool, GuIn* in, GuExn* err);

GuString
gu_string_read_latin1(size_t len, GuPool* pool, GuIn* in, GuExn* err);

GuIn*
gu_string_in(GuString string, GuPool* pool);

bool
gu_string_is_stable(GuString string);

GuString
gu_ucs_string(const GuUCS* ubuf, size_t len, GuPool* pool);

typedef struct GuStringBuf GuStringBuf;

GuStringBuf*
gu_string_buf(GuPool* pool);

GuOut*
gu_string_buf_out(GuStringBuf* sb);

GuString
gu_string_buf_freeze(GuStringBuf* sb, GuPool* pool);

GuString
gu_format_string_v(const char* fmt, va_list args, GuPool* pool);

GuString
gu_format_string(GuPool* pool, const char* fmt, ...);

GuString
gu_str_string(const char* str, GuPool* pool);

bool
gu_string_to_int(GuString s, int *res);

bool
gu_string_to_double(GuString s, double *res);


bool
gu_string_is_prefix(GuString s1, GuString s2);

#endif // GU_STRING_H_

#if defined(GU_HASH_H_) && !defined(GU_STRING_H_HASH_)
#define GU_STRING_H_HASH_

GuHash
gu_string_hash(GuHash h, GuString s);

extern GuHasher gu_string_hasher[1];

bool
gu_string_eq(GuString s1, GuString s2);

int
gu_string_cmp(GuString s1, GuString s2);
#endif

#ifdef GU_TYPE_H_
# ifndef GU_STRING_H_TYPE_
#  define GU_STRING_H_TYPE_

extern GU_DECLARE_TYPE(GuString, GuOpaque);
# endif

# if defined(GU_SEQ_H_) && !defined(GU_STRING_H_SEQ_TYPE_)
#  define GU_STRING_H_SEQ_TYPE_
extern GU_DECLARE_TYPE(GuStrings, GuSeq);
# endif

# if defined(GU_MAP_H_TYPE_) && !defined(GU_STRING_H_MAP_TYPE_)
#  define GU_STRING_H_MAP_TYPE_

extern GU_DECLARE_KIND(GuStringMap);
typedef GuType_GuMap GuType_GuStringMap;

#define GU_TYPE_INIT_GuStringMap(KIND, MAP_T, VAL_T, DEFAULT)	\
	GU_TYPE_INIT_GuMap(KIND, MAP_T,				\
			   gu_type(GuString), gu_string_hasher,	\
			   VAL_T, DEFAULT)

# endif
#endif


#if defined(GU_SEQ_H_) && !defined(GU_STRING_H_SEQ_)
#define GU_STRING_H_SEQ_

typedef GuSeq GuStrings;
// typedef GuBuf GuStringBuf;

#endif


#if defined(GU_MAP_H_) && !defined(GU_STRING_H_MAP_)
#define GU_STRING_H_MAP_

typedef GuMap GuStringMap;

#define gu_new_string_map(VAL_T, DEFAULT, POOL)				\
	gu_new_map(GuString, gu_string_hasher, VAL_T, (DEFAULT), (POOL))

#endif

