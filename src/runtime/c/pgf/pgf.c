#include <pgf/pgf.h>
#include <pgf/data.h>
#include <pgf/expr.h>
#include <pgf/reader.h>
#include <gu/file.h>
#include <gu/string.h>
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
	PgfPGF* pgf = pgf_read_new(rdr, gu_type(PgfPGF), pool, NULL);
	gu_pool_free(tmp_pool);
	gu_return_on_exn(err, NULL);
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
		PgfCat* abscat1 =
			gu_map_get(pgf->abstract.cats, &cat1, PgfCat*);
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
			PgfCat* abscat2 = gu_map_get(pgf->abstract.cats, &cat2, PgfCat*);
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
	return pgf->absname;
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

void
pgf_iter_functions(PgfPGF* pgf, GuMapItor* fn, GuExn* err)
{
	gu_map_iter(pgf->abstract.funs, fn, err);
}

void
pgf_iter_functions_by_cat(PgfPGF* pgf, PgfCId catname, 
                          GuMapItor* fn, GuExn* err) 
{
	PgfCat* abscat =
		gu_map_get(pgf->abstract.cats, &catname, PgfCat*);
	if (abscat == NULL) {
		gu_raise(err, PgfExn);
		return;
	}
	
	for (size_t i = 0; i < abscat->n_functions; i++) {
		fn->fn(fn, &abscat->functions[i].fun, NULL, err);
		if (!gu_ok(err))
			return;
	}
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
