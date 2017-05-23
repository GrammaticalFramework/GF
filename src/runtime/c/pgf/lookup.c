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

#ifdef PGF_LINEARIZER_DEBUG
PGF_INTERNAL_DECL void
pgf_print_cnc_tree(PgfCncTree ctree, GuOut* out, GuExn* err);
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
	PgfLinFuncs* funcs;
	PgfConcr* concr;
	GuBuf* join;
	PgfMetaId start_id;
	GuChoice* choice;
	GuBuf* stack;
	GuBuf* expr_tokens;
	GuBuf* ctrees;
	int fid;
	GuPool* pool;
} PgfLookupState;

typedef struct {
	GuEnum en;
	double max;
	size_t index;
	GuBuf* ctrees;
	GuPool* out_pool;
} PgfLookupEnum;

static PgfCncTree
pgf_lookup_extract(PgfLookupState* st, PgfMetaId meta_id, PgfCCat *ccat);

static PgfCncTree
pgf_lookup_extract_app(PgfLookupState* st,
                       PgfCCat* ccat, GuBuf* buf,
                       size_t n_args, PgfMetaId* args)
{
	GuChoiceMark mark = gu_choice_mark(st->choice);
	int save_fid = st->fid;

	PgfCncTree ret = gu_null_variant;
	PgfCncTreeApp* capp =
		gu_new_flex_variant(PGF_CNC_TREE_APP,
							PgfCncTreeApp,
							args, n_args, &ret, st->pool);
	capp->ccat    = ccat;
	capp->n_vars  = 0;
	capp->context = NULL;

redo:;
	int index = gu_choice_next(st->choice, gu_buf_length(buf));
	if (index < 0) {
		return gu_null_variant;
	}

	PgfProductionApply* papply =
		gu_buf_get(buf, PgfProductionApply*, index);
	gu_assert(n_args == gu_seq_length(papply->args));

	capp->fun = papply->fun;
	capp->fid = 0;
	capp->n_args = n_args;

	for (size_t i = 0; i < n_args; i++) {
		PgfPArg* parg     = gu_seq_index(papply->args, PgfPArg, i);
		PgfMetaId meta_id = args[i];
		
		PgfCCat* ccat = NULL;
		GuBuf* coercions =
			gu_map_get(st->concr->coerce_idx, parg->ccat, GuBuf*);
		if (coercions == NULL) {
			ccat = parg->ccat;
		} else {
			int index = gu_choice_next(st->choice, gu_buf_length(coercions));
			if (index < 0) {
				st->fid = save_fid;
				gu_choice_reset(st->choice, mark);
				if (!gu_choice_advance(st->choice))
					return gu_null_variant;
				goto redo;
			}

			PgfProductionCoerce* pcoerce =
				gu_buf_get(coercions, PgfProductionCoerce*, index);
			ccat = pcoerce->coerce;
		}

		capp->args[i] =
			pgf_lookup_extract(st, meta_id, ccat);
		if (gu_variant_is_null(capp->args[i])) {
			gu_choice_reset(st->choice, mark);
			if (!gu_choice_advance(st->choice))
				return gu_null_variant;
			goto redo;
		}
	}

	return ret;
}

typedef struct {
	GuMapItor fn;
	int index;
	PgfCCat* ccat;
	GuBuf* buf;
} PgfCncItor;

static void
pgf_cnc_cat_resolve_itor(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCncItor* clo = (PgfCncItor*) fn;
	PgfCCat* ccat = (PgfCCat*) key;
	GuBuf* buf = *((GuBuf**) value);

	if (clo->index == 0) {
		clo->ccat = ccat;
		clo->buf = buf;
	}

	clo->index--;
}

static PgfCncTree
pgf_lookup_extract(PgfLookupState* st, PgfMetaId meta_id, PgfCCat *ccat)
{
	PgfCncTree ret = gu_null_variant;

	GuBuf* id_prods = gu_buf_get(st->join, GuBuf*, meta_id);

	if (id_prods == NULL || gu_buf_length(id_prods) == 0) {
		PgfCncTree chunks_tree;
		PgfCncTreeChunks* chunks =
			gu_new_flex_variant(PGF_CNC_TREE_CHUNKS,
			                    PgfCncTreeChunks,
			                    args, 0, &chunks_tree, st->pool);
		chunks->n_vars  = 0;
		chunks->context = NULL;
		chunks->n_args  = 0;

		if (ccat == NULL) {
			return chunks_tree;
		}
		if (ccat->lindefs == NULL) {
			return ret;
		}

		int index =
			gu_choice_next(st->choice, gu_seq_length(ccat->lindefs));
		if (index < 0) {
			return ret;
		}
		PgfCncTreeApp* capp =
			gu_new_flex_variant(PGF_CNC_TREE_APP,
			                    PgfCncTreeApp,
			                    args, 1, &ret, st->pool);
		capp->ccat = ccat;
		capp->fun = gu_seq_get(ccat->lindefs, PgfCncFun*, index);
		capp->fid = st->fid++;
		capp->n_vars = 0;
		capp->context = NULL;
		capp->n_args = 1;
		capp->args[0] = chunks_tree;

		return ret;
	}

	size_t n_stack = gu_buf_length(st->stack);
	for (size_t i = 0; i < n_stack; i++) {
		PgfMetaId id = gu_buf_get(st->stack, PgfMetaId, i);
		if (meta_id == id) {
			return gu_null_variant;
		}
	}
	gu_buf_push(st->stack, PgfMetaId, meta_id);

	size_t n_id_prods = gu_buf_length(id_prods);

	size_t i = gu_choice_next(st->choice, n_id_prods);
	PgfAbsProduction* prod =
		gu_buf_get(id_prods, PgfAbsProduction*, i);

	size_t n_args = gu_seq_length(prod->fun->type->hypos);

	PgfCncOverloadMap* overl_table =
		gu_map_get(st->concr->fun_indices, prod->fun->name, PgfCncOverloadMap*);
	if (overl_table == NULL) {
		return gu_null_variant;
	}

	if (ccat == NULL) {
		size_t n_count = gu_map_count(overl_table);
		GuChoiceMark mark = gu_choice_mark(st->choice);

redo:;
		int index = gu_choice_next(st->choice, n_count);
		if (index < 0) {
			goto done;
		}

		PgfCncItor clo = { { pgf_cnc_cat_resolve_itor }, index, NULL, NULL };
		gu_map_iter(overl_table, &clo.fn, NULL);
		assert(clo.ccat != NULL && clo.buf != NULL);

		ret = pgf_lookup_extract_app(st, clo.ccat, clo.buf, n_args, prod->args);
		if (gu_variant_is_null(ret)) {
			gu_choice_reset(st->choice, mark);
			if (gu_choice_advance(st->choice))
				goto redo;
		}
	} else {
		GuBuf* buf =
			gu_map_get(overl_table, ccat, GuBuf*);
		if (buf == NULL) {
			goto done;
		}

		ret = pgf_lookup_extract_app(st, ccat, buf, n_args, prod->args);
	}
done:

	gu_buf_pop(st->stack, PgfMetaId);
	return ret;
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

static long
pgf_lookup_compute_kernel_helper1(GuBuf* sentence_tokens, GuBuf* expr_tokens,
                                  long* matrix, size_t i, size_t j);

static long
pgf_lookup_compute_kernel_helper2(GuBuf* sentence_tokens, GuBuf* expr_tokens,
                                  long* matrix, size_t i, size_t j)
{
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

static long
pgf_lookup_compute_kernel_helper1(GuBuf* sentence_tokens, GuBuf* expr_tokens,
                                  long* matrix, size_t i, size_t j)
{
	size_t n_sentence_tokens = gu_buf_length(sentence_tokens);

	long score = matrix[i+n_sentence_tokens*j];
	if (score == -1) {
		if (i >= n_sentence_tokens)
			score = 0;
		else
			score = pgf_lookup_compute_kernel_helper1(sentence_tokens, expr_tokens,
                                                      matrix, i+1, j)
                  + pgf_lookup_compute_kernel_helper2(sentence_tokens, expr_tokens,
                                                      matrix, i,   j);
		matrix[i + n_sentence_tokens*j] = score;
	}

	return score;
}

static long
pgf_lookup_compute_kernel(GuBuf* sentence_tokens, GuBuf* expr_tokens)
{
	size_t n_sentence_tokens = gu_buf_length(sentence_tokens);
	size_t n_expr_tokens     = gu_buf_length(expr_tokens);
	size_t size              = (n_sentence_tokens+1)*(n_expr_tokens+1)*sizeof(long);
	long* matrix = alloca(size);
	memset(matrix, -1, size);

	return pgf_lookup_compute_kernel_helper1(sentence_tokens, expr_tokens, matrix, 0, 0);
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
pgf_lookup_symbol_token(PgfLinFuncs** funcs, PgfToken tok)
{
	PgfLookupState* st = gu_container(funcs, PgfLookupState, funcs);
	gu_buf_push(st->expr_tokens, PgfToken, tok);
}

static PgfLinFuncs pgf_lookup_lin_funcs = {
	.symbol_token = pgf_lookup_symbol_token,
	.begin_phrase = NULL,
	.end_phrase   = NULL,
	.symbol_ne    = NULL,
	.symbol_bind  = NULL,
	.symbol_capit = NULL
};

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
	st.funcs   = &pgf_lookup_lin_funcs;
	st.concr   = concr;
	st.join    = join;
	st.start_id= meta_id1;
	st.choice  = gu_new_choice(work_pool);
	st.stack   = gu_new_buf(PgfMetaId, work_pool);
	st.expr_tokens=gu_new_buf(GuString, work_pool);
	st.ctrees  = gu_new_buf(PgfCncTreeScore, pool);
	st.fid     = 0;
	st.pool    = pool;

	GuChoiceMark mark = gu_choice_mark(st.choice);
	
	long sentence_value = 
		pgf_lookup_compute_kernel(sentence_tokens, sentence_tokens);

	double max = 0;
	PgfCncTreeScore* cts = gu_buf_extend(st.ctrees);
	for (;;) {
		cts->ctree =
			pgf_lookup_extract(&st, st.start_id, NULL);

		if (!gu_variant_is_null(cts->ctree)) {
			cts->ctree = pgf_lzr_wrap_linref(cts->ctree, st.pool);
			pgf_lzr_linearize(concr, cts->ctree, 0, &st.funcs, st.pool);

			cts->score =
				((double) pgf_lookup_compute_kernel(sentence_tokens, st.expr_tokens)) /
				sqrt(((double) sentence_value) * ((double) pgf_lookup_compute_kernel(st.expr_tokens, st.expr_tokens)));

			gu_buf_flush(st.expr_tokens);

#ifdef PGF_LINEARIZER_DEBUG
			{
				GuPool* tmp_pool = gu_new_pool();
				GuOut* out = gu_file_out(stderr, tmp_pool);
				GuExn* err = gu_exn(tmp_pool);
				pgf_print_cnc_tree(cts->ctree, out, err);
				gu_printf(out, err, " [%f]\n", cts->score);
				gu_pool_free(tmp_pool);
			}
#endif

			if (cts->score > max) {
				max = cts->score;
			}

			cts = gu_buf_extend(st.ctrees);
		}
		
		gu_choice_reset(st.choice, mark);

		if (!gu_choice_advance(st.choice))
			break;
	}
	gu_buf_trim(st.ctrees);

	gu_pool_free(work_pool);

	PgfLookupEnum* lenum = gu_new(PgfLookupEnum, pool);
	lenum->en.next = pgf_lookup_enum_next;
	lenum->max     = max;
	lenum->index   = 0;
	lenum->ctrees  = st.ctrees;
	lenum->out_pool= out_pool;
	return &lenum->en;
}
