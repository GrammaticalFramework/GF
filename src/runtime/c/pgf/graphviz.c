#include "data.h"
#include "graphviz.h"

static int
pgf_graphviz_abstract_tree_(PgfExpr expr, int *pid,
                            GuWriter* wtr, GuExn* err)
{
	int id = -1;

	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS:
		gu_impossible();
		break;
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		id = pgf_graphviz_abstract_tree_(app->fun, pid, wtr, err);
		int arg_id = pgf_graphviz_abstract_tree_(app->arg, pid, wtr, err);
		gu_printf(wtr, err, "n%d -- n%d [style = \"solid\"]\n", id, arg_id);
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* lit = ei.data;
		id = (*pid)++;
		gu_printf(wtr, err, "n%d[label = \"", id);
		
		GuVariantInfo ei = gu_variant_open(lit->lit);
		switch (ei.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lit = ei.data;
			gu_puts("\\\"", wtr, err);
			gu_string_write(lit->val, wtr, err);
			gu_puts("\\\"", wtr, err);
			break;
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lit = ei.data;
			gu_printf(wtr, err, "%d", lit->val);
			break;
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lit = ei.data;
			gu_printf(wtr, err, "%lf", lit->val);
			break;
		}
		default:
			gu_impossible();
		}

		gu_puts("\", style = \"solid\", shape = \"plaintext\"]\n", wtr, err);
		break;
	}
	case PGF_EXPR_META:
		id = (*pid)++;
		gu_printf(wtr, err, "n%d[label = \"?\", style = \"solid\", shape = \"plaintext\"]\n", id);
		break;
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;
		id = (*pid)++;
		gu_printf(wtr, err, "n%d[label = \"", id);
		gu_string_write(fun->fun, wtr, err);
		gu_puts("\", style = \"solid\", shape = \"plaintext\"]\n", wtr, err);
		break;
	}
	case PGF_EXPR_VAR:
		gu_impossible();
		break;
	case PGF_EXPR_TYPED: {
		PgfExprTyped* typed = ei.data;
		id = pgf_graphviz_abstract_tree_(typed->expr, pid, wtr, err);
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* implarg = ei.data;
		id = pgf_graphviz_abstract_tree_(implarg->expr, pid, wtr, err);
		break;
	}
	default:
		gu_impossible();
	}

	return id;
}

void
pgf_graphviz_abstract_tree(PgfExpr expr, GuWriter* wtr, GuExn* err)
{
	int id = 0;

	gu_puts("graph {\n", wtr, err);
	pgf_graphviz_abstract_tree_(expr, &id, wtr, err);
	gu_puts("}", wtr, err);
}
