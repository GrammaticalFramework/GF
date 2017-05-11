#include <pgf/pgf.h>
#include <pgf/data.h>
#include <pgf/expr.h>
#include <pgf/reader.h>
#include <pgf/linearizer.h>
#include <gu/file.h>
#include <gu/string.h>
#include <gu/enum.h>
#include <stdio.h>
#include <math.h>

PGF_API PgfPGF*
pgf_read(const char* fpath,
         GuPool* pool, GuExn* err)
{
	FILE* infile = fopen(fpath, "rb");
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
	
	fclose(infile);
	return pgf;
}

PGF_API PgfPGF*
pgf_read_in(GuIn* in,
            GuPool* pool, GuPool* tmp_pool, GuExn* err)
{
	PgfReader* rdr = pgf_new_reader(in, pool, tmp_pool, err);
	PgfPGF* pgf = pgf_read_pgf(rdr);
	pgf_reader_done(rdr, pgf);
	return pgf;
}

PGF_API GuString
pgf_abstract_name(PgfPGF* pgf)
{
	return pgf->abstract.name;
}

PGF_API void
pgf_iter_languages(PgfPGF* pgf, GuMapItor* itor, GuExn* err)
{
	size_t n_concrs = gu_seq_length(pgf->concretes);
	for (size_t i = 0; i < n_concrs; i++) {
		PgfConcr* concr = gu_seq_index(pgf->concretes, PgfConcr, i);
		itor->fn(itor, concr->name, &concr, err);
		if (!gu_ok(err))
			break;
	}
}

PGF_API PgfConcr*
pgf_get_language(PgfPGF* pgf, PgfCId lang)
{
	return gu_seq_binsearch(pgf->concretes, pgf_concr_order, PgfConcr, lang);
}

PGF_API GuString
pgf_concrete_name(PgfConcr* concr)
{
	return concr->name;
}

PGF_API void
pgf_iter_categories(PgfPGF* pgf, GuMapItor* itor, GuExn* err)
{
	size_t n_cats = gu_seq_length(pgf->abstract.cats);
	for (size_t i = 0; i < n_cats; i++) {
		PgfAbsCat* cat = gu_seq_index(pgf->abstract.cats, PgfAbsCat, i);
		itor->fn(itor, cat->name, &cat, err);
		if (!gu_ok(err))
			break;
	}
}

PGF_API PgfType*
pgf_start_cat(PgfPGF* pgf, GuPool* pool)
{
	PgfFlag* flag =
		gu_seq_binsearch(pgf->abstract.aflags, pgf_flag_order, PgfFlag, "startcat");

	if (flag != NULL) {
		GuVariantInfo i = gu_variant_open(flag->value);
		switch (i.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr *lstr = (PgfLiteralStr *) i.data;
			
			GuPool* tmp_pool = gu_local_pool();
			GuIn* in = gu_string_in(lstr->val,tmp_pool);
			GuExn* err = gu_new_exn(tmp_pool);
			PgfType *type = pgf_read_type(in, pool, err);
			if (!gu_ok(err))
				break;
			gu_pool_free(tmp_pool);
			return type;
		}
		}
	}

	PgfType* type = gu_new_flex(pool, PgfType, exprs, 0);
	type->hypos   = gu_empty_seq();
	type->cid     = "S";
	type->n_exprs = 0;
	return type;
}

PGF_API GuString
pgf_language_code(PgfConcr* concr)
{
	PgfFlag* flag =
		gu_seq_binsearch(concr->cflags, pgf_flag_order, PgfFlag, "language");

	if (flag == NULL)
		return "";

	GuVariantInfo i = gu_variant_open(flag->value);
	switch (i.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr *lstr = (PgfLiteralStr *) i.data;
		return lstr->val;
	}
	}

	return "";
}

PGF_API void
pgf_iter_functions(PgfPGF* pgf, GuMapItor* itor, GuExn* err)
{
	size_t n_funs = gu_seq_length(pgf->abstract.funs);
	for (size_t i = 0; i < n_funs; i++) {
		PgfAbsFun* fun = gu_seq_index(pgf->abstract.funs, PgfAbsFun, i);
		itor->fn(itor, fun->name, &fun, err);
		if (!gu_ok(err))
			break;
	}
}

PGF_API void
pgf_iter_functions_by_cat(PgfPGF* pgf, PgfCId catname, 
                          GuMapItor* itor, GuExn* err) 
{
	size_t n_funs = gu_seq_length(pgf->abstract.funs);
	for (size_t i = 0; i < n_funs; i++) {
		PgfAbsFun* fun = gu_seq_index(pgf->abstract.funs, PgfAbsFun, i);
		
		if (strcmp(fun->type->cid, catname) == 0) {
			itor->fn(itor, fun->name, &fun, err);
			if (!gu_ok(err))
				break;
		}
	}
}

PGF_API PgfType*
pgf_function_type(PgfPGF* pgf, PgfCId funname) 
{
	PgfAbsFun* absfun =
		gu_seq_binsearch(pgf->abstract.funs, pgf_absfun_order, PgfAbsFun, funname);
	if (absfun == NULL)
		return NULL;

	return absfun->type;
}

PGF_API double
pgf_function_prob(PgfPGF* pgf, PgfCId funname) 
{
	PgfAbsFun* absfun =
		gu_seq_binsearch(pgf->abstract.funs, pgf_absfun_order, PgfAbsFun, funname);
	if (absfun == NULL)
		return INFINITY;

	return absfun->ep.prob;
}

PGF_API GuString
pgf_print_name(PgfConcr* concr, PgfCId id)
{
	PgfCId name =
		gu_map_get(concr->printnames, id, GuString);
	return name;
}

PGF_API bool
pgf_has_linearization(PgfConcr* concr, PgfCId id)
{
	PgfCncOverloadMap* overl_table =
		gu_map_get(concr->fun_indices, id, PgfCncOverloadMap*);
	return (overl_table != NULL);
}

PGF_API PgfExprProb*
pgf_fun_get_ep(void* value)
{
	PgfAbsFun* absfun = *((PgfAbsFun**) value);
	return &absfun->ep;
}
