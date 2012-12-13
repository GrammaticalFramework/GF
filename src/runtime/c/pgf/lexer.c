#include <gu/list.h>
#include <pgf/pgf.h>
#include <pgf/data.h>
#include <wctype.h>

struct PgfLexer {
	GuReader* rdr;
	GuPool* pool;
	GuUCS ucs;
	PgfToken tok;
};

PgfLexer*
pgf_new_lexer(GuReader *rdr, GuPool *pool)
{
	PgfLexer* lexer = gu_new(PgfLexer, pool);
	lexer->rdr = rdr;
	lexer->pool = pool;
	lexer->ucs = ' ';
	lexer->tok = gu_empty_string;
	return lexer;
}

static void
pgf_lexer_read_ucs(PgfLexer *lexer, GuExn* err)
{
	lexer->ucs = gu_read_ucs(lexer->rdr, err);
	if (gu_exn_is_raised(err)) {
		gu_exn_clear(err);
		lexer->ucs = ' ';
	}
}

PgfToken
pgf_lexer_read_token(PgfLexer *lexer, GuExn* err)
{
	GuPool* tmp_pool = gu_new_pool();

	GuStringBuf* buf = gu_string_buf(tmp_pool);
	GuWriter* wtr = gu_string_buf_writer(buf);

	while (iswspace(lexer->ucs)) {
		lexer->ucs = gu_read_ucs(lexer->rdr, err);
		if (gu_exn_is_raised(err))
			goto stop;
	}

	if (iswalpha(lexer->ucs) ||
	    lexer->ucs == '\''   ||
	    lexer->ucs == '_') {
		int counter = 0;
		do {
			gu_ucs_write(lexer->ucs, wtr, err);
			if (gu_exn_is_raised(err))
				goto stop;
			counter++;
			pgf_lexer_read_ucs(lexer, err);

			if (lexer->ucs == '.' && counter < 4) {
				// perhaps an abreviation
				gu_ucs_write(lexer->ucs, wtr, err);
				if (gu_exn_is_raised(err))
					goto stop;
				counter = 0;
				pgf_lexer_read_ucs(lexer, err);
			}
		} while (iswalnum(lexer->ucs) ||
		         lexer->ucs == '\''   ||
		         lexer->ucs == '_');
	} else if (iswdigit(lexer->ucs) || lexer->ucs == '-') {
		if (lexer->ucs == '-') {
			gu_ucs_write(lexer->ucs, wtr, err);
			if (gu_exn_is_raised(err))
				goto stop;
				
			pgf_lexer_read_ucs(lexer, err);
			if (!iswdigit(lexer->ucs))
				goto stop;
		}

		do {
			gu_ucs_write(lexer->ucs, wtr, err);
			if (gu_exn_is_raised(err))
				goto stop;

			pgf_lexer_read_ucs(lexer, err);
		} while (iswdigit(lexer->ucs));
		
		if (lexer->ucs == '.') {
			gu_ucs_write(lexer->ucs, wtr, err);
			if (gu_exn_is_raised(err))
				goto stop;

			pgf_lexer_read_ucs(lexer, err);
			while (iswdigit(lexer->ucs)) {
				gu_ucs_write(lexer->ucs, wtr, err);
				if (gu_exn_is_raised(err))
					goto stop;
				pgf_lexer_read_ucs(lexer, err);
			}
		}
	} else {
		gu_ucs_write(lexer->ucs, wtr, err);
		if (gu_exn_is_raised(err))
			goto stop;
		pgf_lexer_read_ucs(lexer, err);
	}

stop:
	lexer->tok = gu_string_buf_freeze(buf, lexer->pool);

	gu_pool_free(tmp_pool);
	return lexer->tok;
}

PgfToken
pgf_lexer_current_token(PgfLexer *lexer)
{
	return lexer->tok;
}
