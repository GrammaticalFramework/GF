#include <pgf/pgf.h>
#include <pgf/data.h>
#include <pgf/linearizer.h>
#include <gu/enum.h>

typedef struct {
	int start, end;
	PgfCId cat;
	int lin_idx;
} PgfPhrase;

typedef struct {
	PgfLinFuncs* funcs;
	bool bind;
	GuOut* out;
	GuExn* err;
	int pos;
	GuBuf* marks;
	GuBuf* phrases;
	int found, matches;
	GuPool* pool;
} PgfMetricsLznState;

static void
pgf_metrics_put_space(PgfMetricsLznState* state)
{
	if (state->bind)
		state->bind = false;
	else {
		if (state->out != NULL)
			gu_putc(' ', state->out, state->err);
		state->pos++;
	}
}

static void
pgf_metrics_lzn_symbol_token(PgfLinFuncs** funcs, PgfToken tok)
{
	PgfMetricsLznState* state = gu_container(funcs, PgfMetricsLznState, funcs);

	pgf_metrics_put_space(state);
	if (state->out != NULL)
		gu_string_write(tok, state->out, state->err);

	state->pos += strlen(tok);
}

static void
pgf_metrics_lzn_begin_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lin_index, PgfCId fun)
{
	PgfMetricsLznState* state = gu_container(funcs, PgfMetricsLznState, funcs);
	gu_buf_push(state->marks, int, state->pos);
}

static void
pgf_metrics_lzn_end_phrase1(PgfLinFuncs** funcs, PgfCId cat, int fid, int lin_idx, PgfCId fun)
{
	PgfMetricsLznState* state = gu_container(funcs, PgfMetricsLznState, funcs);

	int start = gu_buf_pop(state->marks, int);
	int end   = state->pos;
	
	if (start != end) {
		PgfPhrase* phrase = gu_new(PgfPhrase, state->pool);
		phrase->start = start;
		phrase->end = end;
		phrase->cat = cat;
		phrase->lin_idx = lin_idx;
		gu_buf_push(state->phrases, PgfPhrase*, phrase);
	}
}

static void
pgf_metrics_symbol_ne(PgfLinFuncs** funcs)
{
	PgfMetricsLznState* state = gu_container(funcs, PgfMetricsLznState, funcs);
	gu_raise(state->err, PgfLinNonExist);
}

static void
pgf_metrics_symbol_bind(PgfLinFuncs** funcs)
{
	PgfMetricsLznState* state = gu_container(funcs, PgfMetricsLznState, funcs);
	state->bind = true;
}

static void
pgf_metrics_lzn_end_phrase2(PgfLinFuncs** funcs, PgfCId cat, int fid, int lin_idx, PgfCId fun)
{
	PgfMetricsLznState* state = gu_container(funcs, PgfMetricsLznState, funcs);

	int start = gu_buf_pop(state->marks, int);
	int end   = state->pos;
	
	if (start != end) {		
		size_t n_phrases = gu_buf_length(state->phrases);
		for (size_t i = 0; i < n_phrases; i++) {
			PgfPhrase* phrase = gu_buf_get(state->phrases, PgfPhrase*, i);
			
			if (phrase->start == start &&
				phrase->end   == end &&
				strcmp(phrase->cat, cat) == 0 &&
				phrase->lin_idx == lin_idx) {
				state->matches++;
				break;
			}
		}
		
		state->found++;
	}
}

static PgfLinFuncs pgf_metrics_lin_funcs1 = {
	.symbol_token = pgf_metrics_lzn_symbol_token,
	.begin_phrase = pgf_metrics_lzn_begin_phrase,
	.end_phrase   = pgf_metrics_lzn_end_phrase1,
	.symbol_ne    = pgf_metrics_symbol_ne,
	.symbol_bind  = pgf_metrics_symbol_bind,
	.symbol_capit = NULL
};

static PgfLinFuncs pgf_metrics_lin_funcs2 = {
	.symbol_token = pgf_metrics_lzn_symbol_token,
	.begin_phrase = pgf_metrics_lzn_begin_phrase,
	.end_phrase   = pgf_metrics_lzn_end_phrase2,
	.symbol_ne    = pgf_metrics_symbol_ne,
	.symbol_bind  = pgf_metrics_symbol_bind,
	.symbol_capit = NULL
};

bool
pgf_parseval(PgfConcr* concr, PgfExpr expr, PgfType* type, 
             double *precision, double *recall, double *exact)
{
	GuPool* pool = gu_new_pool();

	GuExn* err = gu_new_exn(pool);

	GuEnum* en_lins1 =
		pgf_lzr_concretize(concr, expr, err, pool);
	if (!gu_ok(err)) {
		gu_pool_free(pool);
		return false;
	}

	PgfCncTree ctree1 = gu_next(en_lins1, PgfCncTree, pool);
	if (gu_variant_is_null(ctree1)) {
		gu_pool_free(pool);
		return false;
	}

	GuStringBuf* sbuf =
		gu_string_buf(pool);

	PgfMetricsLznState state;
	state.bind = true;
	state.out  = gu_string_buf_out(sbuf);
	state.err  = gu_new_exn(pool);
	state.funcs = &pgf_metrics_lin_funcs1;
	state.pos = 0;
	state.marks = gu_new_buf(int, pool);
	state.phrases = gu_new_buf(PgfPhrase*, pool);
	state.matches = 0;
	state.found = 0;
	state.pool = pool;

	pgf_lzr_linearize(concr, ctree1, 0, &state.funcs, pool);
	if (!gu_ok(state.err)) {
		gu_pool_free(pool);
		return false;
	}

	GuString sentence =
		gu_string_buf_freeze(sbuf, pool);

	GuEnum* en_trees =
		pgf_parse(concr, type, sentence,
		          state.err, pool, pool);
	PgfExprProb* ep = gu_next(en_trees, PgfExprProb*, pool);
	if (ep == NULL) {
		gu_pool_free(pool);
		return false;
	}

	GuEnum* en_lins2 =
		pgf_lzr_concretize(concr, ep->expr, err, pool);
	PgfCncTree ctree2 = gu_next(en_lins2, PgfCncTree, pool);
	if (gu_variant_is_null(ctree2)) {
		gu_pool_free(pool);
		return false;
	}

	state.funcs = &pgf_metrics_lin_funcs2;
	state.bind = true;
	state.out  = NULL;
	state.pos  = 0;
	pgf_lzr_linearize(concr, ctree2, 0, &state.funcs, pool);

	*precision = ((double) state.matches)/((double) state.found);
	*recall = ((double) state.matches)/((double) gu_buf_length(state.phrases));
	*exact = pgf_expr_eq(expr, ep->expr) ? 1 : 0;

	gu_pool_free(pool);

	return true;
}
