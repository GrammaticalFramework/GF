#include "pgf.h"
#include <gu/assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>


PgfExpr
pgf_expr_unwrap(PgfExpr expr)
{
	while (true) {
		GuVariantInfo i = gu_variant_open(expr);
		switch (i.tag) {
		case PGF_EXPR_IMPL_ARG: {
			PgfExprImplArg* eimpl = i.data;
			expr = eimpl->expr;
			break;
		}
		case PGF_EXPR_TYPED: {
			PgfExprTyped* etyped = i.data;
			expr = etyped->expr;
			break;
		}
		default:
			return expr;
		}
	}
}

int
pgf_expr_arity(PgfExpr expr)
{
	int n = 0;
	while (true) {
		PgfExpr e = pgf_expr_unwrap(expr);
		GuVariantInfo i = gu_variant_open(e);
		switch (i.tag) {
		case PGF_EXPR_APP: {
			PgfExprApp* app = i.data;
			expr = app->fun;
			n = n + 1;
			break;
		}
		case PGF_EXPR_FUN:
			return n;
		default:
			return -1;
		}
	}
}

PgfApplication*
pgf_expr_unapply(PgfExpr expr, GuPool* pool)
{
	int arity = pgf_expr_arity(expr);
	if (arity < 0) {
		return NULL;
	}
	PgfApplication* appl = gu_new_flex(pool, PgfApplication, args, arity);
	appl->n_args = arity;
	for (int n = arity - 1; n >= 0; n--) {
		PgfExpr e = pgf_expr_unwrap(expr);
		gu_assert(gu_variant_tag(e) == PGF_EXPR_APP);
		PgfExprApp* app = gu_variant_data(e);
		appl->args[n] = app->arg;
		expr = app->fun;
	}
	PgfExpr e = pgf_expr_unwrap(expr);
	gu_assert(gu_variant_tag(e) == PGF_EXPR_FUN);
	PgfExprFun* fun = gu_variant_data(e);
	appl->fun = fun->fun;
	return appl;
}

GU_DEFINE_TYPE(PgfBindType, enum,
	       GU_ENUM_C(PgfBindType, PGF_BIND_TYPE_EXPLICIT),
	       GU_ENUM_C(PgfBindType, PGF_BIND_TYPE_IMPLICIT));

GU_DEFINE_TYPE(PgfLiteral, GuVariant,
	       GU_CONSTRUCTOR_S(PGF_LITERAL_STR, PgfLiteralStr,
				GU_MEMBER(PgfLiteralStr, val, GuString)),
	       GU_CONSTRUCTOR_S(PGF_LITERAL_INT, PgfLiteralInt,
				GU_MEMBER(PgfLiteralInt, val, int)),
	       GU_CONSTRUCTOR_S(PGF_LITERAL_FLT, PgfLiteralFlt,
				GU_MEMBER(PgfLiteralFlt, val, double)));

GU_DECLARE_TYPE(PgfType, struct);

GU_DEFINE_TYPE(PgfHypo, struct,
	       GU_MEMBER(PgfHypo, bind_type, PgfBindType),
	       GU_MEMBER(PgfHypo, cid, PgfCId),
	       GU_MEMBER_P(PgfHypo, type, PgfType));

GU_DEFINE_TYPE(PgfHypos, GuSeq, gu_type(PgfHypo));

GU_DEFINE_TYPE(PgfType, struct,
	       GU_MEMBER(PgfType, hypos, PgfHypos),
	       GU_MEMBER(PgfType, cid, PgfCId),
	       GU_MEMBER(PgfType, n_exprs, GuLength),
	       GU_FLEX_MEMBER(PgfType, exprs, PgfExpr));

GU_DEFINE_TYPE(
	PgfExpr, GuVariant,
	GU_CONSTRUCTOR_S(
		PGF_EXPR_ABS, PgfExprAbs,
		GU_MEMBER(PgfExprAbs, bind_type, PgfBindType),
		GU_MEMBER(PgfExprAbs, id, GuStr),
		GU_MEMBER(PgfExprAbs, body, PgfExpr)),
	GU_CONSTRUCTOR_S(
		PGF_EXPR_APP, PgfExprApp,
		GU_MEMBER(PgfExprApp, fun, PgfExpr),
		GU_MEMBER(PgfExprApp, arg, PgfExpr)),
	GU_CONSTRUCTOR_S(
		PGF_EXPR_LIT, PgfExprLit, 
		GU_MEMBER(PgfExprLit, lit, PgfLiteral)),
	GU_CONSTRUCTOR_S(
		PGF_EXPR_META, PgfExprMeta,
		GU_MEMBER(PgfExprMeta, id, int)),
	GU_CONSTRUCTOR_S(
		PGF_EXPR_FUN, PgfExprFun,
		GU_MEMBER(PgfExprFun, fun, GuString)),
	GU_CONSTRUCTOR_S(
		PGF_EXPR_VAR, PgfExprVar,
		GU_MEMBER(PgfExprVar, var, int)),
	GU_CONSTRUCTOR_S(
		PGF_EXPR_TYPED, PgfExprTyped,
		GU_MEMBER(PgfExprTyped, expr, PgfExpr),
		GU_MEMBER_P(PgfExprTyped, type, PgfType)),
	GU_CONSTRUCTOR_S(
		PGF_EXPR_IMPL_ARG, PgfExprImplArg,
		GU_MEMBER(PgfExprImplArg, expr, PgfExpr)));


typedef struct PgfExprParser PgfExprParser;

typedef enum {
	PGF_TOKEN_LPAR,
	PGF_TOKEN_RPAR,
	PGF_TOKEN_LCURLY,
	PGF_TOKEN_RCURLY,
	PGF_TOKEN_QUESTION,
	PGF_TOKEN_LAMBDA,
	PGF_TOKEN_RARROW,
	PGF_TOKEN_LTRIANGLE,
	PGF_TOKEN_RTRIANGLE,
	PGF_TOKEN_COMMA,
	PGF_TOKEN_COLON,
	PGF_TOKEN_WILD,
	PGF_TOKEN_IDENT,
	PGF_TOKEN_INT,
	PGF_TOKEN_FLT,
	PGF_TOKEN_STR,
	PGF_TOKEN_UNKNOWN,
	PGF_TOKEN_EOF,
} PGF_TOKEN_TAG;

struct PgfExprParser {
	GuExn* err;
	GuIn* in;
	GuPool* expr_pool;
	GuPool* tmp_pool;
	PGF_TOKEN_TAG token_tag;
	GuChars token_value;
	int ch;
};

static void
pgf_expr_parser_getc(PgfExprParser* parser)
{
	parser->ch = gu_in_u8(parser->in, parser->err);
	if (!gu_ok(parser->err)) {
		gu_exn_clear(parser->err);
		parser->ch = EOF;
	}
}

static void
pgf_expr_parser_token(PgfExprParser* parser)
{
	while (isspace(parser->ch)) {
		pgf_expr_parser_getc(parser);
	}

	parser->token_tag   = PGF_TOKEN_UNKNOWN;
	parser->token_value = gu_null_seq;

	switch (parser->ch) {
	case EOF:
		parser->token_tag = PGF_TOKEN_EOF;
		break;
	case '(':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_LPAR;
		break;
	case ')':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_RPAR;
		break;
	case '{':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_LCURLY;
		break;
	case '}':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_RCURLY;
		break;
	case '<':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_LTRIANGLE;
		break;
	case '>':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_RTRIANGLE;
		break;
	case '?':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_QUESTION;
		break;
	case '\\':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_LAMBDA;
		break;
	case '-':
		pgf_expr_parser_getc(parser);
		if (parser->ch == '>') {
			pgf_expr_parser_getc(parser);
			parser->token_tag = PGF_TOKEN_RARROW;
		}
		break;
	case ',':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_COMMA;
		break;
	case ':':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_COLON;
		break;
	case '_':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_WILD;
		break;
	default: {
		GuCharBuf* chars = gu_new_buf(char, parser->tmp_pool);

		if (isalpha(parser->ch)) {
			while (isalnum(parser->ch) || 
			       parser->ch == '_' || 
			       parser->ch == '\'') {
				gu_buf_push(chars, char, parser->ch);
				pgf_expr_parser_getc(parser);
			}
			parser->token_tag   = PGF_TOKEN_IDENT;
			parser->token_value = gu_buf_seq(chars);
		} else if (isdigit(parser->ch)) {
			while (isdigit(parser->ch)) {
				gu_buf_push(chars, char, parser->ch);
				pgf_expr_parser_getc(parser);
			}
			
			if (parser->ch == '.') {
				gu_buf_push(chars, char, parser->ch);
				pgf_expr_parser_getc(parser);
				
				while (isdigit(parser->ch)) {
					gu_buf_push(chars, char, parser->ch);
					pgf_expr_parser_getc(parser);
				}
				parser->token_tag   = PGF_TOKEN_FLT;
				parser->token_value = gu_buf_seq(chars);
			} else {
				parser->token_tag   = PGF_TOKEN_INT;
				parser->token_value = gu_buf_seq(chars);
			}
		} else if (parser->ch == '"') {
			pgf_expr_parser_getc(parser);
			
			while (parser->ch != '"' && parser->ch != EOF) {
				gu_buf_push(chars, char, parser->ch);
				pgf_expr_parser_getc(parser);
			}
			
			if (parser->ch == '"') {
				pgf_expr_parser_getc(parser);
				parser->token_tag   = PGF_TOKEN_STR;
				parser->token_value = gu_buf_seq(chars);
			}
		}
		break;
	}
	}
}

static bool
pgf_expr_parser_lookahead(PgfExprParser* parser, int ch)
{
	while (isspace(parser->ch)) {
		pgf_expr_parser_getc(parser);
	}
	
	return (parser->ch == ch);
}

static PgfExpr
pgf_expr_parser_expr(PgfExprParser* parser);

static PgfType*
pgf_expr_parser_type(PgfExprParser* parser);

static PgfExpr
pgf_expr_parser_term(PgfExprParser* parser)
{
	switch (parser->token_tag) {
	case PGF_TOKEN_LPAR: {
		pgf_expr_parser_token(parser);
		PgfExpr expr = pgf_expr_parser_expr(parser);
		if (parser->token_tag == PGF_TOKEN_RPAR) {
			pgf_expr_parser_token(parser);
			return expr;
		} else {
			return gu_null_variant;
		}
	}
	case PGF_TOKEN_LTRIANGLE: {
		pgf_expr_parser_token(parser);
		PgfExpr expr = pgf_expr_parser_expr(parser);
		
		if (parser->token_tag != PGF_TOKEN_COLON) {
			return gu_null_variant;
		}
		pgf_expr_parser_token(parser);

		PgfType* type = pgf_expr_parser_type(parser);

		if (parser->token_tag != PGF_TOKEN_RTRIANGLE) {
			return gu_null_variant;
		}
		pgf_expr_parser_token(parser);

		return gu_new_variant_i(parser->expr_pool,
					PGF_EXPR_TYPED,
					PgfExprTyped,
					expr, type);
	}
	case PGF_TOKEN_QUESTION: {
		pgf_expr_parser_token(parser);
		return gu_new_variant_i(parser->expr_pool,
					            PGF_EXPR_META,
					            PgfExprMeta,
					            0);
	}
	case PGF_TOKEN_IDENT: {
		char* str = 
			gu_chars_str(parser->token_value, parser->tmp_pool);
		PgfCId id = gu_str_string(str, parser->expr_pool);
		pgf_expr_parser_token(parser);
		return gu_new_variant_i(parser->expr_pool,
					PGF_EXPR_FUN,
					PgfExprFun,
					id);
	}
	case PGF_TOKEN_INT: {
		char* str = 
			gu_chars_str(parser->token_value, parser->tmp_pool);
		int n = atoi(str);
		pgf_expr_parser_token(parser);
		PgfLiteral lit = 
			gu_new_variant_i(parser->expr_pool,
			                 PGF_LITERAL_INT,
			                 PgfLiteralInt,
			                 n);
		return gu_new_variant_i(parser->expr_pool,
					PGF_EXPR_LIT,
					PgfExprLit,
					lit);
	}
	case PGF_TOKEN_STR: {
		char* str =
			gu_chars_str(parser->token_value, parser->tmp_pool);
		GuString s = gu_str_string(str, parser->expr_pool);
		pgf_expr_parser_token(parser);
		PgfLiteral lit = 
			gu_new_variant_i(parser->expr_pool,
			                 PGF_LITERAL_STR,
			                 PgfLiteralStr,
			                 s);
		return gu_new_variant_i(parser->expr_pool,
					PGF_EXPR_LIT,
					PgfExprLit,
					lit);
	}
	case PGF_TOKEN_FLT: {
		char* str = 
			gu_chars_str(parser->token_value, parser->tmp_pool);
		double d = atof(str);
		pgf_expr_parser_token(parser);
		PgfLiteral lit = 
			gu_new_variant_i(parser->expr_pool,
			                 PGF_LITERAL_FLT,
			                 PgfLiteralFlt,
			                 d);
		return gu_new_variant_i(parser->expr_pool,
					PGF_EXPR_LIT,
					PgfExprLit,
					lit);
	}
	default:
		return gu_null_variant;
	}
}

static PgfExpr
pgf_expr_parser_arg(PgfExprParser* parser)
{
	PgfExpr arg;

	if (parser->token_tag == PGF_TOKEN_LCURLY) {
		pgf_expr_parser_token(parser);

		arg = pgf_expr_parser_expr(parser);
		if (gu_variant_is_null(arg))
			return gu_null_variant;

		if (parser->token_tag != PGF_TOKEN_RCURLY) {
			return gu_null_variant;
		}

		pgf_expr_parser_token(parser);

		arg = gu_new_variant_i(parser->expr_pool,
				  PGF_EXPR_IMPL_ARG,
				  PgfExprImplArg,
				  arg);
	} else {
		arg = pgf_expr_parser_term(parser);
	}

	return arg;
}

static bool
pgf_expr_parser_bind(PgfExprParser* parser, GuBuf* binds)
{
	PgfCId var;
	PgfBindType bind_type = PGF_BIND_TYPE_EXPLICIT;

	if (parser->token_tag == PGF_TOKEN_LCURLY) {
		bind_type = PGF_BIND_TYPE_IMPLICIT;
		pgf_expr_parser_token(parser);
	}

	for (;;) {
		if (parser->token_tag == PGF_TOKEN_IDENT) {
			char* str = 
				gu_chars_str(parser->token_value, parser->tmp_pool);
			var = gu_str_string(str, parser->expr_pool);
			pgf_expr_parser_token(parser);
		} else if (parser->token_tag == PGF_TOKEN_WILD) {
			var = gu_str_string("_", parser->expr_pool);
			pgf_expr_parser_token(parser);
		} else {
			return false;
		}

		PgfExpr bind =
			gu_new_variant_i(parser->expr_pool,
								PGF_EXPR_ABS,
								PgfExprAbs,
								bind_type,
								var,
								gu_null_variant);
		gu_buf_push(binds, PgfExpr, bind);
		
		if (bind_type == PGF_BIND_TYPE_EXPLICIT ||
		    parser->token_tag != PGF_TOKEN_COMMA) {
			break;
		}
		
		pgf_expr_parser_token(parser);
	}

	if (bind_type == PGF_BIND_TYPE_IMPLICIT) {
		if (parser->token_tag != PGF_TOKEN_RCURLY)
			return false;
		pgf_expr_parser_token(parser);
	}

	return true;
}

static GuBuf*
pgf_expr_parser_binds(PgfExprParser* parser)
{
	GuBuf* binds = gu_new_buf(PgfExpr, parser->tmp_pool);

	for (;;) {
		if (!pgf_expr_parser_bind(parser, binds))
			return NULL;

		if (parser->token_tag != PGF_TOKEN_COMMA)
			break;

		pgf_expr_parser_token(parser);
	}

	return binds;
}

static PgfExpr
pgf_expr_parser_expr(PgfExprParser* parser)
{
	if (parser->token_tag == PGF_TOKEN_LAMBDA) {
		pgf_expr_parser_token(parser);
		GuBuf* binds = pgf_expr_parser_binds(parser);
		if (binds == NULL)
			return gu_null_variant;

		if (parser->token_tag != PGF_TOKEN_RARROW) {
			return gu_null_variant;
		}
		pgf_expr_parser_token(parser);

		PgfExpr expr = pgf_expr_parser_expr(parser);
		if (gu_variant_is_null(expr))
			return gu_null_variant;

		size_t n_binds = gu_buf_length(binds);
		for (size_t i = n_binds; i > 0; i--) {
			PgfExpr bind = gu_buf_get(binds, PgfExpr, i-1);

			((PgfExprAbs*) gu_variant_data(bind))->body = expr;
			expr = bind;
		}

		return expr;
	} else {
		PgfExpr expr = pgf_expr_parser_term(parser);
		if (gu_variant_is_null(expr))
			return gu_null_variant;

		while (parser->token_tag != PGF_TOKEN_EOF &&
		       parser->token_tag != PGF_TOKEN_RPAR &&
		       parser->token_tag != PGF_TOKEN_RCURLY &&
		       parser->token_tag != PGF_TOKEN_RTRIANGLE &&
		       parser->token_tag != PGF_TOKEN_COLON) {
			PgfExpr arg = pgf_expr_parser_arg(parser);
			if (gu_variant_is_null(arg))
				return gu_null_variant;

			expr = gu_new_variant_i(parser->expr_pool,
						PGF_EXPR_APP,
						PgfExprApp,
						expr, arg);
		}
		
		return expr;
	}
}

static bool
pgf_expr_parser_hypos(PgfExprParser* parser, GuBuf* hypos)
{
	PgfCId var;
	PgfBindType bind_type = PGF_BIND_TYPE_EXPLICIT;

	for (;;) {
		if (bind_type == PGF_BIND_TYPE_EXPLICIT &&
		    parser->token_tag == PGF_TOKEN_LCURLY) {
			bind_type = PGF_BIND_TYPE_IMPLICIT;
			pgf_expr_parser_token(parser);
		}

		if (parser->token_tag == PGF_TOKEN_IDENT) {
			char* str = 
				gu_chars_str(parser->token_value, parser->tmp_pool);
			var = gu_str_string(str, parser->expr_pool);
			pgf_expr_parser_token(parser);
		} else if (parser->token_tag == PGF_TOKEN_WILD) {
			var = gu_str_string("_", parser->expr_pool);
			pgf_expr_parser_token(parser);
		} else {
			return false;
		}

		PgfHypo* hypo = gu_buf_extend(hypos);
		hypo->bind_type = bind_type;
		hypo->cid = var;
		hypo->type = NULL;

		if (bind_type == PGF_BIND_TYPE_IMPLICIT &&
			parser->token_tag == PGF_TOKEN_RCURLY) {
			bind_type = PGF_BIND_TYPE_EXPLICIT;
			pgf_expr_parser_token(parser);
		}

		if (parser->token_tag != PGF_TOKEN_COMMA) {
			break;
		}
		
		pgf_expr_parser_token(parser);
	}

	if (bind_type == PGF_BIND_TYPE_IMPLICIT)
		return false;

	return true;
}

static PgfType*
pgf_expr_parser_atom(PgfExprParser* parser)
{
	if (parser->token_tag != PGF_TOKEN_IDENT)
		return NULL;

	char* str =
		gu_chars_str(parser->token_value, parser->tmp_pool);
	PgfCId cid = gu_str_string(str, parser->expr_pool);
	pgf_expr_parser_token(parser);

	GuBuf* args = gu_new_buf(PgfExpr, parser->tmp_pool);
	while (parser->token_tag != PGF_TOKEN_EOF &&
		   parser->token_tag != PGF_TOKEN_RPAR &&
		   parser->token_tag != PGF_TOKEN_RTRIANGLE &&
		   parser->token_tag != PGF_TOKEN_RARROW) {
		PgfExpr arg =
			pgf_expr_parser_arg(parser);
		if (gu_variant_is_null(arg))
			return NULL;
			
		gu_buf_push(args, PgfExpr, arg);
	}

	size_t n_exprs = gu_buf_length(args);

	PgfType* type = gu_new_flex(parser->expr_pool, PgfType, exprs, n_exprs);
	type->hypos   = gu_empty_seq();
	type->cid     = cid;
	type->n_exprs = n_exprs;

	for (size_t i = 0; i < n_exprs; i++) {
		type->exprs[i] = gu_buf_get(args, PgfExpr, i);
	}
	
	return type;
}

static PgfType*
pgf_expr_parser_type(PgfExprParser* parser)
{
	PgfType* type = NULL;
	GuBuf* hypos = gu_new_buf(PgfHypo, parser->expr_pool);

	for (;;) {
		if (parser->token_tag == PGF_TOKEN_LPAR) {
			pgf_expr_parser_token(parser);

			size_t n_start = gu_buf_length(hypos);

			if ((parser->token_tag == PGF_TOKEN_IDENT &&
			     (pgf_expr_parser_lookahead(parser, ',') || 
				  pgf_expr_parser_lookahead(parser, ':'))) ||
				(parser->token_tag == PGF_TOKEN_LCURLY) ||
				(parser->token_tag == PGF_TOKEN_WILD)) {

				if (!pgf_expr_parser_hypos(parser, hypos))
					return NULL;

				if (parser->token_tag != PGF_TOKEN_COLON)
					return NULL;

				pgf_expr_parser_token(parser);
			} else {
				PgfHypo* hypo = gu_buf_extend(hypos);
				hypo->bind_type = PGF_BIND_TYPE_EXPLICIT;
				hypo->cid = gu_str_string("_", parser->expr_pool);
				hypo->type = NULL;
			}

			size_t n_end = gu_buf_length(hypos);

			PgfType* type = pgf_expr_parser_type(parser);
			if (type == NULL)
				return NULL;

			if (parser->token_tag != PGF_TOKEN_RPAR)
				return NULL;

			pgf_expr_parser_token(parser);

			if (parser->token_tag != PGF_TOKEN_RARROW)
				return NULL;

			pgf_expr_parser_token(parser);
			
			for (size_t i = n_start; i < n_end; i++) {
				PgfHypo* hypo = gu_buf_index(hypos, PgfHypo, i);
				hypo->type = type;
			}
		} else {
			type = pgf_expr_parser_atom(parser);
			if (type == NULL)
				return NULL;

			if (parser->token_tag != PGF_TOKEN_RARROW)
				break;

			pgf_expr_parser_token(parser);

			PgfHypo* hypo = gu_buf_extend(hypos);
			hypo->bind_type = PGF_BIND_TYPE_EXPLICIT;
			hypo->cid = gu_str_string("_", parser->expr_pool);
			hypo->type = type;
		}
	}

	type->hypos = gu_buf_seq(hypos);

	return type;
}

static PgfExprParser*
pgf_new_parser(GuIn* in, GuPool* pool, GuPool* tmp_pool, GuExn* err)
{
	PgfExprParser* parser = gu_new(PgfExprParser, tmp_pool);
	parser->err = err;
	parser->in = in;
	parser->expr_pool = pool;
	parser->tmp_pool = tmp_pool;
	parser->ch = ' ';
	pgf_expr_parser_token(parser);
	return parser;
}

PgfExpr
pgf_read_expr(GuIn* in, GuPool* pool, GuExn* err)
{
	GuPool* tmp_pool = gu_new_pool();
	PgfExprParser* parser = 
		pgf_new_parser(in, pool, tmp_pool, err);
	PgfExpr expr = pgf_expr_parser_expr(parser);
	if (parser->token_tag != PGF_TOKEN_EOF)
		return gu_null_variant;
	gu_pool_free(tmp_pool);
	return expr;
}

PgfType*
pgf_read_type(GuIn* in, GuPool* pool, GuExn* err)
{
	GuPool* tmp_pool = gu_new_pool();
	PgfExprParser* parser = 
		pgf_new_parser(in, pool, tmp_pool, err);
	PgfType* type = pgf_expr_parser_type(parser);
	if (parser->token_tag != PGF_TOKEN_EOF)
		return NULL;
	gu_pool_free(tmp_pool);
	return type;
}

bool
pgf_literal_eq(PgfLiteral lit1, PgfLiteral lit2)
{
	GuVariantInfo ei1 = gu_variant_open(lit1);
	GuVariantInfo ei2 = gu_variant_open(lit2);
	
	if (ei1.tag != ei2.tag)
		return false;

	switch (ei1.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr* lit1 = ei1.data;
		PgfLiteralStr* lit2 = ei2.data;
        return gu_string_eq(lit1->val, lit2->val);
    }
    case PGF_LITERAL_INT: {
		PgfLiteralInt* lit1 = ei1.data;
		PgfLiteralInt* lit2 = ei2.data;
        return (lit1->val == lit2->val);
    }
	case PGF_LITERAL_FLT: {
		PgfLiteralFlt* lit1 = ei1.data;
		PgfLiteralFlt* lit2 = ei2.data;
		return (lit1->val == lit2->val);
    }
	default:
		gu_impossible();
    }
    
    return false;
}

bool
pgf_expr_eq(PgfExpr e1, PgfExpr e2)
{
	GuVariantInfo ei1 = gu_variant_open(e1);
	GuVariantInfo ei2 = gu_variant_open(e2);
	
	if (ei1.tag != ei2.tag)
		return false;

	switch (ei1.tag) {
	case PGF_EXPR_ABS: {
		PgfExprAbs* abs1 = ei1.data;
		PgfExprAbs* abs2 = ei2.data;
		return gu_string_eq(abs1->id, abs2->id) &&
		       pgf_expr_eq(abs1->body, abs2->body);
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app1 = ei1.data;
		PgfExprApp* app2 = ei2.data;
		return (pgf_expr_eq(app1->fun,app2->fun) &&
		        pgf_expr_eq(app1->arg,app2->arg));
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* lit1 = ei1.data;
		PgfExprLit* lit2 = ei2.data;
		return (pgf_literal_eq(lit1->lit,lit2->lit));
	}
	case PGF_EXPR_META: {
		PgfExprMeta* meta1 = ei1.data;
		PgfExprMeta* meta2 = ei2.data;
		return (meta1->id == meta2->id);
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* fun1 = ei1.data;
		PgfExprFun* fun2 = ei2.data;
		return gu_string_eq(fun1->fun, fun2->fun);
	}
	case PGF_EXPR_VAR: {
		PgfExprVar* var1 = ei1.data;
		PgfExprVar* var2 = ei2.data;
		return (var1->var == var2->var);
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* typed1 = ei1.data;
		PgfExprTyped* typed2 = ei2.data;
		return pgf_expr_eq(typed1->expr, typed2->expr) &&
		       pgf_type_eq(typed1->type, typed2->type);
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* impl1 = ei1.data;
		PgfExprImplArg* impl2 = ei2.data;
		return pgf_expr_eq(impl1->expr, impl2->expr);
	}
	default:
		gu_impossible();
	}
	
	return false;
}

GuHash
pgf_literal_hash(GuHash h, PgfLiteral lit)
{
	GuVariantInfo i = gu_variant_open(lit);

	switch (i.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr* lit = i.data;
        h = gu_string_hash(h, lit->val);
        break;
    }
	case PGF_LITERAL_INT: {
		PgfLiteralInt* lit = i.data;
		h = gu_hash_byte(h, lit->val);
		break;
	}
	case PGF_LITERAL_FLT: {
		PgfLiteralFlt* lit = i.data;
		h = gu_hash_byte(h, lit->val);
		break;
	}
	default:
		gu_impossible();
	}

	return h;
}

GuHash
pgf_expr_hash(GuHash h, PgfExpr e)
{
	GuVariantInfo ei = gu_variant_open(e);
	switch (ei.tag) {
	case PGF_EXPR_ABS: {
		PgfExprAbs* abs = ei.data;
		h = gu_string_hash(h, abs->id);
		h = pgf_expr_hash(h, abs->body);
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		h = pgf_expr_hash(h, app->fun);
		h = pgf_expr_hash(h, app->arg);
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* lit = ei.data;
        h = pgf_literal_hash(h, lit->lit);
		break;
	}
	case PGF_EXPR_META:
		h = gu_hash_byte(h, '?');
		break;
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;
		h = gu_string_hash(h, fun->fun);
		break;
	}
	case PGF_EXPR_VAR: {
		PgfExprVar* evar = ei.data;
		
		h = gu_hash_byte(h, evar->var);
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* typed = ei.data;
		h = pgf_expr_hash(h, typed->expr);
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* impl = ei.data;
		h = pgf_expr_hash(h, impl->expr);
		break;
	}
	default:
		gu_impossible();
	}
	return h;
}

void
pgf_print_literal(PgfLiteral lit,
			      GuOut* out, GuExn* err)
{
	GuVariantInfo ei = gu_variant_open(lit);
	switch (ei.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr* lit = ei.data;
        gu_putc('"', out, err);
		gu_string_write(lit->val, out, err);
        gu_putc('"', out, err);
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
}

void
pgf_print_expr(PgfExpr expr, PgfPrintContext* ctxt, int prec,
               GuOut* out, GuExn* err)
{
	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS: {
		PgfExprAbs* abs = ei.data;

		if (prec > 1) {
			gu_puts("(", out, err);
		}

		gu_putc('\\', out, err);
		
		PgfPrintContext* new_ctxt = ctxt;

		for (;;) {
			if (abs->bind_type == PGF_BIND_TYPE_IMPLICIT) {
				gu_putc('{', out, err);
			}
			gu_string_write(abs->id, out, err);
			if (abs->bind_type == PGF_BIND_TYPE_IMPLICIT) {
				gu_putc('}', out, err);
			}

			PgfPrintContext* c = malloc(sizeof(PgfPrintContext));
			c->name = abs->id;
			c->next = new_ctxt;
			new_ctxt = c;

			if (gu_variant_tag(abs->body) != PGF_EXPR_ABS)
				break;
				
			gu_putc(',', out, err);
			
			abs = gu_variant_data(abs->body);
		}

		gu_puts(" -> ", out, err);
		pgf_print_expr(abs->body, new_ctxt, 1, out, err);

		while (new_ctxt != ctxt) {
			PgfPrintContext* next = new_ctxt->next;
			free(new_ctxt);
			new_ctxt = next;
		}

		if (prec > 1) {
			gu_puts(")", out, err);
		}
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		if (prec > 3) {
			gu_puts("(", out, err);
		}
		pgf_print_expr(app->fun, ctxt, 3, out, err);
		gu_puts(" ", out, err);
		pgf_print_expr(app->arg, ctxt, 4, out, err);
		if (prec > 3) {
			gu_puts(")", out, err);
		}
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* lit = ei.data;
        pgf_print_literal(lit->lit, out, err);
		break;
	}
	case PGF_EXPR_META:
		gu_putc('?', out, err);
		break;
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;
		gu_string_write(fun->fun, out, err);
		break;
	}
	case PGF_EXPR_VAR: {
		PgfExprVar* evar = ei.data;
		
		int var = evar->var;
		PgfPrintContext* c = ctxt;
		while (c != NULL && var > 0) {
			c = ctxt->next;
		}
		
		if (c == NULL) {
			gu_printf(out, err, "#%d", evar->var);
		} else {
			gu_string_write(c->name, out, err);
		}
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* typed = ei.data;
		gu_putc('<', out, err);
		pgf_print_expr(typed->expr, ctxt, 0, out, err);
		gu_puts(" : ", out, err);
		pgf_print_type(typed->type, ctxt, 0, out, err);
		gu_putc('>', out, err);
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* impl = ei.data;
		gu_putc('{', out, err);
		pgf_print_expr(impl->expr, ctxt, 0, out, err);
		gu_putc('}', out, err);
		break;
	}
	default:
		gu_impossible();
	}
}

PgfPrintContext*
pgf_print_hypo(PgfHypo *hypo, PgfPrintContext* ctxt, int prec,
               GuOut *out, GuExn *err)
{
    if (hypo->bind_type == PGF_BIND_TYPE_IMPLICIT) {
        gu_puts("({", out, err);
        gu_string_write(hypo->cid, out, err);
        gu_puts("} : ", out, err);
        pgf_print_type(hypo->type, ctxt, 0, out, err);
        gu_puts(")", out, err);
    } else {
        GuPool* tmp_pool = gu_new_pool();
        GuString tmp = gu_str_string("_", tmp_pool);
        
        if (!gu_string_eq(hypo->cid, tmp)) {
            gu_puts("(", out, err);
            gu_string_write(hypo->cid, out, err);
            gu_puts(" : ", out, err);
            pgf_print_type(hypo->type, ctxt, 0, out, err);
            gu_puts(")", out, err);
        } else {
            pgf_print_type(hypo->type, ctxt, prec, out, err);
        }
        
        gu_pool_free(tmp_pool);
    }
    
	PgfPrintContext* new_ctxt = malloc(sizeof(PgfPrintContext));
	new_ctxt->name = hypo->cid;
	new_ctxt->next = ctxt;
	return new_ctxt;
}

void
pgf_print_type(PgfType *type, PgfPrintContext* ctxt, int prec,
               GuOut *out, GuExn *err)
{
    size_t n_hypos = gu_seq_length(type->hypos);
    
    if (n_hypos > 0) {
		if (prec > 0) gu_putc('(', out, err);
		
		PgfPrintContext* new_ctxt = ctxt;
		for (size_t i = 0; i < n_hypos; i++) {
			PgfHypo *hypo = gu_seq_index(type->hypos, PgfHypo, i);
			new_ctxt = pgf_print_hypo(hypo, new_ctxt, 1, out, err);

			gu_puts(" -> ", out, err);
		}

		gu_string_write(type->cid, out, err);
    
		for (size_t i = 0; i < type->n_exprs; i++) {
			gu_puts(" ", out, err);
			pgf_print_expr(type->exprs[i], new_ctxt, 4, out, err);
		}

		while (new_ctxt != ctxt) {
			PgfPrintContext* next = new_ctxt->next;
			free(new_ctxt);
			new_ctxt = next;
		}

		if (prec > 0) gu_putc(')', out, err);
	} else if (type->n_exprs > 0) {
		if (prec > 3) gu_putc('(', out, err);
		
		gu_string_write(type->cid, out, err);
    
		for (size_t i = 0; i < type->n_exprs; i++) {
			gu_puts(" ", out, err);
			pgf_print_expr(type->exprs[i], ctxt, 4, out, err);
		}
		
		if (prec > 3) gu_putc(')', out, err);
	} else {
		gu_string_write(type->cid, out, err);
	}
}

bool
pgf_type_eq(PgfType* t1, PgfType* t2)
{
	if (gu_seq_length(t1->hypos) != gu_seq_length(t2->hypos))
		return false;

	size_t n_hypos = gu_seq_length(t1->hypos);
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo *hypo1 = gu_seq_index(t1->hypos, PgfHypo, i);
		PgfHypo *hypo2 = gu_seq_index(t1->hypos, PgfHypo, i);
		
		if (hypo1->bind_type != hypo2->bind_type)
			return false;
			
		if (!gu_string_eq(hypo1->cid, hypo2->cid))
			return false;
			
		if (!pgf_type_eq(hypo1->type, hypo2->type))
			return false;
	}
    
	if (!gu_string_eq(t1->cid, t2->cid))
		return false;

	if (t1->n_exprs != t2->n_exprs)
		return false;

	for (size_t i = 0; i < t1->n_exprs; i++) {
		if (!pgf_expr_eq(t1->exprs[i], t2->exprs[i]))
			return false;
	}

	return true;
}
