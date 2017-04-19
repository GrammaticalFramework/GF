/* 
 * Copyright 2010 University of Helsinki.
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

/** @file
 *
 * Lightweight tagged data.    
 */

#ifndef GU_VARIANT_H_
#define GU_VARIANT_H_

#include <gu/defs.h>
#include <gu/mem.h>

/** @name Variants
 * @{
 */

typedef uintptr_t GuVariant;


GU_API_DECL
void* gu_alloc_variant(uint8_t tag, 
		       size_t size, size_t align, 
		       GuVariant* variant_out, GuPool* pool);

GU_API_DECL
GuVariant gu_make_variant(uint8_t tag, 
			  size_t size, size_t align, 
			  const void* init, GuPool* pool);

#define gu_new_variant(tag, type, variant_out, pool)	    \
	((type*)gu_alloc_variant(tag, sizeof(type), \
				 gu_alignof(type), variant_out, pool))

/**< 
 * @hideinitializer */

#define gu_new_variant_i(POOL, TAG, T, ...)				\
	gu_make_variant(TAG, sizeof(T), gu_alignof(T),			\
			&(T){ __VA_ARGS__ }, POOL)



#define gu_new_flex_variant(tag, type, flex_mem, n_elems, variant_out, pool)	\
	((type*)gu_alloc_variant(tag,				\
				 GU_FLEX_SIZE(type, flex_mem, n_elems), \
				 gu_flex_alignof(type),			\
				 variant_out, pool))
/**< 
 * @hideinitializer */

enum {
	GU_VARIANT_NULL = -1
};

GU_API_DECL
int gu_variant_tag(GuVariant variant);

GU_API_DECL
void* gu_variant_data(GuVariant variant);


typedef struct GuVariantInfo GuVariantInfo;

struct GuVariantInfo {
	int tag;
	void* data;
};

GU_API_DECL GuVariantInfo gu_variant_open(GuVariant variant);
GU_API_DECL GuVariant gu_variant_close(GuVariantInfo info);

/** @} */

static inline void*
gu_variant_to_ptr(GuVariant variant)
{
	return (void*) variant;
}

static inline GuVariant
gu_variant_from_ptr(const void* p)
{
	return (uintptr_t) p;
}

GU_API_DECL extern const GuVariant gu_null_variant;

static inline bool
gu_variant_is_null(GuVariant v) {
	return ((void*)v == NULL);
}

#endif // GU_VARIANT_H_
