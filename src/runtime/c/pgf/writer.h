#ifndef WRITER_H_
#define WRITER_H_

#include <gu/exn.h>
#include <gu/mem.h>
#include <gu/in.h>

// the writer interface

typedef struct PgfWriter PgfWriter;

PGF_INTERNAL_DECL PgfWriter*
pgf_new_writer(GuOut* out, GuPool* pool, GuExn* err);

PGF_INTERNAL_DECL void
pgf_write_tag(uint8_t tag, PgfWriter* wtr);

PGF_INTERNAL_DECL void
pgf_write_uint(uint32_t val, PgfWriter* wtr);

PGF_INTERNAL_DECL void
pgf_write_int(int32_t val, PgfWriter* wtr);

PGF_INTERNAL_DECL void
pgf_write_string(GuString val, PgfWriter* wtr);

PGF_INTERNAL_DECL void
pgf_write_double(double val, PgfWriter* wtr);

PGF_INTERNAL_DECL void
pgf_write_len(size_t len, PgfWriter* wtr);

PGF_INTERNAL_DECL void
pgf_write_cid(PgfCId id, PgfWriter* wtr);

PGF_INTERNAL_DECL void
pgf_write_pgf(PgfPGF* pgf, PgfWriter* wtr);

#endif // WRITER_H_
