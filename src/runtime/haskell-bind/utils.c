#include <HsFFI.h>
#include <pgf/pgf.h>

typedef struct {
	PgfLiteralCallback callback;
	GuFinalizer fin;
} HSPgfLiteralCallback;

static void 
hspgf_literal_callback_fin(GuFinalizer* self)
{
	HSPgfLiteralCallback* callback = gu_container(self, HSPgfLiteralCallback, fin);
	
	if (callback->callback.match != NULL)
		hs_free_fun_ptr((HsFunPtr) callback->callback.match);
	if (callback->callback.predict != NULL)
		hs_free_fun_ptr((HsFunPtr) callback->callback.predict);
}

PgfLiteralCallback*
hspgf_new_literal_callback(PgfConcr* concr) {
	GuPool* pool = pgf_concr_get_pool(concr);
	HSPgfLiteralCallback* callback = gu_new(HSPgfLiteralCallback, pool);
	callback->callback.match   = NULL;
	callback->callback.predict = NULL;
	callback->fin.fn = hspgf_literal_callback_fin;
	gu_pool_finally(pool, &callback->fin);
	return &callback->callback;
}
