#include <pgf/parser.h>
#include <gu/choice.h>
#include <gu/seq.h>
#include <gu/assert.h>
#include <gu/log.h>
#include <gu/file.h>
#include <math.h>
#include <stdlib.h>

typedef struct PgfItem PgfItem;

typedef GuBuf PgfItemBuf;
typedef GuList(PgfItemBuf*) PgfItemBufs;

typedef GuBuf PgfCCatBuf;

struct PgfParse {
	PgfConcr* concr;
    PgfItemBuf* agenda;
    int max_fid;
};

typedef struct {
	PgfExprProb ep;
	PgfPArgs args;
	size_t arg_idx;
} PgfExprState;

typedef GuMap PgfExprCache;
static GU_DEFINE_TYPE(PgfExprCache, GuMap,
		              gu_type(PgfCCat), NULL,
		              gu_ptr_type(PgfExprProb), &gu_null_struct);

typedef struct PgfParseResult PgfParseResult;

struct PgfParseResult {
    PgfConcr* concr;
	PgfCCatBuf* completed;
	GuChoice* choice;
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
	PgfItemBase* base;
	PgfPArgs args;
	PgfSymbol curr_sym;
	uint16_t seq_idx;
	uint8_t tok_idx;
	uint8_t alt;
};

typedef struct {
	int fid;
	int lin_idx;
} PgfCFCat;

static GU_DEFINE_TYPE(PgfCFCat, struct,
	       GU_MEMBER(PgfCFCat, fid, int),
           GU_MEMBER(PgfCFCat, lin_idx, int));

extern GuHasher pgf_cfcat_hasher;

static GU_DEFINE_TYPE(PgfItemBuf, abstract, _);
static GU_DEFINE_TYPE(PgfItemBufs, abstract, _);

typedef GuMap PgfContsMap;
GU_DEFINE_TYPE(PgfContsMap, GuMap,
		      gu_type(PgfCCat), NULL,
		      gu_ptr_type(PgfItemBufs), &gu_null_struct);

typedef GuMap PgfEpsilonIdx;
GU_DEFINE_TYPE(PgfEpsilonIdx, GuMap,
		      gu_type(PgfCFCat), &pgf_cfcat_hasher,
		      gu_ptr_type(PgfCCat), &gu_null_struct);

typedef GuMap PgfGenCatMap;
GU_DEFINE_TYPE(PgfGenCatMap, GuMap,
		      gu_type(PgfItemBuf), NULL,
		      gu_ptr_type(PgfCCat), &gu_null_struct);

// GuString -> PgfItemBuf*			 
typedef GuStringMap PgfTransitions;
GU_DEFINE_TYPE(PgfTransitions, GuStringMap,
		      gu_ptr_type(PgfItemBuf), &gu_null_struct);

typedef struct PgfParsing PgfParsing;

typedef struct {
	PgfTokens tokens;
	PgfExprProb ep;
} PgfLiteralCandidate;

typedef const struct PgfLexCallback PgfLexCallback;

struct PgfLexCallback {
	void (*lex)(PgfLexCallback* self, PgfToken tok, PgfItem* item);
	GuEnum *(*lit)(PgfLexCallback* self, PgfCCat* cat);
};

struct PgfParsing {
	GuPool* pool;
    GuPool* tmp_pool;
	PgfContsMap* conts_map;
	PgfGenCatMap* generated_cats;
	PgfCCatBuf* completed;
    PgfLexCallback* callback;
    PgfItemBuf *lexicon_idx;
    PgfEpsilonIdx *epsilon_idx;
    PgfItemBuf *metas;
    int max_fid;
};

#ifdef PGF_PARSER_DEBUG
static void
pgf_print_production(int fid, PgfProduction prod, GuWriter *wtr, GuExn* err)
{
    gu_printf(wtr,err,"C%d -> ",fid);
       
    GuVariantInfo i = gu_variant_open(prod);
    switch (i.tag) {
    case PGF_PRODUCTION_APPLY: {
        PgfProductionApply* papp = i.data;
        gu_printf(wtr,err,"F%d(",papp->fun->funid);
        pgf_print_expr(papp->fun->ep->expr, 0, wtr, err);
        gu_printf(wtr,err,")[");
        size_t n_args = gu_seq_length(papp->args);
        for (size_t j = 0; j < n_args; j++) {
            if (j > 0)
                gu_putc(',',wtr,err);
                    
            PgfPArg arg = gu_seq_get(papp->args, PgfPArg, j);

            if (arg.hypos != NULL) {
                size_t n_hypos = gu_list_length(arg.hypos);
                for (size_t k = 0; k < n_hypos; k++) {
                    if (k > 0)
                        gu_putc(' ',wtr,err);
                    PgfCCat *hypo = gu_list_index(arg.hypos, k);
                    gu_printf(wtr,err,"C%d",hypo->fid);
                }
            }
            
            gu_printf(wtr,err,"C%d",arg.ccat->fid);
        }
        gu_printf(wtr,err,"]\n");
        break;
    }
    case PGF_PRODUCTION_COERCE: {
        PgfProductionCoerce* pcoerce = i.data;
        gu_printf(wtr,err,"_[C%d]\n",pcoerce->coerce->fid);
        break;
    }
    case PGF_PRODUCTION_META: {
        PgfProductionMeta* pmeta = i.data;
        gu_printf(wtr,err,"?[");
        size_t n_args = gu_seq_length(pmeta->args);
        for (size_t j = 0; j < n_args; j++) {
            if (j > 0)
                gu_putc(',',wtr,err);
                    
            PgfCCat *arg = gu_seq_get(pmeta->args, PgfCCat*, j);            
            gu_printf(wtr,err,"C%d",arg->fid);
        }
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
pgf_print_item(PgfItem* item, GuWriter* wtr, GuExn* err)
{
    gu_printf(wtr, err, "[C%d -> ",item->base->ccat->fid);

	GuVariantInfo i = gu_variant_open(item->base->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
        PgfCncFun* fun = papp->fun;
        gu_printf(wtr, err, "F%d(", fun->funid);
        pgf_print_expr(fun->ep->expr, 0, wtr, err);
        gu_printf(wtr, err, ")[");
		for (size_t i = 0; i < gu_seq_length(item->args); i++) {
            PgfPArg arg = gu_seq_get(item->args, PgfPArg, i);
            gu_printf(wtr, err,
                      ((i < gu_seq_length(item->args)-1) ? "C%d," : "C%d"),
                      arg.ccat->fid);
        }
        gu_printf(wtr, err, "]; %d : ",item->base->lin_idx);
		PgfSequence seq = fun->lins[item->base->lin_idx];
		for (size_t i = 0; i < gu_seq_length(seq); i++) {
            if (i == item->seq_idx)
                gu_printf(wtr, err, " . ");
            
            PgfSymbol *sym = gu_seq_index(seq, PgfSymbol, i);
            pgf_print_symbol(*sym, wtr, err);
        }
        if (item->seq_idx == gu_seq_length(seq))
            gu_printf(wtr, err, " .");
		break;
	}
	case PGF_PRODUCTION_COERCE: {
        gu_printf(wtr, err, "_[C%d]; %d : ",
            gu_seq_index(item->args, PgfPArg, 0)->ccat->fid,
            item->base->lin_idx);
        if (item->seq_idx == 0)
            gu_printf(wtr, err, ". ");
        gu_printf(wtr, err, "<0,%d>", item->base->lin_idx);
        if (item->seq_idx == 1)
            gu_printf(wtr, err, " .");
		break;
	}
	case PGF_PRODUCTION_META: {
        gu_printf(wtr, err, "?[");
		for (size_t i = 0; i < gu_seq_length(item->args); i++) {
            PgfPArg arg = gu_seq_get(item->args, PgfPArg, i);
            gu_printf(wtr, err,
                      ((i < gu_seq_length(item->args)-1) ? "C%d," : "C%d"),
                      arg.ccat->fid);
        }
        gu_printf(wtr, err, "]; %d : %d",item->base->lin_idx, item->seq_idx);
		break;
	}
	default:
		gu_impossible();
	}
    
    gu_printf(wtr, err, "]\n");
}
#endif

static void
pgf_parsing_add_transition(PgfParsing* parsing, PgfToken tok, PgfItem* item)
{
    parsing->callback->lex(parsing->callback, tok, item);
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
                      PgfCCat* ccat, size_t lin_idx)
{
	gu_require(lin_idx < ccat->cnccat->n_lins);
	PgfItemBufs* contss = gu_map_get(conts_map, ccat, PgfItemBufs*);
	if (contss == NULL)
		return false;

	return (gu_list_index(contss, lin_idx) != NULL);
}

static PgfCCat*
pgf_parsing_create_completed(PgfParsing* parsing, PgfItemBuf* conts, 
			     PgfCncCat* cnccat)
{
	PgfCCat* cat = gu_new(PgfCCat, parsing->pool);
	cat->cnccat = cnccat;
	cat->fid = parsing->max_fid++;
	cat->prods = gu_buf_seq(gu_new_buf(PgfProduction, parsing->pool));
	cat->n_synprods = 0;
	gu_map_put(parsing->generated_cats, conts, PgfCCat*, cat);
	return cat;
}

static PgfCCat*
pgf_parsing_get_completed(PgfParsing* parsing, PgfItemBuf* conts)
{
	return gu_map_get(parsing->generated_cats, conts, PgfCCat*);
}

static PgfSymbol
pgf_item_base_symbol(PgfItemBase* ibase, size_t seq_idx, GuPool* pool)
{
	GuVariantInfo i = gu_variant_open(ibase->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
		PgfCncFun* fun = papp->fun;
		gu_assert(ibase->lin_idx < fun->n_lins);
		PgfSequence seq = fun->lins[ibase->lin_idx];
		gu_assert(seq_idx <= gu_seq_length(seq));
		if (seq_idx == gu_seq_length(seq)) {
			return gu_null_variant;
		} else {
			return gu_seq_get(seq, PgfSymbol, seq_idx);
		}
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		gu_assert(seq_idx <= 1);
		if (seq_idx == 1) {
			return gu_null_variant;
		} else {
			return gu_new_variant_i(pool, PGF_SYMBOL_CAT,
						PgfSymbolCat,
						.d = 0, .r = ibase->lin_idx);
		}
		break;
	}
	case PGF_PRODUCTION_META: {
		return gu_null_variant;
	}
	default:
		gu_impossible();
	}
	return gu_null_variant;
}

static PgfItem*
pgf_new_item(PgfCCat* ccat, size_t lin_idx,
		       PgfProduction prod, PgfItemBuf* conts, GuPool* pool)
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
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = pi.data;
		item->args = gu_new_seq(PgfPArg, 1, pool);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, 0);
		parg->hypos = NULL;
		parg->ccat = pcoerce->coerce;
		break;
	}
	case PGF_PRODUCTION_META: {
		PgfProductionMeta* pmeta = pi.data;
		item->args = pmeta->args;
		break;
	}
	default:
		gu_impossible();
	}
	item->base = base;
	item->curr_sym = pgf_item_base_symbol(item->base, 0, pool);
	item->seq_idx = 0;
	item->tok_idx = 0;
	item->alt = 0;
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
pgf_item_update_arg(PgfItem* item, size_t d, PgfCCat *ccat, GuPool* pool)
{
	PgfItem* new_item = pgf_item_copy(item, pool);
	size_t nargs = gu_seq_length(item->args);
	new_item->args = gu_new_seq(PgfPArg, nargs, pool);
	memcpy(gu_seq_data(new_item->args), gu_seq_data(item->args),
	       nargs * sizeof(PgfPArg));
	gu_seq_set(new_item->args, PgfPArg, d,
		   ((PgfPArg) { .hypos = NULL, .ccat = ccat }));
		   
	return new_item;
}

static void
pgf_item_advance(PgfItem* item, GuPool* pool)
{
	item->seq_idx++;
	item->curr_sym = pgf_item_base_symbol(item->base, item->seq_idx, pool);
}

static void
pgf_parsing_item(PgfParsing* parsing, PgfItem* item);

static void
pgf_parsing_combine(PgfParsing* parsing, PgfItem* cont, PgfCCat* cat)
{
	if (cont == NULL) {
		gu_buf_push(parsing->completed, PgfCCat*, cat);
		return;
	}

	PgfItem* item = NULL;

	if (!gu_variant_is_null(cont->curr_sym)) {
		switch (gu_variant_tag(cont->curr_sym)) {
		case PGF_SYMBOL_CAT: {
			PgfSymbolCat* scat = gu_variant_data(cont->curr_sym);
			item = pgf_item_update_arg(cont, scat->d, cat, parsing->pool);
			break;
		}
		case PGF_SYMBOL_LIT: {
			PgfSymbolLit* slit = gu_variant_data(cont->curr_sym);
			item = pgf_item_update_arg(cont, slit->d, cat, parsing->pool);
			break;
		}
		default:
			gu_impossible();
		}
	} else {		
		item = pgf_item_copy(cont, parsing->pool);
		size_t nargs = gu_seq_length(cont->args);
		item->args = gu_new_seq(PgfPArg, nargs+1, parsing->pool);
		memcpy(gu_seq_data(item->args), gu_seq_data(cont->args),
			   nargs * sizeof(PgfPArg));
		gu_seq_set(item->args, PgfPArg, nargs,
		     ((PgfPArg) { .hypos = NULL, .ccat = cat }));
	}
	
	pgf_item_advance(item, parsing->pool);
	pgf_parsing_item(parsing, item);
}

static void
pgf_parsing_production(PgfParsing* parsing, PgfCCat* ccat, size_t lin_idx,
		       PgfProduction prod, PgfItemBuf* conts)
{
	PgfItem* item =
        pgf_new_item(ccat, lin_idx, prod, conts, parsing->pool);
	pgf_parsing_item(parsing, item);
}

static PgfProduction
pgf_parsing_new_production(PgfItem* item, GuPool *pool)
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
	case PGF_PRODUCTION_META: {
		PgfProductionMeta* new_pmeta = 
			gu_new_variant(PGF_PRODUCTION_META,
				       PgfProductionMeta,
				       &prod, pool);
		new_pmeta->args = item->args;
		break;
	}
	default:
		gu_impossible();
	}
	
	return prod;
}

static void
pgf_parsing_complete(PgfParsing* parsing, PgfItem* item)
{
	PgfProduction prod =
		pgf_parsing_new_production(item, parsing->pool);

	PgfItemBuf* conts = item->base->conts;
	PgfCCat* tmp_cat = pgf_parsing_get_completed(parsing, conts);
    PgfCCat* cat = tmp_cat;
    if (cat == NULL) {
        cat = pgf_parsing_create_completed(parsing, conts,
						   item->base->ccat->cnccat);
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
		gu_printf(wtr, err, "[C%d; %d; C%d]\n",
                            item->base->ccat->fid, 
                            item->base->lin_idx, 
                            cat->fid);
    pgf_print_production(cat->fid, prod, wtr, err);
    gu_pool_free(tmp_pool);
#endif

	if (tmp_cat != NULL) {
		// The category has already been created. If it has also been
		// predicted already, then process a new item for this production.
		PgfItemBufs* contss = 
			pgf_parsing_get_contss(parsing->conts_map, cat, 
			                       parsing->tmp_pool);
		size_t n_contss = gu_list_length(contss);
		for (size_t i = 0; i < n_contss; i++) {
			PgfItemBuf* conts2 = gu_list_index(contss, i);
			/* If there are continuations for
			 * linearization index i, then (cat, i) has
			 * already been predicted. Add the new
			 * production immediately to the agenda,
			 * i.e. process it. */
			if (conts2) {
				pgf_parsing_production(parsing, cat, i,
						       prod, conts2);
			}
		}
	} else {
		size_t n_conts = gu_buf_length(conts);
		for (size_t i = 0; i < n_conts; i++) {
			PgfItem* cont = gu_buf_get(conts, PgfItem*, i);
			pgf_parsing_combine(parsing, cont, cat);
		}
    }
}

static void
pgf_parsing_td_predict(PgfParsing* parsing, PgfItem* item, 
		    PgfCCat* ccat, size_t lin_idx)
{
	gu_enter("-> cat: %d", ccat->fid);
	if (gu_seq_is_null(ccat->prods)) {
		// Empty category
		return;
	}
	PgfItemBuf* conts = 
		pgf_parsing_get_conts(parsing->conts_map, ccat, lin_idx, 
		                       parsing->pool, parsing->tmp_pool);
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
			pgf_parsing_production(parsing, ccat, lin_idx, 
					       prod, conts);
		}

		// Bottom-up prediction for lexical rules
		if (parsing->lexicon_idx != NULL) {
			size_t n_items = gu_buf_length(parsing->lexicon_idx);
			for (size_t i = 0; i < n_items; i++) {
				PgfItem* item = gu_buf_get(parsing->lexicon_idx, PgfItem*, i);
			
				if (item->base->ccat == ccat && 
				    item->base->lin_idx == lin_idx &&
				    gu_seq_length(item->args) == 0) {
					pgf_parsing_production(parsing, ccat, lin_idx,
								           item->base->prod, conts);
				}
			}
		}

		// Bottom-up prediction for epsilon rules
		PgfCFCat cfc = {ccat->fid, lin_idx};
		PgfCCat* eps_ccat = gu_map_get(parsing->epsilon_idx, &cfc, PgfCCat*);

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
						pgf_parsing_production(parsing, ccat, lin_idx,
							prod, conts);
					}
					break;
				}
				}
			}
		}
	} else {
		/* If it has already been completed, combine. */
		PgfCCat* completed = 
			pgf_parsing_get_completed(parsing, conts);
		if (completed) {
			pgf_parsing_combine(parsing, item, completed);
		}
	}
	gu_exit(NULL);
}

static void
pgf_parsing_bu_predict(PgfParsing* parsing, PgfItem* item, 
            PgfItemBuf *agenda)
{
	PgfItemBuf* conts =
		pgf_parsing_get_conts(parsing->conts_map,
							  item->base->ccat, item->base->lin_idx,
							  parsing->pool, parsing->tmp_pool);

	PgfItem* copy = pgf_item_copy(item, parsing->pool);
	copy->base = pgf_item_base_copy(item->base, parsing->pool);
	copy->base->conts = conts;
	gu_buf_push(agenda, PgfItem*, copy);

	if (gu_buf_length(conts) == 0) {
		size_t n_items;

		n_items = gu_buf_length(item->base->conts);
		for (size_t i = 0; i < n_items; i++) {
			PgfItem *item_ = gu_buf_get(item->base->conts, PgfItem*, i);
			pgf_parsing_bu_predict(parsing, item_, conts);
		}

		n_items = gu_buf_length(parsing->metas);
		for (size_t i = 0; i < n_items; i++) {
			PgfItem *item_ = gu_buf_get(parsing->metas, PgfItem*, i);
			gu_buf_push(conts, PgfItem*, item_);
		}
	}

#ifdef PGF_PARSER_DEBUG
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    pgf_print_item(copy, wtr, err);
    gu_pool_free(tmp_pool);
#endif
}

static void
pgf_parsing_symbol(PgfParsing* parsing, PgfItem* item, PgfSymbol sym) {
	switch (gu_variant_tag(sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(sym);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, scat->d);
		gu_assert(!parg->hypos || !parg->hypos->len);
		pgf_parsing_td_predict(parsing, item, parg->ccat, scat->r);
		break;
	}
	case PGF_SYMBOL_KS: {
		PgfSymbolKS* sks = gu_variant_data(sym);
		gu_assert(item->tok_idx < gu_seq_length(sks->tokens));
		PgfToken tok = 
			gu_seq_get(sks->tokens, PgfToken, item->tok_idx++);
        if (item->tok_idx == gu_seq_length(sks->tokens)) {
            item->tok_idx = 0;
            pgf_item_advance(item, parsing->pool);
        }
		pgf_parsing_add_transition(parsing, tok, item);
		break;
	}
	case PGF_SYMBOL_KP: {
		PgfSymbolKP* skp = gu_variant_data(sym);
		size_t idx = item->tok_idx;
		uint8_t alt = item->alt;
		gu_assert(idx < gu_seq_length(skp->default_form));
		if (idx == 0) {
            PgfToken tok;
            PgfItem* new_item;
            
			tok = gu_seq_get(skp->default_form, PgfToken, 0);
            new_item = pgf_item_copy(item, parsing->pool);
            new_item->tok_idx++;
            if (new_item->tok_idx == gu_seq_length(skp->default_form)) {
                new_item->tok_idx = 0;
                pgf_item_advance(new_item, parsing->pool);
            }
            pgf_parsing_add_transition(parsing, tok, new_item);

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
                    new_item = pgf_item_copy(item, parsing->pool);
                    new_item->tok_idx++;
                    new_item->alt = i;
                    if (new_item->tok_idx == gu_seq_length(toks)) {
                        new_item->tok_idx = 0;
                        pgf_item_advance(new_item, parsing->pool);
                    }
                    pgf_parsing_add_transition(parsing, tok, new_item);
				}
			}
		} else if (alt == 0) {
			PgfToken tok =
				gu_seq_get(skp->default_form, PgfToken, idx);
            item->tok_idx++;
            if (item->tok_idx == gu_seq_length(skp->default_form)) {
                item->tok_idx = 0;
                pgf_item_advance(item, parsing->pool);
            }
			pgf_parsing_add_transition(parsing, tok, item);
		} else {
			gu_assert(alt <= skp->n_forms);
            PgfTokens toks = skp->forms[alt - 1].form;
			PgfToken tok = gu_seq_get(toks, PgfToken, idx);
            item->tok_idx++;
            if (item->tok_idx == gu_seq_length(toks)) {
                item->tok_idx = 0;
                pgf_item_advance(item, parsing->pool);
            }
			pgf_parsing_add_transition(parsing, tok, item);
		}
		break;
	}
	case PGF_SYMBOL_LIT: {
		PgfSymbolLit* slit = gu_variant_data(sym);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, slit->d);

		PgfCncCat *cnccat = parg->ccat->cnccat;

		// the linearization category must be {s : Str}
		gu_assert(cnccat->n_lins == 1);
		gu_assert(gu_list_length(cnccat->cats) == 1);

		PgfItemBuf* conts = 
			pgf_parsing_get_conts(parsing->conts_map, 
			                      parg->ccat, slit->r, 
		                          parsing->pool, parsing->tmp_pool);
		gu_buf_push(conts, PgfItem*, item);
		if (gu_buf_length(conts) == 1) {
			/* This is the first time when we encounter this 
			 * literal category so we must call the callback */
		 
			GuEnum* en = parsing->callback->lit(parsing->callback, parg->ccat);
			for (;;) {
				PgfLiteralCandidate* candidate =
					gu_next(en, PgfLiteralCandidate*, parsing->pool);
				if (candidate == NULL)
					break;

				PgfSymbol sym = gu_null_variant;
				PgfSymbolKS* sks =
					gu_new_variant(PGF_SYMBOL_KS,
					               PgfSymbolKS,
					               &sym, parsing->pool);
				sks->tokens = candidate->tokens;

				PgfSequence seq = gu_new_seq(PgfSymbol, 1, parsing->pool);
				gu_seq_set(seq, PgfSymbol, 0, sym);

				PgfCncFun* fun = 
					gu_malloc(parsing->pool, 
							  sizeof(PgfCncFun)+
							  sizeof(PgfSequence*)*cnccat->n_lins);
				fun->name    = gu_empty_string;
				fun->ep      = &candidate->ep;
				fun->funid   = -1;
				fun->n_lins  = cnccat->n_lins;
				fun->lins[0] = seq;

				PgfProduction prod;
				PgfProductionApply* papp =
					gu_new_variant(PGF_PRODUCTION_APPLY,
								   PgfProductionApply,
								   &prod, parsing->pool);
				papp->fun  = fun;
				papp->args = gu_new_seq(PgfPArg, 0, parsing->pool);

				pgf_parsing_production(parsing, parg->ccat, slit->r, 
							           prod, conts);
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
pgf_parsing_item(PgfParsing* parsing, PgfItem* item)
{
#ifdef PGF_PARSER_DEBUG
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    pgf_print_item(item, wtr, err);
    gu_pool_free(tmp_pool);
#endif

	GuVariantInfo i = gu_variant_open(item->base->prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
		PgfCncFun* fun = papp->fun;
		PgfSequence seq = fun->lins[item->base->lin_idx];
		if (item->seq_idx == gu_seq_length(seq)) {
			pgf_parsing_complete(parsing, item);
		} else  {
			PgfSymbol sym = 
				gu_seq_get(seq, PgfSymbol, item->seq_idx);
			pgf_parsing_symbol(parsing, item, sym);
		}
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = i.data;
		switch (item->seq_idx) {
		case 0:
			pgf_parsing_td_predict(parsing, item, 
					    pcoerce->coerce,
					    item->base->lin_idx);
			break;
		case 1:
			pgf_parsing_complete(parsing, item);
			break;
		default:
			gu_impossible();
		}
		break;
	}
	case PGF_PRODUCTION_META: {
		pgf_parsing_complete(parsing, item);
		gu_buf_push(parsing->metas, PgfItem*, item);
		break;
	}
	default:
		gu_impossible();
	}
}

static PgfParsing*
pgf_new_parsing(PgfConcr* concr, PgfLexCallback* callback, int max_fid, 
                GuPool* parse_pool, GuPool* out_pool)
{
	PgfParsing* parsing = gu_new(PgfParsing, out_pool);
	parsing->generated_cats = gu_map_type_new(PgfGenCatMap, out_pool);
	parsing->conts_map = gu_map_type_new(PgfContsMap, out_pool);
	parsing->completed = gu_new_buf(PgfCCat*, parse_pool);
    parsing->callback = callback;
    parsing->lexicon_idx = NULL;
    parsing->epsilon_idx = concr->epsilon_idx;
	parsing->pool = parse_pool;
    parsing->tmp_pool = out_pool;
    parsing->metas = gu_new_buf(PgfItem*, out_pool);
    parsing->max_fid = max_fid;
	return parsing;
}

static PgfParse*
pgf_new_parse(PgfConcr* concr, int max_fid, GuPool* pool)
{
	PgfParse* parse = gu_new(PgfParse, pool);
	parse->concr = concr;
    parse->agenda = NULL;
    parse->max_fid = max_fid;
	return parse;
}

static void
pgf_lex_noop(PgfLexCallback* self, PgfToken tok, PgfItem* item)
{
}

static void
pgf_enum_null(GuEnum* self, void* to, GuPool* pool)
{
	*((PgfLiteralCandidate**) to) = NULL;
}

static GuEnum*
pgf_lit_noop(PgfLexCallback* self, PgfCCat* ccat)
{
	static GuEnum en = { pgf_enum_null };
	return &en;
}

typedef struct {
    PgfLexCallback fn;
    PgfToken tok;
    PgfItemBuf* agenda;
    GuPool *pool;
} PgfParseTokenCallback;

static void 
pgf_match_token(PgfLexCallback* self, PgfToken tok, PgfItem* item)
{
    PgfParseTokenCallback *clo = (PgfParseTokenCallback *) self;

    if (gu_string_eq(tok, clo->tok)) {
        gu_buf_push(clo->agenda, PgfItem*, item);
    }
}

typedef struct {
	GuEnum en;
	PgfLiteralCandidate candidate;
	size_t idx;
} PgfLitEnum;

static void
pgf_enum_lits(GuEnum* self, void* to, GuPool* pool)
{
	PgfLitEnum* en = (PgfLitEnum*) self;

	*((PgfLiteralCandidate**) to) = 
		(en->idx++ > 0) ? NULL : &en->candidate;
}

static GuEnum*
pgf_match_lit(PgfLexCallback* self, PgfCCat* ccat)
{
	PgfParseTokenCallback *clo = (PgfParseTokenCallback *) self;
					   
	PgfLiteral lit;

	switch (ccat->fid) {
	case -1: {
		PgfLiteralStr *lit_str =
			gu_new_variant(PGF_LITERAL_STR,
			               PgfLiteralStr,
			               &lit, clo->pool);
		lit_str->val = clo->tok;
		break;
	}
	case -2: {
		PgfLiteralInt *lit_int =
			gu_new_variant(PGF_LITERAL_INT,
			               PgfLiteralInt,
			               &lit, clo->pool);
		if (!gu_string_to_int(clo->tok, &lit_int->val))
			return pgf_lit_noop(self, ccat);
		break;
	}
	case -3: {
		PgfLiteralFlt *lit_flt =
			gu_new_variant(PGF_LITERAL_FLT,
			               PgfLiteralFlt,
			               &lit, clo->pool);
		if (!gu_string_to_double(clo->tok, &lit_flt->val))
			return pgf_lit_noop(self, ccat);
		break;
	}
	default:
		gu_impossible();
	}

	PgfTokens tokens = gu_new_seq(PgfToken, 1, clo->pool);
	gu_seq_set(tokens, PgfToken, 0, clo->tok);

	PgfExpr expr = gu_null_variant;
	PgfExprLit *expr_lit =
		gu_new_variant(PGF_EXPR_LIT,
					   PgfExprLit,
					   &expr, clo->pool);
	expr_lit->lit = lit;

	PgfLitEnum* en = gu_new(PgfLitEnum, clo->pool);
	en->en.next = pgf_enum_lits;
	en->candidate.tokens  = tokens;
	en->candidate.ep.prob = INFINITY; 
	en->candidate.ep.expr = expr;
	en->idx = 0;

	return &en->en;
}

typedef struct {
	GuMapItor fn;
	PgfProduction prod;
	PgfItemBuf *metas;
	GuPool *pool;
} PgfGetMetaFn;

void
pgf_parsing_get_metas(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfGetMetaFn* clo = (PgfGetMetaFn*) fn;
    PgfCCat *ccat = (PgfCCat *) key;
    PgfItemBufs* contss  = *((PgfItemBufs **) value);
    PgfProduction prod = clo->prod;
    PgfItemBuf *metas = clo->metas;
    GuPool *pool = clo->pool;

	size_t n_lins = gu_list_length(contss);
	for (size_t lin_idx = 0; lin_idx < n_lins; lin_idx++) {
		PgfItemBuf* conts = gu_list_index(contss, lin_idx);

		if (conts != NULL) {
			PgfItem *item =
				pgf_new_item(ccat, lin_idx, prod, conts, pool);
			gu_buf_push(metas, PgfItem*, item);
			
#ifdef PGF_PARSER_DEBUG
			GuPool* tmp_pool = gu_new_pool();
			GuOut* out = gu_file_out(stderr, tmp_pool);
			GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
			GuExn* err = gu_exn(NULL, type, tmp_pool);
			pgf_print_item(item, wtr, err);
			gu_pool_free(tmp_pool);
#endif
		}
	}
}

PgfParse*
pgf_parse_token(PgfParse* parse, PgfToken tok, bool robust, GuPool* pool)
{
    PgfItemBuf* agenda = gu_new_buf(PgfItem*, pool);

    PgfParseTokenCallback clo1 = {{ pgf_match_token, pgf_match_lit }, 
                                  tok, agenda, pool};

	GuPool* tmp_pool = gu_new_pool();
	PgfParsing* parsing = pgf_new_parsing(parse->concr, &clo1.fn, parse->max_fid, pool, tmp_pool);
	parsing->lexicon_idx = gu_map_get(parse->concr->lexicon_idx, &tok, GuBuf*);

	size_t n_items = gu_buf_length(parse->agenda);
	for (size_t i = 0; i < n_items; i++) {
		PgfItem* item = gu_buf_get(parse->agenda, PgfItem*, i);
        pgf_parsing_item(parsing, item);
	}

	if (robust) {
		PgfProduction prod;
		PgfProductionMeta* pmeta =
			gu_new_variant(PGF_PRODUCTION_META,
						   PgfProductionMeta,
						   &prod, parsing->pool);
		pmeta->args = gu_new_seq(PgfPArg, 0, parsing->pool);

		PgfGetMetaFn clo2 = { { pgf_parsing_get_metas }, prod, parsing->metas, pool };
		gu_map_iter(parsing->conts_map, &clo2.fn, NULL);

		if (parsing->lexicon_idx != NULL) {
			size_t n_items = gu_buf_length(parsing->lexicon_idx);
			for (size_t i = 0; i < n_items; i++) {
				PgfItem* item = gu_buf_get(parsing->lexicon_idx, PgfItem*, i);
				
				if (!pgf_parsing_has_conts(parsing->conts_map,
										   item->base->ccat, item->base->lin_idx)) {
					pgf_parsing_bu_predict(parsing, item, agenda);
				}
			}
		} else {
			size_t n_items = gu_buf_length(parsing->metas);
			for (size_t i = 0; i < n_items; i++) {
				PgfItem* item = gu_buf_get(parsing->metas, PgfItem*, i);
				
				pgf_item_advance(item, parsing->pool);
				pgf_parsing_add_transition(parsing, tok, item);
			}
		}
	}

    PgfParse* next_parse = NULL;
    if (gu_buf_length(agenda) > 0) {
        next_parse = pgf_new_parse(parse->concr, parse->max_fid, pool);
        next_parse->agenda = agenda;
        next_parse->max_fid= parsing->max_fid;
    }

    gu_pool_free(tmp_pool);
	return next_parse;
}

static PgfExpr
pgf_cat_to_expr(PgfConcr* concr, PgfCCat* cat,
                PgfCCatBuf* visited, GuChoice* choice,
                GuPool* pool);

static PgfExpr
pgf_production_to_expr(PgfConcr* concr, PgfProduction prod,
                       PgfCCatBuf* visited, GuChoice* choice,
                       GuPool* pool)
{
	GuVariantInfo pi = gu_variant_open(prod);
	switch (pi.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = pi.data;
		PgfExpr expr = papp->fun->ep->expr;
		size_t n_args = gu_seq_length(papp->args);
		for (size_t i = 0; i < n_args; i++) {
			PgfPArg* parg = gu_seq_index(papp->args, PgfPArg, i);
			gu_assert(!parg->hypos || !parg->hypos->len);
			PgfExpr earg = pgf_cat_to_expr(concr, parg->ccat, visited, choice, pool);
			if (gu_variant_is_null(earg))
				return gu_null_variant;
			expr = gu_new_variant_i(pool, PGF_EXPR_APP,
						PgfExprApp,
						.fun = expr, .arg = earg);
		}
		return expr;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = pi.data;
		return pgf_cat_to_expr(concr, pcoerce->coerce, visited, choice, pool);
	}
	case PGF_PRODUCTION_META: {
		PgfProductionMeta* pmeta = pi.data;
		PgfExpr expr = gu_new_variant_i(pool, PGF_EXPR_META,
						PgfExprMeta,
						.id = 0);
		size_t n_args = gu_seq_length(pmeta->args);
		for (size_t i = 0; i < n_args; i++) {
			PgfPArg* parg = gu_seq_index(pmeta->args, PgfPArg, i);
			gu_assert(!parg->hypos || !parg->hypos->len);
			PgfExpr earg = pgf_cat_to_expr(concr, parg->ccat, visited, choice, pool);
			if (gu_variant_is_null(earg))
				return gu_null_variant;
			expr = gu_new_variant_i(pool, PGF_EXPR_APP,
						PgfExprApp,
						.fun = expr, .arg = earg);
		}
		return expr;
	}
	default:
		gu_impossible();
	}
	return gu_null_variant;
}

static PgfExpr
pgf_cat_to_expr(PgfConcr* concr, PgfCCat* cat,
                PgfCCatBuf* visited, GuChoice* choice,
                GuPool* pool)
{
	if (cat->fid < concr->total_cats) {
		// XXX: What should the PgfMetaId be?
		return gu_new_variant_i(pool, PGF_EXPR_META,
					PgfExprMeta, 
					.id = 0);
	}

	size_t n_prods = gu_seq_length(cat->prods);
	for (size_t i = 0; i < gu_buf_length(visited); i++) {
		if (gu_buf_get(visited, PgfCCat*, i) == cat) {
			n_prods = 0;
			break;
		}
	}
	gu_buf_push(visited, PgfCCat*, cat);

	int i = gu_choice_next(choice, n_prods);
	if (i == -1) {
		return gu_null_variant;
	}
	PgfProduction prod = gu_seq_get(cat->prods, PgfProduction, i);
	return pgf_production_to_expr(concr, prod, visited, choice, pool);
}

static PgfExpr
pgf_parse_result_next(PgfParseResult* pr, GuPool* pool)
{
	if (pr->choice == NULL) {
		return gu_null_variant;
	}
	
	PgfExpr ret = gu_null_variant;

	do {
		size_t n_results = gu_buf_length(pr->completed);
		GuChoiceMark mark = gu_choice_mark(pr->choice);
		int i = gu_choice_next(pr->choice, n_results);
		if (i == -1) {
			return gu_null_variant;
		}
		PgfCCat* cat = gu_buf_get(pr->completed, PgfCCat*, i);

		GuPool* tmp_pool = gu_new_pool();
		PgfCCatBuf* visited = gu_new_buf(PgfCCat*, tmp_pool);
		ret = pgf_cat_to_expr(pr->concr, cat, visited, pr->choice, pool);
		gu_pool_free(tmp_pool);

		gu_choice_reset(pr->choice, mark);
		if (!gu_choice_advance(pr->choice)) {
			pr->choice = NULL;
		};
	} while (gu_variant_is_null(ret));
	
	return ret;
}

static void
pgf_parse_result_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfParseResult* pr = gu_container(self, PgfParseResult, en);
	*(PgfExpr*)to = pgf_parse_result_next(pr, pool);
}

static PgfLexCallback lex_callback_noop = 
		{ pgf_lex_noop, pgf_lit_noop };

PgfExprEnum*
pgf_parse_result(PgfParse* parse, GuPool* pool)
{
    GuPool* tmp_pool = gu_new_pool();
	PgfParsing* parsing = 
		pgf_new_parsing(parse->concr,
	                    &lex_callback_noop,
	                    parse->max_fid,
	                    pool, tmp_pool);
	size_t n_items = gu_buf_length(parse->agenda);
	for (size_t i = 0; i < n_items; i++) {
		PgfItem* item = gu_buf_get(parse->agenda, PgfItem*, i);
        pgf_parsing_item(parsing, item);
	}

	PgfExprEnum* en = 
           &gu_new_i(pool, PgfParseResult,
			 .concr = parse->concr,
             .completed = parsing->completed,
			 .choice = gu_new_choice(pool),
			 .en.next = pgf_parse_result_enum_next)->en;

	gu_pool_free(tmp_pool);
	return en;
}

int cmp_expr_prob(GuOrder* self, const void* a, const void* b)
{
	PgfExprProb *s1 = *((PgfExprProb **) a);
	PgfExprProb *s2 = *((PgfExprProb **) b);

	if (s1->prob < s2->prob)
		return -1;
	else if (s1->prob > s2->prob)
		return 1;
	else
		return 0;
}

static GuOrder
pgf_expr_prob_order = { cmp_expr_prob };

static void
pgf_parse_best_result_init(PgfCCat *ccat, GuBuf *pqueue,
                           GuPool *tmp_pool, GuPool *out_pool)
{
	size_t n_prods = gu_seq_length(ccat->prods);
	for (size_t i = 0; i < n_prods; i++) {
		PgfProduction prod =
			gu_seq_get(ccat->prods, PgfProduction, i);

		GuVariantInfo pi = gu_variant_open(prod);
		switch (pi.tag) {
		case PGF_PRODUCTION_APPLY: {
			PgfProductionApply* papp = pi.data;

			PgfExprState *st = gu_new(PgfExprState, tmp_pool);
			st->ep = *papp->fun->ep;
			st->args = papp->args;
			st->arg_idx = 0;
			gu_buf_heap_push(pqueue, &pgf_expr_prob_order, &st);
			break;
		}
		case PGF_PRODUCTION_COERCE: {
			PgfProductionCoerce* pcoerce = pi.data;
			pgf_parse_best_result_init(pcoerce->coerce, pqueue, 
			                           tmp_pool, out_pool);
			break;
		}
		case PGF_PRODUCTION_META: {
			PgfProductionMeta* pmeta = pi.data;

			PgfExprState *st = gu_new(PgfExprState, tmp_pool);
			st->ep.prob = 100000000000 + rand();
			PgfExprMeta *expr_meta =
				gu_new_variant(PGF_EXPR_META,
				       PgfExprMeta,
				       &st->ep.expr, out_pool);
			expr_meta->id = 0;
			st->args = pmeta->args;
			st->arg_idx = 0;
			
			gu_buf_heap_push(pqueue, &pgf_expr_prob_order, &st);
			break;
		}
		}
	}
}

static PgfExprProb*
pgf_parse_best_ccat_result(
                    PgfExprCache *cache, PgfConcr *concr, 
                    PgfCCat *ccat, GuPool *pool)
{
	PgfExprProb* ep = NULL;
	if (gu_map_has(cache, ccat)) {
		ep = gu_map_get(cache, ccat, PgfExprProb*);
		return ep;
	}

	gu_map_put(cache, ccat, PgfExprProb*, NULL);

	GuPool *tmp_pool = gu_new_pool();

	GuBuf* pqueue = gu_new_buf(PgfExprState*, tmp_pool);
	pgf_parse_best_result_init(ccat, pqueue, tmp_pool, pool);

	while (gu_buf_length(pqueue) > 0) {
		PgfExprState *st;
		gu_buf_heap_pop(pqueue, &pgf_expr_prob_order, &st);

		if (st->arg_idx >= gu_seq_length(st->args)) {
			ep = gu_new(PgfExprProb, pool);
			*ep = st->ep;
			gu_map_put(cache, ccat, PgfExprProb*, ep);
			break;
		}

		PgfPArg *parg = gu_seq_index(st->args, PgfPArg, st->arg_idx++);

		double prob = 0;
		PgfExpr fun = st->ep.expr;
		PgfExpr arg;

		if (parg->ccat->fid < concr->total_cats) {
			PgfExprMeta *expr_meta =
				gu_new_variant(PGF_EXPR_META,
							   PgfExprMeta,
							   &arg, pool);
			expr_meta->id = 0;
		} else {
			PgfExprProb *ep_arg = 
				pgf_parse_best_ccat_result(cache, concr, 
			                               parg->ccat, pool);
			if (ep_arg == NULL)
				continue;
				
			arg  = ep_arg->expr;
			prob = ep_arg->prob;
		}
		PgfExprApp *expr_apply =
			gu_new_variant(PGF_EXPR_APP,
						   PgfExprApp,
						   &st->ep.expr, pool);
		expr_apply->fun = fun;
		expr_apply->arg = arg;
		st->ep.prob += prob;
		gu_buf_heap_push(pqueue, &pgf_expr_prob_order, &st);
	}

	gu_pool_free(tmp_pool);

	return ep;
}

PgfExpr
pgf_parse_best_result(PgfParse* parse, GuPool* pool)
{
	GuPool* tmp_pool = gu_new_pool();
	PgfParsing* parsing = 
		pgf_new_parsing(parse->concr, 
	                    &lex_callback_noop,
	                    parse->max_fid, 
	                    pool, tmp_pool);
	size_t n_items = gu_buf_length(parse->agenda);
	for (size_t i = 0; i < n_items; i++) {
		PgfItem* item = gu_buf_get(parse->agenda, PgfItem*, i);
        pgf_parsing_item(parsing, item);
	}

	PgfExprCache *cache = gu_map_type_new(PgfExprCache, tmp_pool);

	GuBuf* pqueue = gu_new_buf(PgfExprProb*, tmp_pool);

	size_t n_completed = gu_buf_length(parsing->completed);
	for (size_t i = 0; i < n_completed; i++) {
		PgfCCat *ccat = gu_buf_get(parsing->completed, PgfCCat*, i);

		PgfExprProb *ep =
			pgf_parse_best_ccat_result(cache, parse->concr, ccat, pool);
		if (ep != NULL)
			gu_buf_heap_push(pqueue, &pgf_expr_prob_order, &ep);
	}

	PgfExpr expr = gu_null_variant;
	if (gu_buf_length(pqueue) > 0) {
		PgfExprProb* ep = NULL;
		gu_buf_heap_pop(pqueue, &pgf_expr_prob_order, &ep);
		expr = ep->expr;
	}

	gu_pool_free(tmp_pool);

	return expr;
}

// TODO: s/CId/Cat, add the cid to Cat, make Cat the key to CncCat
PgfParse*
pgf_parser_parse(PgfConcr* concr, PgfCId cat, size_t lin_idx, GuPool* pool)
{
	PgfCncCat* cnccat =
		gu_map_get(concr->cnccats, &cat, PgfCncCat*);
	if (!cnccat) {
		// error ...
		gu_impossible();
	}
	gu_assert(lin_idx < cnccat->n_lins);

	PgfParse* parse = pgf_new_parse(concr, concr->max_fid, pool);
    parse->agenda = gu_new_buf(PgfItem*, pool);

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
                    pgf_new_item(ccat, lin_idx, prod, conts, pool);
                gu_buf_push(parse->agenda, PgfItem*, item);
            }
		}
	}
	return parse;
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
				eps_ccat->fid = concr->max_fid++;
				eps_ccat->prods = 
					gu_buf_seq(gu_new_buf(PgfProduction, pool));
				eps_ccat->n_synprods = 0;
				gu_map_put(concr->epsilon_idx, &cfc, PgfCCat*, eps_ccat);
			}

			PgfProduction prod =
				pgf_parsing_new_production(item, pool);
			GuBuf* prodbuf = gu_seq_buf(eps_ccat->prods);
			gu_buf_push(prodbuf, PgfProduction, prod);
			eps_ccat->n_synprods++;

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
			pgf_new_item(ccat, lin_idx, prod, conts, pool);

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
