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

		pgf_graphviz_abstract_tree(expr, wtr, err);
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

static void
put_gu_string(GuString s) {
	GuWord w = s.w_;
	uint8_t buf[sizeof(GuWord)];

	char* src;
	size_t len;
	if (w & 1) {
		len = (w & 0xff) >> 1;
		gu_assert(len <= sizeof(GuWord));
		size_t i = len;
		while (i > 0) {
			w >>= 8;
			buf[--i] = w & 0xff;
		}
		src = (char*) buf;
	} else {
		uint8_t* p = (void*) w;
		len = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		src = (char*) &p[1];
	}

	for (size_t i = 0; i < len; i++) {
		FCGI_putchar(src[i]);
	}
}

static void
linearize(PgfConcr* concr, PgfExpr expr, GuPool* pool)
{
	GuStringBuf* sbuf = gu_string_buf(pool);
	GuWriter* wtr = gu_string_buf_writer(sbuf);

	GuExn* err = gu_new_exn(NULL, gu_kind(type), pool);
	
	pgf_linearize(concr, expr, wtr, err);
	
	GuString s = gu_string_buf_freeze(sbuf, pool);
	put_gu_string(s);
}

static void
print_lang(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId lang = *((PgfCId*) key);
	put_gu_string(lang);
	FCGI_putchar(' ');
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
	char* probs_name = "/ParseEngAbs3.probs";
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
	GuString from_lang = gu_str_string("ParseEng", pool);
	PgfConcr* from_concr =
		pgf_get_language(pgf, from_lang);
	if (!from_concr) {
		status = EXIT_FAILURE;
		goto fail;
	}

	// Register a callback for the literal category Symbol
	pgf_parser_add_literal(from_concr, gu_str_string("Symb", pool),
	                       &pgf_nerc_literal_callback);

    while (FCGI_Accept() >= 0) {
		char* query = getenv("QUERY_STRING");

		char sentence[202];
		char to_lang_buf[51] = "";
		if (query == NULL ||
		    sscanf(query, "sentence=%200[^&]&to=%50[^&]", sentence, to_lang_buf) < 1) {
			FCGI_printf("Status: 200 OK\r\n");
			FCGI_printf("Content-type: text/plain; charset=utf-8\r\n\r\n");

			GuMapItor clo = { print_lang };
			pgf_iter_languages(pgf, &clo, NULL);
			FCGI_putchar('\n');
		} else {
			// We create a temporary pool for translating a single
			// sentence, so our memory usage doesn't increase over time.
			GuPool* ppool = gu_new_pool();

			PgfConcr* to_concr = NULL;
			if (strlen(to_lang_buf) > 0) {
				GuString to_lang = gu_str_string(to_lang_buf, ppool);
				to_concr =
					pgf_get_language(pgf, to_lang);
				if (!to_concr) {
					status = EXIT_FAILURE;
					goto fail;
				}
			}

			url_escape(sentence);
			int len = strlen(sentence);
			sentence[len] = '\n';
			sentence[len+1] = '\0';
		
			GuReader *rdr =
				gu_string_reader(gu_str_string(sentence, ppool), ppool);
			PgfLexer *lexer =
				pgf_new_simple_lexer(rdr, ppool);

			GuEnum* result = 
				pgf_parse(from_concr, cat, lexer, ppool, ppool);
			if (result == NULL) {
				FCGI_printf("Status: 500 Internal Server Error\r\n");
				FCGI_printf("Content-type: text/plain\r\n"
							"\r\n"
							"Parsing failed");
				goto done;
			}

			PgfExprProb* ep = gu_next(result, PgfExprProb*, ppool);
			if (ep == NULL) {
				FCGI_printf("Status: 500 Internal Server Error\r\n");
				FCGI_printf("Content-type: text/plain\r\n"
							"\r\n"
							"The sentence was parsed but there was no tree constructed");
				goto done;
			}

			FCGI_printf("Status: 200 OK\r\n");
			if (to_concr == NULL) {
				FCGI_printf("Content-type: image/svg+xml\r\n\r\n");
				render(ep->expr, ppool);
			} else {
				FCGI_printf("Content-type: text/plain; charset=utf-8\r\n\r\n");
				linearize(to_concr, ep->expr, ppool);
			}

done:
			gu_pool_free(ppool);
		}
    }
    
fail:
    gu_pool_free(pool);
    return status;
}
