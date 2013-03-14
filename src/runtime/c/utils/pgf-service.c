#include <stdarg.h>
#include <gu/map.h>
#include <gu/dump.h>
#include <gu/log.h>
#include <gu/enum.h>
#include <gu/file.h>
#include <pgf/pgf.h>
#include <pgf/literals.h>
#include <pgf/parser.h>

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
        if (((size_t) (pr - str)) >= len)
            break;

        if (*pr == '%' &&
            (((size_t) (pr - str))+2) < len &&
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

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), pool);

	char* grammar_path = getenv("GRAMMAR_PATH");
	if (grammar_path == NULL) {
		fprintf(stderr, "Please set the GRAMMAR_PATH variable\n");
		status = EXIT_FAILURE;
		goto fail;
	}

	// Read the PGF grammar.
	char* grammar_name = "/ParseEngAbs.pgf";
	char* grammar_file = malloc(strlen(grammar_path)+strlen(grammar_name)+1);
	strcpy(grammar_file,grammar_path);
	strcat(grammar_file,grammar_name);
	PgfPGF* pgf = pgf_read(grammar_file, pool, err);
	free(grammar_file);

	// If an error occured, it shows in the exception frame
	if (!gu_ok(err)) {
		fprintf(stderr, "Reading PGF failed\n");
		status = EXIT_FAILURE;
		goto fail;
	}

	// Read the extra probs.
	char* probs_name = "/ParseEngAbs2.probs";
	char* probs_file = malloc(strlen(grammar_path)+strlen(probs_name)+1);
	strcpy(probs_file,grammar_path);
	strcat(probs_file,probs_name);
	pgf_load_meta_child_probs(pgf, probs_file, pool, err);
	free(probs_file);

	if (!gu_ok(err)) {
		fprintf(stderr, "Loading meta child probs failed\n");
		status = EXIT_FAILURE;
		goto fail;
	}

	GuString cat = gu_str_string("Phr", pool);
	GuString lang = gu_str_string("ParseEng", pool);
	PgfConcr* concr =
		pgf_get_language(pgf, lang);
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
				        "<body>Please type a sentence to parse</body>\r\n");
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
		
			GuReader *rdr =
				gu_string_reader(gu_str_string(sentence, ppool), ppool);
			PgfLexer *lexer =
				pgf_new_simple_lexer(rdr, ppool);

			GuEnum* result = 
				pgf_parse(concr, cat, lexer, ppool);
			if (result == NULL) {
				FCGI_printf("Content-type: text/html\r\n"
							"\r\n"
							"<body>Parsing failed</body>");
				goto fail_request;
			}

			PgfExprProb* ep = gu_next(result, PgfExprProb*, ppool);
			if (ep == NULL) {
				FCGI_printf("Content-type: text/html\r\n"
							"\r\n"
							"<body>The sentence was parsed but there was no tree constructed</body>");
				goto fail_request;
			}

			FCGI_printf("Content-type: image/svg+xml\r\n\r\n");
			render(ep->expr, ppool);

fail_request:
			gu_pool_free(ppool);
		}
    }
    
fail:
    gu_pool_free(pool);
    return status;
}
