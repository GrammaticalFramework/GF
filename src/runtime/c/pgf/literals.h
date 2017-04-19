#ifndef PGF_LITERALS_H_
#define PGF_LITERALS_H_
 
#include <pgf/data.h>

// literal for named entities recognition
PGF_API_DECL extern PgfLiteralCallback pgf_nerc_literal_callback;

// literal for finding unknown words
PGF_API_DECL extern PgfLiteralCallback pgf_unknown_literal_callback;

PGF_INTERNAL_DECL PgfCCat*
pgf_literal_cat(PgfConcr* concr, PgfLiteral lit);

#endif // PGF_LITERALS_H_
