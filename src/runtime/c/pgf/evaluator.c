#include "pgf/pgf.h"
#include "pgf/data.h"
#include "pgf/evaluator.h"
#include <stdlib.h>

#define PGF_ARGS_DELTA 5

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
			thunk->expr = expr;
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
			gu_new_flex(state->pool, PgfValueMeta, args, n_args);
		val->header.code = state->eval_gates->evaluate_value_meta;
		val->id = emeta->id;
		val->n_args = n_args*sizeof(PgfClosure*);
		for (size_t i = 0; i < n_args; i++) {
			val->args[i] = args[n_args-i-1];
		}

		PgfIndirection* indir = (PgfIndirection*) thunk;
		indir->header.code = state->eval_gates->evaluate_indirection;
		indir->val         = &val->header;

		res = &val->header;
		break;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* efun = ei.data;

		PgfAbsFun* absfun =
			gu_map_get(state->pgf->abstract.funs, efun->fun, PgfAbsFun*);
		if (absfun == NULL) {
			GuExnData* err_data = gu_raise(state->err, PgfExn);
			if (err_data) {
				err_data->data = (char* const) 
					gu_format_string(err_data->pool,
									 "Unknown function: %s",
									 efun->fun);
			}
		} else {
			if (absfun->closure_id > 0) {
				res = &state->globals[absfun->closure_id-1].header;

				if (n_args > 0) {
					PgfValuePAP* val = gu_new_flex(state->pool, PgfValuePAP, args, n_args);
					val->header.code = state->eval_gates->evaluate_value_pap;
					val->fun         = res;
					val->n_args      = n_args*sizeof(PgfClosure*);
					for (size_t i = 0; i < n_args; i++) {
						val->args[i] = args[i];
					}
					res = &val->header;
				}
			} else {
				size_t arity = absfun->arity;

				PgfValue* val = gu_new_flex(state->pool, PgfValue, args, arity);
				val->header.code = state->eval_gates->evaluate_value;
				val->absfun = absfun;
				for (size_t i = 0; i < arity; i++) {
					val->args[i] = args[--n_args];
				}

				res = &val->header;
			}

			PgfIndirection* indir = (PgfIndirection*) thunk;
			indir->header.code = state->eval_gates->evaluate_indirection;
			indir->val = res;
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

		res = tmp_env->closure;

		PgfIndirection* indir = (PgfIndirection*) thunk;
		indir->header.code = state->eval_gates->evaluate_indirection;
		indir->val         = res;

		if (n_args > 0) {
			PgfValuePAP* val = gu_new_flex(state->pool, PgfValuePAP, args, n_args);
			val->header.code = state->eval_gates->evaluate_value_pap;
			val->fun         = res;
			val->n_args      = n_args*sizeof(PgfClosure*);
			for (size_t i = 0; i < n_args; i++) {
				val->args[i] = args[i];
			}
			res = &val->header;
		}
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
	thunk->expr        = ((PgfExprAbs*) gu_variant_data(lambda->expr))->body;
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

		expr   = val->absfun->ep.expr;
		n_args = gu_seq_length(val->absfun->type->hypos);
		args   = val->args;
	} else if (clos->code == state->eval_gates->evaluate_value_gen) {
		PgfValueGen* val = (PgfValueGen*) clos;

		PgfExprVar *evar =
			gu_new_variant(PGF_EXPR_VAR,
						   PgfExprVar,
						   &expr, pool);
		evar->var = level - val->level - 1;

		n_args = val->n_args/sizeof(PgfClosure*);
		args   = val->args;
	} else if (clos->code == state->eval_gates->evaluate_value_meta) {
		PgfValueMeta* val = (PgfValueMeta*) clos;

		PgfExprMeta *emeta =
			gu_new_variant(PGF_EXPR_META,
						   PgfExprMeta,
						   &expr, pool);
		emeta->id = val->id;

		n_args = val->n_args / sizeof(PgfClosure*);
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
		
		n_args = pap->n_args / sizeof(PgfClosure*);
		args   = pap->args;
	} else if (clos->code == state->eval_gates->evaluate_value_lambda) {
		PgfExprThunk *old_thunk = (PgfExprThunk*) clos;
		PgfExprAbs *old_eabs = gu_variant_data(old_thunk->expr);

		PgfValueGen* gen =
			gu_new(PgfValueGen, state->pool);
		gen->header.code = state->eval_gates->evaluate_value_gen;
		gen->level  = level;
		gen->n_args = 0;

		PgfEnv* new_env  = gu_new(PgfEnv, state->pool);
		new_env->next    = old_thunk->env;
		new_env->closure = &gen->header;

		PgfExprThunk* new_thunk =
			gu_new(PgfExprThunk, state->pool);
		new_thunk->header.code = state->eval_gates->evaluate_expr_thunk;
		new_thunk->env  = new_env;
		new_thunk->expr = old_eabs->body;

		PgfExprAbs *eabs =
			gu_new_variant(PGF_EXPR_ABS,
						   PgfExprAbs,
						   &expr, pool);
		eabs->bind_type = old_eabs->bind_type;
		eabs->id = gu_format_string(pool, "v%d", level);
		eabs->body = pgf_value2expr(state, level+1, &new_thunk->header, pool);
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
	size_t n_closures = gu_seq_length(pgf->abstract.eval_gates->defrules);

	PgfEvalState* state = 
		gu_new_flex(pool, PgfEvalState, globals, n_closures);
	state->pgf   = pgf;
	state->eval_gates = pgf->abstract.eval_gates;
	state->pool  = pool;
	state->err   = err;

	PgfFunction* defrules = gu_seq_data(state->eval_gates->defrules);
	for (size_t i = 0; i < n_closures; i++) {
		state->globals[i].header.code = defrules[i];
		state->globals[i].val = NULL;
	}

	PgfExprThunk* thunk =
		gu_new(PgfExprThunk, pool);
	thunk->header.code = state->eval_gates->evaluate_expr_thunk;
	thunk->env  = NULL;
	thunk->expr = expr;

	return pgf_value2expr(state, 0, &thunk->header, out_pool);
}
