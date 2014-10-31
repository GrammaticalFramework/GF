#include "data.h"
#include "evaluator.h"
#include "hopu.h"

void pgf_pattern_unify(PgfEvalState* state, PgfClosure* c1, PgfClosure* c2)
{
	c1 = state->eval_gates->enter(state, c1);
	c2 = state->eval_gates->enter(state, c2);
}

