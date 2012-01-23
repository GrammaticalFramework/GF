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

struct PgfParser {
	PgfConcr* concr;
};

struct PgfParse {
	PgfParser* parser;
	PgfTransitions* transitions;
	PgfCCatBuf* completed;
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

struct PgfParsing {
	PgfParse* parse;
	GuPool* pool;
	PgfContsMap* conts_map;
	PgfGenCatMap* generated_cats;
};

#ifndef NDEBUG
static bool 
pgf_parser_debug() {
    const char* cfg = getenv("PGF_PARSER_DEBUG");
    if (cfg == NULL)
        return false;

    return strcmp(cfg, "yes") == 0;
}

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
pgf_parsing_add_transition(PgfParsing* parsing, PgfToken tok, PgfItem* item)
{
	gu_debug("%s -> %p", tok, item);
	PgfTransitions* tmap = parsing->parse->transitions;
	PgfItemBuf* items = gu_map_get(tmap, &tok, PgfItemBuf*);
	if (!items) {
		items = gu_new_buf(PgfItem*, parsing->pool);
		gu_map_put(tmap, &tok, PgfItemBuf*, items);
	}
	gu_buf_push(items, PgfItem*, item);
}

static PgfItemBufs*
pgf_parsing_get_contss(PgfParsing* parsing, PgfCCat* cat)
{
	PgfItemBufs* contss = gu_map_get(parsing->conts_map, cat, PgfItemBufs*);
	if (!contss) {
		size_t n_lins = cat->cnccat->n_lins;
		contss = gu_new_list(PgfItemBufs, parsing->pool, n_lins);
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
	cat->fid = parsing->parse->max_fid++;
	cat->prods = gu_buf_seq(gu_new_buf(PgfProduction, parsing->pool));
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
pgf_new_item(PgfItemBase* base, GuPool* pool)
{
	PgfItem* item = gu_new(PgfItem, pool);
	GuVariantInfo pi = gu_variant_open(base->prod);
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
		gu_buf_push(parsing->parse->completed, PgfCCat*, cat);
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
pgf_parsing_production(PgfParsing* parsing, PgfCCat* cat, size_t lin_idx,
		       PgfProduction prod, PgfItemBuf* conts)
{
	PgfItemBase* base = gu_new(PgfItemBase, parsing->pool);
	base->ccat = cat;
	base->lin_idx = lin_idx;
	base->prod = prod;
	base->conts = conts;
	PgfItem* item = pgf_new_item(base, parsing->pool);
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

#ifndef NDEBUG
    if (pgf_parser_debug()) {
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
    }
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
pgf_parsing_predict(PgfParsing* parsing, PgfItem* item, 
		    PgfCCat* cat, size_t lin_idx)
{
	gu_enter("-> cat: %d", cat->fid);
	if (gu_seq_is_null(cat->prods)) {
		// Empty category
		return;
	}
	PgfItemBuf* conts = pgf_parsing_get_conts(parsing, cat, lin_idx);
	gu_buf_push(conts, PgfItem*, item);
	if (gu_buf_length(conts) == 1) {
		/* First time we encounter this linearization
		 * of this category at the current position,
		 * so predict it. */
		PgfProductionSeq prods = cat->prods;
		size_t n_prods = gu_seq_length(prods);
		for (size_t i = 0; i < n_prods; i++) {
			PgfProduction prod =
				gu_seq_get(prods, PgfProduction, i);
			pgf_parsing_production(parsing, cat, lin_idx, 
					       prod, conts);
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
			gu_seq_get(sks->tokens, PgfToken, item->tok_idx);
		pgf_parsing_add_transition(parsing, tok, item);
		break;
	}
	case PGF_SYMBOL_KP: {
		PgfSymbolKP* skp = gu_variant_data(sym);
		size_t idx = item->tok_idx;
		uint8_t alt = item->alt;
		gu_assert(idx < gu_seq_length(skp->default_form));
		if (idx == 0) {
			PgfToken tok = gu_seq_get(skp->default_form, PgfToken, 0);
			pgf_parsing_add_transition(parsing, tok, item);
			for (size_t i = 0; i < skp->n_forms; i++) {
				PgfTokens toks = skp->forms[i].form;
				PgfTokens toks2 = skp->default_form;
				// XXX: do nubbing properly
				bool skip = pgf_tokens_equal(toks, toks2);
				for (size_t j = 0; j < i; j++) {
					PgfTokens toks2 = skp->forms[j].form;
					skip |= pgf_tokens_equal(toks, toks2);
				}
				if (skip) {
					continue;
				}
				PgfToken tok = gu_seq_get(toks, PgfToken, 0);
				pgf_parsing_add_transition(parsing, tok, item);
			}
		} else if (alt == 0) {
			PgfToken tok = 
				gu_seq_get(skp->default_form, PgfToken, idx);
			pgf_parsing_add_transition(parsing, tok, item);
		} else {
			gu_assert(alt <= skp->n_forms);
			PgfToken tok = gu_seq_get(skp->forms[alt - 1].form, 
						  PgfToken, idx);
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
#ifndef NDEBUG
    if (pgf_parser_debug()) {
        GuPool* tmp_pool = gu_new_pool();
        GuOut* out = gu_file_out(stderr, tmp_pool);
        GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
        GuExn* err = gu_exn(NULL, type, tmp_pool);
        pgf_print_item(item, wtr, err);
        gu_pool_free(tmp_pool);
    }
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

static bool
pgf_parsing_scan_toks(PgfParsing* parsing, PgfItem* old_item, 
		      PgfToken tok, int alt, PgfTokens toks)
{
	gu_assert(old_item->tok_idx < gu_seq_length(toks));
	if (!gu_string_eq(gu_seq_get(toks, PgfToken, old_item->tok_idx), 
			  tok)) {
		return false;
	}
	PgfItem* item = pgf_item_copy(old_item, parsing->pool);
	item->tok_idx++;
	item->alt = alt;
	if (item->tok_idx == gu_seq_length(toks)) {
		item->tok_idx = 0;
		pgf_item_advance(item, parsing->pool);
	}
	pgf_parsing_item(parsing, item);
	return true;
}

static void
pgf_parsing_scan(PgfParsing* parsing, PgfItem* item, PgfToken tok)
{
	bool succ = false;
	GuVariantInfo i = gu_variant_open(item->curr_sym);
	switch (i.tag) {
	case PGF_SYMBOL_KS: {
		PgfSymbolKS* ks = i.data;
		succ = pgf_parsing_scan_toks(parsing, item, tok, 0, 
					     ks->tokens);
		break;
	}
	case PGF_SYMBOL_KP: {
		PgfSymbolKP* kp = i.data;
		size_t alt = item->alt;
		if (item->tok_idx == 0) {
			succ = pgf_parsing_scan_toks(parsing, item, tok, 0, 
						      kp->default_form);
			for (size_t i = 0; i < kp->n_forms; i++) {
				// XXX: do nubbing properly
				PgfTokens toks = kp->forms[i].form;
				PgfTokens toks2 = kp->default_form;
				bool skip = pgf_tokens_equal(toks, toks2);
				for (size_t j = 0; j < i; j++) {
					PgfTokens toks2 = kp->forms[j].form;
					skip |= pgf_tokens_equal(toks, toks2);
				}
				if (!skip) {
					succ |= pgf_parsing_scan_toks(
						parsing, item, tok, i + 1,
						kp->forms[i].form);
				}
			}
		} else if (alt == 0) {
			succ = pgf_parsing_scan_toks(parsing, item, tok, 0, 
						      kp->default_form);
		} else {
			gu_assert(alt <= kp->n_forms);
			succ = pgf_parsing_scan_toks(parsing, item, tok, 
						     alt, kp->forms[alt - 1].form);
		}
		break;
	}
	default:
		gu_impossible();
	}
	gu_assert(succ);
}


static PgfParsing*
pgf_new_parsing(PgfParse* parse, GuPool* parse_pool, GuPool* out_pool)
{
	PgfParsing* parsing = gu_new(PgfParsing, out_pool);
	parsing->parse = parse;
	parsing->generated_cats = gu_map_type_new(PgfGenCatMap, out_pool);
	parsing->conts_map = gu_map_type_new(PgfContsMap, out_pool);
	parsing->pool = parse_pool;
	return parsing;
}

static PgfParse*
pgf_new_parse(PgfParser* parser, int max_fid, GuPool* pool)
{
	PgfParse* parse = gu_new(PgfParse, pool);
	parse->parser = parser;
	parse->transitions = gu_map_type_new(PgfTransitions, pool);
	parse->completed = gu_new_buf(PgfCCat*, pool);
    parse->max_fid = max_fid;
	return parse;
}

PgfParse*
pgf_parse_token(PgfParse* parse, PgfToken tok, GuPool* pool)
{
	PgfItemBuf* agenda =
		gu_map_get(parse->transitions, &tok, PgfItemBuf*);
	if (!agenda) {
		return NULL;
	}
	PgfParse* next_parse = pgf_new_parse(parse->parser, parse->max_fid, pool);
	GuPool* tmp_pool = gu_new_pool();
	PgfParsing* parsing = pgf_new_parsing(next_parse, pool, tmp_pool);
	size_t n_items = gu_buf_length(agenda);
	for (size_t i = 0; i < n_items; i++) {
		PgfItem* item = gu_buf_get(agenda, PgfItem*, i);
		pgf_parsing_scan(parsing, item, tok);
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

PgfExprEnum*
pgf_parse_result(PgfParse* parse, GuPool* pool)
{
	return &gu_new_i(pool, PgfParseResult,
			 .concr = parse->parser->concr,
             .completed = parse->completed,
			 .choice = gu_new_choice(pool),
			 .en.next = pgf_parse_result_enum_next)->en;
}



// TODO: s/CId/Cat, add the cid to Cat, make Cat the key to CncCat
PgfParse*
pgf_parser_parse(PgfParser* parser, PgfCId cat, size_t lin_idx, GuPool* pool)
{
	PgfParse* parse = pgf_new_parse(parser, parser->concr->max_fid, pool);
	GuPool* tmp_pool = gu_new_pool();
	PgfParsing* parsing = pgf_new_parsing(parse, pool, tmp_pool);
	PgfCncCat* cnccat =
		gu_map_get(parser->concr->cnccats, &cat, PgfCncCat*);
	if (!cnccat) {
		// error ...
		gu_impossible();
	}
	gu_assert(lin_idx < cnccat->n_lins);
	size_t n_ccats = gu_list_length(cnccat->cats);
	for (size_t i = 0; i < n_ccats; i++) {
		PgfCCat* ccat = gu_list_index(cnccat->cats, i);
		if (ccat != NULL) {
			pgf_parsing_predict(parsing, NULL, ccat, lin_idx);
		}
	}
	gu_pool_free(tmp_pool);
	return parse;
}

PgfParser* 
pgf_new_parser(PgfConcr* concr, GuPool* pool)
{
	gu_require(concr != NULL);
	PgfParser* parser = gu_new(PgfParser, pool);
	parser->concr = concr;
	return parser;
}
