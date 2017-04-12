#include <gu/in.h>
#include <gu/utf8.h>
#include <pgf/literals.h>
#include <wctype.h>


static PgfExprProb*
pgf_match_string_lit(PgfLiteralCallback* self, PgfConcr* concr,
                     size_t lin_idx,
                     GuString sentence, size_t* poffset,
                     GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	const uint8_t* buf = (uint8_t*) (sentence + *poffset);
	const uint8_t* p   = buf;
	size_t len = 0;
	while (*p && !gu_ucs_is_space(gu_utf8_decode(&p))) {
		len = p - buf;
	}

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
		memcpy(lit_str->val, buf, len);
		lit_str->val[len] = 0;

		*poffset += len;
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
pgf_predict_empty(PgfLiteralCallback* self, PgfConcr* concr,
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
pgf_match_int_lit(PgfLiteralCallback* self, PgfConcr* concr,
                  size_t lin_idx,
                  GuString sentence, size_t* poffset,
                  GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	const uint8_t* buf = (uint8_t*) (sentence + *poffset);
	const uint8_t* p   = buf;
	size_t len = 0;
	while (*p && !gu_ucs_is_space(gu_utf8_decode(&p))) {
		len = p - buf;
	}

	if (len > 0) {
		GuPool* tmp_pool = gu_local_pool();
		PgfToken tok = gu_malloc(tmp_pool, len+1);
		memcpy((char*) tok, buf, len);
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

		*poffset += len;
		return ep;
	} else {
		return NULL;
	}
}

static PgfLiteralCallback pgf_int_literal_callback =
  { pgf_match_int_lit, pgf_predict_empty } ;



static PgfExprProb*
pgf_match_float_lit(PgfLiteralCallback* self, PgfConcr* concr,
                    size_t lin_idx,
                    GuString sentence, size_t* poffset,
                    GuPool *out_pool)
{
	gu_assert(lin_idx == 0);

	const uint8_t* buf = (uint8_t*) (sentence + *poffset);
	const uint8_t* p   = buf;
	size_t len = 0;
	while (*p && !gu_ucs_is_space(gu_utf8_decode(&p))) {
		len = p - buf;
	}

	if (len > 0) {
		GuPool* tmp_pool = gu_local_pool();
		PgfToken tok = gu_malloc(tmp_pool, len+1);
		memcpy((char*) tok, buf, len);
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

		*poffset += len;
		return ep;
	} else {
		return NULL;
	}
}

static PgfLiteralCallback pgf_float_literal_callback =
  { pgf_match_float_lit, pgf_predict_empty } ;

typedef struct {
	PgfMorphoCallback callback;
	PgfAbstr* abstract;
	PgfExpr expr;
	bool is_known;
	GuPool* out_pool;
} PgfMatchMorphoCallback;

static void
pgf_match_name_morpho_callback(PgfMorphoCallback* self_,
                               PgfCId lemma, GuString analysis, prob_t prob,
                               GuExn* err)
{
	PgfMatchMorphoCallback* self =
		gu_container(self_, PgfMatchMorphoCallback, callback);

	PgfAbsFun* absfun =
		gu_seq_binsearch(self->abstract->funs, pgf_absfun_order, PgfAbsFun, lemma);
	if (absfun != NULL) {
		if (strcmp(absfun->type->cid, "PN") == 0) {
			self->expr = absfun->ep.expr;
		} else if (strcmp(absfun->type->cid, "Weekday") == 0) {
			PgfExprApp *expr_app =
				gu_new_variant(PGF_EXPR_APP,
							   PgfExprApp,
							   &self->expr, self->out_pool);
			GuString con = "weekdayPN";
			PgfExprFun *expr_fun =
				gu_new_flex_variant(PGF_EXPR_FUN,
									PgfExprFun,
									fun, strlen(con)+1,
									&expr_app->fun, self->out_pool);
			strcpy(expr_fun->fun, con);
			expr_app->arg = absfun->ep.expr;
		} else if (strcmp(absfun->type->cid, "Month") == 0) {
			PgfExprApp *expr_app =
				gu_new_variant(PGF_EXPR_APP,
							   PgfExprApp,
							   &self->expr, self->out_pool);
			GuString con = "monthPN";
			PgfExprFun *expr_fun =
				gu_new_flex_variant(PGF_EXPR_FUN,
									PgfExprFun,
									fun, strlen(con)+1,
									&expr_app->fun, self->out_pool);
			strcpy(expr_fun->fun, con);
			expr_app->arg = absfun->ep.expr;
		} else {
			self->is_known = true;
		}
	}
}

static PgfExprProb*
pgf_match_name_lit(PgfLiteralCallback* self, PgfConcr* concr,
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

	const uint8_t* buf = (uint8_t*) (sentence + *poffset);
	const uint8_t* p   = buf;

	int i = 0;
	GuUCS ucs = gu_utf8_decode(&p);
	while (gu_ucs_is_upper(ucs)) {
		if (i > 0)
		  gu_putc(' ', out, err);
		gu_out_utf8(ucs, out, err);
		*poffset = p - ((uint8_t*) sentence);

		ucs = gu_utf8_decode(&p);
		while (ucs != 0 && !gu_ucs_is_space(ucs)) {
			gu_out_utf8(ucs, out, err);
			*poffset = p - ((uint8_t*) sentence);

			ucs = gu_utf8_decode(&p);
		}

		i++;

		while (gu_ucs_is_space(ucs))
			ucs = gu_utf8_decode(&p);
	}

	PgfExprProb* ep = NULL;
	if (i > 0) {
		GuString name = gu_string_buf_freeze(sbuf, tmp_pool);

		// Detect I and I'm in English
		GuString concr_name = pgf_concrete_name(concr);
		size_t concr_name_len = strlen(concr_name);
		if (concr_name_len >= 3 && strcmp(concr_name+concr_name_len-3,"Eng") == 0) {
			if (strcmp(name, "I") == 0 || strcmp(name, "I'm") == 0) {
				gu_pool_free(tmp_pool);
				return NULL;
			}
		}

		PgfMatchMorphoCallback clo = { { pgf_match_name_morpho_callback }, 
			                           concr->abstr,
			                           gu_null_variant,
			                           false,
			                           out_pool
			                         };
		pgf_lookup_morpho(concr, name, &clo.callback, NULL);

		if (clo.is_known) {
			return NULL;
		}

		if (gu_variant_is_null(clo.expr)) {
			PgfExprApp *expr_app1 =
				gu_new_variant(PGF_EXPR_APP,
							   PgfExprApp,
							   &clo.expr, out_pool);
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
			PgfLiteralStr *lit_str =
				gu_new_flex_variant(PGF_LITERAL_STR,
									PgfLiteralStr,
									val, strlen(name)+1,
									&expr_lit->lit, out_pool);
			strcpy(lit_str->val, name);
		}
		
		ep = gu_new(PgfExprProb, out_pool);
		ep->prob = 0;
		ep->expr = clo.expr;
	}

	gu_pool_free(tmp_pool);

	return ep;
}

PGF_API_DATA PgfLiteralCallback pgf_nerc_literal_callback =
  { pgf_match_name_lit, pgf_predict_empty } ;

static void
pgf_match_unknown_morpho_callback(PgfMorphoCallback* self_,
                                  PgfCId lemma, GuString analysis, prob_t prob,
                                  GuExn* err)
{
	PgfMatchMorphoCallback* self =
		gu_container(self_, PgfMatchMorphoCallback, callback);
	self->is_known = true;
}

static PgfExprProb*
pgf_match_unknown_lit(PgfLiteralCallback* self, PgfConcr* concr,
                      size_t lin_idx,
                      GuString sentence, size_t* poffset,
                      GuPool *out_pool)
{
	const uint8_t* buf = (uint8_t*) (sentence + *poffset);
	const uint8_t* p   = buf;

	PgfExprProb* ep = NULL;

	GuUCS ucs = gu_utf8_decode(&p);
	if (!gu_ucs_is_upper(ucs)) {
		GuPool* tmp_pool = gu_local_pool();
		GuStringBuf *sbuf = gu_string_buf(tmp_pool);
		GuOut* out = gu_string_buf_out(sbuf);
		GuExn* err = gu_new_exn(tmp_pool);

		gu_out_utf8(ucs, out, err);
		*poffset = p - ((uint8_t*) sentence);

		ucs = gu_utf8_decode(&p);
		while (ucs != 0 && !gu_ucs_is_space(ucs)) {
			gu_out_utf8(ucs, out, err);
			*poffset = p - ((uint8_t*) sentence);

			ucs = gu_utf8_decode(&p);
		}
		
		GuString word = gu_string_buf_freeze(sbuf, tmp_pool);

		PgfMatchMorphoCallback clo = { { pgf_match_unknown_morpho_callback }, 
			                           concr->abstr,
			                           gu_null_variant,
			                           false,
			                           out_pool
			                         };
		pgf_lookup_morpho(concr, word, &clo.callback, NULL);

		if (!clo.is_known) {
			ep = gu_new(PgfExprProb, out_pool);
			ep->prob = 0;

			PgfExprApp *expr_app =
				gu_new_variant(PGF_EXPR_APP,
							   PgfExprApp,
							   &ep->expr, out_pool);
			GuString con = "MkSymb";
			PgfExprFun *expr_fun =
				gu_new_flex_variant(PGF_EXPR_FUN,
									PgfExprFun,
									fun, strlen(con)+1,
									&expr_app->fun, out_pool);
			strcpy(expr_fun->fun, con);
			PgfExprLit *expr_lit =
				gu_new_variant(PGF_EXPR_LIT,
							   PgfExprLit,
							   &expr_app->arg, out_pool);
			PgfLiteralStr *lit_str =
				gu_new_flex_variant(PGF_LITERAL_STR,
									PgfLiteralStr,
									val, strlen(word)+1,
									&expr_lit->lit, out_pool);
			strcpy(lit_str->val, word);
		}
		
		gu_pool_free(tmp_pool);
	}

	return ep;
}

PGF_API_DATA PgfLiteralCallback pgf_unknown_literal_callback =
  { pgf_match_unknown_lit, pgf_predict_empty } ;

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
