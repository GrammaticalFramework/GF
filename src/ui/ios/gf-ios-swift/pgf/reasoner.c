#include <pgf/pgf.h>
#include <pgf/data.h>
#include <pgf/reasoner.h>
#include <gu/file.h>

//#define PGF_REASONER_DEBUG

typedef struct {
	GuBuf* parents;
	GuBuf* exprs;
	prob_t outside_prob;
} PgfAnswers;

#ifdef PGF_REASONER_DEBUG
typedef void (*PgfStatePrinter)(PgfReasonerState* st,
                                GuOut* out, GuExn* err,
                                GuPool* tmp_pool);
#endif

struct PgfReasonerState {
	// the jitter expects that continuation is the first field
	PgfPredicate continuation;
#ifdef PGF_REASONER_DEBUG
	PgfStatePrinter print;
#endif
	prob_t prob;
};

struct PgfExprState {
	// base must be the first field in order to be able to cast
	// from PgfExprState to PgfReasonerState
	PgfReasonerState base;
	PgfAnswers* answers;
	PgfExpr expr;
#ifdef PGF_REASONER_DEBUG
	size_t n_args;
	size_t arg_idx;
#endif
};

typedef struct {
	// base must be the first field in order to be able to cast
	// from PgfCombine1State to PgfReasonerState
	PgfReasonerState base;
	GuBuf* exprs;
	PgfExprState* parent;
	size_t n_choices;
	size_t choice;
} PgfCombine1State;

typedef struct {
	// base must be the first field in order to be able to cast
	// from PgfCombine2State to PgfReasonerState
	PgfReasonerState base;
	GuBuf* parents;
	PgfExprProb* ep;
	size_t n_choices;
	size_t choice;
} PgfCombine2State;

typedef GuStringMap PgfAbswersMap;

struct PgfReasoner {
	GuPool* pool;
	GuPool* tmp_pool;
	PgfAbstr* abstract;
	PgfAbswersMap* table;
	GuBuf* pqueue;
	GuBuf* exprs;
	PgfExprEnum en;
};

static int
cmp_expr_state(GuOrder* self, const void* a, const void* b)
{
	PgfReasonerState *st1 = *((PgfReasonerState **) a);
	PgfReasonerState *st2 = *((PgfReasonerState **) b);
	
	if (st1->prob < st2->prob)
		return -1;
	else if (st1->prob > st2->prob)
		return 1;
	else
		return 0;
}

static GuOrder
pgf_expr_state_order = { cmp_expr_state };

#ifdef PGF_REASONER_DEBUG
static void
pgf_print_parent_state(PgfExprState* st,
                       GuOut* out, GuExn* err, GuBuf* stack)
{
	gu_buf_push(stack, int, (st->n_args - st->arg_idx - 1));

	PgfExprState* parent = gu_buf_get(st->answers->parents, PgfExprState*, 0);
	if (parent != NULL)
		pgf_print_parent_state(parent, out, err, stack);

	gu_puts(" (", out, err);
	pgf_print_expr(st->expr, NULL, 0, out, err);
}

static void
pgf_print_expr_state(PgfExprState* st,
                     GuOut* out, GuExn* err, GuPool* tmp_pool)
{	
	gu_printf(out, err, "[%f] ", st->base.prob);

	GuBuf* stack = gu_new_buf(int, tmp_pool);
	if (st->n_args > 0)
		gu_buf_push(stack, int, st->n_args - st->arg_idx);

	PgfExprState* cont =
		gu_buf_get(st->answers->parents, PgfExprState*, 0);
	if (cont != NULL)
		pgf_print_parent_state(cont, out, err, stack);

	if (st->n_args > 0)
		gu_puts(" (", out, err);
	else
		gu_puts(" ", out, err);
	pgf_print_expr(st->expr, NULL, 0, out, err);

	size_t n_counts = gu_buf_length(stack);
	for (size_t i = 0; i < n_counts; i++) {
		int count = gu_buf_get(stack, int, i);
		while (count-- > 0)
			gu_puts(" ?", out, err);
		
		gu_puts(")", out, err);
	}
	gu_puts("\n", out, err);
}
#endif

static PgfExprState*
pgf_combine1_to_expr(PgfCombine1State* st, GuPool* tmp_pool) {
	PgfExprProb* ep =
		gu_buf_get(st->exprs, PgfExprProb*, st->choice);

	PgfExprState* nst = gu_new(PgfExprState, tmp_pool);
	nst->base.continuation = st->parent->base.continuation;
	nst->base.prob = st->base.prob;
	nst->answers = st->parent->answers;
	nst->expr =
		gu_new_variant_i(tmp_pool, PGF_EXPR_APP,
				PgfExprApp,
				.fun = st->parent->expr,
				.arg = ep->expr);
#ifdef PGF_REASONER_DEBUG
	nst->base.print = (PgfStatePrinter) pgf_print_expr_state;
	nst->n_args     = st->parent->n_args;
	nst->arg_idx    = st->parent->arg_idx+1;
#endif

	return nst;
}

static PgfExprState*
pgf_combine2_to_expr(PgfCombine2State* st, GuPool* tmp_pool)
{
	PgfExprState* parent =
		gu_buf_get(st->parents, PgfExprState*, st->choice);
	if (parent == NULL)
		return NULL;

	PgfExprState* nst =
		gu_new(PgfExprState, tmp_pool);
	nst->base.continuation = parent->base.continuation;
	nst->base.prob         = st->base.prob;
	nst->answers = parent->answers;
	nst->expr    =
		gu_new_variant_i(tmp_pool, PGF_EXPR_APP,
				PgfExprApp,
				.fun = parent->expr,
				.arg = st->ep->expr);
#ifdef PGF_REASONER_DEBUG
	nst->base.print = (PgfStatePrinter) pgf_print_expr_state;
	nst->n_args  = parent->n_args;
	nst->arg_idx = parent->arg_idx+1;
#endif

	return nst;
}

#ifdef PGF_REASONER_DEBUG
static void
pgf_print_combine1_state(PgfCombine1State* st,
                         GuOut* out, GuExn* err, GuPool* tmp_pool)
{
	PgfExprState* nst = pgf_combine1_to_expr(st, tmp_pool);
	pgf_print_expr_state(nst, out, err, tmp_pool);
}

static void
pgf_print_combine2_state(PgfCombine2State* st,
                         GuOut* out, GuExn* err, GuPool* tmp_pool)
{
	PgfExprState* nst = pgf_combine2_to_expr(st, tmp_pool);
	if (nst != NULL)
		pgf_print_expr_state(nst, out, err, tmp_pool);
}
#endif

static void
pgf_combine1(PgfReasoner* rs, PgfCombine1State* st)
{
	PgfExprState* nst = pgf_combine1_to_expr(st, rs->tmp_pool);
	nst->base.continuation(rs, &nst->base);

	st->choice++;

	if (st->choice < st->n_choices) {
		PgfExprProb* ep =
			gu_buf_get(st->exprs, PgfExprProb*, st->choice);

		st->base.prob = st->parent->base.prob + ep->prob;
		gu_buf_heap_push(rs->pqueue, &pgf_expr_state_order, &st);
	}
}

void
pgf_reasoner_try_first(PgfReasoner* rs, PgfExprState* parent, PgfAbsFun* absfun)
{
	PgfCId cat = absfun->type->cid;

	PgfAnswers* answers = gu_map_get(rs->table, cat, PgfAnswers*);
	if (answers == NULL) {
		answers = gu_new(PgfAnswers, rs->tmp_pool);
		answers->parents = gu_new_buf(PgfExprState*, rs->tmp_pool);
		answers->exprs   = gu_new_buf(PgfExprProb*, rs->tmp_pool);
		answers->outside_prob = parent->base.prob;

		gu_map_put(rs->table, cat, PgfAnswers*, answers);
	}

	gu_buf_push(answers->parents, PgfExprState*, parent);

	if (gu_buf_length(answers->parents) == 1) {
		PgfExprState* st = gu_new(PgfExprState, rs->tmp_pool);
		st->base.continuation = (PgfPredicate) absfun->predicate;
		st->base.prob = answers->outside_prob + absfun->ep.prob;
		st->answers = answers;
		st->expr = absfun->ep.expr;
#ifdef PGF_REASONER_DEBUG
		st->base.print = (PgfStatePrinter) pgf_print_expr_state;
		st->n_args = gu_seq_length(absfun->type->hypos);
		st->arg_idx = 0;
#endif
		gu_buf_heap_push(rs->pqueue, &pgf_expr_state_order, &st);
	} else {
		size_t n_exprs = gu_buf_length(answers->exprs);
		if (n_exprs > 0) {
			PgfExprProb* ep =
				gu_buf_get(answers->exprs, PgfExprProb*, 0);

			PgfCombine1State* nst = gu_new(PgfCombine1State, rs->tmp_pool);
			nst->base.continuation = (PgfPredicate) pgf_combine1;
			nst->base.prob         = parent->base.prob + ep->prob;
			nst->exprs             = answers->exprs;
			nst->choice            = 0;
			nst->n_choices         = gu_buf_length(answers->exprs);
			nst->parent            = parent;
#ifdef PGF_REASONER_DEBUG
			nst->base.print = (PgfStatePrinter) pgf_print_combine1_state;
#endif
			gu_buf_heap_push(rs->pqueue, &pgf_expr_state_order, &nst);
		}
	}
}

void
pgf_reasoner_try_else(PgfReasoner* rs, PgfExprState* prev, PgfAbsFun* absfun)
{
	PgfExprState *st = gu_new(PgfExprState, rs->tmp_pool);
	st->base.continuation = (PgfPredicate) absfun->predicate;
	st->base.prob = prev->answers->outside_prob + absfun->ep.prob;
	st->answers   = prev->answers;
	st->expr      = absfun->ep.expr;
#ifdef PGF_REASONER_DEBUG
	st->base.print = (PgfStatePrinter) pgf_print_expr_state;
	st->n_args  = gu_seq_length(absfun->type->hypos);
	st->arg_idx = 0;
#endif
	gu_buf_heap_push(rs->pqueue, &pgf_expr_state_order, &st);
}

static void
pgf_combine2(PgfReasoner* rs, PgfCombine2State* st)
{
	PgfExprState* nst = pgf_combine2_to_expr(st, rs->tmp_pool);
	if (nst != NULL) {
		nst->base.continuation(rs, &nst->base);
	}

	st->choice++;

	if (st->choice < st->n_choices) {
		PgfExprState* parent =
			gu_buf_get(st->parents, PgfExprState*, st->choice);

		st->base.prob = parent->base.prob + st->ep->prob;
		gu_buf_heap_push(rs->pqueue, &pgf_expr_state_order, &st);
	}
}

void
pgf_reasoner_complete(PgfReasoner* rs, PgfExprState* st)
{
	PgfExprProb* ep = gu_new(PgfExprProb, rs->pool);
	ep->prob = st->base.prob - st->answers->outside_prob;
	ep->expr = st->expr;
	gu_buf_push(st->answers->exprs, PgfExprProb*, ep);

	PgfCombine2State* nst = gu_new(PgfCombine2State, rs->tmp_pool);
	nst->base.continuation = (PgfPredicate) pgf_combine2;
	nst->base.prob         = st->base.prob;
	nst->parents           = st->answers->parents;
	nst->choice            = 0;
	nst->n_choices         = gu_buf_length(st->answers->parents);
	nst->ep                = ep;
#ifdef PGF_REASONER_DEBUG
	nst->base.print = (PgfStatePrinter) pgf_print_combine2_state;
#endif
	nst->base.continuation(rs, &nst->base);
}

void
pgf_reasoner_try_constant(PgfReasoner* rs, PgfExprState* prev, PgfAbsFun* absfun)
{
	pgf_reasoner_try_else(rs, prev, absfun);
	pgf_reasoner_complete(rs, prev);
}

static PgfExprProb*
pgf_reasoner_next(PgfReasoner* rs)
{
	if (rs->tmp_pool == NULL)
		return NULL;
		
	size_t n_exprs = gu_buf_length(rs->exprs);

	while (gu_buf_length(rs->pqueue) > 0) {
		PgfReasonerState* st;
		gu_buf_heap_pop(rs->pqueue, &pgf_expr_state_order, &st);

#ifdef PGF_REASONER_DEBUG
		{
			GuPool* tmp_pool = gu_new_pool();
			GuOut* out = gu_file_out(stderr, tmp_pool);
			GuExn* err = gu_exn(tmp_pool);
			st->print(st, out, err, tmp_pool);
			gu_pool_free(tmp_pool);
		}
#endif

		st->continuation(rs, st);
		
		if (n_exprs < gu_buf_length(rs->exprs)) {
			return gu_buf_get(rs->exprs, PgfExprProb*, n_exprs);
		}
	}

	gu_pool_free(rs->tmp_pool);
	rs->tmp_pool = NULL;
	rs->pqueue   = NULL;
	return NULL;
}

static void
pgf_reasoner_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfReasoner* pr = gu_container(self, PgfReasoner, en);
	*(PgfExprProb**)to = pgf_reasoner_next(pr);
}

PgfExprEnum*
pgf_generate_all(PgfPGF* pgf, PgfCId cat, GuPool* pool)
{
	PgfReasoner* rs = gu_new(PgfReasoner, pool);
	rs->pool = pool;
	rs->tmp_pool = gu_new_pool(),
    rs->abstract = &pgf->abstract,
	rs->table = gu_new_string_map(PgfAnswers*, &gu_null_struct, rs->tmp_pool),

	rs->pqueue = gu_new_buf(PgfReasonerState*, rs->tmp_pool);
	rs->exprs = gu_new_buf(PgfExprProb*, rs->tmp_pool);
	rs->en.next = pgf_reasoner_enum_next;

	PgfAnswers* answers = gu_new(PgfAnswers, rs->tmp_pool);
	answers->parents = gu_new_buf(PgfExprState*, rs->tmp_pool);
	answers->exprs   = rs->exprs;
	answers->outside_prob = 0;
	gu_map_put(rs->table, cat, PgfAnswers*, answers);

	PgfAbsCat* abscat = gu_seq_binsearch(rs->abstract->cats, pgf_abscat_order, PgfAbsCat, cat);
	if (abscat != NULL) {
		((PgfPredicate) abscat->predicate)(rs, NULL);
	}

	return &rs->en;
}
