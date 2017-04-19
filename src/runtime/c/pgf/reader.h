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

PGF_INTERNAL_DECL  PgfReader*
pgf_new_reader(GuIn* in, GuPool* opool, GuPool* tmp_pool, GuExn* err);

PGF_INTERNAL_DECL uint8_t
pgf_read_tag(PgfReader* rdr);

PGF_INTERNAL_DECL uint32_t
pgf_read_uint(PgfReader* rdr);

PGF_INTERNAL_DECL int32_t
pgf_read_int(PgfReader* rdr);

PGF_INTERNAL_DECL GuString
pgf_read_string(PgfReader* rdr);

PGF_INTERNAL_DECL double
pgf_read_double(PgfReader* rdr);

PGF_INTERNAL_DECL size_t
pgf_read_len(PgfReader* rdr);

PGF_INTERNAL_DECL PgfCId
pgf_read_cid(PgfReader* rdr, GuPool* pool);

PGF_INTERNAL_DECL PgfPGF*
pgf_read_pgf(PgfReader* rdr);

PGF_INTERNAL_DECL void
pgf_reader_done(PgfReader* rdr, PgfPGF* pgf);


// JIT specific interface
#ifdef PGF_REASONER_H_

typedef struct PgfJitState PgfJitState;

PGF_INTERNAL_DECL PgfJitState*
pgf_new_jit(PgfReader* rdr);

PGF_INTERNAL_DECL PgfEvalGates*
pgf_jit_gates(PgfReader* rdr);

PGF_INTERNAL_DECL void
pgf_jit_predicate(PgfReader* rdr, PgfAbstr* abstr,
                  PgfAbsCat* abscat);

PGF_INTERNAL_DECL void
pgf_jit_function(PgfReader* rdr, PgfAbstr* abstr,
                 PgfAbsFun* absfun);

PGF_INTERNAL_DECL void
pgf_jit_done(PgfReader* state, PgfAbstr* abstr);

#endif
#endif // READER_H_
