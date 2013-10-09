#include <gu/in.h>
#include <gu/utf8.h>
#include <pgf/parser.h>
#include <pgf/literals.h>
#include <wctype.h>

GU_DEFINE_TYPE(PgfLiteralCallback, struct);

GU_DEFINE_TYPE(PgfCallbacksMap, GuMap,
		       gu_type(PgfCncCat), NULL,
		       gu_ptr_type(PgfLiteralCallback), &gu_null_struct);


static PgfExprProb*
pgf_match_string_lit(PgfConcr* concr, PgfSymbol* psym, size_t lin_idx,
                     GuString sentence, size_t* poffset,
                     GuPool *pool, GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	size_t offset = *poffset;
	while (!gu_is_space(sentence[offset]))
		offset++;

	size_t len = offset - *poffset;
	if (len > 0) {
		PgfExprProb* ep = gu_new(PgfExprProb, out_pool);
		ep->prob = 0;

		PgfExprLit *expr_lit =
			gu_new_variant(PGF_EXPR_LIT,
						   PgfExprLit,
						   &ep->expr, out_pool);

		PgfLiteralStr *lit_str =
			gu_new_flex_variant(PGF_LITERAL_STR,
						        PgfLiteralStr,
						        val, len+1,
						        &expr_lit->lit, out_pool);
		memcpy(lit_str->val, sentence+*poffset, len);
		lit_str->val[len] = 0;

		pgf_add_extern_tok(psym, lit_str->val, pool);
		*poffset = offset;
		return ep;
	} else {
		return NULL;
	}
}

static PgfLiteralCallback pgf_string_literal_callback =
  { pgf_match_string_lit } ;



static PgfExprProb*
pgf_match_int_lit(PgfConcr* concr, PgfSymbol* psym, size_t lin_idx,
                  GuString sentence, size_t* poffset,
                  GuPool *pool, GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	size_t offset = *poffset;
	while (!gu_is_space(sentence[offset]))
		offset++;

	size_t len = offset - *poffset;
	if (len > 0) {
		PgfToken tok = gu_malloc(pool, len+1);
		memcpy((char*) tok, sentence+*poffset, len);
		((char*) tok)[len] = 0;

		int val;
		if (!gu_string_to_int(tok, &val))
			return NULL;

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

		pgf_add_extern_tok(psym, tok, pool);
		*poffset = offset;
		return ep;
	} else {
		return NULL;
	}
}

static PgfLiteralCallback pgf_int_literal_callback =
  { pgf_match_int_lit } ;



static PgfExprProb*
pgf_match_float_lit(PgfConcr* concr, PgfSymbol* psym, size_t lin_idx,
                    GuString sentence, size_t* poffset,
                    GuPool *pool, GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	size_t offset = *poffset;
	while (!gu_is_space(sentence[offset]))
		offset++;

	size_t len = offset - *poffset;
	if (len > 0) {
		PgfToken tok = gu_malloc(pool, len+1);
		memcpy((char*) tok, sentence+*poffset, len);
		((char*) tok)[len] = 0;

		double val;
		if (!gu_string_to_double(tok, &val))
			return NULL;

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

		pgf_add_extern_tok(psym, tok, pool);
		*poffset = offset;
		return ep;
	} else {
		return NULL;
	}
}

static PgfLiteralCallback pgf_float_literal_callback =
  { pgf_match_float_lit } ;



static PgfExprProb*
pgf_match_name_lit(PgfConcr* concr, PgfSymbol* psym, size_t lin_idx,
                    GuString sentence, size_t* poffset,
                    GuPool *pool, GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	GuPool* tmp_pool = gu_new_pool();
	GuStringBuf *sbuf = gu_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	size_t offset = *poffset;

	int i = 0;
	while (iswupper(sentence[offset])) {
		size_t len = 0;
		while (!gu_is_space(sentence[offset+len])) {
			len++;
		}

		PgfToken tok = gu_malloc(pool, len+1);
		memcpy((char*) tok, sentence+offset, len);
		((char*) tok)[len] = 0;

		pgf_add_extern_tok(psym, tok, pool);

		if (i > 0)
		  gu_putc(' ', out, err);
		gu_string_write(tok, out, err);
		
		i++;

		offset  += len;
		*poffset = offset;

		while (gu_is_space(sentence[offset]))
			offset++;
	}

	PgfExprProb* ep = NULL;
	if (i > 0) {
		ep = gu_new(PgfExprProb, pool);
		ep->prob = 0;

		PgfExprApp *expr_app =
			gu_new_variant(PGF_EXPR_APP,
			               PgfExprApp,
			               &ep->expr, pool);
		GuString con = "MkSymb";
		PgfExprFun *expr_fun =
			gu_new_flex_variant(PGF_EXPR_FUN,
			                    PgfExprFun,
			                    fun, strlen(con)+1,
			                    &expr_app->fun, pool);
		strcpy(expr_fun->fun, con);
		PgfExprLit *expr_lit =
			gu_new_variant(PGF_EXPR_LIT,
			               PgfExprLit,
			               &expr_app->arg, pool);
		GuString val = gu_string_buf_freeze(sbuf, tmp_pool);
		PgfLiteralStr *lit_str =
			gu_new_flex_variant(PGF_LITERAL_STR,
			                    PgfLiteralStr,
			                    val, strlen(val)+1,
			                    &expr_lit->lit, pool);
        strcpy(lit_str->val, val);
	}

	gu_pool_free(tmp_pool);

	return ep;
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
