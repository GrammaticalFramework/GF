#ifndef PGF_EVALUATOR_H_
#define PGF_EVALUATOR_H_

struct PgfEvalState {
	PgfPGF* pgf;
	GuPool* pool;
	GuExn* err;
	GuBuf* stack;
};

typedef struct PgfClosure PgfClosure;
typedef struct PgfEvalState PgfEvalState;

typedef PgfClosure* (*PgfFunction)(PgfEvalState* state, PgfClosure* val);

struct PgfClosure {
	PgfFunction code;
};

typedef struct {
	PgfClosure header;
	PgfAbsFun* absfun;
	PgfClosure* args[];
} PgfValue;

PgfClosure*
pgf_evaluate_value(PgfEvalState* state, PgfClosure* closure);

void
pgf_evaluate_save_variables(PgfEvalState* state, PgfValue* val);

#endif
