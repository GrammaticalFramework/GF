#include <gu/dump.h>
#include <gu/list.h>
#include <gu/variant.h>
#include <gu/seq.h>
#include <gu/assert.h>
#include <gu/str.h>
#include <gu/file.h>

GuDump*
gu_new_dump(GuWriter* wtr, GuTypeTable* dumpers, GuExn* err, GuPool* pool)
{
	GuDump* ctx = gu_new(GuDump, pool);
	ctx->pool = pool;
	if (dumpers == NULL) {
		dumpers = &gu_dump_table;
	}
	ctx->dumpers = gu_new_type_map(dumpers, pool);
	ctx->yaml = gu_new_yaml(wtr, err, pool);
	ctx->data = gu_new_addr_map(void, void*, &gu_null, pool);
	ctx->print_address = false;
	return ctx;
}

void
gu_dump(GuType* type, const void* value, GuDump* ctx)
{
	GuDumpFn* dumper = gu_type_map_get(ctx->dumpers, type);
	if (ctx->print_address) {
		GuPool* pool = gu_new_pool();
		GuString s = gu_format_string(pool, "%p", value);
		gu_yaml_comment(ctx->yaml, s);
		gu_pool_free(pool);
	}
	(*dumper)(dumper, type, value, ctx);
}

void
gu_dump_stderr(GuType* type, const void* value, GuExn* err)
{
	GuPool* pool = gu_new_pool();
	GuOut* out = gu_file_out(stderr, pool);
#if 0
	GuWriter* wtr = gu_locale_writer(out, pool);
#else
	GuWriter* wtr = gu_new_utf8_writer(out, pool);
#endif
	GuDump* ctx = gu_new_dump(wtr, NULL, err, pool);
	gu_dump(type, value, ctx);
	gu_pool_free(pool);
}

static void
gu_dump_scalar(GuDump* ctx, const char* fmt, ...)
{
	GuPool* tmp_pool = gu_local_pool();
	va_list args;
	va_start(args, fmt);
	GuString s = gu_format_string_v(fmt, args, tmp_pool);
	va_end(args);
	gu_yaml_scalar(ctx->yaml, s);
	gu_pool_free(tmp_pool);
}

static void
gu_dump_str_scalar(GuDump* ctx, const char* str)
{
	GuPool* tmp_pool = gu_local_pool();
	GuString s = gu_str_string(str, tmp_pool);
	gu_yaml_scalar(ctx->yaml, s);
	gu_pool_free(tmp_pool);
}

static void
gu_dump_null(GuDump* ctx)
{
	gu_yaml_tag_secondary(ctx->yaml, "null");
	gu_yaml_scalar(ctx->yaml, gu_empty_string);
}

static void 
gu_dump_int(GuDumpFn* dumper, GuType* type, const void* p, 
	    GuDump* ctx)
{
	(void) dumper;
	(void) type;
	const int* ip = p;
	gu_dump_scalar(ctx, "%d", *ip);
}

static void 
gu_dump_uint16(GuDumpFn* dumper, GuType* type, const void* p, 
	       GuDump* ctx)
{
	(void) dumper;
	(void) type;
	const uint16_t* ip = p;
	gu_dump_scalar(ctx, "%" PRIu16, *ip);
}

static void 
gu_dump_size(GuDumpFn* dumper, GuType* type, const void* p, 
	     GuDump* ctx)
{
	(void) (dumper && type);
	const size_t* zp = p;
	gu_dump_scalar(ctx, "%zu", *zp);
}



static void 
gu_dump_double(GuDumpFn* dumper, GuType* type, const void* p, 
	       GuDump* ctx)
{
	(void) dumper;
	(void) type;
	const double* dp = p;
	gu_dump_scalar(ctx, "%lf", *dp);
}

static const char gu_dump_length_key[] = "gu_dump_length_key";

static void 
gu_dump_length(GuDumpFn* dumper, GuType* type, const void* p, 
	       GuDump* ctx)
{
	(void) dumper;
	(void) type;
	const GuLength* ip = p;
	gu_dump_scalar(ctx, "%d", *ip);
	GuLength* lenp = gu_map_get(ctx->data, gu_dump_length_key, void*);
	if (lenp != NULL) {
		*lenp = *ip;
	}
}

static void 
gu_dump_str(GuDumpFn* dumper, GuType* type, const void* p, 
	    GuDump* ctx)
{
	(void) dumper;
	(void) type;
	const GuStr* sp = p;
	gu_dump_str_scalar(ctx, *sp);
}

static void 
gu_dump_string(GuDumpFn* dumper, GuType* type, const void* p, 
	       GuDump* ctx)
{
	(void) dumper;
	(void) type;
	const GuString* sp = p;
	gu_yaml_scalar(ctx->yaml, *sp);
}


// For _non-shared_ pointers.
static void 
gu_dump_pointer(GuDumpFn* dumper, GuType* type, const void* p, 
		GuDump* ctx)
{
	(void) dumper;
	GuPointerType* ptype = (GuPointerType*) type;
	void* const* pp = p;
	if (*pp == NULL) {
		gu_dump_null(ctx);
	} else {
		gu_dump(ptype->pointed_type, *pp, ctx);
	}
}

typedef struct {
	GuMapItor itor;
	GuMapType* mtype;
	GuDump* ctx;
} GuDumpMapFn;

static void
gu_dump_map_itor(GuMapItor* self, const void* key, void* value, GuExn* err)
{
	(void) err;
	GuDumpMapFn* clo = (GuDumpMapFn*) self;
	gu_dump(clo->mtype->key_type, key, clo->ctx);
	gu_dump(clo->mtype->value_type, value, clo->ctx);
}

static void
gu_dump_map(GuDumpFn* dumper, GuType* type, const void* p,
	    GuDump* ctx)
{
	(void) dumper;
	GuMapType* mtype = (GuMapType*) type;
	GuMap* map = (GuMap*) p;
	gu_yaml_begin_mapping(ctx->yaml);
	GuDumpMapFn clo = { { gu_dump_map_itor }, mtype, ctx };
	gu_map_iter(map, &clo.itor, NULL);
	gu_yaml_end(ctx->yaml);
}


static void
gu_dump_struct(GuDumpFn* dumper, GuType* type, const void* p,
	       GuDump* ctx)
{
	(void) dumper;
	GuStructRepr* srepr = (GuStructRepr*) type;
	gu_yaml_begin_mapping(ctx->yaml);
	const uint8_t* data = p;
	GuLength* old_lenp = gu_map_get(ctx->data, gu_dump_length_key, void*);
	GuLength len = (GuLength)-1;
	gu_map_put(ctx->data, gu_dump_length_key, void*, &len);

	for (int i = 0; i < srepr->members.len; i++) {
		const GuMember* member = &srepr->members.elems[i];
		gu_dump_str_scalar(ctx, member->name);
		const uint8_t* memp = &data[member->offset];
		if (member->is_flex) {
			// Flexible array member
			gu_assert(len != (GuLength)-1);
			size_t mem_s = gu_type_size(member->type);
			gu_yaml_begin_sequence(ctx->yaml);
			for (GuLength i = 0; i < len; i++) {
				gu_dump(member->type, &memp[i * mem_s], ctx);
			}
			gu_yaml_end(ctx->yaml);
		} else {
			gu_dump(member->type, memp, ctx);
		}
	}
	gu_yaml_end(ctx->yaml);
	if (old_lenp) {
		gu_map_set(ctx->data, gu_dump_length_key, void*, old_lenp);
	}
}

static void
gu_dump_alias(GuDumpFn* dumper, GuType* type, const void* p,
	      GuDump* ctx)
{
	(void) dumper;
	GuTypeAlias* alias = gu_type_cast(type, alias);

	gu_dump(alias->type, p, ctx);
}

static const char gu_dump_reference_key[] = "reference";

static bool
gu_dump_anchor(GuDump* ctx, const void* p) 
{
	GuMap* map = gu_map_get(ctx->data, gu_dump_reference_key, void*);
	if (map == NULL) {
		map = gu_new_addr_map(void, GuYamlAnchor,
				      &gu_yaml_null_anchor, ctx->pool);
		gu_map_put(ctx->data, gu_dump_reference_key, void*, map);
	}
	GuYamlAnchor a = gu_map_get(map, p, GuYamlAnchor);
	if (a == gu_yaml_null_anchor) {
		a = gu_yaml_anchor(ctx->yaml);
		gu_map_put(map, p, GuYamlAnchor, a);
		return true;
	} else {
		gu_yaml_alias(ctx->yaml, a);
		return false;
	}
}

static void
gu_dump_referenced(GuDumpFn* dumper, GuType* type, const void* p,
		   GuDump* ctx)
{
	(void) dumper;
	GuTypeAlias* alias = gu_type_cast(type, alias);
	bool created = gu_dump_anchor(ctx, p);
	if (created) {
		gu_dump(alias->type, p, ctx);
	} else {
		// gu_assert(false);
	}
}

static void 
gu_dump_reference(GuDumpFn* dumper, GuType* type, const void* p, 
		  GuDump* ctx)
{
	(void) dumper;
	(void) type;
	void* const* pp = p;
	bool created = gu_dump_anchor(ctx, *pp);
	if (created) {
		// gu_assert(false);
		GuPointerType* ptype = (GuPointerType*) type;
		gu_dump(ptype->pointed_type, *pp, ctx);
	}
}

static void 
gu_dump_shared(GuDumpFn* dumper, GuType* type, const void* p, 
		  GuDump* ctx)
{
	(void) dumper;
	void* const* pp = p;
	if (*pp == NULL) {
		gu_dump_null(ctx);
	} else {
		bool created = gu_dump_anchor(ctx, *pp);
		if (created) {
			GuPointerType* ptype = (GuPointerType*) type;
			gu_dump(ptype->pointed_type, *pp, ctx);
		}
	}
}

static void 
gu_dump_list(GuDumpFn* dumper, GuType* type, const void* p, 
	     GuDump* ctx)
{
	(void) dumper;
	GuListType* ltype = (GuListType*) type;
	const uint8_t* up = p;
	int len = * (const int*) p;
	size_t elem_size = gu_type_size(ltype->elem_type);
	gu_yaml_begin_sequence(ctx->yaml);
	for (int i = 0; i < len; i++) {
		ptrdiff_t offset = ltype->elems_offset + i * elem_size;
		gu_dump(ltype->elem_type, &up[offset], ctx);
	}
	gu_yaml_end(ctx->yaml);
}

static void
gu_dump_variant(GuDumpFn* dumper, GuType* type, const void* p,
		GuDump* ctx)
{
	(void) dumper;
	GuVariantType* vtype = gu_type_cast(type, GuVariant);
	const GuVariant* vp = p;
	int tag = gu_variant_tag(*vp);
	for (int i = 0; i < vtype->ctors.len; i++) {
		GuConstructor* ctor = &vtype->ctors.elems[i];
		if (ctor->c_tag == tag) {
			gu_yaml_begin_mapping(ctx->yaml);
			gu_dump_str_scalar(ctx, ctor->c_name);
			void* data = gu_variant_data(*vp);
			gu_dump(ctor->type, data, ctx);
			gu_yaml_end(ctx->yaml);
			return;
		}
	}
	gu_assert(false);
}


static void
gu_dump_enum(GuDumpFn* dumper, GuType* type, const void* p,
	     GuDump* ctx)
{
	(void) dumper;
	GuEnumType* etype = gu_type_cast(type, enum);
	GuEnumConstant* cp = gu_enum_value(etype, p);
	gu_assert(cp != NULL);
	gu_dump_str_scalar(ctx, cp->name);
}

static void
gu_dump_seq(GuDumpFn* dumper, GuType* type, const void* p,
	    GuDump* ctx)
{
	(void) dumper;
	GuSeqType* dtype = gu_type_cast(type, GuSeq);
	size_t elem_size = gu_type_size(dtype->elem_type);
	const GuSeq* seqp = p;
	GuSeq seq = *seqp;
	if (gu_seq_is_null(seq)) {
		gu_dump_null(ctx);
		return;
	}
	size_t len = gu_seq_length(seq);
	const uint8_t* data = gu_seq_data(seq);
	gu_yaml_begin_sequence(ctx->yaml);
	for (size_t i = 0; i < len; i++) {
		const void* elemp = &data[i * elem_size];
		gu_dump(dtype->elem_type, elemp, ctx);
	}
	gu_yaml_end(ctx->yaml);
}


GuTypeTable
gu_dump_table = GU_TYPETABLE(
	GU_SLIST_0,
	{ gu_kind(int), gu_fn(gu_dump_int) },
	{ gu_kind(uint16_t), gu_fn(gu_dump_uint16) },
	{ gu_kind(size_t), gu_fn(gu_dump_size) },
	{ gu_kind(GuStr), gu_fn(gu_dump_str) },
	{ gu_kind(GuString), gu_fn(gu_dump_string) },
	{ gu_kind(struct), gu_fn(gu_dump_struct) },
	{ gu_kind(pointer), gu_fn(gu_dump_pointer) },
	{ gu_kind(GuMap), gu_fn(gu_dump_map) },
	{ gu_kind(alias), gu_fn(gu_dump_alias) },
	{ gu_kind(reference), gu_fn(gu_dump_reference) },
	{ gu_kind(referenced), gu_fn(gu_dump_referenced) },
	{ gu_kind(shared), gu_fn(gu_dump_shared) },
	{ gu_kind(GuList), gu_fn(gu_dump_list) },
	{ gu_kind(GuSeq), gu_fn(gu_dump_seq) },
	{ gu_kind(GuLength), gu_fn(gu_dump_length) },
	{ gu_kind(GuVariant), gu_fn(gu_dump_variant) },
	{ gu_kind(double), gu_fn(gu_dump_double) },
	{ gu_kind(enum), gu_fn(gu_dump_enum) },
	);
