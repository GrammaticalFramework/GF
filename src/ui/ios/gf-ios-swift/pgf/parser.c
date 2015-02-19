#include <pgf/data.h>
#include <pgf/expr.h>
#include <pgf/linearizer.h>
#include <gu/enum.h>
#include <gu/seq.h>
#include <gu/assert.h>
#include <gu/choice.h>
#include <gu/file.h>
#include <gu/utf8.h>
#include <math.h>
#include <stdlib.h>

//#define PGF_PARSER_DEBUG
//#define PGF_COUNTS_DEBUG
//#define PGF_RESULT_DEBUG

typedef GuBuf PgfItemBuf;

typedef struct PgfParseState PgfParseState;

struct PgfItemConts {
	PgfCCat* ccat;
	size_t lin_idx;
	PgfParseState* state;
	prob_t outside_prob;
	PgfItemBuf* items;
	int ref_count;			// how many items point to this cont?
};

typedef GuSeq PgfItemContss;
typedef GuMap PgfContsMap;
typedef GuMap PgfGenCatMap;

typedef GuBuf PgfCCatBuf;

typedef struct {
	PgfConcr* concr;
	GuPool* pool;      // this pool is used for structures internal to the parser
	GuPool* out_pool;  // this pool is used for the allocating the final abstract trees
	GuString sentence; // the sentence to be parsed
	GuBuf* expr_queue; // during the extraction of abstract trees we push them in this queue
	PgfExpr meta_var;
	PgfProduction meta_prod;
    int max_fid;
    PgfParseState *before;
    PgfParseState *after;
    PgfToken prefix;
    PgfTokenProb* tp;
    PgfExprEnum en;    // enumeration for the generated trees/tokens
#ifdef PGF_COUNTS_DEBUG
    int item_full_count;
    int item_real_count;
    int cont_full_count;
    int ccat_full_count;
    int prod_full_count;
#endif
    PgfItem* free_item;

    prob_t heuristic_factor;
    prob_t meta_prob;
	prob_t meta_token_prob;
} PgfParsing;

typedef enum { BIND_NONE, BIND_HARD, BIND_SOFT } BIND_TYPE;

typedef struct {
	PgfProductionIdx* idx;
	BIND_TYPE bind_type;
	size_t offset;
} PgfLexiconIdxEntry;

typedef GuBuf PgfLexiconIdx;

struct PgfParseState {
	PgfParseState* next;

    PgfItemBuf* agenda;
    PgfItem* meta_item;
	PgfContsMap* conts_map;
	PgfGenCatMap* generated_cats;

	bool needs_bind;
    size_t start_offset;
    size_t end_offset;

	prob_t viterbi_prob;

	PgfLexiconIdx* lexicon_idx;
};

typedef struct PgfAnswers {
	GuBuf* conts;
	GuBuf* exprs;
	prob_t outside_prob;
} PgfAnswers;

typedef struct {
	PgfAnswers* answers;
	PgfExprProb ep;
	PgfPArgs* args;
	size_t arg_idx;
} PgfExprState;

typedef struct PgfItemBase PgfItemBase;

struct PgfItem {
	union {
		PgfItemConts* conts;
		PgfItem *next;		// used to collect released items
	};

	PgfProduction prod;
	PgfPArgs* args;
	PgfSymbol curr_sym;
	uint16_t sym_idx;
	uint8_t alt_idx;     // position in the pre alternative
	uint8_t alt;         // the number of the alternative
	prob_t inside_prob;
};

static PgfSymbol
pgf_prev_extern_sym(PgfSymbol sym)
{
	GuVariantInfo i = gu_variant_open(sym);
	switch (i.tag) {
	case PGF_SYMBOL_CAT:
		return *((PgfSymbol*) (((PgfSymbolCat*) i.data)+1));
	case PGF_SYMBOL_KP:
		return *((PgfSymbol*) (((PgfSymbolKP*) i.data)+1));
	case PGF_SYMBOL_KS: {
		PgfSymbolKS* sks = (PgfSymbolKS*) i.data;
		size_t tok_len = strlen(sks->token);
		return *((PgfSymbol*) (((uint8_t*) sks)+sizeof(PgfSymbolKS)+tok_len+1));
	}
	case PGF_SYMBOL_LIT:
		return *((PgfSymbol*) (((PgfSymbolLit*) i.data)+1));
	case PGF_SYMBOL_VAR:
		return *((PgfSymbol*) (((PgfSymbolVar*) i.data)+1));
	case PGF_SYMBOL_BIND:
	case PGF_SYMBOL_SOFT_BIND:
		return *((PgfSymbol*) (((PgfSymbolBIND*) i.data)+1));
	case PGF_SYMBOL_CAPIT:
		return *((PgfSymbol*) (((PgfSymbolCAPIT*) i.data)+1));
	case PGF_SYMBOL_NE:
		return *((PgfSymbol*) (((PgfSymbolNE*) i.data)+1));
	default:
		gu_impossible();
		return gu_null_variant;
	}
}

static void
pgf_add_extern_tok(PgfSymbol* psym, PgfToken tok, GuPool* pool) {
	PgfSymbol new_sym;
	size_t tok_len = strlen(tok);
	PgfSymbolKS* sks = (PgfSymbolKS*)
		gu_alloc_variant(PGF_SYMBOL_KS,
						 sizeof(PgfSymbol)+sizeof(PgfSymbolKS)+tok_len+1,
						 gu_alignof(PgfSymbolKS),
						 &new_sym, pool);
	strcpy(sks->token, tok);
	*((PgfSymbol*) (((uint8_t*) sks)+sizeof(PgfSymbolKS)+tok_len+1)) = *psym;
	*psym = new_sym;
}

static void
pgf_add_extern_cat(PgfSymbol* psym, int d, int r, GuPool* pool) {
	PgfSymbol new_sym;
	PgfSymbolCat* scat = (PgfSymbolCat*)
		gu_alloc_variant(PGF_SYMBOL_CAT,
						 sizeof(PgfSymbolCat)+sizeof(PgfSymbol),
						 gu_alignof(PgfSymbolCat),
						 &new_sym, pool);
	*((PgfSymbol*) (scat+1)) = *psym;
	scat->d = d;
	scat->r = r;
	*psym = new_sym;
}

PgfSymbol
pgf_collect_extern_tok(PgfParsing* ps, size_t start, size_t end)
{
	PgfSymbol sym = gu_null_variant;

	size_t offset = start;
	while (offset < end) {
		size_t len = 0;
		while (!gu_is_space(ps->sentence[offset+len])) {
			len++;
		}

		PgfToken tok = gu_malloc(ps->pool, len+1);
		memcpy((char*) tok, ps->sentence+offset, len);
		((char*) tok)[len] = 0;

		pgf_add_extern_tok(&sym, tok, ps->pool);

		offset  += len;
		while (gu_is_space(ps->sentence[offset]))
			offset++;
	}

	return sym;
}

static size_t
pgf_item_symbols_length(PgfItem* item)
{
    GuVariantInfo i = gu_variant_open(item->prod);
    switch (i.tag) {
    case PGF_PRODUCTION_APPLY: {
        PgfProductionApply* papp = i.data;
        return gu_seq_length(papp->fun->lins[item->conts->lin_idx]->syms);
    }
    case PGF_PRODUCTION_COERCE: {
        return 1;
    }
    case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = i.data;
        PgfSymbols* syms;

        if (pext->lins != NULL &&
            (syms = gu_seq_get(pext->lins,PgfSymbols*,item->conts->lin_idx)) != NULL) {
		  return gu_seq_length(syms);
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

static PgfSymbols*
pgf_extern_syms_get(PgfItem* item, GuPool* pool)
{
	int syms_len = pgf_item_symbols_length(item);

	PgfSymbols* syms =
		gu_new_seq(PgfSymbol, syms_len, pool);
	PgfSymbol sym = item->curr_sym;
	while (!gu_variant_is_null(sym)) {
		gu_seq_set(syms, PgfSymbol, --syms_len, sym);
		sym = pgf_prev_extern_sym(sym);
	}
	
	return syms;
}

#ifdef PGF_PARSER_DEBUG
static void
pgf_item_symbols(PgfItem* item,
                 size_t* lin_idx, PgfSymbols** syms,
                 GuPool* pool) {
	*lin_idx = item->conts->lin_idx;

    GuVariantInfo i = gu_variant_open(item->prod);
    switch (i.tag) {
    case PGF_PRODUCTION_APPLY: {
        PgfProductionApply* papp = i.data;
        *syms = papp->fun->lins[item->conts->lin_idx]->syms;
        break;
    }
    case PGF_PRODUCTION_COERCE: {
        PgfSymbol sym =
			gu_new_variant_i(pool, PGF_SYMBOL_CAT,
						PgfSymbolCat,
						.d = 0, .r = item->conts->lin_idx);
		*syms = gu_new_seq(PgfSymbol, 1, pool);
		gu_seq_set(*syms, PgfSymbol, 0, sym);
        break;
    }
    case PGF_PRODUCTION_EXTERN: {
        PgfProductionExtern* pext = i.data;
        
        if (pext->lins == NULL ||
            (*syms = gu_seq_get(pext->lins, PgfSymbols*, item->conts->lin_idx)) == NULL) {
		  *syms = pgf_extern_syms_get(item, pool);
		}
		break;
    }
    case PGF_PRODUCTION_META: {
		*syms = pgf_extern_syms_get(item, pool);
		break;
    }
    default:
        gu_impossible();
    }
}

static void
pgf_print_production_args(PgfPArgs* args,
                          GuOut* out, GuExn* err)
{
	size_t n_args = gu_seq_length(args);
	for (size_t j = 0; j < n_args; j++) {
		if (j > 0)
			gu_putc(',',out,err);

		PgfPArg arg = gu_seq_get(args, PgfPArg, j);

		if (arg.hypos != NULL &&
		    gu_seq_length(arg.hypos) > 0) {
			size_t n_hypos = gu_seq_length(arg.hypos);
			for (size_t k = 0; k < n_hypos; k++) {
				PgfCCat *hypo = gu_seq_get(arg.hypos, PgfCCat*, k);
				gu_printf(out,err,"C%d ",hypo->fid);
			}
			gu_printf(out,err,"-> ");
		}
		
		gu_printf(out,err,"C%d",arg.ccat->fid);
	}
}

static void
pgf_print_production(int fid, PgfProduction prod, 
                     GuOut *out, GuExn* err, GuPool* pool)
{
    gu_printf(out,err,"C%d -> ",fid);
       
    GuVariantInfo i = gu_variant_open(prod);
    switch (i.tag) {
    case PGF_PRODUCTION_APPLY: {
        PgfProductionApply* papp = i.data;
        gu_printf(out,err,"F%d(",papp->fun->funid);
        pgf_print_expr(papp->fun->ep->expr, NULL, 0, out, err);
        gu_printf(out,err,")[");
        pgf_print_production_args(papp->args,out,err);
        gu_printf(out,err,"]\n");
        break;
    }
    case PGF_PRODUCTION_COERCE: {
        PgfProductionCoerce* pcoerce = i.data;
        gu_printf(out,err,"_[C%d]\n",pcoerce->coerce->fid);
        break;
    }
    case PGF_PRODUCTION_EXTERN: {
        PgfProductionExtern* pext = i.data;
        gu_printf(out,err,"<extern>(");
        pgf_print_expr(pext->ep->expr, NULL, 0, out, err);
        gu_printf(out,err,")[]\n");
        break;
    }
    case PGF_PRODUCTION_META: {
        PgfProductionMeta* pmeta = i.data;
        gu_printf(out,err,"<meta>[");
        pgf_print_production_args(pmeta->args,out,err);
        gu_printf(out,err,"]\n");
        break;
    }
    default:
        gu_impossible();
    }
}

void
pgf_print_symbol(PgfSymbol sym, GuOut *out, GuExn *err);

static void
pgf_print_item_seq(PgfItem *item,
                   GuOut *out, GuExn* err, GuPool* pool)
{
	size_t lin_idx;
	PgfSymbols* syms = NULL;
	pgf_item_symbols(item, &lin_idx, &syms, pool);

	gu_printf(out, err, "%d : ",lin_idx);

	size_t index;
	for (index = 0; index < gu_seq_length(syms); index++) {
		if (item->sym_idx == index)
			gu_printf(out, err, " . ");

		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, index);
		pgf_print_symbol(sym, out, err);
	}

	if (item->sym_idx == index)
		gu_printf(out, err, " .");
}

static void
pgf_print_range(PgfParseState* start, PgfParseState* end, GuOut* out, GuExn* err)
{
	gu_printf(out, err, "%d-%d",
	          (start != NULL) ? start->end_offset : 0,
	          (start == end)  ? end->end_offset : end->start_offset);
}

static void
pgf_print_item(PgfItem* item, PgfParseState* state, GuOut* out, GuExn* err, GuPool* pool)
{
    gu_printf(out, err, "[");
	pgf_print_range(item->conts->state, state, out, err);
	gu_printf(out, err, "; C%d -> ", item->conts->ccat->fid);

	GuVariantInfo i = gu_variant_open(item->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
        PgfCncFun* fun = papp->fun;
        gu_printf(out, err, "F%d(", fun->funid);
        pgf_print_expr(fun->ep->expr, NULL, 0, out, err);
        gu_printf(out, err, ")[");
        pgf_print_production_args(item->args, out, err);
        gu_printf(out, err, "]; ");
		break;
	}
	case PGF_PRODUCTION_COERCE: {
        gu_printf(out, err, "_[C%d]; ",
            gu_seq_index(item->args, PgfPArg, 0)->ccat->fid);
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = i.data;
        gu_printf(out, err, "<extern>");
        if (pext->ep != NULL) {
			gu_printf(out, err, "(");
			pgf_print_expr(pext->ep->expr, NULL, 0, out, err);
			gu_printf(out, err, ")");
		}
		gu_printf(out, err, "[");
		pgf_print_production_args(item->args, out, err);
        gu_printf(out, err, "]; ");
		break;
	}
	case PGF_PRODUCTION_META: {
        gu_printf(out, err, "<meta>[");
		pgf_print_production_args(item->args, out, err);
        gu_printf(out, err, "]; ");
		break;
	}
	default:
		gu_impossible();
	}
    
    pgf_print_item_seq(item, out, err, pool);
    gu_printf(out, err, "; %f+%f=%f]\n",
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
cmp_string(GuString* psent, size_t* plen, GuString tok)
{
	GuString sent = *psent;
	size_t   len  = *plen;

	while (*tok != 0) {
		if (len == 0)
			return -1;

		if (((uint8_t) *sent) > ((uint8_t) *tok))
			return 1;
		else if (((uint8_t) *sent) < ((uint8_t) *tok))
			return -2;
			
		tok++;
		sent++;
		len--;
	}

	*psent = sent;
	*plen  = len;
	return 0;
}

static bool
skip_space(GuString* psent, size_t* plen)
{
	if (*plen == 0)
		return false;

	char c = **psent;
	if (!gu_is_space(c))
		return false;

	(*psent)++;
	return true;
}

static int
cmp_item_prob(GuOrder* self, const void* a, const void* b)
{
	PgfItem *item1 = *((PgfItem **) a);
	PgfItem *item2 = *((PgfItem **) b);

	prob_t prob1 = item1->inside_prob + item1->conts->outside_prob;
	prob_t prob2 = item2->inside_prob + item2->conts->outside_prob;
	
	return (int) (prob1-prob2);
}

static GuOrder
pgf_item_prob_order[1] = { { cmp_item_prob } };

static int
cmp_item_production_idx_entry(GuOrder* self, const void* a, const void* b)
{
	PgfProductionIdxEntry *entry1 = (PgfProductionIdxEntry *) a;
	PgfProductionIdxEntry *entry2 = (PgfProductionIdxEntry *) b;

	if (entry1->ccat->fid < entry2->ccat->fid)
		return -1;
	else if (entry1->ccat->fid > entry2->ccat->fid)
		return 1;
	else if (entry1->lin_idx < entry2->lin_idx)
		return -1;
	else if (entry1->lin_idx > entry2->lin_idx)
		return 1;
	else
		return 0;
}

static GuOrder
pgf_production_idx_entry_order[1] = { { cmp_item_production_idx_entry } };

static inline PgfItemContss*
pgf_parsing_get_contss(PgfParseState* state, PgfCCat* cat, GuPool *pool)
{
	return gu_map_get(state->conts_map, cat, PgfItemContss*);
}

static PgfItemConts*
pgf_parsing_get_conts(PgfParseState* state,
                      PgfCCat* ccat, size_t lin_idx,
					  GuPool *pool)
{
	gu_require(lin_idx < ccat->cnccat->n_lins);
	PgfItemContss* contss = 
		pgf_parsing_get_contss(state, ccat, pool);
	if (contss == NULL) {
		size_t n_lins = ccat->cnccat->n_lins;
		contss = gu_new_seq(PgfItemConts*, n_lins, pool);
		for (size_t i = 0; i < n_lins; i++) {
			gu_seq_set(contss, PgfItemConts*, i, NULL);
		}
		gu_map_put(state->conts_map, ccat, PgfItemContss*, contss);
	}

	PgfItemConts* conts = gu_seq_get(contss, PgfItemConts*, lin_idx);
	if (!conts) {
		conts = gu_new(PgfItemConts, pool);
		conts->ccat      = ccat;
		conts->lin_idx   = lin_idx;
		conts->state     = state;
		conts->items     = gu_new_buf(PgfItem*, pool);
		conts->outside_prob = 0;
		conts->ref_count = 0;
		gu_seq_get(contss, PgfItemConts*, lin_idx) = conts;
		
#ifdef PGF_COUNTS_DEBUG
		if (state != NULL) {
			state->ps->cont_full_count++;
		}
#endif
	}
	return conts;
}

static void
gu_ccat_fini(GuFinalizer* fin)
{
	PgfCCat* cat = gu_container(fin, PgfCCat, fin);
	if (cat->prods != NULL)
		gu_seq_free(cat->prods);
}

static PgfCCat*
pgf_parsing_create_completed(PgfParsing* ps, PgfParseState* state, 
                             PgfItemConts* conts,
                             prob_t viterbi_prob)
{
	PgfCCat* cat = gu_new_flex(ps->pool, PgfCCat, fin, 1);
	cat->cnccat = conts->ccat->cnccat;
	cat->lindefs = conts->ccat->lindefs;
	cat->linrefs = conts->ccat->linrefs;
	cat->viterbi_prob = viterbi_prob;
	cat->fid = ps->max_fid++;
	cat->conts = conts;
	cat->answers = NULL;
	cat->prods = NULL;
	cat->n_synprods = 0;
	gu_map_put(state->generated_cats, conts, PgfCCat*, cat);
	
	cat->fin[0].fn = gu_ccat_fini;
	gu_pool_finally(ps->pool, cat->fin);

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
		PgfSymbols* syms = fun->lins[item->conts->lin_idx]->syms;
		gu_assert(item->sym_idx <= gu_seq_length(syms));
		if (item->sym_idx == gu_seq_length(syms)) {
			item->curr_sym = gu_null_variant;
		} else {
			item->curr_sym = gu_seq_get(syms, PgfSymbol, item->sym_idx);
		}
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		gu_assert(item->sym_idx <= 1);
		if (item->sym_idx == 1) {
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
pgf_new_item(PgfParsing* ps, PgfItemConts* conts, PgfProduction prod)
{
	PgfItem* item;
	if (ps->free_item == NULL)
	  item = gu_new(PgfItem, ps->pool);
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
		item->args = gu_new_seq(PgfPArg, 1, ps->pool);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, 0);
		parg->hypos = NULL;
		parg->ccat = pcoerce->coerce;
		item->inside_prob = pcoerce->coerce->viterbi_prob;
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = pi.data;
		item->args = gu_empty_seq();
		item->inside_prob = pext->ep->prob;
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
	item->sym_idx = 0;
	item->alt_idx = 0;
	item->alt = 0;

	conts->ref_count++;

	pgf_item_set_curr_symbol(item, ps->pool);

#ifdef PGF_COUNTS_DEBUG
	ps->item_full_count++;
	ps->item_real_count++;
#endif

	return item;
}

static PgfItem*
pgf_item_copy(PgfItem* item, PgfParsing* ps)
{
	PgfItem* copy;
	if (ps == NULL || ps->free_item == NULL)
	  copy = gu_new(PgfItem, ps->pool);
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
                    PgfParsing *ps)
{
	PgfCCat *old_ccat =
		gu_seq_index(item->args, PgfPArg, d)->ccat;

	PgfItem* new_item = pgf_item_copy(item, ps);
	size_t nargs = gu_seq_length(item->args);
	new_item->args = gu_new_seq(PgfPArg, nargs, ps->pool);
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

	if (GU_LIKELY(item->alt == 0)) {
		item->sym_idx++;
		pgf_item_set_curr_symbol(item, pool);
	}
	else
		item->alt_idx++;
}

static void
pgf_item_free(PgfParsing* ps, PgfItem* item)
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

			pgf_item_free(ps, cont);
		}
	}

#ifdef PGF_PARSER_DEBUG
	memset(item, 0, sizeof(*item));
#endif
	item->next = ps->free_item;
	ps->free_item = item;
#ifdef PGF_COUNTS_DEBUG
	ps->item_real_count--;
#endif
}

static void
pgf_result_predict(PgfParsing* ps, 
                   PgfExprState* cont, PgfCCat* ccat);

static void
pgf_result_production(PgfParsing* ps, 
                      PgfAnswers* answers, PgfProduction prod);

static void
pgf_parsing_combine(PgfParsing* ps,
                    PgfParseState* before, PgfParseState* after,
                    PgfItem* cont, PgfCCat* cat, int lin_idx)
{
	if (cont == NULL) {
		if (before->end_offset == strlen(ps->sentence)) {
			pgf_result_predict(ps, NULL, cat);
		}
		return;
	}

	PgfItem* item = NULL;
	switch (gu_variant_tag(cont->curr_sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(cont->curr_sym);
		item = pgf_item_update_arg(cont, scat->d, cat, ps);
		break;
	}
	case PGF_SYMBOL_LIT: {
		PgfSymbolLit* slit = gu_variant_data(cont->curr_sym);
		item = pgf_item_update_arg(cont, slit->d, cat, ps);
		break;
	}
	default:
		gu_impossible();
	}

	pgf_item_advance(item, ps->pool);
	gu_buf_heap_push(before->agenda, pgf_item_prob_order, &item);
}

static void
pgf_parsing_production(PgfParsing* ps, PgfParseState* state,
                       PgfItemConts* conts, PgfProduction prod)
{
	PgfItem* item =
        pgf_new_item(ps, conts, prod);
    gu_buf_heap_push(state->agenda, pgf_item_prob_order, &item);
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
		new_pcoerce->coerce = parg->ccat;
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = i.data;

		if (pext->lins == NULL ||
		    gu_seq_get(pext->lins,PgfSymbols*,item->conts->lin_idx) == NULL) {
			PgfSymbols* syms =
				pgf_extern_syms_get(item, pool);

			size_t n_lins = item->conts->ccat->cnccat->n_lins;

			PgfProductionExtern* new_pext = (PgfProductionExtern*)
				gu_new_variant(PGF_PRODUCTION_EXTERN,
				               PgfProductionExtern,
				               &prod, pool);
			new_pext->ep = ep;
			new_pext->lins = gu_new_seq(PgfSymbols*, n_lins, pool);

			if (pext->lins == NULL) {
				for (size_t i = 0; i < n_lins; i++) {
					gu_seq_set(new_pext->lins,PgfSymbols*,i,NULL);
				}
			} else {
				for (size_t i = 0; i < n_lins; i++) {
					gu_seq_set(new_pext->lins,PgfSymbols*,i,
							   gu_seq_get(pext->lins,PgfSymbols*,i));
				}
			}
			gu_seq_set(new_pext->lins,PgfSymbols*,item->conts->lin_idx,syms);
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
pgf_parsing_complete(PgfParsing* ps, PgfItem* item, PgfExprProb *ep)
{
	PgfProduction prod =
		pgf_parsing_new_production(item, ep, ps->pool);
#ifdef PGF_COUNTS_DEBUG
	ps->prod_full_count++;
#endif

	PgfCCat* tmp_ccat = pgf_parsing_get_completed(ps->before, item->conts);
    PgfCCat* ccat = tmp_ccat;
    if (ccat == NULL) {
        ccat = pgf_parsing_create_completed(ps, ps->before, item->conts, item->inside_prob);
    }

	if (ccat->prods == NULL || ccat->n_synprods >= gu_seq_length(ccat->prods)) {
		ccat->prods = gu_realloc_seq(ccat->prods, PgfProduction, ccat->n_synprods+1);
	}
	gu_seq_set(ccat->prods, PgfProduction, ccat->n_synprods++, prod);

#ifdef PGF_PARSER_DEBUG
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuExn* err = gu_exn(tmp_pool);
    if (tmp_ccat == NULL) {
	    gu_printf(out, err, "[");
		pgf_print_range(item->conts->state, ps->before, out, err);
		gu_printf(out, err, "; C%d; %d; C%d]\n",
                            item->conts->ccat->fid, 
                            item->conts->lin_idx, 
                            ccat->fid);
	}
    pgf_print_production(ccat->fid, prod, out, err, tmp_pool);
    gu_pool_free(tmp_pool);
#endif

	if (tmp_ccat != NULL) {
		PgfItemContss* contss =
			pgf_parsing_get_contss(ps->before, ccat, ps->pool);
		if (contss != NULL) {
			size_t n_contss = gu_seq_length(contss);
			for (size_t i = 0; i < n_contss; i++) {
				PgfItemConts* conts2 = gu_seq_get(contss, PgfItemConts*, i);
				/* If there are continuations for
				 * linearization index i, then (cat, i) has
				 * already been predicted. Add the new
				 * production immediately to the agenda,
				 * i.e. process it. */
				if (conts2) {
					pgf_parsing_production(ps, ps->before, conts2, prod);
				}
			}
		}

		// The category has already been created. If it has also been
		// predicted already, then process a new item for this production.
		PgfParseState* state = ps->after;
		while (state != NULL) {
			PgfItemContss* contss =
				pgf_parsing_get_contss(state, ccat, ps->pool);
			if (contss != NULL) {
				size_t n_contss = gu_seq_length(contss);
				for (size_t i = 0; i < n_contss; i++) {
					PgfItemConts* conts2 = gu_seq_get(contss, PgfItemConts*, i);
					/* If there are continuations for
					 * linearization index i, then (cat, i) has
					 * already been predicted. Add the new
					 * production immediately to the agenda,
					 * i.e. process it. */
					if (conts2) {
						pgf_parsing_production(ps, state, conts2, prod);
					}
				}
			}

			state = state->next;
		}
		
		if (ccat->answers != NULL) {
			pgf_result_production(ps, ccat->answers, prod);
		}
	} else {
		size_t n_conts = gu_buf_length(item->conts->items);
		for (size_t i = 0; i < n_conts; i++) {
			PgfItem* cont = gu_buf_get(item->conts->items, PgfItem*, i);
			pgf_parsing_combine(ps, ps->before, ps->after, cont, ccat, item->conts->lin_idx);
		}
    }
}

static int
pgf_symbols_cmp(GuString* psent, size_t sent_len, BIND_TYPE* pbind, PgfSymbols* syms)
{
	GuString sent = *psent;

	size_t n_syms = gu_seq_length(syms);
	for (size_t i = 0; i < n_syms; i++) {
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, i);

		GuVariantInfo inf = gu_variant_open(sym);
		switch (inf.tag) {
		case PGF_SYMBOL_CAT:
		case PGF_SYMBOL_LIT:
		case PGF_SYMBOL_VAR: {
			if (sent_len == 0)
				return -1;
			return 1;
		}
		case PGF_SYMBOL_KS: {
			PgfSymbolKS* pks = inf.data;
			if (sent_len == 0)
				return -1;

			if (*pbind == BIND_HARD)
				*pbind = BIND_NONE;
			else {
				if (*pbind != BIND_SOFT && !skip_space(&sent, &sent_len))
					return 1;

				while (*sent != 0) {
					if (!skip_space(&sent, &sent_len))
						break;
				}
			}

			int cmp = cmp_string(&sent, &sent_len, pks->token);
			if (cmp != 0)
				return cmp;
			break;
		}
		case PGF_SYMBOL_KP: {
			return -2;
		}
		case PGF_SYMBOL_BIND: {
			*pbind = BIND_HARD;
			break;
		}
		case PGF_SYMBOL_SOFT_BIND: {
			*pbind = BIND_SOFT;
			break;
		}
		case PGF_SYMBOL_CAPIT: {
			break;
		}
		case PGF_SYMBOL_NE: {
			return -2;
		}
		default:
			gu_impossible();
		}
	}

    *psent = sent;
	return 0;
}

static void
pgf_parsing_lookahead(PgfParsing *ps, PgfParseState* state)
{
	PgfSequence* epsilon_seq =
		gu_seq_index(ps->concr->sequences, PgfSequence, 0);
	if (gu_seq_length(epsilon_seq->syms) == 0 &&
	    epsilon_seq->idx != NULL) {
		// Since the sequences are sorted, the epsilon sequence will
		// always be the first if there is any at all. We should
		// always add the epsilon in the index, because we do
		// bottom up prediction for epsilons.
		PgfLexiconIdxEntry* entry = gu_buf_extend(state->lexicon_idx);
		entry->idx       = epsilon_seq->idx;
		entry->bind_type = BIND_NONE;
		entry->offset    = state->start_offset;
	}

	size_t i = 0;
	size_t j = gu_seq_length(ps->concr->sequences)-1;
	size_t s = j;
	size_t n = 1;
	size_t sent_len = strlen(ps->sentence);

	while (state->end_offset + n <= sent_len) {
		while (i <= j) {
			size_t k  = (i+j) / 2;
			PgfSequence* seq = gu_seq_index(ps->concr->sequences, PgfSequence, k);
			
			GuString current = ps->sentence + state->end_offset;
			BIND_TYPE bind_type = state->needs_bind ? BIND_NONE : BIND_HARD;
			switch (pgf_symbols_cmp(&current, n, &bind_type, seq->syms)) {
			case -2:
				j = k-1;
				s = j;
				break;
			case -1:
				j = k-1;
				break;
			case 0: {
				if (seq->idx != NULL) {
					PgfLexiconIdxEntry* entry = gu_buf_extend(state->lexicon_idx);
					entry->idx       = seq->idx;
					entry->bind_type = bind_type;
					entry->offset    = (current - ps->sentence);
				}
				i = k+1;
				goto next;
			}
			case 1:
				i = k+1;
				break;
			}
		}

next:;
		size_t n_pres = gu_buf_length(ps->concr->pre_sequences);
		for (size_t pi = 0; pi < n_pres; pi++) {
			PgfSequence* seq = gu_buf_index(ps->concr->pre_sequences, PgfSequence, pi);

			GuString current = ps->sentence + state->end_offset;
			BIND_TYPE bind_type = state->needs_bind ? BIND_NONE : BIND_HARD;
			if (pgf_symbols_cmp(&current, n, &bind_type, seq->syms) == 0) {
				PgfLexiconIdxEntry* entry = gu_buf_extend(state->lexicon_idx);
				entry->idx       = seq->idx;
				entry->bind_type = bind_type;
				entry->offset    = (current - ps->sentence);
			}
		}

		j = s;
		n++;
	}
}

static PgfParseState*
pgf_new_parse_state(PgfParsing* ps, size_t start_offset,
                    BIND_TYPE bind_type,
                    prob_t viterbi_prob)
{
	PgfParseState** pstate;
	if (ps->before == NULL && start_offset == 0)
		pstate = &ps->before;
	else {
		if (bind_type != BIND_NONE) {
			if (ps->before->start_offset == start_offset &&
			    ps->before->end_offset   == start_offset &&
			    !ps->before->needs_bind)
				return ps->before;
		} else {
			if (ps->before->start_offset == start_offset)
				return ps->before;
		}

		pstate = &ps->after;
		while (*pstate != NULL) {
			if (bind_type != BIND_NONE) {
				if ((*pstate)->start_offset == start_offset &&
				    (*pstate)->end_offset   == start_offset &&
				    !(*pstate)->needs_bind)
					return *pstate;
			} else {
				if ((*pstate)->start_offset == start_offset)
					return *pstate;
			}
			if ((*pstate)->start_offset > start_offset)
				break;
			pstate = &(*pstate)->next;
		}
	}

	size_t end_offset = start_offset;
	GuString current = ps->sentence + end_offset;
	size_t len = strlen(current);
	while (skip_space(&current, &len)) {
		end_offset++;
	}

	if (bind_type == BIND_HARD && start_offset != end_offset)
		return NULL;

	PgfParseState* state = gu_new(PgfParseState, ps->pool);
	state->next = *pstate;
    state->agenda = gu_new_buf(PgfItem*, ps->pool);
    state->meta_item = NULL;
	state->generated_cats = gu_new_addr_map(PgfItemConts*, PgfCCat*, &gu_null_struct, ps->pool);
	state->conts_map = gu_new_addr_map(PgfCCat*, PgfItemContss*, &gu_null_struct, ps->pool);
	state->needs_bind = (bind_type == BIND_NONE) &&
	                    (start_offset == end_offset);
	state->start_offset = start_offset;
	state->end_offset = end_offset;
	state->viterbi_prob = viterbi_prob;
 	state->lexicon_idx =
		gu_new_buf(PgfLexiconIdxEntry, ps->pool);

	if (ps->before == NULL && start_offset == 0)
		state->needs_bind = false;

	pgf_parsing_lookahead(ps, state);

	*pstate = state;

	return state;
}

static void
pgf_parsing_add_transition(PgfParsing* ps, PgfToken tok, PgfItem* item)
{	
	GuString current = ps->sentence + ps->before->end_offset;
	size_t len = strlen(current);

	if (ps->prefix != NULL && ps->sentence[ps->before->end_offset] == 0) {
		if (gu_string_is_prefix(ps->prefix, tok)) {
			ps->tp = gu_new(PgfTokenProb, ps->out_pool);
			ps->tp->tok  = tok;
			ps->tp->prob = item->inside_prob + item->conts->outside_prob;
		}
	} else {
		if (!ps->before->needs_bind && cmp_string(&current, &len, tok) == 0) {
			PgfParseState* state =
				pgf_new_parse_state(ps, (current - ps->sentence), 
				                    BIND_NONE,
				                    item->inside_prob+item->conts->outside_prob);
			gu_buf_heap_push(state->agenda, pgf_item_prob_order, &item);
		} else {
			pgf_item_free(ps, item);
		}
	}
}

static void
pgf_parsing_predict_lexeme(PgfParsing* ps, PgfItemConts* conts,
                           PgfLexiconIdxEntry* lentry,
                           PgfProductionIdxEntry* entry)
{
	GuVariantInfo i = { PGF_PRODUCTION_APPLY, entry->papp };
	PgfProduction prod = gu_variant_close(i);
	PgfItem* item =
        pgf_new_item(ps, conts, prod);
    PgfSymbols* syms = entry->papp->fun->lins[conts->lin_idx]->syms;
    item->sym_idx = gu_seq_length(syms);
    prob_t prob = item->inside_prob+item->conts->outside_prob;
	PgfParseState* state =
		pgf_new_parse_state(ps, lentry->offset, lentry->bind_type, 
		                    prob);
	if (state->viterbi_prob > prob) {
		state->viterbi_prob = prob;
	}
    gu_buf_heap_push(state->agenda, pgf_item_prob_order, &item);
}

static void
pgf_parsing_td_predict(PgfParsing* ps,
                       PgfItem* item, PgfCCat* ccat, size_t lin_idx)
{
	PgfItemConts* conts = 
		pgf_parsing_get_conts(ps->before, ccat, lin_idx, ps->pool);
	gu_buf_push(conts->items, PgfItem*, item);
	if (gu_buf_length(conts->items) == 1) {
		/* First time we encounter this linearization
		 * of this category at the current position,
		 * so predict it. */

		conts->outside_prob =
			item->inside_prob-conts->ccat->viterbi_prob+
			item->conts->outside_prob;

		if (ps->prefix != NULL) {
			// We do completion:
			//   - top-down prediction for both syntactic and lexical rules
			size_t n_prods;
			if (ccat->fid < ps->concr->total_cats) // in grammar
				n_prods = gu_seq_length(ccat->prods);
			else
				n_prods = ccat->n_synprods;
			for (size_t i = 0; i < n_prods; i++) {
				PgfProduction prod =
					gu_seq_get(ccat->prods, PgfProduction, i);
				pgf_parsing_production(ps, ps->before, conts, prod);
			}
		} else {
			// Top-down prediction for syntactic rules
			for (size_t i = 0; i < ccat->n_synprods; i++) {
				PgfProduction prod =
					gu_seq_get(ccat->prods, PgfProduction, i);
				pgf_parsing_production(ps, ps->before, conts, prod);
			}

			// Bottom-up prediction for lexical and epsilon rules
			size_t n_idcs = gu_buf_length(ps->before->lexicon_idx);
			for (size_t i = 0; i < n_idcs; i++) {
				PgfLexiconIdxEntry* lentry =
					gu_buf_index(ps->before->lexicon_idx, PgfLexiconIdxEntry, i);
				PgfProductionIdxEntry key;
				key.ccat    = ccat;
				key.lin_idx = lin_idx;
				key.papp    = NULL;
				PgfProductionIdxEntry* value =
					gu_seq_binsearch(gu_buf_data_seq(lentry->idx),
									 pgf_production_idx_entry_order,
									 PgfProductionIdxEntry, &key);

				if (value != NULL) {
					pgf_parsing_predict_lexeme(ps, conts, lentry, value);

					PgfProductionIdxEntry* start =
						gu_buf_data(lentry->idx);
					PgfProductionIdxEntry* end =
						start + gu_buf_length(lentry->idx)-1;

					PgfProductionIdxEntry* left = value-1;
					while (left >= start &&
						   value->ccat->fid == left->ccat->fid &&
						   value->lin_idx   == left->lin_idx) {
						pgf_parsing_predict_lexeme(ps, conts, lentry, left);
						left--;
					}

					PgfProductionIdxEntry* right = value+1;
					while (right <= end &&
						   value->ccat->fid == right->ccat->fid &&
						   value->lin_idx   == right->lin_idx) {
						pgf_parsing_predict_lexeme(ps, conts, lentry, right);
						right++;
					}
				}
			}
		}
	} else {
		/* If it has already been completed, combine. */

		PgfCCat* completed =
			pgf_parsing_get_completed(ps->before, conts);
		if (completed) {
			pgf_parsing_combine(ps, ps->before, ps->after, item, completed, lin_idx);
		}

		PgfParseState* state = ps->after;
		while (state != NULL) {
			PgfCCat* completed =
				pgf_parsing_get_completed(state, conts);
			if (completed) {
				pgf_parsing_combine(ps, state, state->next, item, completed, lin_idx);
			}

			state = state->next;
		}
	}
}

static void
pgf_parsing_meta_scan(PgfParsing* ps,
	                  PgfItem* meta_item, prob_t meta_prob)
{
	PgfItem* item = pgf_item_copy(meta_item, ps);
	item->inside_prob += meta_prob;

	size_t offset = ps->before->end_offset;
	while (ps->sentence[offset] != 0 &&
	       !gu_is_space(ps->sentence[offset])) {
		offset++;
	}
	
	size_t len = offset - ps->before->end_offset;
	char* tok = gu_malloc(ps->pool, len+1);
	memcpy(tok, ps->sentence+ps->before->end_offset, len);
	tok[len] = 0;

	pgf_add_extern_tok(&item->curr_sym, tok, ps->pool);

	gu_buf_heap_push(ps->before->agenda, pgf_item_prob_order, &item);
}

static void
pgf_parsing_meta_predict(PgfParsing* ps, PgfItem* meta_item)
{
	PgfAbsCats* cats = ps->concr->abstr->cats;
	size_t n_cats = gu_seq_length(cats);
	
	for (size_t i = 0; i < n_cats; i++) {
		PgfAbsCat* abscat = gu_seq_index(cats, PgfAbsCat, i);

		if (abscat->prob == INFINITY)
			continue;

		PgfCncCat* cnccat =
			gu_map_get(ps->concr->cnccats, abscat->name, PgfCncCat*);
		if (cnccat == NULL)
			continue;

		size_t n_cats = gu_seq_length(cnccat->cats);
		for (size_t i = 0; i < n_cats; i++) {
			PgfCCat* ccat = gu_seq_get(cnccat->cats, PgfCCat*, i);
			if (ccat->prods == NULL) {
				// empty category
				continue;
			}

			for (size_t lin_idx = 0; lin_idx < cnccat->n_lins; lin_idx++) {
				PgfItem* item = 
					pgf_item_copy(meta_item, ps);
				item->inside_prob +=
					ccat->viterbi_prob+abscat->prob;

				size_t nargs = gu_seq_length(meta_item->args);
				item->args = gu_new_seq(PgfPArg, nargs+1, ps->pool);
				memcpy(gu_seq_data(item->args), gu_seq_data(meta_item->args),
					   nargs * sizeof(PgfPArg));
				gu_seq_set(item->args, PgfPArg, nargs,
						   ((PgfPArg) { .hypos = NULL, .ccat = ccat }));

				pgf_add_extern_cat(&item->curr_sym, nargs, lin_idx, ps->pool);

				gu_buf_heap_push(ps->before->agenda, pgf_item_prob_order, &item);
			}
		}
	}
}

static void
pgf_parsing_symbol(PgfParsing* ps, PgfItem* item, PgfSymbol sym);

static void
pgf_parsing_pre(PgfParsing* ps, PgfItem* item, PgfSymbols* syms)
{
	if (item->alt_idx < gu_seq_length(syms)) {
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, item->alt_idx);
		pgf_parsing_symbol(ps, item, sym);
	} else {
		item->alt = 0;
		pgf_item_advance(item, ps->pool);
		gu_buf_heap_push(ps->before->agenda, pgf_item_prob_order, &item);
	}
}

static void
pgf_parsing_symbol(PgfParsing* ps, PgfItem* item, PgfSymbol sym)
{
	switch (gu_variant_tag(sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(sym);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, scat->d);
		
		if (parg->ccat->prods == NULL) {
			// empty category
			pgf_item_free(ps, item);
			return;
		}

		pgf_parsing_td_predict(ps, item, parg->ccat, scat->r);
		break;
	}
	case PGF_SYMBOL_KS: {
		PgfSymbolKS* sks = gu_variant_data(sym);
		pgf_item_advance(item, ps->pool);
		pgf_parsing_add_transition(ps, sks->token, item);
		break;
	}
	case PGF_SYMBOL_KP: {
		PgfSymbolKP* skp = gu_variant_data(sym);

		PgfSymbol sym;
		if (item->alt == 0) {
			PgfItem* new_item;

			new_item = pgf_item_copy(item, ps);
			new_item->alt = 1;
			new_item->alt_idx = 0;
			pgf_parsing_pre(ps, new_item, skp->default_form);

			for (size_t i = 0; i < skp->n_forms; i++) {
				PgfSymbols* syms = skp->forms[i].form;
				PgfSymbols* syms2 = skp->default_form;
				bool skip = false; /*pgf_tokens_equal(toks, toks2);
				for (size_t j = 0; j < i; j++) {
					PgfTokens* toks2 = skp->forms[j].form;
					skip |= pgf_tokens_equal(toks, toks2);
				}*/
				if (!skip) {
					new_item = pgf_item_copy(item, ps);
					new_item->alt = i+2;
					new_item->alt_idx = 0;
					pgf_parsing_pre(ps, new_item, syms);
				}
			}
		} else {
			PgfSymbols* syms =
			   (item->alt == 1) ? skp->default_form : 
								  skp->forms[item->alt-2].form;
			pgf_parsing_pre(ps, item, syms);
		}
		break;
	}
	case PGF_SYMBOL_LIT: {
		PgfSymbolLit* slit = gu_variant_data(sym);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, slit->d);

		if (parg->ccat->fid >= ps->concr->total_cats) {
			pgf_parsing_td_predict(ps, item, parg->ccat, slit->r);
		}
		else {
			PgfItemConts* conts = 
				pgf_parsing_get_conts(ps->before, 
				                      parg->ccat, slit->r,
									  ps->pool);
			gu_buf_push(conts->items, PgfItem*, item);

			if (gu_buf_length(conts->items) == 1) {
				/* This is the first time when we encounter this 
				 * literal category so we must call the callback */

				PgfLiteralCallback* callback =
					gu_map_get(ps->concr->callbacks, 
					           parg->ccat->cnccat, 
							   PgfLiteralCallback*);

				if (callback != NULL) {
					size_t start  = ps->before->end_offset;
					size_t offset = start;
					PgfExprProb *ep =
						callback->match(callback,
						                slit->r,
				                        ps->sentence, &offset,
				                        ps->out_pool);

					if (ep != NULL) {
						PgfProduction prod;
						PgfProductionExtern* pext =
							gu_new_variant(PGF_PRODUCTION_EXTERN,
										   PgfProductionExtern,
										   &prod, ps->pool);
						pext->ep = ep;
						pext->lins = NULL;

						PgfItem* item =
							pgf_new_item(ps, conts, prod);
						item->curr_sym = pgf_collect_extern_tok(ps,start,offset);
						item->sym_idx  = pgf_item_symbols_length(item);
						PgfParseState* state =
							pgf_new_parse_state(ps, offset, BIND_NONE,
							                    item->inside_prob+item->conts->outside_prob);
						gu_buf_heap_push(state->agenda, pgf_item_prob_order, &item);
					}
				} else {
					pgf_item_free(ps, item);
				}
			} else {
				/* If it has already been completed, combine. */

				PgfCCat* completed =
					pgf_parsing_get_completed(ps->before, conts);
				if (completed) {
					pgf_parsing_combine(ps, ps->before, ps->after, item, completed, slit->r);
				}
						
				PgfParseState* state = ps->after;
				while (state != NULL) {
					PgfCCat* completed =
						pgf_parsing_get_completed(state, conts);
					if (completed) {
						pgf_parsing_combine(ps, state, state->next, item, completed, slit->r);
					}

					state = state->next;
				}
			}
		}
		break;
	}
	case PGF_SYMBOL_VAR:
		// XXX TODO proper support
		break;
	case PGF_SYMBOL_NE: {
		// Nothing can match with a non-existant token
		pgf_item_free(ps, item);
		break;
	}
	case PGF_SYMBOL_BIND: {
		if (ps->before->start_offset == ps->before->end_offset &&
		    ps->before->needs_bind) {
			PgfParseState* state =
				pgf_new_parse_state(ps, ps->before->end_offset, BIND_HARD, 
				                    item->inside_prob+item->conts->outside_prob);
			if (state != NULL) {
				pgf_item_advance(item, ps->pool);
				gu_buf_heap_push(state->agenda, pgf_item_prob_order, &item);
			} else {
				pgf_item_free(ps, item);
			}
		} else {
			pgf_item_free(ps, item);
		}
		break;
	}
	case PGF_SYMBOL_SOFT_BIND: {
		if (ps->before->start_offset == ps->before->end_offset) {
			if (ps->before->needs_bind) {
				PgfParseState* state =
					pgf_new_parse_state(ps, ps->before->end_offset, BIND_HARD,
					                    item->inside_prob+item->conts->outside_prob);
				if (state != NULL) {
					pgf_item_advance(item, ps->pool);
					gu_buf_heap_push(state->agenda, pgf_item_prob_order, &item);
				} else {
					pgf_item_free(ps, item);
				}
			} else {
				pgf_item_free(ps, item);
			}
		} else {
			pgf_item_advance(item, ps->pool);
			gu_buf_heap_push(ps->before->agenda, pgf_item_prob_order, &item);
		}
		break;
	}
	case PGF_SYMBOL_CAPIT: {
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_parsing_item(PgfParsing* ps, PgfItem* item)
{
#ifdef PGF_PARSER_DEBUG
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuExn* err = gu_exn(tmp_pool);
    pgf_print_item(item, ps->before, out, err, tmp_pool);
    gu_pool_free(tmp_pool);
#endif

	GuVariantInfo i = gu_variant_open(item->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
		PgfCncFun* fun = papp->fun;
		PgfSymbols* syms = fun->lins[item->conts->lin_idx]->syms;
		if (item->sym_idx == gu_seq_length(syms)) {
			pgf_parsing_complete(ps, item, NULL);
			pgf_item_free(ps, item);
		} else  {
			pgf_parsing_symbol(ps, item, item->curr_sym);
		}
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = i.data;
		switch (item->sym_idx) {
		case 0:
			if (pcoerce->coerce->prods == NULL) {
				// empty category
				pgf_item_free(ps, item);
				return;
			}

			pgf_parsing_td_predict(ps, item,
				                   pcoerce->coerce,
				                   item->conts->lin_idx);
			break;
		case 1:
			pgf_parsing_complete(ps, item, NULL);
			pgf_item_free(ps, item);
			break;
		default:
			gu_impossible();
		}
		break;
	}
	case PGF_PRODUCTION_EXTERN: {
		PgfProductionExtern* pext = i.data;

		PgfSymbols* syms;
		if (pext->lins != NULL &&
		    (syms = gu_seq_get(pext->lins,PgfSymbols*,item->conts->lin_idx)) != NULL) {
			if (item->sym_idx == gu_seq_length(syms)) {
				pgf_parsing_complete(ps, item, NULL);
				pgf_item_free(ps, item);
			} else {
				PgfSymbol sym =
					gu_seq_get(syms, PgfSymbol, item->sym_idx);
				pgf_parsing_symbol(ps, item, sym);
			}
		} else {
			pgf_parsing_complete(ps, item, pext->ep);
			pgf_item_free(ps, item);
		}
		break;
	}
	case PGF_PRODUCTION_META: {
		if (item->sym_idx == pgf_item_symbols_length(item)) {
			if (ps->before->meta_item != NULL)
				break;
			ps->before->meta_item = item;

			if (ps->before->end_offset == strlen(ps->sentence)) {
				PgfExprProb *ep = gu_new(PgfExprProb, ps->pool);
				ep->expr = ps->meta_var;
				ep->prob = item->inside_prob;
				size_t n_args = gu_seq_length(item->args);
				for (size_t i = 0; i < n_args; i++) {
					PgfPArg* arg = gu_seq_index(item->args, PgfPArg, i);
					ep->prob -= arg->ccat->viterbi_prob;
				}
				pgf_parsing_complete(ps, item, ep);
			} else {
				prob_t meta_token_prob =
					ps->meta_token_prob;
				if (meta_token_prob != INFINITY) {
					pgf_parsing_meta_scan(ps, item, meta_token_prob);
				}

				pgf_parsing_meta_predict(ps, item);
			}
		} else {
			pgf_parsing_symbol(ps, item, item->curr_sym);
		}
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_parsing_set_default_factors(PgfParsing* ps, PgfAbstr* abstr)
{
	PgfFlag* flag;
	
	flag =
		gu_seq_binsearch(abstr->aflags, pgf_flag_order, PgfFlag, "heuristic_search_factor");
	if (flag != NULL) {
		GuVariantInfo pi = gu_variant_open(flag->value);
		gu_assert (pi.tag == PGF_LITERAL_FLT);
		ps->heuristic_factor = ((PgfLiteralFlt*) pi.data)->val;
	}

	flag =
		gu_seq_binsearch(abstr->aflags, pgf_flag_order, PgfFlag, "meta_prob");
	if (flag != NULL) {
		GuVariantInfo pi = gu_variant_open(flag->value);
		gu_assert (pi.tag == PGF_LITERAL_FLT);
		ps->meta_prob = - log(((PgfLiteralFlt*) pi.data)->val);
	}

	flag =
		gu_seq_binsearch(abstr->aflags, pgf_flag_order, PgfFlag, "meta_token_prob");
	if (flag != NULL) {
		GuVariantInfo pi = gu_variant_open(flag->value);
		gu_assert (pi.tag == PGF_LITERAL_FLT);
		ps->meta_token_prob = - log(((PgfLiteralFlt*) pi.data)->val);
	}
}

static PgfParsing*
pgf_new_parsing(PgfConcr* concr, GuString sentence,
                GuPool* pool, GuPool* out_pool)
{
	PgfParsing* ps = gu_new(PgfParsing, pool);
	ps->concr = concr;
	ps->pool = pool;
	ps->out_pool = out_pool;
	ps->sentence = sentence;
	ps->expr_queue = gu_new_buf(PgfExprState*, pool);
	ps->max_fid = concr->total_cats;
	ps->before = NULL;
	ps->after = NULL;
#ifdef PGF_COUNTS_DEBUG
	ps->item_full_count = 0;
	ps->item_real_count = 0;
	ps->cont_full_count = 0;
	ps->ccat_full_count = 0;
	ps->prod_full_count = 0;
#endif
	ps->prefix = NULL;
	ps->tp = NULL;
	ps->free_item = NULL;
	ps->heuristic_factor = 0;
	ps->meta_prob = INFINITY;
	ps->meta_token_prob = INFINITY;

	pgf_parsing_set_default_factors(ps, concr->abstr);

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
		for (size_t i = 0; i < ccat->n_synprods; i++) {
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
		if (ccat->prods == NULL)
			return;

		// Generation
		for (size_t i = 0; i < ccat->n_synprods; i++) {
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

// TODO: s/CId/Cat, add the cid to Cat, make Cat the key to CncCat
static PgfParsing*
pgf_parsing_init(PgfConcr* concr, PgfCId cat, size_t lin_idx, 
                 GuString sentence, double heuristic_factor,
                 GuExn* err,
                 GuPool* pool, GuPool* out_pool)
{
	PgfCncCat* cnccat =
		gu_map_get(concr->cnccats, cat, PgfCncCat*);
	if (!cnccat) {
		GuExnData* exn = gu_raise(err, PgfExn);
		exn->data = "Unknown start category";
		return NULL;
	}

	gu_assert(lin_idx < cnccat->n_lins);

	PgfParsing* ps =
		pgf_new_parsing(concr, sentence, pool, out_pool);

	if (heuristic_factor >= 0) {
		ps->heuristic_factor = heuristic_factor;
	}

	PgfParseState* state =
		pgf_new_parse_state(ps, 0, BIND_SOFT, 0);

	size_t n_ccats = gu_seq_length(cnccat->cats);
	for (size_t i = 0; i < n_ccats; i++) {
		PgfCCat* ccat = gu_seq_get(cnccat->cats, PgfCCat*, i);
		if (ccat != NULL) {
            if (ccat->prods == NULL) {
                // Empty category
                continue;
            }

			PgfItemConts* conts =
				pgf_parsing_get_conts(state, ccat, lin_idx, ps->pool);
            gu_buf_push(conts->items, PgfItem*, NULL);

#ifdef PGF_COUNTS_DEBUG
			ps->cont_full_count++;
#endif

            size_t n_prods = gu_seq_length(ccat->prods);
            for (size_t i = 0; i < n_prods; i++) {
                PgfProduction prod =
                    gu_seq_get(ccat->prods, PgfProduction, i);
                PgfItem* item = 
                    pgf_new_item(ps, conts, prod);
                gu_buf_heap_push(state->agenda, pgf_item_prob_order, &item);
            }

			if (ps->meta_prob != INFINITY) {
				PgfItem *item =
					pgf_new_item(ps, conts, ps->meta_prod);
				item->inside_prob =
					ps->meta_prob;
				gu_buf_heap_push(state->agenda, pgf_item_prob_order, &item);
			}
		}
	}

	return ps;
}

static bool
pgf_parsing_proceed(PgfParsing* ps)
{
	bool has_progress = false;

	prob_t best_prob = INFINITY;
	if (gu_buf_length(ps->expr_queue) > 0) {
		best_prob = gu_buf_get(ps->expr_queue, PgfExprState*, 0)->ep.prob;
	}

	prob_t delta_prob = 0;
	PgfParseState* st = ps->before;
	while (st != NULL) {
		if (gu_buf_length(st->agenda) > 0) {
			PgfItem* item = gu_buf_get(st->agenda, PgfItem*, 0);
			prob_t item_prob =
				item->inside_prob+item->conts->outside_prob+delta_prob;
			if (item_prob < best_prob) {
				best_prob = item_prob;

				while (st != ps->before) {
					PgfParseState* tmp = ps->before->next;
					ps->before->next = ps->after;
					ps->after = ps->before;
					ps->before = tmp;
				}
				
				has_progress = true;
			}
		}

		prob_t state_delta =
			(st->viterbi_prob-(st->next ? st->next->viterbi_prob : 0))*
			ps->heuristic_factor;
		delta_prob += state_delta;
		st = st->next;
	}

	if (has_progress) {
		PgfItem* item;
		gu_buf_heap_pop(ps->before->agenda, pgf_item_prob_order, &item);
		pgf_parsing_item(ps, item);
	}

	while (ps->after != NULL) {
		PgfParseState* tmp = ps->after->next;
		ps->after->next = ps->before;
		ps->before = ps->after;
		ps->after  = tmp;
	}

	return has_progress;
}

static PgfExprProb*
pgf_parse_result_next(PgfParsing* ps)
{
	for (;;) {
		while (pgf_parsing_proceed(ps));

		if (gu_buf_length(ps->expr_queue) == 0)
			break;

		PgfExprState* st;
		gu_buf_heap_pop(ps->expr_queue, &pgf_expr_state_order, &st);

#ifdef PGF_PARSER_DEBUG
#ifdef PGF_RESULT_DEBUG
		GuPool* tmp_pool = gu_new_pool();
		GuOut* out = gu_file_out(stderr, tmp_pool);
		GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
		GuExn* err = gu_exn(tmp_pool);
		pgf_print_expr_state0(st, wtr, err, tmp_pool);
		gu_pool_free(tmp_pool);
#endif
#endif

		if (st->arg_idx < gu_seq_length(st->args)) {
			PgfCCat* ccat =
				gu_seq_index(st->args, PgfPArg, st->arg_idx)->ccat;

			if (ccat->fid < ps->concr->total_cats) {
				st->ep.expr =
					gu_new_variant_i(ps->out_pool, 
					                 PGF_EXPR_APP, PgfExprApp,
									 .fun = st->ep.expr,
									 .arg = ps->meta_var);
				st->arg_idx++;
				gu_buf_heap_push(ps->expr_queue, &pgf_expr_state_order, &st);
			} else {
				pgf_result_predict(ps, st, ccat);
			}
		} else if (pgf_parse_result_is_new(st)) {
			gu_buf_push(st->answers->exprs, PgfExprProb*, &st->ep);

			size_t n_conts = gu_buf_length(st->answers->conts);
			for (size_t i = 0; i < n_conts; i++) {
				PgfExprState* st2 = gu_buf_get(st->answers->conts, PgfExprState*, i);
				
				if (st2 == NULL) {
					return &st->ep;
				}

				PgfExprState* st3 = gu_new(PgfExprState, ps->pool);
				st3->answers = st2->answers;
				st3->ep.expr =
					gu_new_variant_i(ps->out_pool,
					                 PGF_EXPR_APP, PgfExprApp,
							         .fun = st2->ep.expr,
							         .arg = st->ep.expr);
				st3->ep.prob = st2->ep.prob + st->ep.prob;
				st3->args = st2->args;
				st3->arg_idx = st2->arg_idx+1;

				gu_buf_heap_push(ps->expr_queue, &pgf_expr_state_order, &st3);
			}
		}
	}

	return NULL;
}

static void
pgf_parse_result_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfParsing* ps = gu_container(self, PgfParsing, en);
	*(PgfExprProb**)to = pgf_parse_result_next(ps);
}

static GuString
pgf_parsing_last_token(PgfParsing* ps, GuPool* pool)
{	
	if (ps->before == NULL)
		return "";

	size_t start = ps->before->end_offset;
	while (start > 0) {
		char c = ps->sentence[start-1];
		if (gu_is_space(c))
			break;
		start--;
	}

	size_t end = ps->before->end_offset;
	while (ps->sentence[end] != 0) {
		char c = ps->sentence[end];
		if (gu_is_space(c))
			break;
		end++;
	}

	char* tok = gu_malloc(pool, end-start+1);
	memcpy(tok, ps->sentence+start, (end-start));
	tok[end-start] = 0;
	return tok;
}

GuEnum*
pgf_parse(PgfConcr* concr, PgfCId cat, GuString sentence,
          GuExn* err, 
          GuPool* pool, GuPool* out_pool)
{
    return pgf_parse_with_heuristics(concr, cat, sentence, -1.0, err, pool, out_pool);
}

GuEnum*
pgf_parse_with_heuristics(PgfConcr* concr, PgfCId cat, GuString sentence,
                          double heuristics,
                          GuExn* err,
                          GuPool* pool, GuPool* out_pool)
{
	if (concr->sequences == NULL ||
	    concr->pre_sequences == NULL ||
	    concr->cnccats == NULL) {
		GuExnData* err_data = gu_raise(err, PgfExn);
		if (err_data) {
			err_data->data = "The concrete syntax is not loaded";
			return NULL;
		}
	}

	// Begin parsing a sentence with the specified category
	PgfParsing* ps =
		pgf_parsing_init(concr, cat, 0, sentence, heuristics, err, pool, out_pool);
	if (ps == NULL) {
		return NULL;
	}

#ifdef PGF_COUNTS_DEBUG
	pgf_parsing_print_counts(ps);
#endif

	while (gu_buf_length(ps->expr_queue) == 0) {
		if (!pgf_parsing_proceed(ps)) {
			GuExnData* exn = gu_raise(err, PgfParseError);
			exn->data = (void*) pgf_parsing_last_token(ps, exn->pool);
			return NULL;
		}

#ifdef PGF_COUNTS_DEBUG
		pgf_parsing_print_counts(ps);
#endif
	}

	// Now begin enumerating the resulting syntax trees
	ps->en.next = pgf_parse_result_enum_next;
	return &ps->en;
}

static void
pgf_parser_completions_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfParsing* ps =
		gu_container(self, PgfParsing, en);

	ps->tp = NULL;
	while (ps->tp == NULL) {
		if (!pgf_parsing_proceed(ps))
			break;
			
#ifdef PGF_COUNTS_DEBUG
		pgf_parsing_print_counts(ps);
#endif
	}

	*((PgfTokenProb**)to) = ps->tp;
}

GuEnum*
pgf_complete(PgfConcr* concr, PgfCId cat, GuString sentence, 
             GuString prefix, GuExn *err, GuPool* pool)
{
	if (concr->sequences == NULL ||
	    concr->pre_sequences == NULL ||
	    concr->cnccats == NULL) {
		GuExnData* err_data = gu_raise(err, PgfExn);
		if (err_data) {
			err_data->data = "The concrete syntax is not loaded";
			return NULL;
		}
	}

	// Begin parsing a sentence with the specified category
	PgfParsing* ps =
		pgf_parsing_init(concr, cat, 0, sentence, -1.0, err, pool, pool);
	if (ps == NULL) {
		return NULL;
	}

#ifdef PGF_COUNTS_DEBUG
	pgf_parsing_print_counts(ps);
#endif

	size_t len = strlen(ps->sentence);
	while (ps->before->end_offset < len) {
		if (!pgf_parsing_proceed(ps)) {
			GuExnData* exn = gu_raise(err, PgfParseError);
			exn->data = (void*) pgf_parsing_last_token(ps, exn->pool);
			return NULL;
		}

#ifdef PGF_COUNTS_DEBUG
		pgf_parsing_print_counts(ps);
#endif
	}

	// Now begin enumerating the completions
	ps->en.next = pgf_parser_completions_next;
	ps->prefix  = prefix;
	ps->tp      = NULL;
	return &ps->en;
}

static void
pgf_morpho_iter(PgfProductionIdx* idx,
                PgfMorphoCallback* callback,
                GuExn* err)
{
	size_t n_entries = gu_buf_length(idx);
	for (size_t i = 0; i < n_entries; i++) {
		PgfProductionIdxEntry* entry =
			gu_buf_index(idx, PgfProductionIdxEntry, i);

		PgfCId lemma = entry->papp->fun->absfun->name;
		GuString analysis = entry->ccat->cnccat->labels[entry->lin_idx];
		
		prob_t prob = entry->ccat->cnccat->abscat->prob +
		              entry->papp->fun->absfun->ep.prob;
		callback->callback(callback,
						   lemma, analysis, prob, err);
		if (!gu_ok(err))
			return;
	}
}

static int
pgf_sequence_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	GuString sent = (GuString) p1;
	const PgfSequence* sp2 = p2;

	BIND_TYPE bind = BIND_HARD;
	int res = pgf_symbols_cmp(&sent, strlen(sent), &bind, sp2->syms);
	if (res == 0 && *sent != 0) {
		res = 1;
	}

	return res;
}

static GuOrder pgf_sequence_order[1] = { { pgf_sequence_cmp_fn } };

void
pgf_lookup_morpho(PgfConcr *concr, GuString sentence,
                  PgfMorphoCallback* callback, GuExn* err)
{
	if (concr->sequences == NULL) {
		GuExnData* err_data = gu_raise(err, PgfExn);
		if (err_data) {
			err_data->data = "The concrete syntax is not loaded";
			return;
		}
	}

	PgfSequence* seq = (PgfSequence*)
		gu_seq_binsearch(concr->sequences, pgf_sequence_order,
		                 PgfSequence, (void*) sentence);

	if (seq != NULL && seq->idx != NULL)
		pgf_morpho_iter(seq->idx, callback, err);
}

typedef struct {
	GuEnum en;
	PgfSequences* sequences;
	GuString prefix;
	size_t seq_idx;
} PgfFullFormState;

struct PgfFullFormEntry {
	GuString tokens;
	PgfProductionIdx* idx;
};

static void
gu_fullform_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfFullFormState* st = gu_container(self, PgfFullFormState, en);
	PgfFullFormEntry* entry = NULL;

	if (st->sequences != NULL) {
		size_t n_seqs = gu_seq_length(st->sequences);
		while (st->seq_idx < n_seqs) {
			PgfSymbols* syms = gu_seq_index(st->sequences, PgfSequence, st->seq_idx)->syms;
			GuString tokens = pgf_get_tokens(syms, 0, pool);
			
			if (!gu_string_is_prefix(st->prefix, tokens)) {
				st->seq_idx = n_seqs;
				break;
			}
				
			if (strlen(tokens) > 0 &&
				gu_seq_index(st->sequences, PgfSequence, st->seq_idx)->idx != NULL) {
				entry = gu_new(PgfFullFormEntry, pool);
				entry->tokens = tokens;
				entry->idx    = gu_seq_index(st->sequences, PgfSequence, st->seq_idx)->idx;

				st->seq_idx++;
				break;
			}

			st->seq_idx++;
		}
	}

	*((PgfFullFormEntry**) to) = entry;
}

GuEnum*
pgf_fullform_lexicon(PgfConcr *concr, GuPool* pool)
{
	PgfFullFormState* st = gu_new(PgfFullFormState, pool);
	st->en.next   = gu_fullform_enum_next;
	st->sequences = concr->sequences;
	st->prefix    = "";
	st->seq_idx   = 0;
	return &st->en;
}

GuString
pgf_fullform_get_string(PgfFullFormEntry* entry)
{
	return entry->tokens;
}

void
pgf_fullform_get_analyses(PgfFullFormEntry* entry,
                          PgfMorphoCallback* callback, GuExn* err)
{
	pgf_morpho_iter(entry->idx, callback, err);
}

GuEnum*
pgf_lookup_word_prefix(PgfConcr *concr, GuString prefix,
                       GuPool* pool, GuExn* err)
{
	if (concr->sequences == NULL) {
		GuExnData* err_data = gu_raise(err, PgfExn);
		if (err_data) {
			err_data->data = "The concrete syntax is not loaded";
			return NULL;
		}
	}

	PgfFullFormState* state = gu_new(PgfFullFormState, pool);
	state->en.next   = gu_fullform_enum_next;
	state->sequences = concr->sequences;
	state->prefix    = prefix;
	state->seq_idx   = 0;

	if (!gu_seq_binsearch_index(concr->sequences, pgf_sequence_order,
	                            PgfSequence, (void*) prefix, 
	                            &state->seq_idx)) {
		state->seq_idx++;
	}

	return &state->en;
}

// The 'pre' construction needs a special handling since
// it cannot be sorted alphabetically (a single pre contains 
// many alternative tokens).
static GuBuf*
pgf_parser_index_pre_(GuBuf* buf, PgfSymbols* syms,
                      GuChoice* ch, GuPool *pool)
{
	size_t n_syms = gu_seq_length(syms);
	for (size_t i = 0; i < n_syms; i++) {
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, i);
		GuVariantInfo inf = gu_variant_open(sym);
		if (inf.tag == PGF_SYMBOL_KP) {
			PgfSymbolKP* skp = inf.data;

			if (buf == NULL) {
				// Since most of the sequences doesn't contain 'pre'
				// we create the buffer on demand. This minimizes
				// the overhead.
				buf = gu_new_buf(PgfSymbol, pool);
				gu_buf_extend_n(buf, i);
				for (size_t j = 0; j < i; j++) {
					PgfSymbol sym = gu_seq_get(syms, PgfSymbol, j);
					gu_buf_set(buf, PgfSymbol, j, sym);
				}
			}

			int idx = gu_choice_next(ch, skp->n_forms+1);
			if (idx == 0) {
				buf = pgf_parser_index_pre_(buf, skp->default_form, ch, pool);
			} else {
				buf = pgf_parser_index_pre_(buf, skp->forms[idx-1].form, ch, pool);
			}
		} else {
			if (buf != NULL) {
				gu_buf_push(buf, PgfSymbol, sym);
			}
		}
	}

	return buf;
}

static void 
pgf_parser_index_pre(PgfConcr* concr, PgfSequence* seq, 
                     GuChoice* ch, GuPool *pool)
{
	do {
		GuChoiceMark mark = gu_choice_mark(ch);

		GuBuf* buf =
			pgf_parser_index_pre_(NULL, seq->syms, ch, pool);

		if (buf != NULL) {
			PgfSequence* pre_seq = gu_buf_extend(concr->pre_sequences);
			pre_seq->syms = gu_buf_data_seq(buf);
			pre_seq->idx  = seq->idx;
		}

		gu_choice_reset(ch, mark);
	} while (gu_choice_advance(ch));	
}

void
pgf_parser_index(PgfConcr* concr, 
                 PgfCCat* ccat, PgfProduction prod,
                 GuPool *pool)
{
	GuVariantInfo i = gu_variant_open(prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;

		if (gu_seq_length(papp->args) > 0)
			break;

		GuPool* tmp_pool = gu_local_pool();
		GuChoice* choice = gu_new_choice(tmp_pool); // we need this for the pres

		for (size_t lin_idx = 0; lin_idx < papp->fun->n_lins; lin_idx++) {
			PgfSequence* seq = papp->fun->lins[lin_idx];
			if (seq->idx == NULL) {
				seq->idx = gu_new_buf(PgfProductionIdxEntry, pool);
				pgf_parser_index_pre(concr, seq, choice, pool);
			}

			size_t i = gu_buf_length(seq->idx);
			while (i > 0) {
				PgfProductionIdxEntry* entry =
					gu_buf_index(seq->idx, PgfProductionIdxEntry, i-1);

				if (entry->ccat->fid < ccat->fid)
					break;
				if (entry->lin_idx <= lin_idx)
					break;

				i--;
			}

			PgfProductionIdxEntry* entry = gu_buf_insert(seq->idx, i);
			entry->ccat    = ccat;
			entry->lin_idx = lin_idx;
			entry->papp    = papp;
		}
		
		gu_pool_free(tmp_pool);
		break;
	}
	case PGF_PRODUCTION_COERCE:
		// Nothing to be done here
		break;
	default:
		gu_impossible();
	}
}

prob_t
pgf_ccat_set_viterbi_prob(PgfCCat* ccat) {
	if (ccat->fid < 0)
		return 0;
	
	if (ccat->viterbi_prob == 0) {       // uninitialized
		ccat->viterbi_prob = INFINITY;   // set to infinity to avoid loops

		if (ccat->prods == NULL)
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
