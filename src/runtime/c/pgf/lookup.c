#include <gu/map.h>
#include <gu/mem.h>
#include <gu/file.h>
#include <gu/string.h>
#include <pgf/data.h>
#include <stdio.h>

#define PGF_LOOKUP_DEBUG

typedef struct {
	PgfAbsFun* fun;
	size_t arg_idx;
} PgfAbsBottomUpEntry;

typedef struct {
	PgfAbsFun* fun;
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
	gu_putc('\n',out,err);
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
	PgfMetaId next_id;
	GuPool* pool;
} PgfSpineBuilder;

static PgfAbsProduction*
pgf_lookup_new_production(PgfSpineBuilder* builder, PgfAbsFun* fun) {
	size_t n_hypos = gu_seq_length(fun->type->hypos);
	PgfAbsProduction* prod = gu_new_flex(builder->pool, PgfAbsProduction, args, n_hypos);
	prod->fun = fun;
	for (size_t i = 0; i < n_hypos; i++) {
		prod->args[i] = 0;
	}
	return prod;
}

static PgfMetaId
pgf_lookup_add_spine_nodes(PgfSpineBuilder* builder, PgfCId cat) {
	PgfMetaId cat_id = gu_map_get(builder->cat_ids, cat, PgfMetaId);
	if (cat_id != 0) {
		return cat_id;
	}

	cat_id = ++builder->next_id;
	gu_map_put(builder->cat_ids, cat, PgfMetaId, cat_id);

	GuBuf* entries = gu_map_get(builder->function_idx, cat, GuBuf*);
	if (entries != NULL) {
		size_t n_entries = gu_buf_length(entries);
		for (size_t i = 0; i < n_entries; i++) {
			PgfAbsBottomUpEntry* entry = gu_buf_index(entries, PgfAbsBottomUpEntry, i);

			PgfMetaId id = pgf_lookup_add_spine_nodes(builder, entry->fun->type->cid);
			
			PgfAbsProduction* prod = pgf_lookup_new_production(builder, entry->fun);
			prod->args[entry->arg_idx] = cat_id;

#ifdef PGF_LOOKUP_DEBUG
			GuPool* tmp_pool = gu_new_pool();
			GuOut* out = gu_file_out(stderr, tmp_pool);
			GuExn* err = gu_exn(tmp_pool);
			pgf_print_abs_production(id, prod, out, err);
			gu_pool_free(tmp_pool);
#endif
		}
	}

	return cat_id;
}

static void
pgf_lookup_add_spine_leaf(PgfSpineBuilder* builder, PgfAbsFun *fun)
{	
	PgfMetaId id = pgf_lookup_add_spine_nodes(builder, fun->type->cid);
	PgfAbsProduction* prod = pgf_lookup_new_production(builder, fun);

#ifdef PGF_LOOKUP_DEBUG
	GuPool* tmp_pool = gu_new_pool();
	GuOut* out = gu_file_out(stderr, tmp_pool);
	GuExn* err = gu_exn(tmp_pool);
	pgf_print_abs_production(id, prod, out, err);
	gu_pool_free(tmp_pool);
#endif	
}

PGF_API GuEnum*
pgf_lookup_sentence(PgfConcr* concr, GuString sentence, GuPool* pool, GuPool* out_pool)
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
	
	PgfSpineBuilder builder;
	builder.function_idx = function_idx;
	builder.cat_ids      = gu_new_string_map(PgfMetaId, &gu_null_struct, pool);
	builder.next_id      = 0;
	builder.pool         = pool;

	GuBuf* funs = gu_map_get(lexicon_idx, sentence, GuBuf*);
	if (funs != NULL) {
		size_t n_funs = gu_buf_length(funs);
		for (size_t i = 0; i < n_funs; i++) {
			PgfAbsFun* absfun =
				gu_buf_get(funs, PgfAbsFun*, i);
			pgf_lookup_add_spine_leaf(&builder, absfun);
		}
	}
	return NULL;
}
