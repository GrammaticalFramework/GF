#include <gu/map.h>
#include <gu/mem.h>
#include <gu/utf8.h>
#include <gu/file.h>
#include <gu/string.h>
#include <gu/choice.h>
#include <pgf/data.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

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
	GuMap* meta_ids;
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
pgf_lookup_build_spine(GuMap* lexicon_idx, GuMap* function_idx,
                       GuString tok, PgfType* typ, PgfMetaId* meta_id,
                       GuPool* pool)
{
	PgfSpineBuilder builder;
	builder.function_idx = function_idx;
	builder.meta_ids     = gu_new_string_map(PgfMetaId, &gu_null_struct, pool);
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
	GuBuf* join;
	PgfMetaId start_id;
	GuChoice* choice;
	GuBuf* stack;
	GuBuf* exprs;
	GuPool* out_pool;
} PgfLookupState;

typedef struct {
	GuEnum en;
	double max;
	size_t index;
	GuBuf* exprs;
} PgfLookupEnum;

static bool
pgf_lookup_extract(PgfLookupState* st, PgfMetaId meta_id, PgfExprProb* ep)
{
	GuBuf* id_prods = gu_buf_get(st->join, GuBuf*, meta_id);

	if (id_prods == NULL || gu_buf_length(id_prods) == 0) {
		ep->expr = gu_new_variant_i(st->out_pool,
					                PGF_EXPR_META,
					                PgfExprMeta,
					                meta_id);
		ep->prob = 0;
		return true;
	}

	size_t n_stack = gu_buf_length(st->stack);
	for (size_t i = 0; i < n_stack; i++) {
		PgfMetaId id = gu_buf_get(st->stack, PgfMetaId, i);
		if (meta_id == id) {
			return false;
		}
	}
	gu_buf_push(st->stack, PgfMetaId, meta_id);

	size_t n_id_prods = gu_buf_length(id_prods);

	size_t i = gu_choice_next(st->choice, n_id_prods);
	PgfAbsProduction* prod =
		gu_buf_get(id_prods, PgfAbsProduction*, i);

	*ep = prod->fun->ep;
	bool res = true;
	size_t n_args = gu_seq_length(prod->fun->type->hypos);
	for (size_t j = 0; j < n_args; j++) {
		PgfExprProb ep_arg;
		if (!pgf_lookup_extract(st, prod->args[j], &ep_arg)) {
			res = false;
			break;
		}

		ep->expr = gu_new_variant_i(st->out_pool,
						PGF_EXPR_APP,
						PgfExprApp,
						ep->expr, ep_arg.expr);
		ep->prob += ep_arg.prob;
	}
	
	gu_buf_pop(st->stack, PgfMetaId);
	return res;
}

static GuBuf*
pgf_lookup_tokenize(GuString buf, size_t len, GuPool* pool)
{	
	GuBuf* tokens = gu_new_buf(GuString, pool);

	GuUCS c = ' ';
	const uint8_t* p = (const uint8_t*) buf;
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
		GuString tok = gu_malloc(pool, len+1);
		memcpy((uint8_t*) tok, start, len);
		((uint8_t*) tok)[len] = 0;

		gu_buf_push(tokens, GuString, tok);
	}
	
	return tokens;
}

static int
pgf_lookup_compute_kernel_helper1(GuBuf* sentence_tokens, GuBuf* expr_tokens,
                                  int* matrix, size_t i, size_t j);

static int
pgf_lookup_compute_kernel_helper2(GuBuf* sentence_tokens, GuBuf* expr_tokens,
                                  int* matrix, size_t i, size_t j)
{
//	size_t n_sentence_tokens = gu_buf_length(sentence_tokens);
	size_t n_expr_tokens     = gu_buf_length(expr_tokens);
	
	if (j >= n_expr_tokens)
		return 0;
		
	GuString sentence_token = gu_buf_get(sentence_tokens, GuString, i);
	GuString expr_token     = gu_buf_get(expr_tokens, GuString, j);
	if (strcmp(sentence_token, expr_token) == 0) {
		return 1 + 
		       pgf_lookup_compute_kernel_helper1(sentence_tokens, expr_tokens,
                                                 matrix, i+1, j+1) +
               pgf_lookup_compute_kernel_helper2(sentence_tokens, expr_tokens,
                                                 matrix, i,   j+1);
	} else {
		return pgf_lookup_compute_kernel_helper2(sentence_tokens, expr_tokens, matrix, i, j+1);
	}
}

static int
pgf_lookup_compute_kernel_helper1(GuBuf* sentence_tokens, GuBuf* expr_tokens,
                                  int* matrix, size_t i, size_t j)
{
	size_t n_sentence_tokens = gu_buf_length(sentence_tokens);
//	size_t n_expr_tokens     = gu_buf_length(expr_tokens);

	int score = matrix[i+n_sentence_tokens*j];
	if (score == -1) {
		if (i >= n_sentence_tokens)
			score = 0;
		else
			score = pgf_lookup_compute_kernel_helper1(sentence_tokens, expr_tokens,
                                                      matrix, i+1, j)
                  + pgf_lookup_compute_kernel_helper2(sentence_tokens, expr_tokens,
                                                      matrix, i,   j);
		matrix[n_sentence_tokens*i + j] = score;
	}

	return score;
}

static int
pgf_lookup_compute_kernel(GuBuf* sentence_tokens, GuBuf* expr_tokens)
{
	size_t n_sentence_tokens = gu_buf_length(sentence_tokens);
	size_t n_expr_tokens     = gu_buf_length(expr_tokens);
	size_t size              = (n_sentence_tokens+1)*(n_expr_tokens+1)*sizeof(int);
	int* matrix = alloca(size);
	memset(matrix, -1, size);

	return pgf_lookup_compute_kernel_helper1(sentence_tokens, expr_tokens, matrix, 0, 0);
}

typedef struct {
	PgfExprProb ep;
	double score;
} PgfExprScore;

static void
pgf_lookup_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfLookupEnum* st = gu_container(self, PgfLookupEnum, en);
	PgfExprScore* es = NULL;

	while (st->index < gu_buf_length(st->exprs)) {
		es = gu_buf_index(st->exprs, PgfExprScore, st->index);
		st->index++;
		if (fabs(es->score - st->max) < 0.00005) {
			*((PgfExprProb**) to) = &es->ep;
			return;
		}
	}

	*((PgfExprProb**) to) = NULL;
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

	GuBuf* sentence_tokens =
		pgf_lookup_tokenize(sentence,
		                    strlen(sentence),
		                    work_pool);

	PgfMetaId meta_id1 = 0;
	GuBuf* join = gu_new_buf(GuBuf*, pool);
	gu_buf_push(join, GuBuf*, NULL);

	size_t n_tokens = gu_buf_length(sentence_tokens);
	for (size_t i = 0; i < n_tokens; i++) {
		GuString tok = gu_buf_get(sentence_tokens, GuString, i);

		PgfMetaId meta_id2 = 0;
		GuBuf* spine =
			pgf_lookup_build_spine(lexicon_idx, function_idx,
			                       tok, typ, &meta_id2,
			                       work_pool);

		join = pgf_lookup_merge(meta_id1, join, meta_id2, spine, &meta_id1, work_pool, pool);
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
	st.join    = join;
	st.start_id= meta_id1;
	st.choice  = gu_new_choice(work_pool);
	st.stack   = gu_new_buf(PgfMetaId, work_pool);
	st.exprs   = gu_new_buf(PgfExprScore, pool);
	st.out_pool= out_pool;

	GuChoiceMark mark = gu_choice_mark(st.choice);

	double max = 0;
	PgfExprScore* es = gu_buf_extend(st.exprs);
	for (;;) {
		bool res = pgf_lookup_extract(&st, st.start_id, &es->ep);

		gu_choice_reset(st.choice, mark);

		if (!gu_choice_advance(st.choice))
			break;

		if (res) {
			GuExn* err = gu_exn(work_pool);
			GuStringBuf* sbuf = gu_new_string_buf(work_pool);
			GuOut* out = gu_string_buf_out(sbuf);

			pgf_linearize(concr, es->ep.expr, out, err);
			if (!gu_ok(err)) {
				continue;
			}

			GuBuf* expr_tokens =
				pgf_lookup_tokenize(gu_string_buf_data(sbuf),
									gu_string_buf_length(sbuf),
									work_pool);

			es->score =
				((double) pgf_lookup_compute_kernel(sentence_tokens, expr_tokens)) /
				sqrt(((double) pgf_lookup_compute_kernel(sentence_tokens, sentence_tokens)) * ((double) pgf_lookup_compute_kernel(expr_tokens, expr_tokens)));

#ifdef PGF_LOOKUP_DEBUG
			{
				GuPool* tmp_pool = gu_new_pool();
				GuOut* out = gu_file_out(stderr, tmp_pool);
				GuExn* err = gu_exn(tmp_pool);
				pgf_print_expr(es->ep.expr, NULL, 0, out, err);
				gu_printf(out, err, " [%f]\n", es->score);
				gu_pool_free(tmp_pool);
			}
#endif

			if (es->score > max) {
				max = es->score;
			}

			es = gu_buf_extend(st.exprs);
		}
	}
	gu_buf_trim(st.exprs);

	gu_pool_free(work_pool);

	PgfLookupEnum* lenum = gu_new(PgfLookupEnum, pool);
	lenum->en.next = pgf_lookup_enum_next;
	lenum->max     = max;
	lenum->index   = 0;
	lenum->exprs   = st.exprs;
	return &lenum->en;
}
