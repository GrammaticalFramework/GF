#ifndef PGF_EVALUATOR_H_
#define PGF_EVALUATOR_H_

typedef struct {
	PgfFunction code;
} PgfClosure;

typedef struct {
	PgfClosure header;
	PgfClosure* val;
} PgfIndirection;

typedef struct {
	PgfPGF* pgf;
	PgfEvalGates* eval_gates; // cached from pgf->abstr->eval_gates
	GuPool* pool;
	GuExn* err;
	PgfIndirection cafs[];  // derived from gu_seq_data(pgf->abstr->eval_gates->cafs)
} PgfEvalState;

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
	PgfClosure* con;
	PgfClosure* args[];
} PgfValue;

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

typedef struct {
	PgfClosure header;
	PgfClosure* fun;
	size_t      n_args;
	PgfClosure* args[];
} PgfValuePAP;

struct PgfEvalGates {
	PgfFunction evaluate_expr_thunk;
	PgfFunction evaluate_indirection;
	PgfFunction evaluate_value;
	PgfFunction evaluate_value_gen;
	PgfFunction evaluate_value_meta;
	PgfFunction evaluate_value_lit;
	PgfFunction evaluate_value_pap;
	PgfFunction evaluate_value_lambda;
	PgfFunction evaluate_caf;

	PgfFunction update_closure;
	PgfFunction update_pap;

	PgfFunction mk_const;

	PgfClosure* (*enter)(PgfEvalState* state, PgfClosure* closure);

	GuFinalizer fin;
	GuSeq* cafs;
};

PgfClosure*
pgf_evaluate_expr_thunk(PgfEvalState* state, PgfExprThunk* thunk);

PgfClosure*
pgf_evaluate_lambda_application(PgfEvalState* state, PgfExprThunk* lambda,
                                                     PgfClosure* arg);

#endif
