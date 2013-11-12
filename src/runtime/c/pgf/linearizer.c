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
			gu_map_get(concr->fun_indices, papply->fun->absfun->name,
				PgfCncOverloadMap*);
		if (!overl_table) {
			overl_table = gu_map_type_new(PgfCncOverloadMap, pool);
			gu_map_put(concr->fun_indices,
				papply->fun->absfun->name, PgfCncOverloadMap*, overl_table);
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
	PgfCCat* ccat;
	PgfCncFun* fun;
	int fid;

	size_t n_vars;
	PgfPrintContext* context;

	size_t n_args;
	PgfCncTree args[];
} PgfCncTreeApp;

typedef struct {
	size_t n_vars;
	PgfPrintContext* context;

	GuLength n_args;
	PgfCncTree args[];
} PgfCncTreeChunks;

typedef struct {
	size_t n_vars;
	PgfPrintContext* context;

	int fid;
	PgfLiteral lit;
} PgfCncTreeLit;

#ifdef PGF_LINEARIZER_DEBUG
void
pgf_print_cnc_tree_vars(size_t n_vars, PgfPrintContext* context,
                        GuOut* out, GuExn* err)
{
	if (n_vars > 0) {
		gu_putc('\\', out, err);
		for (;;) {
			gu_string_write(context->name, out, err);
			n_vars--;

			if (n_vars > 0)
				gu_putc(',', out, err);
			else
				break;
		}
		gu_puts(" -> ", out, err);
	}
}

void
pgf_print_cnc_tree(PgfCncTree ctree, GuOut* out, GuExn* err)
{
	GuVariantInfo ti = gu_variant_open(ctree);
	switch (ti.tag) {
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* capp = ti.data;
		if (capp->n_vars+capp->n_args > 0) gu_putc('(', out, err);
		pgf_print_cnc_tree_vars(capp->n_vars, capp->context, out, err);
		gu_printf(out, err, "F%d", capp->fun->funid);
		for (size_t i = 0; i < capp->n_args; i++) {
			gu_putc(' ', out, err);
			pgf_print_cnc_tree(capp->args[i], out, err);
		}
		if (capp->n_vars+capp->n_args > 0) gu_putc(')', out, err);
		break;
	}
	case PGF_CNC_TREE_CHUNKS: {
		PgfCncTreeChunks* chunks = ti.data;
		if (chunks->n_vars+chunks->n_args > 0) gu_putc('(', out, err);
		pgf_print_cnc_tree_vars(chunks->n_vars, chunks->context, out, err);
		gu_putc('?', out, err);
		for (size_t i = 0; i < chunks->n_args; i++) {
			gu_putc(' ', out, err);
			pgf_print_cnc_tree(chunks->args[i], out, err);
		}
		if (chunks->n_vars+chunks->n_args > 0) gu_putc(')', out, err);
		break;
	}
	case PGF_CNC_TREE_LIT: {
		PgfCncTreeLit* clit = ti.data;
		if (clit->n_vars > 0) gu_putc('(', out, err);
		pgf_print_cnc_tree_vars(clit->n_vars, clit->context, out, err);
		pgf_print_literal(clit->lit, out, err);
		if (clit->n_vars > 0) gu_putc(')', out, err);
		break;
	}
	case GU_VARIANT_NULL:
		gu_puts("null", out, err);
		break;
	default:
		gu_impossible();
	}
}
#endif

static PgfCncTree
pgf_lzn_resolve(PgfLzn* lzn, 
                PgfPrintContext* context, PgfExpr expr,
                PgfCCat* ccat,
                GuPool* pool);

static PgfCncTree
pgf_lzn_resolve_app(PgfLzn* lzn,
                    size_t n_vars, PgfPrintContext* context,
                    PgfCCat* ccat, GuBuf* buf, GuBuf* args,
                    GuPool* pool)
{
	GuChoiceMark mark = gu_choice_mark(lzn->ch);
	int save_fid = lzn->fid;

	size_t n_args = gu_buf_length(args);

	PgfCncTree ret = gu_null_variant;
	PgfCncTreeApp* capp =
		gu_new_flex_variant(PGF_CNC_TREE_APP,
							PgfCncTreeApp,
							args, n_args, &ret, pool);
	capp->ccat    = ccat;
	capp->n_vars  = n_vars;
	capp->context = context;

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
			pgf_lzn_resolve(lzn, context, earg, ccat, pool);
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
pgf_lzn_resolve_def(PgfLzn* lzn,
                    size_t n_vars, PgfPrintContext* context,
                    PgfCCat* ccat, GuString s, GuPool* pool)
{
	PgfCncTree lit = gu_null_variant;
	PgfCncTree ret = gu_null_variant;

	PgfCncTreeLit* clit =
		gu_new_variant(PGF_CNC_TREE_LIT,
					   PgfCncTreeLit,
					   &lit, pool);
	clit->n_vars  = 0;
	clit->context = context;
	clit->fid = lzn->fid++;
	PgfLiteralStr* lit_str =
		gu_new_flex_variant(PGF_LITERAL_STR,
					        PgfLiteralStr,
					        val, strlen(s)+1,
					        &clit->lit, pool);
	strcpy((char*) lit_str->val, (char*) s);

	if (ccat->lindefs == NULL)
		return lit;

	int index =
		gu_choice_next(lzn->ch, gu_seq_length(ccat->lindefs));
	if (index < 0) {
		return ret;
	}
	PgfCncTreeApp* capp =
		gu_new_flex_variant(PGF_CNC_TREE_APP,
							PgfCncTreeApp,
							args, 1, &ret, pool);
	capp->ccat = ccat;
	capp->fun = gu_seq_get(ccat->lindefs, PgfCncFun*, index);
	capp->fid = lzn->fid++;
	capp->n_vars  = n_vars;
	capp->context = context;
	capp->n_args  = 1;
	capp->args[0] = lit;

	return ret;
}

typedef struct {
	GuMapItor fn;
	int index;
	PgfCCat* ccat;
	GuBuf* buf;
} PgfLznItor;

static void
pgf_lzn_cat_resolve_itor(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfLznItor* clo = (PgfLznItor*) fn;
	PgfCCat* ccat = (PgfCCat*) key;
	GuBuf* buf = *((GuBuf**) value);

	if (clo->index == 0) {
		clo->ccat = ccat;
		clo->buf = buf;
	}

	clo->index--;
}

PgfCncTree
pgf_lzr_wrap_linref(PgfCncTree ctree, GuPool* pool)
{
	GuVariantInfo cti = gu_variant_open(ctree);
	switch (cti.tag) {
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* capp = cti.data;

		assert(gu_seq_length(capp->ccat->linrefs) > 0);
	
		// here we must apply the linref function
		PgfCncTree new_ctree;
		PgfCncTreeApp* new_capp =
			gu_new_flex_variant(PGF_CNC_TREE_APP,
						PgfCncTreeApp,
						args, 1, &new_ctree, pool);
		new_capp->ccat    = NULL;
		new_capp->fun     = gu_seq_get(capp->ccat->linrefs, PgfCncFun*, 0);
		new_capp->fid     = -1;
		new_capp->n_vars  = 0;
		new_capp->context = NULL;
		new_capp->n_args  = 1;
		new_capp->args[0] = ctree;

		ctree = new_ctree;
		break;
	}
	}
	
	return ctree;
}

static PgfCncTree
pgf_lzn_resolve(PgfLzn* lzn, 
                PgfPrintContext* context, PgfExpr expr,
                PgfCCat* ccat, 
                GuPool* pool)
{
	PgfCncTree ret = gu_null_variant;
	GuPool* tmp_pool = gu_new_pool();
	size_t n_vars = 0;
	GuBuf* args = gu_new_buf(PgfExpr, tmp_pool);

	for (;;) {
		GuVariantInfo i = gu_variant_open(expr);
		switch (i.tag) {
		case PGF_EXPR_ABS: {
			PgfExprAbs* eabs = i.data;

			PgfPrintContext* new_context = gu_new(PgfPrintContext, pool);
			new_context->name = eabs->id;
			new_context->next = context;
			context = new_context;
			
			n_vars++;
			
			expr = eabs->body;
			break;
		}
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
			clit->n_vars  = n_vars;
			clit->context = context;
			clit->fid = lzn->fid++;
			clit->lit = elit->lit;
			goto done;
		}
		case PGF_EXPR_META: {
			size_t n_args = gu_buf_length(args);

			PgfCncTree chunks_tree;
			PgfCncTreeChunks* chunks = 
				gu_new_flex_variant(PGF_CNC_TREE_CHUNKS,
				                    PgfCncTreeChunks,
				                    args, n_args, &chunks_tree, pool);
			chunks->n_vars  = n_vars;
			chunks->context = context;
			chunks->n_args = n_args;

			for (size_t i = 0; i < n_args; i++) {
				PgfExpr earg = gu_buf_get(args, PgfExpr, n_args-i-1);
				chunks->args[i] = pgf_lzn_resolve(lzn, context, earg, NULL, pool);
				if (gu_variant_is_null(chunks->args[i])) {
					ret = gu_null_variant;
					goto done;
				}
				chunks->args[i] = 
					pgf_lzr_wrap_linref(chunks->args[i], pool);
			}

			if (ccat == NULL) {
				ret = chunks_tree;
				goto done;
			}
			if (ccat->lindefs == NULL) {
				goto done;
			}

			int index =
				gu_choice_next(lzn->ch, gu_seq_length(ccat->lindefs));
			if (index < 0) {
				return ret;
			}
			PgfCncTreeApp* capp =
				gu_new_flex_variant(PGF_CNC_TREE_APP,
									PgfCncTreeApp,
									args, 1, &ret, pool);
			capp->ccat = ccat;
			capp->fun = gu_seq_get(ccat->lindefs, PgfCncFun*, index);
			capp->fid = lzn->fid++;
			capp->n_vars = 0;
			capp->context = context;
			capp->n_args = 1;
			capp->args[0] = chunks_tree;

			goto done;
		}
		case PGF_EXPR_FUN: {
			PgfExprFun* efun = i.data;

			PgfCncOverloadMap* overl_table =
				gu_map_get(lzn->concr->fun_indices, efun->fun, PgfCncOverloadMap*);
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
				GuString s = gu_string_buf_freeze(sbuf, tmp_pool);

				if (ccat != NULL) {
					ret = pgf_lzn_resolve_def(lzn, n_vars, context, ccat, s, pool);
				} else {
					PgfCncTreeLit* clit = 
						gu_new_variant(PGF_CNC_TREE_LIT,
									   PgfCncTreeLit,
									   &ret, pool);
					clit->n_vars = 0;
					clit->context = context;
					clit->fid = lzn->fid++;
					PgfLiteralStr* lit = 
						gu_new_flex_variant(PGF_LITERAL_STR,
									        PgfLiteralStr,
									        val, strlen(s)+1,
									        &clit->lit, pool);
					strcpy(lit->val, s);
				}

				gu_pool_free(tmp_pool);
				goto done;
			}

			if (ccat == NULL) {
				size_t n_count = gu_map_count(overl_table);
				GuChoiceMark mark = gu_choice_mark(lzn->ch);

redo:;
				int index = gu_choice_next(lzn->ch, n_count);
				if (index < 0) {
					goto done;
				}

				PgfLznItor clo = { { pgf_lzn_cat_resolve_itor }, index, NULL, NULL };
				gu_map_iter(overl_table, &clo.fn, NULL);
				assert(clo.ccat != NULL && clo.buf != NULL);

				ret = pgf_lzn_resolve_app(lzn, n_vars, context, clo.ccat, clo.buf, args, pool);
				if (gu_variant_is_null(ret)) {
					gu_choice_reset(lzn->ch, mark);
					if (gu_choice_advance(lzn->ch))
						goto redo;
				}
			} else {
				GuBuf* buf =
					gu_map_get(overl_table, ccat, GuBuf*);
				if (buf == NULL) {
					goto done;
				}

				ret = pgf_lzn_resolve_app(lzn, n_vars, context, ccat, buf, args, pool);
			}
			goto done;
		}
		case PGF_EXPR_VAR: {
			PgfExprVar* evar = i.data;
			
			int index = evar->var;
			PgfPrintContext* ctxt = context;
			while (index > 0) {
				assert (ctxt != NULL);
				ctxt = ctxt->next;
				index--;
			}

			if (ccat != NULL && ccat->lindefs == NULL) {
				goto done;
			}

			if (ccat != NULL) {
				ret = pgf_lzn_resolve_def(lzn, n_vars, context, ccat, ctxt->name, pool);
			} else {
				PgfCncTreeLit* clit = 
					gu_new_variant(PGF_CNC_TREE_LIT,
								   PgfCncTreeLit,
								   &ret, pool);
				clit->n_vars  = 0;
				clit->context = context;
				clit->fid = lzn->fid++;
				PgfLiteralStr* lit = 
					gu_new_flex_variant(PGF_LITERAL_STR,
								        PgfLiteralStr,
								        val, strlen(ctxt->name)+1,
								        &clit->lit, pool);
				strcpy(lit->val, ctxt->name);
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
	*toc = pgf_lzn_resolve(lzn, NULL, lzn->expr, NULL, pool);
	gu_choice_reset(lzn->ch, mark);

#ifdef PGF_LINEARIZER_DEBUG
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    if (gu_variant_is_null(*toc))
		gu_puts("*nil*\n", out, err);
	else {
		pgf_print_cnc_tree(*toc, out, err);
		gu_puts("\n", out, err);
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
pgf_lzr_linearize_var(PgfConcr* concr, PgfCncTree ctree, size_t var_idx, PgfLinFuncs** fnsp)
{
	GuVariantInfo cti = gu_variant_open(ctree);

	size_t n_vars = 0;
	PgfPrintContext* context = NULL;
	
	switch (cti.tag) {
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* fapp = cti.data;
		n_vars  = fapp->n_vars;
		context = fapp->context;
		break;
	}
	case PGF_CNC_TREE_CHUNKS: {
		PgfCncTreeChunks* fchunks = cti.data;
		n_vars  = fchunks->n_vars;
		context = fchunks->context;
		break;
	}
	case PGF_CNC_TREE_LIT: {
		PgfCncTreeLit* flit = cti.data;
		n_vars  = flit->n_vars;
		context = flit->context;
		break;
	}
	default:
		gu_impossible();
	}

	n_vars -= var_idx+1;
	while (n_vars > 0) {
		context = context->next;
		n_vars--;
	}

	if ((*fnsp)->symbol_token) {
		(*fnsp)->symbol_token(fnsp, context->name);
	}
}

void
pgf_lzr_linearize_symbols(PgfConcr* concr, PgfCncTreeApp* fapp,
                          PgfSymbols* syms, uint16_t sym_idx,
                          PgfLinFuncs** fnsp)
{
	size_t nsyms = gu_seq_length(syms);
	for (size_t i = sym_idx; i < nsyms; i++) {
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, i);
		GuVariantInfo sym_i = gu_variant_open(sym);
		switch (sym_i.tag) {
		case PGF_SYMBOL_CAT:
		case PGF_SYMBOL_LIT: {
			if (fapp == NULL)
				return;

			PgfSymbolIdx* sidx = sym_i.data;
			gu_assert((unsigned) sidx->d < fapp->n_args);

			PgfCncTree argf = fapp->args[sidx->d];
			pgf_lzr_linearize(concr, argf, sidx->r, fnsp);
			break;
		}
		case PGF_SYMBOL_VAR: {
			if (fapp == NULL)
				return;

			PgfSymbolIdx* sidx = sym_i.data;
			gu_assert((unsigned) sidx->d < fapp->n_args);

			PgfCncTree argf = fapp->args[sidx->d];
			pgf_lzr_linearize_var(concr, argf, sidx->r, fnsp);
			break;
		}
		case PGF_SYMBOL_KS: {
			PgfSymbolKS* ks = sym_i.data;
			if ((*fnsp)->symbol_token) {
				(*fnsp)->symbol_token(fnsp, ks->token);
			}
			break;
		}
		case PGF_SYMBOL_KP: {
			// TODO: correct prefix-dependencies
			PgfSymbolKP* kp = sym_i.data;
			pgf_lzr_linearize_symbols(concr, fapp, kp->default_form, 0, fnsp);
			break;
		}
		case PGF_SYMBOL_NE: {
			if ((*fnsp)->symbol_ne) {
				(*fnsp)->symbol_ne(fnsp);
			}
			break;
		}
		case PGF_SYMBOL_BIND:
		case PGF_SYMBOL_SOFT_BIND: {
			if ((*fnsp)->symbol_bind) {
				(*fnsp)->symbol_bind(fnsp);
			}
			break;
		}
		default:
			gu_impossible(); 
		}
	}
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

		if (fns->begin_phrase && fapp->ccat != NULL) {
			fns->begin_phrase(fnsp,
							  fun->absfun->type->cid,
							  fapp->fid, lin_idx,
							  fun->absfun->name);
		}

		gu_require(lin_idx < fun->n_lins);
		pgf_lzr_linearize_symbols(concr, fapp, fun->lins[lin_idx]->syms, 0, fnsp);
		
		if (fns->end_phrase && fapp->ccat != NULL) {
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

		if (fchunks->n_args == 0) {
			if ((*fnsp)->symbol_token) {
				(*fnsp)->symbol_token(fnsp, "?");
			}
		} else {
			for (size_t i = 0; i < fchunks->n_args; i++) {
				pgf_lzr_linearize(concr, fchunks->args[i], 0, fnsp);
			}
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
							  "");
		}

		if (fns->expr_literal) {
			fns->expr_literal(fnsp, flit->lit);
		}

		if (fns->end_phrase) {
			fns->end_phrase(fnsp,
							cat, flit->fid, 0,
							"");
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
	bool bind;
	GuOut* out;
	GuExn* err;
};

GU_DEFINE_TYPE(PgfLinNonExist, abstract, _);

static void
pgf_file_lzn_put_space(PgfSimpleLin* flin)
{
	if (flin->bind)
		flin->bind = false;
	else
		gu_putc(' ', flin->out, flin->err);
}

static void
pgf_file_lzn_symbol_token(PgfLinFuncs** funcs, PgfToken tok)
{
	PgfSimpleLin* flin = gu_container(funcs, PgfSimpleLin, funcs);
	if (!gu_ok(flin->err)) {
		return;
	}

	pgf_file_lzn_put_space(flin);
	gu_string_write(tok, flin->out, flin->err);
}

static void
pgf_file_lzn_expr_literal(PgfLinFuncs** funcs, PgfLiteral lit)
{
	PgfSimpleLin* flin = gu_container(funcs, PgfSimpleLin, funcs);
	if (!gu_ok(flin->err)) {
		return;
	}

	pgf_file_lzn_put_space(flin);

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
}

static void
pgf_file_lzn_symbol_ne(PgfLinFuncs** funcs)
{
	PgfSimpleLin* flin = gu_container(funcs, PgfSimpleLin, funcs);
	gu_raise(flin->err, PgfLinNonExist);
}

static void
pgf_file_lzn_symbol_bind(PgfLinFuncs** funcs)
{
	PgfSimpleLin* flin = gu_container(funcs, PgfSimpleLin, funcs);
	flin->bind = true;
}

static PgfLinFuncs pgf_file_lin_funcs = {
	.symbol_token = pgf_file_lzn_symbol_token,
	.expr_literal = pgf_file_lzn_expr_literal,
	.begin_phrase = NULL,
	.end_phrase   = NULL,
	.symbol_ne    = pgf_file_lzn_symbol_ne,
	.symbol_bind  = pgf_file_lzn_symbol_bind
};

void
pgf_lzr_linearize_simple(PgfConcr* concr, PgfCncTree ctree,
			 size_t lin_idx, GuOut* out, GuExn* err)
{
	PgfSimpleLin flin = {
		.funcs = &pgf_file_lin_funcs,
		.bind = true,
		.out = out,
		.err = err
	};
	pgf_lzr_linearize(concr, ctree, lin_idx, &flin.funcs);
}

void
pgf_lzr_linearize_table(PgfConcr* concr, PgfCncTree ctree, 
                        size_t* n_lins, GuString** labels)
{
	static GuString s_label = "s";

	GuVariantInfo cti = gu_variant_open(ctree);

	switch (cti.tag) {
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* fapp = cti.data;
		
		PgfCncCat* cnccat = fapp->ccat->cnccat;
		*n_lins = cnccat->n_lins;
		*labels = cnccat->labels;
		break;
	}
	case PGF_CNC_TREE_LIT:
	case PGF_CNC_TREE_CHUNKS: {
		*n_lins = 1;
		*labels = &s_label;
		break;
	}
	default:
		gu_impossible();
	}

}

void
pgf_linearize(PgfConcr* concr, PgfExpr expr, GuOut* out, GuExn* err)
{
	GuPool* tmp_pool = gu_local_pool();

	GuEnum* cts =
		pgf_lzr_concretize(concr, expr, tmp_pool);
	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (!gu_variant_is_null(ctree)) {
		ctree = pgf_lzr_wrap_linref(ctree, tmp_pool);
		pgf_lzr_linearize_simple(concr, ctree, 0, out, err);
	}

	gu_pool_free(tmp_pool);
}

GuString
pgf_get_tokens(PgfSymbols* syms, uint16_t sym_idx, GuPool* pool)
{
	GuPool* tmp_pool = gu_new_pool();
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);
	GuStringBuf* sbuf = gu_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	PgfSimpleLin flin = {
		.funcs = &pgf_file_lin_funcs,
		.bind = true,
		.out = out,
		.err = err
	};

	pgf_lzr_linearize_symbols(NULL, NULL, syms, sym_idx, &flin.funcs);

	GuString tokens = gu_ok(err) ? gu_string_buf_freeze(sbuf, pool)
	                             : "";

	gu_pool_free(tmp_pool);

	return tokens;
}
