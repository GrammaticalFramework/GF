#ifndef READER_H_
#define READER_H_

#include <gu/exn.h>
#include <gu/mem.h>
#include <gu/in.h>

// general reader interface

typedef struct {
	GuIn* in;
	GuExn* err;
	GuPool* opool;
	GuPool* tmp_pool;
	GuBuf* non_lexical_buf;
	struct PgfJitState* jit_state;
} PgfReader;

PgfReader*
pgf_new_reader(GuIn* in, GuPool* opool, GuPool* tmp_pool, GuExn* err);

uint8_t
pgf_read_tag(PgfReader* rdr);

uint32_t
pgf_read_uint(PgfReader* rdr);

int32_t
pgf_read_int(PgfReader* rdr);

GuString
pgf_read_string(PgfReader* rdr);

double
pgf_read_double(PgfReader* rdr);

size_t
pgf_read_len(PgfReader* rdr);

PgfCId
pgf_read_cid(PgfReader* rdr, GuPool* pool);

PgfPGF*
pgf_read_pgf(PgfReader* rdr);

void
pgf_reader_done(PgfReader* rdr, PgfPGF* pgf);


// JIT specific interface
#ifdef PGF_EVALUATOR_H_

typedef struct PgfJitState PgfJitState;

PgfJitState*
pgf_new_jit(PgfReader* rdr);

PgfEvalGates*
pgf_jit_gates(PgfReader* rdr);

void
pgf_jit_predicate(PgfReader* rdr, PgfAbstr* abstr,
                  PgfAbsCat* abscat);

void
pgf_jit_function(PgfReader* rdr, PgfAbstr* abstr,
                 PgfAbsFun* absfun);

void
pgf_jit_done(PgfReader* state, PgfAbstr* abstr);

#endif
#endif // READER_H_
