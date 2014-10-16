#include "pgf/pgf.h"
#include "pgf/data.h"
#include "pgf/evaluator.h"
#include <stdlib.h>

#define PGF_ARGS_DELTA 5

static inline PgfClosure*
pgf_mk_pap(PgfEvalState* state, PgfClosure* fun,
           size_t n_args, PgfClosure** args)
{
	if (n_args > 0) {
		PgfValuePAP* val = gu_new_flex(state->pool, PgfValuePAP, args, n_args);
		val->header.code = state->eval_gates->evaluate_value_pap;
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
pgf_evaluate_expr_thunk(PgfEvalState* state, PgfExprThunk* thunk)
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
			PgfEnv* new_env  = gu_new(PgfEnv, state->pool);
			new_env->next    = env;
			new_env->closure = args[--n_args];

			env  = new_env;
			expr = eabs->body;
			goto repeat;
		} else {
			thunk->header.code = state->eval_gates->evaluate_value_lambda;
			thunk->expr = eabs->body;
			res = &thunk->header;
		}
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* eapp = ei.data;
		PgfExprThunk* thunk = 
			gu_new(PgfExprThunk, state->pool);
		thunk->header.code = state->eval_gates->evaluate_expr_thunk;
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
		val->header.code = state->eval_gates->evaluate_value_lit;
		val->lit = elit->lit;
		res = &val->header;
		break;
	}
	case PGF_EXPR_META: {
		PgfExprMeta* emeta = ei.data;

		PgfValueMeta* val =
			gu_new(PgfValueMeta, state->pool);
		val->header.code = state->eval_gates->evaluate_meta;
		val->env = env;
		val->id  = emeta->id;
		res = pgf_mk_pap(state, &val->header, n_args, args);
		break;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* efun = ei.data;

		PgfAbsFun* absfun =
			gu_seq_binsearch(state->pgf->abstract.funs, pgf_absfun_order, PgfAbsFun, efun->fun);
		gu_assert(absfun != NULL);

		if (absfun->closure.code != NULL) {
			res = pgf_mk_pap(state, (PgfClosure*) &absfun->closure, n_args, args);
		} else {
			size_t arity = absfun->arity;

			if (n_args == arity) {
				PgfValue* val = gu_new_flex(state->pool, PgfValue, args, arity);
				val->header.code = state->eval_gates->evaluate_value;
				val->con = (PgfClosure*) &absfun->closure;

				for (size_t i = 0; i < arity; i++) {
					val->args[i] = args[--n_args];
				}
				res = &val->header;
			} else {
				gu_assert(n_args < arity);

				PgfExprThunk* lambda = gu_new(PgfExprThunk, state->pool);
				lambda->header.code = state->eval_gates->evaluate_value_lambda;
				lambda->env = NULL;
				res = pgf_mk_pap(state, &lambda->header, n_args, args);

				for (size_t i = 0; i < arity; i++) {
					PgfExpr new_expr, arg;

					PgfExprVar *evar =
						gu_new_variant(PGF_EXPR_VAR,
									   PgfExprVar,
									   &arg, state->pool);
					evar->var = arity-i-1;

					PgfExprApp *eapp =
						gu_new_variant(PGF_EXPR_APP,
									   PgfExprApp,
									   &new_expr, state->pool);
					eapp->fun = expr;
					eapp->arg = arg;
					
					expr = new_expr;
				}
				
				for (size_t i = 0; i < arity-1; i++) {
					PgfExpr new_expr;

					PgfExprAbs *eabs =
						gu_new_variant(PGF_EXPR_ABS,
									   PgfExprAbs,
									   &new_expr, state->pool);
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
				GuExnData* err_data = gu_raise(state->err, PgfExn);
				if (err_data) {
					err_data->data = "invalid de Bruijn index";
				}
				return NULL;
			}
			i--;
		}

		res = pgf_mk_pap(state, tmp_env->closure, n_args, args);
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
pgf_evaluate_lambda_application(PgfEvalState* state, PgfExprThunk* lambda,
                                                     PgfClosure* arg)
{
	PgfEnv* new_env = gu_new(PgfEnv, state->pool);
	new_env->next    = lambda->env;
	new_env->closure = arg;

	PgfExprThunk* thunk = gu_new(PgfExprThunk, state->pool);
	thunk->header.code = state->eval_gates->evaluate_expr_thunk;
	thunk->env         = new_env;
	thunk->expr        = lambda->expr;
	return pgf_evaluate_expr_thunk(state, thunk);
}

static PgfExpr
pgf_value2expr(PgfEvalState* state, int level, PgfClosure* clos, GuPool* pool)
{
	clos = state->eval_gates->enter(state, clos);
	if (clos == NULL)
		return gu_null_variant;

	PgfExpr expr = gu_null_variant;
	size_t n_args = 0;
	PgfClosure** args;

	if (clos->code == state->eval_gates->evaluate_value) {
		PgfValue* val = (PgfValue*) clos;
		PgfAbsFun* absfun = gu_container(val->con, PgfAbsFun, closure);

		expr   = absfun->ep.expr;
		n_args = absfun->arity;
		args   = val->args;
	} else if (clos->code == state->eval_gates->evaluate_value_lit) {
		PgfValueLit* val = (PgfValueLit*) clos;

		PgfExprLit *elit =
			gu_new_variant(PGF_EXPR_LIT,
						   PgfExprLit,
						   &expr, pool);

		GuVariantInfo i = gu_variant_open(val->lit);
		switch (i.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lstr = i.data;

			PgfLiteralStr* new_lstr =
				gu_new_flex_variant(PGF_LITERAL_STR,
									PgfLiteralStr,
									val, strlen(lstr->val)+1,
									&elit->lit, pool);
			strcpy(new_lstr->val, lstr->val);
			break;
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lint = i.data;

			PgfLiteralInt* new_lint =
				gu_new_variant(PGF_LITERAL_INT,
							   PgfLiteralInt,
							   &elit->lit, pool);
			new_lint->val = lint->val;
			break;
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lflt = i.data;

			PgfLiteralFlt* new_lflt =
				gu_new_variant(PGF_LITERAL_FLT,
							   PgfLiteralFlt,
							   &elit->lit, pool);
			new_lflt->val = lflt->val;
			break;
		}
		default:
			gu_impossible();
		}
	} else if (clos->code == state->eval_gates->evaluate_value_pap) {
		PgfValuePAP *pap = (PgfValuePAP*) clos;

		PgfValueGen* gen =
			gu_new(PgfValueGen, state->pool);
		gen->header.code = state->eval_gates->evaluate_gen;
		gen->level  = level;

		size_t n_args = pap->n_args/sizeof(PgfClosure*);
		PgfValuePAP* new_pap = gu_new_flex(state->pool, PgfValuePAP, args, n_args+1);
		new_pap->header.code = state->eval_gates->evaluate_value_pap;
		new_pap->fun         = pap->fun;
		new_pap->n_args      = pap->n_args+sizeof(PgfClosure*);
		new_pap->args[0]     = &gen->header;
		for (size_t i = 0; i < n_args; i++) {
			new_pap->args[i+1] = pap->args[i];
		}

		PgfExprAbs *eabs =
			gu_new_variant(PGF_EXPR_ABS,
						   PgfExprAbs,
						   &expr, pool);
		eabs->bind_type = PGF_BIND_TYPE_EXPLICIT;
		eabs->id = gu_format_string(pool, "v%d", level);
		eabs->body = pgf_value2expr(state, level+1, &new_pap->header, pool);
	} else if (clos->code == state->eval_gates->evaluate_value_const) {
		PgfValuePAP* val = (PgfValuePAP*) clos;
		
		if (val->fun->code == state->eval_gates->evaluate_meta) {
			PgfValueMeta* fun = (PgfValueMeta*) val->fun;

			PgfExprMeta *emeta =
				gu_new_variant(PGF_EXPR_META,
				               PgfExprMeta,
				               &expr, pool);
			emeta->id = fun->id;
		} else if (val->fun->code == state->eval_gates->evaluate_gen) {
			PgfValueGen* fun = (PgfValueGen*) val->fun;

			PgfExprVar *evar =
				gu_new_variant(PGF_EXPR_VAR,
				               PgfExprVar,
				               &expr, pool);
			evar->var = level - fun->level - 1;
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
			pgf_value2expr(state, level, args[i], pool);
		if (gu_variant_is_null(arg))
			return gu_null_variant;

		PgfExprApp* e =
			gu_new_variant(PGF_EXPR_APP,
						   PgfExprApp,
						   &expr, pool);
		e->fun = fun;
		e->arg = arg;
	}

	return expr;
}

PgfExpr
pgf_compute(PgfPGF* pgf, PgfExpr expr, GuExn* err, GuPool* pool, GuPool* out_pool)
{
	size_t n_cafs =
		(pgf->abstract.eval_gates->cafs == NULL) 
			? 0 : gu_seq_length(pgf->abstract.eval_gates->cafs);

	PgfEvalState* state = 
		gu_new_flex(pool, PgfEvalState, cafs, n_cafs);
	state->pgf   = pgf;
	state->eval_gates = pgf->abstract.eval_gates;
	state->pool  = pool;
	state->err   = err;

	PgfFunction* cafs = gu_seq_data(state->eval_gates->cafs);
	for (size_t i = 0; i < n_cafs; i++) {
		state->cafs[i].header.code = cafs[i];
		state->cafs[i].val = NULL;
	}

	PgfExprThunk* thunk =
		gu_new(PgfExprThunk, pool);
	thunk->header.code = state->eval_gates->evaluate_expr_thunk;
	thunk->env  = NULL;
	thunk->expr = expr;

	return pgf_value2expr(state, 0, &thunk->header, out_pool);
}
