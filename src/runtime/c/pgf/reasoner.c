#include <pgf/pgf.h>
#include <pgf/data.h>
#include <gu/file.h>
#include <math.h>
#include <stdio.h>

//#define PGF_REASONER_DEBUG

typedef struct PgfExprState PgfExprState;

typedef struct {
	GuBuf* conts;
	GuBuf* exprs;
	prob_t outside_prob;
} PgfAnswers;

struct PgfExprState {
	PgfAnswers* answers;
	PgfExprProb ep;
	PgfHypos hypos;
	size_t arg_idx;
};

typedef enum {
	PGF_EXPR_QSTATE_PREDICT,
	PGF_EXPR_QSTATE_COMBINE1,
	PGF_EXPR_QSTATE_COMBINE2
} PGF_EXPR_QSTATE_KIND;

typedef struct {
	prob_t prob;
	PGF_EXPR_QSTATE_KIND kind;
	void*  single;
	size_t choice_idx;
	GuBuf* choices;
} PgfExprQState;

static GU_DEFINE_TYPE(PgfAnswers, abstract);

typedef GuStringMap PgfAbswersMap;
static GU_DEFINE_TYPE(PgfAbswersMap, GuStringMap, gu_ptr_type(PgfAnswers),
                      &gu_null_struct);

typedef struct {
	GuPool* tmp_pool;
	PgfAbstr* abstract;
	PgfAbswersMap* table;
	GuBuf* pqueue;
	PgfExprEnum en;
} PgfReasoner;

static int
cmp_expr_qstate(GuOrder* self, const void* a, const void* b)
{
	PgfExprQState *q1 = *((PgfExprQState **) a);
	PgfExprQState *q2 = *((PgfExprQState **) b);
	
	if (q1->prob < q2->prob)
		return -1;
	else if (q1->prob > q2->prob)
		return 1;
	else
		return 0;
}

static GuOrder
pgf_expr_qstate_order = { cmp_expr_qstate };

#ifdef PGF_REASONER_DEBUG
static void
pgf_print_expr_state(PgfExprState* st,
                     GuWriter* wtr, GuExn* err, GuBuf* stack)
{
	gu_buf_push(stack, int, (gu_seq_length(st->hypos) - st->arg_idx - 1));

	PgfExprState* cont = gu_buf_get(st->answers->conts, PgfExprState*, 0);
	if (cont != NULL)
		pgf_print_expr_state(cont, wtr, err, stack);

	gu_puts(" (", wtr, err);
	pgf_print_expr(st->ep.expr, 0, wtr, err);
}

static void
pgf_print_expr_state0(PgfExprState* st, PgfAbstr* abstract,
                      GuWriter* wtr, GuExn* err, GuPool* tmp_pool)
{	
	prob_t prob = st->answers->outside_prob+st->ep.prob;
	gu_printf(wtr, err, "[%f]", prob);

	size_t n_args = gu_seq_length(st->hypos);

	GuBuf* stack = gu_new_buf(int, tmp_pool);
	if (n_args > 0)
		gu_buf_push(stack, int, gu_seq_length(st->hypos) - st->arg_idx);

	PgfExprState* cont =
		gu_buf_get(st->answers->conts, PgfExprState*, 0);
	if (cont != NULL)
		pgf_print_expr_state(cont, wtr, err, stack);

	if (n_args > 0)
		gu_puts(" (", wtr, err);
	else
		gu_puts(" ", wtr, err);
	pgf_print_expr(st->ep.expr, 0, wtr, err);

	size_t n_counts = gu_buf_length(stack);
	for (size_t i = 0; i < n_counts; i++) {
		int count = gu_buf_get(stack, int, i);
		while (count-- > 0)
			gu_puts(" ?", wtr, err);
		
		gu_puts(")", wtr, err);
	}
	gu_puts("\n", wtr, err);
}
#endif

static PgfExprState*
pgf_reasoner_combine(PgfReasoner* rs,
                     PgfExprState* st, PgfExprProb* ep,
                     GuPool* pool)
{
	PgfExprState* nst = 
		gu_new(PgfExprState, rs->tmp_pool);
	nst->answers = st->answers;
	nst->ep.expr =
		gu_new_variant_i(pool, PGF_EXPR_APP,
				PgfExprApp,
				.fun = st->ep.expr,
				.arg = ep->expr);
	nst->ep.prob = st->ep.prob+ep->prob;
	nst->hypos = st->hypos;
	nst->arg_idx = st->arg_idx+1;
	return nst;
}

static void
pgf_reasoner_predict(PgfReasoner* rs, PgfExprState* cont,
                     prob_t outside_prob, PgfCId cat,
                     GuPool* pool)
{
	PgfAnswers* answers = gu_map_get(rs->table, &cat, PgfAnswers*);
	if (answers == NULL) {
		answers = gu_new(PgfAnswers, rs->tmp_pool);
		answers->conts = gu_new_buf(PgfExprState*, rs->tmp_pool);
		answers->exprs = gu_new_buf(PgfExprProb*, rs->tmp_pool);
		answers->outside_prob = outside_prob;

		gu_map_put(rs->table, &cat, PgfAnswers*, answers);
	}

	gu_buf_push(answers->conts, PgfExprState*, cont);

	if (gu_buf_length(answers->conts) == 1) {
		PgfCat* abscat = gu_map_get(rs->abstract->cats, &cat, PgfCat*);
		if (abscat == NULL) {
			return;
		}

		if (gu_buf_length(abscat->functions) > 0) {
			PgfExprQState *q = gu_new(PgfExprQState, rs->tmp_pool);
			q->kind = PGF_EXPR_QSTATE_PREDICT;
			q->single = answers;
			q->choice_idx = 0;
			q->choices = abscat->functions;

			q->prob = answers->outside_prob + gu_buf_get(q->choices, PgfFunDecl*, 0)->ep.prob;
			gu_buf_heap_push(rs->pqueue, &pgf_expr_qstate_order, &q);
		}
	} else {
		if (gu_buf_length(answers->exprs) > 0) {
			PgfExprQState *q = gu_new(PgfExprQState, rs->tmp_pool);
			q->prob = cont->ep.prob + gu_buf_get(answers->exprs, PgfExprProb*, 0)->prob;
			q->kind = PGF_EXPR_QSTATE_COMBINE1;
			q->single = cont;
			q->choice_idx = 0;
			q->choices = answers->exprs;

			gu_buf_heap_push(rs->pqueue, &pgf_expr_qstate_order, &q);
		}
	}
}

static PgfExprProb*
pgf_reasoner_next(PgfReasoner* rs, GuPool* pool)
{
	if (rs->tmp_pool == NULL)
		return NULL;

	while (gu_buf_length(rs->pqueue) > 0) {
		PgfExprQState* q;
		gu_buf_heap_pop(rs->pqueue, &pgf_expr_qstate_order, &q);

		PgfExprState* st = NULL;
		switch (q->kind) {
		case PGF_EXPR_QSTATE_PREDICT: {
			PgfFunDecl* absfun =
				gu_buf_get(q->choices, PgfFunDecl*, q->choice_idx);

			st = gu_new(PgfExprState, pool);
			st->answers = q->single;
			st->ep      = absfun->ep;
			st->hypos   = absfun->type->hypos;
			st->arg_idx = 0;

			q->choice_idx++;
			if (q->choice_idx < gu_buf_length(q->choices)) {
				q->prob = st->answers->outside_prob + gu_buf_get(q->choices, PgfFunDecl*, q->choice_idx)->ep.prob;
				gu_buf_heap_push(rs->pqueue, &pgf_expr_qstate_order, &q);
			}
			break;
		}
		case PGF_EXPR_QSTATE_COMBINE1: {
			PgfExprState* cont = q->single;
			PgfExprProb* ep =
				gu_buf_get(q->choices, PgfExprProb*, q->choice_idx);
			st = pgf_reasoner_combine(rs, cont, ep, pool);
			
			q->choice_idx++;
			if (q->choice_idx < gu_buf_length(q->choices)) {
				q->prob = cont->ep.prob + gu_buf_get(q->choices, PgfExprProb*, q->choice_idx)->prob;
				gu_buf_heap_push(rs->pqueue, &pgf_expr_qstate_order, &q);
			}
			break;
		}
		case PGF_EXPR_QSTATE_COMBINE2: {
			PgfExprState* cont =
				gu_buf_get(q->choices, PgfExprState*, q->choice_idx);
			PgfExprProb* ep = q->single;
			st = pgf_reasoner_combine(rs, cont, ep, pool);
			
			q->choice_idx++;
			if (q->choice_idx < gu_buf_length(q->choices)) {
				q->prob = ep->prob + gu_buf_get(q->choices, PgfExprState*, q->choice_idx)->ep.prob;
				gu_buf_heap_push(rs->pqueue, &pgf_expr_qstate_order, &q);
			}
			break;
		}
		default:
			gu_impossible();
		}
		

#ifdef PGF_REASONER_DEBUG
		{
			GuPool* tmp_pool = gu_new_pool();
			GuOut* out = gu_file_out(stderr, tmp_pool);
			GuWriter* wtr = gu_new_utf8_writer(out, tmp_pool);
			GuExn* err = gu_exn(NULL, type, tmp_pool);
			pgf_print_expr_state0(st, rs->abstract, wtr, err, tmp_pool);
			gu_pool_free(tmp_pool);
		}
#endif

		if (st->arg_idx < gu_seq_length(st->hypos)) {
			PgfHypo *hypo = gu_seq_index(st->hypos, PgfHypo, st->arg_idx);
			prob_t outside_prob = 
				st->ep.prob+st->answers->outside_prob;
			pgf_reasoner_predict(rs, st, outside_prob,
								 hypo->type->cid, pool);
		} else {
			gu_buf_push(st->answers->exprs, PgfExprProb*, &st->ep);

			PgfExprProb* target = NULL;
				
			GuBuf* conts = st->answers->conts;
			size_t choice_idx = 0;
			PgfExprState* cont =
				gu_buf_get(conts, PgfExprState*, 0);
			if (cont == NULL) {
				target = &st->ep;
				cont   = gu_buf_get(conts, PgfExprState*, 1);
				choice_idx++;
			}

			if (choice_idx < gu_buf_length(conts)) {
				PgfExprQState *q = gu_new(PgfExprQState, rs->tmp_pool);
				q->prob = st->ep.prob + cont->ep.prob;
				q->kind = PGF_EXPR_QSTATE_COMBINE2;
				q->single = &st->ep;
				q->choice_idx = choice_idx;
				q->choices = conts;

				gu_buf_heap_push(rs->pqueue, &pgf_expr_qstate_order, &q);
			}

			if (target != NULL)
				return target;
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
	*(PgfExprProb**)to = pgf_reasoner_next(pr, pool);
}

PgfExprEnum*
pgf_generate(PgfPGF* pgf, PgfCId cat, GuPool* pool)
{
	PgfReasoner* rs = gu_new(PgfReasoner, pool);
	rs->tmp_pool = gu_new_pool(),
    rs->abstract = &pgf->abstract,
	rs->table = gu_map_type_new(PgfAbswersMap, rs->tmp_pool),
	rs->pqueue  = gu_new_buf(PgfExprQState*, rs->tmp_pool);
	rs->en.next = pgf_reasoner_enum_next;

	pgf_reasoner_predict(rs, NULL, 0, cat, pool);

	return &rs->en;
}
