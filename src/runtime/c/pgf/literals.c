#include <gu/in.h>
#include <gu/utf8.h>
#include <pgf/literals.h>
#include <wctype.h>


static PgfExprProb*
pgf_match_string_lit(PgfLiteralCallback* self,
                     size_t lin_idx,
                     GuString sentence, size_t* poffset,
                     GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	size_t offset = *poffset;
	while (sentence[offset] && !gu_is_space(sentence[offset]))
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

		*poffset = offset;
		return ep;
	} else {
		return NULL;
	}
}

static void
pgf_predict_empty_next(GuEnum* self, void* to, GuPool* pool)
{
	*((PgfTokenProb**) to) = NULL;
}

static GuEnum*
pgf_predict_empty(PgfLiteralCallback* self,
	              size_t lin_idx,
	              GuString prefix,
	              GuPool *out_pool)
{
	GuEnum* en = gu_new(GuEnum, out_pool);
	en->next = pgf_predict_empty_next;
	return en;
}

static PgfLiteralCallback pgf_string_literal_callback =
  { pgf_match_string_lit, pgf_predict_empty } ;



static PgfExprProb*
pgf_match_int_lit(PgfLiteralCallback* self,
                  size_t lin_idx,
                  GuString sentence, size_t* poffset,
                  GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	size_t offset = *poffset;
	while (sentence[offset] && !gu_is_space(sentence[offset]))
		offset++;

	size_t len = offset - *poffset;
	if (len > 0) {
		GuPool* tmp_pool = gu_local_pool();
		PgfToken tok = gu_malloc(tmp_pool, len+1);
		memcpy((char*) tok, sentence+*poffset, len);
		((char*) tok)[len] = 0;

		int val;
		if (!gu_string_to_int(tok, &val)) {
			gu_pool_free(tmp_pool);
			return NULL;
		}
		
		gu_pool_free(tmp_pool);

		PgfExprProb* ep = gu_new(PgfExprProb, out_pool);
		ep->prob = 0;

		PgfExprLit *expr_lit =
			gu_new_variant(PGF_EXPR_LIT,
						   PgfExprLit,
						   &ep->expr, out_pool);
		PgfLiteralInt *lit_int =
			gu_new_variant(PGF_LITERAL_INT,
						   PgfLiteralInt,
						   &expr_lit->lit, out_pool);
		lit_int->val = val;

		*poffset = offset;
		return ep;
	} else {
		return NULL;
	}
}

static PgfLiteralCallback pgf_int_literal_callback =
  { pgf_match_int_lit, pgf_predict_empty } ;



static PgfExprProb*
pgf_match_float_lit(PgfLiteralCallback* self,
                    size_t lin_idx,
                    GuString sentence, size_t* poffset,
                    GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	size_t offset = *poffset;
	while (sentence[offset] && !gu_is_space(sentence[offset]))
		offset++;

	size_t len = offset - *poffset;
	if (len > 0) {
		GuPool* tmp_pool = gu_local_pool();
		PgfToken tok = gu_malloc(tmp_pool, len+1);
		memcpy((char*) tok, sentence+*poffset, len);
		((char*) tok)[len] = 0;

		double val;
		if (!gu_string_to_double(tok, &val)) {
			gu_pool_free(tmp_pool);
			return NULL;
		}
		
		gu_pool_free(tmp_pool);

		PgfExprProb* ep = gu_new(PgfExprProb, out_pool);
		ep->prob = 0;

		PgfExprLit *expr_lit =
			gu_new_variant(PGF_EXPR_LIT,
						   PgfExprLit,
						   &ep->expr, out_pool);
		PgfLiteralFlt *lit_flt =
			gu_new_variant(PGF_LITERAL_FLT,
						   PgfLiteralFlt,
						   &expr_lit->lit, out_pool);
		lit_flt->val = val;

		*poffset = offset;
		return ep;
	} else {
		return NULL;
	}
}

static PgfLiteralCallback pgf_float_literal_callback =
  { pgf_match_float_lit, pgf_predict_empty } ;



static PgfExprProb*
pgf_match_name_lit(PgfLiteralCallback* self,
                   size_t lin_idx,
                   GuString sentence, size_t* poffset,
                   GuPool *out_pool)
{
	if (lin_idx != 0)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuStringBuf *sbuf = gu_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);
	GuExn* err = gu_new_exn(tmp_pool);

	size_t offset = *poffset;

	int i = 0;
	while (iswupper(sentence[offset])) {
		size_t len = 0;
		while (!gu_is_space(sentence[offset+len])) {
			len++;
		}

		PgfToken tok = gu_malloc(tmp_pool, len+1);
		memcpy((char*) tok, sentence+offset, len);
		((char*) tok)[len] = 0;

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
		ep = gu_new(PgfExprProb, out_pool);
		ep->prob = 0;

		PgfExprApp *expr_app1 =
			gu_new_variant(PGF_EXPR_APP,
			               PgfExprApp,
			               &ep->expr, out_pool);
		GuString con1 = "SymbPN";
		PgfExprFun *expr_fun1 =
			gu_new_flex_variant(PGF_EXPR_FUN,
			                    PgfExprFun,
			                    fun, strlen(con1)+1,
			                    &expr_app1->fun, out_pool);
		strcpy(expr_fun1->fun, con1);
		PgfExprApp *expr_app2 =
			gu_new_variant(PGF_EXPR_APP,
			               PgfExprApp,
			               &expr_app1->arg, out_pool);
		GuString con2 = "MkSymb";
		PgfExprFun *expr_fun2 =
			gu_new_flex_variant(PGF_EXPR_FUN,
			                    PgfExprFun,
			                    fun, strlen(con2)+1,
			                    &expr_app2->fun, out_pool);
		strcpy(expr_fun2->fun, con2);
		PgfExprLit *expr_lit =
			gu_new_variant(PGF_EXPR_LIT,
			               PgfExprLit,
			               &expr_app2->arg, out_pool);
		GuString val = gu_string_buf_freeze(sbuf, tmp_pool);
		PgfLiteralStr *lit_str =
			gu_new_flex_variant(PGF_LITERAL_STR,
			                    PgfLiteralStr,
			                    val, strlen(val)+1,
			                    &expr_lit->lit, out_pool);
        strcpy(lit_str->val, val);
	}

	gu_pool_free(tmp_pool);

	return ep;
}

PgfLiteralCallback pgf_nerc_literal_callback =
  { pgf_match_name_lit, pgf_predict_empty } ;


PgfCallbacksMap*
pgf_new_callbacks_map(PgfConcr* concr, GuPool *pool)
{
	int fid;
	PgfCCat* ccat;
	
	PgfCallbacksMap* callbacks = 
		gu_new_addr_map(PgfCncCat*, PgfLiteralCallback*, &gu_null_struct, pool);

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

void
pgf_callbacks_map_add_literal(PgfConcr* concr, PgfCallbacksMap* callbacks,
                              PgfCId cat, PgfLiteralCallback* callback)
{
	PgfCncCat* cnccat =
		gu_map_get(concr->cnccats, cat, PgfCncCat*);
	if (cnccat == NULL)
		return;

	gu_map_put(callbacks, cnccat,
	           PgfLiteralCallback*, callback);
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
