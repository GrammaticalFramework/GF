/* 
 * Copyright 2010 University of Helsinki.
 *   
 * This file is part of libpgf.
 * 
 * Libpgf is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 * 
 * Libpgf is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
 * License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with libpgf. If not, see <http://www.gnu.org/licenses/>.
 */

#include "data.h"
#include "linearize.h"
#include <gu/map.h>
#include <gu/fun.h>
#include <gu/log.h>
#include <gu/choice.h>
#include <gu/seq.h>
#include <gu/string.h>
#include <gu/assert.h>
#include <pgf/expr.h>

typedef GuStringMap PgfLinInfer;
typedef GuSeq PgfProdSeq;

static GU_DEFINE_TYPE(PgfProdSeq, GuSeq, gu_type(PgfProduction));

typedef struct PgfLinInferEntry PgfLinInferEntry;

struct PgfLinInferEntry {
	PgfCCat* cat;
	PgfCncFun* fun;
};

static GU_DEFINE_TYPE(
	PgfLinInferEntry, struct,
	GU_MEMBER_P(PgfLinInferEntry, cat, PgfCCat)
	// ,GU_MEMBER(PgfLinInferEntry, fun, ...)
	);

typedef GuBuf PgfLinInfers;
static GU_DEFINE_TYPE(PgfLinInfers, GuBuf, gu_type(PgfLinInferEntry));

typedef GuIntMap PgfCncProds;
static GU_DEFINE_TYPE(PgfCncProds, GuIntMap, gu_type(PgfProdSeq),
		      &gu_null_seq);

typedef GuStringMap PgfLinProds;
static GU_DEFINE_TYPE(PgfLinProds, GuStringMap, gu_ptr_type(PgfCncProds),
		      &gu_null_struct);


static GuHash
pgf_lzr_cats_hash_fn(GuHasher* self, const void* p)
{
	(void) self;
	PgfCCatIds* cats = *(PgfCCatIds* const*)p;
	size_t len = gu_list_length(cats);
	uintptr_t h = 0;
	for (size_t i = 0; i < len; i++) {
		h = 101 * h + (uintptr_t) gu_list_index(cats, i);
	}
	return h;
}

static bool
pgf_lzr_cats_eq_fn(GuEquality* self, const void* p1, const void* p2)
{
	(void) self;
	PgfCCatIds* cats1 = *(PgfCCatIds* const*) p1;
	PgfCCatIds* cats2 = *(PgfCCatIds* const*) p2;
	int len = gu_list_length(cats1);
	if (gu_list_length(cats2) != len) {
		return false;
	}
	for (int i = 0; i < len; i++) {
		PgfCCat* cat1 = gu_list_index(cats1, i);
		PgfCCat* cat2 = gu_list_index(cats2, i);
		if (cat1 != cat2) {
			return false;
		}
	}
	return true;
}

static GuHasher
pgf_lzr_cats_hasher[1] = {
	{
		.eq = { pgf_lzr_cats_eq_fn },
		.hash = pgf_lzr_cats_hash_fn
	}
};

typedef GuMap PgfInferMap;
static GU_DEFINE_TYPE(PgfInferMap, GuMap,
		      gu_ptr_type(PgfCCatIds), pgf_lzr_cats_hasher,
		      gu_ptr_type(PgfLinInfers), &gu_null_struct);

typedef GuStringMap PgfFunIndices;
GU_DEFINE_TYPE(PgfFunIndices, GuStringMap, gu_ptr_type(PgfInferMap),
		      &gu_null_struct);

typedef GuBuf PgfCCatBuf;
static GU_DEFINE_TYPE(PgfCCatBuf, GuBuf, gu_ptr_type(PgfCCat));

typedef GuMap PgfCoerceIdx;
GU_DEFINE_TYPE(PgfCoerceIdx, GuMap,
		      gu_type(PgfCCat), NULL,
		      gu_ptr_type(PgfCCatBuf), &gu_null_struct);


static void
pgf_lzr_add_infer_entry(
			PgfInferMap* infer_table,
			PgfCCat* cat,
			PgfProductionApply* papply,
			GuPool *pool)
{
	PgfPArgs args = papply->args;
	size_t n_args = gu_seq_length(args);
	PgfCCatIds* arg_cats = gu_new_list(PgfCCatIds, pool, n_args);
	for (size_t i = 0; i < n_args; i++) {
		// XXX: What about the hypos in the args?
		gu_list_index(arg_cats, i) = gu_seq_get(args, PgfPArg, i).ccat;
	}
	gu_debug("%d,%d,%d -> %d, %s",
		 n_args > 0 ? gu_list_index(arg_cats, 0)->fid : -1,
		 n_args > 1 ? gu_list_index(arg_cats, 1)->fid : -1,
		 n_args > 2 ? gu_list_index(arg_cats, 2)->fid : -1,
		 cat->fid, papply->fun->fun);
	PgfLinInfers* entries =
		gu_map_get(infer_table, &arg_cats, PgfLinInfers*);
	if (!entries) {
		entries = gu_new_buf(PgfLinInferEntry, pool);
		gu_map_put(infer_table, &arg_cats, PgfLinInfers*, entries);
	} else {
		// XXX: arg_cats is duplicate, we ought to free it
		// Display warning?
	}

	PgfLinInferEntry entry = {
		.cat = cat,
		.fun = papply->fun
	};
	gu_buf_push(entries, PgfLinInferEntry, entry);
}
			

void
pgf_lzr_index(PgfConcr* concr, PgfCCat* cat, PgfProduction prod,
              GuPool *pool)
{
	void* data = gu_variant_data(prod);
	switch (gu_variant_tag(prod)) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papply = data;
		PgfInferMap* infer =
			gu_map_get(concr->fun_indices, &papply->fun->fun,
				   PgfInferMap*);
		gu_debug("index: %s -> %d", papply->fun->fun, cat->fid);
		if (!infer) {
			infer = gu_map_type_new(PgfInferMap, pool);
			gu_map_put(concr->fun_indices,
				   &papply->fun->fun, PgfInferMap*, infer);
		}
		pgf_lzr_add_infer_entry(infer, cat, papply, pool);
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = data;
		PgfCCatBuf* cats = gu_map_get(concr->coerce_idx, pcoerce->coerce,
					      PgfCCatBuf*);
		if (!cats) {
			cats = gu_new_buf(PgfCCat*, pool);
			gu_map_put(concr->coerce_idx, 
				   pcoerce->coerce, PgfCCatBuf*, cats);
		}
		gu_debug("coerce_idx: %d -> %d", pcoerce->coerce->fid, cat->fid);
		gu_buf_push(cats, PgfCCat*, cat);
		break;
	}
	default:
		// Display warning?
		break;
	}
}

typedef struct PgfLzn PgfLzn;

struct PgfLzn {
	PgfConcr* concr;
	GuChoice* ch;
	PgfExpr expr;
	GuEnum en;
};


//
// PgfCncTree
//

typedef enum {
	PGF_CNC_TREE_APP,
	PGF_CNC_TREE_LIT,
} PgfCncTreeTag;

typedef struct PgfCncTreeApp PgfCncTreeApp;
struct PgfCncTreeApp {
	PgfCncFun* fun;
	GuLength n_args;
	PgfCncTree args[];
};

typedef struct PgfCncTreeLit PgfCncTreeLit;
struct PgfCncTreeLit {
	PgfLiteral lit;
};


static PgfCCat*
pgf_lzn_pick_supercat(PgfLzn* lzn, PgfCCat* cat)
{
	gu_enter("->");
	while (true) {
		PgfCCatBuf* supers =
			gu_map_get(lzn->concr->coerce_idx, cat, PgfCCatBuf*);
		if (!supers) {
			break;
		}
		gu_debug("n_supers: %d", gu_buf_length(supers));
		int ch = gu_choice_next(lzn->ch, gu_buf_length(supers) + 1);
		gu_debug("choice: %d", ch);
		if (ch == 0) {
			break;
		}
		cat = gu_buf_get(supers, PgfCCat*, ch - 1);
	}
	gu_exit("<- %d", cat->fid);
	return cat;
}

static PgfCCat*
pgf_lzn_infer(PgfLzn* lzn, PgfExpr expr, GuPool* pool, PgfCncTree* ctree_out);

static PgfCCat*
pgf_lzn_infer_apply_try(PgfLzn* lzn, PgfApplication* appl,
			PgfInferMap* infer, GuChoiceMark* marks,
			PgfCCatIds* arg_cats, int* ip, int n_args, 
			GuPool* pool, PgfCncTreeApp* app_out)
{
	gu_enter("f: %s, *ip: %d, n_args: %d", appl->fun, *ip, n_args);
	PgfCCat* ret = NULL;
	while (*ip < n_args) {
		PgfCncTree* arg_treep = 
			(app_out == NULL ? NULL : &app_out->args[*ip]);
		PgfCCat* arg_i = 
			pgf_lzn_infer(lzn, appl->args[*ip], pool, arg_treep);
		if (arg_i == NULL) {
			goto finish;
		}
		arg_i = pgf_lzn_pick_supercat(lzn, arg_i);
		gu_list_index(arg_cats, *ip) = arg_i;
		marks[++*ip] = gu_choice_mark(lzn->ch);
	}
	PgfLinInfers* entries = gu_map_get(infer, &arg_cats, PgfLinInfers*);
	if (!entries) {
		goto finish;
	}
	size_t n_entries = gu_buf_length(entries);
	int e = gu_choice_next(lzn->ch, n_entries);
	gu_debug("entry %d of %d", e, n_entries);
	if (e < 0) {
		goto finish;
	}
	PgfLinInferEntry* entry = gu_buf_index(entries, PgfLinInferEntry, e);
	if (app_out != NULL) {
		app_out->fun = entry->fun;
	}
	ret = entry->cat;
finish:
	gu_exit("fid: %d", ret ? ret->fid : -1);
	return ret;
}
typedef GuList(GuChoiceMark) PgfChoiceMarks;

static PgfCCat*
pgf_lzn_infer_application(PgfLzn* lzn, PgfApplication* appl, 
			  GuPool* pool, PgfCncTree* ctree_out)
{
	PgfInferMap* infer =
		gu_map_get(lzn->concr->fun_indices, &appl->fun, PgfInferMap*);
	gu_enter("-> f: %s, n_args: %d", appl->fun, appl->n_args);
	if (infer == NULL) {
		gu_exit("<- couldn't find f");
		return NULL;
	}
	GuPool* tmp_pool = gu_new_pool();
	PgfCCat* ret = NULL;
	int n = appl->n_args;
	PgfCCatIds* arg_cats = gu_new_list(PgfCCatIds, tmp_pool, n);

	PgfCncTreeApp* appt = NULL;
	if (ctree_out) {
		appt = gu_new_flex_variant(PGF_CNC_TREE_APP, PgfCncTreeApp, 
					   args, n, ctree_out, pool);
		appt->n_args = n;
	}

	PgfChoiceMarks* marksl = gu_new_list(PgfChoiceMarks, tmp_pool, n + 1);
	GuChoiceMark* marks = gu_list_elems(marksl);
	int i = 0;
	marks[i] = gu_choice_mark(lzn->ch);
	while (true) {
		ret = pgf_lzn_infer_apply_try(lzn, appl, infer,
					      marks, arg_cats,
					      &i, n, pool, appt);
		if (ret != NULL) {
			break;
		}

		do {
			--i;
			if (i < 0) {
				goto finish;
			}
			gu_choice_reset(lzn->ch, marks[i]);
		} while (!gu_choice_advance(lzn->ch));
	}
finish:
	gu_pool_free(tmp_pool);
	gu_exit("<- fid: %d", ret ? ret->fid : -1);
	return ret;
}

static PgfCCat*
pgf_lzn_infer(PgfLzn* lzn, PgfExpr expr, GuPool* pool, PgfCncTree* ctree_out)
{
	PgfCCat* ret = NULL;
	GuPool* tmp_pool = gu_new_pool();
	PgfApplication* appl = pgf_expr_unapply(expr, tmp_pool);
	if (appl != NULL) {
		ret = pgf_lzn_infer_application(lzn, appl, pool, ctree_out);
	} else {
		GuVariantInfo i = gu_variant_open(pgf_expr_unwrap(expr));
		switch (i.tag) {
		case PGF_EXPR_LIT: {
			PgfExprLit* elit = i.data;
			if (pool != NULL) {
				*ctree_out = gu_new_variant_i(
					pool, PGF_CNC_TREE_LIT,
					PgfCncTreeLit,
					.lit = elit->lit);
			}
			ret = pgf_literal_cat(elit->lit);
		}
		default:
			// XXX: should we do something here?
			break;
		}
	}
	gu_pool_free(tmp_pool);
	return ret;
}


static PgfCncTree
pgf_lzn_next(PgfLzn* lzn, GuPool* pool)
{
	// XXX: rewrite this whole mess
	PgfCncTree ctree = gu_null_variant;
	if (gu_variant_is_null(lzn->expr)) {
		return ctree;
	}
	PgfCCat* cat = NULL;
	GuChoiceMark mark = gu_choice_mark(lzn->ch);
	do {
		cat = pgf_lzn_infer(lzn, lzn->expr, NULL, NULL);
		gu_choice_reset(lzn->ch, mark);
	} while (!cat && gu_choice_advance(lzn->ch));

	if (cat) {
		PgfCCat* cat2 = pgf_lzn_infer(lzn, lzn->expr, pool, &ctree);
		gu_assert(cat == cat2);
		gu_debug("fid: %d", cat->fid);
		gu_choice_reset(lzn->ch, mark);
		if (!gu_choice_advance(lzn->ch)) {
			lzn->expr = gu_null_variant;
		}
	}
	return ctree;
}

static void
pgf_cnc_tree_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfLzn* lzn = gu_container(self, PgfLzn, en);
	PgfCncTree* toc = to;
	*toc = pgf_lzn_next(lzn, pool);
}

PgfCncTreeEnum*
pgf_lzr_concretize(PgfConcr* concr, PgfExpr expr, GuPool* pool)
{
	PgfLzn* lzn = gu_new(PgfLzn, pool);
	lzn->concr = concr;
	lzn->expr = expr;
	lzn->ch = gu_new_choice(pool);
	lzn->en.next = pgf_cnc_tree_enum_next;
	return &lzn->en;
}


int
pgf_cnc_tree_dimension(PgfCncTree ctree)
{
	GuVariantInfo cti = gu_variant_open(ctree);
	switch (cti.tag) {
	case PGF_CNC_TREE_LIT: 
		return 1;
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* fapp = cti.data;
		return fapp->fun->n_lins;
	}
	default:
		gu_impossible();
		return 0;
	}
}

void
pgf_lzr_linearize(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx, PgfLinFuncs** fnsp)
{
	PgfLinFuncs* fns = *fnsp;
	GuVariantInfo cti = gu_variant_open(ctree);

	switch (cti.tag) {
	case PGF_CNC_TREE_LIT: {
		gu_require(lin_idx == 0);
		PgfCncTreeLit* flit = cti.data;
		if (fns->expr_literal) {
			fns->expr_literal(fnsp, flit->lit);
		}
		break;
	}
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* fapp = cti.data;
		PgfCncFun* fun = fapp->fun;
		if (fns->expr_apply) {
			fns->expr_apply(fnsp, fun->fun, fapp->n_args);
		}
		gu_require(lin_idx < fun->n_lins);
		PgfSequence seq = fun->lins[lin_idx];
		size_t nsyms = gu_seq_length(seq);
		PgfSymbol* syms = gu_seq_data(seq);
		for (size_t i = 0; i < nsyms; i++) {
			PgfSymbol sym = syms[i];
			GuVariantInfo sym_i = gu_variant_open(sym);
			switch (sym_i.tag) {
			case PGF_SYMBOL_CAT:
			case PGF_SYMBOL_VAR:
			case PGF_SYMBOL_LIT: {
				PgfSymbolIdx* sidx = sym_i.data;
				gu_assert((unsigned) sidx->d < fapp->n_args);
				PgfCncTree argf = fapp->args[sidx->d];
				pgf_lzr_linearize(concr, argf, sidx->r, fnsp);
				break;
			}
			case PGF_SYMBOL_KS: {
				PgfSymbolKS* ks = sym_i.data;
				if (fns->symbol_tokens) {
					fns->symbol_tokens(fnsp, ks->tokens);
				}
				break;
			}
			case PGF_SYMBOL_KP: {
				// TODO: correct prefix-dependencies
				PgfSymbolKP* kp = sym_i.data;
				if (fns->symbol_tokens) {
					fns->symbol_tokens(fnsp,
							   kp->default_form);
				}
				break;
			}
			default:
				gu_impossible(); 
			}
		}
		break;
	} // case PGF_CNC_TREE_APP
	default:
		gu_impossible();
	}
}



typedef struct PgfSimpleLin PgfSimpleLin;

struct PgfSimpleLin {
	PgfLinFuncs* funcs;
	GuWriter* wtr;
	GuExn* err;
};

static void
pgf_file_lzn_symbol_tokens(PgfLinFuncs** funcs, PgfTokens toks)
{
	PgfSimpleLin* flin = gu_container(funcs, PgfSimpleLin, funcs);
	if (!gu_ok(flin->err)) {
		return;
	}
	size_t len = gu_seq_length(toks);
	for (size_t i = 0; i < len; i++) {
		PgfToken tok = gu_seq_get(toks, PgfToken, i);
		gu_string_write(tok, flin->wtr, flin->err);
		gu_putc(' ', flin->wtr, flin->err);
	}
}

static PgfLinFuncs pgf_file_lin_funcs = {
	.symbol_tokens = pgf_file_lzn_symbol_tokens
};

void
pgf_lzr_linearize_simple(PgfConcr* concr, PgfCncTree ctree,
			 size_t lin_idx, GuWriter* wtr, GuExn* err)
{
	PgfSimpleLin flin = {
		.funcs = &pgf_file_lin_funcs,
		.wtr = wtr,
		.err = err
	};
	pgf_lzr_linearize(concr, ctree, lin_idx, &flin.funcs);
}
