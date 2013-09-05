#include <pgf/pgf.h>
#include <pgf/data.h>
#include <pgf/expr.h>
#include <pgf/reader.h>
#include <pgf/linearizer.h>
#include <pgf/parser.h>
#include <pgf/lexer.h>
#include <gu/file.h>
#include <gu/string.h>
#include <gu/enum.h>
#include <stdio.h>
#include <math.h>

GU_DEFINE_TYPE(PgfExn, abstract, _);

PgfPGF*
pgf_read(const char* fpath,
         GuPool* pool, GuExn* err)
{
	FILE* infile = fopen(fpath, "r");
	if (infile == NULL) {
		gu_raise_errno(err);
		return NULL;
	}

	GuPool* tmp_pool = gu_new_pool();

	// Create an input stream from the input file
	GuIn* in = gu_file_in(infile, tmp_pool);

	PgfReader* rdr = pgf_new_reader(in, pool, tmp_pool, err);
	PgfPGF* pgf = pgf_read_pgf(rdr);
	pgf_reader_done(rdr, pgf);

	gu_pool_free(tmp_pool);
	return pgf;
}

void
pgf_load_meta_child_probs(PgfPGF* pgf, const char* fpath,
                          GuPool* pool, GuExn* err)
{
	FILE *fp = fopen(fpath, "r");
	if (!fp) {
		gu_raise_errno(err);
		return;
	}

	GuPool* tmp_pool = gu_new_pool();
	
	for (;;) {
		char cat1_s[21];
		char cat2_s[21];
		prob_t prob;

		if (fscanf(fp, "%20s\t%20s\t%f", cat1_s, cat2_s, &prob) < 3)
			break;

		prob = - log(prob);

		GuString cat1 = gu_str_string(cat1_s, tmp_pool);
		PgfAbsCat* abscat1 =
			gu_map_get(pgf->abstract.cats, &cat1, PgfAbsCat*);
		if (abscat1 == NULL) {
			gu_raise(err, PgfExn);
			goto close;
		}

		if (strcmp(cat2_s, "*") == 0) {
			abscat1->meta_prob = prob;
		} else if (strcmp(cat2_s, "_") == 0) {
			abscat1->meta_token_prob = prob;
		} else {
			GuString cat2 = gu_str_string(cat2_s, tmp_pool);
			PgfAbsCat* abscat2 = gu_map_get(pgf->abstract.cats, &cat2, PgfAbsCat*);
			if (abscat2 == NULL) {
				gu_raise(err, PgfExn);
				goto close;
			}

			if (abscat1->meta_child_probs == NULL) {
				abscat1->meta_child_probs = 
					gu_map_type_new(PgfMetaChildMap, pool);
			}

			gu_map_put(abscat1->meta_child_probs, abscat2, prob_t, prob);
		}
	}
	
close:
	gu_pool_free(tmp_pool);
	fclose(fp);
}

GuString
pgf_abstract_name(PgfPGF* pgf)
{
	return pgf->abstract.name;
}

void
pgf_iter_languages(PgfPGF* pgf, GuMapItor* fn, GuExn* err)
{
	gu_map_iter(pgf->concretes, fn, err);
}

PgfConcr*
pgf_get_language(PgfPGF* pgf, PgfCId lang)
{
	return gu_map_get(pgf->concretes, &lang, PgfConcr*);
}

GuString
pgf_concrete_name(PgfConcr* concr)
{
	return concr->name;
}

void
pgf_iter_categories(PgfPGF* pgf, GuMapItor* fn, GuExn* err)
{
	gu_map_iter(pgf->abstract.cats, fn, err);
}

PgfCId
pgf_start_cat(PgfPGF* pgf, GuPool* pool)
{
	GuPool* tmp_pool = gu_local_pool();

	GuString s = gu_str_string("startcat", tmp_pool);
	PgfLiteral lit =
		gu_map_get(pgf->abstract.aflags, &s, PgfLiteral);

	if (gu_variant_is_null(lit))
		return gu_str_string("S", pool);

	GuVariantInfo i = gu_variant_open(lit);
	switch (i.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr *lstr = (PgfLiteralStr *) i.data;
		return lstr->val;
	}
	}

	return gu_str_string("S", pool);
}

GuString
pgf_language_code(PgfConcr* concr)
{
	GuPool* tmp_pool = gu_local_pool();

	GuString s = gu_str_string("language", tmp_pool);
	PgfLiteral lit =
		gu_map_get(concr->cflags, &s, PgfLiteral);

	if (gu_variant_is_null(lit))
		return gu_empty_string;

	GuVariantInfo i = gu_variant_open(lit);
	switch (i.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr *lstr = (PgfLiteralStr *) i.data;
		return lstr->val;
	}
	}

	return gu_empty_string;
}

void
pgf_iter_functions(PgfPGF* pgf, GuMapItor* fn, GuExn* err)
{
	gu_map_iter(pgf->abstract.funs, fn, err);
}

typedef struct {
	GuMapItor fn;
	PgfCId catname;
	GuMapItor* client_fn;
} PgfFunByCatIter;

static void
pgf_filter_by_cat(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	(void) (key && err);

	PgfFunByCatIter* clo = (PgfFunByCatIter*) fn;
	PgfAbsFun* absfun = *((PgfAbsFun**) value);
	
	if (gu_string_eq(absfun->type->cid, clo->catname)) {
		clo->client_fn->fn(clo->client_fn, &absfun->name, NULL, err);
	}
}

void
pgf_iter_functions_by_cat(PgfPGF* pgf, PgfCId catname, 
                          GuMapItor* fn, GuExn* err) 
{
	PgfFunByCatIter clo = { { pgf_filter_by_cat }, catname, fn };
	gu_map_iter(pgf->abstract.funs, &clo.fn, err);
}

PgfType*
pgf_function_type(PgfPGF* pgf, PgfCId funname) 
{
	PgfAbsFun* absfun =
		gu_map_get(pgf->abstract.funs, &funname, PgfAbsFun*);
	if (absfun == NULL)
		return NULL;
		
	return absfun->type;
}

GuString
pgf_print_name(PgfConcr* concr, PgfCId id)
{
	PgfCId name =
		gu_map_get(concr->printnames, &id, PgfCId);
	if (gu_string_eq(name, gu_empty_string))
		name = id;
	return name;
}

void
pgf_linearize(PgfConcr* concr, PgfExpr expr, GuOut* out, GuExn* err)
{
	GuPool* tmp_pool = gu_local_pool();
	
	GuEnum* cts = 
		pgf_lzr_concretize(concr, expr, tmp_pool);
	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (!gu_variant_is_null(ctree)) {
		pgf_lzr_linearize_simple(concr, ctree, 0, out, err);
	}

	gu_pool_free(tmp_pool);
}

GuEnum*
pgf_parse(PgfConcr* concr, PgfCId cat, PgfLexer *lexer, 
          GuPool* pool, GuPool* out_pool)
{
    return pgf_parse_with_heuristics(concr, cat, lexer, -1.0, pool, out_pool);
}

GuEnum*
pgf_parse_with_heuristics(PgfConcr* concr, PgfCId cat, PgfLexer *lexer,
                          double heuristics,
                          GuPool* pool, GuPool* out_pool)
{
	// Begin parsing a sentence of the specified category
	PgfParseState* state =
		pgf_parser_init_state(concr, cat, 0, heuristics, pool, out_pool);
	if (state == NULL) {
		return NULL;
	}

	// Tokenization
	GuExn* lex_err = gu_new_exn(NULL, gu_kind(type), pool);
	PgfToken tok = pgf_lexer_read_token(lexer, lex_err);
	while (!gu_exn_is_raised(lex_err)) {
		// feed the token to get a new parse state
		state = pgf_parser_next_state(state, tok);
		if (state == NULL) {
			return NULL;
		}

		tok = pgf_lexer_read_token(lexer, lex_err);
	}

	if (gu_exn_caught(lex_err) != gu_type(GuEOF))
		return NULL;

	// Now begin enumerating the resulting syntax trees
	return pgf_parse_result(state);
}

GuEnum*
pgf_complete(PgfConcr* concr, PgfCId cat, PgfLexer *lexer, 
             GuString prefix, GuPool* pool)
{
	// Begin parsing a sentence of the specified category
	PgfParseState* state =
		pgf_parser_init_state(concr, cat, 0, -1, pool, pool);
	if (state == NULL) {
		return NULL;
	}

	// Tokenization
	GuExn* lex_err = gu_new_exn(NULL, gu_kind(type), pool);
	PgfToken tok = pgf_lexer_read_token(lexer, lex_err);
	while (!gu_exn_is_raised(lex_err)) {
		// feed the token to get a new parse state
		state = pgf_parser_next_state(state, tok);
		if (state == NULL) {
			return NULL;
		}

		tok = pgf_lexer_read_token(lexer, lex_err);
	}

	if (gu_exn_caught(lex_err) != gu_type(GuEOF))
		return NULL;

	// Now begin enumerating the resulting syntax trees
	return pgf_parser_completions(state, prefix);
}
