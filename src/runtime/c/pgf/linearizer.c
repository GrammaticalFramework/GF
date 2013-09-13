#include "data.h"
#include "linearizer.h"
#include <gu/map.h>
#include <gu/fun.h>
#include <gu/choice.h>
#include <gu/seq.h>
#include <gu/file.h>
#include <gu/string.h>
#include <gu/assert.h>
#include <pgf/expr.h>
#include <pgf/literals.h>
#include <stdio.h>

//#define PGF_LINEARIZER_DEBUG

GU_DEFINE_TYPE(PgfCncOverloadMap, GuMap,
               gu_type(PgfCCat), NULL,
               gu_ptr_type(GuBuf), &gu_null_struct);

GU_DEFINE_TYPE(PgfCncFunOverloadMap, GuStringMap, gu_ptr_type(PgfCncOverloadMap),
               &gu_null_struct);

static void
pgf_lzr_add_overl_entry(PgfCncOverloadMap* overl_table,
			            PgfCCat* ccat, void* entry,
			            GuPool *pool)
{
	GuBuf* entries =
		gu_map_get(overl_table, ccat, GuBuf*);
	if (entries == NULL) {
		entries = gu_new_buf(void*, pool);
		gu_map_put(overl_table, ccat, GuBuf*, entries);
	}

	gu_buf_push(entries, void*, entry);
}

void
pgf_lzr_index(PgfConcr* concr, 
              PgfCCat* ccat, PgfProduction prod,
              GuPool *pool)
{
	void* data = gu_variant_data(prod);
	switch (gu_variant_tag(prod)) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply* papply = data;
		PgfCncOverloadMap* overl_table =
			gu_map_get(concr->fun_indices, &papply->fun->absfun->name,
				PgfCncOverloadMap*);
		if (!overl_table) {
			overl_table = gu_map_type_new(PgfCncOverloadMap, pool);
			gu_map_put(concr->fun_indices,
				&papply->fun->absfun->name, PgfCncOverloadMap*, overl_table);
		}
		pgf_lzr_add_overl_entry(overl_table, ccat, papply, pool);
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = data;
		pgf_lzr_add_overl_entry(concr->coerce_idx, ccat, pcoerce, pool);
		break;
	}
	default:
		gu_impossible();
	}
}

typedef struct PgfLzn PgfLzn;

struct PgfLzn {
	PgfConcr* concr;
	GuChoice* ch;
	PgfExpr expr;
	int fid;
	GuEnum en;
};


//
// PgfCncTree
//

typedef enum {
	PGF_CNC_TREE_APP,
	PGF_CNC_TREE_CHUNKS,
	PGF_CNC_TREE_LIT,
} PgfCncTreeTag;

typedef struct {
	PgfCncFun* fun;
	int fid;
	GuLength n_args;
	PgfCncTree args[];
} PgfCncTreeApp;

typedef struct {
	GuLength n_args;
	PgfCncTree args[];
} PgfCncTreeChunks;

typedef struct {
	int fid;
	PgfLiteral lit;
} PgfCncTreeLit;

#ifdef PGF_LINEARIZER_DEBUG
void
pgf_print_cnc_tree(PgfCncTree ctree, GuWriter* wtr, GuExn* err)
{
	GuVariantInfo ti = gu_variant_open(ctree);
	switch (ti.tag) {
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* capp = ti.data;
		if (capp->n_args > 0) gu_putc('(', wtr, err);
		gu_printf(wtr, err, "F%d", capp->fun->funid);
		for (size_t i = 0; i < capp->n_args; i++) {
			gu_putc(' ', wtr, err);
			pgf_print_cnc_tree(capp->args[i], wtr, err);
		}
		if (capp->n_args > 0) gu_putc(')', wtr, err);
		break;
	}
	case PGF_CNC_TREE_CHUNKS: {
		PgfCncTreeChunks* chunks = ti.data;
		if (chunks->n_args > 0) gu_putc('(', wtr, err);
		gu_putc('?', wtr, err);
		for (size_t i = 0; i < chunks->n_args; i++) {
			gu_putc(' ', wtr, err);
			pgf_print_cnc_tree(chunks->args[i], wtr, err);
		}
		if (chunks->n_args > 0) gu_putc(')', wtr, err);
		break;
	}
	case PGF_CNC_TREE_LIT: {
		PgfCncTreeLit* clit = ti.data;
		pgf_print_literal(clit->lit, wtr, err);
		break;
	}
	case GU_VARIANT_NULL:
		gu_puts("null", wtr, err);
		break;
	default:
		gu_impossible();
	}
}
#endif

static PgfCncTree
pgf_lzn_resolve(PgfLzn* lzn, PgfExpr expr, PgfCCat* ccat, GuPool* pool);

static PgfCncTree
pgf_lzn_resolve_app(PgfLzn* lzn, GuBuf* buf, GuBuf* args, GuPool* pool)
{
	GuChoiceMark mark = gu_choice_mark(lzn->ch);
	int save_fid = lzn->fid;

	size_t n_args = gu_buf_length(args);

	PgfCncTree ret = gu_null_variant;
	PgfCncTreeApp* capp =
		gu_new_flex_variant(PGF_CNC_TREE_APP,
							PgfCncTreeApp,
							args, n_args, &ret, pool);

redo:;
	int index = gu_choice_next(lzn->ch, gu_buf_length(buf));
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
		PgfPArg* parg = gu_seq_index(papply->args, PgfPArg, i);
		PgfExpr  earg = gu_buf_get(args, PgfExpr, n_args-i-1);

		PgfCCat* ccat = NULL;
		GuBuf* coercions =
			gu_map_get(lzn->concr->coerce_idx, parg->ccat, GuBuf*);
		if (coercions == NULL) {
			ccat = parg->ccat;
		} else {
			int index = gu_choice_next(lzn->ch, gu_buf_length(coercions));
			if (index < 0) {
				lzn->fid = save_fid;
				gu_choice_reset(lzn->ch, mark);
				if (!gu_choice_advance(lzn->ch))
					return gu_null_variant;
				goto redo;
			}

			PgfProductionCoerce* pcoerce =
				gu_buf_get(coercions, PgfProductionCoerce*, index);
			ccat = pcoerce->coerce;
		}

		capp->args[i] =
			pgf_lzn_resolve(lzn, earg, ccat, pool);
		if (gu_variant_is_null(capp->args[i])) {
			lzn->fid = save_fid;
			gu_choice_reset(lzn->ch, mark);
			if (!gu_choice_advance(lzn->ch))
				return gu_null_variant;
			goto redo;
		}
	}

	capp->fid = lzn->fid++;

	return ret;
}

static PgfCncTree
pgf_lzn_resolve_def(PgfLzn* lzn, PgfCncFuns* lindefs, GuString s, GuPool* pool)
{
	PgfCncTree lit = gu_null_variant;
	PgfCncTree ret = gu_null_variant;

	PgfCncTreeLit* clit =
		gu_new_variant(PGF_CNC_TREE_LIT,
					   PgfCncTreeLit,
					   &lit, pool);
	clit->fid = lzn->fid++;
	clit->lit =
		gu_new_variant_i(pool,
					 PGF_LITERAL_STR,
					 PgfLiteralStr,
					 s);

	if (lindefs == NULL)
		return lit;

	int index =
		gu_choice_next(lzn->ch, gu_list_length(lindefs));
	if (index < 0) {
		return ret;
	}
	PgfCncTreeApp* capp =
		gu_new_flex_variant(PGF_CNC_TREE_APP,
							PgfCncTreeApp,
							args, 1, &ret, pool);
	capp->fun = gu_list_index(lindefs, index);
	capp->fid = lzn->fid++;
	capp->n_args = 1;
	capp->args[0] = lit;
	
	return ret;
}

typedef struct {
	GuMapItor fn;
	GuBuf* buf;
} PgfLznItor;

static void
pgf_lzn_cat_resolve_itor(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfLznItor* clo = (PgfLznItor*) fn;
	GuBuf* buf = *((GuBuf**) value);
	
	for (size_t i = 0; i < gu_buf_length(buf); i++) {
		PgfProductionApply* apply = 
			gu_buf_get(buf, PgfProductionApply*, i);
		gu_buf_push(clo->buf, PgfProductionApply*, apply);
	}
}

static PgfCncTree
pgf_lzn_resolve(PgfLzn* lzn, PgfExpr expr, PgfCCat* ccat, GuPool* pool)
{
	PgfCncTree ret = gu_null_variant;
	GuPool* tmp_pool = gu_new_pool();
	GuBuf* args = gu_new_buf(PgfExpr, tmp_pool);

	for (;;) {
		GuVariantInfo i = gu_variant_open(expr);
		switch (i.tag) {
		case PGF_EXPR_APP: {
			PgfExprApp* eapp = i.data;
			gu_buf_push(args, PgfExpr, eapp->arg);
			expr = eapp->fun;
			break;
		}
		case PGF_EXPR_LIT: {
			PgfExprLit* elit = i.data;
			PgfCncTreeLit* clit = 
				gu_new_variant(PGF_CNC_TREE_LIT,
				               PgfCncTreeLit,
				               &ret, pool);
			clit->fid = lzn->fid++;
			clit->lit = elit->lit;
			goto done;
		}
		case PGF_EXPR_META: {
			if (ccat == NULL) {
				size_t n_args = gu_buf_length(args);

				PgfCncTreeChunks* chunks = 
					gu_new_flex_variant(PGF_CNC_TREE_CHUNKS,
								PgfCncTreeChunks,
								args, n_args, &ret, pool);
				chunks->n_args = n_args;

				for (size_t i = 0; i < n_args; i++) {
					PgfExpr earg = gu_buf_get(args, PgfExpr, n_args-i-1);
					chunks->args[i] = pgf_lzn_resolve(lzn, earg, NULL, pool);
					if (gu_variant_is_null(chunks->args[i])) {
						ret = gu_null_variant;
						break;
					}
				}

				goto done;
			} else {
				if (ccat->lindefs == NULL) {
					goto done;
				}

				GuString s = gu_str_string("?", pool);
				ret = pgf_lzn_resolve_def(lzn, ccat->lindefs, s, pool);
				goto done;
			}
		}
		case PGF_EXPR_FUN: {
			PgfExprFun* efun = i.data;

			PgfCncOverloadMap* overl_table =
				gu_map_get(lzn->concr->fun_indices, &efun->fun, PgfCncOverloadMap*);
			if (overl_table == NULL) {
				if (ccat != NULL && ccat->lindefs == NULL) {
					goto done;
				}

				GuPool* tmp_pool = gu_local_pool();
				GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);
				GuStringBuf* sbuf = gu_string_buf(tmp_pool);
				GuOut* out = gu_string_buf_out(sbuf);

				gu_putc('[', out, err);
				gu_string_write(efun->fun, out, err);
				gu_putc(']', out, err);
				GuString s = gu_string_buf_freeze(sbuf, pool);

				if (ccat != NULL) {
					ret = pgf_lzn_resolve_def(lzn, ccat->lindefs, s, pool);
				} else {
					PgfCncTreeLit* clit = 
						gu_new_variant(PGF_CNC_TREE_LIT,
									   PgfCncTreeLit,
									   &ret, pool);
					clit->fid = lzn->fid++;
					PgfLiteralStr* lit = 
						gu_new_variant(PGF_LITERAL_STR,
									   PgfLiteralStr,
									   &clit->lit, pool);
					lit->val = s;
				}

				gu_pool_free(tmp_pool);
				goto done;
			}

			if (ccat == NULL) {
				GuPool* tmp_pool = gu_local_pool();
				GuBuf* buf =
					gu_new_buf(PgfProductionApply*, tmp_pool);
				PgfLznItor clo = { { pgf_lzn_cat_resolve_itor }, buf };
				gu_map_iter(overl_table, &clo.fn, NULL);
				ret = pgf_lzn_resolve_app(lzn, buf, args, pool);
				gu_pool_free(tmp_pool);
			} else {
				GuBuf* buf =
					gu_map_get(overl_table, ccat, GuBuf*);
				if (buf == NULL) {
					goto done;
				}
				
				ret = pgf_lzn_resolve_app(lzn, buf, args, pool);
			}
			goto done;
		}
		case PGF_EXPR_TYPED: {
			PgfExprTyped* etyped = i.data;
			expr = etyped->expr;
			break;
		}
		case PGF_EXPR_IMPL_ARG: {
			PgfExprImplArg* eimpl = i.data;
			expr = eimpl->expr;
			break;
		}
		default:
			gu_impossible();
		}
	}
	
done:
	gu_pool_free(tmp_pool);
	return ret;
}

static void
pgf_cnc_tree_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfLzn* lzn = gu_container(self, PgfLzn, en);
	PgfCncTree* toc = to;

	if (lzn->ch == NULL) {
		*toc = gu_null_variant;
		return;
	}

	lzn->fid = 0;

	GuChoiceMark mark = gu_choice_mark(lzn->ch);
	*toc = pgf_lzn_resolve(lzn, lzn->expr, NULL, pool);
	gu_choice_reset(lzn->ch, mark);

#ifdef PGF_LINEARIZER_DEBUG
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    if (gu_variant_is_null(*toc))
		gu_puts("*nil*\n", wtr, err);
	else {
		pgf_print_cnc_tree(*toc, wtr, err);
		gu_puts("\n", wtr, err);
	}
    gu_pool_free(tmp_pool);
#endif

	if (!gu_choice_advance(lzn->ch)) {
		lzn->ch = NULL;
	}
}

PgfCncTreeEnum*
pgf_lzr_concretize(PgfConcr* concr, PgfExpr expr, GuPool* pool)
{
	PgfLzn* lzn = gu_new(PgfLzn, pool);
	lzn->concr = concr;
	lzn->expr = expr;
	lzn->fid = 0;
	lzn->ch = gu_new_choice(pool);
	lzn->en.next = pgf_cnc_tree_enum_next;
	return &lzn->en;
}

void
pgf_lzr_linearize(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx, PgfLinFuncs** fnsp)
{
	PgfLinFuncs* fns = *fnsp;
	GuVariantInfo cti = gu_variant_open(ctree);

	switch (cti.tag) {
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* fapp = cti.data;
		PgfCncFun* fun = fapp->fun;

		if (fns->begin_phrase) {
			fns->begin_phrase(fnsp,
							  fun->absfun->type->cid,
							  fapp->fid, lin_idx,
							  fun->absfun->name);
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
			case PGF_SYMBOL_NE: {
				// Nothing to be done here
				break;
			}
			default:
				gu_impossible(); 
			}
		}
		
		if (fns->end_phrase) {
			fns->end_phrase(fnsp,
							fun->absfun->type->cid,
							fapp->fid, lin_idx,
							fun->absfun->name);
		}
		break;
	}
	case PGF_CNC_TREE_CHUNKS: {
		gu_require(lin_idx == 0);
		PgfCncTreeChunks* fchunks = cti.data;
		for (size_t i = 0; i < fchunks->n_args; i++) {
			pgf_lzr_linearize(concr, fchunks->args[i], 0, fnsp);
		}
		break;
	}
	case PGF_CNC_TREE_LIT: {
		gu_require(lin_idx == 0);
		PgfCncTreeLit* flit = cti.data;

		PgfCId cat =
			pgf_literal_cat(concr, flit->lit)->cnccat->abscat->name;
		
		if (fns->begin_phrase) {
			fns->begin_phrase(fnsp,
							  cat, flit->fid, 0,
							  gu_empty_string);
		}

		if (fns->expr_literal) {
			fns->expr_literal(fnsp, flit->lit);
		}

		if (fns->end_phrase) {
			fns->end_phrase(fnsp,
							cat, flit->fid, 0,
							gu_empty_string);
		}

		break;
	}
	default:
		gu_impossible();
	}
}



typedef struct PgfSimpleLin PgfSimpleLin;

struct PgfSimpleLin {
	PgfLinFuncs* funcs;
	int n_tokens;
	GuOut* out;
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
		if (flin->n_tokens > 0)
			gu_putc(' ', flin->out, flin->err);

		PgfToken tok = gu_seq_get(toks, PgfToken, i);
		gu_string_write(tok, flin->out, flin->err);
		
		flin->n_tokens++;
	}
}

static void
pgf_file_lzn_expr_literal(PgfLinFuncs** funcs, PgfLiteral lit)
{
	PgfSimpleLin* flin = gu_container(funcs, PgfSimpleLin, funcs);
	if (!gu_ok(flin->err)) {
		return;
	}

	if (flin->n_tokens > 0)
		gu_putc(' ', flin->out, flin->err);

	GuVariantInfo i = gu_variant_open(lit);
    switch (i.tag) {
    case PGF_LITERAL_STR: {
        PgfLiteralStr* lstr = i.data;
		gu_string_write(lstr->val, flin->out, flin->err);
		break;
	}
    case PGF_LITERAL_INT: {
        PgfLiteralInt* lint = i.data;
		gu_printf(flin->out, flin->err, "%d", lint->val);
		break;
	}
    case PGF_LITERAL_FLT: {
        PgfLiteralFlt* lflt = i.data;
		gu_printf(flin->out, flin->err, "%lf", lflt->val);
		break;
	}
	default:
		gu_impossible();
	}

	flin->n_tokens++;
}

static PgfLinFuncs pgf_file_lin_funcs = {
	.symbol_tokens = pgf_file_lzn_symbol_tokens,
	.expr_literal  = pgf_file_lzn_expr_literal,
	.begin_phrase  = NULL,
	.end_phrase    = NULL,
};

void
pgf_lzr_linearize_simple(PgfConcr* concr, PgfCncTree ctree,
			 size_t lin_idx, GuOut* out, GuExn* err)
{
	PgfSimpleLin flin = {
		.funcs = &pgf_file_lin_funcs,
		.n_tokens = 0,
		.out = out,
		.err = err
	};
	pgf_lzr_linearize(concr, ctree, lin_idx, &flin.funcs);
}
