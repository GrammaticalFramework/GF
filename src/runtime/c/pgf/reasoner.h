#ifndef PGF_REASONER_H_
#define PGF_REASONER_H_

typedef GuStringMap PgfAbswersMap;

typedef struct PgfReasoner PgfReasoner;
typedef struct PgfReasonerState PgfReasonerState;
typedef struct PgfExprState PgfExprState;

typedef void (*PgfPredicate)(PgfReasoner* rs, PgfReasonerState* st);

void
pgf_reasoner_try_first(PgfReasoner* rs, PgfExprState* parent, PgfAbsFun* absfun);

void
pgf_reasoner_try_else(PgfReasoner* rs, PgfExprState* prev, PgfAbsFun* absfun);

void
pgf_reasoner_complete(PgfReasoner* rs, PgfExprState* st);

void
pgf_reasoner_try_constant(PgfReasoner* rs, PgfExprState* prev, PgfAbsFun* absfun);

typedef struct {
	PgfFunction code;
} PgfClosure;

typedef struct {
	PgfClosure header;
	PgfClosure* val;
} PgfIndirection;

typedef struct {
	PgfLiteral lit;
	GuBuf* consts;
	void* enter_stack_ptr;
} PgfEvalAccum;

struct PgfReasoner {
	GuPool* pool;
	GuPool* out_pool;
	PgfAbstr* abstract;
	PgfAbswersMap* table;
	GuBuf* pqueue;
	GuBuf* exprs;
	PgfEvalGates* eval_gates; // cached from pgf->abstr->eval_gates
	GuExn* err;
	void* enter_stack_ptr;
	void* tmp;              // for temporary register spills
	PgfExprEnum en;
	PgfIndirection cafs[];  // derived from gu_seq_data(pgf->abstr->eval_gates->cafs)
};

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
} PgfValueGen;

typedef struct {
	PgfClosure header;
	PgfEnv*  env;
	PgfMetaId id;
} PgfValueMeta;

typedef struct {
	PgfClosure header;
	PgfLiteral lit;
} PgfValueLit;

typedef struct {
	PgfClosure header;
	PgfLiteral lit;
	GuBuf* consts;
} PgfValueSum;

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
	PgfFunction evaluate_value_lit;
	PgfFunction evaluate_value_pap;
	PgfFunction evaluate_value_lambda;
	PgfFunction evaluate_value_const;
	PgfFunction evaluate_meta;
	PgfFunction evaluate_gen;
	PgfFunction evaluate_sum;
	PgfFunction evaluate_caf;

	PgfFunction update_closure;
	PgfFunction update_pap;

	PgfFunction mk_const;

	PgfClosure* (*enter)(PgfReasoner* rs, PgfClosure* closure);

	GuFinalizer fin;
	GuSeq* cafs;
};

PgfReasoner*
pgf_new_reasoner(PgfPGF* pgf, GuExn* err, GuPool* pool, GuPool* out_pool);

PgfClosure*
pgf_evaluate_expr_thunk(PgfReasoner* rs, PgfExprThunk* thunk);

PgfClosure*
pgf_evaluate_lambda_application(PgfReasoner* rs, PgfExprThunk* lambda,
                                                 PgfClosure* arg);

void
pgf_evaluate_accum_init_int(PgfReasoner* rs, 
                            PgfEvalAccum* accum, int val);

void
pgf_evaluate_accum_init_str(PgfReasoner* rs, 
                            PgfEvalAccum* accum, GuString val);
                            
void
pgf_evaluate_accum_init_flt(PgfReasoner* rs, 
                            PgfEvalAccum* accum, float val);

void
pgf_evaluate_accum_add(PgfReasoner* rs, 
                       PgfEvalAccum* accum, PgfClosure* closure);

PgfClosure*
pgf_evaluate_accum_done(PgfReasoner* rs, PgfEvalAccum* accum);

#endif
