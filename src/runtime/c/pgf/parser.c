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
	PgfCCat* completed;
	PgfItem* target;
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

typedef struct {
	PgfToken tok;
    PgfProductionIdx* lexicon_idx;
    prob_t lexical_prob;
} PgfTokenState;

struct PgfParseState {
	GuPool* pool;
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
	            item->conts->outside_prob,
	            item->inside_prob+item->conts->outside_prob);
}
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
	PgfCCat* cat = gu_new(PgfCCat, state->pool);
	cat->cnccat = conts->ccat->cnccat;
	cat->viterbi_prob = viterbi_prob;
	cat->fid = state->ps->max_fid++;
	cat->conts = conts;
	cat->prods = gu_buf_seq(gu_new_buf(PgfProduction, state->pool));
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
    if (gu_string_eq(tok, after->ts->tok)) {
        if (after->next == NULL) {
			after->ps->target = item;
			after->viterbi_prob = 
				item->inside_prob+item->conts->outside_prob;
		}

		gu_buf_heap_push(after->agenda, &pgf_item_prob_order, &item);
    } else {
		pgf_item_free(before, after, item);
	}
}

static void
pgf_parsing_combine(PgfParseState* before, PgfParseState* after,
                    PgfItem* cont, PgfCCat* cat, int lin_idx)
{
	if (cont == NULL) {
		if (after == NULL)
			before->ps->completed = cat;
		return;
	}

	PgfItem* item = NULL;
	switch (gu_variant_tag(cont->curr_sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(cont->curr_sym);
		item = pgf_item_update_arg(cont, scat->d, cat, before->pool, before->ps);
		break;
	}
	case PGF_SYMBOL_LIT: {
		PgfSymbolLit* slit = gu_variant_data(cont->curr_sym);
		item = pgf_item_update_arg(cont, slit->d, cat, before->pool, before->ps);
		break;
	}
	default:
		gu_impossible();
	}

	pgf_item_advance(item, before->pool);
	gu_buf_heap_push(before->agenda, &pgf_item_prob_order, &item);
}

static void
pgf_parsing_production(PgfParseState* state,
                       PgfItemConts* conts, PgfProduction prod)
{
	PgfItem* item =
        pgf_new_item(conts, prod, state->pool, state->ps);
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
		pgf_parsing_new_production(item, ep, before->pool);
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
			pgf_parsing_get_contss(before->conts_map, cat, before->pool);
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
				pgf_parsing_get_contss(state->conts_map, cat, state->pool);
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
	} else {
		size_t n_conts = gu_buf_length(item->conts->items);
		for (size_t i = 0; i < n_conts; i++) {
			PgfItem* cont = gu_buf_get(item->conts->items, PgfItem*, i);
			pgf_parsing_combine(before, after, cont, cat, item->conts->lin_idx);
		}
    }
}

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

static bool
pgf_parsing_bu_filter(PgfParseState* before, PgfParseState* after,
                      PgfCCat* ccat, size_t lin_idx)
{
	while (ccat->conts != NULL)			// back to the original PgfCCat
		ccat = ccat->conts->ccat;
	PgfCFCat cfc = {ccat, lin_idx};

	if (gu_map_has(before->ps->concr->epsilon_idx, &cfc)) {
		return false;
	}

	if (after != NULL && after->ts->lexicon_idx != NULL) {
		PgfFilterFn clo = {{ pgf_parsing_bu_filter_iter }, before->ps->concr, cfc, true};
		gu_map_iter(after->ts->lexicon_idx, &clo.fn, NULL);
		return clo.filter;
	}

	return false;
}

static void
pgf_parsing_td_predict(PgfParseState* before, PgfParseState* after,
                       PgfItem* item, PgfCCat* ccat, size_t lin_idx)
{
	PgfItemConts* conts = 
		pgf_parsing_get_conts(before->conts_map, 
		                      ccat, lin_idx, before,
		                      before->pool);
	gu_buf_push(conts->items, PgfItem*, item);
	if (gu_buf_length(conts->items) == 1) {
		/* First time we encounter this linearization
		 * of this category at the current position,
		 * so predict it. */

		conts->outside_prob =
			item->inside_prob-conts->ccat->viterbi_prob+
			item->conts->outside_prob;

		// Top-down prediction for syntactic rules
		PgfProductionSeq prods = ccat->prods;
		for (size_t i = 0; i < ccat->n_synprods; i++) {
			PgfProduction prod =
				gu_seq_get(prods, PgfProduction, i);		
			pgf_parsing_production(before, conts, prod);
		}

		// Bottom-up prediction for lexical rules
		if (after != NULL && after->ts->lexicon_idx != NULL) {
			PgfCFCat cfc = {ccat, lin_idx};
			PgfProductionSeq tok_prods = 
				gu_map_get(after->ts->lexicon_idx, &cfc, PgfProductionSeq);
			
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
	PgfItem* item = pgf_item_copy(meta_item, before->pool, before->ps);
	item->inside_prob += meta_prob;

	PgfSymbol prev = item->curr_sym;
	PgfSymbolKS* sks = (PgfSymbolKS*)
		gu_alloc_variant(PGF_SYMBOL_KS,
						 sizeof(PgfSymbolKS)+sizeof(PgfSymbol),
						 gu_alignof(PgfSymbolKS),
						 &item->curr_sym, after->pool);
	*((PgfSymbol*)(sks+1)) = prev;
	sks->tokens = gu_new_seq(PgfToken, 1, after->pool);
	gu_seq_set(sks->tokens, PgfToken, 0, after->ts->tok);

	gu_buf_heap_push(before->agenda, &pgf_item_prob_order, &item);
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
				pgf_item_copy(meta_item, before->pool, before->ps);
			item->inside_prob +=
				ccat->viterbi_prob+meta_prob;

			size_t nargs = gu_seq_length(meta_item->args);
			item->args = gu_new_seq(PgfPArg, nargs+1, before->pool);
			memcpy(gu_seq_data(item->args), gu_seq_data(meta_item->args),
			       nargs * sizeof(PgfPArg));
			gu_seq_set(item->args, PgfPArg, nargs,
			           ((PgfPArg) { .hypos = NULL, .ccat = ccat }));

			PgfSymbol prev = item->curr_sym;
			PgfSymbolCat* scat = (PgfSymbolCat*)
				gu_alloc_variant(PGF_SYMBOL_CAT,
								 sizeof(PgfSymbolCat)+sizeof(PgfSymbol),
								 gu_alignof(PgfSymbolCat),
								 &item->curr_sym, before->pool);
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
				pgf_item_advance(item, after->pool);
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
				new_item = pgf_item_copy(item, after->pool, after->ps);            
				new_item->tok_idx++;
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
						new_item = pgf_item_copy(item, after->pool, after->ps);
						new_item->tok_idx++;
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
			    parg->ccat->fid >= before->ps->concr->total_cats) {
				pgf_parsing_td_predict(before, after, item, parg->ccat, slit->r);
			}
			else {
				PgfItemConts* conts = 
					pgf_parsing_get_conts(before->conts_map, 
										  parg->ccat, slit->r, before,
										  before->pool);
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
							               &prod, before->pool);
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
			PgfToken tok = (after != NULL) ? after->ts->tok
			                               : gu_empty_string;

			PgfExprProb *ep = NULL;
			bool accepted = 
				pext->callback->match(before->ps->concr, item, 
				                      tok,
				                      &ep, before->pool);

			if (ep != NULL)
				pgf_parsing_complete(before, after, item, ep);

			if (accepted) {
				if (after != NULL) {
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
				PgfExprProb *ep = gu_new(PgfExprProb, before->pool);
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
pgf_parsing_proceed(PgfParseState* state) {
	prob_t best_prob = INFINITY;
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
		prob_t lexical_prob =
			st->ts ? st->ts->lexical_prob : 0;
		delta_prob += fmax(state_delta, lexical_prob);
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
pgf_new_parsing(PgfConcr* concr, GuPool* pool)
{
	PgfParsing* ps = gu_new(PgfParsing, pool);
	ps->concr = concr;
	ps->completed = NULL;
	ps->target = NULL;
	ps->max_fid = concr->total_cats;
#ifdef PGF_COUNTS_DEBUG
	ps->item_full_count = 0;
	ps->item_real_count = 0;
	ps->cont_full_count = 0;
	ps->ccat_full_count = 0;
	ps->prod_full_count = 0;
#endif
	ps->free_item = NULL;
	ps->beam_size = pgf_parsing_default_beam_size(concr);

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
	state->pool = pool;
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

static PgfTokenState*
pgf_new_token_state(PgfConcr *concr, PgfToken tok, GuPool* pool)
{
	PgfTokenState* ts = gu_new(PgfTokenState, pool);
	ts->tok = tok;
    ts->lexicon_idx = gu_map_get(concr->leftcorner_tok_idx, 
                                 &tok, PgfProductionIdx*);
	ts->lexical_prob = INFINITY;
	if (ts->lexicon_idx != NULL) {
		PgfLexiconFn clo = { { pgf_parser_compute_lexicon_prob }, ts };
		gu_map_iter(ts->lexicon_idx, &clo.fn, NULL);
	}
	if (ts->lexical_prob == INFINITY)
		ts->lexical_prob = 0;
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

PgfParseState*
pgf_parser_next_state(PgfParseState* prev, PgfToken tok, GuPool* pool)
{
#ifdef PGF_COUNTS_DEBUG
	pgf_parsing_print_counts(prev->ps);
#endif

	PgfTokenState* ts =
		pgf_new_token_state(prev->ps->concr,tok,pool);
	PgfParseState* state =
	    pgf_new_parse_state(prev->ps, prev, ts, pool);

	state->ps->target = NULL;
	while (state->ps->target == NULL) {
		if (!pgf_parsing_proceed(state))
			break;
	}
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
			while (pr->state->ps->completed == NULL) {
				if (!pgf_parsing_proceed(pr->state))
					break;
			}
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
#ifdef PGF_COUNTS_DEBUG
	pgf_parsing_print_counts(state->ps);
#endif

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

void
pgf_parse_print_chunks(PgfParseState* state)
{
	if (state->ps->completed == NULL) {
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

	gu_pool_free(tmp_pool);
}

// TODO: s/CId/Cat, add the cid to Cat, make Cat the key to CncCat
PgfParseState*
pgf_parser_init_state(PgfConcr* concr, PgfCId cat, size_t lin_idx, GuPool* pool)
{
	PgfCncCat* cnccat =
		gu_map_get(concr->cnccats, &cat, PgfCncCat*);
	if (!cnccat)
		return NULL;

	gu_assert(lin_idx < cnccat->n_lins);

	PgfParsing* ps =
		pgf_new_parsing(concr, pool);
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
pgf_parser_set_beam_size(PgfParseState* state, double beam_size)
{
	state->ps->beam_size = beam_size;
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

	PgfLeftcornerFn clo2 = { { pgf_parser_leftcorner_iter_conts }, 
	                         concr, conts_map, generated_cats,
	                         concr->total_cats,
	                         pool, tmp_pool };
	gu_map_iter(conts_map, &clo2.fn, NULL);

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
