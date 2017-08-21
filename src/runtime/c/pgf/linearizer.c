#include "data.h"
#include "linearizer.h"
#include <gu/map.h>
#include <gu/fun.h>
#include <gu/choice.h>
#include <gu/seq.h>
#include <gu/file.h>
#include <gu/string.h>
#include <gu/assert.h>
#include <gu/utf8.h>
#include <gu/ucs.h>
#include <pgf/expr.h>
#include <pgf/literals.h>
#include <stdio.h>

//#define PGF_LINEARIZER_DEBUG

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

PGF_INTERNAL void
pgf_lzr_index(PgfConcr* concr, 
              PgfCCat* ccat, PgfProduction prod,
              bool is_lexical,
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
			overl_table = gu_new_addr_map(PgfCCat*, GuBuf*, &gu_null_struct, pool);
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

typedef struct {
	PgfConcr* concr;
	GuChoice* ch;
	PgfExpr expr;
	int fid;
	GuEnum en;
} PgfCnc;


#ifdef PGF_LINEARIZER_DEBUG
static void
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

PGF_INTERNAL void
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
		if (chunks->id > 0)
			gu_printf(out, err, "?%d", chunks->id);
		else
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
pgf_cnc_resolve(PgfCnc* cnc,
                PgfPrintContext* context, PgfExpr expr,
                PgfCCat* ccat,
                GuPool* pool);

static PgfCncTree
pgf_cnc_resolve_app(PgfCnc* cnc,
                    size_t n_vars, PgfPrintContext* context,
                    PgfCCat* ccat, GuBuf* buf, GuBuf* args,
                    GuPool* pool)
{
	GuChoiceMark mark = gu_choice_mark(cnc->ch);
	int save_fid = cnc->fid;

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
	int index = gu_choice_next(cnc->ch, gu_buf_length(buf));
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
			gu_map_get(cnc->concr->coerce_idx, parg->ccat, GuBuf*);
		if (coercions == NULL) {
			ccat = parg->ccat;
		} else {
			int index = gu_choice_next(cnc->ch, gu_buf_length(coercions));
			if (index < 0) {
				cnc->fid = save_fid;
				gu_choice_reset(cnc->ch, mark);
				if (!gu_choice_advance(cnc->ch))
					return gu_null_variant;
				goto redo;
			}

			PgfProductionCoerce* pcoerce =
				gu_buf_get(coercions, PgfProductionCoerce*, index);
			ccat = pcoerce->coerce;
		}

		capp->args[i] =
			pgf_cnc_resolve(cnc, context, earg, ccat, pool);
		if (gu_variant_is_null(capp->args[i])) {
			cnc->fid = save_fid;
			gu_choice_reset(cnc->ch, mark);
			if (!gu_choice_advance(cnc->ch))
				return gu_null_variant;
			goto redo;
		}
	}

	capp->fid = cnc->fid++;

	return ret;
}

static PgfCncTree
pgf_cnc_resolve_def(PgfCnc* cnc,
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
	clit->fid = cnc->fid++;
	PgfLiteralStr* lit_str =
		gu_new_flex_variant(PGF_LITERAL_STR,
					        PgfLiteralStr,
					        val, strlen(s)+1,
					        &clit->lit, pool);
	strcpy((char*) lit_str->val, (char*) s);

	if (ccat->lindefs == NULL)
		return lit;

	int index =
		gu_choice_next(cnc->ch, gu_seq_length(ccat->lindefs));
	if (index < 0) {
		return ret;
	}
	PgfCncTreeApp* capp =
		gu_new_flex_variant(PGF_CNC_TREE_APP,
							PgfCncTreeApp,
							args, 1, &ret, pool);
	capp->ccat = ccat;
	capp->fun = gu_seq_get(ccat->lindefs, PgfCncFun*, index);
	capp->fid = cnc->fid++;
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
} PgfCncItor;

static void
pgf_cnc_cat_resolve_itor(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCncItor* clo = (PgfCncItor*) fn;
	PgfCCat* ccat = (PgfCCat*) key;
	GuBuf* buf = *((GuBuf**) value);

	if (clo->index == 0) {
		clo->ccat = ccat;
		clo->buf = buf;
	}

	clo->index--;
}

PGF_API PgfCncTree
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
pgf_cnc_resolve(PgfCnc* cnc, 
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
			clit->fid = cnc->fid++;
			clit->lit = elit->lit;
			goto done;
		}
		case PGF_EXPR_META: {
			PgfExprMeta* emeta = i.data;
			size_t n_args = gu_buf_length(args);

			PgfCncTree chunks_tree;
			PgfCncTreeChunks* chunks = 
				gu_new_flex_variant(PGF_CNC_TREE_CHUNKS,
				                    PgfCncTreeChunks,
				                    args, n_args, &chunks_tree, pool);
			chunks->id      = emeta->id;
			chunks->n_vars  = n_vars;
			chunks->context = context;
			chunks->n_args  = n_args;

			for (size_t i = 0; i < n_args; i++) {
				PgfExpr earg = gu_buf_get(args, PgfExpr, n_args-i-1);
				chunks->args[i] = pgf_cnc_resolve(cnc, context, earg, NULL, pool);
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
				gu_choice_next(cnc->ch, gu_seq_length(ccat->lindefs));
			if (index < 0) {
				return ret;
			}
			PgfCncTreeApp* capp =
				gu_new_flex_variant(PGF_CNC_TREE_APP,
									PgfCncTreeApp,
									args, 1, &ret, pool);
			capp->ccat = ccat;
			capp->fun = gu_seq_get(ccat->lindefs, PgfCncFun*, index);
			capp->fid = cnc->fid++;
			capp->n_vars = 0;
			capp->context = context;
			capp->n_args = 1;
			capp->args[0] = chunks_tree;

			goto done;
		}
		case PGF_EXPR_FUN: {
			PgfExprFun* efun = i.data;

			PgfCncOverloadMap* overl_table =
				gu_map_get(cnc->concr->fun_indices, efun->fun, PgfCncOverloadMap*);
			if (overl_table == NULL) {
				if (ccat != NULL && ccat->lindefs == NULL) {
					goto done;
				}

				GuPool* tmp_pool = gu_local_pool();
				GuExn* err = gu_new_exn(tmp_pool);
				GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
				GuOut* out = gu_string_buf_out(sbuf);

				gu_putc('[', out, err);
				gu_string_write(efun->fun, out, err);
				gu_putc(']', out, err);
				GuString s = gu_string_buf_freeze(sbuf, tmp_pool);

				if (ccat != NULL) {
					ret = pgf_cnc_resolve_def(cnc, n_vars, context, ccat, s, pool);
				} else {
					PgfCncTreeLit* clit = 
						gu_new_variant(PGF_CNC_TREE_LIT,
									   PgfCncTreeLit,
									   &ret, pool);
					clit->n_vars = 0;
					clit->context = context;
					clit->fid = cnc->fid++;
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
				GuChoiceMark mark = gu_choice_mark(cnc->ch);

redo:;
				int index = gu_choice_next(cnc->ch, n_count);
				if (index < 0) {
					goto done;
				}

				PgfCncItor clo = { { pgf_cnc_cat_resolve_itor }, index, NULL, NULL };
				gu_map_iter(overl_table, &clo.fn, NULL);
				assert(clo.ccat != NULL && clo.buf != NULL);

				ret = pgf_cnc_resolve_app(cnc, n_vars, context, clo.ccat, clo.buf, args, pool);
				if (gu_variant_is_null(ret)) {
					gu_choice_reset(cnc->ch, mark);
					if (gu_choice_advance(cnc->ch))
						goto redo;
				}
			} else {
				GuBuf* buf =
					gu_map_get(overl_table, ccat, GuBuf*);
				if (buf == NULL) {
					goto done;
				}

				ret = pgf_cnc_resolve_app(cnc, n_vars, context, ccat, buf, args, pool);
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
				ret = pgf_cnc_resolve_def(cnc, n_vars, context, ccat, ctxt->name, pool);
			} else {
				PgfCncTreeLit* clit = 
					gu_new_variant(PGF_CNC_TREE_LIT,
								   PgfCncTreeLit,
								   &ret, pool);
				clit->n_vars  = 0;
				clit->context = context;
				clit->fid = cnc->fid++;
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
	PgfCnc* lzn = gu_container(self, PgfCnc, en);
	PgfCncTree* toc = to;

	if (lzn->ch == NULL) {
		*toc = gu_null_variant;
		return;
	}

	lzn->fid = 0;

	GuChoiceMark mark = gu_choice_mark(lzn->ch);
	*toc = pgf_cnc_resolve(lzn, NULL, lzn->expr, NULL, pool);
	gu_choice_reset(lzn->ch, mark);

#ifdef PGF_LINEARIZER_DEBUG
    GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuExn* err = gu_exn(tmp_pool);
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

PGF_API PgfCncTreeEnum*
pgf_lzr_concretize(PgfConcr* concr, PgfExpr expr, GuExn* err, GuPool* pool)
{
	if (concr->fun_indices == NULL ||
	    concr->coerce_idx == NULL) {
		GuExnData* err_data = gu_raise(err, PgfExn);
		if (err_data) {
			err_data->data = "The concrete syntax is not loaded";
			return NULL;
		}
	}

	PgfCnc* cnc = gu_new(PgfCnc, pool);
	cnc->concr = concr;
	cnc->expr = expr;
	cnc->fid = 0;
	cnc->ch = gu_new_choice(pool);
	cnc->en.next = pgf_cnc_tree_enum_next;
	return &cnc->en;
}

typedef struct {
	PgfConcr* concr;
	PgfLinFuncs** funcs;
	GuPool* tmp_pool;
} PgfLzr;

static PgfLzr*
pgf_new_lzr(PgfConcr* concr, PgfLinFuncs** funcs, GuPool* tmp_pool)
{
	PgfLzr* lzr = gu_new(PgfLzr, tmp_pool);
	lzr->concr    = concr;
	lzr->funcs    = funcs;
	lzr->tmp_pool = tmp_pool;
	return lzr;
}

typedef enum {
	PGF_CACHED_BEGIN,
	PGF_CACHED_END,
	PGF_CACHED_BIND,
	PGF_CACHED_CAPIT,
	PGF_CACHED_ALL_CAPIT,
	PGF_CACHED_NE
} PgfLzrCachedTag;

typedef struct {
	PgfLzrCachedTag tag;
	PgfCId cat;
	int fid;
	int lin_idx;
	PgfCId fun;
} PgfLzrCached;

typedef struct {
	PgfLinFuncs*   funcs;
	PgfCncTreeApp* app;
	PgfSymbolKP*   kp;
	GuBuf* events;
	PgfLzr* lzr;
	PgfLinFuncs**  prev;
} PgfLzrCache;

static void
pgf_lzr_linearize_symbols(PgfLzr* lzr, PgfCncTreeApp* fapp,
                          PgfSymbols* syms, uint16_t sym_idx);
                          
static void
pgf_lzr_linearize_tree(PgfLzr* lzr, PgfCncTree ctree, size_t lin_idx);

static void
pgf_lzr_cache_flush(PgfLzrCache* cache, PgfSymbols* form)
{
	cache->lzr->funcs = cache->prev;
	pgf_lzr_linearize_symbols(cache->lzr, cache->app, form, 0);

	size_t n_cached = gu_buf_length(cache->events);
	for (size_t i = 0; i < n_cached; i++) {
		PgfLzrCached* event =
			gu_buf_index(cache->events, PgfLzrCached, i);
			
		switch (event->tag) {
		case PGF_CACHED_BEGIN:
			if ((*cache->lzr->funcs)->begin_phrase) {
				(*cache->lzr->funcs)->begin_phrase(
				                        cache->lzr->funcs,
				                        event->cat,
				                        event->fid,
				                        event->lin_idx,
				                        event->fun);
			}
			break;
		case PGF_CACHED_END:
			if ((*cache->lzr->funcs)->end_phrase) {
				(*cache->lzr->funcs)->end_phrase(
				                        cache->lzr->funcs,
				                        event->cat,
				                        event->fid,
				                        event->lin_idx,
				                        event->fun);
			}
			break;
		case PGF_CACHED_BIND:
			if ((*cache->lzr->funcs)->symbol_bind) {
				(*cache->lzr->funcs)->symbol_bind(cache->lzr->funcs);
			}
			break;
		case PGF_CACHED_CAPIT:
			if ((*cache->lzr->funcs)->symbol_capit) {
				(*cache->lzr->funcs)->symbol_capit(cache->lzr->funcs, PGF_CAPIT_FIRST);
			}
			break;
		case PGF_CACHED_ALL_CAPIT:
			if ((*cache->lzr->funcs)->symbol_capit) {
				(*cache->lzr->funcs)->symbol_capit(cache->lzr->funcs, PGF_CAPIT_ALL);
			}
			break;
		case PGF_CACHED_NE:
			if ((*cache->lzr->funcs)->symbol_ne) {
				(*cache->lzr->funcs)->symbol_ne(cache->lzr->funcs);
			}
			break;
		}
	}
}

static void
pgf_lzr_cache_symbol_token(PgfLinFuncs** funcs, PgfToken tok)
{
	PgfLzrCache* cache = gu_container(funcs, PgfLzrCache, funcs);

	PgfSymbols* form = cache->kp->default_form;
	for (size_t i = 0; i < cache->kp->n_forms; i++) {
		GuStrings* prefixes = cache->kp->forms[i].prefixes;
		size_t n_prefixes = gu_seq_length(prefixes);
		for (size_t j = 0; j < n_prefixes; j++) {
			GuString prefix = gu_seq_get(prefixes, GuString, j);
			
			if (gu_string_is_prefix(prefix, tok)) {
				form = cache->kp->forms[i].form;
				goto found;
			}
		}
	}
found:

	pgf_lzr_cache_flush(cache, form);
	if ((*cache->lzr->funcs)->symbol_token) {
		(*cache->lzr->funcs)->symbol_token(cache->lzr->funcs, tok);
	}
}

static void
pgf_lzr_cache_begin_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lin_idx, PgfCId fun)
{
	PgfLzrCache*  cache = gu_container(funcs, PgfLzrCache, funcs);
	PgfLzrCached* event = gu_buf_extend(cache->events);
	event->tag     = PGF_CACHED_BEGIN;
	event->cat     = cat;
	event->fid     = fid;
	event->lin_idx = lin_idx;
	event->fun     = fun;
}

static void
pgf_lzr_cache_end_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lin_idx, PgfCId fun)
{
	PgfLzrCache*  cache = gu_container(funcs, PgfLzrCache, funcs);
	PgfLzrCached* event = gu_buf_extend(cache->events);
	event->tag     = PGF_CACHED_END;
	event->cat     = cat;
	event->fid     = fid;
	event->lin_idx = lin_idx;
	event->fun     = fun;
}

static void
pgf_lzr_cache_symbol_ne(PgfLinFuncs** funcs)
{
	PgfLzrCache*  cache = gu_container(funcs, PgfLzrCache, funcs);
	PgfLzrCached* event = gu_buf_extend(cache->events);
	event->tag     = PGF_CACHED_NE;
}

static void
pgf_lzr_cache_symbol_bind(PgfLinFuncs** funcs)
{
	PgfLzrCache*  cache = gu_container(funcs, PgfLzrCache, funcs);
	PgfLzrCached* event = gu_buf_extend(cache->events);
	event->tag     = PGF_CACHED_BIND;
}

static void
pgf_lzr_cache_symbol_capit(PgfLinFuncs** funcs, PgfCapitState capit)
{
	PgfLzrCache*  cache = gu_container(funcs, PgfLzrCache, funcs);
	PgfLzrCached* event = gu_buf_extend(cache->events);
	event->tag     = (capit == PGF_CAPIT_ALL) ? PGF_CACHED_ALL_CAPIT : PGF_CACHED_CAPIT;
}

static void
pgf_lzr_cache_symbol_meta(PgfLinFuncs** funcs, PgfMetaId id)
{
	PgfLzrCache* cache = gu_container(funcs, PgfLzrCache, funcs);

	pgf_lzr_cache_flush(cache, cache->kp->default_form);
	if ((*cache->lzr->funcs)->symbol_meta) {
		(*cache->lzr->funcs)->symbol_meta(cache->lzr->funcs, id);
	}
}

static PgfLinFuncs pgf_lzr_cache_funcs = {
	.symbol_token = pgf_lzr_cache_symbol_token,
	.begin_phrase = pgf_lzr_cache_begin_phrase,
	.end_phrase   = pgf_lzr_cache_end_phrase,
	.symbol_ne    = pgf_lzr_cache_symbol_ne,
	.symbol_bind  = pgf_lzr_cache_symbol_bind,
	.symbol_capit = pgf_lzr_cache_symbol_capit,
	.symbol_meta  = pgf_lzr_cache_symbol_meta
};

static void
pgf_lzr_linearize_var(PgfLzr* lzr, PgfCncTree ctree, size_t var_idx)
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

	if ((*lzr->funcs)->symbol_token) {
		(*lzr->funcs)->symbol_token(lzr->funcs, context->name);
	}
}

static void
pgf_lzr_linearize_symbols(PgfLzr* lzr, PgfCncTreeApp* fapp,
                          PgfSymbols* syms, uint16_t sym_idx)
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
			pgf_lzr_linearize_tree(lzr, argf, sidx->r);
			break;
		}
		case PGF_SYMBOL_VAR: {
			if (fapp == NULL)
				return;

			PgfSymbolIdx* sidx = sym_i.data;
			gu_assert((unsigned) sidx->d < fapp->n_args);

			PgfCncTree argf = fapp->args[sidx->d];
			pgf_lzr_linearize_var(lzr, argf, sidx->r);
			break;
		}
		case PGF_SYMBOL_KS: {
			PgfSymbolKS* ks = sym_i.data;
			if ((*lzr->funcs)->symbol_token) {
				(*lzr->funcs)->symbol_token(lzr->funcs, ks->token);
			}
			break;
		}
		case PGF_SYMBOL_KP: {
			// TODO: correct prefix-dependencies
			PgfSymbolKP* kp = sym_i.data;
			//gu_buf_push(pres, PgfSymbolKP*, kp);
			PgfLzrCache* cache = gu_new(PgfLzrCache, lzr->tmp_pool);
			cache->funcs = &pgf_lzr_cache_funcs;
			cache->app   = fapp;
			cache->kp    = kp;
			cache->events= gu_new_buf(PgfLzrCached, lzr->tmp_pool);
			cache->lzr   = lzr;
			cache->prev  = lzr->funcs;
			lzr->funcs = &cache->funcs;
			break;
		}
		case PGF_SYMBOL_NE: {
			if ((*lzr->funcs)->symbol_ne) {
				(*lzr->funcs)->symbol_ne(lzr->funcs);
			}
			break;
		}
		case PGF_SYMBOL_BIND:
		case PGF_SYMBOL_SOFT_BIND: {
			if ((*lzr->funcs)->symbol_bind) {
				(*lzr->funcs)->symbol_bind(lzr->funcs);
			}
			break;
		}
		case PGF_SYMBOL_SOFT_SPACE: {
			// SOFT_SPACE should be just ignored in linearization
			break;
		}
		case PGF_SYMBOL_CAPIT:
			if ((*lzr->funcs)->symbol_capit) {
				(*lzr->funcs)->symbol_capit(lzr->funcs, PGF_CAPIT_FIRST);
			}
			break;
		case PGF_SYMBOL_ALL_CAPIT:
			if ((*lzr->funcs)->symbol_capit) {
				(*lzr->funcs)->symbol_capit(lzr->funcs, PGF_CAPIT_ALL);
			}
			break;
		default:
			gu_impossible(); 
		}
	}
}

static void
pgf_lzr_linearize_tree(PgfLzr* lzr, PgfCncTree ctree, size_t lin_idx)
{
	GuVariantInfo cti = gu_variant_open(ctree);

	switch (cti.tag) {
	case PGF_CNC_TREE_APP: {
		PgfCncTreeApp* fapp = cti.data;
		PgfCncFun* fun = fapp->fun;

		if ((*lzr->funcs)->begin_phrase && fapp->ccat != NULL) {
			(*lzr->funcs)->begin_phrase(lzr->funcs,
			                            fun->absfun->type->cid,
			                            fapp->fid, lin_idx,
			                            fun->absfun->name);
		}

		gu_require(lin_idx < fun->n_lins);
		pgf_lzr_linearize_symbols(lzr, fapp, fun->lins[lin_idx]->syms, 0);
		
		if ((*lzr->funcs)->end_phrase && fapp->ccat != NULL) {
			(*lzr->funcs)->end_phrase(lzr->funcs,
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
			if ((*lzr->funcs)->symbol_meta) {
				(*lzr->funcs)->symbol_meta(lzr->funcs, fchunks->id);
			}
		} else {
			for (size_t i = 0; i < fchunks->n_args; i++) {
				pgf_lzr_linearize_tree(lzr, fchunks->args[i], 0);
			}
		}
		break;
	}
	case PGF_CNC_TREE_LIT: {
		gu_require(lin_idx == 0);
		PgfCncTreeLit* flit = cti.data;

		PgfCId cat =
			pgf_literal_cat(lzr->concr, flit->lit)->cnccat->abscat->name;
		
		if ((*lzr->funcs)->begin_phrase) {
			(*lzr->funcs)->begin_phrase(lzr->funcs,
			                            cat, flit->fid, 0,
			                            "");
		}

		GuVariantInfo i = gu_variant_open(flit->lit);
		PgfToken tok = NULL;
		switch (i.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lstr = i.data;
			tok = lstr->val;
			break;
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lint = i.data;
			tok = gu_format_string(lzr->tmp_pool, "%d", lint->val);
			break;
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lflt = i.data;
			tok = gu_format_string(lzr->tmp_pool, "%lf", lflt->val);
			break;
		}
		default:
			gu_impossible();
		}

		if ((*lzr->funcs)->symbol_token) {
			(*lzr->funcs)->symbol_token(lzr->funcs, tok);
		}

		if ((*lzr->funcs)->end_phrase) {
			(*lzr->funcs)->end_phrase(lzr->funcs,
							          cat, flit->fid, 0,
							          "");
		}

		break;
	}
	default:
		gu_impossible();
	}
}

PGF_API void
pgf_lzr_linearize(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx, 
                  PgfLinFuncs** funcs, GuPool* tmp_pool)
{
	PgfLzr* lzr = pgf_new_lzr(concr, funcs, tmp_pool);
	pgf_lzr_linearize_tree(lzr, ctree, lin_idx);
	
	while (lzr->funcs != funcs) {
		PgfLzrCache* cache = gu_container(lzr->funcs, PgfLzrCache, funcs);
		pgf_lzr_cache_flush(cache, cache->kp->default_form);
	}
}

typedef struct PgfSimpleLin PgfSimpleLin;

struct PgfSimpleLin {
	PgfLinFuncs* funcs;
	bool bind;
	PgfCapitState capit;
	GuOut* out;
	GuExn* err;
};

static void
pgf_file_lzn_symbol_token(PgfLinFuncs** funcs, PgfToken tok)
{
	PgfSimpleLin* flin = gu_container(funcs, PgfSimpleLin, funcs);
	if (!gu_ok(flin->err)) {
		return;
	}

	if (flin->bind)
		flin->bind = false;
	else {
		gu_putc(' ', flin->out, flin->err);
		if (flin->capit == PGF_CAPIT_NEXT)
			flin->capit = PGF_CAPIT_NONE;
	}

	switch (flin->capit) {
	case PGF_CAPIT_NONE:
		gu_string_write(tok, flin->out, flin->err);
		break;
	case PGF_CAPIT_FIRST: {
		GuUCS c = gu_utf8_decode((const uint8_t**) &tok);
		c = gu_ucs_to_upper(c);
		gu_out_utf8(c, flin->out, flin->err);
		gu_string_write(tok, flin->out, flin->err);
		flin->capit = PGF_CAPIT_NONE;
		break;
	}
	case PGF_CAPIT_ALL:
		flin->capit = PGF_CAPIT_NEXT;
		// continue
	case PGF_CAPIT_NEXT: {
		const uint8_t* p = (uint8_t*) tok;
		while (*p) {
			GuUCS c = gu_utf8_decode(&p);
			c = gu_ucs_to_upper(c);
			gu_out_utf8(c, flin->out, flin->err);
		}
		break;
	}
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

static void
pgf_file_lzn_symbol_capit(PgfLinFuncs** funcs, PgfCapitState capit)
{
	PgfSimpleLin* flin = gu_container(funcs, PgfSimpleLin, funcs);
	flin->capit = capit;
}

static void
pgf_file_lzn_symbol_meta(PgfLinFuncs** funcs, PgfMetaId id)
{
	PgfSimpleLin* flin = gu_container(funcs, PgfSimpleLin, funcs);
	if (!gu_ok(flin->err)) {
		return;
	}

	if (flin->bind)
		flin->bind = false;
	else {
		gu_putc(' ', flin->out, flin->err);
		if (flin->capit == PGF_CAPIT_NEXT)
			flin->capit = PGF_CAPIT_NONE;
	}

	gu_putc('?', flin->out, flin->err);

	switch (flin->capit) {
	case PGF_CAPIT_FIRST:
		flin->capit = PGF_CAPIT_NONE;
		break;
	case PGF_CAPIT_ALL:
		flin->capit = PGF_CAPIT_NEXT;
		break;
	default:;
	}
}

static PgfLinFuncs pgf_file_lin_funcs = {
	.symbol_token = pgf_file_lzn_symbol_token,
	.begin_phrase = NULL,
	.end_phrase   = NULL,
	.symbol_ne    = pgf_file_lzn_symbol_ne,
	.symbol_bind  = pgf_file_lzn_symbol_bind,
	.symbol_capit = pgf_file_lzn_symbol_capit,
	.symbol_meta  = pgf_file_lzn_symbol_meta
};

PGF_API void
pgf_lzr_linearize_simple(PgfConcr* concr, PgfCncTree ctree, size_t lin_idx,
                         GuOut* out, GuExn* err,
                         GuPool* tmp_pool)
{
	PgfSimpleLin flin = {
		.funcs = &pgf_file_lin_funcs,
		.bind = true,
		.capit = PGF_CAPIT_NONE,
		.out = out,
		.err = err
	};
	pgf_lzr_linearize(concr, ctree, lin_idx, &flin.funcs, tmp_pool);
}

PGF_API void
pgf_lzr_get_table(PgfConcr* concr, PgfCncTree ctree, 
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

PGF_API void
pgf_linearize(PgfConcr* concr, PgfExpr expr, GuOut* out, GuExn* err)
{
	GuPool* tmp_pool = gu_local_pool();

	GuEnum* cts =
		pgf_lzr_concretize(concr, expr, err, tmp_pool);
	if (!gu_ok(err)) {
		gu_pool_free(tmp_pool);
		return;
	}

	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (!gu_variant_is_null(ctree)) {
		ctree = pgf_lzr_wrap_linref(ctree, tmp_pool);
		pgf_lzr_linearize_simple(concr, ctree, 0, out, err, tmp_pool);
	}

	gu_pool_free(tmp_pool);
}

PGF_INTERNAL GuString
pgf_get_tokens(PgfSymbols* syms, uint16_t sym_idx, GuPool* pool)
{
	GuPool* tmp_pool = gu_new_pool();
	GuExn* err = gu_new_exn(tmp_pool);
	GuStringBuf* sbuf = gu_new_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	PgfSimpleLin flin = {
		.funcs = &pgf_file_lin_funcs,
		.bind = true,
		.capit = false,
		.out = out,
		.err = err
	};

	PgfLzr* lzr = pgf_new_lzr(NULL, &flin.funcs, tmp_pool);
	pgf_lzr_linearize_symbols(lzr, NULL, syms, sym_idx);
	
	while (lzr->funcs != &flin.funcs) {
		PgfLzrCache* cache = gu_container(lzr->funcs, PgfLzrCache, funcs);
		pgf_lzr_cache_flush(cache, cache->kp->default_form);
	}

	GuString tokens = gu_ok(err) ? gu_string_buf_freeze(sbuf, pool)
	                             : "";

	gu_pool_free(tmp_pool);

	return tokens;
}
