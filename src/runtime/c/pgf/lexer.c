#include <gu/list.h>
#include <pgf/lexer.h>
#include <pgf/data.h>
#include <wctype.h>

struct PgfLexer {
	GuReader* rdr;
	GuUCS ucs;
};

PgfLexer*
pgf_new_lexer(GuReader *rdr, GuPool *pool)
{
	PgfLexer* lexer = gu_new(PgfLexer, pool);
	lexer->rdr = rdr;
	lexer->ucs = ' ';
	return lexer;
}

PgfToken
pgf_lexer_next_token(PgfLexer *lexer, GuExn* err, GuPool *pool)
{
	GuPool* tmp_pool = gu_new_pool();

	PgfToken tok;

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
		do {
			gu_ucs_write(lexer->ucs, wtr, err);
			if (gu_exn_is_raised(err))
				goto stop;
			lexer->ucs = gu_read_ucs(lexer->rdr, err);
			if (gu_exn_is_raised(err))
				goto stop;
		} while (iswalnum(lexer->ucs) ||
		         lexer->ucs == '\''   ||
		         lexer->ucs == '_');
	} else if (iswdigit(lexer->ucs) || lexer->ucs == '-') {
		if (lexer->ucs == '-') {
			gu_ucs_write(lexer->ucs, wtr, err);
			if (gu_exn_is_raised(err))
				goto stop;
			lexer->ucs = gu_read_ucs(lexer->rdr, err);
			if (gu_exn_is_raised(err))
				goto stop;

			if (!iswdigit(lexer->ucs))
				goto stop;
		}

		do {
			gu_ucs_write(lexer->ucs, wtr, err);
			if (gu_exn_is_raised(err))
				goto stop;
			lexer->ucs = gu_read_ucs(lexer->rdr, err);
			if (gu_exn_is_raised(err))
				goto stop;
		} while (iswdigit(lexer->ucs));
		
		if (lexer->ucs == '.') {
			gu_ucs_write(lexer->ucs, wtr, err);
			if (gu_exn_is_raised(err))
				goto stop;

			lexer->ucs = gu_read_ucs(lexer->rdr, err);
			if (gu_exn_is_raised(err))
				goto stop;

			while (iswdigit(lexer->ucs)) {
				gu_ucs_write(lexer->ucs, wtr, err);
				if (gu_exn_is_raised(err))
					goto stop;
				lexer->ucs = gu_read_ucs(lexer->rdr, err);
				if (gu_exn_is_raised(err))
					goto stop;
			}
		}
	} else {
		gu_ucs_write(lexer->ucs, wtr, err);
		if (gu_exn_is_raised(err))
			goto stop;
		lexer->ucs = gu_read_ucs(lexer->rdr, err);
		if (gu_exn_is_raised(err))
			goto stop;
	}

stop:
	tok = gu_string_buf_freeze(buf, pool);

	gu_pool_free(tmp_pool);
	return tok;
}
