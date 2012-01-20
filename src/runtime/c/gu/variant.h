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
#include <gu/type.h>

/** @name Variants
 * @{
 */

typedef struct GuVariant GuVariant;


void* gu_alloc_variant(uint8_t tag, 
		       size_t size, size_t align, 
		       GuVariant* variant_out, GuPool* pool);

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

int gu_variant_tag(GuVariant variant);

void* gu_variant_data(GuVariant variant);


typedef struct GuVariantInfo GuVariantInfo;

struct GuVariantInfo {
	int tag;
	void* data;
};

GuVariantInfo gu_variant_open(GuVariant variant);

/** @privatesection */
struct GuVariant {
	uintptr_t p;
	/**< @private */
};

/** @} */

static inline void*
gu_variant_to_ptr(GuVariant variant)
{
	return (void*)variant.p;
}

static inline GuVariant
gu_variant_from_ptr(const void* p)
{
	GuVariant v = { (uintptr_t)p };
	return v;
}

extern const GuVariant gu_null_variant;

static inline bool
gu_variant_is_null(GuVariant v) {
	return ((void*)v.p == NULL);
}


// variant

typedef const struct GuConstructor GuConstructor;

struct GuConstructor {
	int c_tag;
	const char* c_name;
	const GuType* type;
};

#define GU_CONSTRUCTOR_V(ctag, c_type) {		\
		.c_tag = ctag,	 \
		.c_name = #ctag, \
		.type = c_type \
}

#define GU_CONSTRUCTOR(ctag, t_) \
	GU_CONSTRUCTOR_V(ctag, gu_type(t_))

#define GU_CONSTRUCTOR_P(ctag, t_) \
	GU_CONSTRUCTOR_V(ctag, gu_ptr_type(t_))

#define GU_CONSTRUCTOR_S(ctag, t_, ...)		\
	GU_CONSTRUCTOR_V(ctag, GU_TYPE_LIT(struct, t_, __VA_ARGS__))

#define GU_CONSTRUCTOR_S1(ctag, t_, mem1_, type1_)			\
	GU_CONSTRUCTOR_S(ctag, t_,					\
			 GU_MEMBER(t_, mem1_, type1_))

#define GU_CONSTRUCTOR_S2(ctag, t_, mem1_, type1_, mem2_, type2_)	\
	GU_CONSTRUCTOR_S(ctag, t_,					\
			 GU_MEMBER(t_, mem1_, type1_),			\
			 GU_MEMBER(t_, mem2_, type2_))



typedef GuSList(GuConstructor) GuConstructors;

typedef const struct GuVariantType GuVariantType, GuType_GuVariant;

struct GuVariantType {
	GuType_repr repr_base;
	GuConstructors ctors;
};

#define GU_TYPE_INIT_GuVariant(k_, t_, ...) {			\
	.repr_base = GU_TYPE_INIT_repr(k_, GuVariant, _),	\
	.ctors = GU_SLIST(GuConstructor, __VA_ARGS__) \
}

extern GU_DECLARE_KIND(GuVariant);

#endif // GU_VARIANT_H_
