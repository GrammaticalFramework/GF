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
typedef void (*PgfStatePrinter)(PgfReasoner* rs, PgfReasonerState* st,
                                GuOut* out, GuExn* err,
                                GuPool* tmp_pool);
#endif

struct PgfReasonerState {
	PgfClosure header;
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
pgf_print_parent_state(PgfReasoner* rs, PgfExprState* st,
                       GuOut* out, GuExn* err, GuBuf* stack)
{
	gu_buf_push(stack, int, (st->n_args - st->arg_idx - 1));

	PgfExprState* parent = gu_buf_get(st->answers->parents, PgfExprState*, 0);
	if (&parent->base.header != rs->start)
		pgf_print_parent_state(rs, parent, out, err, stack);

	gu_puts(" (", out, err);
	pgf_print_expr(st->expr, NULL, 0, out, err);
}

static void
pgf_print_expr_state(PgfReasoner* rs, PgfExprState* st,
                     GuOut* out, GuExn* err, GuPool* tmp_pool)
{	
	gu_printf(out, err, "[%f] ", st->base.prob);

	GuBuf* stack = gu_new_buf(int, tmp_pool);
	if (st->n_args > 0)
		gu_buf_push(stack, int, st->n_args - st->arg_idx);

	PgfExprState* cont =
		gu_buf_get(st->answers->parents, PgfExprState*, 0);
	if (&cont->base.header != rs->start)
		pgf_print_parent_state(rs, cont, out, err, stack);

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
pgf_combine1_to_expr(PgfCombine1State* st, GuPool* pool, GuPool* out_pool) {
	PgfExprProb* ep =
		gu_buf_get(st->exprs, PgfExprProb*, st->choice);

	PgfExprState* nst = gu_new(PgfExprState, pool);
	nst->base.header.code = st->parent->base.header.code;
	nst->base.prob = st->base.prob;
	nst->answers = st->parent->answers;
	nst->expr =
		gu_new_variant_i(out_pool, PGF_EXPR_APP,
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
pgf_combine2_to_expr(PgfReasoner* rs, PgfCombine2State* st,
                     GuPool* pool, GuPool* out_pool)
{
	PgfExprState* parent =
		gu_buf_get(st->parents, PgfExprState*, st->choice);
	if (&parent->base.header == rs->start)
		return NULL;

	PgfExprState* nst =
		gu_new(PgfExprState, pool);
	nst->base.header.code = parent->base.header.code;
	nst->base.prob         = st->base.prob;
	nst->answers = parent->answers;
	nst->expr    =
		gu_new_variant_i(out_pool, PGF_EXPR_APP,
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
pgf_print_combine1_state(PgfReasoner* rs, PgfCombine1State* st,
                         GuOut* out, GuExn* err, GuPool* tmp_pool)
{
	PgfExprState* nst = pgf_combine1_to_expr(st, tmp_pool, tmp_pool);
	pgf_print_expr_state(rs, nst, out, err, tmp_pool);
}

static void
pgf_print_combine2_state(PgfReasoner* rs, PgfCombine2State* st,
                         GuOut* out, GuExn* err, GuPool* tmp_pool)
{
	PgfExprState* nst = pgf_combine2_to_expr(rs, st, tmp_pool, tmp_pool);
	if (nst != NULL)
		pgf_print_expr_state(rs, nst, out, err, tmp_pool);
}
#endif

PGF_INTERNAL void
pgf_reasoner_combine1(PgfReasoner* rs, PgfClosure* closure)
{
	PgfCombine1State* st = (PgfCombine1State*) closure;
	PgfExprState* nst = pgf_combine1_to_expr(st, rs->pool, rs->out_pool);
	rs->eval_gates->enter(rs, &nst->base.header);

	st->choice++;

	if (st->choice < st->n_choices) {
		PgfExprProb* ep =
			gu_buf_get(st->exprs, PgfExprProb*, st->choice);

		st->base.prob = st->parent->base.prob + ep->prob;
		gu_buf_heap_push(rs->pqueue, &pgf_expr_state_order, &st);
	}
}

PGF_INTERNAL void
pgf_reasoner_try_first(PgfReasoner* rs, PgfExprState* parent, PgfAbsFun* absfun)
{
	PgfCId cat = absfun->type->cid;

	PgfAnswers* answers = gu_map_get(rs->table, cat, PgfAnswers*);
	if (answers == NULL) {
		answers = gu_new(PgfAnswers, rs->pool);
		answers->parents = gu_new_buf(PgfExprState*, rs->pool);
		answers->exprs   = gu_new_buf(PgfExprProb*, rs->pool);
		answers->outside_prob = parent->base.prob;

		gu_map_put(rs->table, cat, PgfAnswers*, answers);
	}

	gu_buf_push(answers->parents, PgfExprState*, parent);

	if (gu_buf_length(answers->parents) == 1) {
		PgfExprState* st = gu_new(PgfExprState, rs->pool);
		st->base.header.code = absfun->predicate;
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

			PgfCombine1State* nst = gu_new(PgfCombine1State, rs->pool);
			nst->base.header.code  = rs->eval_gates->combine1;
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

PGF_INTERNAL void
pgf_reasoner_try_else(PgfReasoner* rs, PgfExprState* prev, PgfAbsFun* absfun)
{
	PgfExprState *st = gu_new(PgfExprState, rs->pool);
	st->base.header.code = absfun->predicate;
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

PGF_INTERNAL void
pgf_reasoner_combine2(PgfReasoner* rs, PgfClosure* closure)
{
	PgfCombine2State* st = (PgfCombine2State*) closure;
	PgfExprState* nst = pgf_combine2_to_expr(rs, st, rs->pool, rs->out_pool);
	if (nst != NULL) {
		rs->eval_gates->enter(rs, &nst->base.header);
	}

	st->choice++;

	if (st->choice < st->n_choices) {
		PgfExprState* parent =
			gu_buf_get(st->parents, PgfExprState*, st->choice);

		st->base.prob = parent->base.prob + st->ep->prob;
		gu_buf_heap_push(rs->pqueue, &pgf_expr_state_order, &st);
	}
}

PGF_INTERNAL void
pgf_reasoner_complete(PgfReasoner* rs, PgfExprState* st)
{
	PgfExprProb* ep = gu_new(PgfExprProb, rs->out_pool);
	ep->prob = st->base.prob - st->answers->outside_prob;
	ep->expr = st->expr;
	gu_buf_push(st->answers->exprs, PgfExprProb*, ep);

	PgfCombine2State* nst = gu_new(PgfCombine2State, rs->pool);
	nst->base.header.code  = rs->eval_gates->combine2;
	nst->base.prob         = st->base.prob;
	nst->parents           = st->answers->parents;
	nst->choice            = 0;
	nst->n_choices         = gu_buf_length(st->answers->parents);
	nst->ep                = ep;
#ifdef PGF_REASONER_DEBUG
	nst->base.print = (PgfStatePrinter) pgf_print_combine2_state;
#endif
	rs->eval_gates->enter(rs, &nst->base.header);
}

PGF_INTERNAL void
pgf_reasoner_try_constant(PgfReasoner* rs, PgfExprState* prev, PgfAbsFun* absfun)
{
	pgf_reasoner_try_else(rs, prev, absfun);
	pgf_reasoner_complete(rs, prev);
}

static void
pgf_reasoner_mk_literal(PgfReasoner* rs, PgfExprState* parent,
                        GuString cat, PgfExpr expr)
{
	PgfAnswers* answers = gu_map_get(rs->table, cat, PgfAnswers*);
	if (answers == NULL) {
		answers = gu_new(PgfAnswers, rs->pool);
		answers->parents = gu_new_buf(PgfExprState*, rs->pool);
		answers->exprs   = gu_new_buf(PgfExprProb*, rs->pool);
		answers->outside_prob = parent->base.prob;

		gu_map_put(rs->table, cat, PgfAnswers*, answers);
	}

	gu_buf_push(answers->parents, PgfExprState*, parent);

	if (gu_buf_length(answers->parents) == 1) {
		PgfExprProb* ep = gu_new(PgfExprProb, rs->out_pool);
		ep->prob = 0;
		ep->expr = expr;
		gu_buf_push(answers->exprs, PgfExprProb*, ep);
	}

	if (&parent->base.header == rs->start)
		return;

	PgfExprProb* ep =
		gu_buf_get(answers->exprs, PgfExprProb*, 0);

	parent->expr =
		gu_new_variant_i(rs->out_pool,
		                 PGF_EXPR_APP,
		                 PgfExprApp,
		                 parent->expr, 
		                 ep->expr);
#ifdef PGF_REASONER_DEBUG
	parent->arg_idx++;
#endif
	parent->base.prob += ep->prob;
	gu_buf_heap_push(rs->pqueue, &pgf_expr_state_order, &parent);
}

PGF_INTERNAL void
pgf_reasoner_mk_string(PgfReasoner* rs, PgfExprState* parent)
{
	pgf_reasoner_mk_literal(rs, parent, "String",
	                        pgf_expr_string("__mock_string__", rs->out_pool));
}

PGF_INTERNAL void
pgf_reasoner_mk_int(PgfReasoner* rs, PgfExprState* parent)
{
	pgf_reasoner_mk_literal(rs, parent, "Int",
	                        pgf_expr_int(999, rs->out_pool));
}

PGF_INTERNAL void
pgf_reasoner_mk_float(PgfReasoner* rs, PgfExprState* parent)
{
	pgf_reasoner_mk_literal(rs, parent, "Float",
	                        pgf_expr_float(999.99, rs->out_pool));
}

static PgfExprProb*
pgf_reasoner_next(PgfReasoner* rs)
{
	for (;;) {
		if (rs->n_reported_exprs < gu_buf_length(rs->exprs)) {
			return gu_buf_get(rs->exprs, PgfExprProb*, rs->n_reported_exprs++);
		}

		if (gu_buf_length(rs->pqueue) == 0)
			return NULL;

		PgfReasonerState* st;
		gu_buf_heap_pop(rs->pqueue, &pgf_expr_state_order, &st);

#ifdef PGF_REASONER_DEBUG
		{
			GuPool* tmp_pool = gu_new_pool();
			GuOut* out = gu_file_out(stderr, tmp_pool);
			GuExn* err = gu_exn(tmp_pool);
			st->print(rs, st, out, err, tmp_pool);
			gu_pool_free(tmp_pool);
		}
#endif

		rs->eval_gates->enter(rs, &st->header);
	}
}

static void
pgf_reasoner_enum_next(GuEnum* self, void* to, GuPool* pool)
{
	PgfReasoner* pr = gu_container(self, PgfReasoner, en);
	*(PgfExprProb**)to = pgf_reasoner_next(pr);
}

PGF_INTERNAL PgfReasoner*
pgf_new_reasoner(PgfPGF* pgf, GuExn* err, GuPool* pool, GuPool* out_pool)
{
	size_t n_cafs =
		(pgf->abstract.eval_gates->cafs == NULL) 
			? 0 : gu_seq_length(pgf->abstract.eval_gates->cafs);

	PgfReasoner* rs = gu_new_flex(pool, PgfReasoner, cafs, n_cafs);
	rs->pool = pool,
	rs->out_pool = out_pool;
	rs->err   = err;
    rs->abstract = &pgf->abstract,
	rs->table = gu_new_string_map(PgfAnswers*, &gu_null_struct, rs->pool),

	rs->start = NULL;
	rs->eval_gates = pgf->abstract.eval_gates;

	rs->pqueue = gu_new_buf(PgfReasonerState*, rs->pool);
	rs->exprs = gu_new_buf(PgfExprProb*, rs->pool);
	rs->n_reported_exprs = 0;
	rs->en.next = pgf_reasoner_enum_next;

	PgfFunction* cafs = gu_seq_data(rs->eval_gates->cafs);
	for (size_t i = 0; i < n_cafs; i++) {
		rs->cafs[i].header.code = cafs[i];
		rs->cafs[i].val = NULL;
	}

	return rs;
}

PGF_API PgfExprEnum*
pgf_generate_all(PgfPGF* pgf, PgfType* typ, GuExn* err, GuPool* pool, GuPool* out_pool)
{
	PgfReasoner* rs = pgf_new_reasoner(pgf, err, pool, out_pool);

	PgfAnswers* answers = gu_new(PgfAnswers, rs->pool);
	answers->parents = gu_new_buf(PgfExprState*, rs->pool);
	answers->exprs   = rs->exprs;
	answers->outside_prob = 0;
	gu_map_put(rs->table, typ->cid, PgfAnswers*, answers);

	PgfAbsCat* abscat = gu_seq_binsearch(rs->abstract->cats, pgf_abscat_order, PgfAbsCat, typ->cid);
	if (abscat != NULL) {
		rs->start = gu_new(PgfClosure, rs->pool);
		rs->start->code = abscat->predicate;
		rs->eval_gates->enter(rs, rs->start);
	}

	return &rs->en;
}
