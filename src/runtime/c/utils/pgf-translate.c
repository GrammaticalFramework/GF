#include <gu/variant.h>
#include <gu/map.h>
#include <gu/dump.h>
#include <gu/log.h>
#include <gu/enum.h>
#include <gu/file.h>
#include <pgf/pgf.h>
#include <pgf/parser.h>
#include <pgf/literals.h>
#include <pgf/linearizer.h>
#include <pgf/edsl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
#include <time.h>

static void
print_result(PgfExprProb* ep, PgfConcr* to_concr, 
             GuWriter* wtr, GuExn* err, GuPool* ppool)
{
	// Write out the abstract syntax tree
	gu_printf(wtr, err, " [%f] ", ep->prob);
	pgf_print_expr(ep->expr, 0, wtr, err);
	gu_putc('\n', wtr, err);

	// Enumerate the concrete syntax trees corresponding
	// to the abstract tree.
	GuEnum* cts = pgf_lzr_concretize(to_concr, ep->expr, ppool);
	while (true) {
		PgfCncTree ctree =
			gu_next(cts, PgfCncTree, ppool);
		if (gu_variant_is_null(ctree)) {
			break;
		}
		gu_putc(' ', wtr, err);
		// Linearize the concrete tree as a simple
		// sequence of strings.
		pgf_lzr_linearize_simple(to_concr	, ctree, 0, wtr, err);
		gu_putc('\n', wtr, err);
		gu_writer_flush(wtr, err);
	}
}

int main(int argc, char* argv[]) {
	// Set the character locale, so we can produce proper output.
	setlocale(LC_CTYPE, "");

	// Create the pool that is used to allocate everything
	GuPool* pool = gu_new_pool();
	int status = EXIT_SUCCESS;
	if (argc < 5 || argc > 6) {
		fprintf(stderr, "usage: %s pgf cat from-lang to-lang [probs-file]\n", argv[0]);
		status = EXIT_FAILURE;
		goto fail;
	}
	char* filename = argv[1];

	GuString cat = gu_str_string(argv[2], pool);

	GuString from_lang = gu_str_string(argv[3], pool);
	GuString to_lang = gu_str_string(argv[4], pool);
	
	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), pool);

	// Read the PGF grammar.
	PgfPGF* pgf = pgf_read(filename, pool, err);

	// If an error occured, it shows in the exception frame
	if (!gu_ok(err)) {
		fprintf(stderr, "Reading PGF failed\n");
		status = EXIT_FAILURE;
		goto fail;
	}

	if (argc == 6) {
		char* meta_probs_filename = argv[5];
		pgf_load_meta_child_probs(pgf, meta_probs_filename, pool, err);
		if (!gu_ok(err)) {
			fprintf(stderr, "Loading meta child probs failed\n");
			status = EXIT_FAILURE;
			goto fail;
		}
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
	pgf_parser_add_literal(from_concr, gu_str_string("Symb", pool),
	                       &pgf_nerc_literal_callback);

	// Create an output stream for stdout
	GuOut* out = gu_file_out(stdout, pool);

	// Locale-encoding writers are currently unsupported
	// GuWriter* wtr = gu_locale_writer(out, pool);
	// Use a writer with hard-coded utf-8 encoding for now.
	GuWriter* wtr = gu_new_utf8_writer(out, pool);

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
				
				print_result(ep, to_concr, wtr, err, ppool);
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

		GuReader *rdr =
			gu_string_reader(gu_str_string(line, ppool), ppool);
		PgfLexer *lexer =
			pgf_new_simple_lexer(rdr, ppool);

		clock_t start = clock();

		GuEnum* result =
			pgf_parse(from_concr, cat, lexer, ppool);
		if (result == NULL) {
			PgfToken tok =
				pgf_lexer_current_token(lexer);

			if (gu_string_eq(tok, gu_empty_string))
				gu_puts("Couldn't begin parsing", wtr, err);
			else {
				gu_puts("Unexpected token: \"", wtr, err);
				gu_string_write(tok, wtr, err);
				gu_puts("\"\n", wtr, err);
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
		
		print_result(ep, to_concr, wtr, err, ppool);

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

