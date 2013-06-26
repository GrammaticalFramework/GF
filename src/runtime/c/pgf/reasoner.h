#ifndef PGF_REASONER_H_
#define PGF_REASONER_H_

typedef struct PgfReasoner PgfReasoner;
typedef struct PgfReasonerState PgfReasonerState;
typedef struct PgfExprState PgfExprState;

typedef void (*PgfPredicate)(PgfReasoner* rs, PgfReasonerState* st);

void
pgf_try_first(PgfReasoner* rs, PgfExprState* parent, PgfAbsFun* absfun);

void
pgf_try_else(PgfReasoner* rs, PgfExprState* prev, PgfAbsFun* absfun);

void
pgf_complete(PgfReasoner* rs, PgfExprState* st);

void
pgf_try_constant(PgfReasoner* rs, PgfExprState* prev, PgfAbsFun* absfun);

#endif
