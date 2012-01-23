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

#include "data.h"
#include "expr.h"
#include <gu/defs.h>
#include <gu/map.h>
#include <gu/seq.h>
#include <gu/assert.h>
#include <gu/intern.h>
#include <gu/in.h>
#include <gu/bits.h>
#include <gu/exn.h>
#include <gu/utf8.h>

#define GU_LOG_ENABLE
#include <gu/log.h>

typedef struct PgfIdContext PgfIdContext;

//
// PgfReader
// 

typedef struct PgfReader PgfReader;

struct PgfReader {
	GuIn* in;
	GuExn* err;
	GuPool* opool;
	GuSymTable* symtab;
	PgfSequences* curr_sequences;
	PgfCncFuns* curr_cncfuns;
	GuMap* curr_ccats;
	GuMap* curr_lindefs;
	GuMap* curr_coercions;
	GuTypeMap* read_to_map;
	GuTypeMap* read_new_map;
	void* curr_key;
};

typedef struct PgfReadTagExn PgfReadTagExn;

struct PgfReadTagExn {
	GuType* type;
	int tag;
};

static GU_DEFINE_TYPE(PgfReadTagExn, abstract, _);

static GU_DEFINE_TYPE(PgfReadExn, abstract, _);

static uint8_t
pgf_read_u8(PgfReader* rdr)
{
	uint8_t u = gu_in_u8(rdr->in, rdr->err);
	gu_debug("u8: %u", u);
	return u;
}

static uint32_t
pgf_read_uint(PgfReader* rdr)
{
	uint32_t u = 0;
	int shift = 0;
	uint8_t b = 0;
	do {
		b = pgf_read_u8(rdr);
		gu_return_on_exn(rdr->err, 0);
		u |= (b & ~0x80) << shift;
		shift += 7;
	} while (b & 0x80);
	gu_debug("uint: %u", u);
	return u;
}

static int32_t
pgf_read_int(PgfReader* rdr)
{
	uint32_t u = pgf_read_uint(rdr);
	return gu_decode_2c32(u, rdr->err);
}

static GuLength
pgf_read_len(PgfReader* rdr)
{
	int32_t len = pgf_read_int(rdr);
	// It's crucial that we return 0 on failure, so the
	// caller can proceed without checking for error
	// immediately.
	gu_return_on_exn(rdr->err, 0);
	if (len < 0) {
		gu_raise_i(rdr->err, PgfReadTagExn,
			   .type = gu_type(GuLength), .tag = len);
		return 0;
	}
	return (GuLength) len;
}

typedef const struct PgfReadToFn PgfReadToFn;

struct PgfReadToFn {
	void (*fn)(GuType* type, PgfReader* rdr, void* to);
};

static void 
pgf_read_to(PgfReader* rdr, GuType* type, void* to) {
	PgfReadToFn* fn = gu_type_map_get(rdr->read_to_map, type);
	fn->fn(type, rdr, to);
}

typedef const struct PgfReadNewFn PgfReadNewFn;
struct PgfReadNewFn {
	void* (*fn)(GuType* type, PgfReader* rdr, GuPool* pool, 
		    size_t* size_out);
};

static void*
pgf_read_new(PgfReader* rdr, GuType* type, GuPool* pool, size_t* size_out)
{
	size_t size = 0;
	PgfReadNewFn* fn = gu_type_map_get(rdr->read_new_map, type);
	return fn->fn(type, rdr, pool, size_out ? size_out : &size);
}

static void*
pgf_read_new_type(GuType* type, PgfReader* rdr, GuPool* pool, 
		  size_t* size_out)
{
	GuTypeRepr* repr = gu_type_repr(type);
	void* to = gu_malloc_aligned(pool, repr->size, repr->align);
	pgf_read_to(rdr, type, to);
	*size_out = repr->size;
	return to;
}

static void*
pgf_read_struct(GuStructRepr* stype, PgfReader* rdr, void* to, 
		GuPool* pool, size_t* size_out)
{
	GuTypeRepr* repr = gu_type_cast((GuType*)stype, repr);
	size_t size = repr->size;
	GuLength length = 0;
	bool have_length = false;
	uint8_t* p = NULL;
	uint8_t* bto = to;
	gu_enter("-> struct %s", stype->name);

	for (int i = 0; i < stype->members.len; i++) {
		const GuMember* m = &stype->members.elems[i];
		gu_enter("-> %s.%s", stype->name, m->name);
		if (m->is_flex) {
			gu_assert(have_length && p == NULL && pool != NULL);
			size_t m_size = gu_type_size(m->type);
			size = gu_flex_size(size, m->offset,
					    length, m_size);
			p = gu_malloc_aligned(pool, size, repr->align);
			for (size_t j = 0; j < length; j++) {
				pgf_read_to(rdr, m->type, 
					    &p[m->offset + j * m_size]);
				gu_return_on_exn(rdr->err, NULL);
			}
		} else {
			pgf_read_to(rdr, m->type, &bto[m->offset]);
			gu_return_on_exn(rdr->err, NULL);
		}
		if (m->type == gu_type(GuLength)) {
			gu_assert(!have_length);
			have_length = true;
			length = gu_member(GuLength, to, m->offset);
		}
		gu_exit("<- %s.%s", stype->name, m->name);
	}
	if (p) {
		memcpy(p, to, repr->size);
	}
	if (size_out) {
		*size_out = size;
	}
	gu_exit("<- struct %s", stype->name);
	return p;
}

static void
pgf_read_to_struct(GuType* type, PgfReader* rdr, void* to)
{
	GuStructRepr* stype = gu_type_cast(type, struct);
	pgf_read_struct(stype, rdr, to, NULL, NULL);
}

static void*
pgf_read_new_struct(GuType* type, PgfReader* rdr, 
		    GuPool* pool, size_t* size_out)
{
	GuStructRepr* stype = gu_type_cast(type, struct);
	if (gu_struct_has_flex(stype)) {
		GuPool* tmp_pool = gu_new_pool();
		void* to = gu_type_malloc(type, tmp_pool);
		void* p = pgf_read_struct(stype, rdr, to, pool, size_out);
		gu_pool_free(tmp_pool);
		gu_assert(p);
		return p;
	} else {
		void* to = gu_type_malloc(type, pool);
		pgf_read_struct(stype, rdr, to, NULL, NULL);
		return to;
	}
}


static void
pgf_read_to_pointer(GuType* type, PgfReader* rdr, void* to)
{
	GuPointerType* ptype = (GuPointerType*) type;
	GuType* pointed = ptype->pointed_type;
	gu_require(gu_type_has_kind(pointed, gu_kind(struct)) ||
		   gu_type_has_kind(pointed, gu_kind(abstract)));
	GuStruct** sto = to;
	*sto = pgf_read_new(rdr, pointed, rdr->opool, NULL);
}

static void
pgf_read_to_GuVariant(GuType* type, PgfReader* rdr, void* to)
{
	GuVariantType* vtype = (GuVariantType*) type;
	GuVariant* vto = to;

	uint8_t btag = pgf_read_u8(rdr);
	gu_return_on_exn(rdr->err,);
	if (btag >= vtype->ctors.len) {
		gu_raise_i(rdr->err, PgfReadTagExn, 
			   .type = type, .tag = btag);
		return;
	}
	GuConstructor* ctor = &vtype->ctors.elems[btag];
	gu_enter("-> variant %s", ctor->c_name);
	GuPool* tmp_pool = gu_new_pool();
	GuTypeRepr* repr = gu_type_repr(ctor->type);
	size_t size = repr->size;
	void* init = pgf_read_new(rdr, ctor->type, tmp_pool, &size);
	*vto = gu_make_variant(btag, size, repr->align, init, rdr->opool);
	gu_pool_free(tmp_pool);
	gu_exit("<- variant %s", ctor->c_name);
}

static void
pgf_read_to_enum(GuType* type, PgfReader* rdr, void* to)
{
	// For now, assume that enum values are encoded in a single octet
	GuEnumType* etype = (GuEnumType*) type;
	uint8_t tag = pgf_read_u8(rdr);
	gu_return_on_exn(rdr->err,);
	if (tag >= etype->constants.len) {
		gu_raise_i(rdr->err, PgfReadTagExn, 
			   .type = type, .tag = tag);
		return;
	}
	GuEnumConstant* econ = &etype->constants.elems[tag];
	size_t size = gu_type_size(type);
	if (size == sizeof(int8_t)) {
		*((int8_t*) to) = econ->value;
	} else if (size == sizeof(int16_t)) {
		*((int16_t*) to) = econ->value;
	} else if (size == sizeof(int32_t)) {
		*((int32_t*) to) = econ->value;
	} else if (size == sizeof(int64_t)) {
		*((int64_t*) to) = econ->value;
	} else {
		gu_impossible();
	}
}

static void
pgf_read_to_void(GuType* info, PgfReader* rdr, void* to)
{
	(void) (info && rdr && to);
}


static void
pgf_read_to_int(GuType* type, PgfReader* rdr, void* to) 
{
	(void) type;
	*(int*) to = pgf_read_int(rdr);
}

static void
pgf_read_to_uint16_t(GuType* type, PgfReader* rdr, void* to)
{
	(void) type;
	*(uint16_t*) to = gu_in_u16be(rdr->in, rdr->err);
}

static void
pgf_read_to_GuLength(GuType* type, PgfReader* rdr, void* to)
{
	(void) type;
	*(GuLength*) to = pgf_read_len(rdr);
}

static void
pgf_read_to_double(GuType* type, PgfReader* rdr, void* to)
{
	(void) type;
	*(double*) to = gu_in_f64be(rdr->in, rdr->err);
}

static void
pgf_read_to_alias(GuType* type, PgfReader* rdr, void* to)
{
	GuTypeAlias* atype = gu_type_cast(type, alias);
	pgf_read_to(rdr, atype->type, to);
}

static void
pgf_read_into_map(GuMapType* mtype, PgfReader* rdr, GuMap* map, GuPool* pool)
{
	/* The parameter pool is the temporary pool used to store the
	   map. But the actual values need to be more persistent so we
	   store them in rdr->opool. */
	(void) pool;
	GuPool* tmp_pool = gu_new_pool();
	void* key = NULL;
	GuLength len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );
	if (mtype->hasher) {
		key = gu_type_malloc(mtype->key_type, tmp_pool);
	}
	for (size_t i = 0; i < len; i++) {
		if (mtype->hasher) {
			pgf_read_to(rdr, mtype->key_type, key);
		} else {
			key = pgf_read_new(rdr, mtype->key_type, 
					   rdr->opool, NULL);
		}
		gu_return_on_exn(rdr->err, );
		rdr->curr_key = key;
		/* If an old value already exists, read into
		   it. This allows us to create the value
		   object and point into it before we read the
		   content. */
		void* valp = gu_map_insert(map, key);
		pgf_read_to(rdr, mtype->value_type, valp);
		gu_return_on_exn(rdr->err, );
	}
	gu_pool_free(tmp_pool);
}

static void*
pgf_read_new_GuMap(GuType* type, PgfReader* rdr, GuPool* pool, size_t* size_out)
{
	(void) size_out;
	GuMapType* mtype = (GuMapType*) type;
	GuMap* map = gu_map_type_make(mtype, pool);
	pgf_read_into_map(mtype, rdr, map, pool);
	gu_return_on_exn(rdr->err, NULL);
	return map;
}

static void
pgf_read_to_GuString(GuType* type, PgfReader* rdr, void* to)
{
	(void) (type);
	gu_enter("-> GuString");
	GuString* sp = to;
	
	GuPool* tmp_pool = gu_new_pool();
	GuStringBuf* sbuf = gu_string_buf(tmp_pool);
	GuWriter* wtr = gu_string_buf_writer(sbuf);

	GuLength len = pgf_read_len(rdr);

	for (size_t i = 0; i < len; i++) {
		GuUCS ucs = gu_in_utf8(rdr->in, rdr->err);
		gu_ucs_write(ucs, wtr, rdr->err);
	}
	GuString str = gu_string_buf_freeze(sbuf, tmp_pool);
	GuSymbol sym = gu_symtable_intern(rdr->symtab, str);
	gu_pool_free(tmp_pool);

	gu_exit("<- GuString");
	*sp = sym;
}

static void
pgf_read_to_PgfCId(GuType* type, PgfReader* rdr, void* to)
{
	(void) (type);
	gu_enter("-> PgfCId");
	PgfCId* sp = to;
	
	GuPool* tmp_pool = gu_new_pool();
	GuStringBuf* sbuf = gu_string_buf(tmp_pool);
	GuWriter* wtr = gu_string_buf_writer(sbuf);

	GuLength len = pgf_read_len(rdr);

	for (size_t i = 0; i < len; i++) {
		// CIds are in latin-1
		GuUCS ucs = gu_in_u8(rdr->in, rdr->err);
		gu_ucs_write(ucs, wtr, rdr->err);
	}
	GuString str = gu_string_buf_freeze(sbuf, tmp_pool);
	GuSymbol sym = gu_symtable_intern(rdr->symtab, str);
	gu_pool_free(tmp_pool);

	gu_exit("<- PgfCId");
	*sp = sym;
}

static void
pgf_read_to_PgfCCatId(GuType* type, PgfReader* rdr, void* to)
{
	(void) (type);
	PgfCCat** pto = to;
	int fid = pgf_read_int(rdr);
	gu_return_on_exn(rdr->err,);

	PgfCCat* ccat = gu_map_get(rdr->curr_ccats, &fid, PgfCCat*);
	if (!ccat) {
        ccat = gu_new(PgfCCat, rdr->opool);
        ccat->cnccat = NULL;
        ccat->lindefs = gu_map_get(rdr->curr_lindefs, &fid, PgfFunIds*);
        ccat->prods = gu_null_seq;
        ccat->fid = fid;

        gu_map_put(rdr->curr_ccats, &fid, PgfCCat*, ccat);
	}

    *pto = ccat;
}

static void
pgf_read_to_PgfCCat(GuType* type, PgfReader* rdr, void* to)
{
    (void) type;
    gu_enter("->");
    int* fidp = rdr->curr_key;

    PgfCCat* ccat = to;
    ccat->cnccat = NULL;
    ccat->lindefs = gu_map_get(rdr->curr_lindefs, fidp, PgfFunIds*);
    pgf_read_to(rdr, gu_type(PgfProductionSeq), &ccat->prods);
    ccat->fid = *fidp;
    gu_exit("<-");
}

// This is only needed because new_struct would otherwise override.
// TODO: get rid of new_struct and all the FAM mess
static void*
pgf_read_new_PgfCCat(GuType* type, PgfReader* rdr, GuPool* pool,
		     size_t* size_out)
{
	PgfCCat* ccat = gu_map_get(rdr->curr_ccats, rdr->curr_key, PgfCCat*);
	if (!ccat) {
        ccat = gu_new(PgfCCat, pool);
        gu_map_put(rdr->curr_ccats, rdr->curr_key, PgfCCat*, ccat);
	}
	pgf_read_to_PgfCCat(type, rdr, ccat);
	*size_out = sizeof(PgfCCat);
	return ccat;
}

static void*
pgf_read_new_GuList(GuType* type, PgfReader* rdr, GuPool* pool, size_t* size_out)
{
	GuListType* ltype = gu_type_cast(type, GuList);
	GuLength length = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);
	void* list = gu_list_type_alloc(ltype, length, pool);
	for (size_t i = 0; i < length; i++) {
		void* elem = gu_list_type_index(ltype, list, i);
		pgf_read_to(rdr, ltype->elem_type, elem);
		gu_return_on_exn(rdr->err, NULL);
	}
	*size_out = gu_flex_size(ltype->size, ltype->elems_offset,
				 length, 
				 gu_type_size(ltype->elem_type));
	return list;
}

static void
pgf_read_to_GuSeq(GuType* type, PgfReader* rdr, void* to)
{
	gu_enter("->");
	GuSeqType* stype = gu_type_cast(type, GuSeq);
	GuLength length = pgf_read_len(rdr);
	GuTypeRepr* repr = gu_type_repr(stype->elem_type);
	gu_return_on_exn(rdr->err, );
	GuSeq seq = gu_make_seq(repr->size, length, rdr->opool);
	uint8_t* data = gu_seq_data(seq);
	for (size_t i = 0; i < length; i++) {
		void* elem = &data[i * repr->size];
		pgf_read_to(rdr, stype->elem_type, elem);
		gu_return_on_exn(rdr->err, );
	}
	GuSeq* sto = to;
	*sto = seq;
	gu_exit("<-");
}

static void
pgf_read_to_maybe_seq(GuType* type, PgfReader* rdr, void* to)
{
	GuSeq* sto = to;
	uint8_t tag = pgf_read_u8(rdr);
	gu_return_on_exn(rdr->err,);
	switch (tag) {
	case 0:
		*sto = gu_null_seq;
		break;
	case 1:
		pgf_read_to_GuSeq(type, rdr, to);
		break;
	default:
		gu_raise_i(rdr->err, PgfReadTagExn,
			   .type = type, .tag = tag);
		break;
	}
}


static void*
pgf_read_new_idarray(GuType* type, PgfReader* rdr, GuPool* pool,
		     size_t* size_out)
{
	(void) type;
	void* list = pgf_read_new_GuList(type, rdr, rdr->opool, size_out);
	if (type == gu_type(PgfSequences)) {
		rdr->curr_sequences = list;
	} else if (type == gu_type(PgfCncFuns)) {
		rdr->curr_cncfuns = list;
        
        // set the function ids
        int n_funs = gu_list_length(rdr->curr_cncfuns);
        for (int funid = 0; funid < n_funs; funid++) {
            PgfCncFun* cncfun = gu_list_index(rdr->curr_cncfuns, funid);
            cncfun->funid = funid;
        }
	} else {
		gu_impossible();
	}
	return list;
}

static void
pgf_read_to_PgfSeqId(GuType* type, PgfReader* rdr, void* to)
{
	(void) type;
	int32_t id = pgf_read_int(rdr);
	gu_return_on_exn(rdr->err,);
	if (id < 0 || id >= gu_list_length(rdr->curr_sequences)) {
		gu_raise(rdr->err, PgfReadExn);
		return;
	}
	*(PgfSeqId*) to = gu_list_elems(rdr->curr_sequences)[id];
}


static void
pgf_read_to_PgfFunId(GuType* type, PgfReader* rdr, void* to)
{
	(void) type;
	int32_t id = pgf_read_int(rdr);
	gu_return_on_exn(rdr->err,);
	if (id < 0 || id >= gu_list_length(rdr->curr_cncfuns)) {
		gu_raise(rdr->err, PgfReadExn);
		return;
	}
	*(PgfFunId*) to = gu_list_elems(rdr->curr_cncfuns)[id];
}

static GU_DEFINE_TYPE(PgfLinDefs, GuIntMap, gu_ptr_type(PgfFunIds),
		      &gu_null_struct);
typedef PgfCCat PgfCCatData;
static GU_DEFINE_TYPE(PgfCCatData, typedef, gu_type(PgfCCat));

static GU_DEFINE_TYPE(PgfCCatMap, GuIntMap, gu_ptr_type(PgfCCat),
		      &gu_null_struct);

static GU_DEFINE_TYPE(PgfCncCatMap, GuStringMap, gu_ptr_type(PgfCncCat),
		      &gu_null_struct);

typedef struct {
	GuMapItor fn;
	GuBuf* seq;
} PgfCCatCbCtx;

static PgfCncCat*
pgf_ccat_set_cnccat(PgfCCat* ccat, GuBuf* newly_set)
{
	if (!ccat->cnccat) {
		size_t n_prods = gu_seq_length(ccat->prods);
		for (size_t i = 0; i < n_prods; i++) {
			PgfProduction prod = 
				gu_seq_get(ccat->prods, PgfProduction, i);
			GuVariantInfo i = gu_variant_open(prod);
			switch (i.tag) {
			case PGF_PRODUCTION_COERCE: {
				PgfProductionCoerce* pcoerce = i.data;
				PgfCncCat* cnccat = 
					pgf_ccat_set_cnccat(pcoerce->coerce,
							    newly_set);
				if (!ccat->cnccat) {
					ccat->cnccat = cnccat;
				} else if (ccat->cnccat != cnccat) {
					// XXX: real error
					gu_impossible();
				}
 				break;
			}
			case PGF_PRODUCTION_APPLY:
				// Shouldn't happen with current PGF.
				// XXX: real error
				gu_impossible();
				break;
			default:
				gu_impossible();
			}
		}
		gu_buf_push(newly_set, PgfCCat*, ccat);
	}
	return ccat->cnccat;
}


static void
pgf_read_ccat_cb(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	(void) (key && err);
	PgfCCatCbCtx* ctx = (PgfCCatCbCtx*) fn;
	PgfCCat** ccatp = value;
	pgf_ccat_set_cnccat(*ccatp, ctx->seq);
}

static void*
pgf_read_new_PgfConcr(GuType* type, PgfReader* rdr, GuPool* pool,
		       size_t* size_out)
{
	(void) (type && size_out);
	PgfConcr* concr = gu_new(PgfConcr, pool);
	concr->cflags = 
		pgf_read_new(rdr, gu_type(PgfFlags), pool, NULL);
	concr->printnames = 
		pgf_read_new(rdr, gu_type(PgfPrintNames), pool, NULL);
	concr->sequences = 
		pgf_read_new(rdr, gu_type(PgfSequences), rdr->opool, NULL);
	concr->cncfuns =
		pgf_read_new(rdr, gu_type(PgfCncFuns), pool, NULL);
	GuMapType* lindefs_t = gu_type_cast(gu_type(PgfLinDefs), GuMap);
	rdr->curr_lindefs = gu_map_type_make(lindefs_t, pool);
	pgf_read_into_map(lindefs_t, rdr, rdr->curr_lindefs, rdr->opool);
	GuMapType* ccats_t = gu_type_cast(gu_type(PgfCCatMap), GuMap);
	concr->ccats =
		gu_new_int_map(PgfCCat*, &gu_null_struct, pool);
    rdr->curr_ccats = concr->ccats;
	pgf_read_into_map(ccats_t, rdr, concr->ccats, rdr->opool);    
	concr->cnccats = pgf_read_new(rdr, gu_type(PgfCncCatMap), 
				      rdr->opool, NULL);

	GuBuf* extra_ccats = gu_new_buf(PgfCCat*, pool);
	PgfCCatCbCtx ctx = { { pgf_read_ccat_cb }, extra_ccats };
	gu_map_iter(concr->ccats, &ctx.fn, NULL);
	concr->extra_ccats = gu_buf_freeze(extra_ccats, rdr->opool);
	(void) pgf_read_int(rdr); // totalcats
	return concr;
}

static bool
pgf_ccat_n_lins(PgfCCat* cat, int* n_lins) {
	if (gu_seq_is_null(cat->prods)) {
		return true;
	}
	size_t n_prods = gu_seq_length(cat->prods);
	for (size_t j = 0; j < n_prods; j++) {
		PgfProduction prod =
			gu_seq_get(cat->prods, PgfProduction, j);
		GuVariantInfo i = gu_variant_open(prod);
		switch (i.tag) {
		case PGF_PRODUCTION_APPLY: {
			PgfProductionApply* papp = i.data;
			if (*n_lins == -1) {
				*n_lins = (int) papp->fun->n_lins;
			} else if (*n_lins != (int) papp->fun->n_lins) {
				// Inconsistent n_lins for different productions!
				return false;
			}
			break;
		}
		case PGF_PRODUCTION_COERCE: {
			PgfProductionCoerce* pcoerce = i.data;
			bool succ = pgf_ccat_n_lins(pcoerce->coerce, n_lins);
			if (!succ) {
				return false;
			}
			break;
		}
		default:
			gu_impossible();
		}
	}
	return true;
}

static void*
pgf_read_new_PgfCncCat(GuType* type, PgfReader* rdr, GuPool* pool,
		       size_t* size_out)
{
	PgfCId cid = *(PgfCId*) rdr->curr_key;
	gu_enter("-> cid");
	(void) (type && size_out);
	PgfCncCat* cnccat = gu_new(PgfCncCat, pool);
	cnccat->cid = cid;
	int first = pgf_read_int(rdr);
	int last = pgf_read_int(rdr);
	int len = last + 1 - first;
	PgfCCatIds* cats = gu_new_list(PgfCCatIds, pool, len);
	int n_lins = -1;
	for (int i = 0; i < len; i++) {
		int fid = first + i;
		PgfCCat* ccat = gu_map_get(rdr->curr_ccats, &fid, PgfCCat*);
        if (!ccat) {
            ccat = gu_new(PgfCCat, rdr->opool);
            ccat->cnccat = NULL;
            ccat->lindefs = gu_map_get(rdr->curr_lindefs, &fid, PgfFunIds*);
            ccat->prods = gu_null_seq;
            ccat->fid = fid;

            gu_map_put(rdr->curr_ccats, &fid, PgfCCat*, ccat);
        }
		gu_list_index(cats, i) = ccat;

        ccat->cnccat = cnccat;
		if (!pgf_ccat_n_lins(ccat, &n_lins)) {
			gu_raise(rdr->err, PgfReadExn);
			goto fail;
		}
		gu_debug("range[%d] = %d", i, ccat ? ccat->fid : -1);
	}
	cnccat->n_lins = n_lins == -1 ? 0 : (size_t) n_lins;
	cnccat->cats = cats;
	cnccat->labels = pgf_read_new(rdr, gu_type(GuStringL), 
				      pool, NULL);
	gu_exit("<-");
	return cnccat;
fail:
	gu_exit("<- fail");
	return NULL;
}

#define PGF_READ_TO_FN(k_, fn_)					\
	{ gu_kind(k_), (void*) &(PgfReadToFn){ fn_ } }

#define PGF_READ_TO(k_)				\
	PGF_READ_TO_FN(k_, pgf_read_to_##k_)


static GuTypeTable
pgf_read_to_table = GU_TYPETABLE(
	GU_SLIST_0,
	PGF_READ_TO(struct),
	PGF_READ_TO(GuVariant),
	PGF_READ_TO(enum),
	PGF_READ_TO(void),
	PGF_READ_TO(int),
	PGF_READ_TO(uint16_t),
	PGF_READ_TO(GuLength),
	PGF_READ_TO(PgfCId),
	PGF_READ_TO(GuString),
	PGF_READ_TO(double),
	PGF_READ_TO(pointer),
	PGF_READ_TO_FN(PgfEquationsM, pgf_read_to_maybe_seq),
	PGF_READ_TO(GuSeq),
	PGF_READ_TO(PgfCCatId),
	PGF_READ_TO(PgfCCat),
	PGF_READ_TO(PgfSeqId),
	PGF_READ_TO(PgfFunId),
	PGF_READ_TO(alias));

#define PGF_READ_NEW_FN(k_, fn_)		\
	{ gu_kind(k_), (void*) &(PgfReadNewFn){ fn_ } }

#define PGF_READ_NEW(k_)			\
	PGF_READ_NEW_FN(k_, pgf_read_new_##k_)

static GuTypeTable
pgf_read_new_table = GU_TYPETABLE(
	GU_SLIST_0,
	PGF_READ_NEW(type),
	PGF_READ_NEW(struct),
	PGF_READ_NEW(GuMap),
	PGF_READ_NEW(GuList),
	PGF_READ_NEW(PgfCCat),
	PGF_READ_NEW(PgfCncCat),
	PGF_READ_NEW(PgfConcr),
	PGF_READ_NEW_FN(PgfSequences, pgf_read_new_idarray),
	PGF_READ_NEW_FN(PgfCncFuns, pgf_read_new_idarray)
	);

static PgfReader*
pgf_new_reader(GuIn* in, GuPool* opool, GuPool* tmp_pool, GuExn* err)
{
	PgfReader* rdr = gu_new(PgfReader, tmp_pool);
	rdr->opool = opool;
	rdr->symtab = gu_new_symtable(opool, tmp_pool);
	rdr->err = err;
	rdr->in = in;
	rdr->curr_sequences = NULL;
	rdr->curr_cncfuns = NULL;
	rdr->read_to_map = gu_new_type_map(&pgf_read_to_table, tmp_pool);
	rdr->read_new_map = gu_new_type_map(&pgf_read_new_table, tmp_pool);
	return rdr;
}


PgfPGF*
pgf_read(GuIn* in, GuPool* pool, GuExn* err)
{
	GuPool* tmp_pool = gu_new_pool();
	PgfReader* rdr = pgf_new_reader(in, pool, tmp_pool, err);
	PgfPGF* pgf = pgf_read_new(rdr, gu_type(PgfPGF), pool, NULL);
	gu_pool_free(tmp_pool);
	gu_return_on_exn(err, NULL);
	return pgf;
}
