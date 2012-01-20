
#include <gu/type.h>
#include <gu/assert.h>
#include <gu/map.h>

GuKind GU_TYPE_IDENT(type)[1] = {{ .super = NULL }};

GU_DEFINE_KIND(alias, type);
GU_DEFINE_KIND(typedef, alias);
GU_DEFINE_KIND(referenced, alias);

GU_DEFINE_KIND(repr, type);
GU_DEFINE_KIND(GuOpaque, repr);

GU_DEFINE_KIND(abstract, type);

GU_DEFINE_KIND(struct, repr);

GU_DEFINE_KIND(pointer, repr);
GU_DEFINE_KIND(reference, pointer);
GU_DEFINE_KIND(shared, pointer);

GU_DEFINE_KIND(primitive, repr);

// sizeof(void) is illegal, so do this manually
GuPrimType GU_TYPE_IDENT(void)[1] = {{
	.repr_base = {
		.type_base = {
			.kind_base = {
				.super = gu_kind(primitive),
			},
		},
		.size = 0,
		.align = 1,
	},
	.name = "void",
}};

GU_DEFINE_KIND(integer, primitive);
GU_DEFINE_TYPE(char, integer, _);

GU_DEFINE_KIND(signed, integer);
GU_DEFINE_TYPE(int, signed, _);
GU_DEFINE_TYPE(int8_t, signed, _);
GU_DEFINE_TYPE(int16_t, signed, _);
GU_DEFINE_TYPE(int32_t, signed, _);
GU_DEFINE_TYPE(int64_t, signed, _);
GU_DEFINE_TYPE(intptr_t, signed, _);
GU_DEFINE_TYPE(intmax_t, signed, _);

GU_DEFINE_KIND(unsigned, integer);
GU_DEFINE_TYPE(uint8_t, unsigned, _);
GU_DEFINE_TYPE(uint16_t, unsigned, _);
GU_DEFINE_TYPE(uint32_t, unsigned, _);
GU_DEFINE_TYPE(uint64_t, unsigned, _);
GU_DEFINE_TYPE(uintmax_t, unsigned, _);
GU_DEFINE_TYPE(size_t, unsigned, _);

GU_DEFINE_TYPE(GuLength, unsigned, _);

GU_DEFINE_KIND(GuFloating, primitive);
GU_DEFINE_TYPE(float, GuFloating, _);
GU_DEFINE_TYPE(double, GuFloating, _);
GU_DEFINE_TYPE(GuLongDouble, GuFloating, _);


GU_DEFINE_KIND(enum, repr);

bool gu_type_has_kind(GuType* type, GuKind* kind)
{
	GuKind* k = (GuKind*)type;
	while (k != NULL) {
		if (k == kind) {
			return true;
		}
		k = k->super;
	}
	return false;
}


struct GuTypeMap {
	GuMap* map;
};

static void
gu_type_map_init(GuTypeMap* tmap, GuTypeTable* table) 
{
	for (int i = 0; i < table->parents.len; i++) {
		gu_type_map_init(tmap, table->parents.elems[i]);
	}
	for (int i = 0; i < table->entries.len; i++) {
		GuTypeTableEntry* e = &table->entries.elems[i];
		gu_map_put(tmap->map, e->kind, void*, e->val);
	}
}

GuTypeMap*
gu_new_type_map(GuTypeTable* table, GuPool* pool)
{
	GuTypeMap* tmap =
		gu_new_i(pool, GuTypeMap,
			 .map = gu_new_map(GuKind, NULL, void*, &gu_null, pool));
	gu_type_map_init(tmap, table);
	return tmap;
}

bool
gu_struct_has_flex(GuStructRepr* srepr)
{
	for (int i = 0; i < srepr->members.len; i++) {
		if (srepr->members.elems[i].is_flex) {
			return true;
		}
	}
	return false;
}

void*
gu_type_map_get(GuTypeMap* tmap, GuType* type)
{
	GuKind* kind = (GuKind*)type;
	while (kind != NULL) {
		void* val = gu_map_get(tmap->map, kind, void*);
		if (val != NULL) {
			return val;
		}
		kind = kind->super;
	}
	return NULL;
}

const void*
gu_type_dyn_cast(GuType* type, GuKind* kind)
{
	if (gu_type_has_kind(type, kind)) {
		return type;
	}
	return NULL;
}


const void* 
gu_type_check_cast(GuType* type, GuKind* kind)
{
	gu_assert(gu_type_has_kind(type, kind));
	return type;
}

GuTypeRepr*
gu_type_repr(GuType* type) 
{
	GuTypeAlias* alias;
	while ((alias = gu_type_try_cast(type, alias))) {
		type = alias->type;
	}
	return gu_type_try_cast(type, repr);
}

size_t
gu_type_size(GuType* type)
{
	GuTypeRepr* repr = gu_type_repr(type);
	return repr ? repr->size : 0;
}

GuEnumConstant*
gu_enum_value(GuEnumType* etype, const void* enump)
{
	size_t esize = etype->repr_base.size;
#define CHECK_ENUM_TYPE(t_) do {					\
		if (esize == sizeof(t_)) {				\
			t_ c = *(const t_*)enump;			\
			for (int i = 0; i < etype->constants.len; i++) { \
				GuEnumConstant* cp = &etype->constants.elems[i]; \
				t_ d = *(const t_*)cp->enum_value;	\
				if (c == d) {				\
					return cp;			\
				}					\
			}						\
			return NULL;					\
		}							\
	} while (false)

	CHECK_ENUM_TYPE(int);
	CHECK_ENUM_TYPE(char);
	CHECK_ENUM_TYPE(short);
	CHECK_ENUM_TYPE(long);
	CHECK_ENUM_TYPE(long long);

	return NULL;
}

void*
gu_type_malloc(GuType* type, GuPool* pool)
{
	GuTypeRepr* repr = gu_type_repr(type);
	gu_assert(repr);
	return gu_malloc_aligned(pool, repr->size, repr->align);
}

#if 0

typedef const struct GuPtrConvFns GuPtrConvFns;

struct GuPtrConvFns {
	void* (*get)(const void* pp);
	void (*set)(void** pp, void* p);
};

#define GU_TYPE_PTR_DEFINE_GETSET(name_, t_)				\
	static void* gu_type_##name_##_ptr_get(const void* pp) {	\
		return *(t_* const*) pp;				\
	}								\
									\
	static void gu_type_##name_##_ptr_set(void* pp, void* p) {	\
		*(t_**) pp = p;						\
	}								\
	static GuPtrConvFns gu_ptr_conv_##name_ = {			\
		.get = gu_type_##name_##_ptr_get,			\
		.set = gu_type_##name_##_ptr_set			\
	}

GU_TYPE_PTR_DEFINE_GETSET(void, void);
GU_TYPE_PTR_DEFINE_GETSET(struct, GuStruct);
GU_TYPE_PTR_DEFINE_GETSET(int, int);


#endif
