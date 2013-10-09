#ifndef PGF_PARSER_H_
#define PGF_PARSER_H_

#include <gu/enum.h>
#include <pgf/data.h>
#include <pgf/expr.h>

void
pgf_add_extern_tok(PgfSymbol* psym, PgfToken tok, GuPool* pool);

void
pgf_add_extern_cat(PgfSymbol* psym, int d, int r, GuPool* pool);

void
pgf_parser_add_literal(PgfConcr *concr, PgfCId cat,
                       PgfLiteralCallback* callback);

#endif // PGF_PARSER_H_
