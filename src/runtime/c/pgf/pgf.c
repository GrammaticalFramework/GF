#include <pgf/pgf.h>
#include <pgf/data.h>
#include <pgf/expr.h>
#include <pgf/reader.h>
#include <pgf/linearizer.h>
#include <pgf/parser.h>
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
		char cat1[21];
		char cat2[21];
		prob_t prob;

		if (fscanf(fp, "%20s\t%20s\t%f", cat1, cat2, &prob) < 3)
			break;

		prob = - log(prob);

		PgfAbsCat* abscat1 =
			gu_map_get(pgf->abstract.cats, cat1, PgfAbsCat*);
		if (abscat1 == NULL) {
			GuExnData* exn = gu_raise(err, PgfExn);
			exn->data = "Unknown category name";
			goto close;
		}

		if (strcmp(cat2, "*") == 0) {
			abscat1->meta_prob = prob;
		} else if (strcmp(cat2, "_") == 0) {
			abscat1->meta_token_prob = prob;
		} else {
			PgfAbsCat* abscat2 = gu_map_get(pgf->abstract.cats, cat2, PgfAbsCat*);
			if (abscat2 == NULL) {
				gu_raise(err, PgfExn);
				GuExnData* exn = gu_raise(err, PgfExn);
				exn->data = "Unknown category name";
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
	return gu_map_get(pgf->concretes, lang, PgfConcr*);
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
pgf_start_cat(PgfPGF* pgf)
{
	PgfLiteral lit =
		gu_map_get(pgf->abstract.aflags, "startcat", PgfLiteral);

	if (gu_variant_is_null(lit))
		return "S";

	GuVariantInfo i = gu_variant_open(lit);
	switch (i.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr *lstr = (PgfLiteralStr *) i.data;
		return lstr->val;
	}
	}

	return "S";
}

GuString
pgf_language_code(PgfConcr* concr)
{
	PgfLiteral lit =
		gu_map_get(concr->cflags, "language", PgfLiteral);

	if (gu_variant_is_null(lit))
		return "";

	GuVariantInfo i = gu_variant_open(lit);
	switch (i.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr *lstr = (PgfLiteralStr *) i.data;
		return lstr->val;
	}
	}

	return "";
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
	
	if (strcmp(absfun->type->cid, clo->catname) == 0) {
		clo->client_fn->fn(clo->client_fn, absfun->name, NULL, err);
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
		gu_map_get(pgf->abstract.funs, funname, PgfAbsFun*);
	if (absfun == NULL)
		return NULL;

	return absfun->type;
}

GuString
pgf_print_name(PgfConcr* concr, PgfCId id)
{
	PgfCId name =
		gu_map_get(concr->printnames, id, PgfCId);
	if (*name == 0)
		name = id;
	return name;
}
