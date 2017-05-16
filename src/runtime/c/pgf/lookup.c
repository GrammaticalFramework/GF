#include <gu/map.h>
#include <gu/mem.h>
#include <gu/utf8.h>
#include <gu/file.h>
#include <gu/string.h>
#include <gu/choice.h>
#include <pgf/data.h>
#include <stdio.h>

//#define PGF_LOOKUP_DEBUG

typedef struct {
	PgfAbsFun* fun;
	size_t arg_idx;
} PgfAbsBottomUpEntry;

typedef struct {
	PgfAbsFun* fun;
	size_t count;
	PgfMetaId args[0];
} PgfAbsProduction;

#ifdef PGF_LOOKUP_DEBUG
static void
pgf_print_abs_production(PgfMetaId id,
                         PgfAbsProduction* prod,
                         GuOut* out, GuExn* err)
{
	gu_printf(out,err,"?%d = %s",id,prod->fun->name);
	size_t n_hypos = gu_seq_length(prod->fun->type->hypos);
	for (size_t i = 0; i < n_hypos; i++) {
		gu_printf(out,err," ?%d", prod->args[i]);
	}
	gu_printf(out,err," (%d)\n",prod->count);
}

static void
pgf_print_abs_productions(GuBuf* prods,
                          GuOut* out, GuExn* err)
{
	size_t n_prods = gu_buf_length(prods);
	for (size_t id = 1; id < n_prods; id++) {
		GuBuf* id_prods = gu_buf_get(prods, GuBuf*, id);
		size_t n_id_prods = gu_buf_length(id_prods);
		for (size_t i = 0; i < n_id_prods; i++) {
			PgfAbsProduction* prod = 
				gu_buf_get(id_prods, PgfAbsProduction*, i);
			pgf_print_abs_production(id, prod, out, err);
		}
	}
}
#endif

static void
pgf_lookup_index_syms(GuMap* lexicon_idx, PgfSymbols* syms, PgfProductionIdx* idx, GuPool* pool) {
	size_t n_syms = gu_seq_length(syms);
	for (size_t j = 0; j < n_syms; j++) {
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, j);
		GuVariantInfo i = gu_variant_open(sym);
		switch (i.tag) {
		case PGF_SYMBOL_KP: {
			PgfSymbolKP* skp = (PgfSymbolKP*) i.data;
			pgf_lookup_index_syms(lexicon_idx, skp->default_form, idx, pool);
			for (size_t k = 0; k < skp->n_forms; k++) {
				pgf_lookup_index_syms(lexicon_idx, skp->forms[k].form, idx, pool);
			}
			break;
		}
		case PGF_SYMBOL_KS: {
			PgfSymbolKS* sks = (PgfSymbolKS*) i.data;
			GuBuf* funs = gu_map_get(lexicon_idx, sks->token, GuBuf*);
			if (funs == NULL) {
				funs = gu_new_buf(PgfAbsFun*, pool);
				gu_map_put(lexicon_idx, sks->token, GuBuf*, funs);
			}

			size_t n_idx = gu_buf_length(idx);
			for (size_t k = 0; k < n_idx; k++) {
				PgfProductionIdxEntry* entry =
					gu_buf_index(idx, PgfProductionIdxEntry, k);
				bool found = false;
				size_t n_funs = gu_buf_length(funs);
				for (size_t l = 0; l < n_funs; l++) {
					PgfAbsFun* fun = gu_buf_get(funs, PgfAbsFun*, l);
					if (fun == entry->papp->fun->absfun) {
						found = true;
						break;
					}
				}
				if (!found)
					gu_buf_push(funs, PgfAbsFun*, entry->papp->fun->absfun);
			}
			break;
		}
		}
	}
}

typedef struct {
	GuMap* function_idx;
	GuMap* cat_ids;
	GuBuf* spine;
	GuPool* pool;
} PgfSpineBuilder;

static PgfAbsProduction*
pgf_lookup_new_production(PgfAbsFun* fun, GuPool *pool) {
	size_t n_hypos = gu_seq_length(fun->type->hypos);
	PgfAbsProduction* prod = gu_new_flex(pool, PgfAbsProduction, args, n_hypos);
	prod->fun   = fun;
	prod->count = 0;
	for (size_t i = 0; i < n_hypos; i++) {
		prod->args[i] = 0;
	}
	return prod;
}

static void
pgf_lookup_add_production(PgfSpineBuilder* builder, PgfMetaId id, PgfAbsProduction* prod)
{
	GuBuf* prods = gu_buf_get(builder->spine, GuBuf*, id);
	gu_buf_push(prods, PgfAbsProduction*, prod);
}

static PgfMetaId
pgf_lookup_add_spine_nodes(PgfSpineBuilder* builder, PgfCId cat) {
	PgfMetaId cat_id = gu_map_get(builder->cat_ids, cat, PgfMetaId);
	if (cat_id != 0) {
		return cat_id;
	}

	cat_id = gu_buf_length(builder->spine);
	gu_buf_push(builder->spine, GuBuf*, gu_new_buf(PgfAbsProduction*, builder->pool));

	gu_map_put(builder->cat_ids, cat, PgfMetaId, cat_id);

	GuBuf* entries = gu_map_get(builder->function_idx, cat, GuBuf*);
	if (entries != NULL) {
		size_t n_entries = gu_buf_length(entries);
		for (size_t i = 0; i < n_entries; i++) {
			PgfAbsBottomUpEntry* entry = gu_buf_index(entries, PgfAbsBottomUpEntry, i);

			PgfMetaId id = pgf_lookup_add_spine_nodes(builder, entry->fun->type->cid);
			
			PgfAbsProduction* prod = pgf_lookup_new_production(entry->fun, builder->pool);
			prod->args[entry->arg_idx] = cat_id;
			
			pgf_lookup_add_production(builder, id, prod);
		}
	}

	return cat_id;
}

static void
pgf_lookup_add_spine_leaf(PgfSpineBuilder* builder, PgfAbsFun *fun)
{	
	PgfMetaId id = pgf_lookup_add_spine_nodes(builder, fun->type->cid);
	PgfAbsProduction* prod = pgf_lookup_new_production(fun, builder->pool);
	prod->count = 1;

	pgf_lookup_add_production(builder, id, prod);
}

static GuBuf*
pgf_lookup_build_spine(GuMap* lexicon_idx, GuMap* function_idx,
                       GuString tok, PgfType* typ, PgfMetaId* cat_id,
                       GuPool* pool)
{
	PgfSpineBuilder builder;
	builder.function_idx = function_idx;
	builder.cat_ids      = gu_new_string_map(PgfMetaId, &gu_null_struct, pool);
	builder.spine        = gu_new_buf(GuBuf*, pool);
	builder.pool         = pool;
	
	gu_buf_push(builder.spine, GuBuf*, NULL);

	GuBuf* funs = gu_map_get(lexicon_idx, tok, GuBuf*);
	if (funs != NULL) {
		size_t n_funs = gu_buf_length(funs);
		for (size_t i = 0; i < n_funs; i++) {
			PgfAbsFun* absfun =
				gu_buf_get(funs, PgfAbsFun*, i);
			pgf_lookup_add_spine_leaf(&builder, absfun);
		}
	}

	*cat_id = gu_map_get(builder.cat_ids, typ->cid, PgfMetaId);

	return builder.spine;
}

typedef PgfMetaId PgfPair[2];

static bool
pgf_pair_eq_fn(GuEquality* self, const void* p1, const void* p2)
{
	(void) self;
	const PgfMetaId* ip1 = p1;
	const PgfMetaId* ip2 = p2;
	return (ip1[0] == ip2[0] && ip1[1] == ip2[1]);
}

static GuHash
pgf_pair_hash_fn(GuHasher* self, const void* p)
{
	(void) self;
	const PgfMetaId* ip = p;
	return (GuHash) (((ip[1] & 0xFFFF) << 16) | (ip[0] & 0xFFFF));
}

static GuHasher
pgf_pair_hasher[1] = {
	{
		{ pgf_pair_eq_fn },
		pgf_pair_hash_fn
	}
};

static PgfMetaId
pgf_lookup_merge_cats(GuBuf* spine, GuMap* pairs,
                      PgfMetaId cat_id1, GuBuf* spine1,
                      PgfMetaId cat_id2, GuBuf* spine2,
                      GuPool* pool)
{
	if (cat_id1 == 0 && cat_id2 == 0)
		return 0;

	PgfPair pair;
	pair[0] = cat_id1;
	pair[1] = cat_id2;
	PgfMetaId cat_id = gu_map_get(pairs, &pair, PgfMetaId);
	if (cat_id != 0)
		return cat_id;

	cat_id = gu_buf_length(spine);
	GuBuf* id_prods = gu_new_buf(PgfAbsProduction*, pool);
	gu_buf_push(spine, GuBuf*, id_prods);

	gu_map_put(pairs, &pair, PgfMetaId, cat_id);

	GuBuf* id_prods1 = gu_buf_get(spine1, GuBuf*, cat_id1);
	GuBuf* id_prods2 = gu_buf_get(spine2, GuBuf*, cat_id2);
	size_t n_id_prods1 = (cat_id1 == 0) ? 0 : gu_buf_length(id_prods1);
	size_t n_id_prods2 = (cat_id2 == 0) ? 0 : gu_buf_length(id_prods2);

	if (cat_id1 != 0) {
		for (size_t i = 0; i < n_id_prods1; i++) {
			PgfAbsProduction* prod1 =
				gu_buf_get(id_prods1, PgfAbsProduction*, i);
			int count = 0;
			for (size_t j = 0; j < n_id_prods2; j++) {
				PgfAbsProduction* prod2 =
					gu_buf_get(id_prods2, PgfAbsProduction*, j);
				if (prod1->fun == prod2->fun) {
					PgfAbsProduction* prod =
						pgf_lookup_new_production(prod1->fun, pool);
					prod->count = prod1->count+prod2->count;
					size_t n_hypos = gu_seq_length(prod->fun->type->hypos);
					for (size_t l = 0; l < n_hypos; l++) {
						prod->args[l] =
							pgf_lookup_merge_cats(spine, pairs,
						                          prod1->args[l], spine1,
						                          prod2->args[l], spine2,
                                                  pool);
					}
					gu_buf_push(id_prods, PgfAbsProduction*, prod);
					
					count++;
				}
			}

			if (count == 0) {
				PgfAbsProduction* prod =
					pgf_lookup_new_production(prod1->fun, pool);
				prod->count = prod1->count;
				size_t n_hypos = gu_seq_length(prod->fun->type->hypos);
				for (size_t l = 0; l < n_hypos; l++) {
					prod->args[l] =
						pgf_lookup_merge_cats(spine, pairs,
											  prod1->args[l], spine1,
											  0,              spine2,
											  pool);
				}
				gu_buf_push(id_prods, PgfAbsProduction*, prod);
			}
		}
	}

	if (cat_id2 != 0) {
		for (size_t i = 0; i < n_id_prods2; i++) {
			PgfAbsProduction* prod2 =
				gu_buf_get(id_prods2, PgfAbsProduction*, i);
			bool found = false;
			for (size_t j = 0; j < n_id_prods1; j++) {
				PgfAbsProduction* prod1 =
					gu_buf_get(id_prods1, PgfAbsProduction*, j);
				if (prod1->fun == prod2->fun) {
					found = true;
					break;
				}
			}
			
			if (!found) {
				PgfAbsProduction* prod =
					pgf_lookup_new_production(prod2->fun, pool);
				prod->count = prod2->count;
				size_t n_hypos = gu_seq_length(prod->fun->type->hypos);
				for (size_t l = 0; l < n_hypos; l++) {
					prod->args[l] =
						pgf_lookup_merge_cats(spine, pairs,
											  0,              spine1,
											  prod2->args[l], spine2,
											  pool);
				}
				gu_buf_push(id_prods, PgfAbsProduction*, prod);
			}
		}
	}

	return cat_id;
}

static GuBuf*
pgf_lookup_merge(PgfMetaId cat_id1, GuBuf* spine1,
                 PgfMetaId cat_id2, GuBuf* spine2,
                 PgfMetaId* cat_id,
                 GuPool* pool, GuPool* out_pool)
{
	GuBuf* spine = gu_new_buf(GuBuf*, out_pool);
	gu_buf_push(spine, GuBuf*, NULL);

	GuMap* pairs = gu_new_map(PgfPair, pgf_pair_hasher, PgfMetaId, &gu_null_struct, pool);

	*cat_id =
		pgf_lookup_merge_cats(spine, pairs,
		                      cat_id1, spine1,
		                      cat_id2, spine2,
		                      out_pool);

	return spine;
}

static bool
pgf_lookup_filter(GuBuf* join, PgfMetaId cat_id, GuSeq* counts, GuBuf* stack)
{
	if (cat_id == 0)
		return true;

	size_t count = gu_seq_get(counts, size_t, cat_id);
	if (count > 0)
		return true;

	size_t n_stack = gu_buf_length(stack);
	for (size_t i = 0; i < n_stack; i++) {
		PgfMetaId id = gu_buf_get(stack, PgfMetaId, i);
		if (cat_id == id) {
			return false;
		}
	}
	gu_buf_push(stack, PgfMetaId, cat_id);

	size_t pos = 0;
	size_t maximum = 0;
	GuBuf* id_prods = gu_buf_get(join, GuBuf*, cat_id);
	size_t n_id_prods = gu_buf_length(id_prods);
	for (size_t i = 0; i < n_id_prods; i++) {
		PgfAbsProduction* prod = 
			gu_buf_get(id_prods, PgfAbsProduction*, i);

		size_t n_args = gu_seq_length(prod->fun->type->hypos);
		size_t sum = prod->count;
		for (size_t j = 0; j < n_args; j++) {
			if (!pgf_lookup_filter(join, prod->args[j], counts, stack)) {
				sum = 0;
				break;
			}
			sum += gu_seq_get(counts, size_t, prod->args[j]);
		}

		if (sum > maximum) {
			maximum = sum;
			pos = 0;
		}
		if (sum == maximum) {
			gu_buf_set(id_prods, PgfAbsProduction*, pos, prod);
			pos++;
		}

		prod->count = sum;
	}

	gu_seq_set(counts, size_t, cat_id, maximum);
	gu_buf_trim_n(id_prods, n_id_prods-pos);

	gu_buf_pop(stack, PgfMetaId);

	return true;
}

typedef struct {
	GuEnum en;
	GuBuf* join;
	PgfMetaId start_id;
	GuChoice* choice;
	GuPool* out_pool;
} PgfLookupEnum;

static void
pgf_lookup_extract(PgfLookupEnum* st, PgfMetaId cat_id, PgfExprProb* ep)
{
	GuBuf* id_prods = gu_buf_get(st->join, GuBuf*, cat_id);
	
	if (id_prods == NULL || gu_buf_length(id_prods) == 0) {
		ep->expr = gu_new_variant_i(st->out_pool,
					                PGF_EXPR_META,
					                PgfExprMeta,
					                cat_id);
		ep->prob = 0;
		return;
	}

	size_t n_id_prods = gu_buf_length(id_prods);

	size_t i = gu_choice_next(st->choice, n_id_prods);
	PgfAbsProduction* prod = 
		gu_buf_get(id_prods, PgfAbsProduction*, i);

	*ep = prod->fun->ep;
	size_t n_args = gu_seq_length(prod->fun->type->hypos);
	for (size_t j = 0; j < n_args; j++) {
		PgfExprProb ep_arg;
		pgf_lookup_extract(st, prod->args[j], &ep_arg);

		ep->expr = gu_new_variant_i(st->out_pool,
						PGF_EXPR_APP,
						PgfExprApp,
						ep->expr, ep_arg.expr);
		ep->prob += ep_arg.prob;
	}
}

static void
pgf_lookup_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfLookupEnum* st = gu_container(self, PgfLookupEnum, en);
	
	if (st->choice == NULL) {
		*((PgfExprProb**) to) = NULL;
		return;
	}

	GuChoiceMark mark = gu_choice_mark(st->choice);

	PgfExprProb* ep = gu_new(PgfExprProb, pool);
	pgf_lookup_extract(st, st->start_id, ep);
	*((PgfExprProb**) to) = ep;

	gu_choice_reset(st->choice, mark);

	if (!gu_choice_advance(st->choice)) {
		st->choice = NULL;
	}
}

PGF_API GuEnum*
pgf_lookup_sentence(PgfConcr* concr, PgfType* typ, GuString sentence, GuPool* pool, GuPool* out_pool)
{
	//// building search indices //
	GuMap* lexicon_idx = gu_new_string_map(GuBuf*, &gu_null_struct, pool);
	size_t n_seqs = gu_seq_length(concr->sequences);
	for (size_t i = 0; i < n_seqs; i++) {
		PgfSequence* seq = gu_seq_index(concr->sequences, PgfSequence, i);
		if (seq->idx != NULL) {
			pgf_lookup_index_syms(lexicon_idx, seq->syms, seq->idx, pool);
		}
	}
	
	GuMap* function_idx = gu_new_string_map(GuBuf*, &gu_null_struct, pool);
	size_t n_funs = gu_seq_length(concr->abstr->funs);
	for (size_t i = 0; i < n_funs; i++) {
		PgfAbsFun* fun = gu_seq_index(concr->abstr->funs, PgfAbsFun, i);

		size_t n_hypos = gu_seq_length(fun->type->hypos);
		for (size_t j = 0; j < n_hypos; j++) {
			PgfHypo* hypo = gu_seq_index(fun->type->hypos, PgfHypo, j);
			
			GuBuf* funs = gu_map_get(function_idx, hypo->type->cid, GuBuf*);
			if (funs == NULL) {
				funs = gu_new_buf(PgfAbsBottomUpEntry, pool);
				gu_map_put(function_idx, hypo->type->cid, GuBuf*, funs);
			}

			PgfAbsBottomUpEntry* entry = gu_buf_extend(funs);
			entry->fun     = fun;
			entry->arg_idx = j;
		}
	}
	///////////////////////////////

	GuPool *work_pool = gu_new_pool();

	PgfMetaId cat_id1 = 0;
	GuBuf* join = gu_new_buf(GuBuf*, pool);
	gu_buf_push(join, GuBuf*, NULL);

	GuUCS c = ' ';
	const uint8_t* p = (const uint8_t*) sentence;
	for (;;) {
		while (gu_ucs_is_space(c)) {
			c = gu_utf8_decode(&p);
		}
		if (c == 0)
			break;

		const uint8_t* start = p-1;
		while (c != 0 && !gu_ucs_is_space(c)) {
			c = gu_utf8_decode(&p);
		}
		const uint8_t* end   = p-1;

		size_t len = end-start;
		GuString tok = gu_malloc(work_pool, len+1);
		memcpy((uint8_t*) tok, start, len);
		((uint8_t*) tok)[len] = 0;

		PgfMetaId cat_id2 = 0;
		GuBuf* spine =
			pgf_lookup_build_spine(lexicon_idx, function_idx,
			                       tok, typ, &cat_id2,
			                       work_pool);

		join = pgf_lookup_merge(cat_id1, join, cat_id2, spine, &cat_id1, work_pool, pool);
	}


	size_t n_cats = gu_buf_length(join);
	GuBuf* stack = gu_new_buf(PgfMetaId, work_pool);
	GuSeq* counts = gu_new_seq(size_t, n_cats, work_pool);
	for (size_t i = 0; i < n_cats; i++) {
		gu_seq_set(counts, size_t, i, 0);
	}
	pgf_lookup_filter(join, cat_id1, counts, stack);
	for (size_t i = 1; i < n_cats; i++) {
		if (gu_seq_get(counts, size_t, i) == 0) {
			GuBuf* id_prods = gu_buf_get(join, GuBuf*, i);
			gu_buf_flush(id_prods);
		}
	}

#ifdef PGF_LOOKUP_DEBUG
	GuPool* tmp_pool = gu_new_pool();
	GuOut* out = gu_file_out(stderr, tmp_pool);
	GuExn* err = gu_exn(tmp_pool);
	pgf_print_abs_productions(join, out, err);
	gu_putc('\n',out,err);
	gu_pool_free(tmp_pool);
#endif

	gu_pool_free(work_pool);

	PgfLookupEnum* st = gu_new(PgfLookupEnum, pool);
	st->en.next = pgf_lookup_enum_next;
	st->join    = join;
	st->start_id= cat_id1;
	st->choice  = gu_new_choice(pool);
	st->out_pool= out_pool;
	return &st->en;
}
