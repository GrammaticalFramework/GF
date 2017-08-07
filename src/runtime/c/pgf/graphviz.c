#include "data.h"
#include "graphviz.h"
#include "linearizer.h"

static int
pgf_graphviz_abstract_tree_(PgfExpr expr, int *pid,
                            GuOut* out, GuExn* err)
{
	int id = -1;

	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS:
		gu_impossible();
		break;
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		id = pgf_graphviz_abstract_tree_(app->fun, pid, out, err);
		int arg_id = pgf_graphviz_abstract_tree_(app->arg, pid, out, err);
		gu_printf(out, err, "n%d -- n%d [style = \"solid\"]\n", id, arg_id);
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* lit = ei.data;
		id = (*pid)++;
		gu_printf(out, err, "n%d[label = \"", id);
		
		GuVariantInfo ei = gu_variant_open(lit->lit);
		switch (ei.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lit = ei.data;
			gu_puts("\\\"", out, err);
			gu_string_write(lit->val, out, err);
			gu_puts("\\\"", out, err);
			break;
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lit = ei.data;
			gu_printf(out, err, "%d", lit->val);
			break;
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lit = ei.data;
			gu_printf(out, err, "%lf", lit->val);
			break;
		}
		default:
			gu_impossible();
		}

		gu_puts("\", style = \"solid\", shape = \"plaintext\"]\n", out, err);
		break;
	}
	case PGF_EXPR_META:
		id = (*pid)++;
		gu_printf(out, err, "n%d[label = \"?\", style = \"solid\", shape = \"plaintext\"]\n", id);
		break;
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;
		id = (*pid)++;
		gu_printf(out, err, "n%d[label = \"", id);
		gu_string_write(fun->fun, out, err);
		gu_puts("\", style = \"solid\", shape = \"plaintext\"]\n", out, err);
		break;
	}
	case PGF_EXPR_VAR:
		gu_impossible();
		break;
	case PGF_EXPR_TYPED: {
		PgfExprTyped* typed = ei.data;
		id = pgf_graphviz_abstract_tree_(typed->expr, pid, out, err);
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* implarg = ei.data;
		id = pgf_graphviz_abstract_tree_(implarg->expr, pid, out, err);
		break;
	}
	default:
		gu_impossible();
	}

	return id;
}

PGF_API void
pgf_graphviz_abstract_tree(PgfPGF* pgf, PgfExpr expr, GuOut* out, GuExn* err)
{
	int id = 0;

	gu_puts("graph {\n", out, err);
	pgf_graphviz_abstract_tree_(expr, &id, out, err);
	gu_puts("}", out, err);
}

typedef struct PgfParseNode PgfParseNode;
	
struct PgfParseNode {
	int id;
	PgfParseNode* parent;
	GuString label;
};

typedef struct {
	PgfLinFuncs* funcs;

	GuPool* pool;
	GuOut* out;
	GuExn* err;
	
	PgfParseNode* parent;
	size_t level;
	GuBuf* internals;
	GuBuf* leaves;
} PgfBracketLznState;

static void
pgf_bracket_lzn_symbol_token(PgfLinFuncs** funcs, PgfToken tok)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);

	PgfParseNode* node = gu_new(PgfParseNode, state->pool);
	node->id     = 100000 + gu_buf_length(state->leaves);
	node->parent = state->parent;
	node->label  = tok;
	gu_buf_push(state->leaves, PgfParseNode*, node);
}

static void
pgf_bracket_lzn_begin_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);

	if (strcmp(cat, "_") == 0)
		return;
	
	state->level++;

	GuBuf* level;
	if (state->level < gu_buf_length(state->internals))
		level = gu_buf_get(state->internals, GuBuf*, state->level);
	else {
		level = gu_new_buf(PgfParseNode*, state->pool);
		gu_buf_push(state->internals, GuBuf*, level);
	}

	size_t len = gu_buf_length(level);
	for (size_t i = 0; i < len; i++) {
		PgfParseNode* node = gu_buf_get(level, PgfParseNode*, i);
		if (node->id == fid) {
			state->parent = node;
			return;
		}
	}
	
	PgfParseNode* node = gu_new(PgfParseNode, state->pool);
	node->id     = fid;
	node->parent = state->parent;
	node->label  = cat;
	gu_buf_push(level, PgfParseNode*, node);

	state->parent = node;
}

static void
pgf_bracket_lzn_end_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);

	if (strcmp(cat, "_") == 0)
		return;

	state->level--;
	state->parent = state->parent->parent;
}

static void
pgf_bracket_lzn_symbol_meta(PgfLinFuncs** funcs, PgfMetaId meta_id)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);

	PgfParseNode* node = gu_new(PgfParseNode, state->pool);
	node->id     = 100000 + gu_buf_length(state->leaves);
	node->parent = state->parent;
	node->label  = "?";
	gu_buf_push(state->leaves, PgfParseNode*, node);
}

static PgfLinFuncs pgf_bracket_lin_funcs = {
	.symbol_token  = pgf_bracket_lzn_symbol_token,
	.begin_phrase  = pgf_bracket_lzn_begin_phrase,
	.end_phrase    = pgf_bracket_lzn_end_phrase,
	.symbol_ne     = NULL,
	.symbol_bind   = NULL,
	.symbol_capit  = NULL,
	.symbol_meta   = pgf_bracket_lzn_symbol_meta
};

static void
pgf_graphviz_parse_level(GuBuf* level, GuOut* out, GuExn* err)
{
	gu_puts("\n  subgraph {rank=same;\n", out, err);

	size_t len = gu_buf_length(level);
	
	if (len > 1)
		gu_puts("    edge[style=invis]\n", out, err);

	for (size_t i = 0; i < len; i++) {
		PgfParseNode* node = gu_buf_get(level, PgfParseNode*, i);
		gu_printf(out, err, "    n%d[label=\"", node->id);
		gu_string_write(node->label, out, err);
		gu_puts("\"]\n", out, err);		
	}
	
	if (len > 1) {
		for (size_t i = 0; i < len; i++) {
			PgfParseNode* node = gu_buf_get(level, PgfParseNode*, i);		
		
			gu_puts((i == 0) ? "    " : " -- ", out, err);
			gu_printf(out, err, "n%d", node->id);
		}
		gu_puts("\n", out, err);
	}
	
	gu_puts("  }\n", out, err);

	for (size_t i = 0; i < len; i++) {
		PgfParseNode* node = gu_buf_get(level, PgfParseNode*, i);		
		if (node->parent != NULL)
			gu_printf(out, err, "  n%d -- n%d\n", node->parent->id, node->id);
	}
}

PGF_API void
pgf_graphviz_parse_tree(PgfConcr* concr, PgfExpr expr, GuOut* out, GuExn* err)
{
	GuPool* tmp_pool = gu_local_pool();
	
	GuEnum* cts = 
		pgf_lzr_concretize(concr, expr, err, tmp_pool);
	if (!gu_ok(err))
		return;

	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (gu_variant_is_null(ctree)) {
		gu_pool_free(tmp_pool);
		return;
	}

	gu_puts("graph {\n", out, err);
	gu_puts("  node[shape=plaintext]\n", out, err);

	PgfBracketLznState state;
	state.funcs = &pgf_bracket_lin_funcs;
	state.pool = tmp_pool;
	state.out = out;
	state.err = err;

	state.parent    = NULL;
	state.level     = -1;
	state.internals = gu_new_buf(GuBuf*, tmp_pool);
	state.leaves    = gu_new_buf(PgfParseNode*, tmp_pool);
	pgf_lzr_linearize(concr, ctree, 0, &state.funcs, tmp_pool);

	size_t len = gu_buf_length(state.internals);
	for (size_t i = 0; i < len; i++) {
		GuBuf* level = gu_buf_get(state.internals, GuBuf*, i);
		pgf_graphviz_parse_level(level, out, err);
	}
	pgf_graphviz_parse_level(state.leaves, out, err);

	gu_puts("}", out, err);

	gu_pool_free(tmp_pool);
}
