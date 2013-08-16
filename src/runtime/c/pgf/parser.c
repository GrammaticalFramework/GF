#include <pgf/parser.h>
#include <gu/seq.h>
#include <gu/assert.h>

#include <gu/log.h>
#include <gu/file.h>
#include <math.h>
#include <stdlib.h>

//#define PGF_PARSER_DEBUG
//#define PGF_COUNTS_DEBUG
//#define PGF_LEFTCORNER_DEBUG
//#define PGF_LEFTCORNER_FILTER
//#define PGF_RESULT_DEBUG

typedef GuBuf PgfItemBuf;
static GU_DEFINE_TYPE(PgfItemBuf, abstract, _);

struct PgfItemConts {
	PgfCCat* ccat;
	size_t lin_idx;
	PgfParseState* state;
	prob_t outside_prob;
	PgfItemBuf* items;
	int ref_count;			// how many items point to this cont?
};

static GU_DEFINE_TYPE(PgfItemConts, abstract, _);

typedef GuList(PgfItemConts*) PgfItemContss;
static GU_DEFINE_TYPE(PgfItemContss, abstract, _);

typedef GuMap PgfContsMap;
static GU_DEFINE_TYPE(PgfContsMap, GuMap,
                      gu_type(PgfCCat), NULL,
                      gu_ptr_type(PgfItemContss), &gu_null_struct);

typedef GuMap PgfGenCatMap;
static GU_DEFINE_TYPE(PgfGenCatMap, GuMap,
		              gu_type(PgfItemConts), NULL,
		              gu_ptr_type(PgfCCat), &gu_null_struct);

typedef GuBuf PgfCCatBuf;

typedef struct {
	PgfConcr* concr;
	GuPool* pool;      // this pool is used for structures internal to the parser
	GuPool* out_pool;  // this pool is used for the allocating the final abstract trees
	GuBuf* expr_queue;
	PgfExpr meta_var;
	PgfProduction meta_prod;
    int max_fid;
#ifdef PGF_COUNTS_DEBUG
    int item_full_count;
    int item_real_count;
    int cont_full_count;
    int ccat_full_count;
    int prod_full_count;
#endif
    PgfItem* free_item;
    prob_t beam_size;
} PgfParsing;

typedef struct {
	PgfCCat* ccat;
	size_t lin_idx;
} PgfCFCat;

static GU_DEFINE_TYPE(PgfCFCat, struct,
	       GU_MEMBER(PgfCFCat, ccat, PgfCCat),
           GU_MEMBER(PgfCFCat, lin_idx, size_t));

extern GuHasher pgf_cfcat_hasher;

GU_DEFINE_TYPE(PgfProductionIdx, GuMap,
		       gu_type(PgfCFCat), &pgf_cfcat_hasher,
		       gu_type(PgfProductionSeq), &gu_null_seq);

typedef struct PgfTokenState PgfTokenState;

typedef struct {
	bool (*match_token)(PgfTokenState* ts, PgfToken tok, PgfItem* item);
	PgfToken (*get_token)(PgfTokenState* ts);
	PgfProductionIdx* (*get_lexicon_idx)(PgfTokenState* ts);
} PgfTokenFn;

struct PgfTokenState {
	PgfTokenFn* fn;
    prob_t lexical_prob;
};

struct PgfParseState {
	PgfParseState* next;

    PgfItemBuf* agenda;
    PgfItem* meta_item;
	PgfContsMap* conts_map;
	PgfGenCatMap* generated_cats;
    unsigned short offset;

	prob_t viterbi_prob;

    PgfParsing* ps;
    PgfTokenState* ts;
};

typedef struct PgfAnswers {
	GuBuf* conts;
	GuBuf* exprs;
	prob_t outside_prob;
} PgfAnswers;

typedef struct {
	PgfAnswers* answers;
	PgfExprProb ep;
	PgfPArgs args;
	size_t arg_idx;
} PgfExprState;

typedef struct PgfParseResult PgfParseResult;

struct PgfParseResult {
    PgfParseState* state;
	PgfExprEnum en;
};

typedef struct PgfItemBase PgfItemBase;

struct PgfItem {
	union {
		PgfItemConts* conts;
		PgfItem *next;		// used to collect released items
	};

	PgfProduction prod;
	PgfPArgs args;
	PgfSymbol curr_sym;
	uint16_t seq_idx;
	uint8_t tok_idx;
	uint8_t alt;
	prob_t inside_prob;
};

GU_DEFINE_TYPE(PgfLeftcornerCatIdx, GuMap,
		       gu_type(PgfCFCat), &pgf_cfcat_hasher,
		       gu_ptr_type(PgfProductionIdx), &gu_null_struct);

GU_DEFINE_TYPE(PgfLeftcornerTokIdx, GuStringMap,
		       gu_ptr_type(PgfProductionIdx), &gu_null_struct);

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

size_t
pgf_item_lin_idx(PgfItem* item) {
	return item->conts->lin_idx;
}

int
pgf_item_sequence_length(PgfItem* item)
{
    GuVariantInfo i = gu_variant_open(item->prod);
    switch (i.tag) {
    case PGF_PRODUCTION_APPLY: {
        PgfProductionApply* papp = i.data;
        return gu_seq_length(papp->fun->lins[item->conts->lin_idx]);
    }
    case PGF_PRODUCTION_COERCE: {
        return 1;
    }
    case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = i.data;
        PgfSequence seq;
        
        if (!gu_seq_is_null(pext->lins) &&
            !gu_seq_is_null(seq = gu_seq_get(pext->lins,PgfSequence,item->conts->lin_idx))) {
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
		int seq_len = 0;
		PgfSymbol sym = item->curr_sym;
		while (!gu_variant_is_null(sym)) {
			seq_len++;
			sym = pgf_prev_extern_sym(sym);
		}
		
		return seq_len;
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
                  size_t* lin_idx, PgfSequence* seq,
                  GuPool* pool) {
	*lin_idx = item->conts->lin_idx;

    GuVariantInfo i = gu_variant_open(item->prod);
    switch (i.tag) {
    case PGF_PRODUCTION_APPLY: {
        PgfProductionApply* papp = i.data;
        *seq = papp->fun->lins[item->conts->lin_idx];
        break;
    }
    case PGF_PRODUCTION_COERCE: {
        PgfSymbol sym =
			gu_new_variant_i(pool, PGF_SYMBOL_CAT,
						PgfSymbolCat,
						.d = 0, .r = item->conts->lin_idx);
		*seq = gu_new_seq(PgfSequence, 1, pool);
		gu_seq_set(*seq, PgfSymbol, 0, sym);
        break;
    }
    case PGF_PRODUCTION_EXTERN: {
        PgfProductionExtern* pext = i.data;
        
        if (gu_seq_is_null(pext->lins) ||
            gu_seq_is_null(*seq = gu_seq_get(pext->lins, PgfSequence, item->conts->lin_idx))) {
		  *seq = pgf_extern_seq_get(item, pool);
		}
		break;
    }
    case PGF_PRODUCTION_META: {
		*seq = pgf_extern_seq_get(item, pool);
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
        pgf_print_expr(papp->fun->ep->expr, NULL, 0, wtr, err);
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
        pgf_print_expr(pext->ep->expr, NULL, 0, wtr, err);
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
	size_t lin_idx;
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
pgf_print_item(PgfItem* item, PgfParseState* state, GuWriter* wtr, GuExn* err, GuPool* pool)
{
    gu_printf(wtr, err, "[%d-%d; C%d -> ",
	                    item->conts->state ? item->conts->state->offset : 0,
	                    state ? state->offset : 0,
	                    item->conts->ccat->fid);

	GuVariantInfo i = gu_variant_open(item->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
        PgfCncFun* fun = papp->fun;
        gu_printf(wtr, err, "F%d(", fun->funid);
        pgf_print_expr(fun->ep->expr, NULL, 0, wtr, err);
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
			pgf_print_expr(pext->ep->expr, NULL, 0, wtr, err);
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
	            item->conts->outside_prob,
	            item->inside_prob+item->conts->outside_prob);
}

#ifdef PGF_RESULT_DEBUG
static void
pgf_print_expr_state(PgfExprState* st,
                     GuWriter* wtr, GuExn* err, GuBuf* stack)
{
	gu_buf_push(stack, int, (gu_seq_length(st->args) - st->arg_idx - 1));

	if (gu_buf_length(st->answers->conts) > 0) {
		PgfExprState* cont = gu_buf_get(st->answers->conts, PgfExprState*, 0);
		if (cont != NULL)
			pgf_print_expr_state(cont, wtr, err, stack);
	}

	gu_puts(" (", wtr, err);
	pgf_print_expr(st->ep.expr, NULL, 0, wtr, err);
}

static void
pgf_print_expr_state0(PgfExprState* st,
                      GuWriter* wtr, GuExn* err, GuPool* tmp_pool)
{	
	gu_printf(wtr, err, "[%f+%f=%f]", 
		st->ep.prob,
		st->answers->outside_prob,
		st->answers->outside_prob+st->ep.prob);

	size_t n_args = gu_seq_length(st->args);

	GuBuf* stack = gu_new_buf(int, tmp_pool);
	if (n_args > 0)
		gu_buf_push(stack, int, n_args - st->arg_idx);

	if (gu_buf_length(st->answers->conts) > 0) {
		PgfExprState* cont =
			gu_buf_get(st->answers->conts, PgfExprState*, 0);
		if (cont != NULL)
			pgf_print_expr_state(cont, wtr, err, stack);
	}

	if (n_args > 0)
		gu_puts(" (", wtr, err);
	else
		gu_puts(" ", wtr, err);
	pgf_print_expr(st->ep.expr, NULL, 0, wtr, err);

	size_t n_counts = gu_buf_length(stack);
	for (size_t i = 0; i < n_counts; i++) {
		int count = gu_buf_get(stack, int, i);
		while (count-- > 0)
			gu_puts(" ?", wtr, err);
		
		gu_puts(")", wtr, err);
	}
	gu_puts("\n", wtr, err);
}
#endif
#endif

static int
cmp_item_prob(GuOrder* self, const void* a, const void* b)
{
	PgfItem *item1 = *((PgfItem **) a);
	PgfItem *item2 = *((PgfItem **) b);

	prob_t prob1 = item1->inside_prob + item1->conts->outside_prob;
	prob_t prob2 = item2->inside_prob + item2->conts->outside_prob;
	
	if (prob1 < prob2)
		return -1;
	else if (prob1 > prob2)
		return 1;
	else
		return 0;
}

static GuOrder
pgf_item_prob_order = { cmp_item_prob };

static PgfItemContss*
pgf_parsing_get_contss(PgfContsMap* conts_map, PgfCCat* cat, GuPool *pool)
{
	PgfItemContss* contss = gu_map_get(conts_map, cat, PgfItemContss*);
	if (!contss) {
		size_t n_lins = cat->cnccat->n_lins;
		contss = gu_new_list(PgfItemContss, pool, n_lins);
		for (size_t i = 0; i < n_lins; i++) {
			gu_list_index(contss, i) = NULL;
		}
		gu_map_put(conts_map, cat, PgfItemContss*, contss);
	}
	return contss;
}

static PgfItemConts*
pgf_parsing_get_conts(PgfContsMap* conts_map,
                      PgfCCat* ccat, size_t lin_idx, 
                      PgfParseState* state,
					  GuPool *pool)
{
	gu_require(lin_idx < ccat->cnccat->n_lins);
	PgfItemContss* contss = 
		pgf_parsing_get_contss(conts_map, ccat, pool);
	PgfItemConts* conts = gu_list_index(contss, lin_idx);
	if (!conts) {
		conts = gu_new(PgfItemConts, pool);
		conts->ccat      = ccat;
		conts->lin_idx   = lin_idx;
		conts->state     = state;
		conts->items     = gu_new_buf(PgfItem*, pool);
		conts->outside_prob = 0;
		conts->ref_count = 0;
		gu_list_index(contss, lin_idx) = conts;
		
#ifdef PGF_COUNTS_DEBUG
		if (state != NULL) {
			state->ps->cont_full_count++;
		}
#endif
	}
	return conts;
}

static PgfCCat*
pgf_parsing_create_completed(PgfParseState* state, PgfItemConts* conts,
                             prob_t viterbi_prob)
{
	PgfCCat* cat = gu_new(PgfCCat, state->ps->pool);
	cat->cnccat = conts->ccat->cnccat;
	cat->viterbi_prob = viterbi_prob;
	cat->fid = state->ps->max_fid++;
	cat->conts = conts;
	cat->answers = NULL;
	cat->prods = gu_buf_seq(gu_new_buf(PgfProduction, state->ps->pool));
	cat->n_synprods = 0;
	gu_map_put(state->generated_cats, conts, PgfCCat*, cat);

#ifdef PGF_COUNTS_DEBUG	
	state->ps->ccat_full_count++;
#endif

	return cat;
}

static PgfCCat*
pgf_parsing_get_completed(PgfParseState* state, PgfItemConts* conts)
{
	return gu_map_get(state->generated_cats, conts, PgfCCat*);
}

static void
pgf_item_set_curr_symbol(PgfItem* item, GuPool* pool)
{
	GuVariantInfo i = gu_variant_open(item->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
		PgfCncFun* fun = papp->fun;
		gu_assert(item->conts->lin_idx < fun->n_lins);
		PgfSequence seq = fun->lins[item->conts->lin_idx];
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
						.d = 0, .r = item->conts->lin_idx);
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
pgf_new_item(PgfItemConts* conts, PgfProduction prod,
             GuPool* pool, PgfParsing* ps)
{
	PgfItem* item;
	if (ps == NULL || ps->free_item == NULL)
	  item = gu_new(PgfItem, pool);
	else {
	  item = ps->free_item;
	  ps->free_item = ps->free_item->next;
	}

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
	item->conts = conts;
	item->prod  = prod;
	item->curr_sym = gu_null_variant;
	item->seq_idx = 0;
	item->tok_idx = 0;
	item->alt = 0;

	conts->ref_count++;

	pgf_item_set_curr_symbol(item, pool);

#ifdef PGF_COUNTS_DEBUG
	if (ps != NULL) {
		ps->item_full_count++;
		ps->item_real_count++;
	}
#endif

	return item;
}

static PgfItem*
pgf_item_copy(PgfItem* item, GuPool* pool, PgfParsing* ps)
{
	PgfItem* copy;
	if (ps == NULL || ps->free_item == NULL)
	  copy = gu_new(PgfItem, pool);
	else {
	  copy = ps->free_item;
	  ps->free_item = ps->free_item->next;
	}
	memcpy(copy, item, sizeof(PgfItem));

#ifdef PGF_COUNTS_DEBUG
	if (ps != NULL) {
		ps->item_full_count++;
		ps->item_real_count++;
	}
#endif

	item->conts->ref_count++;

	return copy;
}

static PgfItem*
pgf_item_update_arg(PgfItem* item, size_t d, PgfCCat *new_ccat,
                    GuPool* pool, PgfParsing *ps)
{
	PgfCCat *old_ccat =
		gu_seq_index(item->args, PgfPArg, d)->ccat;

	PgfItem* new_item = pgf_item_copy(item, pool, ps);
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
pgf_item_free(PgfParseState* before, PgfParseState* after, 
              PgfItem* item)
{
	GuVariantInfo i = gu_variant_open(item->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_META:
		return; // for now we don't release meta items
	}

	PgfItemConts* conts = item->conts;
	conts->ref_count--;
	do {
		if (conts->ref_count != 0)
			break;

		conts = conts->ccat->conts;
	} while (conts != NULL);

	if (conts == NULL) {
		size_t n_items = gu_buf_length(item->conts->items);
		for (size_t i = 0; i < n_items; i++) {
			PgfItem* cont = gu_buf_get(item->conts->items, PgfItem*, i);
			if (cont == NULL)
				continue;

			pgf_item_free(before, after, cont);
		}
	}

#ifdef PGF_PARSER_DEBUG
	memset(item, 0, sizeof(*item));
#endif
	item->next = before->ps->free_item;
	before->ps->free_item = item;
#ifdef PGF_COUNTS_DEBUG
	before->ps->item_real_count--;
#endif
}

static void
pgf_parsing_add_transition(PgfParseState* before, PgfParseState* after, 
                           PgfToken tok, PgfItem* item)
{
    if (after->ts->fn->match_token(after->ts, tok, item)) {
        if (after->next == NULL) {
			after->viterbi_prob = 
				item->inside_prob+item->conts->outside_prob;
		}

		gu_buf_heap_push(after->agenda, &pgf_item_prob_order, &item);
    } else {
		pgf_item_free(before, after, item);
	}
}

static void
pgf_result_predict(PgfParsing* ps, 
                   PgfExprState* cont, PgfCCat* ccat);

static void
pgf_result_production(PgfParsing* ps, 
                      PgfAnswers* answers, PgfProduction prod);

static void
pgf_parsing_combine(PgfParseState* before, PgfParseState* after,
                    PgfItem* cont, PgfCCat* cat, int lin_idx)
{
	if (cont == NULL) {
		if (after == NULL) {
			pgf_result_predict(before->ps, NULL, cat);
		}
		return;
	}

	PgfItem* item = NULL;
	switch (gu_variant_tag(cont->curr_sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(cont->curr_sym);
		item = pgf_item_update_arg(cont, scat->d, cat, before->ps->pool, before->ps);
		break;
	}
	case PGF_SYMBOL_LIT: {
		PgfSymbolLit* slit = gu_variant_data(cont->curr_sym);
		item = pgf_item_update_arg(cont, slit->d, cat, before->ps->pool, before->ps);
		break;
	}
	default:
		gu_impossible();
	}

	pgf_item_advance(item, before->ps->pool);
	gu_buf_heap_push(before->agenda, &pgf_item_prob_order, &item);
}

static void
pgf_parsing_production(PgfParseState* state,
                       PgfItemConts* conts, PgfProduction prod)
{
	PgfItem* item =
        pgf_new_item(conts, prod, state->ps->pool, state->ps);
    gu_buf_heap_push(state->agenda, &pgf_item_prob_order, &item);
}

static PgfProduction
pgf_parsing_new_production(PgfItem* item, PgfExprProb *ep, GuPool *pool)
{
	GuVariantInfo i = gu_variant_open(item->prod);
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
		    gu_seq_is_null(gu_seq_get(pext->lins,PgfSequence,item->conts->lin_idx))) {
			PgfSequence seq = 
				pgf_extern_seq_get(item, pool);

			size_t n_lins = item->conts->ccat->cnccat->n_lins;

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
			gu_seq_set(new_pext->lins,PgfSequence,item->conts->lin_idx,seq);
		} else {
			prod = item->prod;
		}
		break;
	}
	case PGF_PRODUCTION_META: {
		PgfProductionMeta* new_pmeta = 
			gu_new_variant(PGF_PRODUCTION_META,
						   PgfProductionMeta,
						   &prod, pool);
		new_pmeta->ep   = ep;
		new_pmeta->args = item->args;
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
		pgf_parsing_new_production(item, ep, before->ps->pool);
#ifdef PGF_COUNTS_DEBUG
	before->ps->prod_full_count++;
#endif

	PgfCCat* tmp_cat = pgf_parsing_get_completed(before, item->conts);
    PgfCCat* cat = tmp_cat;
    if (cat == NULL) {
        cat = pgf_parsing_create_completed(before, item->conts,
                                           item->inside_prob);
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
                            item->conts->state ? item->conts->state->offset : 0,
                            before->offset,
                            item->conts->ccat->fid, 
                            item->conts->lin_idx, 
                            cat->fid);
    pgf_print_production(cat->fid, prod, wtr, err, tmp_pool);
    gu_pool_free(tmp_pool);
#endif

	if (tmp_cat != NULL) {
		PgfItemContss* contss =
			pgf_parsing_get_contss(before->conts_map, cat, before->ps->pool);
		size_t n_contss = gu_list_length(contss);
		for (size_t i = 0; i < n_contss; i++) {
			PgfItemConts* conts2 = gu_list_index(contss, i);
			/* If there are continuations for
			 * linearization index i, then (cat, i) has
			 * already been predicted. Add the new
			 * production immediately to the agenda,
			 * i.e. process it. */
			if (conts2) {
				pgf_parsing_production(before, conts2, prod);
			}
		}

		// The category has already been created. If it has also been
		// predicted already, then process a new item for this production.
		PgfParseState* state = after;
		while (state != NULL) {
			PgfItemContss* contss =
				pgf_parsing_get_contss(state->conts_map, cat, state->ps->pool);
			size_t n_contss = gu_list_length(contss);
			for (size_t i = 0; i < n_contss; i++) {
				PgfItemConts* conts2 = gu_list_index(contss, i);
				/* If there are continuations for
				 * linearization index i, then (cat, i) has
				 * already been predicted. Add the new
				 * production immediately to the agenda,
				 * i.e. process it. */
				if (conts2) {
					pgf_parsing_production(state, conts2, prod);
				}
			}

			state = state->next;
		}
		
		if (cat->answers != NULL) {
			pgf_result_production(before->ps, cat->answers, prod);
		}
	} else {
		size_t n_conts = gu_buf_length(item->conts->items);
		for (size_t i = 0; i < n_conts; i++) {
			PgfItem* cont = gu_buf_get(item->conts->items, PgfItem*, i);
			pgf_parsing_combine(before, after, cont, cat, item->conts->lin_idx);
		}
    }
}

#ifdef PGF_LEFTCORNER_FILTER
typedef struct {
	GuMapItor fn;
	PgfConcr* concr;
	PgfCFCat cfc;
	bool filter;
} PgfFilterFn;

static void
pgf_parsing_bu_filter_iter(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfFilterFn* clo = (PgfFilterFn*) fn;
	PgfCFCat cfc = *((PgfCFCat*) key);
		
	if (clo->filter) {
		PgfProductionIdx* set =
			gu_map_get(clo->concr->leftcorner_cat_idx, 
					   &cfc, PgfProductionIdx*);

		if (gu_map_has(set, &clo->cfc)) {
			clo->filter = false;
		}
	}
}
#endif

static bool
pgf_parsing_bu_filter(PgfParseState* before, PgfParseState* after,
                      PgfCCat* ccat, size_t lin_idx)
{
#ifdef PGF_LEFTCORNER_FILTER
	while (ccat->conts != NULL)			// back to the original PgfCCat
		ccat = ccat->conts->ccat;
	PgfCFCat cfc = {ccat, lin_idx};

	if (gu_map_has(before->ps->concr->epsilon_idx, &cfc)) {
		return false;
	}

	if (after != NULL && after->ts->fn->get_lexicon_idx(after->ts) != NULL) {
		PgfFilterFn clo = {{ pgf_parsing_bu_filter_iter }, before->ps->concr, cfc, true};
		gu_map_iter(after->ts->fn->get_lexicon_idx(after->ts), &clo.fn, NULL);
		return clo.filter;
	}
#endif
	return false;
}

static void
pgf_parsing_td_predict(PgfParseState* before, PgfParseState* after,
                       PgfItem* item, PgfCCat* ccat, size_t lin_idx)
{
	PgfItemConts* conts = 
		pgf_parsing_get_conts(before->conts_map, 
		                      ccat, lin_idx, before,
		                      before->ps->pool);
	gu_buf_push(conts->items, PgfItem*, item);
	if (gu_buf_length(conts->items) == 1) {
		/* First time we encounter this linearization
		 * of this category at the current position,
		 * so predict it. */

		conts->outside_prob =
			item->inside_prob-conts->ccat->viterbi_prob+
			item->conts->outside_prob;

		size_t n_prods = ccat->n_synprods;
		PgfProductionIdx* lexicon_idx = NULL;
		if (after != NULL) {
			lexicon_idx = after->ts->fn->get_lexicon_idx(after->ts);
			
			// we don't know the current token.
			// probably we just compute the list of completions
			if (lexicon_idx == NULL)
				n_prods = gu_seq_length(ccat->prods);
		}
		
		// Top-down prediction for syntactic rules
		for (size_t i = 0; i < n_prods; i++) {
			PgfProduction prod =
				gu_seq_get(ccat->prods, PgfProduction, i);		
			pgf_parsing_production(before, conts, prod);
		}

		// Bottom-up prediction for lexical rules
		
		if (lexicon_idx != NULL) {
			PgfCFCat cfc = {ccat, lin_idx};
			PgfProductionSeq tok_prods = 
				gu_map_get(lexicon_idx, &cfc, PgfProductionSeq);

			if (!gu_seq_is_null(tok_prods)) {
				size_t n_prods = gu_seq_length(tok_prods);
				for (size_t i = 0; i < n_prods; i++) {
					PgfProduction prod =
						gu_seq_get(tok_prods, PgfProduction, i);
					
					pgf_parsing_production(before, conts, prod);
				}
			}
		}

		// Bottom-up prediction for epsilon rules
		PgfCFCat cfc = {ccat, lin_idx};
		PgfProductionSeq eps_prods =
			gu_map_get(before->ps->concr->epsilon_idx, &cfc, PgfProductionSeq);

		if (!gu_seq_is_null(eps_prods)) {
			size_t n_prods = gu_seq_length(eps_prods);
			for (size_t i = 0; i < n_prods; i++) {
				PgfProduction prod = 
					gu_seq_get(eps_prods, PgfProduction, i);

				pgf_parsing_production(before, conts, prod);
			}
		}
	} else {
		/* If it has already been completed, combine. */

		PgfCCat* completed =
			pgf_parsing_get_completed(before, conts);
		if (completed) {
			pgf_parsing_combine(before, after, item, completed, lin_idx);
		}

		PgfParseState* state = after;
		while (state != NULL) {
			PgfCCat* completed =
				pgf_parsing_get_completed(state, conts);
			if (completed) {
				pgf_parsing_combine(state, state->next, item, completed, lin_idx);
			}

			state = state->next;
		}
	}
}

static void
pgf_parsing_meta_scan(PgfParseState* before, PgfParseState* after,
	                  PgfItem* meta_item, prob_t meta_prob)
{
	PgfToken tok = after->ts->fn->get_token(after->ts);
	
	if (!gu_string_eq(tok, gu_empty_string)) {	
		PgfItem* item = pgf_item_copy(meta_item, before->ps->pool, before->ps);
		item->inside_prob += meta_prob;

		PgfSymbol prev = item->curr_sym;
		PgfSymbolKS* sks = (PgfSymbolKS*)
			gu_alloc_variant(PGF_SYMBOL_KS,
							 sizeof(PgfSymbolKS)+sizeof(PgfSymbol),
							 gu_alignof(PgfSymbolKS),
							 &item->curr_sym, after->ps->pool);
		*((PgfSymbol*)(sks+1)) = prev;
		sks->tokens = gu_new_seq(PgfToken, 1, after->ps->pool);
		gu_seq_set(sks->tokens, PgfToken, 0, tok);

		gu_buf_heap_push(before->agenda, &pgf_item_prob_order, &item);
	}
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
	
	PgfAbsCat* abscat = (PgfAbsCat*) key;
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
		if (gu_seq_is_null(ccat->prods)) {
			// empty category
			continue;
		}

		for (size_t lin_idx = 0; lin_idx < cnccat->n_lins; lin_idx++) {
			// bottom-up filtering
			if (pgf_parsing_bu_filter(before, after, ccat, lin_idx)) {
				// the current token is unreachable from this category
				continue;
			}

			PgfItem* item = 
				pgf_item_copy(meta_item, before->ps->pool, before->ps);
			item->inside_prob +=
				ccat->viterbi_prob+meta_prob;

			size_t nargs = gu_seq_length(meta_item->args);
			item->args = gu_new_seq(PgfPArg, nargs+1, before->ps->pool);
			memcpy(gu_seq_data(item->args), gu_seq_data(meta_item->args),
			       nargs * sizeof(PgfPArg));
			gu_seq_set(item->args, PgfPArg, nargs,
			           ((PgfPArg) { .hypos = NULL, .ccat = ccat }));

			PgfSymbol prev = item->curr_sym;
			PgfSymbolCat* scat = (PgfSymbolCat*)
				gu_alloc_variant(PGF_SYMBOL_CAT,
								 sizeof(PgfSymbolCat)+sizeof(PgfSymbol),
								 gu_alignof(PgfSymbolCat),
								 &item->curr_sym, before->ps->pool);
			*((PgfSymbol*)(scat+1)) = prev;
			scat->d = nargs;
			scat->r = lin_idx;
		
			gu_buf_heap_push(before->agenda, &pgf_item_prob_order, &item);
		}
	}
}

static void
pgf_parsing_symbol(PgfParseState* before, PgfParseState* after,
                   PgfItem* item, PgfSymbol sym) {
	switch (gu_variant_tag(sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(sym);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, scat->d);
		gu_assert(!parg->hypos || !parg->hypos->len);
		
		if (gu_seq_is_null(parg->ccat->prods)) {
			// empty category
			pgf_item_free(before, after, item);
			return;
		}

		// bottom-up filtering
		if (pgf_parsing_bu_filter(before, after, parg->ccat, scat->r)) {
			// the current token is unreachable
			pgf_item_free(before, after, item);
			return;
		}

		pgf_parsing_td_predict(before, after, item, parg->ccat, scat->r);
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
				pgf_item_advance(item, after->ps->pool);
			}
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
				new_item = pgf_item_copy(item, after->ps->pool, after->ps);            
				new_item->tok_idx++;
				if (new_item->tok_idx == gu_seq_length(skp->default_form)) {
					new_item->tok_idx = 0;
					pgf_item_advance(new_item, after->ps->pool);
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
						new_item = pgf_item_copy(item, after->ps->pool, after->ps);
						new_item->tok_idx++;
						new_item->alt = i;
						if (new_item->tok_idx == gu_seq_length(toks)) {
							new_item->tok_idx = 0;
							pgf_item_advance(new_item, after->ps->pool);
						}
						pgf_parsing_add_transition(before, after, tok, new_item);
					}
				}
			} else if (alt == 0) {
				PgfToken tok =
					gu_seq_get(skp->default_form, PgfToken, idx);
				item->tok_idx++;
				if (item->tok_idx == gu_seq_length(skp->default_form)) {
					item->tok_idx = 0;
					pgf_item_advance(item, after->ps->pool);
				}
				pgf_parsing_add_transition(before, after, tok, item);
			} else {
				gu_assert(alt <= skp->n_forms);
				PgfTokens toks = skp->forms[alt - 1].form;
				PgfToken tok = gu_seq_get(toks, PgfToken, idx);
				item->tok_idx++;
				if (item->tok_idx == gu_seq_length(toks)) {
					item->tok_idx = 0;
					pgf_item_advance(item, after->ps->pool);
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
			    parg->ccat->fid >= before->ps->concr->total_cats) {
				pgf_parsing_td_predict(before, after, item, parg->ccat, slit->r);
			}
			else {
				PgfItemConts* conts = 
					pgf_parsing_get_conts(before->conts_map, 
										  parg->ccat, slit->r, before,
										  before->ps->pool);
				gu_buf_push(conts->items, PgfItem*, item);

				if (gu_buf_length(conts->items) == 1) {
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
							               &prod, before->ps->pool);
						pext->callback = callback;
						pext->ep = NULL;
						pext->lins = gu_null_seq;

						pgf_parsing_production(before, conts, prod);
					}
				} else {
					/* If it has already been completed, combine. */

					PgfCCat* completed =
							pgf_parsing_get_completed(before, conts);
					if (completed) {
						pgf_parsing_combine(before, after, item, completed, slit->r);
					}
						
					PgfParseState* state = after;
					while (state != NULL) {
						PgfCCat* completed =
							pgf_parsing_get_completed(state, conts);
						if (completed) {
							pgf_parsing_combine(state, state->next, item, completed, slit->r);
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
    pgf_print_item(item, before, wtr, err, tmp_pool);
    gu_pool_free(tmp_pool);
#endif
	
	GuVariantInfo i = gu_variant_open(item->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
		PgfCncFun* fun = papp->fun;
		PgfSequence seq = fun->lins[item->conts->lin_idx];
		if (item->seq_idx == gu_seq_length(seq)) {
			pgf_parsing_complete(before, after, item, NULL);
			pgf_item_free(before, after, item);
		} else  {
			pgf_parsing_symbol(before, after, item, item->curr_sym);
		}
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = i.data;
		switch (item->seq_idx) {
		case 0:
			if (gu_seq_is_null(pcoerce->coerce->prods)) {
				// empty category
				pgf_item_free(before, after, item);
				return;
			}

			// bottom-up filtering
			if (pgf_parsing_bu_filter(before, after, 
			                          pcoerce->coerce,
			                          item->conts->lin_idx)) {
				// the current token is unreachable
				pgf_item_free(before, after, item);
				return;
			}

			pgf_parsing_td_predict(before, after, item, 
				                   pcoerce->coerce,
				                   item->conts->lin_idx);
			break;
		case 1:
			pgf_parsing_complete(before, after, item, NULL);
			pgf_item_free(before, after, item);
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
		    !gu_seq_is_null(seq = gu_seq_get(pext->lins,PgfSequence,item->conts->lin_idx))) {
			if (item->seq_idx == gu_seq_length(seq)) {
				pgf_parsing_complete(before, after, item, NULL);
				pgf_item_free(before, after, item);
			} else  {
				PgfSymbol sym =
					gu_seq_get(seq, PgfSymbol, item->seq_idx);
				pgf_parsing_symbol(before, after, item, sym);
			}
		} else {
			PgfToken tok = (after != NULL)
			    ? after->ts->fn->get_token(after->ts)
			    : gu_empty_string;

			PgfExprProb *ep = NULL;
			bool accepted = 
				pext->callback->match(before->ps->concr, item, 
				                      tok,
				                      &ep, before->ps->out_pool);

			if (ep != NULL)
				pgf_parsing_complete(before, after, item, ep);

			if (accepted) {
				if (after != NULL) {
					PgfSymbol prev = item->curr_sym;
					PgfSymbolKS* sks = (PgfSymbolKS*)
						gu_alloc_variant(PGF_SYMBOL_KS,
										 sizeof(PgfSymbolKS)+sizeof(PgfSymbol),
										 gu_alignof(PgfSymbolKS),
										 &item->curr_sym, after->ps->pool);
					*((PgfSymbol*)(sks+1)) = prev;
					sks->tokens = gu_new_seq(PgfToken, 1, after->ps->pool);
					gu_seq_set(sks->tokens, PgfToken, 0, tok);

					item->seq_idx++;
					pgf_parsing_add_transition(before, after, tok, item);
				}
			} else {
				pgf_item_free(before, after, item);
			}
		}
		break;
	}
	case PGF_PRODUCTION_META: {
		if (item->seq_idx == pgf_item_sequence_length(item)) {
			if (before->meta_item != NULL)
				break;
			before->meta_item = item;
			
			if (after == NULL) {
				PgfExprProb *ep = gu_new(PgfExprProb, before->ps->pool);
				ep->expr = before->ps->meta_var;
				ep->prob = item->inside_prob;
				size_t n_args = gu_seq_length(item->args);
				for (size_t i = 0; i < n_args; i++) {
					PgfPArg* arg = gu_seq_index(item->args, PgfPArg, i);
					ep->prob -= arg->ccat->viterbi_prob;
				}
				pgf_parsing_complete(before, after, item, ep);
			} else {
				prob_t meta_token_prob = 
					item->conts->ccat->cnccat->abscat->meta_token_prob;
				if (meta_token_prob != INFINITY) {
					pgf_parsing_meta_scan(before, after, item, meta_token_prob);
				}

				PgfCIdMap* meta_child_probs =
					item->conts->ccat->cnccat->abscat->meta_child_probs;
				if (meta_child_probs != NULL) {
					PgfMetaPredictFn clo = { { pgf_parsing_meta_predict }, before, after, item };
					gu_map_iter(meta_child_probs, &clo.fn, NULL);
				}
			}
		} else {
			pgf_parsing_symbol(before, after, item, item->curr_sym);
		}
		break;
	}
	default:
		gu_impossible();
	}
}

static bool
pgf_parsing_proceed(PgfParseState* state)
{
	prob_t best_prob = INFINITY;
	if (gu_buf_length(state->ps->expr_queue) > 0) {
		best_prob = gu_buf_get(state->ps->expr_queue, PgfExprState*, 0)->ep.prob;
	}

	PgfParseState* before = NULL;

	prob_t delta_prob = 0;
	PgfParseState* st = state;
	while (st != NULL) {
		if (gu_buf_length(st->agenda) > 0) {
			PgfItem* item = gu_buf_get(st->agenda, PgfItem*, 0);
			prob_t item_prob = 
				item->inside_prob+item->conts->outside_prob+delta_prob;
			if (item_prob < best_prob) {
				best_prob = item_prob;
				before    = st;
			}
		}
		
		prob_t state_delta =
			(st->viterbi_prob-(st->next ? st->next->viterbi_prob : 0))*
			state->ps->beam_size;
		//prob_t lexical_prob =
		//	st->ts ? st->ts->lexical_prob : 0;
		delta_prob += state_delta; /*fmax(state_delta, lexical_prob)*/;   // the calculation of lexical_prob doesn't work properly.
		st = st->next;
	}

	if (before == NULL)
		return false;

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
	
	return true;
}

static prob_t
pgf_parsing_default_beam_size(PgfConcr* concr)
{
	GuPool* tmp_pool = gu_new_pool();
	PgfCId flag_name = gu_str_string("beam_size", tmp_pool);
	PgfLiteral lit = gu_map_get(concr->cflags, &flag_name, PgfLiteral);
	
	if (gu_variant_is_null(lit))
		return 0;

	GuVariantInfo pi = gu_variant_open(lit);
	gu_assert (pi.tag == PGF_LITERAL_FLT);	
	return ((PgfLiteralFlt*) pi.data)->val;
}

static PgfParsing*
pgf_new_parsing(PgfConcr* concr, double heuristics,
                GuPool* pool, GuPool* out_pool)
{
	PgfParsing* ps = gu_new(PgfParsing, pool);
	ps->concr = concr;
	ps->pool = pool;
	ps->out_pool = out_pool;
	ps->expr_queue = gu_new_buf(PgfExprState*, pool);
	ps->max_fid = concr->total_cats;
#ifdef PGF_COUNTS_DEBUG
	ps->item_full_count = 0;
	ps->item_real_count = 0;
	ps->cont_full_count = 0;
	ps->ccat_full_count = 0;
	ps->prod_full_count = 0;
#endif
	ps->free_item = NULL;
	ps->beam_size = heuristics;

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
	pmeta->args = gu_new_seq(PgfPArg, 0, pool);

	return ps;
}

static PgfParseState*
pgf_new_parse_state(PgfParsing* ps,
                    PgfParseState* next,
                    PgfTokenState* ts,
                    GuPool* pool)
{
	PgfParseState* state = gu_new(PgfParseState, pool);
	state->next = next;
    state->agenda = gu_new_buf(PgfItem*, pool);
    state->meta_item = NULL;
	state->generated_cats = gu_map_type_new(PgfGenCatMap, pool);
	state->conts_map = gu_map_type_new(PgfContsMap, pool);
    state->offset = next ? next->offset+1 : 0;
	state->viterbi_prob = 0;
    state->ps = ps;
    state->ts = ts;
	return state;
}

typedef struct {
	GuMapItor fn;
	PgfTokenState* ts;
} PgfLexiconFn;

static void
pgf_parser_compute_lexicon_prob(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfTokenState* ts = ((PgfLexiconFn*) fn)->ts;
	PgfProductionSeq prods = *((PgfProductionSeq*) value);
	
	if (gu_seq_is_null(prods))
		return;
	
	size_t n_prods = gu_seq_length(prods);
	for (size_t i = 0; i < n_prods; i++) {
		PgfProduction prod =
			gu_seq_get(prods, PgfProduction, i);

		GuVariantInfo pi = gu_variant_open(prod);
		switch (pi.tag) {
		case PGF_PRODUCTION_APPLY: {
			PgfProductionApply* papp = pi.data;
			if (ts->lexical_prob > papp->fun->ep->prob) {
				ts->lexical_prob = papp->fun->ep->prob;
			}
			break;
		}
		}
	}
}

#define pgf_new_token_state(ty, pool) \
	(ty*) pgf_new_token_state_(&pgf_tsfn_##ty, (PgfTokenState*) gu_new(ty, pool))

static PgfTokenState*
pgf_new_token_state_(PgfTokenFn* fn, PgfTokenState* ts)
{
	ts->fn = fn;
	ts->lexical_prob = INFINITY;	
	return ts;
}

#ifdef PGF_COUNTS_DEBUG
void pgf_parsing_print_counts(PgfParsing* ps)
{
	printf("%d\t%d\t%d\t%d\t%d\n", 
		ps->item_full_count, 
		ps->item_real_count, 
		ps->cont_full_count,
		ps->ccat_full_count,
		ps->prod_full_count);
}
#endif

typedef struct {
	PgfTokenState ts;
	PgfToken tok;
	PgfProductionIdx *lexicon_idx;
} PgfRealTokenState;

static bool
pgf_real_match_token(PgfTokenState* ts, PgfToken tok, PgfItem* item)
{
	return gu_string_eq(gu_container(ts, PgfRealTokenState, ts)->tok, tok);
}

static PgfToken
pgf_real_get_token(PgfTokenState* ts) {
	return gu_container(ts, PgfRealTokenState, ts)->tok;
}

static PgfProductionIdx*
pgf_real_get_lexicon_idx(PgfTokenState* ts) {
	return gu_container(ts, PgfRealTokenState, ts)->lexicon_idx;
}

static PgfTokenFn pgf_tsfn_PgfRealTokenState = {
	pgf_real_match_token,
	pgf_real_get_token,
	pgf_real_get_lexicon_idx
};

PgfParseState*
pgf_parser_next_state(PgfParseState* prev, PgfToken tok)
{
#ifdef PGF_COUNTS_DEBUG
	pgf_parsing_print_counts(prev->ps);
#endif

	PgfRealTokenState* ts =
		pgf_new_token_state(PgfRealTokenState, prev->ps->pool);
	ts->tok = tok;
    ts->lexicon_idx = gu_map_get(prev->ps->concr->leftcorner_tok_idx,
                                 &tok, PgfProductionIdx*);	
	if (ts->lexicon_idx != NULL) {
		PgfLexiconFn clo = { { pgf_parser_compute_lexicon_prob }, &ts->ts };
		gu_map_iter(ts->lexicon_idx, &clo.fn, NULL);
	}
	if (ts->ts.lexical_prob == INFINITY)
		ts->ts.lexical_prob = 0;

	PgfParseState* state =
	    pgf_new_parse_state(prev->ps, prev, &ts->ts, prev->ps->pool);

	while (gu_buf_length(state->agenda) == 0) {
		if (!pgf_parsing_proceed(state))
			return NULL;
	}

	return state;
}

typedef struct {
	PgfTokenState ts;
	GuEnum en;
	GuString prefix;
	PgfTokenProb* tp;
	GuPool* pool;
	PgfParseState* state;
} PgfPrefixTokenState;

static bool
pgf_prefix_match_token(PgfTokenState* ts0, PgfToken tok, PgfItem* item)
{
	PgfPrefixTokenState* ts = 
		gu_container(ts0, PgfPrefixTokenState, ts);

	if (gu_string_is_prefix(ts->prefix, tok)) {
		ts->tp = gu_new(PgfTokenProb, ts->pool);
		ts->tp->tok  = tok;
		ts->tp->prob = item->inside_prob+item->conts->outside_prob;
	}

	return false;
}

static PgfToken
pgf_prefix_get_token(PgfTokenState* ts) {
	return gu_empty_string;
}

static PgfProductionIdx*
pgf_prefix_get_lexicon_idx(PgfTokenState* ts) {
	return NULL;
}

static PgfTokenFn pgf_tsfn_PgfPrefixTokenState = {
	pgf_prefix_match_token,
	pgf_prefix_get_token,
	pgf_prefix_get_lexicon_idx
};

static void
pgf_parser_completions_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfPrefixTokenState* ts =
		gu_container(self, PgfPrefixTokenState, en);

	ts->tp   = NULL;
	ts->pool = pool;
	while (ts->tp == NULL) {
		if (!pgf_parsing_proceed(ts->state))
			break;
	}

	*((PgfTokenProb**)to) = ts->tp;
}

GuEnum*
pgf_parser_completions(PgfParseState* prev, GuString prefix)
{
#ifdef PGF_COUNTS_DEBUG
	pgf_parsing_print_counts(prev->ps);
#endif

	PgfPrefixTokenState* ts =
		pgf_new_token_state(PgfPrefixTokenState, prev->ps->pool);
	ts->en.next = pgf_parser_completions_next;
	ts->prefix  = prefix;
	ts->tp      = NULL;
	ts->state   =
	    pgf_new_parse_state(prev->ps, prev, &ts->ts, prev->ps->pool);

	return &ts->en;
}

static int
cmp_expr_state(GuOrder* self, const void* a, const void* b)
{
	PgfExprState *s1 = *((PgfExprState **) a);
	PgfExprState *s2 = *((PgfExprState **) b);

	prob_t prob1 = s1->answers->outside_prob+s1->ep.prob;
	prob_t prob2 = s2->answers->outside_prob+s2->ep.prob;

	if (prob1 < prob2)
		return -1;
	else if (prob1 > prob2)
		return 1;
	else
		return 0;
}

static GuOrder
pgf_expr_state_order = { cmp_expr_state };

static void
pgf_result_production(PgfParsing* ps, 
                      PgfAnswers* answers, PgfProduction prod)
{
	GuVariantInfo pi = gu_variant_open(prod);
	switch (pi.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = pi.data;

		PgfExprState *st = gu_new(PgfExprState, ps->pool);
		st->answers = answers;
		st->ep      = *papp->fun->ep;
		st->args    = papp->args;
		st->arg_idx = 0;

		size_t n_args = gu_seq_length(st->args);
		for (size_t k = 0; k < n_args; k++) {
			PgfPArg* parg = gu_seq_index(st->args, PgfPArg, k);
			st->ep.prob += parg->ccat->viterbi_prob;
		}

		gu_buf_heap_push(ps->expr_queue, &pgf_expr_state_order, &st);
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = pi.data;

		PgfCCat* ccat = pcoerce->coerce;
		size_t n_prods = gu_seq_length(ccat->prods);
		for (size_t i = 0; i < n_prods; i++) {
			PgfProduction prod =
				gu_seq_get(ccat->prods, PgfProduction, i);
			pgf_result_production(ps, answers, prod);
		}
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = pi.data;

		PgfExprState *st = gu_new(PgfExprState, ps->pool);
		st->answers = answers;
		st->ep      = *pext->ep;
		st->args    = gu_empty_seq();
		st->arg_idx = 0;

		gu_buf_heap_push(ps->expr_queue, &pgf_expr_state_order, &st);
		break;
	}
	case PGF_PRODUCTION_META: {
		PgfProductionMeta* pmeta = pi.data;

		PgfExprState *st = gu_new(PgfExprState, ps->pool);
		st->answers = answers;
		st->ep      = *pmeta->ep;
		st->args    = pmeta->args;
		st->arg_idx = 0;

		size_t n_args = gu_seq_length(st->args);
		for (size_t k = 0; k < n_args; k++) {
			PgfPArg* parg = gu_seq_index(st->args, PgfPArg, k);
			st->ep.prob += parg->ccat->viterbi_prob;
		}

		gu_buf_heap_push(ps->expr_queue, &pgf_expr_state_order, &st);
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_result_predict(PgfParsing* ps, 
                   PgfExprState* cont, PgfCCat* ccat)
{
	prob_t outside_prob = 0;
	if (cont != NULL) {
		cont->ep.prob -= ccat->viterbi_prob;
		outside_prob =
			cont->answers->outside_prob+cont->ep.prob;
	}

	PgfAnswers* answers = ccat->answers;
	if (answers == NULL) {
		answers = gu_new(PgfAnswers, ps->pool);
		answers->conts = gu_new_buf(PgfExprState*, ps->pool);
		answers->exprs = gu_new_buf(PgfExprProb*,  ps->pool);
		answers->outside_prob = outside_prob;

		ccat->answers = answers;
	}

	gu_buf_push(answers->conts, PgfExprState*, cont);

	if (gu_buf_length(answers->conts) == 1) {
		if (gu_seq_is_null(ccat->prods))
			return;

		// Generation
		size_t n_prods = gu_seq_length(ccat->prods);
		for (size_t i = 0; i < n_prods; i++) {
			PgfProduction prod =
				gu_seq_get(ccat->prods, PgfProduction, i);
			pgf_result_production(ps, answers, prod);
		}
	} else {
		size_t n_exprs = gu_buf_length(answers->exprs);
		for (size_t i = 0; i < n_exprs; i++) {
			PgfExprProb* ep = gu_buf_get(answers->exprs, PgfExprProb*, i);

			PgfExprState* st = gu_new(PgfExprState, ps->pool);
			st->answers = cont->answers;
			st->ep.expr =
				gu_new_variant_i(ps->out_pool, 
				                 PGF_EXPR_APP, PgfExprApp,
						         .fun = cont->ep.expr,
						         .arg = ep->expr);
			st->ep.prob = cont->ep.prob+ep->prob;
			st->args    = cont->args;
			st->arg_idx = cont->arg_idx+1;

			gu_buf_heap_push(ps->expr_queue, &pgf_expr_state_order, &st);
		}
	}
}

static bool
pgf_parse_result_is_new(PgfExprState* st)
{
	// we have found a complete abstract tree but we must check
	// whether this is not a duplication. Since the trees are
	// generated in probability order it is enough to check only
	// trees with the same probability.

	size_t i = gu_buf_length(st->answers->exprs);
	while (i-- > 0) {
		PgfExprProb* ep = 
			gu_buf_get(st->answers->exprs, PgfExprProb*, i);

		if (ep->prob < st->ep.prob)
			break;

		if (pgf_expr_eq(ep->expr, st->ep.expr))
			return false;
	}

	return true;
}

static PgfExprProb*
pgf_parse_result_next(PgfParseResult* pr)
{
	for (;;) {
		while (pgf_parsing_proceed(pr->state));

		if (gu_buf_length(pr->state->ps->expr_queue) == 0)
			break;

		PgfExprState* st;
		gu_buf_heap_pop(pr->state->ps->expr_queue, &pgf_expr_state_order, &st);

#ifdef PGF_PARSER_DEBUG
#ifdef PGF_RESULT_DEBUG
		GuPool* tmp_pool = gu_new_pool();
		GuOut* out = gu_file_out(stderr, tmp_pool);
		GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
		GuExn* err = gu_exn(NULL, type, tmp_pool);
		pgf_print_expr_state0(st, wtr, err, tmp_pool);
		gu_pool_free(tmp_pool);
#endif
#endif

		if (st->arg_idx < gu_seq_length(st->args)) {
			PgfCCat* ccat =
				gu_seq_index(st->args, PgfPArg, st->arg_idx)->ccat;

			if (ccat->fid < pr->state->ps->concr->total_cats) {
				st->ep.expr =
					gu_new_variant_i(pr->state->ps->out_pool, 
					                 PGF_EXPR_APP, PgfExprApp,
									 .fun = st->ep.expr,
									 .arg = pr->state->ps->meta_var);
				st->arg_idx++;
				gu_buf_heap_push(pr->state->ps->expr_queue, &pgf_expr_state_order, &st);
			} else {
				pgf_result_predict(pr->state->ps, st, ccat);
			}
		} else if (pgf_parse_result_is_new(st)) {
			gu_buf_push(st->answers->exprs, PgfExprProb*, &st->ep);

			size_t n_conts = gu_buf_length(st->answers->conts);
			for (size_t i = 0; i < n_conts; i++) {
				PgfExprState* st2 = gu_buf_get(st->answers->conts, PgfExprState*, i);
				
				if (st2 == NULL) {
					return &st->ep;
				}

				PgfExprState* st3 = gu_new(PgfExprState, pr->state->ps->pool);
				st3->answers = st2->answers;
				st3->ep.expr =
					gu_new_variant_i(pr->state->ps->out_pool,
					                 PGF_EXPR_APP, PgfExprApp,
							         .fun = st2->ep.expr,
							         .arg = st->ep.expr);
				st3->ep.prob = st2->ep.prob + st->ep.prob;
				st3->args = st2->args;
				st3->arg_idx = st2->arg_idx+1;

				gu_buf_heap_push(pr->state->ps->expr_queue, &pgf_expr_state_order, &st3);
			}
		}
	}

	return NULL;
}

static void
pgf_parse_result_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfParseResult* pr = gu_container(self, PgfParseResult, en);
	*(PgfExprProb**)to = pgf_parse_result_next(pr);
}

PgfExprEnum*
pgf_parse_result(PgfParseState* state)
{
#ifdef PGF_COUNTS_DEBUG
	pgf_parsing_print_counts(state->ps);
#endif

	PgfExprEnum* en =
           &gu_new_i(state->ps->pool, PgfParseResult,
                     .state = state,
			         .en.next = pgf_parse_result_enum_next)->en;

	return en;
}

void
pgf_parse_print_chunks(PgfParseState* state)
{
/*	if (state->ps->completed == NULL) {
		while (state->ps->completed == NULL) {
			if (!pgf_parsing_proceed(state))
				break;
		}
		if (state->ps->completed == NULL)
			return;
	}
		
	GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stdout, tmp_pool);
    GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);

	PgfCCat* completed = state->ps->completed;
	if (gu_seq_length(completed->prods) == 0)
		return;

	size_t n_args  = 0;
	size_t arg_idx = 0;
	PgfCCat* ccat = NULL;
	PgfProductionMeta* pmeta = NULL;

	PgfProduction prod = gu_seq_get(completed->prods, PgfProduction, 0);
	GuVariantInfo pi = gu_variant_open(prod);
	switch (pi.tag) {
	case PGF_PRODUCTION_APPLY:
		n_args  = 1;
		arg_idx = 0;
		ccat = completed;
		break;
	case PGF_PRODUCTION_META:
		pmeta = pi.data;
		n_args  = gu_seq_length(pmeta->args);
		arg_idx = 0;
		ccat    = gu_seq_index(pmeta->args, PgfPArg, arg_idx)->ccat;
		break;
	}

	PgfParseState* next = NULL;
	while (state != NULL) {
		PgfParseState* tmp = state->next;
		state->next = next;
		next  = state;
		state = tmp;
	}

	int offset = 0;

	state = next;
	next  = NULL;
	while (state != NULL) {
		if (state->ts != NULL)
		{
			if (ccat != NULL &&
			    offset == ((ccat->conts->state != NULL) ? ccat->conts->state->offset : 0)) {
				PgfCCat *ccat2 = ccat;
				while (ccat2->conts != NULL) {
					ccat2 = ccat2->conts->ccat;
				}

				gu_putc('(', wtr, err);
				gu_string_write(ccat2->cnccat->abscat->name, wtr, err);
				gu_putc(' ', wtr, err);
			}

			gu_string_write(state->ts->tok, wtr, err);
			offset++;
			
			if (ccat != NULL &&
			    ccat ==
				   gu_map_get(state->generated_cats, ccat->conts, PgfCCat*)) {
				gu_putc(')', wtr, err);
				
				arg_idx++;
				ccat =
					(arg_idx >= n_args) ?
						NULL :
						gu_seq_index(pmeta->args, PgfPArg, arg_idx)->ccat;
			}
			
			gu_putc(' ', wtr, err);
		}

		PgfParseState* tmp = state->next;
		state->next = next;
		next  = state;
		state = tmp;
	}
	gu_putc('\n', wtr, err);

	gu_pool_free(tmp_pool);*/
}

// TODO: s/CId/Cat, add the cid to Cat, make Cat the key to CncCat
PgfParseState*
pgf_parser_init_state(PgfConcr* concr, PgfCId cat, size_t lin_idx, 
                      double heuristics,
                      GuPool* pool, GuPool* out_pool)
{
	PgfCncCat* cnccat =
		gu_map_get(concr->cnccats, &cat, PgfCncCat*);
	if (!cnccat)
		return NULL;

	gu_assert(lin_idx < cnccat->n_lins);

	if (heuristics < 0) {
		heuristics = pgf_parsing_default_beam_size(concr);
	}

	PgfParsing* ps =
		pgf_new_parsing(concr, heuristics, pool, out_pool);
	PgfParseState* state =
		pgf_new_parse_state(ps, NULL, NULL, pool);

	size_t n_ccats = gu_list_length(cnccat->cats);
	for (size_t i = 0; i < n_ccats; i++) {
		PgfCCat* ccat = gu_list_index(cnccat->cats, i);
		if (ccat != NULL) {
            if (gu_seq_is_null(ccat->prods)) {
                // Empty category
                continue;
            }
            
			PgfItemConts* conts = gu_new(PgfItemConts, pool);
			conts->ccat      = ccat;
			conts->lin_idx   = lin_idx;
			conts->state     = NULL;
			conts->items     = gu_new_buf(PgfItem*, pool);
			conts->outside_prob = 0;
			conts->ref_count = 0;
			gu_buf_push(conts->items, PgfItem*, NULL);

#ifdef PGF_COUNTS_DEBUG
			ps->cont_full_count++;
#endif

            size_t n_prods = gu_seq_length(ccat->prods);
            for (size_t i = 0; i < n_prods; i++) {
                PgfProduction prod =
                    gu_seq_get(ccat->prods, PgfProduction, i);
                PgfItem* item = 
                    pgf_new_item(conts, prod, pool, ps);
                gu_buf_heap_push(state->agenda, &pgf_item_prob_order, &item);
            }

         	PgfItem *item =
				pgf_new_item(conts, ps->meta_prod, pool, ps);
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

typedef struct {
	GuMapItor fn;
	PgfTokens tokens;
	PgfMorphoCallback* callback;
} PgfMorphoFn;

static void
pgf_morpho_iter(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfMorphoFn* clo = (PgfMorphoFn*) fn;
	PgfCFCat cfc = *((PgfCFCat*) key);
	PgfProductionSeq prods = *((PgfProductionSeq*) value);

	if (gu_seq_is_null(prods))
		return;

	GuString analysis = cfc.ccat->cnccat->labels[cfc.lin_idx];

	size_t n_prods = gu_seq_length(prods);
	for (size_t i = 0; i < n_prods; i++) {
		PgfProduction prod =
			gu_seq_get(prods, PgfProduction, i);

		GuVariantInfo i = gu_variant_open(prod);
		switch (i.tag) {
		case PGF_PRODUCTION_APPLY: {
			PgfProductionApply* papp = i.data;

			// match the tokens with the production
			size_t pos = 0;
			PgfSequence seq = papp->fun->lins[cfc.lin_idx];
			size_t len = gu_seq_length(seq);
			for (size_t i = 0; i < len; i++) {
				PgfSymbol sym = gu_seq_get(seq, PgfSymbol, i);

				GuVariantInfo i = gu_variant_open(sym);
				switch (i.tag) {
				case PGF_SYMBOL_KS: {
					PgfSymbolKS* symks = i.data;
					size_t len = gu_seq_length(symks->tokens);
					for (size_t i = 0; i < len; i++) {
						if (pos >= gu_seq_length(clo->tokens))
							goto cont;

						PgfToken tok1 = gu_seq_get(symks->tokens, PgfToken, i);
						PgfToken tok2 = gu_seq_get(clo->tokens, PgfToken, pos++);
						
						if (!gu_string_eq(tok1, tok2))
							goto cont;
					}
				}
				default:
					continue;
				}
			}
			
			if (pos != gu_seq_length(clo->tokens))
				goto cont;

			PgfCId lemma = papp->fun->absfun->name;
			prob_t prob = papp->fun->absfun->ep.prob;
			clo->callback->callback(clo->callback, clo->tokens,
			                        lemma, analysis, prob, err);
		}
		}
	cont:;
	}
}

void
pgf_lookup_morpho(PgfConcr *concr, PgfLexer *lexer,
                  PgfMorphoCallback* callback, GuExn* err)
{
	GuPool* tmp_pool = gu_local_pool();
	
	GuBuf* tokens = gu_new_buf(PgfToken, tmp_pool);
	GuExn* lex_err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	PgfToken tok = pgf_lexer_read_token(lexer, lex_err);
	if (gu_exn_is_raised(lex_err)) {
		gu_raise(err, PgfExn);
		gu_pool_free(tmp_pool);
		return;
	}

	PgfProductionIdx* lexicon_idx =
		gu_map_get(concr->leftcorner_tok_idx, &tok, PgfProductionIdx*);
	if (lexicon_idx == NULL) {
		gu_pool_free(tmp_pool);
		return;
	}

	do {
		gu_buf_push(tokens, PgfToken, tok);
		tok = pgf_lexer_read_token(lexer, lex_err);
	} while (!gu_exn_is_raised(lex_err));

	PgfMorphoFn clo = { { pgf_morpho_iter }, gu_buf_seq(tokens), callback };
	gu_map_iter(lexicon_idx, &clo.fn, err);
	
	gu_pool_free(tmp_pool);
}

static void
pgf_parser_leftcorner_add_token(PgfConcr* concr,
                                PgfTokens tokens, PgfItem* item, 
                                GuPool *pool)
{
	PgfToken tok = gu_seq_get(tokens, PgfToken, 0);

	PgfProductionIdx* set =
		gu_map_get(concr->leftcorner_tok_idx, &tok, PgfProductionIdx*);
	if (set == NULL) {
		set = gu_map_type_new(PgfProductionIdx, pool);
		gu_map_put(concr->leftcorner_tok_idx, &tok, PgfProductionIdx*, set);
	}

	PgfCFCat cfc = {item->conts->ccat, item->conts->lin_idx};
	while (cfc.ccat->conts != NULL)
		cfc.ccat = cfc.ccat->conts->ccat;
	PgfProductionSeq prods = gu_map_get(set, &cfc, PgfProductionSeq);

	if (gu_seq_length(item->args) == 0) {
		if (gu_seq_is_null(prods)) {
			prods = gu_buf_seq(gu_new_buf(PgfProduction, pool));
		}

		PgfProduction prod =
			pgf_parsing_new_production(item, NULL, pool);
		GuBuf* prodbuf = gu_seq_buf(prods);
		gu_buf_push(prodbuf, PgfProduction, prod);
	}

	gu_map_put(set, &cfc, PgfProductionSeq, prods);
}

static void
pgf_parser_leftcorner_add_epsilon(PgfConcr* concr, 
                                  PgfProduction prod, PgfItem* item, 
                                  GuPool *pool)
{
	PgfCFCat cfc = {item->conts->ccat, item->conts->lin_idx};
	while (cfc.ccat->conts != NULL)
		cfc.ccat = cfc.ccat->conts->ccat;
	PgfProductionSeq prods =
		gu_map_get(concr->epsilon_idx, &cfc, PgfProductionSeq);

	if (gu_seq_length(item->args) == 0) {
		if (gu_seq_is_null(prods)) {
			prods = gu_buf_seq(gu_new_buf(PgfProduction, pool));
		}

		gu_buf_push(gu_seq_buf(prods), PgfProduction, prod);
	}

	gu_map_put(concr->epsilon_idx, &cfc, PgfProductionSeq, prods);
}

typedef struct {
	GuMapItor fn;
	PgfConcr* concr;
	PgfContsMap* conts_map;
	PgfGenCatMap* generated_cats;
	int max_fid;
	GuPool* pool;
	GuPool* tmp_pool;
} PgfLeftcornerFn;

static void
pgf_parser_leftcorner_item(PgfLeftcornerFn* clo, PgfItem* item)
{
#if defined(PGF_PARSER_DEBUG) && defined(PGF_LEFTCORNER_DEBUG)
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    pgf_print_item(item, NULL, wtr, err, tmp_pool);
    gu_pool_free(tmp_pool);
#endif

	GuVariantInfo i = gu_variant_open(item->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;

		PgfSequence seq = papp->fun->lins[item->conts->lin_idx];
		if (item->seq_idx < gu_seq_length(seq)) {
			GuVariantInfo i = gu_variant_open(item->curr_sym);
			switch (i.tag) {
			case PGF_SYMBOL_CAT: {
				PgfSymbolCat* scat = i.data;

				PgfPArg* parg =
					gu_seq_index(item->args, PgfPArg, scat->d);

				if (gu_seq_is_null(parg->ccat->prods))
					return;

				// Place the item in the continuation map
				PgfItemConts* conts_ =
					pgf_parsing_get_conts(clo->conts_map,
										  parg->ccat, scat->r, 0,
										  clo->tmp_pool);
				gu_buf_push(conts_->items, PgfItem*, item);
				if (gu_buf_length(conts_->items) == 1) {
					conts_->outside_prob = 0;

					size_t n_prods = gu_seq_length(parg->ccat->prods);
					for (size_t i = 0; i < n_prods; i++) {
						PgfProduction prod =
							gu_seq_get(parg->ccat->prods, PgfProduction, i);

						PgfItem* item =
							pgf_new_item(conts_, prod, clo->tmp_pool, NULL);

						pgf_parser_leftcorner_item(clo, item);
					}
				} else {
					// If the current category has epsilon rules
					// then we must do the same for a new item where 
					// the dot is moved with one position.
					PgfCCat* eps_ccat =
						gu_map_get(clo->generated_cats, conts_, PgfCCat*);

					if (eps_ccat != NULL) {
						PgfItem* new_item =
							pgf_item_update_arg(item, scat->d, eps_ccat, clo->tmp_pool, NULL);
						pgf_item_advance(new_item, clo->tmp_pool);
						pgf_parser_leftcorner_item(clo, new_item);
					}
				}
				break;
			}
			case PGF_SYMBOL_KS: {
				PgfSymbolKS* sks = i.data;
				pgf_parser_leftcorner_add_token(clo->concr, 
				                                sks->tokens,
				                                item, clo->pool);
				break;
			}
			case PGF_SYMBOL_KP: {
				PgfSymbolKP* skp = i.data;
				pgf_parser_leftcorner_add_token(clo->concr, 
				                                skp->default_form,
										        item, clo->pool);
				for (size_t i = 0; i < skp->n_forms; i++) {
					pgf_parser_leftcorner_add_token(clo->concr, 
					                                skp->forms[i].form,
											        item, clo->pool);
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
			PgfCCat* tmp_ccat =
				gu_map_get(clo->generated_cats, item->conts, PgfCCat*);

			PgfCCat* eps_ccat = tmp_ccat;
			if (eps_ccat == NULL) {
				eps_ccat = gu_new(PgfCCat, clo->tmp_pool);
				eps_ccat->cnccat = item->conts->ccat->cnccat;
				eps_ccat->viterbi_prob = 0;
				eps_ccat->fid = clo->max_fid++;
				eps_ccat->prods =
					gu_buf_seq(gu_new_buf(PgfProduction, clo->tmp_pool));
				eps_ccat->conts = item->conts;
				eps_ccat->answers = NULL;
				eps_ccat->n_synprods = 0;

				gu_map_put(clo->generated_cats, 
				           item->conts, PgfCCat*, eps_ccat);				           
			}

			PgfProduction prod =
				pgf_parsing_new_production(item, NULL, clo->pool);
			GuBuf* prodbuf = gu_seq_buf(eps_ccat->prods);
			gu_buf_push(prodbuf, PgfProduction, prod);

			pgf_parser_leftcorner_add_epsilon(clo->concr,
			                                  prod, item,
                                              clo->pool);
                                              
#if defined(PGF_PARSER_DEBUG) && defined(PGF_LEFTCORNER_DEBUG)
			GuPool* tmp_pool = gu_new_pool();
			GuOut* out = gu_file_out(stderr, tmp_pool);
			GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
			GuExn* err = gu_exn(NULL, type, tmp_pool);
			if (tmp_ccat == NULL)
				gu_printf(wtr, err, "[0-0; C%d; %d; C%d]\n",
									item->conts->ccat->fid, 
									item->conts->lin_idx, 
									eps_ccat->fid);
			pgf_print_production(eps_ccat->fid, prod, wtr, err, clo->tmp_pool);
			gu_pool_free(tmp_pool);
#endif

			if (tmp_ccat == NULL) {
				size_t n_items = gu_buf_length(item->conts->items);
				for (size_t i = 0; i < n_items; i++) {
					PgfItem* cont = 
						gu_buf_get(item->conts->items, PgfItem*, i);
					if (cont == NULL)
						continue;
					
					gu_assert(gu_variant_tag(cont->curr_sym) == PGF_SYMBOL_CAT);
					PgfSymbolCat* scat = gu_variant_data(cont->curr_sym);

					PgfItem* new_item =
						pgf_item_update_arg(cont, scat->d, eps_ccat, clo->tmp_pool, NULL);
					pgf_item_advance(new_item, clo->tmp_pool);
					pgf_parser_leftcorner_item(clo, new_item);
				}
			}
		}
	}
	break;
	case PGF_PRODUCTION_COERCE: {
		if (item->seq_idx < 1) {
			PgfPArg* parg =
				gu_seq_index(item->args, PgfPArg, 0);

			if (gu_seq_is_null(parg->ccat->prods))
				return;

			PgfItemConts* conts_ =
				pgf_parsing_get_conts(clo->conts_map,
									  parg->ccat, item->conts->lin_idx, 0,
									  clo->tmp_pool);
			gu_buf_push(conts_->items, PgfItem*, item);
			if (gu_buf_length(conts_->items) == 1) {
				conts_->outside_prob = 0;

				size_t n_prods = gu_seq_length(parg->ccat->prods);
				for (size_t i = 0; i < n_prods; i++) {
					PgfProduction prod =
						gu_seq_get(parg->ccat->prods, PgfProduction, i);

					PgfItem* new_item =
						pgf_new_item(conts_, prod, clo->tmp_pool, NULL);

					pgf_parser_leftcorner_item(clo, new_item);
				}
			} else {
				// If the argument category has epsilon rules
				// then the result category has epsilon rules too.
				PgfCCat* eps_ccat =
					gu_map_get(clo->generated_cats, conts_, PgfCCat*);

				if (eps_ccat != NULL) {
					PgfItem* new_item =
						pgf_item_update_arg(item, 0, eps_ccat, clo->tmp_pool, NULL);
					pgf_item_advance(new_item, clo->tmp_pool);
					pgf_parser_leftcorner_item(clo, new_item);
				}
			}
		} else {
			PgfCCat* tmp_ccat =
				gu_map_get(clo->generated_cats, item->conts, PgfCCat*);

			PgfCCat* eps_res_ccat = tmp_ccat;
			if (eps_res_ccat == NULL) {
				eps_res_ccat = gu_new(PgfCCat, clo->tmp_pool);
				eps_res_ccat->cnccat = item->conts->ccat->cnccat;
				eps_res_ccat->viterbi_prob = 0;
				eps_res_ccat->fid = clo->max_fid++;
				eps_res_ccat->prods =
					gu_buf_seq(gu_new_buf(PgfProduction, clo->tmp_pool));
				eps_res_ccat->conts = item->conts;
				eps_res_ccat->answers = NULL;
				eps_res_ccat->n_synprods = 0;

				gu_map_put(clo->generated_cats, 
						   item->conts, PgfCCat*, eps_res_ccat);
			}

			PgfProduction prod;
			PgfProductionCoerce* new_pcoerce =
				gu_new_variant(PGF_PRODUCTION_COERCE,
							   PgfProductionCoerce,
							   &prod, clo->pool);
			new_pcoerce->coerce = gu_seq_index(item->args, PgfPArg, 0)->ccat;
			GuBuf* prodbuf = gu_seq_buf(eps_res_ccat->prods);
			gu_buf_push(prodbuf, PgfProduction, prod);

			pgf_parser_leftcorner_add_epsilon(clo->concr,
											  prod, item,
											  clo->pool);

#if defined(PGF_PARSER_DEBUG) && defined(PGF_LEFTCORNER_DEBUG)
			GuPool* tmp_pool = gu_new_pool();
			GuOut* out = gu_file_out(stderr, tmp_pool);
			GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
			GuExn* err = gu_exn(NULL, type, tmp_pool);
			if (tmp_ccat == NULL)
				gu_printf(wtr, err, "[0-0; C%d; %d; C%d]\n",
									item->conts->ccat->fid, 
									item->conts->lin_idx, 
									eps_res_ccat->fid);
			pgf_print_production(eps_res_ccat->fid, prod, wtr, err, tmp_pool);
			gu_pool_free(tmp_pool);
#endif

			if (tmp_ccat == NULL) {
				size_t n_items = gu_buf_length(item->conts->items);
				for (size_t i = 0; i < n_items; i++) {
					PgfItem* cont = 
						gu_buf_get(item->conts->items, PgfItem*, i);
					if (cont == NULL)
						continue;

					gu_assert(gu_variant_tag(cont->curr_sym) == PGF_SYMBOL_CAT);
					PgfSymbolCat* scat = gu_variant_data(cont->curr_sym);

					PgfItem* new_item =
						pgf_item_update_arg(cont, scat->d, eps_res_ccat, clo->tmp_pool, NULL);
					pgf_item_advance(new_item, clo->tmp_pool);
					pgf_parser_leftcorner_item(clo, new_item);
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
pgf_parser_leftcorner_iter_cats(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	(void) (key && err);

	PgfLeftcornerFn* clo = (PgfLeftcornerFn*) fn;
    PgfCCat* ccat = *((PgfCCat**) value);

	if (gu_seq_is_null(ccat->prods))
		return;

	for (size_t lin_idx = 0; lin_idx < ccat->cnccat->n_lins; lin_idx++) {
		PgfItemConts* conts =
			pgf_parsing_get_conts(clo->conts_map, ccat, lin_idx, 0, clo->tmp_pool);
				
		gu_buf_push(conts->items, PgfItem*, NULL);
		if (gu_buf_length(conts->items) == 1) {
			conts->outside_prob = 0;

			size_t n_prods = gu_seq_length(ccat->prods);
			for (size_t i = 0; i < n_prods; i++) {
				PgfProduction prod = gu_seq_get(ccat->prods, PgfProduction, i);

				PgfItem* item =
					pgf_new_item(conts, prod, clo->tmp_pool, NULL);

				pgf_parser_leftcorner_item(clo, item);
			}
		}
	}
}

#ifdef PGF_LEFTCORNER_FILTER
static void
pgf_parser_leftcorner_closure(PgfProductionIdx* set, PgfItemBuf* items, 
                              PgfContsMap* conts_map, GuPool* pool)
{
	size_t n_items = gu_buf_length(items);
	for (size_t i = 0; i < n_items; i++) {
		PgfItem* item = gu_buf_get(items, PgfItem*, i);
		if (item == NULL)
			continue;

		PgfCFCat cfc = {item->conts->ccat, item->conts->lin_idx};
		while (cfc.ccat->conts != NULL)
			cfc.ccat = cfc.ccat->conts->ccat;

		if (!gu_map_has(set, &cfc)) {
			gu_map_put(set, &cfc, PgfCCat*, NULL);

			PgfItemConts* conts =
				pgf_parsing_get_conts(conts_map, 
				                      item->conts->ccat, 
				                      item->conts->lin_idx,
				                      0,
				                      pool);
			if (conts != NULL)
				pgf_parser_leftcorner_closure(set, conts->items, conts_map, pool);
		}
	}
}

static void
pgf_parser_leftcorner_iter_conts(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfConcr* concr = ((PgfLeftcornerFn*) fn)->concr;
	PgfContsMap* conts_map = ((PgfLeftcornerFn*) fn)->conts_map;
	GuPool* pool = ((PgfLeftcornerFn*) fn)->pool;
	PgfCCat* ccat = (PgfCCat*) key;
	PgfItemContss* contss = *((PgfItemContss**) value);

	if (ccat->conts != NULL)
		return;

	size_t n_lins = gu_list_length(contss);
	for (size_t lin_idx = 0; lin_idx < n_lins; lin_idx++) {
		PgfItemConts* conts = gu_list_index(contss, lin_idx);

		if (conts != NULL) {
			PgfCFCat cfc = {ccat, lin_idx};

			PgfProductionIdx* set = 
				gu_map_get(concr->leftcorner_cat_idx, 
		                   &cfc, PgfProductionIdx*);
			if (set == NULL) {
				set = gu_map_type_new(PgfProductionIdx,pool);
				gu_map_put(set, &cfc, PgfCCat*, NULL);
				gu_map_put(concr->leftcorner_cat_idx,
						   &cfc, PgfProductionIdx*, set);
			}

			pgf_parser_leftcorner_closure(set, conts->items, conts_map, pool);
		}
	}
}
#endif

void
pgf_parser_index(PgfConcr* concr, GuPool *pool)
{
	GuPool *tmp_pool = gu_new_pool();
	PgfContsMap* conts_map = gu_map_type_new(PgfContsMap, tmp_pool);
	PgfGenCatMap* generated_cats = gu_map_type_new(PgfGenCatMap, tmp_pool);

	PgfLeftcornerFn clo1 = { { pgf_parser_leftcorner_iter_cats  }, 
	                         concr, conts_map, generated_cats,
	                         concr->total_cats,
	                         pool, tmp_pool };
	gu_map_iter(concr->ccats, &clo1.fn, NULL);

#ifdef PGF_LEFTCORNER_FILTER
	PgfLeftcornerFn clo2 = { { pgf_parser_leftcorner_iter_conts }, 
	                         concr, conts_map, generated_cats,
	                         concr->total_cats,
	                         pool, tmp_pool };
	gu_map_iter(conts_map, &clo2.fn, NULL);
#endif

	gu_pool_free(tmp_pool);
}

prob_t
pgf_ccat_set_viterbi_prob(PgfCCat* ccat) {
	if (ccat->fid < 0)
		return 0;
	
	if (ccat->viterbi_prob == 0) {       // uninitialized
		ccat->viterbi_prob = INFINITY;   // set to infinity to avoid loops

		if (gu_seq_is_null(ccat->prods))
			return INFINITY;

		prob_t viterbi_prob = INFINITY;
		
		size_t n_prods = gu_seq_length(ccat->prods);
		for (size_t i = 0; i < n_prods; i++) {
			PgfProduction prod =
				gu_seq_get(ccat->prods, PgfProduction, i);		
			
			prob_t prob = 0;

			GuVariantInfo inf = gu_variant_open(prod);
			switch (inf.tag) {
			case PGF_PRODUCTION_APPLY: {
				PgfProductionApply* papp = inf.data;
				prob = papp->fun->ep->prob;
				
				size_t n_args = gu_seq_length(papp->args);
				for (size_t j = 0; j < n_args; j++) {
					PgfPArg* arg = gu_seq_index(papp->args, PgfPArg, j);
					prob += pgf_ccat_set_viterbi_prob(arg->ccat);
				}
				break;
			}
			case PGF_PRODUCTION_COERCE: {
				PgfProductionCoerce* pcoerce = inf.data;
				prob = pgf_ccat_set_viterbi_prob(pcoerce->coerce);
				break;
			}
			default:
				gu_impossible();
				return 0;
			}
			
			if (viterbi_prob > prob)
				viterbi_prob = prob;
		}
		
		ccat->viterbi_prob = viterbi_prob;
	}

	return ccat->viterbi_prob;
}

static bool
pgf_cfcat_eq_fn(GuEquality* self, const void* a, const void* b)
{
	PgfCFCat *x = (PgfCFCat *) a;
	PgfCFCat *y = (PgfCFCat *) b;
	
	return (x->ccat->fid == y->ccat->fid && x->lin_idx == y->lin_idx);
}

static GuHash
pgf_cfcat_hash_fn(GuHasher* self, const void* a)
{
	PgfCFCat *x = (PgfCFCat *) a;
	return ((x->ccat->fid << 16) ^ x->lin_idx);
}

GuHasher pgf_cfcat_hasher = {
	{ pgf_cfcat_eq_fn },
	pgf_cfcat_hash_fn
};
