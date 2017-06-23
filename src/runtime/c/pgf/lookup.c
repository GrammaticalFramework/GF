#include <gu/map.h>
#include <gu/mem.h>
#include <gu/utf8.h>
#include <gu/file.h>
#include <gu/string.h>
#include <gu/choice.h>
#include <pgf/data.h>
#include <pgf/linearizer.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//#define PGF_LOOKUP_DEBUG
//#define PGF_LINEARIZER_DEBUG

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
	gu_printf(out,err," [%d]\n",prod->count);
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

#ifdef PGF_LINEARIZER_DEBUG
PGF_INTERNAL_DECL void
pgf_print_cnc_tree(PgfCncTree ctree, GuOut* out, GuExn* err);
#endif

static void
pgf_lookup_index_syms(GuMap* lexicon_idx, PgfSymbols* syms, PgfAbsFun* absfun, GuPool* pool) {
	size_t n_syms = gu_seq_length(syms);
	for (size_t j = 0; j < n_syms; j++) {
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, j);
		GuVariantInfo i = gu_variant_open(sym);
		switch (i.tag) {
		case PGF_SYMBOL_KP: {
			PgfSymbolKP* skp = (PgfSymbolKP*) i.data;
			pgf_lookup_index_syms(lexicon_idx, skp->default_form, absfun, pool);
			for (size_t k = 0; k < skp->n_forms; k++) {
				pgf_lookup_index_syms(lexicon_idx, skp->forms[k].form, absfun, pool);
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

			bool found = false;
			size_t n_funs = gu_buf_length(funs);
			for (size_t l = 0; l < n_funs; l++) {
				PgfAbsFun* absfun1 = gu_buf_get(funs, PgfAbsFun*, l);
				if (absfun1 == absfun) {
					found = true;
					break;
				}
			}
			if (!found)
				gu_buf_push(funs, PgfAbsFun*, absfun);
			break;
		}
		}
	}
}

typedef struct {
	GuMap* function_idx;
	GuMap* meta_ids;
	GuBuf* spine;
	GuPool* pool;
} PgfSpineBuilder;

typedef struct {
	PgfToken token;
	size_t n_funs;
	PgfAbsFun** funs;
} PgfInputToken;

static PgfAbsProduction*
pgf_lookup_new_production(PgfAbsFun* fun, GuPool *pool)
{
	size_t n_hypos = gu_seq_length(fun->type->hypos);
	PgfAbsProduction* prod = gu_new_flex(pool, PgfAbsProduction, args, n_hypos);
	prod->fun = fun;
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
	PgfMetaId meta_id = gu_map_get(builder->meta_ids, cat, PgfMetaId);
	if (meta_id != 0) {
		return meta_id;
	}

	meta_id = gu_buf_length(builder->spine);
	gu_buf_push(builder->spine, GuBuf*, gu_new_buf(PgfAbsProduction*, builder->pool));

	gu_map_put(builder->meta_ids, cat, PgfMetaId, meta_id);

	GuBuf* entries = gu_map_get(builder->function_idx, cat, GuBuf*);
	if (entries != NULL) {
		size_t n_entries = gu_buf_length(entries);
		for (size_t i = 0; i < n_entries; i++) {
			PgfAbsBottomUpEntry* entry = gu_buf_index(entries, PgfAbsBottomUpEntry, i);

			PgfMetaId id = pgf_lookup_add_spine_nodes(builder, entry->fun->type->cid);
			
			PgfAbsProduction* prod = pgf_lookup_new_production(entry->fun, builder->pool);
			prod->args[entry->arg_idx] = meta_id;
			
			pgf_lookup_add_production(builder, id, prod);
		}
	}

	return meta_id;
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
pgf_lookup_build_spine(GuMap* function_idx,
                       PgfInputToken* tok, PgfType* typ, PgfMetaId* meta_id,
                       GuPool* pool)
{
	PgfSpineBuilder builder;
	builder.function_idx = function_idx;
	builder.meta_ids     = gu_new_string_map(PgfMetaId, &gu_null_struct, pool);
	builder.spine        = gu_new_buf(GuBuf*, pool);
	builder.pool         = pool;

	gu_buf_push(builder.spine, GuBuf*, NULL);

	for (size_t i = 0; i < tok->n_funs; i++) {
		pgf_lookup_add_spine_leaf(&builder, tok->funs[i]);
	}

	*meta_id = gu_map_get(builder.meta_ids, typ->cid, PgfMetaId);

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
                      PgfMetaId meta_id1, GuBuf* spine1,
                      PgfMetaId meta_id2, GuBuf* spine2,
                      GuPool* pool)
{
	if (meta_id1 == 0 && meta_id2 == 0)
		return 0;

	PgfPair pair;
	pair[0] = meta_id1;
	pair[1] = meta_id2;
	PgfMetaId meta_id = gu_map_get(pairs, &pair, PgfMetaId);
	if (meta_id != 0)
		return meta_id;

	meta_id = gu_buf_length(spine);
	GuBuf* id_prods = gu_new_buf(PgfAbsProduction*, pool);
	gu_buf_push(spine, GuBuf*, id_prods);

	gu_map_put(pairs, &pair, PgfMetaId, meta_id);

	GuBuf* id_prods1 = gu_buf_get(spine1, GuBuf*, meta_id1);
	GuBuf* id_prods2 = gu_buf_get(spine2, GuBuf*, meta_id2);
	size_t n_id_prods1 = (meta_id1 == 0) ? 0 : gu_buf_length(id_prods1);
	size_t n_id_prods2 = (meta_id2 == 0) ? 0 : gu_buf_length(id_prods2);

	if (meta_id1 != 0) {
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

	if (meta_id2 != 0) {
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

	return meta_id;
}

static GuBuf*
pgf_lookup_merge(PgfMetaId meta_id1, GuBuf* spine1,
                 PgfMetaId meta_id2, GuBuf* spine2,
                 PgfMetaId* meta_id,
                 GuPool* pool, GuPool* out_pool)
{
	GuBuf* spine = gu_new_buf(GuBuf*, out_pool);
	gu_buf_push(spine, GuBuf*, NULL);

	GuMap* pairs = gu_new_map(PgfPair, pgf_pair_hasher, PgfMetaId, &gu_null_struct, pool);

	*meta_id =
		pgf_lookup_merge_cats(spine, pairs,
		                      meta_id1, spine1,
		                      meta_id2, spine2,
		                      out_pool);

	return spine;
}

typedef struct {
	PgfLinFuncs* funcs;
	PgfConcr* concr;
	GuBuf* join;
	PgfMetaId start_id;
	GuChoice* choice;
	GuBuf* expr_tokens;
	GuBuf* ctrees;
	int max_fid;
	PgfAbsFun** curr_absfun;
	GuPool* pool;
} PgfLookupState;

typedef struct {
	GuEnum en;
	double max;
	size_t index;
	GuBuf* ctrees;
	GuPool* out_pool;
} PgfLookupEnum;

static bool
pgf_lookup_filter(GuBuf* join, PgfMetaId meta_id, GuSeq* counts, GuBuf* stack)
{
	if (meta_id == 0)
		return true;

	size_t count = gu_seq_get(counts, size_t, meta_id);
	if (count > 0)
		return true;

	size_t n_stack = gu_buf_length(stack);
	for (size_t i = 0; i < n_stack; i++) {
		PgfMetaId id = gu_buf_get(stack, PgfMetaId, i);
		if (meta_id == id) {
			return false;
		}
	}
	gu_buf_push(stack, PgfMetaId, meta_id);

	size_t pos = 0;
	size_t maximum = 0;
	GuBuf* id_prods = gu_buf_get(join, GuBuf*, meta_id);
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

	gu_seq_set(counts, size_t, meta_id, maximum);
	gu_buf_trim_n(id_prods, n_id_prods-pos);

	gu_buf_pop(stack, PgfMetaId);

	return true;
}

static void
gu_ccat_fini(GuFinalizer* fin)
{
	PgfCCat* cat = gu_container(fin, PgfCCat, fin);
	if (cat->prods != NULL)
		gu_seq_free(cat->prods);
}

static PgfCCat*
pgf_lookup_new_ccat(PgfLookupState* st, PgfCCat* ccat)
{
	PgfCCat* new_ccat = gu_new_flex(st->pool, PgfCCat, fin, 1);
	new_ccat->cnccat = ccat->cnccat;
	new_ccat->lindefs = ccat->lindefs;
	new_ccat->linrefs = ccat->linrefs;
	new_ccat->viterbi_prob = 0;
	new_ccat->fid = st->max_fid++;
	new_ccat->conts = NULL;
	new_ccat->answers = NULL;
	new_ccat->prods = NULL;
	new_ccat->n_synprods = 0;

	new_ccat->fin[0].fn = gu_ccat_fini;
	gu_pool_finally(st->pool, new_ccat->fin);

	return new_ccat;
}

static PgfCCat*
pgf_lookup_concretize(PgfLookupState* st, GuMap* cache, PgfMetaId meta_id, PgfCCat *ccat);

static PgfCCat*
pgf_lookup_concretize_coercions(PgfLookupState* st, GuMap* cache,
                                PgfMetaId meta_id, PgfCCat* ccat,
                                GuBuf* coercions)
{
	PgfPair pair;
	pair[0] = meta_id;
	pair[1] = ccat->fid;
	PgfCCat** pnew_ccat = gu_map_find(cache, &pair);
	if (pnew_ccat != NULL)
		return *pnew_ccat;

	PgfCCat* new_ccat = NULL;

	size_t n_coercions = gu_buf_length(coercions);
	for (size_t i = 0; i < n_coercions; i++) {
		PgfProductionCoerce* pcoerce =
			gu_buf_get(coercions, PgfProductionCoerce*, i);

		PgfCCat* new_coerce =
			pgf_lookup_concretize(st, cache, meta_id, pcoerce->coerce);
		if (new_coerce == NULL)
			continue;

		if (new_ccat == NULL) {
			new_ccat = pgf_lookup_new_ccat(st, ccat);
		}

		PgfProduction cnc_prod;
		PgfProductionCoerce* new_pcoerce =
			gu_new_variant(PGF_PRODUCTION_COERCE,
			               PgfProductionCoerce,
			               &cnc_prod, st->pool);
		new_pcoerce->coerce = new_coerce;

		if (new_ccat->prods == NULL || new_ccat->n_synprods >= gu_seq_length(new_ccat->prods)) {
			new_ccat->prods = gu_realloc_seq(new_ccat->prods, PgfProduction, new_ccat->n_synprods+(n_coercions-i));
		}
		gu_seq_set(new_ccat->prods, PgfProduction, new_ccat->n_synprods++, cnc_prod);

#ifdef PGF_LOOKUP_DEBUG
		{
			GuPool* tmp_pool = gu_new_pool();
			GuOut* out = gu_file_out(stderr, tmp_pool);
			GuExn* err = gu_exn(tmp_pool);
			gu_printf(out,err,"C%d -> _[C%d]\n",new_ccat->fid,new_pcoerce->coerce->fid);
			gu_pool_free(tmp_pool);
		}
#endif
	}

	gu_map_put(cache, &pair, PgfCCat*, new_ccat);

	return new_ccat;
}

static PgfCCat*
pgf_lookup_concretize(PgfLookupState* st, GuMap* cache, PgfMetaId meta_id, PgfCCat *ccat)
{
	if (meta_id == 0) {
		if (ccat->lindefs == NULL || gu_seq_length(ccat->lindefs) == 0)
			return NULL;
		return ccat;
	}

	PgfPair pair;
	pair[0] = meta_id;
	pair[1] = ccat->fid;
	PgfCCat** pnew_ccat = gu_map_find(cache, &pair);
	if (pnew_ccat != NULL)
		return *pnew_ccat;

	PgfCCat* new_ccat = NULL;

	GuBuf* id_prods = gu_buf_get(st->join, GuBuf*, meta_id);

	size_t n_id_prods = gu_buf_length(id_prods);
	for (size_t i = 0; i < n_id_prods; i++) {
		PgfAbsProduction* prod =
			gu_buf_get(id_prods, PgfAbsProduction*, i);

		PgfCncOverloadMap* overl_table =
			gu_map_get(st->concr->fun_indices, prod->fun->name, PgfCncOverloadMap*);
		if (overl_table == NULL)
			continue;

		GuBuf* buf =
			gu_map_get(overl_table, ccat, GuBuf*);
		if (buf == NULL)
			continue;

		size_t n_prods = gu_buf_length(buf);
		for (size_t j = 0; j < n_prods; j++) {
			PgfProductionApply* papply =
				gu_buf_get(buf, PgfProductionApply*, j);

			size_t n_args   = gu_seq_length(papply->args);
			GuSeq* new_args = gu_new_seq(PgfPArg, n_args, st->pool);
			for (size_t k = 0; k < n_args; k++) {
				PgfPArg* parg     = gu_seq_index(papply->args, PgfPArg, k);
				PgfPArg* new_parg = gu_seq_index(new_args, PgfPArg, k);

				new_parg->hypos = parg->hypos;

				GuBuf* coercions =
					gu_map_get(st->concr->coerce_idx, parg->ccat, GuBuf*);
				if (coercions == NULL) {
					new_parg->ccat =
						pgf_lookup_concretize(st, cache, prod->args[k], parg->ccat);
				} else {
					new_parg->ccat =
						pgf_lookup_concretize_coercions(st, cache, prod->args[k], parg->ccat, coercions);
				}

				if (new_parg->ccat == NULL)
					goto skip;
			}

			if (new_ccat == NULL) {
				new_ccat = pgf_lookup_new_ccat(st, ccat);
			}

			PgfProduction cnc_prod;
			PgfProductionApply* new_papp = 
				gu_new_variant(PGF_PRODUCTION_APPLY,
				               PgfProductionApply,
				               &cnc_prod, st->pool);
			new_papp->fun  = papply->fun;
			new_papp->args = new_args;

			if (new_ccat->prods == NULL || new_ccat->n_synprods >= gu_seq_length(new_ccat->prods)) {
				new_ccat->prods = gu_realloc_seq(new_ccat->prods, PgfProduction, new_ccat->n_synprods+(n_prods-j));
			}
			gu_seq_set(new_ccat->prods, PgfProduction, new_ccat->n_synprods++, cnc_prod);

#ifdef PGF_LOOKUP_DEBUG
			{
				GuPool* tmp_pool = gu_new_pool();
				GuOut* out = gu_file_out(stderr, tmp_pool);
				GuExn* err = gu_exn(tmp_pool);

				gu_printf(out,err,"C%d -> F%d[",new_ccat->fid,new_papp->fun->funid);

				size_t n_args = gu_seq_length(new_papp->args);
				for (size_t l = 0; l < n_args; l++) {
					if (l > 0)
						gu_putc(',',out,err);

					PgfPArg arg = gu_seq_get(new_papp->args, PgfPArg, l);

					if (arg.hypos != NULL) {
						size_t n_hypos = gu_seq_length(arg.hypos);
						for (size_t r = 0; r < n_hypos; r++) {
							if (r > 0)
								gu_putc(' ',out,err);
							PgfCCat *hypo = gu_seq_get(arg.hypos, PgfCCat*, r);
							gu_printf(out,err,"C%d",hypo->fid);
						}
					}

					gu_printf(out,err,"C%d",arg.ccat->fid);
				}
				gu_printf(out,err,"]\n");
				gu_pool_free(tmp_pool);
			}
#endif

skip:;
		}
	}

	gu_map_put(cache, &pair, PgfCCat*, new_ccat);

	return new_ccat;
}

static PgfCncTree
pgf_lookup_extract(PgfLookupState* st, PgfCCat* ccat)
{
	PgfCncTree ret;

	if (ccat->fid < st->concr->total_cats) {
		int index =
			gu_choice_next(st->choice, gu_seq_length(ccat->lindefs));

		PgfCncTreeApp* capp =
			gu_new_flex_variant(PGF_CNC_TREE_APP,
			                    PgfCncTreeApp,
			                    args, 1, &ret, st->pool);
		capp->ccat = ccat;
		capp->fun = gu_seq_get(ccat->lindefs, PgfCncFun*, index);
		capp->fid = 0;
		capp->n_vars = 0;
		capp->context = NULL;
		capp->n_args = 1;

		PgfCncTreeChunks* chunks =
			gu_new_flex_variant(PGF_CNC_TREE_CHUNKS,
			                    PgfCncTreeChunks,
			                    args, 0, &capp->args[0], st->pool);
		chunks->n_vars  = 0;
		chunks->context = NULL;
		chunks->n_args  = 0;
	} else {
		int index =
			gu_choice_next(st->choice, ccat->n_synprods);

		PgfProduction prod = 
			gu_seq_get(ccat->prods, PgfProduction, index);

		GuVariantInfo i = gu_variant_open(prod);
		switch (i.tag) {
		case PGF_PRODUCTION_APPLY: {
			PgfProductionApply* papply = i.data;

			size_t n_args = gu_seq_length(papply->args);
			PgfCncTreeApp* capp =
				gu_new_flex_variant(PGF_CNC_TREE_APP,
				                    PgfCncTreeApp,
				                    args, n_args, &ret, st->pool);
			capp->ccat = ccat;
			capp->fun = papply->fun;
			capp->fid = 0;
			capp->n_vars = 0;
			capp->context = NULL;
			capp->n_args = n_args;

			for (size_t i = 0; i < n_args; i++) {
				PgfPArg* arg = gu_seq_index(papply->args, PgfPArg, i);
				capp->args[i] = pgf_lookup_extract(st, arg->ccat);
			}
			break;
		}
		case PGF_PRODUCTION_COERCE: {
			PgfProductionCoerce* pcoerce = i.data;
			ret = pgf_lookup_extract(st, pcoerce->coerce);
			break;
		}
		default:
			gu_impossible();
		}
	}

	return ret;
}

static GuBuf*
pgf_lookup_tokenize(GuMap* lexicon_idx, GuString sentence, GuPool* pool)
{	
	GuBuf* tokens = gu_new_buf(PgfInputToken, pool);

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

		PgfInputToken* tok = gu_buf_extend(tokens);

		size_t len = end-start;
		tok->token = gu_malloc(pool, len+1);
		memcpy((uint8_t*) tok->token, start, len);
		((uint8_t*) tok->token)[len] = 0;

		GuBuf* funs = gu_map_get(lexicon_idx, tok->token, GuBuf*);
		if (funs != NULL) {
			tok->n_funs = gu_buf_length(funs);
			tok->funs   = gu_buf_data(funs);
		} else {
			tok->n_funs = 0;
			tok->funs   = NULL;
		}
	}

	return tokens;
}

static double
pgf_lookup_compute_kernel_helper(GuBuf* sentence_tokens, GuBuf* expr_tokens,
                                 double* matrix, size_t i, size_t j)
{
	size_t dim = gu_buf_length(sentence_tokens)+1;

	double score = matrix[i + dim*j];

	if (score < 0) {
		score = 0;
		for (size_t l = 0; l < i; l++) {
			matrix[l + dim*j] = score;
			for (size_t k = j; k > 0; k--) {
				PgfInputToken* sentence_token = gu_buf_index(sentence_tokens, PgfInputToken, l);
				PgfInputToken* expr_token     = gu_buf_index(expr_tokens, PgfInputToken, k-1);

				if (strcmp(sentence_token->token, expr_token->token) == 0) {
					score += 1 + pgf_lookup_compute_kernel_helper(sentence_tokens, expr_tokens, matrix, l, k-1);
				} else {
					bool match = false;
					for (size_t i = 0; i < sentence_token->n_funs; i++) {
						for (size_t j = 0; j < expr_token->n_funs; j++) {
							if (sentence_token->funs[i] == expr_token->funs[j]) {
								match = true;
								goto done;
							}
						}
					}
				done:
					if (match) {
						score += 0.5 + pgf_lookup_compute_kernel_helper(sentence_tokens, expr_tokens, matrix, l, k-1);
					}
				}
			}
		}
		matrix[i + dim*j] = score;
	}

	return score;
}

static double
pgf_lookup_compute_kernel(GuBuf* sentence_tokens, GuBuf* expr_tokens)
{
	size_t n_sentence_tokens = gu_buf_length(sentence_tokens);
	size_t n_expr_tokens     = gu_buf_length(expr_tokens);
	size_t size              = (n_sentence_tokens+1)*(n_expr_tokens+1);
	double* matrix = alloca(size*sizeof(double));

	for (size_t i = 0; i < size; i++) {
		matrix[i] = -1;
	}

	return
		pgf_lookup_compute_kernel_helper(sentence_tokens,expr_tokens,matrix,
		                                 n_sentence_tokens,n_expr_tokens);
}

typedef struct {
	PgfCncTree ctree;
	double score;
} PgfCncTreeScore;

static void
pgf_lookup_ctree_to_expr(PgfCncTree ctree, PgfExprProb* ep,
                         GuPool* out_pool)
{
	size_t n_args = 0;
	PgfCncTree* args = NULL;

	GuVariantInfo cti = gu_variant_open(ctree);
	switch (cti.tag) {
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* fapp = cti.data;
		*ep    = fapp->fun->absfun->ep;
		n_args = fapp->n_args;
		args   = fapp->args;
		break;
	}
	case PGF_CNC_TREE_CHUNKS: {
		PgfCncTreeChunks* fchunks = cti.data;
		n_args = fchunks->n_args;
		args   = fchunks->args;
		
		ep->expr = gu_new_variant_i(out_pool, 
		                            PGF_EXPR_META, PgfExprMeta,
		                            .id = 0);
		ep->prob = 0;
		break;
	}
/*	case PGF_CNC_TREE_LIT: {
		PgfCncTreeLit* flit = cti.data;
		break;
	}*/
	default:
		gu_impossible();
	}
	
	if (gu_variant_is_null(ep->expr)) {
		gu_assert(n_args==1);
		pgf_lookup_ctree_to_expr(args[0], ep, out_pool);
	} else {
		for (size_t i = 0; i < n_args; i++) {
			PgfExprProb ep_arg;
			pgf_lookup_ctree_to_expr(args[i], &ep_arg, out_pool);

			
			ep->expr = gu_new_variant_i(out_pool,
										PGF_EXPR_APP,
										PgfExprApp,
										ep->expr, ep_arg.expr);
			ep->prob += ep_arg.prob;
		}
	}
}

static void
pgf_lookup_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfLookupEnum* st = gu_container(self, PgfLookupEnum, en);
	PgfCncTreeScore* cts = NULL;

	while (st->index < gu_buf_length(st->ctrees)) {
		cts = gu_buf_index(st->ctrees, PgfCncTreeScore, st->index);
		st->index++;
		if (cts->score == st->max) {
			PgfExprProb* ep = gu_new(PgfExprProb, st->out_pool);
			pgf_lookup_ctree_to_expr(cts->ctree, ep, st->out_pool);
			*((PgfExprProb**) to) = ep;
			return;
		}
	}

	*((PgfExprProb**) to) = NULL;
}

static void
pgf_lookup_symbol_token(PgfLinFuncs** self, PgfToken token)
{
	PgfLookupState* st = gu_container(self, PgfLookupState, funcs);
	PgfInputToken* tok = gu_buf_extend(st->expr_tokens);
	tok->token  = token;
	tok->n_funs = st->curr_absfun ? 1 : 0;
	tok->funs   = st->curr_absfun;
}

static void
pgf_lookup_begin_phrase(PgfLinFuncs** self, PgfCId cat, int fid, int lindex, PgfCId funname)
{
	PgfLookupState* st = gu_container(self, PgfLookupState, funcs);
	
	PgfAbsFun* absfun = gu_seq_binsearch(st->concr->abstr->funs, pgf_absfun_order, PgfAbsFun, funname);
	if (absfun != NULL) {
		st->curr_absfun = gu_new(PgfAbsFun*, st->pool);
		*st->curr_absfun = absfun;
	} else {
		st->curr_absfun = NULL;
	}
}

static void
pgf_lookup_end_phrase(PgfLinFuncs** self, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfLookupState* st = gu_container(self, PgfLookupState, funcs);
	st->curr_absfun = NULL;
}

static PgfLinFuncs pgf_lookup_lin_funcs = {
	.symbol_token = pgf_lookup_symbol_token,
	.begin_phrase = pgf_lookup_begin_phrase,
	.end_phrase   = pgf_lookup_end_phrase,
	.symbol_ne    = NULL,
	.symbol_bind  = NULL,
	.symbol_capit = NULL
};

PGF_API GuEnum*
pgf_lookup_sentence(PgfConcr* concr, PgfType* typ, GuString sentence, GuPool* pool, GuPool* out_pool)
{
	//// building search indices //
	GuMap* lexicon_idx = gu_new_string_map(GuBuf*, &gu_null_struct, pool);
	size_t n_cncfuns = gu_seq_length(concr->cncfuns);
	for (size_t i = 0; i < n_cncfuns; i++) {
		PgfCncFun* cncfun = gu_seq_get(concr->cncfuns, PgfCncFun*, i);
		for (size_t lin_idx = 0; lin_idx < cncfun->n_lins; lin_idx++) {
			pgf_lookup_index_syms(lexicon_idx, cncfun->lins[lin_idx]->syms, cncfun->absfun, pool);
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

	GuBuf* sentence_tokens =
		pgf_lookup_tokenize(lexicon_idx, sentence, work_pool);

	PgfMetaId meta_id1 = 0;
	GuBuf* join = gu_new_buf(GuBuf*, pool);
	gu_buf_push(join, GuBuf*, NULL);

	size_t n_tokens = gu_buf_length(sentence_tokens);
	for (size_t i = 0; i < n_tokens; i++) {
		PgfInputToken* tok = gu_buf_index(sentence_tokens, PgfInputToken, i);

		PgfMetaId meta_id2 = 0;
		GuBuf* spine =
			pgf_lookup_build_spine(function_idx,
			                       tok, typ, &meta_id2,
			                       work_pool);

		join = pgf_lookup_merge(meta_id1, join, meta_id2, spine, &meta_id1, work_pool, pool);
	}

	size_t n_cats = gu_buf_length(join);
	GuBuf* stack = gu_new_buf(PgfMetaId, work_pool);
	GuSeq* counts = gu_new_seq(size_t, n_cats, work_pool);
	for (size_t i = 0; i < n_cats; i++) {
		gu_seq_set(counts, size_t, i, 0);
	}
	pgf_lookup_filter(join, meta_id1, counts, stack);
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

	PgfLookupState st;
	st.funcs   = &pgf_lookup_lin_funcs;
	st.concr   = concr;
	st.join    = join;
	st.start_id= meta_id1;
	st.choice  = gu_new_choice(work_pool);
	st.expr_tokens=gu_new_buf(PgfInputToken, work_pool);
	st.ctrees  = gu_new_buf(PgfCncTreeScore, pool);
	st.curr_absfun= NULL;
	st.max_fid = concr->total_cats;
	st.pool    = pool;

	GuMap* cache = gu_new_map(PgfPair, pgf_pair_hasher, PgfCCat*, &gu_null_struct, pool);

	double sentence_value =
		pgf_lookup_compute_kernel(sentence_tokens, sentence_tokens);

	double max = 0;

	PgfCncCat* cnccat =
		gu_map_get(concr->cnccats, typ->cid, PgfCncCat*);
	size_t n_ccats = gu_seq_length(cnccat->cats);
	for (size_t i = 0; i < n_ccats; i++) {
		PgfCCat* ccat = gu_seq_get(cnccat->cats, PgfCCat*, i);
		PgfCCat* new_ccat = pgf_lookup_concretize(&st, cache, st.start_id, ccat);
		if (new_ccat == NULL)
			continue;

		GuChoiceMark mark = gu_choice_mark(st.choice);

		for (;;) {
			PgfCncTreeScore* cts = gu_buf_extend(st.ctrees);
			cts->ctree =
				pgf_lookup_extract(&st, new_ccat);

			cts->ctree = pgf_lzr_wrap_linref(cts->ctree, st.pool);
			pgf_lzr_linearize(concr, cts->ctree, 0, &st.funcs, st.pool);

			double value = pgf_lookup_compute_kernel(sentence_tokens, st.expr_tokens);
			double expr_value = pgf_lookup_compute_kernel(st.expr_tokens, st.expr_tokens);
			cts->score =
				value / sqrt(sentence_value * expr_value);

			gu_buf_flush(st.expr_tokens);

#ifdef PGF_LINEARIZER_DEBUG
			{
				GuPool* tmp_pool = gu_new_pool();
				GuOut* out = gu_file_out(stderr, tmp_pool);
				GuExn* err = gu_exn(tmp_pool);
				pgf_lzr_linearize_simple(concr, cts->ctree, 0,
                                         out, err, tmp_pool);
				gu_putc('\n', out, err);
				pgf_print_cnc_tree(cts->ctree, out, err);
				gu_printf(out, err, " [%.1f/sqrt(%.1f*%.1f)=%f]\n\n", value, sentence_value, expr_value, cts->score);
				gu_pool_free(tmp_pool);
			}
#endif

			if (cts->score > max) {
				max = cts->score;
			}

			gu_choice_reset(st.choice, mark);

			if (!gu_choice_advance(st.choice))
				break;
		}
	}

	gu_pool_free(work_pool);


	PgfLookupEnum* lenum = gu_new(PgfLookupEnum, pool);
	lenum->en.next = pgf_lookup_enum_next;
	lenum->max     = max;
	lenum->index   = 0;
	lenum->ctrees  = st.ctrees;
	lenum->out_pool= out_pool;
	return &lenum->en;
}
