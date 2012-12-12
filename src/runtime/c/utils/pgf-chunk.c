// Don't give too much hope to this script. It is doing the wrong thing
// but let's see how far we can get with it.

#include <gu/variant.h>
#include <gu/map.h>
#include <gu/dump.h>
#include <gu/log.h>
#include <gu/enum.h>
#include <gu/file.h>
#include <pgf/pgf.h>
#include <pgf/parser.h>
#include <pgf/lexer.h>
#include <pgf/literals.h>
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
	if (argc != 4) {
		fprintf(stderr, "usage: %s pgf cat from_lang\n", argv[0]);
		status = EXIT_FAILURE;
		goto fail;
	}
	char* filename = argv[1];

	GuString cat = gu_str_string(argv[2], pool);

	GuString from_lang = gu_str_string(argv[3], pool);
	
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

	pgf_load_meta_child_probs(pgf, "../../../treebanks/PennTreebank/ParseEngAbs3.probs", pool, err);
	if (!gu_ok(err)) {
		fprintf(stderr, "Loading meta child probs failed\n");
		status = EXIT_FAILURE;
		goto fail;
	}

	// Look up the source and destination concrete categories
	PgfConcr* from_concr = pgf_get_language(pgf, from_lang);
	if (!from_concr) {
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

	// The interactive translation loop.
	// XXX: This currently reads stdin directly, so it doesn't support
	// encodings properly. TODO: use a locale reader for input
	while (true) {
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
		}
		
		// We create a temporary pool for translating a single
		// sentence, so our memory usage doesn't increase over time.
		ppool = gu_new_pool();

		// Begin parsing a sentence of the specified category
		PgfParseState* state =
			pgf_parser_init_state(from_concr, cat, 0, ppool);
		if (state == NULL) {
			fprintf(stderr, "Couldn't begin parsing\n");
			status = EXIT_FAILURE;
			break;
		}
		
		GuReader *rdr =
			gu_string_reader(gu_str_string(line, ppool), ppool);
		PgfLexer *lexer =
			pgf_new_lexer(rdr, ppool);

		// Tokenization
		GuExn* lex_err = gu_new_exn(NULL, gu_kind(type), ppool);
		PgfToken tok = pgf_lexer_next_token(lexer, lex_err, ppool);
		while (!gu_exn_is_raised(lex_err)) {
			// feed the token to get a new parse state
			state = pgf_parser_next_state(state, tok, ppool);
			if (!state) {
				gu_puts("Unexpected token: \"", wtr, err);
				gu_string_write(tok, wtr, err);
				gu_puts("\"\n", wtr, err);
				goto fail_parse;
			}
			
			tok = pgf_lexer_next_token(lexer, lex_err, ppool);
		}

		pgf_parse_print_chunks(state);
		continue;
	fail_parse:
		// Free all resources allocated during parsing and linearization
		gu_pool_free(ppool);
		ppool = NULL;
	}
fail_concr:
fail:
	gu_pool_free(pool);
	return status;
}
