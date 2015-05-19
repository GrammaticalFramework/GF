#include <gu/variant.h>
#include <gu/map.h>
#include <gu/enum.h>
#include <gu/file.h>
#include <gu/exn.h>
#include <pgf/pgf.h>
#include <pgf/literals.h>
#include <pgf/linearizer.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
#include <time.h>

static void
print_result(PgfExprProb* ep, PgfConcr* to_concr, 
             GuOut* out, GuExn* err, GuPool* ppool)
{
	// Write out the abstract syntax tree
	gu_printf(out, err, " [%f] ", ep->prob);
	pgf_print_expr(ep->expr, NULL, 0, out, err);
	gu_putc('\n', out, err);

	// Enumerate the concrete syntax trees corresponding
	// to the abstract tree.
	GuEnum* cts = pgf_lzr_concretize(to_concr, ep->expr, err, ppool);
	while (true) {
		PgfCncTree ctree =
			gu_next(cts, PgfCncTree, ppool);
		if (gu_variant_is_null(ctree)) {
			break;
		}
		gu_putc(' ', out, err);
		// Linearize the concrete tree as a simple
		// sequence of strings.
		pgf_lzr_linearize_simple(to_concr, ctree, 0, out, err, ppool);

		if (gu_exn_caught(err, PgfLinNonExist)) {
			// encountered nonExist. Unfortunately there
			// might be some output printed already. The
			// right solution should be to use GuStringBuf.
			gu_exn_clear(err);
		}
		gu_putc('\n', out, err);
		gu_out_flush(out, err);
	}
}

int main(int argc, char* argv[]) {
	// Set the character locale, so we can produce proper output.
	setlocale(LC_CTYPE, "");

	// Create the pool that is used to allocate everything
	GuPool* pool = gu_new_pool();
	int status = EXIT_SUCCESS;
	if (argc < 5) {
		fprintf(stderr, "usage: %s pgf cat from-lang to-lang\n", argv[0]);
		status = EXIT_FAILURE;
		goto fail;
	}

	GuString filename = argv[1];
	GuString cat = argv[2];
	GuString from_lang = argv[3];
	GuString to_lang = argv[4];

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(pool);

	// Read the PGF grammar.
	PgfPGF* pgf = pgf_read(filename, pool, err);

	// If an error occured, it shows in the exception frame
	if (!gu_ok(err)) {
		fprintf(stderr, "Reading PGF failed\n");
		status = EXIT_FAILURE;
		goto fail;
	}

	// Look up the source and destination concrete categories
	PgfConcr* from_concr = pgf_get_language(pgf, from_lang);
	PgfConcr* to_concr = pgf_get_language(pgf, to_lang);
	if (!from_concr || !to_concr) {
		fprintf(stderr, "Unknown language\n");
		status = EXIT_FAILURE;
		goto fail_concr;
	}
	
	// Register a callback for the literal category Symbol
	PgfCallbacksMap* callbacks =
		pgf_new_callbacks_map(from_concr, pool);
	pgf_callbacks_map_add_literal(from_concr, callbacks,
	                              "PN", &pgf_nerc_literal_callback);
	pgf_callbacks_map_add_literal(from_concr, callbacks,
	                              "Symb", &pgf_unknown_literal_callback);

	// Create an output stream for stdout
	GuOut* out = gu_file_out(stdout, pool);

	// We will keep the latest results in the 'ppool' and
	// we will iterate over them by using 'result'.
	GuPool* ppool = NULL;
	GuEnum* result = NULL;

	// The interactive translation loop.
	// XXX: This currently reads stdin directly, so it doesn't support
	// encodings properly. TODO: use a locale reader for input
	while (true) {
		fprintf(stdout, "> ");
		fflush(stdout);
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
			// Empty line -> show the next tree for the last sentence

			if (result != NULL) {
				clock_t start = clock();

				PgfExprProb* ep = gu_next(result, PgfExprProb*, ppool);

				clock_t end = clock();
				double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
				printf("%.2f sec\n", cpu_time_used);

				// The enumerator will return a null variant at the
				// end of the results.
				if (ep == NULL) {
					goto fail_parse;
				}
				
				print_result(ep, to_concr, out, err, ppool);
			}
			continue;
		}

		// We release the last results
		if (ppool != NULL) {
			gu_pool_free(ppool);
			ppool  = NULL;
			result = NULL;
		}
		
		// We create a temporary pool for translating a single
		// sentence, so our memory usage doesn't increase over time.
		ppool = gu_new_pool();

		clock_t start = clock();

		GuExn* parse_err = gu_new_exn(ppool);
		result =
			pgf_parse_with_heuristics(from_concr, cat, line, 
			                          -1, callbacks,
			                          parse_err, ppool, ppool);
		if (!gu_ok(parse_err)) {
			if (gu_exn_caught(parse_err, PgfExn)) {
				GuString msg = gu_exn_caught_data(parse_err);
				gu_string_write(msg, out, err);
				gu_putc('\n', out, err);
			} else if (gu_exn_caught(parse_err, PgfParseError)) {
				gu_puts("Unexpected token: \"", out, err);
				GuString tok = gu_exn_caught_data(parse_err);
				gu_string_write(tok, out, err);
				gu_puts("\"\n", out, err);
			}

			goto fail_parse;
		}

		PgfExprProb* ep = gu_next(result, PgfExprProb*, ppool);

		clock_t end = clock();
		double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
		printf("%.2f sec\n", cpu_time_used);

		// The enumerator will return null at the end of the results.
		if (ep == NULL) {
			goto fail_parse;
		}
		
		print_result(ep, to_concr, out, err, ppool);

		continue;
	fail_parse:
		// Free all resources allocated during parsing and linearization
		gu_pool_free(ppool);
		ppool = NULL;
		result = NULL;
	}
fail_concr:
fail:
	gu_pool_free(pool);
	return status;
}

