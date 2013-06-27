#include <gu/variant.h>
#include <gu/map.h>
#include <gu/dump.h>
#include <gu/log.h>
#include <gu/enum.h>
#include <gu/file.h>
#include <pgf/pgf.h>
#include <pgf/data.h>
#include <pgf/parser.h>
#include <pgf/lexer.h>
#include <pgf/literals.h>
#include <pgf/linearizer.h>
#include <pgf/expr.h>
#include <pgf/edsl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
#include <time.h>

int main(int argc, char* argv[]) {
  // Set the character locale, so we can produce proper output.
  setlocale(LC_CTYPE, "");

  // Create the pool that is used to allocate everything
  GuPool* pool = gu_new_pool();
  int status = EXIT_SUCCESS;
  if (argc < 4 || argc > 5) {
    fprintf(stderr, "usage: %s pgf-file start-cat cnc-lang [heuristics]\n(0.0 <= heuristics < 1.0, default: 0.95)\n", argv[0]);
    status = EXIT_FAILURE;
    goto fail;
  }
  char* filename = argv[1];
  GuString cat = gu_str_string(argv[2], pool);
  GuString lang = gu_str_string(argv[3], pool);

  double heuristics = 0.95;
  if (argc == 5) {
      heuristics = atof(argv[4]);
  }

  // Create an exception frame that catches all errors.
  GuExn* err = gu_new_exn(NULL, gu_kind(type), pool);


  clock_t start = clock();

  // Read the PGF grammar.
  PgfPGF* pgf = pgf_read(filename, pool, err);

  // If an error occured, it shows in the exception frame
  if (!gu_ok(err)) {
    fprintf(stderr, "Reading PGF failed\n");
    status = EXIT_FAILURE;
    goto fail;
  }

  // Look up the source and destination concrete categories
  PgfConcr* concr = pgf_get_language(pgf, lang);
  if (!concr) {
    fprintf(stderr, "Unknown language\n");
    status = EXIT_FAILURE;
    goto fail;
  }

  /* // Register a callback for the literal category Symbol */
  /* pgf_parser_add_literal(from_concr, gu_str_string("Symb", pool), */
  /*                        &pgf_nerc_literal_callback); */

  clock_t end = clock();
  double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

  fprintf(stderr, "(%.0f ms) Ready to parse [heuristics=%.2f]!\n", 1000.0 * cpu_time_used, heuristics);

  // Create an output stream for stdout
  GuOut* out = gu_file_out(stdout, pool);

  // Locale-encoding writers are currently unsupported
  // GuWriter* wtr = gu_locale_writer(out, pool);
  // Use a writer with hard-coded utf-8 encoding for now.
  GuWriter* wtr = gu_new_utf8_writer(out, pool);

  // We will keep the latest results in the 'ppool' and
  // we will iterate over them by using 'result'.
  GuPool* ppool = NULL;

  // The interactive PARSING loop.
  // XXX: This currently reads stdin directly, so it doesn't support
  // encodings properly. TODO: use a locale reader for input
  for (int ctr = 0; true; ctr++) {
    /* fprintf(stdout, "> "); */
    /* fflush(stdout); */
    char buf[4096];
    char* line = fgets(buf, sizeof(buf), stdin);
    if (line == NULL) {
      if (ferror(stdin)) {
        fprintf(stderr, "Input error\n");
        status = EXIT_FAILURE;
      }
      break;
    } else if (strcmp(line, "") == 0) {
      // End nicely on empty input
      break;
    } else if (strcmp(line, "\n") == 0) {
      // Empty line -> skip
      continue;
    }

    // We release the last results
    if (ppool != NULL) {
      gu_pool_free(ppool);
      ppool  = NULL;
    }

    // We create a temporary pool for translating a single
    // sentence, so our memory usage doesn't increase over time.
    ppool = gu_new_pool();

    clock_t start = clock();

    GuReader *rdr = gu_string_reader(gu_str_string(line, ppool), ppool);
    PgfLexer *lexer = pgf_new_simple_lexer(rdr, ppool);
    GuEnum* result = pgf_parse_with_heuristics(concr, cat, lexer, heuristics, ppool, ppool);

    PgfExprProb* ep = NULL;
    if (result != NULL) 
      ep = gu_next(result, PgfExprProb*, ppool);

    clock_t end = clock();
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

    gu_printf(wtr, err, "%d (%.0f ms): ", ctr, 1000.0 * cpu_time_used);
    if (ep != NULL) {
      gu_printf(wtr, err, "[%.4f] (", ep->prob);
      pgf_print_expr(ep->expr, NULL, 0, wtr, err);
      gu_printf(wtr, err, ")\n");
    } else {
      gu_printf(wtr, err, "---\n");
    }
    gu_writer_flush(wtr, err);
  }

 fail:
  gu_pool_free(pool);
  return status;
}

