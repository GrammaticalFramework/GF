#include "data.h"
#include "reasoner.h"
#include "hopu.h"

PGF_INTERNAL void
pgf_pattern_unify(PgfReasoner* rs, PgfClosure* c1, PgfClosure* c2)
{
	c1 = rs->eval_gates->enter(rs, c1);
	c2 = rs->eval_gates->enter(rs, c2);
}

