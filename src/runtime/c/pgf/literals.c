#include <gu/read.h>
#include <pgf/literals.h>
#include <wctype.h>

GU_DEFINE_TYPE(PgfLiteralCallback, struct);

GU_DEFINE_TYPE(PgfCallbacksMap, GuMap,
		       gu_type(PgfCncCat), NULL,
		       gu_ptr_type(PgfLiteralCallback), &gu_null_struct);


static bool
pgf_match_string_lit(PgfLiteralCallback* self, int lin_idx, PgfTokens toks, 
                     PgfExprProb** out_ep, GuPool *pool)
{
	gu_assert(lin_idx == 0);

	if (gu_seq_length(toks) == 1) {
		*out_ep = NULL;
		return true;
	} else if (gu_seq_length(toks) == 2) {
		PgfExprProb* ep = gu_new(PgfExprProb, pool);
		ep->prob = 0;

		PgfExprLit *expr_lit =
			gu_new_variant(PGF_EXPR_LIT,
						   PgfExprLit,
						   &ep->expr, pool);
		PgfLiteralStr *lit_str =
			gu_new_variant(PGF_LITERAL_STR,
						   PgfLiteralStr,
						   &expr_lit->lit, pool);
		lit_str->val = gu_seq_get(toks, PgfToken, 0);

		*out_ep = ep;
		return false;
	} else {
		*out_ep = NULL;
		return false;
	}
}

static PgfLiteralCallback pgf_string_literal_callback =
  { pgf_match_string_lit } ;



static bool
pgf_match_int_lit(PgfLiteralCallback* self, int lin_idx, PgfTokens toks, 
                  PgfExprProb** out_ep, GuPool *pool)
{
	gu_assert(lin_idx == 0);

	size_t n_toks = gu_seq_length(toks);
	if (n_toks == 1) {
		PgfToken tok = gu_seq_get(toks, PgfToken, 0);

		int val;

		*out_ep = NULL;
		return gu_string_to_int(tok, &val);
	} else if (n_toks == 2) {
		PgfToken tok = gu_seq_get(toks, PgfToken, 0);

		int val;
		if (!gu_string_to_int(tok, &val)) {
			*out_ep = NULL;
			return false;
		}

		PgfExprProb* ep = gu_new(PgfExprProb, pool);
		ep->prob = 0;

		PgfExprLit *expr_lit =
			gu_new_variant(PGF_EXPR_LIT,
						   PgfExprLit,
						   &ep->expr, pool);
		PgfLiteralInt *lit_int =
			gu_new_variant(PGF_LITERAL_INT,
						   PgfLiteralInt,
						   &expr_lit->lit, pool);
		lit_int->val = val;

		*out_ep = ep;
		return false;
	} else {
		*out_ep = NULL;
		return false;
	}
}

static PgfLiteralCallback pgf_int_literal_callback =
  { pgf_match_int_lit } ;



static bool
pgf_match_float_lit(PgfLiteralCallback* self, int lin_idx, PgfTokens toks, 
                    PgfExprProb** out_ep, GuPool *pool)
{
	gu_assert(lin_idx == 0);

	size_t n_toks = gu_seq_length(toks);
	if (n_toks == 1) {
		PgfToken tok = gu_seq_get(toks, PgfToken, 0);

		double val;

		*out_ep = NULL;
		return gu_string_to_double(tok, &val);
	} else if (n_toks == 2) {
		PgfToken tok = gu_seq_get(toks, PgfToken, 0);

		double val;
		if (!gu_string_to_double(tok, &val)) {
			*out_ep = NULL;
			return false;
		}

		PgfExprProb* ep = gu_new(PgfExprProb, pool);
		ep->prob = 0;

		PgfExprLit *expr_lit =
			gu_new_variant(PGF_EXPR_LIT,
						   PgfExprLit,
						   &ep->expr, pool);
		PgfLiteralFlt *lit_flt =
			gu_new_variant(PGF_LITERAL_FLT,
						   PgfLiteralFlt,
						   &expr_lit->lit, pool);
		lit_flt->val = val;

		*out_ep = ep;
		return false;
	} else {
		*out_ep = NULL;
		return false;
	}
}

static PgfLiteralCallback pgf_float_literal_callback =
  { pgf_match_float_lit } ;



static bool
pgf_match_name_lit(PgfLiteralCallback* self, int lin_idx, PgfTokens toks, 
                   PgfExprProb** out_ep, GuPool *pool)
{
	gu_assert(lin_idx == 0);
	
	size_t n_toks = gu_seq_length(toks);

	if (n_toks == 0) {
		*out_ep = NULL;
		return false;
	}

	PgfToken tok = gu_seq_get(toks, PgfToken, n_toks-1);
	
	GuPool* tmp_pool = gu_new_pool();
	GuReader* rdr = gu_string_reader(tok, tmp_pool);
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);
	
	bool iscap = iswupper(gu_read_ucs(rdr, err));	
	if (!iscap && n_toks > 1) {
		GuStringBuf *sbuf = gu_string_buf(tmp_pool);
		GuWriter* wtr = gu_string_buf_writer(sbuf);

		for (size_t i = 0; i < n_toks-1; i++) {
			if (i > 0)
			  gu_putc(' ', wtr, err);

			tok = gu_seq_get(toks, PgfToken, i);
			gu_string_write(tok, wtr, err);
		}
		
		PgfExprProb* ep = gu_new(PgfExprProb, pool);
		ep->prob = 0;

		PgfExprApp *expr_app =
			gu_new_variant(PGF_EXPR_APP,
			               PgfExprApp,
			               &ep->expr, pool);
		PgfExprFun *expr_fun =
			gu_new_variant(PGF_EXPR_FUN,
			               PgfExprFun,
			               &expr_app->fun, pool);
		expr_fun->fun = gu_str_string("MkSymb", pool);
		PgfExprLit *expr_lit =
			gu_new_variant(PGF_EXPR_LIT,
			               PgfExprLit,
			               &expr_app->arg, pool);
		PgfLiteralStr *lit_str =
			gu_new_variant(PGF_LITERAL_STR,
			               PgfLiteralStr,
			               &expr_lit->lit, pool);
		lit_str->val = gu_string_buf_freeze(sbuf, pool);
		
		*out_ep = ep;
	}

	gu_pool_free(tmp_pool);
	
	return iscap;
}

PgfLiteralCallback pgf_nerc_literal_callback =
  { pgf_match_name_lit } ;


PgfCallbacksMap*
pgf_new_callbacks_map(PgfConcr* concr, GuPool *pool)
{
	int fid;
	PgfCCat* ccat;
	
	PgfCallbacksMap* callbacks = 
		gu_map_type_new(PgfCallbacksMap, pool); 
	
	fid  = -1;
	ccat = gu_map_get(concr->ccats, &fid, PgfCCat*);
	if (ccat != NULL)
		gu_map_put(callbacks, ccat->cnccat, 
		           PgfLiteralCallback*, &pgf_string_literal_callback);

	fid  = -2;
	ccat = gu_map_get(concr->ccats, &fid, PgfCCat*);
	if (ccat != NULL)
		gu_map_put(callbacks, ccat->cnccat, 
		           PgfLiteralCallback*, &pgf_int_literal_callback);

	fid  = -3;
	ccat = gu_map_get(concr->ccats, &fid, PgfCCat*);
	if (ccat != NULL)
		gu_map_put(callbacks, ccat->cnccat, 
		           PgfLiteralCallback*, &pgf_float_literal_callback);

	return callbacks;
}

PgfCCat*
pgf_literal_cat(PgfConcr* concr, PgfLiteral lit)
{
	int fid;

	switch (gu_variant_tag(lit)) {
	case PGF_LITERAL_STR:
		fid = -1;
		break;
	case PGF_LITERAL_INT:
		fid = -2;
		break;
	case PGF_LITERAL_FLT:
		fid = -3;
		break;
	default:
		gu_impossible();
		return NULL;
	}

	return gu_map_get(concr->ccats, &fid, PgfCCat*);
}
