#ifndef READER_H_
#define READER_H_

#include <gu/exn.h>
#include <gu/mem.h>
#include <gu/in.h>

typedef struct PgfReader PgfReader;

PgfReader*
pgf_new_reader(GuIn* in, GuPool* opool, GuPool* tmp_pool, GuExn* err);

PgfPGF*
pgf_read_pgf(PgfReader* rdr);

#endif // READER_H_
