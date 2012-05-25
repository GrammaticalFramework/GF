#include <stdarg.h>
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
#include <pgf/linearize.h>
#include <pgf/expr.h>

#define NO_FCGI_DEFINES
#include <fcgi_stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define ISXDIGIT(c) ( \
    (c >= 48 && c <= 57) || \
    ((c & ~0x20) >= 65 && (c & ~0x20) <= 70) \
)
  
void
url_escape(char *str)
{
    char *pr = str, *pw = str;
    size_t len = strlen(str);
    
    for (;;) {
        if ((pr - str) >= len)
            break;

        if (*pr == '%' &&
            ((pr - str)+2) < len &&
            ISXDIGIT(*(pr+1)) &&
            ISXDIGIT(*(pr+2))) 
		{
            pr++;

			char hexstr[3];
            hexstr[0] = *pr++;
            hexstr[1] = *pr++;
            hexstr[2] = 0;

			char *ptr;
            int ch = strtoul(hexstr, &ptr, 16);
            *pw++ = (char) (ch & 0x7f);
        }
        else if(*pr == '+') {
            *pw++ = ' ';
        }
        else {
			*pw++ = *pr++;
		}
	}

    *pw++ = 0;
}

static int
generate_graphviz_expr(PgfExpr expr, int *pid,
                       GuWriter* wtr, GuExn* err, GuPool* pool)
{
	int id;
	
	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;
		id = (*pid)++;
		gu_printf(wtr, err, "n%d[label = \"", id);
		gu_string_write(fun->fun, wtr, err);
		gu_puts("\", style = \"solid\", shape = \"plaintext\"]\n", wtr, err);
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		id = generate_graphviz_expr(app->fun, pid, wtr, err, pool);
		int arg_id = generate_graphviz_expr(app->arg, pid, wtr, err, pool);
		gu_printf(wtr, err, "n%d -- n%d [style = \"solid\"]\n", id, arg_id);
		break;
	}
	case PGF_EXPR_ABS:
	case PGF_EXPR_LIT: {
		PgfExprLit* lit = ei.data;
		id = (*pid)++;
		gu_printf(wtr, err, "n%d[label = \"", id);
		
		GuVariantInfo ei = gu_variant_open(lit->lit);
		switch (ei.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lit = ei.data;
			gu_puts("\\\"", wtr, err);
			gu_string_write(lit->val, wtr, err);
			gu_puts("\\\"", wtr, err);
			break;
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lit = ei.data;
			gu_printf(wtr, err, "%d", lit->val);
			break;
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lit = ei.data;
			gu_printf(wtr, err, "%lf", lit->val);
			break;
		}
		default:
			gu_impossible();
		}

		gu_puts("\", style = \"solid\", shape = \"plaintext\"]\n", wtr, err);
		break;
	}
	case PGF_EXPR_META:
		id = (*pid)++;
		gu_printf(wtr, err, "n%d[label = \"?\", style = \"solid\", shape = \"plaintext\"]\n", id);
		break;
	case PGF_EXPR_VAR:
	case PGF_EXPR_TYPED:
	case PGF_EXPR_IMPL_ARG:
		gu_impossible();
		break;
	default:
		gu_impossible();
	}
	
	return id;
}

static void
generate_graphviz(PgfExpr expr, GuWriter* wtr, GuExn* err, GuPool* pool)
{
	int id = 0;

	gu_puts("graph {\n", wtr, err);
	generate_graphviz_expr(expr, &id, wtr, err, pool);
	gu_puts("}", wtr, err);
}

static int
render(PgfExpr expr, GuPool* pool)
{
	int pid;
	int pc[2]; /* Parent to child pipe */
	int cp[2]; /* Child to parent pipe */
	char ch;

	/* Make pipes */
	if (pipe(pc) < 0)
		return 0;
	if (pipe(cp) < 0)
		return 0;

	/* Create a child to run command. */
	switch (pid = fork())
	{
	case -1: 
		return 0;
	case 0:
		/* Child. */
		dup2(cp[1], 1); /* Make stdout go to write
					       end of pipe. */
		dup2(pc[0], 0); /* Make stdin come from read
			 		       end of pipe. */
		close(pc[1]);
		close(cp[0]);

		char *args[] = {"dot", "-Tsvg", NULL};
		execvp(args[0], args);

		exit(1);
	default: {
		/* Parent. */
		FILE* fstream = fdopen(pc[1], "w");
		GuOut* out = gu_file_out(fstream, pool);
		GuWriter* wtr = gu_new_utf8_writer(out, pool);
		GuExn* err = gu_new_exn(NULL, gu_kind(type), pool);

		generate_graphviz(expr, wtr, err, pool);
		fclose(fstream);

		close(cp[1]);
		while (read(cp[0], &ch, 1) == 1)
		{
			FCGI_putchar(ch);
		}
		return 1;
	}
	}
}

int main ()
{
	// Create the pool that is used to allocate everything
	GuPool* pool = gu_new_pool();
	int status = EXIT_SUCCESS;

	FILE* infile = fopen("/home/krasimir/www.grammaticalframework.org/examples/PennTreebank/ParseEngAbs.pgf", "r");
	if (infile == NULL) {
		fprintf(stderr, "couldn't open the grammar\n");
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

	GuString cat = gu_str_string("Utt", pool);
	GuString lang = gu_str_string("ParseEng", pool);
	PgfConcr* concr =
		gu_map_get(pgf->concretes, &lang, PgfConcr*);
	if (!concr) {
		status = EXIT_FAILURE;
		goto fail;
	}

	// Register a callback for the literal category Symbol
	pgf_parser_add_literal(concr, gu_str_string("Symb", pool),
	                       &pgf_nerc_literal_callback);

    while (FCGI_Accept() >= 0) {
		char* sentence = getenv("QUERY_STRING");
		if (sentence == NULL ||
		    (sentence = strchr(sentence, '=')) == NULL) {
			FCGI_printf("Content-type: text/html\r\n"
				        "\r\n"
				        "<body>Please specify a sentence to parse</body>\r\n");
		} else {
			sentence++;

			// We create a temporary pool for translating a single
			// sentence, so our memory usage doesn't increase over time.
			GuPool* ppool = gu_new_pool();

			char* tmp = gu_malloc(ppool, strlen(sentence)+2);
			strcpy(tmp, sentence);
			url_escape(tmp);
			int len = strlen(tmp);
			tmp[len] = '\n';
			tmp[len+1] = '\0';
			sentence = tmp;

			// Begin parsing a sentence of the specified category
			PgfParseState* state =
				pgf_parser_init_state(concr, cat, 0, pool);
			if (state == NULL) {
				FCGI_printf("Content-type: text/html\r\n"
				            "\r\n"
				            "<body>Couldn't begin parsing</body>");
				goto fail_request;
			}
		
			GuReader *rdr =
				gu_string_reader(gu_str_string(sentence, ppool), ppool);
			PgfLexer *lexer =
				pgf_new_lexer(rdr, ppool);

			// Tokenization
			GuExn* lex_err = gu_new_exn(NULL, gu_kind(type), ppool);
			PgfToken tok = pgf_lexer_next_token(lexer, lex_err, ppool);
			while (!gu_exn_is_raised(lex_err)) {
				// feed the token to get a new parse state
				state = pgf_parser_next_state(state, tok, ppool);
				if (!state) {
					FCGI_printf("Content-type: text/html\r\n"
								"\r\n"
								"<body>Unexpected token</body>");
					goto fail_request;
				}
				
				tok = pgf_lexer_next_token(lexer, lex_err, ppool);
			}

			// Now begin enumerating the resulting syntax trees
			GuEnum* result = pgf_parse_result(state, ppool);

			PgfExprProb* ep = gu_next(result, PgfExprProb*, ppool);

			FCGI_printf("Content-type: image/svg+xml\r\n\r\n");

			render(ep->expr, ppool);

fail_request:
			gu_pool_free(ppool);
		}
    }
    
fail_read:
	fclose(infile);
fail:
    gu_pool_free(pool);
    return status;
}
