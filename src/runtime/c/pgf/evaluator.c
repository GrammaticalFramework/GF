#include "pgf/pgf.h"
#include "pgf/data.h"
#include "pgf/evaluator.h"

typedef struct PgfEnv PgfEnv;

struct PgfEnv {
	PgfEnv* next;
	PgfClosure* closure;
};

typedef struct {
	PgfClosure header;
	PgfEnv*  env;
	PgfExpr  expr;
} PgfExprThunk;

typedef struct {
	PgfClosure header;
	PgfClosure* val;
} PgfIndirection;

typedef struct {
	PgfClosure header;
	int level;
	size_t n_args;
	PgfClosure* args[];
} PgfValueGen;

typedef struct {
	PgfClosure header;
	PgfEnv*  env;
	PgfMetaId id;
	size_t n_args;
	PgfClosure* args[];
} PgfValueMeta;

typedef struct {
	PgfClosure header;
	PgfLiteral lit;
} PgfValueLit;

static PgfClosure*
pgf_evaluate_indirection(PgfEvalState* state, PgfClosure* closure)
{
	PgfIndirection* indir = (PgfIndirection*) closure;
	return indir->val;
}

PgfClosure*
pgf_evaluate_value(PgfEvalState* state, PgfClosure* closure)
{
	return closure;
}

static PgfClosure*
pgf_evaluate_value_gen(PgfEvalState* state, PgfClosure* closure)
{
	PgfValueGen* val = (PgfValueGen*) closure;

	size_t n_args = val->n_args + gu_buf_length(state->stack);
	PgfValueGen* new_val =
		gu_new_flex(state->pool, PgfValueGen, args, n_args);
	new_val->header.code = pgf_evaluate_value_gen;
	new_val->level = val->level;
	new_val->n_args = n_args;
	
	size_t i = 0;
	while (i < val->n_args) {
		new_val->args[i] = val->args[i];
		i++;
	}
	while (i < n_args) {
		new_val->args[i] = gu_buf_pop(state->stack, PgfClosure*);
		i++;
	}

	return &new_val->header;
}

static PgfClosure*
pgf_evaluate_value_meta(PgfEvalState* state, PgfClosure* closure)
{
	PgfValueMeta* val = (PgfValueMeta*) closure;

	size_t n_args = val->n_args + gu_buf_length(state->stack);
	PgfValueMeta* new_val =
		gu_new_flex(state->pool, PgfValueMeta, args, n_args);
	new_val->header.code = pgf_evaluate_value_meta;
	new_val->id = val->id;
	new_val->n_args = n_args;
	
	size_t i = 0;
	while (i < val->n_args) {
		new_val->args[i] = val->args[i];
		i++;
	}
	while (i < n_args) {
		val->args[i] = gu_buf_pop(state->stack, PgfClosure*);
		i++;
	}

	return &new_val->header;
}

static PgfClosure*
pgf_evaluate_value_lit(PgfEvalState* state, PgfClosure* closure)
{
	return closure;
}

static PgfClosure*
pgf_evaluate_expr_thunk(PgfEvalState* state, PgfClosure* closure)
{
	PgfExprThunk* thunk = (PgfExprThunk*) closure;
	PgfEnv* env  = thunk->env;
	PgfExpr expr = thunk->expr;

	for (;;) {
		GuVariantInfo ei = gu_variant_open(expr);
		switch (ei.tag) {
		case PGF_EXPR_ABS: {
			PgfExprAbs* eabs = ei.data;

			if (gu_buf_length(state->stack) > 0) {
				PgfEnv* new_env  = gu_new(PgfEnv, state->pool);
				new_env->next    = env;
				new_env->closure = gu_buf_pop(state->stack, PgfClosure*);

				env  = new_env;
				expr = eabs->body;
			} else {
				thunk->expr = expr;
				return closure;
			}
			break;
		}
		case PGF_EXPR_APP: {
			PgfExprApp* eapp = ei.data;
			PgfExprThunk* thunk = 
				gu_new(PgfExprThunk, state->pool);
			thunk->header.code = pgf_evaluate_expr_thunk;
			thunk->env  = env;
			thunk->expr = eapp->arg;
			gu_buf_push(state->stack, PgfClosure*, &thunk->header);
			expr = eapp->fun;
			break;
		}
		case PGF_EXPR_LIT: {
			PgfExprLit* elit = ei.data;

			if (gu_buf_length(state->stack) > 0) {
				GuExnData* err_data = gu_raise(state->err, PgfExn);
				if (err_data) {
					err_data->data = "found literal of function type";
				}
				return NULL;
			}

			PgfValueLit* val = (PgfValueLit*) closure;
			val->header.code = pgf_evaluate_value_lit;
			val->lit = elit->lit;
			return &val->header;
		}
		case PGF_EXPR_META: {
			PgfExprMeta* emeta = ei.data;

			size_t n_args = gu_buf_length(state->stack);

			PgfValueMeta* val =
				gu_new_flex(state->pool, PgfValueMeta, args, n_args);
			val->header.code = pgf_evaluate_value_meta;
			val->id = emeta->id;
			val->n_args  = n_args;
			for (size_t i = 0; i < n_args; i++) {
				val->args[i] = gu_buf_pop(state->stack, PgfClosure*);
			}

			PgfIndirection* indir = (PgfIndirection*) closure;
			indir->header.code = pgf_evaluate_indirection;
			indir->val         = &val->header;

			return &val->header;
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
				return NULL;
			}

			PgfValue* val;
			if (absfun->function != NULL) {
				val = (PgfValue*) ((PgfFunction) absfun->function)(state, closure);
			} else {
				size_t n_args = absfun->arity;

				val = gu_new_flex(state->pool, PgfValue, args, n_args);
				val->header.code = pgf_evaluate_value;
				val->absfun = absfun;
				for (size_t i = 0; i < n_args; i++) {
					val->args[i] = gu_buf_pop(state->stack, PgfClosure*);
				}
			}

			PgfIndirection* indir = (PgfIndirection*) closure;
			indir->header.code = pgf_evaluate_indirection;
			indir->val         = &val->header;

			return &val->header;
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

			PgfClosure* val = 
				tmp_env->closure->code(state, tmp_env->closure);

			PgfIndirection* indir = (PgfIndirection*) closure;
			indir->header.code = pgf_evaluate_indirection;
			indir->val         = val;

			return val;
		}
		case PGF_EXPR_TYPED: {
			PgfExprTyped* etyped = ei.data;
			expr = etyped->expr;
			break;
		}
		case PGF_EXPR_IMPL_ARG: {
			PgfExprImplArg* eimpl = ei.data;
			expr = eimpl->expr;
			break;
		}
		default:
			gu_impossible();
		}
	}
}

void
pgf_evaluate_save_variables(PgfEvalState* state, PgfValue* val)
{
	size_t n_args = val->absfun->arity;
	for (size_t i = 0; i < n_args; i++) {
		gu_buf_push(state->stack, PgfClosure*, val->args[i]);
	}
}

static PgfExpr
pgf_value2expr(PgfEvalState* state, int level, PgfClosure* clos, GuPool* pool)
{
	clos = clos->code(state, clos);
	if (clos == NULL)
		return gu_null_variant;

	PgfExpr expr = gu_null_variant;
	size_t n_args = 0;
	PgfClosure** args;

	if (clos->code == pgf_evaluate_value) {
		PgfValue* val = (PgfValue*) clos;

		expr   = val->absfun->ep.expr;
		n_args = gu_seq_length(val->absfun->type->hypos);
		args   = val->args;
	} else if (clos->code == pgf_evaluate_value_gen) {
		PgfValueGen* val = (PgfValueGen*) clos;

		PgfExprVar *evar =
			gu_new_variant(PGF_EXPR_VAR,
						   PgfExprVar,
						   &expr, pool);
		evar->var = level - val->level - 1;

		n_args = val->n_args;
		args   = val->args;
	} else if (clos->code == pgf_evaluate_value_meta) {
		PgfValueMeta* val = (PgfValueMeta*) clos;

		PgfExprMeta *emeta =
			gu_new_variant(PGF_EXPR_META,
						   PgfExprMeta,
						   &expr, pool);
		emeta->id = val->id;

		n_args = val->n_args;
		args   = val->args;
	} else if (clos->code == pgf_evaluate_value_lit) {
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
	} else {
		PgfExprThunk *old_thunk = (PgfExprThunk*) clos;
		PgfExprAbs *old_eabs = gu_variant_open(old_thunk->expr).data;

		PgfValueGen* gen =
			gu_new(PgfValueGen, state->pool);
		gen->header.code = pgf_evaluate_value_gen;
		gen->level  = level;
		gen->n_args = 0;

		PgfEnv* new_env  = gu_new(PgfEnv, state->pool);
		new_env->next    = old_thunk->env;
		new_env->closure = &gen->header;

		PgfExprThunk* new_thunk =
			gu_new(PgfExprThunk, state->pool);
		new_thunk->header.code = pgf_evaluate_expr_thunk;
		new_thunk->env  = new_env;
		new_thunk->expr = old_eabs->body;

		PgfExprAbs *eabs =
			gu_new_variant(PGF_EXPR_ABS,
						   PgfExprAbs,
						   &expr, pool);
		eabs->bind_type = old_eabs->bind_type;
		eabs->id = gu_format_string(pool, "v%d", level);
		eabs->body = pgf_value2expr(state, level+1, &new_thunk->header, pool);
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
	PgfEvalState* state = gu_new(PgfEvalState, pool);
	state->pgf   = pgf;
	state->pool  = pool;
	state->err   = err;
	state->stack = gu_new_buf(PgfClosure*, pool);

	PgfExprThunk* thunk =
		gu_new(PgfExprThunk, pool);
	thunk->header.code = pgf_evaluate_expr_thunk;
	thunk->env  = NULL;
	thunk->expr = expr;

	return pgf_value2expr(state, 0, &thunk->header, out_pool);
}
