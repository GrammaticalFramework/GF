#include "variant.h"
#include "bits.h"

enum {
	GU_VARIANT_ALIGNMENT = sizeof(uintptr_t)
};

GU_API void*
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

GU_API GuVariant 
gu_make_variant(uint8_t tag, size_t size, size_t align, const void* init,
		GuPool* pool)
{
	GuVariant v;
	void* data = gu_alloc_variant(tag, size, align, &v, pool);
	memcpy(data, init, size);
	return v;
}

GU_API int
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

GU_API void*
gu_variant_data(GuVariant variant)
{
	if (gu_variant_is_null(variant)) {
		return NULL;
	}
	return (void*)gu_align_backward(variant, GU_VARIANT_ALIGNMENT);
}

GU_API GuVariantInfo
gu_variant_open(GuVariant variant)
{
	GuVariantInfo info = {
		.tag = gu_variant_tag(variant),
		.data = gu_variant_data(variant)
	};
	return info;
}

GU_API GuVariant
gu_variant_close(GuVariantInfo info)
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

GU_API int 
gu_variant_intval(GuVariant variant)
{
	int u = variant % GU_VARIANT_ALIGNMENT;
	if (u == 0) {
		int* mem = (int*)variant;
		return *mem;
	}
	return (variant / GU_VARIANT_ALIGNMENT);
}

GU_API const GuVariant gu_null_variant = { (GuWord) NULL };
