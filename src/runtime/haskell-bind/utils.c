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

static PgfExprProb*
hspgf_match_callback(PgfLiteralCallback* self, PgfConcr* concr,
	                 size_t lin_idx,
	                 GuString sentence, size_t* poffset,
	                 GuPool *out_pool)
{
	HSPgfLiteralCallback* callback = (HSPgfLiteralCallback*) self;
	size_t offset = *poffset;

	const uint8_t *start = sentence;
	const uint8_t *end   = sentence + offset;
	size_t hs_offset = 0;
	while (start < end) {
		gu_utf8_decode(&start);
		hs_offset++;
	}

	PgfExprProb* ep =
		callback->match(self, lin_idx, sentence, &hs_offset, out_pool);

	start = sentence;
	end   = start;
	while (hs_offset > 0) {
		gu_utf8_decode(&end);
		hs_offset--;
	}

	*poffset = (end - start);

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
	GuFinalizer fin;
} HSPgfOracleCallback;

static void
hspgf_oracle_callback_fin(GuFinalizer* self)
{
	HSPgfOracleCallback* oracle = gu_container(self, HSPgfOracleCallback, fin);

	if (oracle->oracle.predict  != NULL)
		hs_free_fun_ptr((HsFunPtr) oracle->oracle.predict);
	if (oracle->oracle.complete != NULL)
		hs_free_fun_ptr((HsFunPtr) oracle->oracle.complete);
	if (oracle->oracle.literal  != NULL)
		hs_free_fun_ptr((HsFunPtr) oracle->oracle.literal);
}

PgfOracleCallback*
hspgf_new_oracle_callback(HsFunPtr predict, HsFunPtr complete, HsFunPtr literal, GuPool* pool)
{
	HSPgfOracleCallback* oracle = gu_new(HSPgfOracleCallback, pool);
	oracle->oracle.predict  = (void*) predict;
	oracle->oracle.complete = (void*) complete;
	oracle->oracle.literal  = (void*) literal;
	oracle->fin.fn = hspgf_oracle_callback_fin;
	gu_pool_finally(pool, &oracle->fin);
	return &oracle->oracle;
}
