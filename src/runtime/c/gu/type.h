 
#ifndef GU_TYPE_H_
#define GU_TYPE_H_

#include <gu/defs.h>

//
// kind
//

typedef const struct GuKind GuKind;

struct GuKind {
	GuKind* super;
};

// Use GU_PASTE here so k_ can be preprocessor-expanded
#define GU_TYPE_IDENT(k_) GU_PASTE(gu_type__,k_)

#define gu_kind(k_) ((GuKind*)GU_TYPE_IDENT(k_))

#define GU_DECLARE_KIND(k_) \
	GuKind GU_TYPE_IDENT(k_)[1]

extern GU_DECLARE_KIND(kind);

#define GU_DEFINE_KIND(k_, super_k_) \
	GuKind GU_TYPE_IDENT(k_)[1] = {{ .super = gu_kind(super_k_) }}

//
// type
//

typedef const struct GuType GuType;

struct GuType {
	GuKind kind_base;
};

typedef GuType GuType_type;

extern GU_DECLARE_KIND(type);

#define GU_TYPE_INIT_type(k_, t_, _) { .kind_base = { .super = gu_kind(k_) } }

#define gu_type(t_) ((GuType*)gu_kind(t_))


#define GU_KIND_TYPE(k_) GU_PASTE(GuType_,k_)

// This cannot be used indirectly, since we don't want to pp-expand k_.
// We must inline the body into other macros.
#define GU_TYPE_INIT(k_, ...)		\
	GU_TYPE_INIT_##k_(k_, __VA_ARGS__)

//#define GU_TYPE_LIT(k_, ...)						
//	((GuType*)(GuType_##k_[]){GU_TYPE_INIT(k_, __VA_ARGS__)})
#define GU_TYPE_LIT(k_, ...)						\
	((GuType*)&(GU_KIND_TYPE(k_)) GU_TYPE_INIT_##k_(k_, __VA_ARGS__))

#define GU_DECLARE_TYPE(t_, k_)	\
	GU_KIND_TYPE(k_) GU_TYPE_IDENT(t_)[1]

//#define GU_DEFINE_TYPE(t_, k_, ...)					
//	GuType_##k_ GU_TYPE_IDENT(t_) = GU_TYPE_INIT(k_, t_, __VA_ARGS__)
#define GU_DEFINE_TYPE(t_, k_, ...)					\
	GU_KIND_TYPE(k_) GU_TYPE_IDENT(t_)[1] =				\
	{ GU_TYPE_INIT_##k_(k_, t_, __VA_ARGS__) }

#define GU_DEFINE_TYPE_ALIAS(t1_, t2_)		\
	static GuType* const GU_TYPE_IDENT(t1_) = gu_type(t2_)


//
// abstract
//

typedef GuType GuType_abstract;

#define GU_TYPE_INIT_abstract(k_, t_, _)		\
	GU_TYPE_INIT_type(k_, t_, _)

extern GU_DECLARE_KIND(abstract);


//
// repr 
//

typedef struct GuTypeRepr GuTypeRepr, GuType_repr;

struct GuTypeRepr {
	GuType type_base;
	uint16_t size;
	uint16_t align;
};

#define GU_TYPE_INIT_repr(k_, t_, _) {				\
		.type_base = GU_TYPE_INIT_type(k_, t_, _),	\
		.size = sizeof(t_), \
		.align = gu_alignof(t_) \
		 }

extern GU_DECLARE_KIND(repr);



//
// GuOpaque
//

typedef GuType_repr GuType_GuOpaque;

#define GU_TYPE_INIT_GuOpaque GU_TYPE_INIT_repr

extern GU_DECLARE_KIND(GuOpaque);

//
// pointer
//

typedef const struct GuPointerType GuPointerType, GuType_pointer;

struct GuPointerType {
	GuType_repr repr_base;
	GuType* pointed_type;
};

#define GU_TYPE_INIT_pointer(k_, t_, pointed_)	\
	{					   \
		.repr_base = GU_TYPE_INIT_repr(k_, t_, _),	\
	.pointed_type = pointed_ \
}	


extern GU_DECLARE_KIND(pointer);

#define gu_ptr_type(t_) \
	GU_TYPE_LIT(pointer, t_*, gu_type(t_))







//
// alias
//


typedef const struct GuTypeAlias GuTypeAlias, GuType_alias;

struct GuTypeAlias {
	GuType type_base;
	GuType* type;
};

#define GU_TYPE_INIT_alias(k_, t_, type_) {			\
	.type_base = GU_TYPE_INIT_type(k_, t_, _),	\
	.type = type_				\
}

extern GU_DECLARE_KIND(alias);

//
// typedef
//

typedef const struct GuTypeDef GuTypeDef, GuType_typedef;

struct GuTypeDef {
        GuType_alias alias_base;
	const char* name;
};

#define GU_TYPE_INIT_typedef(k_, t_, type_) {			\
	.alias_base = GU_TYPE_INIT_alias(k_, t_, type_),	\
	.name = #t_,		\
}

extern GU_DECLARE_KIND(typedef);

#define GU_DEFINE_TYPEDEF_X(t_, dk_, k_, ...)			\
	GU_DEFINE_TYPE(t_, dk_, GU_TYPE_LIT(k_, t_, __VA_ARGS__))

#define GU_DEFINE_TYPEDEF(t_, ...)	\
	GU_DEFINE_TYPEDEF_X(t_, typedef, __VA_ARGS__)



//
// referenced
//

extern GU_DECLARE_KIND(referenced);

typedef GuType_alias GuType_referenced;

#define GU_TYPE_INIT_referenced GU_TYPE_INIT_alias



#include <gu/mem.h>

//
// struct
//

typedef const struct GuStructRepr GuStructRepr, GuType_struct;

typedef const struct GuMember GuMember;

struct GuMember {
	ptrdiff_t offset;
	const char* name;
	GuType* type;
	bool is_flex;
};

struct GuStructRepr {
	GuType_repr repr_base;
	const char* name;
	struct {
		int len;
		GuMember* elems;
	} members;
};

extern GU_DECLARE_KIND(struct);

#define GU_MEMBER_AUX_(struct_, member_, type_, is_flex_)      \
	{					      \
		.offset = offsetof(struct_, member_), \
		.name = #member_,	      \
		.type = type_,		      \
		.is_flex = is_flex_,  \
	}

#define GU_MEMBER_V(struct_, member_, type_) \
	GU_MEMBER_AUX_(struct_, member_, type_, false)

#define GU_MEMBER(s_, m_, t_) \
	GU_MEMBER_V(s_, m_, gu_type(t_))

#define GU_MEMBER_P(s_, m_, t_) \
	GU_MEMBER_V(s_, m_, gu_ptr_type(t_))

#define GU_MEMBER_S(s_, m_, t_) \
	GU_MEMBER_V(s_, m_, gu_shared_ptr_type(t_))

#define GU_FLEX_MEMBER_V(struct_, member_, type_) \
	GU_MEMBER_AUX_(struct_, member_, type_, true)

#define GU_FLEX_MEMBER(s_, m_, t_) \
	GU_FLEX_MEMBER_V(s_, m_, gu_type(t_))

#define GU_FLEX_MEMBER_P(s_, m_, t_) \
	GU_FLEX_MEMBER_V(s_, m_, gu_ptr_type(t_))


#define GU_TYPE_INIT_struct(k_, t_, ...)	{		\
	.repr_base = GU_TYPE_INIT_repr(k_, t_, _),		\
	.name = #t_, \
	.members = {								\
		.len = GU_ARRAY_LEN(GuMember,GU_ID({__VA_ARGS__})),		\
		.elems = ((GuMember[]){__VA_ARGS__})			\
	} \
}

bool
gu_struct_has_flex(GuStructRepr* srepr);


//
// reference
//

typedef GuType_pointer GuType_reference;

#define GU_TYPE_INIT_reference GU_TYPE_INIT_pointer

extern GU_DECLARE_KIND(reference);


//
// shared
//

typedef GuType_pointer GuType_shared;

#define GU_TYPE_INIT_shared GU_TYPE_INIT_pointer

extern GU_DECLARE_KIND(shared);

#define gu_shared_ptr_type(t_) \
	GU_TYPE_LIT(shared, t_*, gu_type(t_))

//
// primitives
//

typedef const struct GuPrimType GuPrimType, GuType_primitive;

struct GuPrimType {
	GuType_repr repr_base;
	const char* name;
};

#define GU_TYPE_INIT_primitive(k_, t_, _) {	\
	.repr_base = GU_TYPE_INIT_repr(k_, t_, _),	\
	.name = #t_			\
}	

extern GU_DECLARE_KIND(primitive);
extern GU_DECLARE_TYPE(void, primitive);

#define GU_TYPE_INIT_integer GU_TYPE_INIT_primitive
typedef GuType_primitive GuType_integer;
extern GU_DECLARE_KIND(integer);
extern GU_DECLARE_TYPE(char, integer);

#define GU_TYPE_INIT_signed GU_TYPE_INIT_integer
typedef GuType_integer GuType_signed;
extern GU_DECLARE_KIND(signed);
extern GU_DECLARE_TYPE(int, signed);
extern GU_DECLARE_TYPE(int8_t, signed);
extern GU_DECLARE_TYPE(int16_t, signed);
extern GU_DECLARE_TYPE(int32_t, signed);
extern GU_DECLARE_TYPE(int64_t, signed);
extern GU_DECLARE_TYPE(intptr_t, signed);
extern GU_DECLARE_TYPE(intmax_t, signed);

#define GU_TYPE_INIT_unsigned GU_TYPE_INIT_integer
typedef GuType_integer GuType_unsigned;
extern GU_DECLARE_KIND(unsigned);
extern GU_DECLARE_TYPE(uint8_t, unsigned);
extern GU_DECLARE_TYPE(uint16_t, unsigned);
extern GU_DECLARE_TYPE(uint32_t, unsigned);
extern GU_DECLARE_TYPE(uint64_t, unsigned);
extern GU_DECLARE_TYPE(uintmax_t, unsigned);
extern GU_DECLARE_TYPE(size_t, unsigned);

typedef size_t GuLength;
extern GU_DECLARE_TYPE(GuLength, unsigned); // TODO: get rid


#define GU_TYPE_INIT_GuFloating GU_TYPE_INIT_primitive
typedef GuType_primitive GuType_GuFloating;
extern GU_DECLARE_KIND(GuFloating);
extern GU_DECLARE_TYPE(float, GuFloating);
extern GU_DECLARE_TYPE(double, GuFloating);
typedef long double GuLongDouble;
extern GU_DECLARE_TYPE(GuLongDouble, GuFloating);



//
// enum
//

extern GU_DECLARE_KIND(enum);

typedef const struct GuEnumConstant GuEnumConstant;

struct GuEnumConstant {
	const char* name;
	int64_t value;
	const void* enum_value;
};

typedef const struct GuEnumType GuEnumType, GuType_enum;

struct GuEnumType {
	GuType_repr repr_base;
	struct {
		int len;
		GuEnumConstant* elems;
	} constants;
};

#define GU_ENUM_C(t_, x) {		\
		.name = #x, \
		.value = x,		\
		.enum_value = (const t_[1]){ x } \
 }

#define GU_TYPE_INIT_enum(k_, t_, ...) { \
	.repr_base = GU_TYPE_INIT_repr(k_, t_, _),	\
	.constants = {								\
		.len = GU_ARRAY_LEN(GuEnumConstant,GU_ID({__VA_ARGS__})),		\
		.elems = ((GuEnumConstant[]){__VA_ARGS__})			\
	} \
}

GuEnumConstant*
gu_enum_value(GuEnumType* etype, const void* enump);




bool gu_type_has_kind(const GuType* type, const GuKind* kind);




typedef const struct GuTypeTableEntry GuTypeTableEntry;

struct GuTypeTableEntry {
	GuKind* kind;
	void* val;
};

typedef const struct GuTypeTable GuTypeTable;

struct GuTypeTable {
	struct {
		int len;
		GuTypeTable** elems;
	} parents;
	struct {
		int len;
		GuTypeTableEntry* elems;
	} entries;
};

#define GU_TYPETABLE(parents_, ...) { \
	.parents = parents_, \
	.entries = {								\
		.len = GU_ARRAY_LEN(GuTypeTableEntry,GU_ID({__VA_ARGS__})),		\
		.elems = ((GuTypeTableEntry[]){__VA_ARGS__})			\
	} \
 }

typedef struct GuTypeMap GuTypeMap;

GuTypeMap*
gu_new_type_map(GuTypeTable* table, GuPool* pool);

void*
gu_type_map_get(GuTypeMap* tmap, GuType* type);

size_t 
gu_type_size(GuType* type);

GuTypeRepr*
gu_type_repr(GuType* type);

const void*
gu_type_check_cast(GuType* t, GuKind* k);

const void*
gu_type_dyn_cast(GuType* t, GuKind* k);

#define gu_type_try_cast(type_, k_) \
	((GU_KIND_TYPE(k_)*)gu_type_dyn_cast(type_, gu_kind(k_)))

#ifndef NDEBUG
#define gu_type_cast(type_, k_) \
	((GU_KIND_TYPE(k_)*)gu_type_check_cast(type_, gu_kind(k_)))
#else
#define gu_type_cast(type_, k_) \
	((GU_KIND_TYPE(k_)*)(type_))
#endif

void* gu_type_malloc(GuType* type, GuPool* pool);

#if 0
void* gu_type_ptr_get(GuType* type, const void* pp);
void gu_type_ptr_set(GuType* type, void* pp, void* p);
#endif


#endif // GU_TYPE_H_
