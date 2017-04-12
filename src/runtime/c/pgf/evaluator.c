#include "pgf/pgf.h"
#include "pgf/data.h"
#include "pgf/reasoner.h"
#include <stdlib.h>

#define PGF_ARGS_DELTA 5

static inline PgfClosure*
pgf_mk_pap(PgfReasoner* rs, PgfClosure* fun,
           size_t n_args, PgfClosure** args)
{
	if (n_args > 0) {
		PgfValuePAP* val = gu_new_flex(rs->pool, PgfValuePAP, args, n_args);
		val->header.code = rs->eval_gates->evaluate_value_pap;
		val->fun         = fun;
		val->n_args      = n_args*sizeof(PgfClosure*);
		for (size_t i = 0; i < n_args; i++) {
			val->args[i] = args[i];
		}
		return &val->header;
	}
	return fun;
}

PgfClosure*
pgf_evaluate_expr_thunk(PgfReasoner* rs, PgfExprThunk* thunk)
{
	PgfEnv* env  = thunk->env;
	PgfExpr expr = thunk->expr;

	size_t n_args = 0;
	PgfClosure** args = NULL;
	PgfClosure* res = NULL;

repeat:;
	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS: {
		PgfExprAbs* eabs = ei.data;

		if (n_args > 0) {
			PgfEnv* new_env  = gu_new(PgfEnv, rs->pool);
			new_env->next    = env;
			new_env->closure = args[--n_args];

			env  = new_env;
			expr = eabs->body;
			goto repeat;
		} else {
			thunk->header.code = rs->eval_gates->evaluate_value_lambda;
			thunk->expr = eabs->body;
			res = &thunk->header;
		}
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* eapp = ei.data;
		PgfExprThunk* thunk = 
			gu_new(PgfExprThunk, rs->pool);
		thunk->header.code = rs->eval_gates->evaluate_expr_thunk;
		thunk->env  = env;
		thunk->expr = eapp->arg;
		
		if (n_args % PGF_ARGS_DELTA == 0) {
			args = realloc(args, n_args + PGF_ARGS_DELTA);
		}
		args[n_args++] = &thunk->header;

		expr = eapp->fun;
		goto repeat;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* elit = ei.data;
		PgfValueLit* val = (PgfValueLit*) thunk;
		val->header.code = rs->eval_gates->evaluate_value_lit;
		val->lit = elit->lit;
		res = &val->header;
		break;
	}
	case PGF_EXPR_META: {
		PgfExprMeta* emeta = ei.data;

		PgfValueMeta* val =
			gu_new(PgfValueMeta, rs->pool);
		val->header.code = rs->eval_gates->evaluate_meta;
		val->env = env;
		val->id  = emeta->id;
		res = pgf_mk_pap(rs, &val->header, n_args, args);
		break;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* efun = ei.data;

		PgfAbsFun* absfun =
			gu_seq_binsearch(rs->abstract->funs, pgf_absfun_order, PgfAbsFun, efun->fun);
		gu_assert(absfun != NULL);

		if (absfun->closure.code != NULL) {
			res = pgf_mk_pap(rs, (PgfClosure*) &absfun->closure, n_args, args);
		} else {
			size_t arity = absfun->arity;

			if (n_args >= arity) {
				PgfValue* val = gu_new_flex(rs->pool, PgfValue, args, n_args);
				val->header.code = rs->eval_gates->evaluate_value;
				val->con = (PgfClosure*) &absfun->closure;

				for (size_t i = 0; i < n_args; i++) {
					val->args[i] = args[--n_args];
				}
				res = &val->header;
			} else {
				PgfExprThunk* lambda = gu_new(PgfExprThunk, rs->pool);
				lambda->header.code = rs->eval_gates->evaluate_value_lambda;
				lambda->env = NULL;
				res = pgf_mk_pap(rs, &lambda->header, n_args, args);

				for (size_t i = 0; i < arity; i++) {
					PgfExpr new_expr, arg;

					PgfExprVar *evar =
						gu_new_variant(PGF_EXPR_VAR,
									   PgfExprVar,
									   &arg, rs->pool);
					evar->var = arity-i-1;

					PgfExprApp *eapp =
						gu_new_variant(PGF_EXPR_APP,
									   PgfExprApp,
									   &new_expr, rs->pool);
					eapp->fun = expr;
					eapp->arg = arg;
					
					expr = new_expr;
				}

				for (size_t i = 0; i < arity-1; i++) {
					PgfExpr new_expr;

					PgfExprAbs *eabs =
						gu_new_variant(PGF_EXPR_ABS,
									   PgfExprAbs,
									   &new_expr, rs->pool);
					eabs->bind_type = PGF_BIND_TYPE_EXPLICIT;
					eabs->id = "_";
					eabs->body = expr;

					expr = new_expr;
				}
				
				lambda->expr = expr;
			}
		}
		break;
	}
	case PGF_EXPR_VAR: {
		PgfExprVar* evar = ei.data;
		PgfEnv* tmp_env = env;
		size_t i = evar->var;
		while (i > 0) {
			tmp_env = tmp_env->next;
			if (tmp_env == NULL) {
				GuExnData* err_data = gu_raise(rs->err, PgfExn);
				if (err_data) {
					err_data->data = "invalid de Bruijn index";
				}
				return NULL;
			}
			i--;
		}

		res = pgf_mk_pap(rs, tmp_env->closure, n_args, args);
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* etyped = ei.data;
		expr = etyped->expr;
		goto repeat;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* eimpl = ei.data;
		expr = eimpl->expr;
		goto repeat;
	}
	default:
		gu_impossible();
	}

	free(args);
	return res;
}

PgfClosure*
pgf_evaluate_lambda_application(PgfReasoner* rs, PgfExprThunk* lambda,
                                PgfClosure* arg)
{
	PgfEnv* new_env = gu_new(PgfEnv, rs->pool);
	new_env->next    = lambda->env;
	new_env->closure = arg;

	PgfExprThunk* thunk = gu_new(PgfExprThunk, rs->pool);
	thunk->header.code = rs->eval_gates->evaluate_expr_thunk;
	thunk->env         = new_env;
	thunk->expr        = lambda->expr;
	return pgf_evaluate_expr_thunk(rs, thunk);
}

static PgfExpr
pgf_value2expr(PgfReasoner* rs, int level, PgfClosure* clos)
{
	clos = rs->eval_gates->enter(rs, clos);
	if (clos == NULL)
		return gu_null_variant;

	PgfExpr expr = gu_null_variant;
	size_t n_args = 0;
	PgfClosure** args;

	if (clos->code == rs->eval_gates->evaluate_value) {
		PgfValue* val = (PgfValue*) clos;
		PgfAbsFun* absfun = gu_container(val->con, PgfAbsFun, closure);

		expr   = absfun->ep.expr;
		n_args = gu_seq_length(absfun->type->hypos);
		args   = val->args;
	} else if (clos->code == rs->eval_gates->evaluate_value_lit) {
		PgfValueLit* val = (PgfValueLit*) clos;

		PgfExprLit *elit =
			gu_new_variant(PGF_EXPR_LIT,
						   PgfExprLit,
						   &expr, rs->out_pool);

		GuVariantInfo i = gu_variant_open(val->lit);
		switch (i.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lstr = i.data;

			PgfLiteralStr* new_lstr =
				gu_new_flex_variant(PGF_LITERAL_STR,
									PgfLiteralStr,
									val, strlen(lstr->val)+1,
									&elit->lit, rs->out_pool);
			strcpy(new_lstr->val, lstr->val);
			break;
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lint = i.data;

			PgfLiteralInt* new_lint =
				gu_new_variant(PGF_LITERAL_INT,
							   PgfLiteralInt,
							   &elit->lit, rs->out_pool);
			new_lint->val = lint->val;
			break;
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lflt = i.data;

			PgfLiteralFlt* new_lflt =
				gu_new_variant(PGF_LITERAL_FLT,
							   PgfLiteralFlt,
							   &elit->lit, rs->out_pool);
			new_lflt->val = lflt->val;
			break;
		}
		default:
			gu_impossible();
		}
	} else if (clos->code == rs->eval_gates->evaluate_value_pap) {
		PgfValuePAP *pap = (PgfValuePAP*) clos;

		PgfValueGen* gen =
			gu_new(PgfValueGen, rs->pool);
		gen->header.code = rs->eval_gates->evaluate_gen;
		gen->level  = level;

		size_t n_args = pap->n_args/sizeof(PgfClosure*);
		PgfValuePAP* new_pap = gu_new_flex(rs->pool, PgfValuePAP, args, n_args+1);
		new_pap->header.code = rs->eval_gates->evaluate_value_pap;
		new_pap->fun         = pap->fun;
		new_pap->n_args      = pap->n_args+sizeof(PgfClosure*);
		new_pap->args[0]     = &gen->header;
		for (size_t i = 0; i < n_args; i++) {
			new_pap->args[i+1] = pap->args[i];
		}

		PgfExprAbs *eabs =
			gu_new_variant(PGF_EXPR_ABS,
						   PgfExprAbs,
						   &expr, rs->out_pool);
		eabs->bind_type = PGF_BIND_TYPE_EXPLICIT;
		eabs->id = gu_format_string(rs->out_pool, "v%d", level);
		eabs->body = pgf_value2expr(rs, level+1, &new_pap->header);
	} else if (clos->code == rs->eval_gates->evaluate_value_const) {
		PgfValuePAP* val = (PgfValuePAP*) clos;
		
		if (val->fun->code == rs->eval_gates->evaluate_meta) {
			PgfValueMeta* fun = (PgfValueMeta*) val->fun;

			PgfExprMeta *emeta =
				gu_new_variant(PGF_EXPR_META,
				               PgfExprMeta,
				               &expr, rs->out_pool);
			emeta->id = fun->id;
		} else if (val->fun->code == rs->eval_gates->evaluate_gen) {
			PgfValueGen* fun = (PgfValueGen*) val->fun;

			PgfExprVar *evar =
				gu_new_variant(PGF_EXPR_VAR,
				               PgfExprVar,
				               &expr, rs->out_pool);
			evar->var = level - fun->level - 1;
		} else if (val->fun->code == rs->eval_gates->evaluate_sum) {
			PgfValueSum* sum = (PgfValueSum*) val->fun;

			PgfExpr e1,e2;
			PgfExprFun *efun =
				gu_new_flex_variant(PGF_EXPR_FUN,
				                    PgfExprFun,
				                    fun, 2,
				                    &e1, rs->out_pool);
			strcpy(efun->fun, "+");

			PgfExprLit *elit =
				gu_new_variant(PGF_EXPR_LIT,
				               PgfExprLit,
				               &e2, rs->out_pool);
			elit->lit = sum->lit;
			
			PgfExprApp* eapp =
				gu_new_variant(PGF_EXPR_APP,
				               PgfExprApp,
				               &expr, rs->out_pool);
			eapp->fun = e1;
			eapp->arg = e2;
	
			size_t n_consts = gu_buf_length(sum->consts);
			for (size_t i = 0; i < n_consts; i++) {
				PgfClosure* con =
					gu_buf_get(sum->consts, PgfClosure*, i);

				PgfExpr fun = expr;
				PgfExpr arg = 
					pgf_value2expr(rs, level, con);
				if (gu_variant_is_null(arg))
					return gu_null_variant;

				PgfExprApp* e =
					gu_new_variant(PGF_EXPR_APP,
					               PgfExprApp,
					               &expr, rs->out_pool);
				e->fun = fun;
				e->arg = arg;
			}
		} else {
			PgfAbsFun* absfun = gu_container(val->fun, PgfAbsFun, closure);
			expr   = absfun->ep.expr;
		}

		n_args = val->n_args/sizeof(PgfClosure*);
		args   = val->args;
	} else {
		gu_impossible();
	}

	for (size_t i = 0; i < n_args; i++) {
		PgfExpr fun = expr;
		PgfExpr arg = 
			pgf_value2expr(rs, level, args[i]);
		if (gu_variant_is_null(arg))
			return gu_null_variant;

		PgfExprApp* e =
			gu_new_variant(PGF_EXPR_APP,
						   PgfExprApp,
						   &expr, rs->out_pool);
		e->fun = fun;
		e->arg = arg;
	}

	return expr;
}

PgfExpr
pgf_compute(PgfPGF* pgf, PgfExpr expr, GuExn* err, GuPool* pool, GuPool* out_pool)
{
	PgfReasoner* rs =
		pgf_new_reasoner(pgf, err, pool, out_pool);

	PgfExprThunk* thunk =
		gu_new(PgfExprThunk, pool);
	thunk->header.code = rs->eval_gates->evaluate_expr_thunk;
	thunk->env  = NULL;
	thunk->expr = expr;

	return pgf_value2expr(rs, 0, &thunk->header);
}

void
pgf_evaluate_accum_init_int(PgfReasoner* rs, 
                            PgfEvalAccum* accum, int val)
{
	PgfLiteralInt *lit_int =
		gu_new_variant(PGF_LITERAL_INT,
	                   PgfLiteralInt,
	                   &accum->lit,
					   rs->pool);
	lit_int->val = val;
	accum->consts = NULL;
}

void
pgf_evaluate_accum_init_str(PgfReasoner* rs, 
                            PgfEvalAccum* accum, GuString val)
{
	if (val == NULL)
		val = "";

	PgfLiteralStr *lit_str =
		gu_new_flex_variant(PGF_LITERAL_STR,
							PgfLiteralStr,
							val, strlen(val)+1,
							&accum->lit, rs->pool);
	strcpy((char*) lit_str->val, (char*) val);
	accum->consts = NULL;
}

void
pgf_evaluate_accum_init_flt(PgfReasoner* rs, 
                            PgfEvalAccum* accum, float val)
{
	PgfLiteralFlt *lit_flt =
		gu_new_variant(PGF_LITERAL_FLT,
					   PgfLiteralFlt,
					   &accum->lit,
					   rs->pool);
	lit_flt->val = val;
	accum->enter_stack_ptr = rs->enter_stack_ptr;
	rs->enter_stack_ptr = ((char*)accum)-sizeof(char*)*2;
	accum->consts = NULL;
}

static void
pgf_evaluate_accum_add_helper(PgfEvalAccum* accum, PgfLiteral lit)
{
	GuVariantInfo ei = gu_variant_open(lit);
	switch (ei.tag) {
	case PGF_LITERAL_INT: {
		PgfLiteralInt* lint = ei.data;
		((PgfLiteralInt*)gu_variant_data(accum->lit))->val += lint->val;
		break;
	}
	case PGF_LITERAL_STR: {
		PgfLiteralStr* lstr = ei.data;
		break;
	}
	case PGF_LITERAL_FLT: {
		PgfLiteralFlt* lflt = ei.data;
		((PgfLiteralFlt*)gu_variant_data(accum->lit))->val += lflt->val;
		break;
	}
	}
}

void
pgf_evaluate_accum_add(PgfReasoner* rs,
                       PgfEvalAccum* accum, PgfClosure* closure)
{
	if (closure->code == rs->eval_gates->evaluate_value_lit) {
		PgfValueLit* val = (PgfValueLit*) closure;
		pgf_evaluate_accum_add_helper(accum, val->lit);
	} else if (closure->code == rs->eval_gates->evaluate_value_const) {
		if (accum->consts == NULL)
			accum->consts = gu_new_buf(PgfClosure*, rs->pool);

		PgfValuePAP* pap = (PgfValuePAP*) closure;
		
		if (pap->fun->code == rs->eval_gates->evaluate_sum) {
			PgfValueSum* val = (PgfValueSum*) ((PgfValuePAP*) closure)->fun;
			pgf_evaluate_accum_add_helper(accum, val->lit);

			size_t n_consts = gu_buf_length(val->consts);
			for (size_t i = 0; i < n_consts; i++) {
				PgfClosure* clos = gu_buf_get(val->consts, PgfClosure*, i);
				gu_buf_push(accum->consts, PgfClosure*, clos);
			}
		} else {
			gu_buf_push(accum->consts, PgfClosure*, closure);
		}
	} else {
		gu_impossible();
	}
}

PgfClosure*
pgf_evaluate_accum_done(PgfReasoner* rs, PgfEvalAccum* accum)
{
	rs->enter_stack_ptr = accum->enter_stack_ptr;

	if (accum->consts == NULL) {
		PgfValueLit* val = gu_new(PgfValueLit, rs->pool);
		val->header.code = rs->eval_gates->evaluate_value_lit;
		val->lit = accum->lit;
		return &val->header;
	} else {
		PgfValueSum* val = gu_new(PgfValueSum, rs->pool);
		val->header.code = rs->eval_gates->evaluate_sum;
		val->lit = accum->lit;
		val->consts = accum->consts;
		return &val->header;
	}
}
