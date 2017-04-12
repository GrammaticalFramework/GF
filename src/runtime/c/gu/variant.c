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

#include "variant.h"
#include "bits.h"

enum {
	GU_VARIANT_ALIGNMENT = sizeof(uintptr_t)
};

void* 
gu_alloc_variant(uint8_t tag, size_t size, 
		 size_t align, GuVariant* variant_out, GuPool* pool)
{
	align = gu_max(align, GU_VARIANT_ALIGNMENT);
	if (((size_t)tag) > GU_VARIANT_ALIGNMENT - 2) {
		uint8_t* alloc = gu_malloc_aligned(pool, align + size, align);
		alloc[align - 1] = tag;
		void* p = &alloc[align];
		*variant_out = (uintptr_t)p;
		return p;
	}
	void* p = gu_malloc_aligned(pool, size, align);
	*variant_out = ((uintptr_t)p) | (tag + 1);
	return p;
}

GuVariant 
gu_make_variant(uint8_t tag, size_t size, size_t align, const void* init,
		GuPool* pool)
{
	GuVariant v;
	void* data = gu_alloc_variant(tag, size, align, &v, pool);
	memcpy(data, init, size);
	return v;
}

int
gu_variant_tag(GuVariant variant)
{
	if (gu_variant_is_null(variant)) {
		return GU_VARIANT_NULL;
	}
	int u = variant % GU_VARIANT_ALIGNMENT;
	if (u == 0) {
		uint8_t* mem = (uint8_t*)variant;
		return mem[-1];
	}
	return u - 1;
}

void*
gu_variant_data(GuVariant variant)
{
	if (gu_variant_is_null(variant)) {
		return NULL;
	}
	return (void*)gu_align_backward(variant, GU_VARIANT_ALIGNMENT);
}

GuVariantInfo gu_variant_open(GuVariant variant)
{
	GuVariantInfo info = {
		.tag = gu_variant_tag(variant),
		.data = gu_variant_data(variant)
	};
	return info;
}

GuVariant gu_variant_close(GuVariantInfo info)
{
	GuVariant variant;

	if (((size_t)info.tag) > GU_VARIANT_ALIGNMENT - 2) {
		variant = (uintptr_t)info.data;
		assert(gu_variant_tag(variant) == info.tag);
	} else {
		variant = ((uintptr_t)info.data) | (info.tag + 1);
	}

	return variant;
}

int 
gu_variant_intval(GuVariant variant)
{
	int u = variant % GU_VARIANT_ALIGNMENT;
	if (u == 0) {
		int* mem = (int*)variant;
		return *mem;
	}
	return (variant / GU_VARIANT_ALIGNMENT);
}

GU_API_DATA const GuVariant gu_null_variant = { (GuWord) NULL };
