#include <gu/variant.h>
#include <gu/map.h>
#include <gu/dump.h>
#include <gu/log.h>
#include <gu/enum.h>
#include <gu/file.h>
#include <pgf/pgf.h>
#include <pgf/data.h>
#include <pgf/parser.h>
#include <pgf/linearize.h>
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
	if (argc != 5) {
		fprintf(stderr, "usage: %s pgf [.]cat from_lang to_lang\n", argv[0]);
		status = EXIT_FAILURE;
		goto fail;
	}
	char* filename = argv[1];

	GuString cat;
	bool robust_mode;
	if (argv[2][0] == '.') {
		cat = gu_str_string(argv[2]+1, pool);
		robust_mode = true;
	} else {
		cat = gu_str_string(argv[2], pool);
		robust_mode = false;
	}

	GuString from_lang = gu_str_string(argv[3], pool);
	GuString to_lang = gu_str_string(argv[4], pool);
	
	FILE* infile = fopen(filename, "r");
	if (infile == NULL) {
		fprintf(stderr, "couldn't open %s\n", filename);
		status = EXIT_FAILURE;
		goto fail;
	}

	// Create an input stream from the input file
	GuIn* in = gu_file_in(infile, pool);

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), pool);

	// Read the PGF grammar.
	PgfPGF* pgf = pgf_read(in, pool, err);

	// If an error occured, it shows in the exception frame
	if (!gu_ok(err)) {
		fprintf(stderr, "Reading PGF failed\n");
		status = EXIT_FAILURE;
		goto fail_read;
	}

	// Look up the source and destination concrete categories
	PgfConcr* from_concr =
		gu_map_get(pgf->concretes, &from_lang, PgfConcr*);
	PgfConcr* to_concr =
		gu_map_get(pgf->concretes, &to_lang, PgfConcr*);
	if (!from_concr || !to_concr) {
		fprintf(stderr, "Unknown language\n");
		status = EXIT_FAILURE;
		goto fail_concr;
	}

	// Arbitrarily choose linearization index 0. Usually the initial
	// categories we are interested in only have one field.
	int lin_idx = 0;

	// Create an output stream for stdout
	GuOut* out = gu_file_out(stdout, pool);

	// Locale-encoding writers are currently unsupported
	// GuWriter* wtr = gu_locale_writer(out, pool);
	// Use a writer with hard-coded utf-8 encoding for now.
	GuWriter* wtr = gu_new_utf8_writer(out, pool);

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
		} else if (line[0] == '\0') {
			// End nicely on empty input
			break;
		}
		// We create a temporary pool for translating a single
		// sentence, so our memory usage doesn't increase over time.
		GuPool* ppool = gu_new_pool();

		clock_t start = clock();

		// Begin parsing a sentence of the specified category
		PgfParse* parse =
			pgf_parser_parse(from_concr, cat, lin_idx, pool);
		if (parse == NULL) {
			fprintf(stderr, "Couldn't begin parsing\n");
			status = EXIT_FAILURE;
			break;
		}

		// naive tokenization
		char* tok = strtok(line, " \n");
		while (tok) {
			GuString tok_s = gu_str_string(tok, pool);
			gu_debug("parsing token \"%s\"", tok);
			// feed the token to get a new parse state
			parse = pgf_parse_token(parse, tok_s, robust_mode, ppool);
			if (!parse) {
				fprintf(stderr,
					"Unexpected token: \"%s\"\n", tok);
				goto fail_parse;
			}
			tok = strtok(NULL, " \n");
		}
		
		// Now begin enumerating the resulting syntax trees
		GuEnum* result = pgf_parse_result(parse, ppool);

		clock_t end = clock();

		double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
		printf("%.2f sec\n", cpu_time_used);

		while (true) {
			PgfExpr expr = gu_next(result, PgfExpr, ppool);
			
			clock_t end = clock();
			
			// The enumerator will return a null variant at the
			// end of the results.
			if (gu_variant_is_null(expr)) {
				break;
			}
			gu_putc(' ', wtr, err);
			// Write out the abstract syntax tree
			pgf_print_expr(expr, 0, wtr, err);
			gu_putc('\n', wtr, err);
			
			if (robust_mode) {
				double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
				printf("%.2f sec\n", cpu_time_used);
				break;
			}

			// Enumerate the concrete syntax trees corresponding
			// to the abstract tree.
			GuEnum* cts = pgf_lzr_concretize(to_concr, expr, ppool);
			while (true) {
				PgfCncTree ctree =
					gu_next(cts, PgfCncTree, ppool);
				if (gu_variant_is_null(ctree)) {
					break;
				}
				gu_puts("  ", wtr, err);
				// Linearize the concrete tree as a simple
				// sequence of strings.
				pgf_lzr_linearize_simple(to_concr	, ctree, lin_idx,
							 wtr, err);
				gu_putc('\n', wtr, err);
				gu_writer_flush(wtr, err);
			}
		}
	fail_parse:
		// Free all resources allocated during parsing and linearization
		gu_pool_free(ppool);
	}
fail_concr:
fail_read:
	fclose(infile);
fail:
	gu_pool_free(pool);
	return status;
}

