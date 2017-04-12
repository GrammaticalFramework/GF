#ifndef PGF_LITERALS_H_
#define PGF_LITERALS_H_

// MSVC requires explicit export/import of
// symbols in DLLs. CMake takes care of this
// for functions, but not for data/variables.
#if defined(_MSC_VER)
#if defined(COMPILING_PGF)
#define PGF_API_DATA_DECL __declspec(dllexport)
#define PGF_API_DATA __declspec(dllexport)
#else
#define PGF_API_DATA_DECL __declspec(dllimport)
#define PGF_API_DATA ERROR_NOT_COMPILING_LIBPGF
#endif

#else

#define PGF_API_DATA_DECL extern
#define PGF_API_DATA
#endif
// end MSVC workaround
 
 
#include <pgf/data.h>

// literal for named entities recognition
PGF_API_DATA_DECL PgfLiteralCallback pgf_nerc_literal_callback;

// literal for finding unknown words
PGF_API_DATA_DECL PgfLiteralCallback pgf_unknown_literal_callback;

PgfCCat*
pgf_literal_cat(PgfConcr* concr, PgfLiteral lit);

#endif // PGF_LITERALS_H_
