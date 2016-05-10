#include <HsFFI.h>
#include <pgf/pgf.h>
#include <gu/utf8.h>

typedef struct {
	PgfLiteralCallback callback;
	PgfExprProb* (*match)(PgfLiteralCallback* self,
	                      size_t lin_idx,
	                      GuString sentence, size_t* poffset,
	                      GuPool *out_pool);
	GuFinalizer fin;
} HSPgfLiteralCallback;

static size_t
hspgf_offset2hs(GuString sentence, size_t offset)
{
	const uint8_t *start = sentence;
	const uint8_t *end   = sentence + offset;
	size_t hs_offset = 0;
	while (start < end) {
		gu_utf8_decode(&start);
		hs_offset++;
	}
	return hs_offset;
}

static size_t
hspgf_hs2offset(GuString sentence, size_t hs_offset)
{
	const uint8_t *start = sentence;
	const uint8_t *end   = start;
	while (hs_offset > 0) {
		gu_utf8_decode(&end);
		hs_offset--;
	}
	
	return (end - start);
}

static PgfExprProb*
hspgf_match_callback(PgfLiteralCallback* self, PgfConcr* concr,
	                 size_t lin_idx,
	                 GuString sentence, size_t* poffset,
	                 GuPool *out_pool)
{
	HSPgfLiteralCallback* callback = (HSPgfLiteralCallback*) self;

	size_t hs_offset =
		hspgf_offset2hs(sentence, *poffset);
	PgfExprProb* ep =
		callback->match(self, lin_idx, sentence, &hs_offset, out_pool);
	*poffset = hspgf_hs2offset(sentence, hs_offset);

	return ep;
}

static void
hspgf_literal_callback_fin(GuFinalizer* self)
{
	HSPgfLiteralCallback* callback = gu_container(self, HSPgfLiteralCallback, fin);
	
	if (callback->callback.match != NULL)
		hs_free_fun_ptr((HsFunPtr) callback->match);
	if (callback->callback.predict != NULL)
		hs_free_fun_ptr((HsFunPtr) callback->callback.predict);
}

void
hspgf_callbacks_map_add_literal(PgfConcr* concr, PgfCallbacksMap* callbacks,
                                PgfCId cat, HsFunPtr match, HsFunPtr predict,
                                GuPool* pool)
{
	HSPgfLiteralCallback* callback = gu_new(HSPgfLiteralCallback, pool);
	callback->callback.match   = hspgf_match_callback;
	callback->callback.predict = (void*) predict;
	callback->match  = (void*) match;
	callback->fin.fn = hspgf_literal_callback_fin;
	gu_pool_finally(pool, &callback->fin);
	pgf_callbacks_map_add_literal(concr, callbacks, cat, &callback->callback);
}

typedef struct {
	PgfOracleCallback oracle;
	GuString sentence;
    bool (*predict) (PgfCId cat,
	                 GuString label,
	                 size_t offset);
	bool (*complete)(PgfCId cat,
	                 GuString label,
	                 size_t offset);
    PgfExprProb* (*literal)(PgfCId cat,
	                        GuString label,
	                        size_t* poffset,
	                        GuPool *out_pool);
	GuFinalizer fin;
} HSPgfOracleCallback;

static bool
hspgf_predict_callback(PgfOracleCallback* self,
	                   PgfCId cat,
	                   GuString label,
	                   size_t offset)
{
	HSPgfOracleCallback* oracle = gu_container(self, HSPgfOracleCallback, oracle);
	oracle->predict(cat,label,hspgf_offset2hs(oracle->sentence, offset));
}

static bool
hspgf_complete_callback(PgfOracleCallback* self,
	                   PgfCId cat,
	                   GuString label,
	                   size_t offset)
{
	HSPgfOracleCallback* oracle = gu_container(self, HSPgfOracleCallback, oracle);
	oracle->complete(cat,label,hspgf_offset2hs(oracle->sentence, offset));
}

static PgfExprProb*
hspgf_literal_callback(PgfOracleCallback* self,
                       PgfCId cat,
	                   GuString label,
	                   size_t* poffset,
	                   GuPool *out_pool)
{
	HSPgfOracleCallback* oracle = gu_container(self, HSPgfOracleCallback, oracle);
	size_t hs_offset = hspgf_offset2hs(oracle->sentence, *poffset);
	PgfExprProb* ep =
		oracle->literal(cat,label,&hs_offset,out_pool);
	*poffset = hspgf_hs2offset(oracle->sentence, hs_offset);
	return ep;
}

static void
hspgf_oracle_callback_fin(GuFinalizer* self)
{
	HSPgfOracleCallback* oracle = gu_container(self, HSPgfOracleCallback, fin);

	if (oracle->predict  != NULL)
		hs_free_fun_ptr((HsFunPtr) oracle->predict);
	if (oracle->complete != NULL)
		hs_free_fun_ptr((HsFunPtr) oracle->complete);
	if (oracle->literal  != NULL)
		hs_free_fun_ptr((HsFunPtr) oracle->literal);
}

PgfOracleCallback*
hspgf_new_oracle_callback(GuString sentence,
                          HsFunPtr predict, HsFunPtr complete, HsFunPtr literal,
                          GuPool* pool)
{
	HSPgfOracleCallback* oracle = gu_new(HSPgfOracleCallback, pool);
	oracle->oracle.predict  = predict  ? hspgf_predict_callback  : NULL;
	oracle->oracle.complete = complete ? hspgf_complete_callback : NULL;
	oracle->oracle.literal  = literal  ? hspgf_literal_callback  : NULL;
	oracle->sentence = sentence;
	oracle->predict  = (void*) predict;
	oracle->complete = (void*) complete;
	oracle->literal  = (void*) literal;
	oracle->fin.fn = hspgf_oracle_callback_fin;
	gu_pool_finally(pool, &oracle->fin);
	return &oracle->oracle;
}
