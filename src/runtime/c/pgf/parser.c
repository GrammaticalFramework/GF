#include <pgf/parser.h>
#include <gu/seq.h>
#include <gu/assert.h>
#include <gu/log.h>
#include <gu/file.h>
#include <math.h>

//#define PGF_PARSER_DEBUG

typedef GuBuf PgfItemBuf;
static GU_DEFINE_TYPE(PgfItemBuf, abstract, _);

typedef GuList(PgfItemBuf*) PgfItemBufs;
static GU_DEFINE_TYPE(PgfItemBufs, abstract, _);

typedef GuMap PgfContsMap;
GU_DEFINE_TYPE(PgfContsMap, GuMap,
		      gu_type(PgfCCat), NULL,
		      gu_ptr_type(PgfItemBufs), &gu_null_struct);

typedef GuMap PgfGenCatMap;
GU_DEFINE_TYPE(PgfGenCatMap, GuMap,
		      gu_type(PgfItemBuf), NULL,
		      gu_ptr_type(PgfCCat), &gu_null_struct);

typedef GuBuf PgfCCatBuf;

typedef struct {
	PgfConcr* concr;
	PgfCCat* completed;
	PgfItem* target;
	PgfExpr meta_var;
	PgfProduction meta_prod;
    int max_fid;
    int item_count;
} PgfParsing;

typedef struct {
	PgfToken tok;
    PgfItemBuf* lexicon_idx;
} PgfTokenState;

struct PgfParseState {
	GuPool* pool;
	PgfParseState* next;

    PgfItemBuf* agenda;
	PgfContsMap* conts_map;
	PgfGenCatMap* generated_cats;
    int offset;

    PgfParsing* ps;
    PgfTokenState* ts;
};

typedef struct PgfExprState PgfExprState;

struct PgfExprState {
	PgfExprState* cont;
	PgfExpr expr;
	PgfPArgs args;
	size_t arg_idx;
};

typedef struct {
	PgfExprState *st;
	prob_t prob;
} PgfExprQState;

typedef struct PgfParseResult PgfParseResult;

struct PgfParseResult {
	GuPool* tmp_pool;
    PgfParseState* state;
	GuBuf* pqueue;
	PgfExprEnum en;
};

typedef struct PgfItemBase PgfItemBase;


struct PgfItemBase {
	PgfItemBuf* conts;
	PgfCCat* ccat;
	PgfProduction prod;
	unsigned short lin_idx;
};

struct PgfItem {
#ifdef PGF_PARSER_DEBUG
	int start,end;
#endif
	PgfItemBase* base;
	PgfPArgs args;
	PgfSymbol curr_sym;
	uint16_t seq_idx;
	uint8_t tok_idx;
	uint8_t alt;
	prob_t inside_prob;
	prob_t outside_prob;
};

typedef struct {
	int fid;
	int lin_idx;
} PgfCFCat;

static GU_DEFINE_TYPE(PgfCFCat, struct,
	       GU_MEMBER(PgfCFCat, fid, int),
           GU_MEMBER(PgfCFCat, lin_idx, int));

extern GuHasher pgf_cfcat_hasher;

GU_DEFINE_TYPE(PgfEpsilonIdx, GuMap,
		      gu_type(PgfCFCat), &pgf_cfcat_hasher,
		      gu_ptr_type(PgfCCat), &gu_null_struct);

// GuString -> PgfItemBuf*
GU_DEFINE_TYPE(PgfTransitions, GuStringMap,
		      gu_ptr_type(PgfItemBuf), &gu_null_struct);

static PgfSymbol
pgf_prev_extern_sym(PgfSymbol sym)
{
	GuVariantInfo i = gu_variant_open(sym);
	switch (i.tag) {
	case PGF_SYMBOL_CAT:
		return *((PgfSymbol*) (((PgfSymbolCat*) i.data)+1));
	case PGF_SYMBOL_KP:
		return *((PgfSymbol*) (((PgfSymbolKP*) i.data)+1));
	case PGF_SYMBOL_KS:
		return *((PgfSymbol*) (((PgfSymbolKS*) i.data)+1));
	case PGF_SYMBOL_LIT:
		return *((PgfSymbol*) (((PgfSymbolLit*) i.data)+1));
	case PGF_SYMBOL_VAR:
		return *((PgfSymbol*) (((PgfSymbolVar*) i.data)+1));
	default:
		gu_impossible();
		return gu_null_variant;
	}
}

int
pgf_item_lin_idx(PgfItem* item) {
	return item->base->lin_idx;
}

int
pgf_item_sequence_length(PgfItem* item)
{
    GuVariantInfo i = gu_variant_open(item->base->prod);
    switch (i.tag) {
    case PGF_PRODUCTION_APPLY: {
        PgfProductionApply* papp = i.data;
        return gu_seq_length(papp->fun->lins[item->base->lin_idx]);
    }
    case PGF_PRODUCTION_COERCE: {
        return 1;
    }
    case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = i.data;
        PgfSequence seq;
        
        if (!gu_seq_is_null(pext->lins) &&
            !gu_seq_is_null(seq = gu_seq_get(pext->lins,PgfSequence,item->base->lin_idx))) {
		  return gu_seq_length(seq);
		} else {
			int seq_len = 0;
			PgfSymbol sym = item->curr_sym;
			while (!gu_variant_is_null(sym)) {
				seq_len++;
				sym = pgf_prev_extern_sym(sym);
			}
			
			return seq_len;
		}
    }
    case PGF_PRODUCTION_META: {
		PgfProductionMeta* pmeta = i.data;
        PgfSequence seq;
        
        if (!gu_seq_is_null(pmeta->lins) &&
		    !gu_seq_is_null(seq = gu_seq_get(pmeta->lins,PgfSequence,item->base->lin_idx))) {
		  return gu_seq_length(seq);
		} else {
			int seq_len = 0;
			PgfSymbol sym = item->curr_sym;
			while (!gu_variant_is_null(sym)) {
				seq_len++;
				sym = pgf_prev_extern_sym(sym);
			}
			
			return seq_len;
		}
    }
    default:
        gu_impossible();
        return 0;
    }
}

static PgfSequence
pgf_extern_seq_get(PgfItem* item, GuPool* pool)
{
	int seq_len = pgf_item_sequence_length(item);

	PgfSequence seq = 
		gu_new_seq(PgfSymbol, seq_len, pool);
	PgfSymbol sym = item->curr_sym;
	while (!gu_variant_is_null(sym)) {
		gu_seq_set(seq, PgfSymbol, --seq_len, sym);
		sym = pgf_prev_extern_sym(sym);
	}
	
	return seq;
}

void
pgf_item_sequence(PgfItem* item, 
                  int* lin_idx, PgfSequence* seq,
                  GuPool* pool) {
	*lin_idx = item->base->lin_idx;

    GuVariantInfo i = gu_variant_open(item->base->prod);
    switch (i.tag) {
    case PGF_PRODUCTION_APPLY: {
        PgfProductionApply* papp = i.data;
        *seq = papp->fun->lins[item->base->lin_idx];
        break;
    }
    case PGF_PRODUCTION_COERCE: {
        PgfSymbol sym =
			gu_new_variant_i(pool, PGF_SYMBOL_CAT,
						PgfSymbolCat,
						.d = 0, .r = item->base->lin_idx);
		*seq = gu_new_seq(PgfSequence, 1, pool);
		gu_seq_set(*seq, PgfSymbol, 0, sym);
        break;
    }
    case PGF_PRODUCTION_EXTERN: {
        PgfProductionExtern* pext = i.data;
        
        if (gu_seq_is_null(pext->lins) ||
            gu_seq_is_null(*seq = gu_seq_get(pext->lins, PgfSequence, item->base->lin_idx))) {
		  *seq = pgf_extern_seq_get(item, pool);
		}
		break;
    }
    case PGF_PRODUCTION_META: {
        PgfProductionMeta* pmeta = i.data;
        
        if (gu_seq_is_null(pmeta->lins) ||
		    gu_seq_is_null(*seq = gu_seq_get(pmeta->lins,PgfSequence,item->base->lin_idx))) {
		  *seq = pgf_extern_seq_get(item, pool);
		}
		break;
    }
    default:
        gu_impossible();
    }
}

#ifdef PGF_PARSER_DEBUG
static void
pgf_print_production_args(PgfPArgs args,
                          GuWriter* wtr, GuExn* err)
{
	size_t n_args = gu_seq_length(args);
	for (size_t j = 0; j < n_args; j++) {
		if (j > 0)
			gu_putc(',',wtr,err);
				
		PgfPArg arg = gu_seq_get(args, PgfPArg, j);

		if (arg.hypos != NULL &&
		    gu_list_length(arg.hypos) > 0) {
			size_t n_hypos = gu_list_length(arg.hypos);
			for (size_t k = 0; k < n_hypos; k++) {
				PgfCCat *hypo = gu_list_index(arg.hypos, k);
				gu_printf(wtr,err,"C%d ",hypo->fid);
			}
			gu_printf(wtr,err,"-> ");
		}
		
		gu_printf(wtr,err,"C%d",arg.ccat->fid);
	}
}

static void
pgf_print_production(int fid, PgfProduction prod, 
                     GuWriter *wtr, GuExn* err, GuPool* pool)
{
    gu_printf(wtr,err,"C%d -> ",fid);
       
    GuVariantInfo i = gu_variant_open(prod);
    switch (i.tag) {
    case PGF_PRODUCTION_APPLY: {
        PgfProductionApply* papp = i.data;
        gu_printf(wtr,err,"F%d(",papp->fun->funid);
        pgf_print_expr(papp->fun->ep->expr, 0, wtr, err);
        gu_printf(wtr,err,")[");
        pgf_print_production_args(papp->args,wtr,err);
        gu_printf(wtr,err,"]\n");
        break;
    }
    case PGF_PRODUCTION_COERCE: {
        PgfProductionCoerce* pcoerce = i.data;
        gu_printf(wtr,err,"_[C%d]\n",pcoerce->coerce->fid);
        break;
    }
    case PGF_PRODUCTION_EXTERN: {
        PgfProductionExtern* pext = i.data;
        gu_printf(wtr,err,"<extern>(");
        pgf_print_expr(pext->ep->expr, 0, wtr, err);
        gu_printf(wtr,err,")[]\n");
        break;
    }
    case PGF_PRODUCTION_META: {
        PgfProductionMeta* pmeta = i.data;
        gu_printf(wtr,err,"<meta>[");
        pgf_print_production_args(pmeta->args,wtr,err);
        gu_printf(wtr,err,"]\n");
        break;
    }
    default:
        gu_impossible();
    }
}

void
pgf_print_symbol(PgfSymbol sym, GuWriter *wtr, GuExn *err);

static void
pgf_print_item_seq(PgfItem *item,
                   GuWriter* wtr, GuExn* err, GuPool* pool)
{
	int lin_idx;
	PgfSequence seq;
	pgf_item_sequence(item, &lin_idx, &seq, pool);

	gu_printf(wtr, err, "%d : ",lin_idx);

	size_t index;
	for (index = 0; index < gu_seq_length(seq); index++) {
		if (item->seq_idx == index)
			gu_printf(wtr, err, " . ");

		PgfSymbol *sym = gu_seq_index(seq, PgfSymbol, index);
		pgf_print_symbol(*sym, wtr, err);
	}

	if (item->seq_idx == index)
		gu_printf(wtr, err, " .");
}

static void
pgf_print_item(PgfItem* item, GuWriter* wtr, GuExn* err, GuPool* pool)
{
    gu_printf(wtr, err, "[%d-%d; C%d -> ",
	                    item->start,
	                    item->end,
	                    item->base->ccat->fid);

	GuVariantInfo i = gu_variant_open(item->base->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
        PgfCncFun* fun = papp->fun;
        gu_printf(wtr, err, "F%d(", fun->funid);
        pgf_print_expr(fun->ep->expr, 0, wtr, err);
        gu_printf(wtr, err, ")[");
        pgf_print_production_args(item->args, wtr, err);
        gu_printf(wtr, err, "]; ");
		break;
	}
	case PGF_PRODUCTION_COERCE: {
        gu_printf(wtr, err, "_[C%d]; ",
            gu_seq_index(item->args, PgfPArg, 0)->ccat->fid);
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = i.data;
        gu_printf(wtr, err, "<extern>");
        if (pext->ep != NULL) {
			gu_printf(wtr, err, "(");
			pgf_print_expr(pext->ep->expr, 0, wtr, err);
			gu_printf(wtr, err, ")");
		}
		gu_printf(wtr, err, "[");
		pgf_print_production_args(item->args, wtr, err);
        gu_printf(wtr, err, "]; ");
		break;
	}
	case PGF_PRODUCTION_META: {
        gu_printf(wtr, err, "<meta>[");
		pgf_print_production_args(item->args, wtr, err);
        gu_printf(wtr, err, "]; ");
		break;
	}
	default:
		gu_impossible();
	}
    
    pgf_print_item_seq(item, wtr, err, pool);
    gu_printf(wtr, err, "; %f+%f=%f]\n",
	            item->inside_prob,
	            item->outside_prob,
	            item->inside_prob+item->outside_prob);
}
#endif

static int
cmp_item_prob(GuOrder* self, const void* a, const void* b)
{
	PgfItem *item1 = *((PgfItem **) a);
	PgfItem *item2 = *((PgfItem **) b);

	prob_t prob1 = item1->inside_prob + item1->outside_prob;
	prob_t prob2 = item2->inside_prob + item2->outside_prob;
	
	if (prob1 < prob2)
		return -1;
	else if (prob1 > prob2)
		return 1;
	else
		return 0;
}

static GuOrder
pgf_item_prob_order = { cmp_item_prob };

static void
pgf_parsing_add_transition(PgfParseState* before, PgfParseState* after, 
                           PgfToken tok, PgfItem* item)
{
    if (gu_string_eq(tok, after->ts->tok)) {
        if (after->next == NULL)
			after->ps->target = item;

		gu_buf_heap_push(after->agenda, &pgf_item_prob_order, &item);
    }
}

static PgfItemBufs*
pgf_parsing_get_contss(PgfContsMap* conts_map, PgfCCat* cat, GuPool *tmp_pool)
{
	PgfItemBufs* contss = gu_map_get(conts_map, cat, PgfItemBufs*);
	if (!contss) {
		size_t n_lins = cat->cnccat->n_lins;
		contss = gu_new_list(PgfItemBufs, tmp_pool, n_lins);
		for (size_t i = 0; i < n_lins; i++) {
			gu_list_index(contss, i) = NULL;
		}
		gu_map_put(conts_map, cat, PgfItemBufs*, contss);
	}
	return contss;
}

static PgfItemBuf*
pgf_parsing_get_conts(PgfContsMap* conts_map,
                      PgfCCat* ccat, size_t lin_idx,
					  GuPool *pool, GuPool *tmp_pool)
{
	gu_require(lin_idx < ccat->cnccat->n_lins);
	PgfItemBufs* contss = 
		pgf_parsing_get_contss(conts_map, ccat, tmp_pool);
	PgfItemBuf* conts = gu_list_index(contss, lin_idx);
	if (!conts) {
		conts = gu_new_buf(PgfItem*, pool);
		gu_list_index(contss, lin_idx) = conts;
	}
	return conts;
}

static bool
pgf_parsing_has_conts(PgfContsMap* conts_map,
                      PgfCCat* ccat, size_t lin_idx,
                      PgfItemBuf* conts)
{
	gu_require(lin_idx < ccat->cnccat->n_lins);

	PgfItemBufs* contss = gu_map_get(conts_map, ccat, PgfItemBufs*);
	if (!contss)
		return false;

	PgfItemBuf* conts0 = gu_list_index(contss, lin_idx);
	return (conts == conts0);
}

static PgfCCat*
pgf_parsing_create_completed(PgfParseState* state, PgfItemBuf* conts,
                             prob_t viterbi_prob, PgfCncCat* cnccat)
{
	PgfCCat* cat = gu_new(PgfCCat, state->pool);
	cat->cnccat = cnccat;
	cat->viterbi_prob = viterbi_prob;
	cat->fid = state->ps->max_fid++;
	cat->prods = gu_buf_seq(gu_new_buf(PgfProduction, state->pool));
	cat->n_synprods = 0;
	gu_map_put(state->generated_cats, conts, PgfCCat*, cat);
	return cat;
}

static PgfCCat*
pgf_parsing_get_completed(PgfParseState* state, PgfItemBuf* conts)
{
	return gu_map_get(state->generated_cats, conts, PgfCCat*);
}

static void
pgf_item_set_curr_symbol(PgfItem* item, GuPool* pool)
{
	GuVariantInfo i = gu_variant_open(item->base->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
		PgfCncFun* fun = papp->fun;
		gu_assert(item->base->lin_idx < fun->n_lins);
		PgfSequence seq = fun->lins[item->base->lin_idx];
		gu_assert(item->seq_idx <= gu_seq_length(seq));
		if (item->seq_idx == gu_seq_length(seq)) {
			item->curr_sym = gu_null_variant;
		} else {
			item->curr_sym = gu_seq_get(seq, PgfSymbol, item->seq_idx);
		}
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		gu_assert(item->seq_idx <= 1);
		if (item->seq_idx == 1) {
			item->curr_sym = gu_null_variant;
		} else {
			item->curr_sym = gu_new_variant_i(pool, PGF_SYMBOL_CAT,
						PgfSymbolCat,
						.d = 0, .r = item->base->lin_idx);
		}
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		break;
	}
	case PGF_PRODUCTION_META: {
		break;
	}
	default:
		gu_impossible();
	}
}

static PgfItem*
pgf_new_item(int pos, PgfCCat* ccat, size_t lin_idx,
             PgfProduction prod, PgfItemBuf* conts, 
             prob_t delta_prob,
             GuPool* pool)
{
    PgfItemBase* base = gu_new(PgfItemBase, pool);
	base->ccat = ccat;
	base->lin_idx = lin_idx;
	base->prod = prod;
	base->conts = conts;

	PgfItem* item = gu_new(PgfItem, pool);
	GuVariantInfo pi = gu_variant_open(prod);
	switch (pi.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = pi.data;
		item->args = papp->args;
		item->inside_prob = papp->fun->ep->prob;
		
		int n_args = gu_seq_length(item->args);
		for (int i = 0; i < n_args; i++) {
			PgfPArg *arg = gu_seq_index(item->args, PgfPArg, i);
			item->inside_prob += arg->ccat->viterbi_prob;
		}
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = pi.data;
		item->args = gu_new_seq(PgfPArg, 1, pool);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, 0);
		parg->hypos = NULL;
		parg->ccat = pcoerce->coerce;
		item->inside_prob = pcoerce->coerce->viterbi_prob;
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = pi.data;
		item->args = gu_empty_seq();
		item->inside_prob = pext->ep ? pext->ep->prob : 0;

		int n_args = gu_seq_length(item->args);
		for (int i = 0; i < n_args; i++) {
			PgfPArg *arg = gu_seq_index(item->args, PgfPArg, i);
			item->inside_prob += arg->ccat->viterbi_prob;
		}
		break;
	}
	case PGF_PRODUCTION_META: {
		PgfProductionMeta* pmeta = pi.data;
		item->args = pmeta->args;
		item->inside_prob = pmeta->ep ? pmeta->ep->prob : 0;

		int n_args = gu_seq_length(item->args);
		for (int i = 0; i < n_args; i++) {
			PgfPArg *arg = gu_seq_index(item->args, PgfPArg, i);
			item->inside_prob += arg->ccat->viterbi_prob;
		}
		break;
	}
	default:
		gu_impossible();
	}
#ifdef PGF_PARSER_DEBUG
	item->start = pos;
	item->end = pos;
#endif
	item->base = base;
	item->curr_sym = gu_null_variant;
	item->seq_idx = 0;
	item->tok_idx = 0;
	item->alt = 0;

	item->outside_prob = 0;
	if (gu_buf_length(conts) > 0) {
		PgfItem* best_cont = gu_buf_get(conts, PgfItem*, 0);
		if (best_cont != NULL)
			item->outside_prob = 
				best_cont->inside_prob-ccat->viterbi_prob+
				best_cont->outside_prob;
	}
	item->outside_prob += delta_prob;

	pgf_item_set_curr_symbol(item, pool);
	return item;
}

static PgfItemBase*
pgf_item_base_copy(PgfItemBase* base, GuPool* pool)
{
	PgfItemBase* copy = gu_new(PgfItemBase, pool);
	memcpy(copy, base, sizeof(PgfItemBase));
	return copy;
}

static PgfItem*
pgf_item_copy(PgfItem* item, GuPool* pool)
{
	PgfItem* copy = gu_new(PgfItem, pool);
	memcpy(copy, item, sizeof(PgfItem));
	return copy;
}

static PgfItem*
pgf_item_update_arg(PgfItem* item, size_t d, PgfCCat *new_ccat,
                    GuPool* pool)
{
	PgfCCat *old_ccat =
		gu_seq_index(item->args, PgfPArg, d)->ccat;

	PgfItem* new_item = pgf_item_copy(item, pool);
	size_t nargs = gu_seq_length(item->args);
	new_item->args = gu_new_seq(PgfPArg, nargs, pool);
	memcpy(gu_seq_data(new_item->args), gu_seq_data(item->args),
	       nargs * sizeof(PgfPArg));
	gu_seq_set(new_item->args, PgfPArg, d,
		   ((PgfPArg) { .hypos = NULL, .ccat = new_ccat }));
	new_item->inside_prob += 
		new_ccat->viterbi_prob - old_ccat->viterbi_prob;

	return new_item;
}

static void
pgf_item_advance(PgfItem* item, GuPool* pool)
{
	item->seq_idx++;
	pgf_item_set_curr_symbol(item, pool);
}

static void
pgf_parsing_combine(PgfParseState* before, PgfParseState* after,
                    PgfItem* cont, PgfCCat* cat, int lin_idx,
                    bool is_empty)
{
	if (cont == NULL) {
		if (after == NULL)
			before->ps->completed = cat;
		return;
	}

	bool extend = false;
	GuVariantInfo i = gu_variant_open(cont->base->prod);
	if (i.tag == PGF_PRODUCTION_META) {
		PgfProductionMeta* pmeta = i.data;
		if (gu_seq_is_null(pmeta->lins) ||
		    gu_seq_is_null(gu_seq_get(pmeta->lins,PgfSequence,cont->base->lin_idx))) {
			extend = true;
		}
	}

	PgfItem* item = NULL;

	if (!extend) {
		switch (gu_variant_tag(cont->curr_sym)) {
		case PGF_SYMBOL_CAT: {
			PgfSymbolCat* scat = gu_variant_data(cont->curr_sym);
			item = pgf_item_update_arg(cont, scat->d, cat, before->pool);
			break;
		}
		case PGF_SYMBOL_LIT: {
			PgfSymbolLit* slit = gu_variant_data(cont->curr_sym);
			item = pgf_item_update_arg(cont, slit->d, cat, before->pool);
			break;
		}
		default:
			gu_impossible();
		}
	} else {
		if (is_empty)
			return;

		item = pgf_item_copy(cont, before->pool);
		size_t nargs = gu_seq_length(cont->args);
		item->args = gu_new_seq(PgfPArg, nargs+1, before->pool);
		memcpy(gu_seq_data(item->args), gu_seq_data(cont->args),
			   nargs * sizeof(PgfPArg));
		gu_seq_set(item->args, PgfPArg, nargs,
		     ((PgfPArg) { .hypos = NULL, .ccat = cat }));

		PgfCIdMap* meta_child_probs =
			item->base->ccat->cnccat->abscat->meta_child_probs;
		item->inside_prob += 
			cat->viterbi_prob+
			gu_map_get(meta_child_probs, cat->cnccat->abscat, prob_t);

		PgfSymbol prev = item->curr_sym;
		PgfSymbolCat* scat = (PgfSymbolCat*)
			gu_alloc_variant(PGF_SYMBOL_CAT,
							 sizeof(PgfSymbolCat)+sizeof(PgfSymbol),
							 gu_alignof(PgfSymbolCat),
							 &item->curr_sym, before->pool);
		*((PgfSymbol*)(scat+1)) = prev;
		scat->d = nargs;
		scat->r = lin_idx;
	}

#ifdef PGF_PARSER_DEBUG
	item->end = before->offset;
#endif
	pgf_item_advance(item, before->pool);
	gu_buf_heap_push(before->agenda, &pgf_item_prob_order, &item);
}

static void
pgf_parsing_production(PgfParseState* state,
                       PgfCCat* ccat, size_t lin_idx,
                       PgfProduction prod, PgfItemBuf* conts,
                       prob_t delta_prob)
{
	PgfItem* item =
        pgf_new_item(state->offset, ccat, lin_idx, prod, conts, delta_prob, state->pool);
    state->ps->item_count++;
    gu_buf_heap_push(state->agenda, &pgf_item_prob_order, &item);
}

static PgfProduction
pgf_parsing_new_production(PgfItem* item, PgfExprProb *ep, GuPool *pool)
{
	GuVariantInfo i = gu_variant_open(item->base->prod);
	PgfProduction prod = gu_null_variant;
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
		PgfProductionApply* new_papp = 
			gu_new_variant(PGF_PRODUCTION_APPLY,
				       PgfProductionApply,
				       &prod, pool);
		new_papp->fun = papp->fun;
		new_papp->args = item->args;
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* new_pcoerce =
			gu_new_variant(PGF_PRODUCTION_COERCE,
				       PgfProductionCoerce,
				       &prod, pool);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, 0);
		gu_assert(!parg->hypos || !parg->hypos->len);
		new_pcoerce->coerce = parg->ccat;
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = i.data;

		if (gu_seq_is_null(pext->lins) ||
		    gu_seq_is_null(gu_seq_get(pext->lins,PgfSequence,item->base->lin_idx))) {
			PgfSequence seq = 
				pgf_extern_seq_get(item, pool);

			size_t n_lins = item->base->ccat->cnccat->n_lins;

			PgfProductionExtern* new_pext = (PgfProductionExtern*)
				gu_new_variant(PGF_PRODUCTION_EXTERN,
				               PgfProductionExtern,
				               &prod, pool);
			new_pext->callback = pext->callback;
			new_pext->ep = ep;
			new_pext->lins = gu_new_seq(PgfSequence, n_lins, pool);

			if (gu_seq_is_null(pext->lins)) {
				for (size_t i = 0; i < n_lins; i++) {
					gu_seq_set(new_pext->lins,PgfSequence,i,
					           gu_null_seq);
				}
			} else {
				for (size_t i = 0; i < n_lins; i++) {
					gu_seq_set(new_pext->lins,PgfSequence,i,
							   gu_seq_get(pext->lins,PgfSequence,i));
				}
			}
			gu_seq_set(new_pext->lins,PgfSequence,item->base->lin_idx,seq);
		} else {
			prod = item->base->prod;
		}
		break;
	}
	case PGF_PRODUCTION_META: {
		PgfProductionMeta* pmeta = i.data;

		PgfProductionMeta* new_pmeta = 
			gu_new_variant(PGF_PRODUCTION_META,
						   PgfProductionMeta,
						   &prod, pool);
		new_pmeta->ep   = ep;
		new_pmeta->lins = pmeta->lins;
		new_pmeta->args = item->args;

		if (gu_seq_is_null(pmeta->lins) ||
		    gu_seq_is_null(gu_seq_get(pmeta->lins,PgfSequence,item->base->lin_idx))) {
			PgfSequence seq =
				pgf_extern_seq_get(item, pool);

			size_t n_lins = item->base->ccat->cnccat->n_lins;

			new_pmeta->lins = gu_new_seq(PgfSequence, n_lins, pool);

			if (gu_seq_is_null(pmeta->lins)) {
				for (size_t i = 0; i < n_lins; i++) {
					gu_seq_set(new_pmeta->lins,PgfSequence,i,
					           gu_null_seq);
				}
			} else {
				for (size_t i = 0; i < n_lins; i++) {
					gu_seq_set(new_pmeta->lins,PgfSequence,i,
							   gu_seq_get(pmeta->lins,PgfSequence,i));
				}
			}
			gu_seq_set(new_pmeta->lins,PgfSequence,item->base->lin_idx,seq);
		}
		break;
	}
	default:
		gu_impossible();
	}
	
	return prod;
}

static void
pgf_parsing_complete(PgfParseState* before, PgfParseState* after,
                     PgfItem* item, PgfExprProb *ep)
{
	PgfProduction prod =
		pgf_parsing_new_production(item, ep, before->pool);

	PgfItemBuf* conts = item->base->conts;
	PgfCCat* tmp_cat = pgf_parsing_get_completed(before, conts);
    PgfCCat* cat = tmp_cat;
    if (cat == NULL) {
        cat = pgf_parsing_create_completed(before, conts,
                           item->inside_prob, item->base->ccat->cnccat);
    }

    GuBuf* prodbuf = gu_seq_buf(cat->prods);
	gu_buf_push(prodbuf, PgfProduction, prod);
	cat->n_synprods++;

#ifdef PGF_PARSER_DEBUG
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    if (tmp_cat == NULL)
		gu_printf(wtr, err, "[%d-%d; C%d; %d; C%d]\n",
                            item->start,
                            item->end,
                            item->base->ccat->fid, 
                            item->base->lin_idx, 
                            cat->fid);
    pgf_print_production(cat->fid, prod, wtr, err, tmp_pool);
    gu_pool_free(tmp_pool);
#endif

	if (tmp_cat != NULL) {
		PgfItemBufs* contss =
			pgf_parsing_get_contss(before->conts_map, cat, before->pool);
		size_t n_contss = gu_list_length(contss);
		for (size_t i = 0; i < n_contss; i++) {
			PgfItemBuf* conts2 = gu_list_index(contss, i);
			/* If there are continuations for
			 * linearization index i, then (cat, i) has
			 * already been predicted. Add the new
			 * production immediately to the agenda,
			 * i.e. process it. */
			if (conts2) {
				pgf_parsing_production(before, cat, i,
							   prod, conts2, 0);
			}
		}

		// The category has already been created. If it has also been
		// predicted already, then process a new item for this production.
		PgfParseState* state = after;
		while (state != NULL) {
			PgfItemBufs* contss =
				pgf_parsing_get_contss(state->conts_map, cat, state->pool);
			size_t n_contss = gu_list_length(contss);
			for (size_t i = 0; i < n_contss; i++) {
				PgfItemBuf* conts2 = gu_list_index(contss, i);
				/* If there are continuations for
				 * linearization index i, then (cat, i) has
				 * already been predicted. Add the new
				 * production immediately to the agenda,
				 * i.e. process it. */
				if (conts2) {
					pgf_parsing_production(state, cat, i,
								   prod, conts2, 0);
				}
			}

			state = state->next;
		}
	} else {
		bool is_empty =
			pgf_parsing_has_conts(before->conts_map, 
		                          item->base->ccat, item->base->lin_idx, 
		                          item->base->conts);

		size_t n_conts = gu_buf_length(conts);
		for (size_t i = 0; i < n_conts; i++) {
			PgfItem* cont = gu_buf_get(conts, PgfItem*, i);
			pgf_parsing_combine(before, after, cont, cat, item->base->lin_idx, is_empty);
		}
    }
}

static void
pgf_parsing_td_predict(PgfParseState* before, PgfParseState* after,
                       PgfItem* item, PgfCCat* ccat, size_t lin_idx,
                       prob_t delta_prob)
{
	gu_enter("-> cat: %d", ccat->fid);
	if (gu_seq_is_null(ccat->prods)) {
		// Empty category
		return;
	}
	
	PgfItemBuf* conts = 
		pgf_parsing_get_conts(before->conts_map, ccat, lin_idx, 
		                      before->pool, before->pool);
	gu_buf_push(conts, PgfItem*, item);
	if (gu_buf_length(conts) == 1) {
		/* First time we encounter this linearization
		 * of this category at the current position,
		 * so predict it. */

		// Top-down prediction for syntactic rules
		PgfProductionSeq prods = ccat->prods;
		for (size_t i = 0; i < ccat->n_synprods; i++) {
			PgfProduction prod =
				gu_seq_get(prods, PgfProduction, i);		
			pgf_parsing_production(before, ccat, lin_idx, prod, conts, delta_prob);
		}
		
		if (ccat->cnccat->abscat->meta_prob != INFINITY &&
		    ccat->fid < before->ps->concr->total_cats) {
			// Top-down prediction for meta rules
			PgfItem *item =
				pgf_new_item(before->offset, ccat, lin_idx, before->ps->meta_prod, conts, 0, before->pool);
			before->ps->item_count++;
			item->inside_prob = 
				ccat->cnccat->abscat->meta_prob;
			gu_buf_heap_push(before->agenda, &pgf_item_prob_order, &item);
		}

		// Bottom-up prediction for lexical rules
		if (after != NULL && after->ts->lexicon_idx != NULL) {
			size_t n_items = gu_buf_length(after->ts->lexicon_idx);
			for (size_t i = 0; i < n_items; i++) {
				PgfItem* new_item = gu_buf_get(after->ts->lexicon_idx, PgfItem*, i);
			
				if (new_item->base->ccat == ccat && 
				    new_item->base->lin_idx == lin_idx &&
				    gu_seq_length(new_item->args) == 0) {
					pgf_parsing_production(before, ccat, lin_idx,
								           new_item->base->prod, conts, 0);
				}
			}
		}

		// Bottom-up prediction for epsilon rules
		PgfCFCat cfc = {ccat->fid, lin_idx};
		PgfCCat* eps_ccat = gu_map_get(before->ps->concr->epsilon_idx, 
		                               &cfc, PgfCCat*);
		if (eps_ccat != NULL) {
			size_t n_prods = gu_seq_length(eps_ccat->prods);
			for (size_t i = 0; i < n_prods; i++) {
				PgfProduction prod = 
					gu_seq_get(eps_ccat->prods, PgfProduction, i);
				
				GuVariantInfo i = gu_variant_open(prod);
				switch (i.tag) {
				case PGF_PRODUCTION_APPLY: {
					PgfProductionApply* papp = i.data;
					if (gu_seq_length(papp->args) == 0) {
						pgf_parsing_production(before, ccat, lin_idx,
							prod, conts, 0);
					}
					break;
				}
				}
			}
		}
	} else {
		/* If it has already been completed, combine. */

		PgfCCat* completed =
			pgf_parsing_get_completed(before, conts);
		if (completed) {
			pgf_parsing_combine(before, after, item, completed, lin_idx, true);
		}

		PgfParseState* state = after;
		while (state != NULL) {
			PgfCCat* completed =
				pgf_parsing_get_completed(state, conts);
			if (completed) {
				pgf_parsing_combine(state, state->next, item, completed, lin_idx, true);
			}

			state = state->next;
		}
	}
	gu_exit("<-");
}

typedef struct {
	GuMapItor fn;
	PgfParseState* before;
	PgfParseState* after;
	PgfItem* meta_item;
} PgfMetaPredictFn;

static void
pgf_parsing_meta_predict(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	(void) (err);
	
	PgfCat* abscat = (PgfCat*) key;
    prob_t meta_prob = *((prob_t*) value);
    PgfMetaPredictFn* clo = (PgfMetaPredictFn*) fn;
    PgfParseState* before = clo->before;
    PgfParseState* after  = clo->after;
    PgfItem* meta_item  = clo->meta_item;

    PgfCncCat* cnccat =
		gu_map_get(before->ps->concr->cnccats, &abscat->name, PgfCncCat*);
	if (cnccat == NULL)
		return;

	size_t n_cats = gu_list_length(cnccat->cats);
	for (size_t i = 0; i < n_cats; i++) {
		PgfCCat* ccat = gu_list_index(cnccat->cats, i);
		
		for (size_t lin_idx = 0; lin_idx < cnccat->n_lins; lin_idx++) {
			pgf_parsing_td_predict(before, after,
									meta_item, ccat, lin_idx, meta_prob);
		}
	}
}

static prob_t
pgf_parsing_bu_predict(PgfParseState* before, PgfParseState* after,
                       PgfItemBuf* index, PgfItem* meta_item,
                       PgfItemBuf* agenda)
{
	prob_t prob = INFINITY;

	PgfMetaChildMap* meta_child_probs =
		meta_item->base->ccat->cnccat->abscat->meta_child_probs;
	if (meta_child_probs == NULL)
		return prob;

	if (!gu_map_has(before->generated_cats, index)) {
		gu_map_put(before->generated_cats, index, PgfCCat*, NULL);

		size_t n_items = gu_buf_length(index);
		for (size_t i = 0; i < n_items; i++) {
			PgfItem *item = gu_buf_get(index, PgfItem*, i);

			prob_t meta_prob =
				meta_item->inside_prob+
				meta_item->outside_prob+
				gu_map_get(meta_child_probs, item->base->ccat->cnccat->abscat, prob_t);

			PgfItemBuf* conts =
				pgf_parsing_get_conts(before->conts_map,
									  item->base->ccat, item->base->lin_idx,
									  before->pool, before->pool);
			if (gu_buf_length(conts) == 0) {
				prob_t outside_prob =
					pgf_parsing_bu_predict(before, after,
										   item->base->conts, meta_item, 
										   conts);

				if (outside_prob > meta_prob)
					outside_prob = meta_prob;

				for (size_t j = i; j < n_items; j++) {
					PgfItem *item_ = gu_buf_get(index, PgfItem*, j);

					if (item->base->conts == item_->base->conts) {
						PgfItem* copy = pgf_item_copy(item_, after->pool);
						copy->base = pgf_item_base_copy(item_->base, after->pool);
						copy->base->conts = conts;
						copy->outside_prob = outside_prob;
#ifdef PGF_PARSER_DEBUG
						copy->start = before->offset;
						copy->end   = (agenda == NULL)
						                      ? after->offset
							                  : before->offset;
#endif

						if (agenda == NULL)
							pgf_parsing_add_transition(before, after, after->ts->tok, copy);
						else
							gu_buf_push(agenda, PgfItem*, copy);

						prob_t item_prob = 
							copy->inside_prob+copy->outside_prob;
						if (prob > item_prob)
							prob = item_prob;
					}
				}				
			} else {
				size_t n_items = gu_buf_length(conts);
				for (size_t i = 0; i < n_items; i++) {
					PgfItem *item = gu_buf_get(conts, PgfItem*, i);
					
					prob_t item_prob = 
						item->inside_prob+item->outside_prob;
					if (prob > item_prob)
						prob = item_prob;
				}
				prob += item->inside_prob;

				/* If it has already been completed, combine. */

				/*PgfCCat* completed =
					pgf_parsing_get_completed(before, conts);
				if (completed) {
					pgf_parsing_combine(before, after, meta_item, completed, item->base->lin_idx);
				}*/

				PgfParseState* state = after;
				while (state != NULL) {
					PgfCCat* completed =
						pgf_parsing_get_completed(state, conts);
					if (completed) {
						pgf_parsing_combine(state, state->next, meta_item, completed, item->base->lin_idx, true);
					}

					state = state->next;
				}
			}
			
			if (meta_prob != INFINITY)
				gu_buf_push(conts, PgfItem*, meta_item);
		}
	}

	return prob;
}

static void
pgf_parsing_symbol(PgfParseState* before, PgfParseState* after,
                   PgfItem* item, PgfSymbol sym) {
	switch (gu_variant_tag(sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(sym);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, scat->d);
		gu_assert(!parg->hypos || !parg->hypos->len);
		pgf_parsing_td_predict(before, after, item, parg->ccat, scat->r, 0);
		break;
	}
	case PGF_SYMBOL_KS: {
		if (after != NULL) {
			PgfSymbolKS* sks = gu_variant_data(sym);
			gu_assert(item->tok_idx < gu_seq_length(sks->tokens));
			PgfToken tok = 
				gu_seq_get(sks->tokens, PgfToken, item->tok_idx++);
			if (item->tok_idx == gu_seq_length(sks->tokens)) {
				item->tok_idx = 0;
				pgf_item_advance(item, after->pool);
			}
#ifdef PGF_PARSER_DEBUG
			item->end++;
#endif
			pgf_parsing_add_transition(before, after, tok, item);
		}
		break;
	}
	case PGF_SYMBOL_KP: {
		if (after != NULL) {
			PgfSymbolKP* skp = gu_variant_data(sym);
			size_t idx = item->tok_idx;
			uint8_t alt = item->alt;
			gu_assert(idx < gu_seq_length(skp->default_form));
			if (idx == 0) {
				PgfToken tok;
				PgfItem* new_item;
				
				tok = gu_seq_get(skp->default_form, PgfToken, 0);
				new_item = pgf_item_copy(item, after->pool);            
				new_item->tok_idx++;
#ifdef PGF_PARSER_DEBUG
				new_item->end++;
#endif
				if (new_item->tok_idx == gu_seq_length(skp->default_form)) {
					new_item->tok_idx = 0;
					pgf_item_advance(new_item, after->pool);
				}
				pgf_parsing_add_transition(before, after, tok, new_item);

				for (size_t i = 0; i < skp->n_forms; i++) {
					// XXX: do nubbing properly
					PgfTokens toks = skp->forms[i].form;
					PgfTokens toks2 = skp->default_form;
					bool skip = pgf_tokens_equal(toks, toks2);
					for (size_t j = 0; j < i; j++) {
						PgfTokens toks2 = skp->forms[j].form;
						skip |= pgf_tokens_equal(toks, toks2);
					}
					if (!skip) {
						tok = gu_seq_get(toks, PgfToken, 0);
						new_item = pgf_item_copy(item, after->pool);
						new_item->tok_idx++;
#ifdef PGF_PARSER_DEBUG
						new_item->end++;
#endif
						new_item->alt = i;
						if (new_item->tok_idx == gu_seq_length(toks)) {
							new_item->tok_idx = 0;
							pgf_item_advance(new_item, after->pool);
						}
						pgf_parsing_add_transition(before, after, tok, new_item);
					}
				}
			} else if (alt == 0) {
				PgfToken tok =
					gu_seq_get(skp->default_form, PgfToken, idx);
				item->tok_idx++;
#ifdef PGF_PARSER_DEBUG
				item->end++;
#endif
				if (item->tok_idx == gu_seq_length(skp->default_form)) {
					item->tok_idx = 0;
					pgf_item_advance(item, after->pool);
				}
				pgf_parsing_add_transition(before, after, tok, item);
			} else {
				gu_assert(alt <= skp->n_forms);
				PgfTokens toks = skp->forms[alt - 1].form;
				PgfToken tok = gu_seq_get(toks, PgfToken, idx);
				item->tok_idx++;
#ifdef PGF_PARSER_DEBUG
				item->end++;
#endif
				if (item->tok_idx == gu_seq_length(toks)) {
					item->tok_idx = 0;
					pgf_item_advance(item, after->pool);
				}
				pgf_parsing_add_transition(before, after, tok, item);
			}
		}
		break;
	}
	case PGF_SYMBOL_LIT: {
		if (after != NULL) {
			PgfSymbolLit* slit = gu_variant_data(sym);
			PgfPArg* parg = gu_seq_index(item->args, PgfPArg, slit->d);
			gu_assert(!parg->hypos || !parg->hypos->len);

			if (parg->ccat->fid > 0 &&
			    parg->ccat->fid >= before->ps->concr->total_cats)
				pgf_parsing_td_predict(before, after, item, parg->ccat, slit->r, 0);
			else {
				PgfItemBuf* conts = 
					pgf_parsing_get_conts(before->conts_map, 
										  parg->ccat, slit->r, 
										  before->pool, before->pool);
				gu_buf_push(conts, PgfItem*, item);

				if (gu_buf_length(conts) == 1) {
					/* This is the first time when we encounter this 
					 * literal category so we must call the callback */

					PgfLiteralCallback* callback =
						gu_map_get(before->ps->concr->callbacks, 
						           parg->ccat->cnccat, 
								   PgfLiteralCallback*);

					if (callback != NULL) {
						PgfProduction prod;
						PgfProductionExtern* pext =
							gu_new_variant(PGF_PRODUCTION_EXTERN,
							               PgfProductionExtern,
							               &prod, before->pool);
						pext->callback = callback;
						pext->ep = NULL;
						pext->lins = gu_null_seq;

						pgf_parsing_production(before, parg->ccat, slit->r,
											   prod, conts, 0);
					}
				} else {
					/* If it has already been completed, combine. */

					PgfCCat* completed =
							pgf_parsing_get_completed(before, conts);
					if (completed) {
						pgf_parsing_combine(before, after, item, completed, slit->r, true);
					}
						
					PgfParseState* state = after;
					while (state != NULL) {
						PgfCCat* completed =
							pgf_parsing_get_completed(state, conts);
						if (completed) {
							pgf_parsing_combine(state, state->next, item, completed, slit->r, true);
						}

						state = state->next;
					}
				}
			}
		}
		break;
	}
	case PGF_SYMBOL_VAR:
		// XXX TODO proper support
		break;
	default:
		gu_impossible();
	}
}

static void
pgf_parsing_item(PgfParseState* before, PgfParseState* after, PgfItem* item)
{
#ifdef PGF_PARSER_DEBUG
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    pgf_print_item(item, wtr, err, tmp_pool);
    gu_pool_free(tmp_pool);
#endif

	GuVariantInfo i = gu_variant_open(item->base->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
		PgfCncFun* fun = papp->fun;
		PgfSequence seq = fun->lins[item->base->lin_idx];
		if (item->seq_idx == gu_seq_length(seq)) {
			pgf_parsing_complete(before, after, item, NULL);
		} else  {
			PgfSymbol sym = 
				gu_seq_get(seq, PgfSymbol, item->seq_idx);
			pgf_parsing_symbol(before, after, item, sym);
		}
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = i.data;
		switch (item->seq_idx) {
		case 0:
			pgf_parsing_td_predict(before, after, item, 
					    pcoerce->coerce,
					    item->base->lin_idx, 0);
			break;
		case 1:
			pgf_parsing_complete(before, after, item, NULL);
			break;
		default:
			gu_impossible();
		}
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = i.data;
		
		PgfSequence seq;
		if (!gu_seq_is_null(pext->lins) &&
		    !gu_seq_is_null(seq = gu_seq_get(pext->lins,PgfSequence,item->base->lin_idx))) {
			if (item->seq_idx == gu_seq_length(seq)) {
				pgf_parsing_complete(before, after, item, NULL);
			} else  {
				PgfSymbol sym =
					gu_seq_get(seq, PgfSymbol, item->seq_idx);
				pgf_parsing_symbol(before, after, item, sym);
			}
		} else {
			PgfToken tok = (after != NULL) ? after->ts->tok
			                               : gu_empty_string;

			PgfExprProb *ep = NULL;
			bool accepted = 
				pext->callback->match(before->ps->concr, item, 
				                      tok,
				                      &ep, before->pool);

			if (ep != NULL)
				pgf_parsing_complete(before, after, item, ep);

			if (accepted && after != NULL) {
				PgfSymbol prev = item->curr_sym;
				PgfSymbolKS* sks = (PgfSymbolKS*)
					gu_alloc_variant(PGF_SYMBOL_KS,
									 sizeof(PgfSymbolKS)+sizeof(PgfSymbol),
									 gu_alignof(PgfSymbolKS),
									 &item->curr_sym, after->pool);
				*((PgfSymbol*)(sks+1)) = prev;
				sks->tokens = gu_new_seq(PgfToken, 1, after->pool);
				gu_seq_set(sks->tokens, PgfToken, 0, tok);

				item->seq_idx++;
#ifdef PGF_PARSER_DEBUG
				item->end++;
#endif
				pgf_parsing_add_transition(before, after, tok, item);
			}
		}
		break;
	}
	case PGF_PRODUCTION_META: {
		PgfProductionMeta* pmeta = i.data;

		PgfSequence seq;
		if (!gu_seq_is_null(pmeta->lins) &&
		    !gu_seq_is_null(seq = gu_seq_get(pmeta->lins,PgfSequence,item->base->lin_idx))) {
			if (item->seq_idx == gu_seq_length(seq)) {
				pgf_parsing_complete(before, after, item, NULL);
			} else  {
				PgfSymbol sym =
					gu_seq_get(seq, PgfSymbol, item->seq_idx);
				pgf_parsing_symbol(before, after, item, sym);
			}
		} else {
			if (!gu_variant_is_null(item->curr_sym)) {
				PgfExprProb *ep = gu_new(PgfExprProb, before->pool);
				ep->expr = before->ps->meta_var;
				ep->prob = item->inside_prob;
				size_t n_args = gu_seq_length(item->args);
				for (size_t i = 0; i < n_args; i++) {
					PgfPArg* arg = gu_seq_index(item->args, PgfPArg, i);
					ep->prob -= arg->ccat->viterbi_prob;
				}
				pgf_parsing_complete(before, after, item, ep);
			}

			if (after != NULL) {
				if (after->ts->lexicon_idx == NULL) {
					prob_t meta_token_prob = 
						item->base->ccat->cnccat->abscat->meta_token_prob;
					if (meta_token_prob == INFINITY)
						break;
					item->inside_prob += meta_token_prob;

					PgfSymbol prev = item->curr_sym;
					PgfSymbolKS* sks = (PgfSymbolKS*)
						gu_alloc_variant(PGF_SYMBOL_KS,
										 sizeof(PgfSymbolKS)+sizeof(PgfSymbol),
										 gu_alignof(PgfSymbolKS),
										 &item->curr_sym, after->pool);
					*((PgfSymbol*)(sks+1)) = prev;
					sks->tokens = gu_new_seq(PgfToken, 1, after->pool);
					gu_seq_set(sks->tokens, PgfToken, 0, after->ts->tok);

					item->seq_idx++;
#ifdef PGF_PARSER_DEBUG
					item->end++;
#endif
					pgf_parsing_add_transition(before, after, after->ts->tok, item);
				} else {
					PgfCIdMap* meta_child_probs =
						item->base->ccat->cnccat->abscat->meta_child_probs;
					if (meta_child_probs != NULL) {
						PgfMetaPredictFn clo = { { pgf_parsing_meta_predict }, before, after, item };
						gu_map_iter(meta_child_probs, &clo.fn, NULL);
					}
/*
					fprintf(stderr, "------------------------------------\n");
					pgf_parsing_bu_predict(before, after,
										   after->ts->lexicon_idx, item, 
										   NULL);
					fprintf(stderr, "------------------------------------\n");*/
				}
			}
		}
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_parsing_proceed(PgfParseState* state, void** output) {
	while (*output == NULL) {
		if (state->ps->item_count > state->ps->concr->item_quota)
			break;

		prob_t best_prob = INFINITY;
		PgfParseState* before = NULL;

		PgfParseState* st = state;
		while (st != NULL) {
			if (gu_buf_length(st->agenda) > 0) {
				PgfItem* item = gu_buf_get(st->agenda, PgfItem*, 0);
				prob_t item_prob = item->inside_prob+item->outside_prob;
				if (item_prob < best_prob) {
					best_prob = item_prob;
					before    = st;
				}
			}
			st = st->next;
		}

		if (before == NULL)
			break;

		PgfParseState* after = NULL;

		st = state;
		while (st != before) {
			PgfParseState* tmp = st->next;
			st->next = after;
			after    = st;
			st       = tmp;
		}

		PgfItem* item;
		gu_buf_heap_pop(before->agenda, &pgf_item_prob_order, &item);
		pgf_parsing_item(before, after, item);

		while (after != NULL) {
			PgfParseState* tmp = after->next;
			after->next = before;
			before = after;
			after  = tmp;
		}
		state = before;
	}
}

static PgfParsing*
pgf_new_parsing(PgfConcr* concr, GuPool* pool)
{
	PgfParsing* ps = gu_new(PgfParsing, pool);
	ps->concr = concr;
	ps->completed = NULL;
	ps->target = NULL;
	ps->max_fid = concr->max_fid;
	ps->item_count = 0;

	PgfExprMeta *expr_meta =
		gu_new_variant(PGF_EXPR_META,
					   PgfExprMeta,
					   &ps->meta_var, pool);
	expr_meta->id = 0;

	PgfProductionMeta* pmeta =
		gu_new_variant(PGF_PRODUCTION_META,
					   PgfProductionMeta,
					   &ps->meta_prod, pool);
	pmeta->ep   = NULL;
	pmeta->lins = gu_null_seq;
	pmeta->args = gu_new_seq(PgfPArg, 0, pool);

	return ps;
}

static PgfParseState*
pgf_new_parse_state(PgfParsing* ps,
                    PgfParseState* next,
                    PgfTokenState* ts, int offset,
                    GuPool* pool)
{
	PgfParseState* state = gu_new(PgfParseState, pool);
	state->pool = pool;
	state->next = next;
    state->agenda = gu_new_buf(PgfItem*, pool);
	state->generated_cats = gu_map_type_new(PgfGenCatMap, pool);
	state->conts_map = gu_map_type_new(PgfContsMap, pool);
    state->offset = offset;
    state->ps = ps;
    state->ts = ts;
	return state;
}

static PgfTokenState*
pgf_new_token_state(PgfConcr *concr, PgfToken tok, GuPool* pool)
{
	PgfTokenState* ts = gu_new(PgfTokenState, pool);
	ts->tok = tok;
    ts->lexicon_idx = gu_map_get(concr->lexicon_idx, &tok, GuBuf*);
	return ts;
}

PgfParseState*
pgf_parser_next_state(PgfParseState* prev, PgfToken tok, GuPool* pool)
{
	PgfTokenState* ts =
		pgf_new_token_state(prev->ps->concr,tok,pool);
	PgfParseState* state =
	    pgf_new_parse_state(prev->ps, prev,
                            ts, prev->offset+1,
                            pool);

	state->ps->target = NULL;
	pgf_parsing_proceed(state, (void**) &state->ps->target);
    if (state->ps->target != NULL) {
		return state;
    }

	return NULL;
}

static int
cmp_expr_qstate(GuOrder* self, const void* a, const void* b)
{
	PgfExprQState *s1 = (PgfExprQState *) a;
	PgfExprQState *s2 = (PgfExprQState *) b;

	if (s1->prob < s2->prob)
		return -1;
	else if (s1->prob > s2->prob)
		return 1;
	else
		return 0;
}

static GuOrder
pgf_expr_qstate_order = { cmp_expr_qstate };

static void
pgf_result_cat_init(PgfParseResult* pr,
                    PgfExprState* cont, prob_t cont_prob, PgfCCat* ccat)
{
	// Checking for loops in the chart
	if (cont != NULL) {
		PgfExprState* st = cont->cont;
		while (st != NULL) {
			PgfPArg* arg = gu_seq_index(st->args, PgfPArg, st->arg_idx);
			if (arg->ccat == ccat)
				return;

			st = st->cont;
		}
	}

	if (gu_seq_is_null(ccat->prods))
		return;

	// Generation
	size_t n_prods = gu_seq_length(ccat->prods);
	for (size_t i = 0; i < n_prods; i++) {
		PgfProduction prod =
			gu_seq_get(ccat->prods, PgfProduction, i);

		GuVariantInfo pi = gu_variant_open(prod);
		switch (pi.tag) {
		case PGF_PRODUCTION_APPLY: {
			PgfProductionApply* papp = pi.data;

			PgfExprState *st = gu_new(PgfExprState, pr->tmp_pool);
			st->cont = cont;
			st->expr = papp->fun->ep->expr;
			st->args = papp->args;
			st->arg_idx = 0;

			PgfExprQState q = {st, cont_prob + papp->fun->ep->prob};
			size_t n_args = gu_seq_length(st->args);
			for (size_t k = 0; k < n_args; k++) {
				PgfPArg* parg = gu_seq_index(st->args, PgfPArg, k);
				q.prob += parg->ccat->viterbi_prob;
			}

			gu_buf_heap_push(pr->pqueue, &pgf_expr_qstate_order, &q);
			break;
		}
		case PGF_PRODUCTION_COERCE: {
			PgfProductionCoerce* pcoerce = pi.data;
			pgf_result_cat_init(pr, cont, cont_prob, pcoerce->coerce);
			break;
		}
		case PGF_PRODUCTION_EXTERN: {
			PgfProductionExtern* pext = pi.data;

			PgfExprState *st = gu_new(PgfExprState, pr->tmp_pool);
			st->cont = cont;
			st->expr = pext->ep->expr;
			st->args = gu_empty_seq();
			st->arg_idx = 0;

			PgfExprQState q = {st, cont_prob + pext->ep->prob};
			gu_buf_heap_push(pr->pqueue, &pgf_expr_qstate_order, &q);
			break;
		}
		case PGF_PRODUCTION_META: {
			PgfProductionMeta* pmeta = pi.data;

			PgfExprState *st = gu_new(PgfExprState, pr->tmp_pool);
			st->cont = cont;
			st->expr = pmeta->ep->expr;
			st->args = pmeta->args;
			st->arg_idx = 0;

			PgfExprQState q = {st, cont_prob + pmeta->ep->prob};
			size_t n_args = gu_seq_length(st->args);
			for (size_t k = 0; k < n_args; k++) {
				PgfPArg* parg = gu_seq_index(st->args, PgfPArg, k);
				q.prob += parg->ccat->viterbi_prob;
			}

			gu_buf_heap_push(pr->pqueue, &pgf_expr_qstate_order, &q);
			break;
		}
		default:
			gu_impossible();
		}
	}
}

static PgfExprProb*
pgf_parse_result_next(PgfParseResult* pr, GuPool* pool)
{
	if (pr->pqueue == NULL)
		return NULL;

	for (;;) {
		if (pr->state->ps->completed == NULL) {
			pgf_parsing_proceed(pr->state,
								(void**) &pr->state->ps->completed);
			if (pr->state->ps->completed == NULL)
				return NULL;
			pgf_result_cat_init(pr, NULL, 0, pr->state->ps->completed);
		}

		while (gu_buf_length(pr->pqueue) > 0) {
			PgfExprQState q;
			gu_buf_heap_pop(pr->pqueue, &pgf_expr_qstate_order, &q);

			if (q.st->arg_idx < gu_seq_length(q.st->args)) {
				PgfPArg* arg = gu_seq_index(q.st->args, PgfPArg, q.st->arg_idx);
				prob_t cont_prob = q.prob - arg->ccat->viterbi_prob;
				if (arg->ccat->fid < pr->state->ps->concr->total_cats) {
					q.st->expr =
						gu_new_variant_i(pool, PGF_EXPR_APP,
						                 PgfExprApp,
							             .fun = q.st->expr,
							             .arg = pr->state->ps->meta_var);
					q.st->arg_idx++;
					gu_buf_heap_push(pr->pqueue, &pgf_expr_qstate_order, &q);
				} else {
					pgf_result_cat_init(pr, q.st, cont_prob, arg->ccat);
				}
			} else {
				if (q.st->cont == NULL) {
					PgfExprProb* ep = gu_new(PgfExprProb, pool);
					ep->expr = q.st->expr;
					ep->prob = q.prob;
					return ep;
				}

				PgfExprState* st = gu_new(PgfExprState, pr->tmp_pool);
				st->cont = q.st->cont->cont;
				st->expr =
					gu_new_variant_i(pool, PGF_EXPR_APP,
							PgfExprApp,
							.fun = q.st->cont->expr, .arg = q.st->expr);
				st->args = q.st->cont->args;
				st->arg_idx = q.st->cont->arg_idx+1;
				
				PgfExprQState q2 = {st, q.prob};
				gu_buf_heap_push(pr->pqueue, &pgf_expr_qstate_order, &q2);
			}
		}

		pr->state->ps->completed = NULL;
	}

	gu_pool_free(pr->tmp_pool);
	pr->tmp_pool = NULL;
	pr->pqueue = NULL;
	return NULL;
}

static void
pgf_parse_result_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfParseResult* pr = gu_container(self, PgfParseResult, en);
	*(PgfExprProb**)to = pgf_parse_result_next(pr, pool);
}

PgfExprEnum*
pgf_parse_result(PgfParseState* state, GuPool* pool)
{
	GuPool* tmp_pool = gu_new_pool();
	GuBuf* pqueue = gu_new_buf(PgfExprQState, tmp_pool);

	PgfExprEnum* en =
           &gu_new_i(pool, PgfParseResult,
			 .tmp_pool = tmp_pool,
             .state = state,
			 .pqueue = pqueue,
			 .en.next = pgf_parse_result_enum_next)->en;

	return en;
}


// TODO: s/CId/Cat, add the cid to Cat, make Cat the key to CncCat
PgfParseState*
pgf_parser_init_state(PgfConcr* concr, PgfCId cat, size_t lin_idx, GuPool* pool)
{
	PgfCncCat* cnccat =
		gu_map_get(concr->cnccats, &cat, PgfCncCat*);
	if (!cnccat) {
		// error ...
		gu_impossible();
	}
	gu_assert(lin_idx < cnccat->n_lins);

	PgfParsing* ps =
		pgf_new_parsing(concr, pool);
	PgfParseState* state =
		pgf_new_parse_state(ps, NULL, NULL, 0, pool);

    PgfItemBuf* conts = gu_new_buf(PgfItem*, pool);
    gu_buf_push(conts, PgfItem*, NULL);

	size_t n_ccats = gu_list_length(cnccat->cats);
	for (size_t i = 0; i < n_ccats; i++) {
		PgfCCat* ccat = gu_list_index(cnccat->cats, i);
		if (ccat != NULL) {
            if (gu_seq_is_null(ccat->prods)) {
                // Empty category
                continue;
            }
            
            PgfProductionSeq prods = ccat->prods;
            size_t n_prods = gu_seq_length(prods);
            for (size_t i = 0; i < n_prods; i++) {
                PgfProduction prod =
                    gu_seq_get(prods, PgfProduction, i);
                PgfItem* item = 
                    pgf_new_item(0, ccat, lin_idx, prod, conts, 0, pool);
                ps->item_count++;
                gu_buf_heap_push(state->agenda, &pgf_item_prob_order, &item);
            }
            
         	PgfItem *item =
				pgf_new_item(0, ccat, lin_idx, ps->meta_prod, conts, 0, pool);
			ps->item_count++;
			item->inside_prob = 
				ccat->cnccat->abscat->meta_prob;
			gu_buf_heap_push(state->agenda, &pgf_item_prob_order, &item);
		}
	}
	return state;
}

void
pgf_parser_add_literal(PgfConcr *concr, PgfCId cat,
                       PgfLiteralCallback* callback)
{
	PgfCncCat* cnccat =
		gu_map_get(concr->cnccats, &cat, PgfCncCat*);
	if (cnccat == NULL)
		return;

	gu_map_put(concr->callbacks, cnccat,
	           PgfLiteralCallback*, callback);
}

static void
pgf_parser_bu_add_entry(PgfConcr* concr, PgfTokens tokens,
                        PgfItem* item,
						GuPool *pool)
{
	PgfToken tok = gu_seq_get(tokens, PgfToken, 0);
					
	GuBuf* items = gu_map_get(concr->lexicon_idx, &tok, GuBuf*);
	if (items == NULL) {
		items = gu_new_buf(PgfItemBase*, pool);
		gu_map_put(concr->lexicon_idx, &tok, GuBuf*, items);
	}

	gu_buf_push(items, PgfItem*, item);
}

void
pgf_parser_bu_item(PgfConcr* concr, PgfItem* item, 
					PgfContsMap* conts_map,
					GuPool *pool, GuPool *tmp_pool)
{
	GuVariantInfo i = gu_variant_open(item->base->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;

		PgfSequence seq = papp->fun->lins[item->base->lin_idx];
		if (item->seq_idx < gu_seq_length(seq)) {
			GuVariantInfo i = gu_variant_open(item->curr_sym);
			switch (i.tag) {
			case PGF_SYMBOL_CAT: {
				PgfSymbolCat* scat = i.data;

				// Place the item in the continuation map
				PgfPArg* parg =
					gu_seq_index(item->args, PgfPArg, scat->d);
				PgfItemBuf* conts_ =
					pgf_parsing_get_conts(conts_map, 
										  parg->ccat, scat->r,
										  pool, tmp_pool);
				gu_buf_push(conts_, PgfItem*, item);

				// If the current category has epsilon rules
				// then we must do the same for a new item where 
				// the dot is moved with one position.
				PgfCFCat cfc = {parg->ccat->fid, scat->r};
				PgfCCat* eps_ccat =
					gu_map_get(concr->epsilon_idx, &cfc, PgfCCat*);

				if (eps_ccat != NULL) {
					PgfItem* new_item =
						pgf_item_update_arg(item, scat->d, eps_ccat, pool);
					pgf_item_advance(new_item, pool);
					pgf_parser_bu_item(concr, new_item, conts_map,
					                   pool, tmp_pool);
				}
				break;
			}
			case PGF_SYMBOL_KS: {
				PgfSymbolKS* sks = i.data;
				
				item->tok_idx++;
				if (item->tok_idx == gu_seq_length(sks->tokens)) {
					item->tok_idx = 0;
					pgf_item_advance(item, pool);
				}

				pgf_parser_bu_add_entry(concr, sks->tokens,
										 item, pool);
				break;
			}
			case PGF_SYMBOL_KP: {
				PgfSymbolKP* skp = i.data;

				item->tok_idx++;
				if (item->tok_idx == gu_seq_length(skp->default_form)) {
					item->tok_idx = 0;
					pgf_item_advance(item, pool);
				}

				pgf_parser_bu_add_entry(concr, skp->default_form,
										 item, pool);
				for (size_t i = 0; i < skp->n_forms; i++) {
					pgf_parser_bu_add_entry(concr, skp->forms[i].form,
											 item, pool);
				}
				break;
			}
			case PGF_SYMBOL_LIT:
				// Nothing to be done here
				break;
			case PGF_SYMBOL_VAR:
				// XXX TODO proper support
				break;
			default:
				gu_impossible();
			}
		} else {
			PgfCFCat cfc = {item->base->ccat->fid, item->base->lin_idx};
			PgfCCat* tmp_ccat =
				gu_map_get(concr->epsilon_idx, &cfc, PgfCCat*);

			PgfCCat* eps_ccat = tmp_ccat;
			if (eps_ccat == NULL) {
				eps_ccat = gu_new(PgfCCat, pool);
				eps_ccat->cnccat = item->base->ccat->cnccat;
				eps_ccat->viterbi_prob = INFINITY;
				eps_ccat->fid = concr->max_fid++;
				eps_ccat->prods = 
					gu_buf_seq(gu_new_buf(PgfProduction, pool));
				eps_ccat->n_synprods = 0;
				gu_map_put(concr->epsilon_idx, &cfc, PgfCCat*, eps_ccat);
			}

			PgfProduction prod =
				pgf_parsing_new_production(item, NULL, pool);
			GuBuf* prodbuf = gu_seq_buf(eps_ccat->prods);
			gu_buf_push(prodbuf, PgfProduction, prod);
			eps_ccat->n_synprods++;

			if (eps_ccat->viterbi_prob > item->inside_prob)
				eps_ccat->viterbi_prob = item->inside_prob;

			if (tmp_ccat == NULL) {
				size_t n_items = gu_buf_length(item->base->conts);
				for (size_t i = 0; i < n_items; i++) {
					PgfItem* cont = 
						gu_buf_get(item->base->conts, PgfItem*, i);

					gu_assert(gu_variant_tag(cont->curr_sym) == PGF_SYMBOL_CAT);
					PgfSymbolCat* scat = gu_variant_data(cont->curr_sym);

					PgfItem* new_item =
						pgf_item_update_arg(cont, scat->d, eps_ccat, pool);
					pgf_item_advance(new_item, pool);
					pgf_parser_bu_item(concr, new_item, conts_map,
					                   pool, tmp_pool);
				}
			}
		}
	}
	break;
	case PGF_PRODUCTION_COERCE: {
		PgfPArg* parg =
			gu_seq_index(item->args, PgfPArg, 0);
		PgfItemBuf* conts_ =
			pgf_parsing_get_conts(conts_map,
								  parg->ccat, item->base->lin_idx,
								  pool, tmp_pool);
		gu_buf_push(conts_, PgfItem*, item);

		// If the argument category has epsilon rules
		// then the result category has epsilon rules too.
		PgfCFCat cfc = {parg->ccat->fid, item->base->lin_idx};
		PgfCCat* eps_arg_ccat =
			gu_map_get(concr->epsilon_idx, &cfc, PgfCCat*);

		if (eps_arg_ccat != NULL) {			                   
			PgfCFCat cfc = {item->base->ccat->fid, item->base->lin_idx};
			PgfCCat* tmp_ccat =
				gu_map_get(concr->epsilon_idx, &cfc, PgfCCat*);

			PgfCCat* eps_res_ccat = tmp_ccat;
			if (eps_res_ccat == NULL) {
				eps_res_ccat = gu_new(PgfCCat, pool);
				eps_res_ccat->cnccat = item->base->ccat->cnccat;
				eps_res_ccat->fid = concr->max_fid++;
				eps_res_ccat->prods = 
					gu_buf_seq(gu_new_buf(PgfProduction, pool));
				eps_res_ccat->n_synprods = 0;
				gu_map_put(concr->epsilon_idx, &cfc, PgfCCat*, eps_res_ccat);
			}

			PgfProduction prod;
			PgfProductionCoerce* new_pcoerce =
				gu_new_variant(PGF_PRODUCTION_COERCE,
				       PgfProductionCoerce,
				       &prod, pool);
			new_pcoerce->coerce = eps_arg_ccat;

			GuBuf* prodbuf = gu_seq_buf(eps_res_ccat->prods);
			gu_buf_push(prodbuf, PgfProduction, prod);
			eps_res_ccat->n_synprods++;

			if (tmp_ccat == NULL) {
				size_t n_items = gu_buf_length(item->base->conts);
				for (size_t i = 0; i < n_items; i++) {
					PgfItem* cont = 
						gu_buf_get(item->base->conts, PgfItem*, i);

					gu_assert(gu_variant_tag(cont->curr_sym) == PGF_SYMBOL_CAT);
					PgfSymbolCat* scat = gu_variant_data(cont->curr_sym);

					PgfItem* new_item =
						pgf_item_update_arg(cont, scat->d, eps_res_ccat, pool);
					pgf_item_advance(new_item, pool);
					pgf_parser_bu_item(concr, new_item, conts_map,
					                   pool, tmp_pool);
				}
			}
		}
		break;
	}
	default:
		gu_impossible();
	}
}

void
pgf_parser_bu_index(PgfConcr* concr, PgfCCat* ccat, PgfProduction prod, 
					PgfContsMap* conts_map,
					GuPool *pool, GuPool *tmp_pool)
{
	for (size_t lin_idx = 0; lin_idx < ccat->cnccat->n_lins; lin_idx++) {
		PgfItemBuf* conts =
			pgf_parsing_get_conts(conts_map, ccat, lin_idx,
			                      pool, tmp_pool);
		PgfItem* item =
			pgf_new_item(0, ccat, lin_idx, prod, conts, 0, pool);

		pgf_parser_bu_item(concr, item, conts_map, pool, tmp_pool);
	}
}

bool
pgf_cfcat_eq_fn(GuEquality* self, const void* a, const void* b)
{
	PgfCFCat *x = (PgfCFCat *) a;
	PgfCFCat *y = (PgfCFCat *) b;
	
	return (x->fid == y->fid && x->lin_idx == y->lin_idx);
}

GuHash
pgf_cfcat_hash_fn(GuHasher* self, const void* a)
{
	PgfCFCat *x = (PgfCFCat *) a;
	return ((x->fid << 16) ^ x->lin_idx);
}

GuHasher pgf_cfcat_hasher = {
	{ pgf_cfcat_eq_fn },
	pgf_cfcat_hash_fn
};
