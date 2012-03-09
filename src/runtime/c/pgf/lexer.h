#ifndef PGF_LEXER_H_
#define PGF_LEXER_H_

#include <gu/read.h>
#include <pgf/data.h>

typedef struct PgfLexer PgfLexer;

PgfLexer*
pgf_new_lexer(GuReader *rdr, GuPool *pool);

PgfToken
pgf_lexer_next_token(PgfLexer *lexer, GuExn* err, GuPool *pool);

#endif // PGF_LEXER_H_
