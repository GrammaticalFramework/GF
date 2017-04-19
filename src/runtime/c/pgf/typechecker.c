#include "pgf.h"
#include "data.h"
#include "gu/mem.h"
#include "gu/string.h"

typedef struct PgfCFHypos PgfCFHypos;
struct PgfCFHypos {
	PgfType* ty;
	PgfCFHypos* next;
};

typedef struct PgfContext PgfContext;
struct PgfContext {
	PgfCId var;
	PgfType* ty;
	PgfContext* next;
};

typedef struct {
	PgfCFHypos* hypos;
	PgfCId cat;
} PgfCFType;

typedef struct {
	PgfAbstr* abstr;
	GuExn* exn;
	GuPool* pool;
	GuPool* tmp_pool;
	PgfMetaId meta_id;
} PgfTypeChecker;

static PgfCFType null_cf_type = { .hypos = NULL, .cat = NULL };

static PgfCFType 
pgf_ty2cfty(PgfTypeChecker* checker, PgfType* ty)
{
	PgfCFHypos* hypos = NULL;
	size_t n_hypos = gu_seq_length(ty->hypos);
	while (n_hypos-- > 0) {
		PgfHypo* hypo = gu_seq_index(ty->hypos, PgfHypo, n_hypos);

		PgfCFHypos* new_hypos = gu_new(PgfCFHypos, checker->tmp_pool);
		new_hypos->ty   = hypo->type;
		new_hypos->next = hypos;
		hypos = new_hypos;
	}
	return ((PgfCFType) { .hypos = hypos, .cat = ty->cid });
}

static PgfType*
pgf_cfty2ty(PgfTypeChecker* checker, PgfCFType cf_ty)
{
	PgfCFHypos* hypos;

	size_t n_hypos = 0;
	hypos = cf_ty.hypos;
	while (hypos != NULL) {
		n_hypos++;
		hypos = hypos->next;
	}

	PgfType* ty = gu_new(PgfType, checker->pool);
	ty->hypos   = gu_new_seq(PgfHypo, n_hypos, checker->pool);
	ty->cid     = cf_ty.cat;
	ty->n_exprs = 0;

	size_t i = 0;
	hypos = cf_ty.hypos;
	while (hypos != NULL) {
		PgfHypo* hypo = gu_seq_index(ty->hypos, PgfHypo, i++);
		hypo->bind_type = PGF_BIND_TYPE_EXPLICIT;
		hypo->cid       = "_";
		hypo->type      = pgf_cfty2ty(checker, pgf_ty2cfty(checker, hypos->ty));
		hypos = hypos->next;
	}

	return ty;
}

static PgfPrintContext*
pgf_tc_mk_print_context(PgfTypeChecker* checker, PgfContext* ctxt)
{
	PgfPrintContext* pctxt = NULL;
	PgfPrintContext** pprev = &pctxt;

	while (ctxt != NULL) {
		PgfPrintContext* new_pctxt =
			gu_new(PgfPrintContext, checker->tmp_pool);
		new_pctxt->name = ctxt->var;
		new_pctxt->next = NULL;

		*pprev = new_pctxt;
		pprev  = &new_pctxt->next;

		ctxt = ctxt->next;
	}

	return pctxt;
}

static void
pgf_tc_err_cannot_infer(PgfTypeChecker* checker, PgfContext* ctxt, PgfExpr e)
{
	GuStringBuf* sbuf = gu_new_string_buf(checker->tmp_pool);
    GuOut* out = gu_string_buf_out(sbuf);
    GuExn* err = gu_exn(checker->tmp_pool);

	gu_puts("Cannot infer the type of expression ", out, err);
	pgf_print_expr(e, pgf_tc_mk_print_context(checker, ctxt), 0, out, err);

	GuExnData* exn = gu_raise(checker->exn, PgfTypeError);
	exn->data = (void*)
		gu_string_buf_freeze(sbuf, exn->pool);
}

static void
pgf_tc_err_exp_fun_type_1(PgfTypeChecker* checker, PgfContext* ctxt, 
                          PgfExpr e, PgfType* ty)
{
	GuStringBuf* sbuf = gu_new_string_buf(checker->tmp_pool);
    GuOut* out = gu_string_buf_out(sbuf);
    GuExn* err = gu_exn(checker->tmp_pool);

	PgfPrintContext* pctxt = pgf_tc_mk_print_context(checker, ctxt);
	gu_puts("The expression ", out, err);
	pgf_print_expr(e, pctxt, 0, out, err);
	gu_puts(" is of function type but ", out, err);
	pgf_print_type(ty, pctxt, 0, out, err);
	gu_puts(" is expected", out, err);

	GuExnData* exn = gu_raise(checker->exn, PgfTypeError);
	exn->data = (void*)
		gu_string_buf_freeze(sbuf, exn->pool);
}

static void
pgf_tc_err_exp_fun_type_2(PgfTypeChecker* checker, PgfContext* ctxt, 
                          PgfExpr e, PgfType* ty)
{
	GuStringBuf* sbuf = gu_new_string_buf(checker->tmp_pool);
    GuOut* out = gu_string_buf_out(sbuf);
    GuExn* err = gu_exn(checker->tmp_pool);

	PgfPrintContext* pctxt = pgf_tc_mk_print_context(checker, ctxt);
	gu_puts("A function type is expected for the expression ", out, err);
	pgf_print_expr(e, pctxt, 0, out, err);
	gu_puts(" instead of type ", out, err);
	pgf_print_type(ty, pctxt, 0, out, err);

	GuExnData* exn = gu_raise(checker->exn, PgfTypeError);
	exn->data = (void*)
		gu_string_buf_freeze(sbuf, exn->pool);
}

static void
pgf_tc_err_n_args(PgfTypeChecker* checker, 
                  PgfAbsCat* abs_cat, size_t n_args)
{
	GuExnData* exn = gu_raise(checker->exn, PgfTypeError);
	exn->data = (void*)
		gu_format_string(exn->pool, 
		                 "The category %s has %d indices but %d are given",
		                 abs_cat->name,
		                 gu_seq_length(abs_cat->context),
		                 n_args);
}

static void
pgf_tc_err_type_mismatch(PgfTypeChecker* checker,
                         PgfContext* ctxt,
                         PgfExpr e, PgfCFType ty1, PgfCFType ty2)
{
	GuStringBuf* sbuf = gu_new_string_buf(checker->tmp_pool);
    GuOut* out = gu_string_buf_out(sbuf);
    GuExn* err = gu_exn(checker->tmp_pool);

	PgfPrintContext* pctxt = pgf_tc_mk_print_context(checker, ctxt);
	gu_puts("The expected type of the expression ", out, err);
	pgf_print_expr(e, pctxt, 0, out, err);
	gu_puts(" is ", out, err);
	pgf_print_type(pgf_cfty2ty(checker, ty1), pctxt, 0, out, err);
	gu_puts(" but ", out, err);
	pgf_print_type(pgf_cfty2ty(checker, ty2), pctxt, 0, out, err);
	gu_puts(" is infered", out, err);

	GuExnData* exn = gu_raise(checker->exn, PgfTypeError);
	exn->data = (void*)
		gu_string_buf_freeze(sbuf, exn->pool);
}

static bool
pgf_unify_types(PgfTypeChecker* checker, PgfCFType ty1, PgfCFType ty2)
{
	if (strcmp(ty1.cat, ty2.cat) != 0)
		return false;
		
	while (ty1.hypos != NULL && ty2.hypos != NULL) {
		if (!pgf_unify_types(checker,
		                     pgf_ty2cfty(checker, ty1.hypos->ty),
		                     pgf_ty2cfty(checker, ty2.hypos->ty)))
			return false;

		ty1.hypos = ty1.hypos->next;
		ty2.hypos = ty2.hypos->next;
	}
	
	if (ty1.hypos != NULL || ty2.hypos != NULL)
		return false;

	return true;
}

static PgfCFType
pgf_inf_expr(PgfTypeChecker* checker, PgfContext* ctxt, PgfExpr* pe);

static void
pgf_tc_expr(PgfTypeChecker* checker,
            PgfContext* ctxt, PgfExpr* pe, PgfCFType ty)
{
	GuVariantInfo i = gu_variant_open(*pe);
	switch (i.tag) {
	case PGF_EXPR_ABS: {
		PgfExprAbs* eabs = i.data;

		if (ty.hypos == NULL) {
			pgf_tc_err_exp_fun_type_1(checker, ctxt, *pe, pgf_cfty2ty(checker, ty));
			return;
		}

		PgfContext* new_ctxt = gu_new(PgfContext, checker->tmp_pool);
		new_ctxt->var  = eabs->id;
		new_ctxt->ty   = ty.hypos->ty;
		new_ctxt->next = ctxt;

		PgfExprAbs* new_eabs =
			gu_new_variant(PGF_EXPR_ABS,
			               PgfExprAbs,
			               pe, checker->pool);
		new_eabs->bind_type = eabs->bind_type;
		new_eabs->id        = gu_string_copy(eabs->id, checker->pool);
		new_eabs->body      = eabs->body;

		PgfCFType new_ty = { .hypos = ty.hypos->next, .cat = ty.cat };
		pgf_tc_expr(checker, new_ctxt, &new_eabs->body, new_ty);
		break;
	}
	case PGF_EXPR_LIT:
	case PGF_EXPR_APP:
	case PGF_EXPR_FUN:
	case PGF_EXPR_VAR:
	case PGF_EXPR_TYPED: {
		PgfCFType inf_ty =
			pgf_inf_expr(checker, ctxt, pe);
		if (!gu_ok(checker->exn))
			return;
		if (!pgf_unify_types(checker, ty, inf_ty)) {
			pgf_tc_err_type_mismatch(checker, ctxt, *pe, ty, inf_ty);
			return;
		}
		break;
	}
	case PGF_EXPR_META: {
		PgfExprMeta* new_emeta =
			gu_new_variant(PGF_EXPR_META,
			               PgfExprMeta,
			               pe, checker->pool);
		new_emeta->id = checker->meta_id++;
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* eimpl = i.data;
		
		PgfExprImplArg* new_eimpl =
			gu_new_variant(PGF_EXPR_IMPL_ARG,
			               PgfExprImplArg,
			               pe, checker->pool);
		new_eimpl->expr = eimpl->expr;
		pgf_tc_expr(checker, ctxt, &new_eimpl->expr, ty);
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_tc_type(PgfTypeChecker* checker, PgfType** pty)
{
	PgfType* ty = *pty;

	PgfAbsCat* abs_cat =
		gu_seq_binsearch(checker->abstr->cats, pgf_abscat_order, PgfAbsCat, ty->cid);
	if (abs_cat == NULL) {
		GuExnData* exn = gu_raise(checker->exn, PgfExn);
		exn->data = (void*)
			gu_format_string(exn->pool,
			                 "Unknown category \"%s\"", ty->cid);
		return;
	}

	PgfContext* ctxt = NULL;

	size_t n_hypos = gu_seq_length(ty->hypos);
	PgfHypos* new_hypos = gu_new_seq(PgfHypo, n_hypos, checker->pool);
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo     = gu_seq_index(ty->hypos, PgfHypo, i);
		PgfHypo* new_hypo = gu_seq_index(new_hypos, PgfHypo, i);

		new_hypo->bind_type = hypo->bind_type;
		new_hypo->cid       = gu_string_copy(hypo->cid, checker->pool);
		new_hypo->type      = hypo->type;

		pgf_tc_type(checker, &new_hypo->type);
		if (!gu_ok(checker->exn))
			return;
			
		PgfContext* new_ctxt = gu_new(PgfContext, checker->tmp_pool);
		new_ctxt->var  = hypo->cid;
		new_ctxt->ty   = hypo->type;
		new_ctxt->next = ctxt;
		ctxt = new_ctxt;
	}

	PgfType *new_ty =
		gu_new_flex(checker->pool, PgfType, exprs, ty->n_exprs);
	new_ty->hypos   = new_hypos;
	new_ty->cid     = gu_string_copy(ty->cid, checker->pool);
	new_ty->n_exprs = ty->n_exprs;

	if (gu_seq_length(abs_cat->context) != ty->n_exprs) {
		pgf_tc_err_n_args(checker, abs_cat, ty->n_exprs);
		return;
	}

	for (size_t i = 0; i < ty->n_exprs; i++) {
		PgfHypo* hypo = gu_seq_index(abs_cat->context, PgfHypo, i);

		new_ty->exprs[i] = ty->exprs[i];
		pgf_tc_expr(checker, ctxt, &new_ty->exprs[i], pgf_ty2cfty(checker, hypo->type));
		if (!gu_ok(checker->exn))
			return;
	}

	*pty = new_ty;
}

static PgfCFType
pgf_inf_expr(PgfTypeChecker* checker, PgfContext* ctxt, PgfExpr* pe)
{
	GuVariantInfo i = gu_variant_open(*pe);
	switch (i.tag) {
	case PGF_EXPR_ABS: {
		pgf_tc_err_cannot_infer(checker, ctxt, *pe);
		return null_cf_type;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* eapp = i.data;

		PgfExprApp* new_eapp =
			gu_new_variant(PGF_EXPR_APP,
			               PgfExprApp,
			               pe, checker->pool);
		new_eapp->fun = eapp->fun;
		new_eapp->arg = eapp->arg;

		PgfCFType fun_ty =
			pgf_inf_expr(checker, ctxt, &new_eapp->fun);
		if (!gu_ok(checker->exn))
			return null_cf_type;
		if (fun_ty.hypos == NULL) {
			pgf_tc_err_exp_fun_type_2(checker,
			                          ctxt,
                                      eapp->fun, pgf_cfty2ty(checker, fun_ty));
			return null_cf_type;
		}

		pgf_tc_expr(checker, ctxt, &new_eapp->arg, pgf_ty2cfty(checker, fun_ty.hypos->ty));
		return ((PgfCFType) { .hypos = fun_ty.hypos->next,
		                      .cat   = fun_ty.cat
		                    });
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* elit = i.data;

		PgfExprLit* new_elit =
			gu_new_variant(PGF_EXPR_LIT,
			               PgfExprLit,
			               pe, checker->pool);

		GuVariantInfo i = gu_variant_open(elit->lit);
		switch (i.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lstr = i.data;

			PgfLiteralStr* new_lstr =
				gu_new_flex_variant(PGF_LITERAL_STR,
				                    PgfLiteralStr,
				                    val, strlen(lstr->val)+1,
				                    &new_elit->lit, checker->pool);
			strcpy(new_lstr->val, lstr->val);

			return ((PgfCFType) { .hypos = NULL, .cat = "String" });
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lint = i.data;

			PgfLiteralInt* new_lint =
				gu_new_variant(PGF_LITERAL_INT,
				               PgfLiteralInt,
				               &new_elit->lit, checker->pool);
			new_lint->val = lint->val;

			return ((PgfCFType) { .hypos = NULL, .cat = "Int" });
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lflt = i.data;

			PgfLiteralFlt* new_lflt =
				gu_new_variant(PGF_LITERAL_FLT,
				               PgfLiteralFlt,
				               &new_elit->lit, checker->pool);
			new_lflt->val = lflt->val;

			return ((PgfCFType) { .hypos = NULL, .cat = "Float" });
		}
		default:
			gu_impossible();
		}
		break;
	}
	case PGF_EXPR_META: {
		pgf_tc_err_cannot_infer(checker, ctxt, *pe);
		return null_cf_type;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* efun = i.data;

		PgfType* ty = NULL;

		int var = 0;
		PgfContext* var_ctxt = ctxt;
		while (var_ctxt != NULL) {
			if (strcmp(var_ctxt->var, efun->fun) == 0) {
				PgfExprVar* new_evar =
					gu_new_variant(PGF_EXPR_VAR,
				                   PgfExprVar,
					               pe, checker->pool);
				new_evar->var = var;
				ty = var_ctxt->ty;
				break;
			}

			var++;
			var_ctxt = var_ctxt->next;
		}

		if (ty == NULL) {
			PgfAbsFun* abs_fun =
				gu_seq_binsearch(checker->abstr->funs, pgf_absfun_order, PgfAbsFun, efun->fun);
			if (abs_fun == NULL) {
				GuExnData* exn = gu_raise(checker->exn, PgfExn);
				exn->data = (void*)
					gu_format_string(exn->pool, 
									 "Unknown function \"%s\"", efun->fun);
				return null_cf_type;
			} else {
				PgfExprFun *new_efun =
					gu_new_flex_variant(PGF_EXPR_FUN,
					                    PgfExprFun,
					                    fun, strlen(efun->fun)+1,
					                    pe, checker->pool);
				strcpy(new_efun->fun, efun->fun);
				ty = abs_fun->type;
			}
		}

		return pgf_ty2cfty(checker, ty);
	}
	case PGF_EXPR_VAR: {
		PgfExprVar* evar = i.data;

		int var = evar->var;
		PgfContext* var_ctxt = ctxt;
		assert(var_ctxt != NULL);
		while (var > 0) {
			var--;
			var_ctxt = var_ctxt->next;
			assert(var_ctxt != NULL);
		}

		return pgf_ty2cfty(checker, var_ctxt->ty);
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* etyped = i.data;
		
		PgfExprTyped* new_etyped =
			gu_new_variant(PGF_EXPR_TYPED,
			               PgfExprTyped,
			               pe, checker->pool);
		new_etyped->expr = etyped->expr;
		new_etyped->type = etyped->type;

		pgf_tc_type(checker, &new_etyped->type);
		if (!gu_ok(checker->exn))
			return null_cf_type;

		PgfCFType cf_ty = pgf_ty2cfty(checker, new_etyped->type);

		pgf_tc_expr(checker, ctxt, &new_etyped->expr, cf_ty);
		return cf_ty;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* eimpl = i.data;
		
		PgfExprImplArg* new_eimpl =
			gu_new_variant(PGF_EXPR_IMPL_ARG,
			               PgfExprImplArg,
			               pe, checker->pool);
		new_eimpl->expr = eimpl->expr;
		return pgf_inf_expr(checker, ctxt, &new_eimpl->expr);
	}
	default:
		gu_impossible();
	}

	return null_cf_type;
}

PGF_API void
pgf_check_expr(PgfPGF* gr, PgfExpr* pe, PgfType* ty,
               GuExn* exn, GuPool* pool)
{
	GuPool* tmp_pool = gu_new_pool();
	
	PgfTypeChecker* checker = gu_new(PgfTypeChecker, tmp_pool);
	checker->abstr    = &gr->abstract;
	checker->exn      = exn;
	checker->pool     = pool;
	checker->tmp_pool = tmp_pool;
	checker->meta_id  = 1;
	
	pgf_tc_expr(checker, NULL, pe, pgf_ty2cfty(checker, ty));
	
	gu_pool_free(tmp_pool);
}

PGF_API PgfType*
pgf_infer_expr(PgfPGF* gr, PgfExpr* pe,
               GuExn* exn, GuPool* pool)
{
	GuPool* tmp_pool = gu_new_pool();
	
	PgfTypeChecker* checker = gu_new(PgfTypeChecker, tmp_pool);
	checker->abstr    = &gr->abstract;
	checker->exn      = exn;
	checker->pool     = pool;
	checker->tmp_pool = tmp_pool;
	checker->meta_id  = 1;

	PgfCFType cf_ty = pgf_inf_expr(checker, NULL, pe);
	
	PgfType* ty = NULL;
	if (gu_ok(exn)) {
		ty = pgf_cfty2ty(checker, cf_ty);
	}

	gu_pool_free(tmp_pool);

	return ty;
}

PGF_API void
pgf_check_type(PgfPGF* gr, PgfType** pty, 
               GuExn* exn, GuPool* pool)
{
	GuPool* tmp_pool = gu_new_pool();
	
	PgfTypeChecker* checker = gu_new(PgfTypeChecker, tmp_pool);
	checker->abstr    = &gr->abstract;
	checker->exn      = exn;
	checker->pool     = pool;
	checker->tmp_pool = tmp_pool;
	checker->meta_id  = 1;

	pgf_tc_type(checker, pty);

	gu_pool_free(tmp_pool);
}
