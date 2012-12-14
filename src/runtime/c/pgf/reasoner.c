#include <pgf/pgf.h>
#include <pgf/data.h>
#include <math.h>
#include <stdio.h>

typedef struct PgfExprState PgfExprState;

struct PgfExprState {
	PgfExprState* cont;
	PgfExpr expr;
	PgfHypos hypos;
	size_t arg_idx;
};

typedef struct {
	PgfExprState *st;
	prob_t cont_prob;
	size_t fun_idx;
	PgfCat* abscat;
} PgfExprQState;

typedef struct {
	GuPool* tmp_pool;
	PgfAbstr* abstract;
	GuBuf* pqueue;
	PgfExprEnum en;
} PgfReasoner;

static int
cmp_expr_qstate(GuOrder* self, const void* a, const void* b)
{
	PgfExprQState *q1 = (PgfExprQState *) a;
	PgfExprQState *q2 = (PgfExprQState *) b;

	prob_t prob1 = q1->cont_prob-log(q1->abscat->functions[q1->fun_idx].prob);
	prob_t prob2 = q2->cont_prob-log(q2->abscat->functions[q2->fun_idx].prob);
	
	if (prob1 < prob2)
		return -1;
	else if (prob1 > prob2)
		return 1;
	else
		return 0;
}

static GuOrder
pgf_expr_qstate_order = { cmp_expr_qstate };

static bool
pgf_reasoner_cat_init(PgfReasoner* rs, 
                      PgfExprState* cont, prob_t cont_prob, PgfCId cat,
                      GuPool* pool)
{
	// Checking for loops in the chart
	if (cont != NULL) {
		PgfExprState* st = cont->cont;
		while (st != NULL) {
			PgfHypo* hypo = gu_seq_index(st->hypos, PgfHypo, st->arg_idx);
			if (gu_string_eq(hypo->type->cid, cat))
				return false;

			st = st->cont;
		}
	}

	PgfCat* abscat = gu_map_get(rs->abstract->cats, &cat, PgfCat*);
	if (abscat == NULL) {
		return false;
	}

	PgfExprQState q = {cont, cont_prob, 0, abscat};
	gu_buf_heap_push(rs->pqueue, &pgf_expr_qstate_order, &q);	
	return true;
}

static PgfExprProb*
pgf_reasoner_next(PgfReasoner* rs, GuPool* pool)
{
	if (rs->pqueue == NULL)
		return NULL;

	while (gu_buf_length(rs->pqueue) > 0) {
		PgfExprQState q;
		gu_buf_heap_pop(rs->pqueue, &pgf_expr_qstate_order, &q);

		PgfCId fun = q.abscat->functions[q.fun_idx++].fun;
		PgfFunDecl* absfun =
			gu_map_get(rs->abstract->funs, &fun, PgfFunDecl*);

		if (q.fun_idx < q.abscat->n_functions) {
			gu_buf_heap_push(rs->pqueue, &pgf_expr_qstate_order, &q);
		}

		if (absfun == NULL)
			continue;

		PgfExprState *st = gu_new(PgfExprState, rs->tmp_pool);
		st->cont = q.st;
		st->expr =
			gu_new_variant_i(pool, PGF_EXPR_FUN,
							 PgfExprFun,
							 .fun = fun);
		st->hypos = absfun->type->hypos;
		st->arg_idx = 0;

		for (;;) {
			prob_t prob = q.cont_prob+absfun->ep.prob;

			if (st->arg_idx < gu_seq_length(st->hypos)) {
				PgfHypo *hypo = gu_seq_index(st->hypos, PgfHypo, st->arg_idx);
				pgf_reasoner_cat_init(rs, st, prob,
									  hypo->type->cid, pool);
				break;
			} else {
				PgfExprState* cont = st->cont;
				if (cont == NULL) {
					PgfExprProb* ep = gu_new(PgfExprProb, pool);
					ep->expr = st->expr;
					ep->prob = prob;
					return ep;
				}

				st->cont = cont->cont;
				st->expr =
					gu_new_variant_i(pool, PGF_EXPR_APP,
							PgfExprApp,
							.fun = cont->expr, .arg = st->expr);
				st->hypos = cont->hypos;
				st->arg_idx = cont->arg_idx+1;
			}
		}
	}

	gu_pool_free(rs->tmp_pool);
	rs->tmp_pool = NULL;
	rs->pqueue = NULL;
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
	GuPool* tmp_pool = gu_new_pool();
	GuBuf* pqueue = gu_new_buf(PgfExprQState, tmp_pool);

	PgfReasoner* rs =
           gu_new_i(pool, PgfReasoner,
			 .tmp_pool = tmp_pool,
             .abstract = &pgf->abstract,
			 .pqueue = pqueue,
			 .en.next = pgf_reasoner_enum_next);

	pgf_reasoner_cat_init(rs, NULL, 0, cat, pool);

	return &rs->en;
}
