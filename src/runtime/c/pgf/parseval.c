#include <pgf/pgf.h>
#include <pgf/linearizer.h>
#include <pgf/parser.h>

typedef struct {
	int start, end;
	PgfCId cat;
	int lin_idx;
} PgfPhrase;

typedef struct {
	PgfLinFuncs* funcs;
	PgfParseState* ps;
	int pos;
	GuBuf* marks;
	GuBuf* phrases;
	int found, matches;
	GuPool* pool;
} PgfMetricsLznState;

static void
pgf_metrics_lzn_symbol_tokens(PgfLinFuncs** funcs, PgfTokens* toks)
{
	PgfMetricsLznState* state = gu_container(funcs, PgfMetricsLznState, funcs);
	
	size_t len = gu_seq_length(toks);
	for (size_t i = 0; i < len; i++) {
		PgfToken tok = gu_seq_get(toks, PgfToken, i);
		
		if (state->ps != NULL)
			state->ps = pgf_parser_next_state(state->ps, tok);

		state->pos++;
	}
}

static void
pgf_metrics_lzn_expr_literal(PgfLinFuncs** funcs, PgfLiteral lit)
{
	PgfMetricsLznState* state = gu_container(funcs, PgfMetricsLznState, funcs);

	GuVariantInfo i = gu_variant_open(lit);
    switch (i.tag) {
    case PGF_LITERAL_STR: {
        PgfLiteralStr* lstr = i.data;
        if (state->ps != NULL) {
			state->ps = pgf_parser_next_state(state->ps, lstr->val);
		}
		state->pos++;
		break;
	}
    case PGF_LITERAL_INT: {
        PgfLiteralInt* lint = i.data;
        if (state->ps != NULL) {
			GuString tok =
				gu_format_string(state->pool, "%d", lint->val);

			state->ps = pgf_parser_next_state(state->ps, tok);
		}
		state->pos++;
		break;
	}
    case PGF_LITERAL_FLT: {
        PgfLiteralFlt* lflt = i.data;
        if (state->ps != NULL) {
			GuString tok =
				gu_format_string(state->pool, "%f", lflt->val);

			state->ps = pgf_parser_next_state(state->ps, tok);
		}
		state->pos++;
		break;
	}
	default:
		gu_impossible();
	}
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
				gu_string_eq(phrase->cat, cat) &&
				phrase->lin_idx == lin_idx) {
				state->matches++;
				break;
			}
		}
		
		state->found++;
	}
}

static PgfLinFuncs pgf_metrics_lin_funcs1 = {
	.symbol_tokens = pgf_metrics_lzn_symbol_tokens,
	.expr_literal  = pgf_metrics_lzn_expr_literal,
	.begin_phrase  = pgf_metrics_lzn_begin_phrase,
	.end_phrase    = pgf_metrics_lzn_end_phrase1
};

static PgfLinFuncs pgf_metrics_lin_funcs2 = {
	.symbol_tokens = pgf_metrics_lzn_symbol_tokens,
	.expr_literal  = pgf_metrics_lzn_expr_literal,
	.begin_phrase  = pgf_metrics_lzn_begin_phrase,
	.end_phrase    = pgf_metrics_lzn_end_phrase2
};

bool
pgf_parseval(PgfConcr* concr, PgfExpr expr, PgfCId cat, 
             double *precision, double *recall, double *exact)
{
	GuPool* pool = gu_new_pool();
	
	GuEnum* en_lins1 =
		pgf_lzr_concretize(concr, expr, pool);
	PgfCncTree ctree1 = gu_next(en_lins1, PgfCncTree, pool);
	if (gu_variant_is_null(ctree1)) {
		gu_pool_free(pool);
		return false;
	}

	PgfMetricsLznState state;
	state.funcs = &pgf_metrics_lin_funcs1;
	state.ps = pgf_parser_init_state(concr, cat, 0, -1, pool, pool);
	state.marks = gu_new_buf(int, pool);
	state.pos = 0;
	state.phrases = gu_new_buf(PgfPhrase*, pool);
	state.matches = 0;
	state.found = 0;
	state.pool = pool;

	pgf_lzr_linearize(concr, ctree1, 0, &state.funcs);
	
	if (state.ps == NULL) {
		gu_pool_free(pool);
		return false;
	}

	GuEnum* en_trees = pgf_parse_result(state.ps);
	PgfExprProb* ep = gu_next(en_trees, PgfExprProb*, pool);
	if (ep == NULL) {
		gu_pool_free(pool);
		return false;
	}

	GuEnum* en_lins2 =
		pgf_lzr_concretize(concr, ep->expr, pool);
	PgfCncTree ctree2 = gu_next(en_lins2, PgfCncTree, pool);
	if (gu_variant_is_null(ctree2)) {
		gu_pool_free(pool);
		return false;
	}

	state.funcs = &pgf_metrics_lin_funcs2;
	state.ps = NULL;
	state.pos = 0;
	pgf_lzr_linearize(concr, ctree2, 0, &state.funcs);
	
	*precision = ((double) state.matches)/((double) state.found);
	*recall = ((double) state.matches)/((double) gu_buf_length(state.phrases));
	*exact = pgf_expr_eq(expr, ep->expr) ? 1 : 0;

	return true;
}
