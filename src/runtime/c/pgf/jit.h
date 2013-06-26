#ifndef PGF_JIT_H_
#define PGF_JIT_H_

typedef struct PgfJitState PgfJitState;

PgfJitState*
pgf_jit_init(GuPool* tmp_pool, GuPool* pool);

void
pgf_jit_done(PgfJitState* state, PgfAbstr* abstr);

void
pgf_jit_predicate(PgfJitState* state, PgfCIdMap* abscats, 
                  PgfAbsCat* abscat, GuBuf* functions);

#endif
