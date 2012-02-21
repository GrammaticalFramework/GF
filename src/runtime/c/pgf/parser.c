#include <pgf/parser.h>
#include <gu/choice.h>
#include <gu/seq.h>
#include <gu/assert.h>
#include <gu/log.h>
#include <gu/file.h>
#include <stdlib.h>

typedef struct PgfItem PgfItem;

typedef GuBuf PgfItemBuf;
typedef GuList(PgfItemBuf*) PgfItemBufs;


// GuString -> PgfItemBuf*			 
typedef GuMap PgfTransitions;			 

typedef GuBuf PgfCCatBuf;

struct PgfParse {
	PgfConcr* concr;
    PgfItemBuf* agenda;
    int max_fid;
};

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

typedef GuMap PgfContsMap;


static GU_DEFINE_TYPE(PgfItemBuf, abstract, _);
static GU_DEFINE_TYPE(PgfItemBufs, abstract, _);
static GU_DEFINE_TYPE(PgfContsMap, GuMap,
		      gu_type(PgfCCat), NULL,
		      gu_ptr_type(PgfItemBufs), &gu_null_struct);

static GU_DEFINE_TYPE(PgfGenCatMap, GuMap,
		      gu_type(PgfItemBuf), NULL,
		      gu_ptr_type(PgfCCat), &gu_null_struct);

static GU_DEFINE_TYPE(PgfTransitions, GuStringMap,
		      gu_ptr_type(PgfItemBuf), &gu_null_struct);

typedef GuMap PgfGenCatMap;

typedef struct PgfParsing PgfParsing;

typedef const struct PgfLexCallback PgfLexCallback;

struct PgfLexCallback {
	void (*lex)(PgfLexCallback* self, PgfToken tok, PgfItem* item);
};

struct PgfParsing {
	GuPool* pool;
    GuPool* tmp_pool;
	PgfContsMap* conts_map;
	PgfGenCatMap* generated_cats;
	PgfCCatBuf* completed;
    PgfLexCallback* callback;
    GuBuf *lexicon_idx, *epsilon_idx;
    int max_fid;
};

GU_DEFINE_TYPE(PgfLexiconIdx, GuStringMap, gu_ptr_type(GuBuf),
		      &gu_null_struct);

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
        gu_string_write(papp->fun->fun, wtr, err);
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
        gu_printf(wtr,err,"_[C%d]\n",pcoerce->coerce);
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
        gu_string_write(fun->fun, wtr, err);
        gu_printf(wtr, err, ")[");
		for (size_t i = 0; i < gu_seq_length(item->args); i++) {
            PgfPArg arg = gu_seq_get(item->args, PgfPArg, i);
            gu_printf(wtr, err,
                      ((i < gu_seq_length(item->args)-1) ? "C%d," : "C%d"),
                      ((arg.ccat == NULL) ? 0 : arg.ccat->fid));
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
		PgfProductionCoerce* pcoerce = i.data;
        gu_printf(wtr, err, "_[%d]; %d : ",
            pcoerce->coerce->fid,
            item->base->lin_idx);
        if (item->seq_idx == 0)
            gu_printf(wtr, err, ". ");
        gu_printf(wtr, err, "<0,%d>", item->base->lin_idx);
        if (item->seq_idx == 1)
            gu_printf(wtr, err, " .");
		break;
	}
	default:
		gu_impossible();
	}
    
    gu_printf(wtr, err, "]\n");
}
#endif

static void
pgf_parser_bu_add_entry(PgfConcr* concr, PgfTokens tokens, 
                        PgfCCat* ccat, size_t lin_idx, 
                        PgfProduction prod,
						GuPool *pool)
{
	PgfToken tok = gu_seq_get(tokens, PgfToken, 0);
					
	GuBuf* items = gu_map_get(concr->lexicon_idx, &tok, GuBuf*);
	if (items == NULL) {
		items = gu_new_buf(PgfItemBase*, pool);
		gu_map_put(concr->lexicon_idx, &tok, GuBuf*, items);
	}
					
	PgfItemBase* base = gu_new(PgfItemBase, pool);
	base->ccat = ccat;
	base->lin_idx = lin_idx;
	base->prod = prod;
	base->conts = NULL;

	gu_buf_push(items, PgfItemBase*, base);
}

void
pgf_parser_bu_index(PgfConcr* concr, PgfCCat* ccat, PgfProduction prod, 
					GuPool *pool)
{
	GuVariantInfo i = gu_variant_open(prod);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;

		for (size_t lin_idx = 0; lin_idx < papp->fun->n_lins; lin_idx++) {		
			PgfSequence seq = papp->fun->lins[lin_idx];
			if (gu_seq_length(seq) > 0) {
				PgfSymbol sym = gu_seq_get(seq, PgfSymbol, 0);
				GuVariantInfo i = gu_variant_open(sym);
				switch (i.tag) {
				case PGF_SYMBOL_CAT: {
					PgfSymbolCat* scat = i.data;
					break;
				}
				case PGF_SYMBOL_KS: {
					PgfSymbolKS* sks = gu_variant_data(sym);
					pgf_parser_bu_add_entry(concr, sks->tokens,
							ccat, lin_idx, prod, pool);
					break;
				}
				case PGF_SYMBOL_KP: {
					PgfSymbolKP* skp = gu_variant_data(sym);
					pgf_parser_bu_add_entry(concr, skp->default_form,
						ccat, lin_idx, prod, pool);
					for (size_t i = 0; i < skp->n_forms; i++) {
						pgf_parser_bu_add_entry(concr, skp->forms[i].form,
							ccat, lin_idx, prod, pool);
					}
					break;
				}
				case PGF_SYMBOL_LIT:
					// XXX TODO proper support
					break;
				case PGF_SYMBOL_VAR:
					// XXX TODO proper support
					break;
				default:
					gu_impossible();
				}
			} else {
				PgfItemBase* base = gu_new(PgfItemBase, pool);
				base->ccat = ccat;
				base->lin_idx = lin_idx;
				base->prod = prod;
				base->conts = NULL;

				gu_buf_push(concr->epsilon_idx, PgfItemBase*, base);
			}
		}
		break;
	case PGF_PRODUCTION_COERCE: {
		break;
	}
	default:
		gu_impossible();
	}
	}
}

static void
pgf_parsing_add_transition(PgfParsing* parsing, PgfToken tok, PgfItem* item)
{
    parsing->callback->lex(parsing->callback, tok, item);
}

static PgfItemBufs*
pgf_parsing_get_contss(PgfParsing* parsing, PgfCCat* cat)
{
	PgfItemBufs* contss = gu_map_get(parsing->conts_map, cat, PgfItemBufs*);
	if (!contss) {
		size_t n_lins = cat->cnccat->n_lins;
		contss = gu_new_list(PgfItemBufs, parsing->tmp_pool, n_lins);
		for (size_t i = 0; i < n_lins; i++) {
			gu_list_index(contss, i) = NULL;
		}
		gu_map_put(parsing->conts_map, cat, PgfItemBufs*, contss);
	}
	return contss;
}


static PgfItemBuf*
pgf_parsing_get_conts(PgfParsing* parsing, PgfCCat* cat, size_t lin_idx)
{
	gu_require(lin_idx < cat->cnccat->n_lins);
	PgfItemBufs* contss = pgf_parsing_get_contss(parsing, cat);
	PgfItemBuf* conts = gu_list_index(contss, lin_idx);
	if (!conts) {
		conts = gu_new_buf(PgfItem*, parsing->pool);
		gu_list_index(contss, lin_idx) = conts;
	}
	return conts;
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

static PgfItem*
pgf_item_copy(PgfItem* item, GuPool* pool)
{
	PgfItem* copy = gu_new(PgfItem, pool);
	memcpy(copy, item, sizeof(PgfItem));
	return copy;
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
	PgfItem* item = pgf_item_copy(cont, parsing->pool);
	size_t nargs = gu_seq_length(cont->args);
	item->args = gu_new_seq(PgfPArg, nargs, parsing->pool);
	memcpy(gu_seq_data(item->args), gu_seq_data(cont->args),
	       nargs * sizeof(PgfPArg));
	gu_assert(gu_variant_tag(item->curr_sym) == PGF_SYMBOL_CAT);
	PgfSymbolCat* pcat = gu_variant_data(cont->curr_sym);
	gu_seq_set(item->args, PgfPArg, pcat->d,
		   ((PgfPArg) { .hypos = NULL, .ccat = cat }));
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

static void
pgf_parsing_complete(PgfParsing* parsing, PgfItem* item)
{
	GuVariantInfo i = gu_variant_open(item->base->prod);
	PgfProduction prod = gu_null_variant;
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = i.data;
		PgfProductionApply* new_papp = 
			gu_new_variant(PGF_PRODUCTION_APPLY,
				       PgfProductionApply,
				       &prod, parsing->pool);
		new_papp->fun = papp->fun;
		new_papp->args = item->args;
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* new_pcoerce =
			gu_new_variant(PGF_PRODUCTION_COERCE,
				       PgfProductionCoerce,
				       &prod, parsing->pool);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, 0);
		gu_assert(!parg->hypos || !parg->hypos->len);
		new_pcoerce->coerce = parg->ccat;
		break;
	}
	default:
		gu_impossible();
	}
    
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
		PgfItemBufs* contss = pgf_parsing_get_contss(parsing, cat);
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
pgf_parsing_bu_predict(PgfParsing* parsing, GuBuf* items,
                       PgfCCat* ccat, size_t lin_idx,
                       PgfItemBuf* conts)
{
	if (items != NULL) {
		size_t n_items = gu_buf_length(items);
		for (size_t i = 0; i < n_items; i++) {
			PgfItemBase* base = gu_buf_get(items, PgfItemBase*, i);
			
			if (base->ccat == ccat && base->lin_idx == lin_idx) {
				GuVariantInfo i = gu_variant_open(base->prod);
				switch (i.tag) {
				case PGF_PRODUCTION_APPLY: {
					PgfProductionApply* papp = i.data;
					if (gu_seq_length(papp->args) == 0) {
						pgf_parsing_production(parsing, ccat, lin_idx,
							base->prod, conts);
					}
					break;
				}
				}
			}
		}
	}
}

static void
pgf_parsing_predict(PgfParsing* parsing, PgfItem* item, 
		    PgfCCat* ccat, size_t lin_idx)
{
	gu_enter("-> cat: %d", ccat->fid);
	if (gu_seq_is_null(ccat->prods)) {
		// Empty category
		return;
	}
	PgfItemBuf* conts = pgf_parsing_get_conts(parsing, ccat, lin_idx);
	gu_buf_push(conts, PgfItem*, item);
	if (gu_buf_length(conts) == 1) {
		/* First time we encounter this linearization
		 * of this category at the current position,
		 * so predict it. */
		PgfProductionSeq prods = ccat->prods;
		for (size_t i = 0; i < ccat->n_synprods; i++) {
			PgfProduction prod =
				gu_seq_get(prods, PgfProduction, i);
			pgf_parsing_production(parsing, ccat, lin_idx, 
					       prod, conts);
		}

		pgf_parsing_bu_predict(parsing, parsing->lexicon_idx,
		                        ccat, lin_idx, conts);
		pgf_parsing_bu_predict(parsing, parsing->epsilon_idx,
		                        ccat, lin_idx, conts);
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
pgf_parsing_symbol(PgfParsing* parsing, PgfItem* item, PgfSymbol sym) {
	switch (gu_variant_tag(sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(sym);
		PgfPArg* parg = gu_seq_index(item->args, PgfPArg, scat->d);
		gu_assert(!parg->hypos || !parg->hypos->len);
		pgf_parsing_predict(parsing, item, parg->ccat, scat->r);
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
	case PGF_SYMBOL_LIT:
		// XXX TODO proper support
		break;
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
			pgf_parsing_predict(parsing, item, 
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

typedef struct {
    PgfLexCallback fn;
    PgfToken tok;
    PgfItemBuf* agenda;
} PgfParseTokenCallback;

static
void pgf_match_token(PgfLexCallback* self, PgfToken tok, PgfItem* item)
{
    PgfParseTokenCallback *clo = (PgfParseTokenCallback *) self;

    if (gu_string_eq(tok, clo->tok)) {
        gu_buf_push(clo->agenda, PgfItem*, item);
    }
}
    
PgfParse*
pgf_parse_token(PgfParse* parse, PgfToken tok, GuPool* pool)
{
    PgfItemBuf* agenda = gu_new_buf(PgfItem*, pool);

    PgfParseTokenCallback clo = {{ pgf_match_token }, tok, agenda};

	GuPool* tmp_pool = gu_new_pool();
	PgfParsing* parsing = pgf_new_parsing(parse->concr, &clo.fn, parse->max_fid, pool, tmp_pool);
	parsing->lexicon_idx = gu_map_get(parse->concr->lexicon_idx, &tok, GuBuf*);

	size_t n_items = gu_buf_length(parse->agenda);
	for (size_t i = 0; i < n_items; i++) {
		PgfItem* item = gu_buf_get(parse->agenda, PgfItem*, i);
        pgf_parsing_item(parsing, item);
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
pgf_cat_to_expr(PgfConcr* concr, PgfCCat* cat, GuChoice* choice, GuPool* pool);

static PgfExpr
pgf_production_to_expr(PgfConcr* concr, PgfProduction prod,
                       GuChoice* choice, GuPool* pool)
{
	GuVariantInfo pi = gu_variant_open(prod);
	switch (pi.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papp = pi.data;
		PgfExpr expr = gu_new_variant_i(pool, PGF_EXPR_FUN,
						PgfExprFun,
						.fun = papp->fun->fun);
		size_t n_args = gu_seq_length(papp->args);
		for (size_t i = 0; i < n_args; i++) {
			PgfPArg* parg = gu_seq_index(papp->args, PgfPArg, i);
			gu_assert(!parg->hypos || !parg->hypos->len);
			PgfExpr earg = pgf_cat_to_expr(concr, parg->ccat, choice, pool);
			expr = gu_new_variant_i(pool, PGF_EXPR_APP,
						PgfExprApp,
						.fun = expr, .arg = earg);
		}
		return expr;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = pi.data;
		return pgf_cat_to_expr(concr, pcoerce->coerce, choice, pool);
	}
	default:
		gu_impossible();
	}
	return gu_null_variant;
}


static PgfExpr
pgf_cat_to_expr(PgfConcr* concr, PgfCCat* cat,
                GuChoice* choice, GuPool* pool)
{
	if (cat->fid < concr->max_fid) {
		// XXX: What should the PgfMetaId be?
		return gu_new_variant_i(pool, PGF_EXPR_META,
					PgfExprMeta, 
					.id = 0);
	}
	size_t n_prods = gu_seq_length(cat->prods);
	int i = gu_choice_next(choice, n_prods);
	if (i == -1) {
		return gu_null_variant;
	}
	PgfProduction prod = gu_seq_get(cat->prods, PgfProduction, i);
	return pgf_production_to_expr(concr, prod, choice, pool);
}


static PgfExpr
pgf_parse_result_next(PgfParseResult* pr, GuPool* pool)
{
	if (pr->choice == NULL) {
		return gu_null_variant;
	}
	size_t n_results = gu_buf_length(pr->completed);
 	GuChoiceMark mark = gu_choice_mark(pr->choice);
	int i = gu_choice_next(pr->choice, n_results);
	if (i == -1) {
		return gu_null_variant;
	}
	PgfCCat* cat = gu_buf_get(pr->completed, PgfCCat*, i);
	PgfExpr ret = pgf_cat_to_expr(pr->concr, cat, pr->choice, pool);
	gu_choice_reset(pr->choice, mark);
	if (!gu_choice_advance(pr->choice)) {
		pr->choice = NULL;
	};
	return ret;
}

static void
pgf_parse_result_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfParseResult* pr = gu_container(self, PgfParseResult, en);
	*(PgfExpr*)to = pgf_parse_result_next(pr, pool);
}

static
void pgf_noop(PgfLexCallback* self, PgfToken tok, PgfItem* item)
{
}

PgfExprEnum*
pgf_parse_result(PgfParse* parse, GuPool* pool)
{
    PgfLexCallback fn = { pgf_noop };

    GuPool* tmp_pool = gu_new_pool();
	PgfParsing* parsing = pgf_new_parsing(parse->concr, &fn, parse->max_fid, pool, tmp_pool);
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
