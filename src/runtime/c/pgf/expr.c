#include "pgf.h"
#include "data.h"
#include <gu/assert.h>
#include <gu/utf8.h>
#include <gu/seq.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

static PgfExpr
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

PGF_API int
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

PGF_API PgfApplication*
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

PGF_API PgfExpr
pgf_expr_apply(PgfApplication* app, GuPool* pool)
{
	PgfExpr expr;

	size_t len = strlen(app->fun);
	PgfExprFun *efun =
		gu_new_flex_variant(PGF_EXPR_FUN,
					        PgfExprFun,
					        fun, len+1,
					        &expr, pool);
	strcpy(efun->fun, app->fun);

	for (int i = 0; i < app->n_args; i++) {
		expr = gu_new_variant_i(pool, 
				                PGF_EXPR_APP, PgfExprApp,
						        .fun = expr,
						        .arg = app->args[i]);
	}
	
	return expr;
}

PGF_API PgfExpr
pgf_expr_abs(PgfBindType bind_type, PgfCId id, PgfExpr body, GuPool* pool)
{
	return gu_new_variant_i(pool, 
				            PGF_EXPR_ABS, PgfExprAbs,
						    .bind_type = bind_type,
						    .id = id,
						    .body = body);
}

PGF_API PgfExprAbs*
pgf_expr_unabs(PgfExpr expr)
{
	GuVariantInfo i = gu_variant_open(expr);
	if (i.tag == PGF_EXPR_ABS) {
		return (PgfExprAbs*) i.data;
	}

	return NULL;
}

PGF_API PgfExpr
pgf_expr_meta(int id, GuPool* pool)
{
	return gu_new_variant_i(pool, 
				            PGF_EXPR_META, PgfExprMeta,
						    .id = id);
}

PGF_API PgfExprMeta*
pgf_expr_unmeta(PgfExpr expr)
{
	GuVariantInfo i = gu_variant_open(expr);
	if (i.tag == PGF_EXPR_META) {
		return (PgfExprMeta*) i.data;
	}

	return NULL;
}

PGF_API PgfExpr
pgf_expr_string(GuString str, GuPool* pool)
{
	PgfLiteral lit;
	PgfLiteralStr* plit = 
		gu_new_flex_variant(PGF_LITERAL_STR,
		                    PgfLiteralStr,
		                    val, strlen(str)+1,
		                    &lit, pool);
	strcpy(plit->val, str);
	return gu_new_variant_i(pool,
	                        PGF_EXPR_LIT,
	                        PgfExprLit,
	                        lit);
}

PGF_API PgfExpr
pgf_expr_int(int val, GuPool* pool)
{
	PgfLiteral lit;
	PgfLiteralInt* plit = 
		gu_new_variant(PGF_LITERAL_INT,
		               PgfLiteralInt,
		               &lit, pool);
	plit->val = val;
	return gu_new_variant_i(pool,
	                        PGF_EXPR_LIT,
	                        PgfExprLit,
	                        lit);
}

PGF_API PgfExpr
pgf_expr_float(double val, GuPool* pool)
{
	PgfLiteral lit;
	PgfLiteralFlt* plit = 
		gu_new_variant(PGF_LITERAL_FLT,
		               PgfLiteralFlt,
		               &lit, pool);
	plit->val = val;
	return gu_new_variant_i(pool,
	                        PGF_EXPR_LIT,
	                        PgfExprLit,
	                        lit);
}

PGF_API void*
pgf_expr_unlit(PgfExpr expr, int lit_tag)
{
	expr = pgf_expr_unwrap(expr);
	GuVariantInfo i = gu_variant_open(expr);
	if (i.tag == PGF_EXPR_LIT) {
		PgfExprLit* elit = i.data;
		GuVariantInfo i2 = gu_variant_open(elit->lit);
		if (i2.tag == lit_tag) {
			return i2.data;
		}
	}
		
	return NULL;
}

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
	PGF_TOKEN_SEMI,
	PGF_TOKEN_WILD,
	PGF_TOKEN_IDENT,
	PGF_TOKEN_INT,
	PGF_TOKEN_FLT,
	PGF_TOKEN_STR,
	PGF_TOKEN_UNKNOWN,
	PGF_TOKEN_EOF,
} PGF_TOKEN_TAG;

typedef GuUCS (*PgfParserGetc)(void* state, bool mark, GuExn* err);

struct PgfExprParser {
	GuExn* err;
	GuPool* expr_pool;
	GuPool* tmp_pool;
	PGF_TOKEN_TAG token_tag;
	GuStringBuf* token_value;

	void* getch_state;
	PgfParserGetc getch;
	GuUCS ch;
};

static void
pgf_expr_parser_getc(PgfExprParser* parser, bool mark)
{
	parser->ch = parser->getch(parser->getch_state, mark, parser->err);
	if (!gu_ok(parser->err)) {
		gu_exn_clear(parser->err);
		parser->ch = EOF;
	}
}

static bool
pgf_is_ident_first(GuUCS ucs)
{
	return (ucs == '_') ||
           (ucs >= 'a' && ucs <= 'z') ||
           (ucs >= 'A' && ucs <= 'Z') ||
           (ucs >= 192 && ucs <= 255 && ucs != 247 && ucs != 215);
}

static bool
pgf_is_ident_rest(GuUCS ucs)
{
	return (ucs == '_') ||
           (ucs == '\'') ||
           (ucs >= '0' && ucs <= '9') ||
           (ucs >= 'a' && ucs <= 'z') ||
           (ucs >= 'A' && ucs <= 'Z') ||
           (ucs >= 192 && ucs <= 255 && ucs != 247 && ucs != 215);
}

static bool
pgf_is_normal_ident(PgfCId id)
{
	const uint8_t* p = (const uint8_t*) id;
	GuUCS ucs = gu_utf8_decode(&p);
	if (!pgf_is_ident_first(ucs))
		return false;

	for (;;) {
		ucs = gu_utf8_decode(&p);
		if (ucs == 0)
			break;
		if (!pgf_is_ident_rest(ucs))
			return false;
	}

	return true;
}

static void
pgf_expr_parser_token(PgfExprParser* parser, bool mark)
{
	while (isspace(parser->ch)) {
		pgf_expr_parser_getc(parser, mark);
		mark = false;
	}

	parser->token_tag   = PGF_TOKEN_UNKNOWN;
	parser->token_value = NULL;

	switch (parser->ch) {
	case EOF:
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_EOF;
		break;
	case '(':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_LPAR;
		break;
	case ')':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_RPAR;
		break;
	case '{':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_LCURLY;
		break;
	case '}':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_RCURLY;
		break;
	case '<':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_LTRIANGLE;
		break;
	case '>':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_RTRIANGLE;
		break;
	case '?':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_QUESTION;
		break;
	case '\\':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_LAMBDA;
		break;
	case '-':
		pgf_expr_parser_getc(parser, mark);
		if (parser->ch == '>') {
			pgf_expr_parser_getc(parser, false);
			parser->token_tag = PGF_TOKEN_RARROW;
		}
		break;
	case ',':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_COMMA;
		break;
	case ':':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_COLON;
		break;
	case ';':
		pgf_expr_parser_getc(parser, mark);
		parser->token_tag = PGF_TOKEN_SEMI;
		break;
	case '\'':
		pgf_expr_parser_getc(parser, mark);

		GuStringBuf* chars = gu_new_string_buf(parser->tmp_pool);
		while (parser->ch != '\'' && parser->ch != EOF) {
			if (parser->ch == '\\') {
				pgf_expr_parser_getc(parser, false);
			}
			gu_out_utf8(parser->ch, gu_string_buf_out(chars), parser->err);
			pgf_expr_parser_getc(parser, false);
		}
		if (parser->ch == '\'') {
			pgf_expr_parser_getc(parser, false);
			gu_out_utf8(0, gu_string_buf_out(chars), parser->err);
			parser->token_tag   = PGF_TOKEN_IDENT;
			parser->token_value = chars;
		}
		break;
	default: {
		GuStringBuf* chars = gu_new_string_buf(parser->tmp_pool);

		if (pgf_is_ident_first(parser->ch)) {
			do {
				gu_out_utf8(parser->ch, gu_string_buf_out(chars), parser->err);
				pgf_expr_parser_getc(parser, mark);
				mark = false;
			} while (pgf_is_ident_rest(parser->ch));
			gu_out_utf8(0, gu_string_buf_out(chars), parser->err);
			parser->token_tag   = PGF_TOKEN_IDENT;
			parser->token_value = chars;
		} else if (isdigit(parser->ch)) {
			while (isdigit(parser->ch)) {
				gu_out_utf8(parser->ch, gu_string_buf_out(chars), parser->err);
				pgf_expr_parser_getc(parser, mark);
				mark = false;
			}

			if (parser->ch == '.') {
				gu_out_utf8(parser->ch, gu_string_buf_out(chars), parser->err);
				pgf_expr_parser_getc(parser, false);
				
				while (isdigit(parser->ch)) {
					gu_out_utf8(parser->ch, gu_string_buf_out(chars), parser->err);
					pgf_expr_parser_getc(parser, false);
				}
				gu_out_utf8(0, gu_string_buf_out(chars), parser->err);
				parser->token_tag   = PGF_TOKEN_FLT;
				parser->token_value = chars;
			} else {
				gu_out_utf8(0, gu_string_buf_out(chars), parser->err);
				parser->token_tag   = PGF_TOKEN_INT;
				parser->token_value = chars;
			}
		} else if (parser->ch == '"') {
			pgf_expr_parser_getc(parser, mark);

			while (parser->ch != '"' && parser->ch != EOF) {
				if (parser->ch == '\\') {
					pgf_expr_parser_getc(parser, false);
					switch (parser->ch) {
					case '\\':
						gu_out_utf8('\\', gu_string_buf_out(chars), parser->err);
						break;
					case '"':
						gu_out_utf8('\"', gu_string_buf_out(chars), parser->err);
						break;
					case 'n':
						gu_out_utf8('\n', gu_string_buf_out(chars), parser->err);
						break;
					case 'r':
						gu_out_utf8('\r', gu_string_buf_out(chars), parser->err);
						break;
					case 'b':
						gu_out_utf8('\b', gu_string_buf_out(chars), parser->err);
						break;
					case 't':
						gu_out_utf8('\t', gu_string_buf_out(chars), parser->err);
						break;
					default:
						return;
					}
				} else {
					gu_out_utf8(parser->ch, gu_string_buf_out(chars), parser->err);
				}
				pgf_expr_parser_getc(parser, false);
			}
			
			if (parser->ch == '"') {
				pgf_expr_parser_getc(parser, false);
				gu_out_utf8(0, gu_string_buf_out(chars), parser->err);
				parser->token_tag   = PGF_TOKEN_STR;
				parser->token_value = chars;
			}
		} else {
			pgf_expr_parser_getc(parser, mark);
		}
		break;
	}
	}
}

static bool
pgf_expr_parser_lookahead(PgfExprParser* parser, int ch)
{
	while (isspace(parser->ch)) {
		pgf_expr_parser_getc(parser, false);
	}

	return (parser->ch == ch);
}

PGF_API PgfExpr
pgf_expr_parser_expr(PgfExprParser* parser, bool mark);

static PgfType*
pgf_expr_parser_type(PgfExprParser* parser, bool mark);

static PgfExpr
pgf_expr_parser_term(PgfExprParser* parser, bool mark)
{
	switch (parser->token_tag) {
	case PGF_TOKEN_LPAR: {
		pgf_expr_parser_token(parser, false);
		PgfExpr expr = pgf_expr_parser_expr(parser, false);
		if (parser->token_tag == PGF_TOKEN_RPAR) {
			pgf_expr_parser_token(parser, mark);
			return expr;
		} else {
			return gu_null_variant;
		}
	}
	case PGF_TOKEN_LTRIANGLE: {
		pgf_expr_parser_token(parser, false);
		PgfExpr expr = pgf_expr_parser_expr(parser, false);
		if (gu_variant_is_null(expr))
			return gu_null_variant;

		if (parser->token_tag != PGF_TOKEN_COLON) {
			return gu_null_variant;
		}
		pgf_expr_parser_token(parser, false);

		PgfType* type = pgf_expr_parser_type(parser, false);
		if (type == NULL)
			return gu_null_variant;

		if (parser->token_tag != PGF_TOKEN_RTRIANGLE) {
			return gu_null_variant;
		}
		pgf_expr_parser_token(parser, mark);

		return gu_new_variant_i(parser->expr_pool,
					PGF_EXPR_TYPED,
					PgfExprTyped,
					expr, type);
	}
	case PGF_TOKEN_QUESTION: {
		pgf_expr_parser_token(parser, mark);

		PgfMetaId id = 0;
		if (parser->token_tag == PGF_TOKEN_INT) {
			char* str =
				gu_string_buf_data(parser->token_value);
			id = atoi(str);
			pgf_expr_parser_token(parser, mark);
		}
		return gu_new_variant_i(parser->expr_pool,
					            PGF_EXPR_META,
					            PgfExprMeta,
					            id);
	}
	case PGF_TOKEN_IDENT: {
		PgfCId id = gu_string_buf_data(parser->token_value);
		pgf_expr_parser_token(parser, mark);
		PgfExpr e;
		PgfExprFun* fun =
			gu_new_flex_variant(PGF_EXPR_FUN,
			                    PgfExprFun,
                                fun, strlen(id)+1,
                                &e, parser->expr_pool);
        strcpy(fun->fun, id);
		return e;
	}
	case PGF_TOKEN_INT: {
		char* str =
			gu_string_buf_data(parser->token_value);
		int n = atoi(str);
		pgf_expr_parser_token(parser, mark);
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
			gu_string_buf_data(parser->token_value);
		pgf_expr_parser_token(parser, mark);
		return pgf_expr_string(str, parser->expr_pool);
	}
	case PGF_TOKEN_FLT: {
		char* str = 
			gu_string_buf_data(parser->token_value);
		double d;
		if (!gu_string_to_double(str,&d))
			return gu_null_variant;
		pgf_expr_parser_token(parser, mark);
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
pgf_expr_parser_arg(PgfExprParser* parser, bool mark)
{
	PgfExpr arg;

	if (parser->token_tag == PGF_TOKEN_LCURLY) {
		pgf_expr_parser_token(parser, false);

		arg = pgf_expr_parser_expr(parser, false);
		if (gu_variant_is_null(arg))
			return gu_null_variant;

		if (parser->token_tag != PGF_TOKEN_RCURLY) {
			return gu_null_variant;
		}
		pgf_expr_parser_token(parser, mark);

		arg = gu_new_variant_i(parser->expr_pool,
				  PGF_EXPR_IMPL_ARG,
				  PgfExprImplArg,
				  arg);
	} else {
		arg = pgf_expr_parser_term(parser, mark);
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
		pgf_expr_parser_token(parser, false);
	}

	for (;;) {
		if (parser->token_tag == PGF_TOKEN_IDENT) {
			var =
				gu_string_copy(gu_string_buf_data(parser->token_value), parser->expr_pool);
			pgf_expr_parser_token(parser, false);
		} else if (parser->token_tag == PGF_TOKEN_WILD) {
			var = "_";
			pgf_expr_parser_token(parser, false);
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

		pgf_expr_parser_token(parser, false);
	}

	if (bind_type == PGF_BIND_TYPE_IMPLICIT) {
		if (parser->token_tag != PGF_TOKEN_RCURLY)
			return false;
		pgf_expr_parser_token(parser, false);
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

		pgf_expr_parser_token(parser, false);
	}

	return binds;
}

PGF_API PgfExpr
pgf_expr_parser_expr(PgfExprParser* parser, bool mark)
{
	if (parser->token_tag == PGF_TOKEN_LAMBDA) {
		pgf_expr_parser_token(parser, false);
		GuBuf* binds = pgf_expr_parser_binds(parser);
		if (binds == NULL)
			return gu_null_variant;

		if (parser->token_tag != PGF_TOKEN_RARROW) {
			return gu_null_variant;
		}
		pgf_expr_parser_token(parser, false);

		PgfExpr expr = pgf_expr_parser_expr(parser, mark);
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
		PgfExpr expr = pgf_expr_parser_term(parser, mark);
		if (gu_variant_is_null(expr))
			return gu_null_variant;

		while (parser->token_tag != PGF_TOKEN_EOF &&
		       parser->token_tag != PGF_TOKEN_RPAR &&
		       parser->token_tag != PGF_TOKEN_RCURLY &&
		       parser->token_tag != PGF_TOKEN_RTRIANGLE &&
		       parser->token_tag != PGF_TOKEN_COLON &&
		       parser->token_tag != PGF_TOKEN_COMMA &&
		       parser->token_tag != PGF_TOKEN_SEMI &&
		       parser->token_tag != PGF_TOKEN_UNKNOWN) {
			PgfExpr arg = pgf_expr_parser_arg(parser, mark);
			if (gu_variant_is_null(arg))
				return expr;

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
			pgf_expr_parser_token(parser, false);
		}

		if (parser->token_tag == PGF_TOKEN_IDENT) {
			var =
				gu_string_copy(gu_string_buf_data(parser->token_value), parser->expr_pool);
			pgf_expr_parser_token(parser, false);
		} else if (parser->token_tag == PGF_TOKEN_WILD) {
			var = "_";
			pgf_expr_parser_token(parser, false);
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
			pgf_expr_parser_token(parser, false);
		}

		if (parser->token_tag != PGF_TOKEN_COMMA) {
			break;
		}
		
		pgf_expr_parser_token(parser, false);
	}

	if (bind_type == PGF_BIND_TYPE_IMPLICIT)
		return false;

	return true;
}

static PgfType*
pgf_expr_parser_atom(PgfExprParser* parser, bool mark)
{
	if (parser->token_tag != PGF_TOKEN_IDENT)
		return NULL;

	PgfCId cid =
		gu_string_copy(gu_string_buf_data(parser->token_value), parser->expr_pool);
	pgf_expr_parser_token(parser, mark);

	GuBuf* args = gu_new_buf(PgfExpr, parser->tmp_pool);
	while (parser->token_tag != PGF_TOKEN_EOF &&
		   parser->token_tag != PGF_TOKEN_RPAR &&
		   parser->token_tag != PGF_TOKEN_RTRIANGLE &&
		   parser->token_tag != PGF_TOKEN_RARROW) {
		PgfExpr arg =
			pgf_expr_parser_arg(parser, mark);
		if (gu_variant_is_null(arg))
			break;

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
pgf_expr_parser_type(PgfExprParser* parser, bool mark)
{
	PgfType* type = NULL;
	GuBuf* hypos = gu_new_buf(PgfHypo, parser->expr_pool);

	for (;;) {
		if (parser->token_tag == PGF_TOKEN_LPAR) {
			pgf_expr_parser_token(parser, false);

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

				pgf_expr_parser_token(parser, false);
			} else {
				PgfHypo* hypo = gu_buf_extend(hypos);
				hypo->bind_type = PGF_BIND_TYPE_EXPLICIT;
				hypo->cid = "_";
				hypo->type = NULL;
			}

			size_t n_end = gu_buf_length(hypos);

			PgfType* type = pgf_expr_parser_type(parser, false);
			if (type == NULL)
				return NULL;

			if (parser->token_tag != PGF_TOKEN_RPAR)
				return NULL;

			pgf_expr_parser_token(parser, false);

			if (parser->token_tag != PGF_TOKEN_RARROW)
				return NULL;

			pgf_expr_parser_token(parser, false);

			for (size_t i = n_start; i < n_end; i++) {
				PgfHypo* hypo = gu_buf_index(hypos, PgfHypo, i);
				hypo->type = type;
			}
		} else {
			type = pgf_expr_parser_atom(parser, mark);
			if (type == NULL)
				return NULL;

			if (parser->token_tag != PGF_TOKEN_RARROW)
				break;

			pgf_expr_parser_token(parser, false);

			PgfHypo* hypo = gu_buf_extend(hypos);
			hypo->bind_type = PGF_BIND_TYPE_EXPLICIT;
			hypo->cid = "_";
			hypo->type = type;
		}
	}

	type->hypos = gu_buf_data_seq(hypos);

	return type;
}

PGF_API PgfExprParser*
pgf_new_parser(void* getc_state, PgfParserGetc getc, GuPool* pool, GuPool* tmp_pool, GuExn* err)
{
	PgfExprParser* parser = gu_new(PgfExprParser, tmp_pool);
	parser->err = err;
	parser->expr_pool = pool;
	parser->tmp_pool = tmp_pool;
	parser->getch_state = getc_state;
	parser->getch = getc;
	parser->ch = ' ';
	pgf_expr_parser_token(parser, false);
	return parser;
}

static GuUCS
pgf_expr_parser_in_getc(void* state, bool mark, GuExn* err)
{
	return gu_in_utf8((GuIn*) state, err);
}

PGF_API PgfExpr
pgf_read_expr(GuIn* in, GuPool* pool, GuPool* tmp_pool, GuExn* err)
{
	PgfExprParser* parser =
		pgf_new_parser(in, pgf_expr_parser_in_getc, pool, tmp_pool, err);
	PgfExpr expr = pgf_expr_parser_expr(parser, true);
	if (parser->token_tag != PGF_TOKEN_EOF)
		return gu_null_variant;
	return expr;
}

PGF_API int
pgf_read_expr_tuple(GuIn* in,
                    size_t n_exprs, PgfExpr exprs[],
                    GuPool* pool, GuExn* err)
{
	GuPool* tmp_pool = gu_new_pool();
	PgfExprParser* parser =
		pgf_new_parser(in, pgf_expr_parser_in_getc, pool, tmp_pool, err);
	if (parser->token_tag != PGF_TOKEN_LTRIANGLE)
		goto fail;
	pgf_expr_parser_token(parser, false);
	for (size_t i = 0; i < n_exprs; i++) {
		if (i > 0) {
			if (parser->token_tag != PGF_TOKEN_COMMA)
				goto fail;
			pgf_expr_parser_token(parser, false);
		}

		exprs[i] = pgf_expr_parser_expr(parser, false);
		if (gu_variant_is_null(exprs[i]))
			goto fail;
	}
	if (parser->token_tag != PGF_TOKEN_RTRIANGLE)
		goto fail;
	pgf_expr_parser_token(parser, false);
	if (parser->token_tag != PGF_TOKEN_EOF)
		goto fail;
	gu_pool_free(tmp_pool);

	return 1;
	
fail:
	gu_pool_free(tmp_pool);
	return 0;
}

PGF_API GuSeq*
pgf_read_expr_matrix(GuIn* in,
                     size_t n_exprs,
                     GuPool* pool, GuExn* err)
{
	GuPool* tmp_pool = gu_new_pool();
	PgfExprParser* parser =
		pgf_new_parser(in, pgf_expr_parser_in_getc, pool, tmp_pool, err);
	if (parser->token_tag != PGF_TOKEN_LTRIANGLE)
		goto fail;
	pgf_expr_parser_token(parser, false);

	GuBuf* buf = gu_new_buf(PgfExpr, pool);
	
	if (parser->token_tag != PGF_TOKEN_RTRIANGLE) {	
		for (;;) {
			PgfExpr* exprs = gu_buf_extend_n(buf, n_exprs);

			for (size_t i = 0; i < n_exprs; i++) {
				if (i > 0) {
					if (parser->token_tag != PGF_TOKEN_COMMA)
						goto fail;
					pgf_expr_parser_token(parser, false);
				}

				exprs[i] = pgf_expr_parser_expr(parser, false);
				if (gu_variant_is_null(exprs[i]))
					goto fail;
			}

			if (parser->token_tag != PGF_TOKEN_SEMI)
				break;

			pgf_expr_parser_token(parser, false);
		}

		if (parser->token_tag != PGF_TOKEN_RTRIANGLE)
			goto fail;
	}

	pgf_expr_parser_token(parser, false);
	if (parser->token_tag != PGF_TOKEN_EOF)
		goto fail;
	gu_pool_free(tmp_pool);

	return gu_buf_data_seq(buf);

fail:
	gu_pool_free(tmp_pool);
	return NULL;
}

PGF_API PgfType*
pgf_read_type(GuIn* in, GuPool* pool, GuPool* tmp_pool, GuExn* err)
{
	PgfExprParser* parser = 
		pgf_new_parser(in, pgf_expr_parser_in_getc, pool, tmp_pool, err);
	PgfType* type = pgf_expr_parser_type(parser, true);
	if (parser->token_tag != PGF_TOKEN_EOF)
		return NULL;
	return type;
}

PGF_API bool
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
        return strcmp(lit1->val, lit2->val) == 0;
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

PGF_API int
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
		return strcmp(abs1->id, abs2->id) == 0 &&
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
		return strcmp(fun1->fun, fun2->fun) == 0;
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

PGF_API GuHash
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

PGF_API GuHash
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

PGF_API size_t
pgf_expr_size(PgfExpr expr)
{
	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS: {
		PgfExprAbs* abs = ei.data;
		return pgf_expr_size(abs->body);
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		return pgf_expr_size(app->fun) + pgf_expr_size(app->arg);
	}
	case PGF_EXPR_LIT:
	case PGF_EXPR_META:
	case PGF_EXPR_FUN:
	case PGF_EXPR_VAR: {
		return 1;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* typed = ei.data;
		return pgf_expr_size(typed->expr);
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* impl = ei.data;
		return pgf_expr_size(impl->expr);
	}
	default:
		gu_impossible();
		return 0;
	}
}

static void
pgf_expr_functions_helper(PgfExpr expr, GuBuf* functions)
{
	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS: {
		PgfExprAbs* abs = ei.data;
		pgf_expr_functions_helper(abs->body, functions);
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		pgf_expr_functions_helper(app->fun, functions);
		pgf_expr_functions_helper(app->arg, functions);
		break;
	}
	case PGF_EXPR_LIT:
	case PGF_EXPR_META:
	case PGF_EXPR_VAR: {
		break;
	}
	case PGF_EXPR_FUN:{
		PgfExprFun* fun = ei.data;
		gu_buf_push(functions, GuString, fun->fun);
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* typed = ei.data;
		pgf_expr_functions_helper(typed->expr, functions);
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* impl = ei.data;
		pgf_expr_functions_helper(impl->expr, functions);
		break;
	}
	default:
		gu_impossible();
	}
}

PGF_API GuSeq*
pgf_expr_functions(PgfExpr expr, GuPool* pool)
{
	GuBuf* functions = gu_new_buf(GuString, pool);
	pgf_expr_functions_helper(expr, functions);
	return gu_buf_data_seq(functions);
}

PGF_API PgfType*
pgf_type_substitute(PgfType* type, GuSeq* meta_values, GuPool* pool)
{
	size_t n_hypos = gu_seq_length(type->hypos);
	PgfHypos* new_hypos = gu_new_seq(PgfHypo, n_hypos, pool);
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo     = gu_seq_index(type->hypos, PgfHypo, i);
		PgfHypo* new_hypo = gu_seq_index(new_hypos, PgfHypo, i);

		new_hypo->bind_type = hypo->bind_type;
		new_hypo->cid       = gu_string_copy(hypo->cid, pool);
		new_hypo->type      = pgf_type_substitute(hypo->type, meta_values, pool);
	}

	PgfType *new_type =
		gu_new_flex(pool, PgfType, exprs, type->n_exprs);
	new_type->hypos   = new_hypos;
	new_type->cid     = gu_string_copy(type->cid, pool);
	new_type->n_exprs = type->n_exprs;

	for (size_t i = 0; i < type->n_exprs; i++) {
		new_type->exprs[i] =
			pgf_expr_substitute(type->exprs[i], meta_values, pool);
	}
	
	return new_type;
}

PGF_API PgfExpr
pgf_expr_substitute(PgfExpr expr, GuSeq* meta_values, GuPool* pool)
{
	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_ABS: {
		PgfExprAbs* abs = ei.data;

		PgfCId id    = gu_string_copy(abs->id, pool);
		PgfExpr body = pgf_expr_substitute(abs->body, meta_values, pool);
		return gu_new_variant_i(pool,
								PGF_EXPR_ABS,
								PgfExprAbs,
								abs->bind_type, id, body);
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		
		PgfExpr fun = pgf_expr_substitute(app->fun, meta_values, pool);
		PgfExpr arg = pgf_expr_substitute(app->arg, meta_values, pool);
		return gu_new_variant_i(pool,
								PGF_EXPR_APP,
								PgfExprApp,
								fun, arg);
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* elit = ei.data;

		PgfLiteral lit;
		GuVariantInfo i = gu_variant_open(elit->lit);
		switch (i.tag) {
		case PGF_LITERAL_STR: {
			PgfLiteralStr* lstr = i.data;

			PgfLiteralStr* new_lstr =
				gu_new_flex_variant(PGF_LITERAL_STR,
				                    PgfLiteralStr,
				                    val, strlen(lstr->val)+1,
				                    &lit, pool);
			strcpy(new_lstr->val, lstr->val);
			break;
		}
		case PGF_LITERAL_INT: {
			PgfLiteralInt* lint = i.data;

			PgfLiteralInt* new_lint =
				gu_new_variant(PGF_LITERAL_INT,
				               PgfLiteralInt,
				               &lit, pool);
			new_lint->val = lint->val;
			break;
		}
		case PGF_LITERAL_FLT: {
			PgfLiteralFlt* lflt = i.data;

			PgfLiteralFlt* new_lflt =
				gu_new_variant(PGF_LITERAL_FLT,
				               PgfLiteralFlt,
				               &lit, pool);
			new_lflt->val = lflt->val;
			break;
		}
		default:
			gu_impossible();
		}
		
		return gu_new_variant_i(pool,
		                        PGF_EXPR_LIT,
			                    PgfExprLit,
			                    lit);
	}
	case PGF_EXPR_META: {
		PgfExprMeta* meta = ei.data;
		PgfExpr e = gu_null_variant;
		if ((size_t) meta->id < gu_seq_length(meta_values)) {
			e = gu_seq_get(meta_values, PgfExpr, meta->id);
		}
		if (gu_variant_is_null(e)) {
			e = gu_new_variant_i(pool,
		                         PGF_EXPR_META,
			                     PgfExprMeta,
			                     meta->id);
		}
		return e;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;

		PgfExpr e;
		PgfExprFun* new_fun =
				gu_new_flex_variant(PGF_EXPR_FUN,
				                    PgfExprFun,
				                    fun, strlen(fun->fun)+1,
				                    &e, pool);
		strcpy(new_fun->fun, fun->fun);
		return e;
	}
	case PGF_EXPR_VAR: {
		PgfExprVar* var = ei.data;
		return gu_new_variant_i(pool,
		                        PGF_EXPR_VAR,
			                    PgfExprVar,
			                    var->var);
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped* typed = ei.data;
		
		PgfExpr expr  = pgf_expr_substitute(typed->expr, meta_values, pool);
		PgfType *type = pgf_type_substitute(typed->type, meta_values, pool);

		return gu_new_variant_i(pool,
								PGF_EXPR_TYPED,
								PgfExprTyped,
								expr,
								type);
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg* impl = ei.data;

		PgfExpr expr = pgf_expr_substitute(impl->expr, meta_values, pool);
		return gu_new_variant_i(pool,
								PGF_EXPR_IMPL_ARG,
								PgfExprImplArg,
								expr);
	}
	default:
		gu_impossible();
		return gu_null_variant;
	}
}

PGF_API void
pgf_print_cid(PgfCId id,
			  GuOut* out, GuExn* err)
{
	if (pgf_is_normal_ident(id))
		gu_string_write(id, out, err);
	else {
		gu_putc('\'', out, err);
		const uint8_t* p = (const uint8_t*) id;
		for (;;) {
			GuUCS ucs = gu_utf8_decode(&p);
			if (ucs == 0)
				break;
			if (ucs == '\'')
				gu_puts("\\\'", out, err);
			else if (ucs == '\\')
				gu_puts("\\\\", out, err);
			else
				gu_out_utf8(ucs, out, err);
		}
		gu_putc('\'', out, err);
	}
}

PGF_API void
pgf_print_literal(PgfLiteral lit,
			      GuOut* out, GuExn* err)
{
	GuVariantInfo ei = gu_variant_open(lit);
	switch (ei.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr* lit = ei.data;
        gu_putc('"', out, err);
        const uint8_t* s = (uint8_t*) lit->val;
        while (*s) {
			GuUCS c = gu_utf8_decode(&s);
			switch (c) {
			case '\\':
				gu_puts("\\\\", out, err);
				break;
			case '"':
				gu_puts("\\\"", out, err);
				break;
			case '\n':
				gu_puts("\\n", out, err);
				break;
			case '\r':
				gu_puts("\\r", out, err);
				break;
			case '\b':
				gu_puts("\\b", out, err);
				break;
			case '\t':
				gu_puts("\\t", out, err);
				break;
			default:
				gu_out_utf8(c, out, err);
			}
		}
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

PGF_API void
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
			pgf_print_cid(abs->id, out, err);
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
	case PGF_EXPR_META: {
		PgfExprMeta* meta = ei.data;
		gu_putc('?', out, err);
		if (meta->id > 0)
			gu_printf(out, err, "%d", meta->id);
		break;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;
		pgf_print_cid(fun->fun, out, err);
		break;
	}
	case PGF_EXPR_VAR: {
		PgfExprVar* evar = ei.data;
		
		int var = evar->var;
		PgfPrintContext* c = ctxt;
		while (c != NULL && var > 0) {
			c = ctxt->next;
			var--;
		}
		
		if (c == NULL) {
			gu_printf(out, err, "#%d", evar->var);
		} else {
			pgf_print_cid(c->name, out, err);
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

PGF_API PgfPrintContext*
pgf_print_hypo(PgfHypo *hypo, PgfPrintContext* ctxt, int prec,
               GuOut *out, GuExn *err)
{
    if (hypo->bind_type == PGF_BIND_TYPE_IMPLICIT) {
        gu_puts("({", out, err);
        pgf_print_cid(hypo->cid, out, err);
        gu_puts("} : ", out, err);
        pgf_print_type(hypo->type, ctxt, 0, out, err);
        gu_puts(")", out, err);
    } else {
        GuPool* tmp_pool = gu_new_pool();

        if (strcmp(hypo->cid, "_") != 0) {
            gu_puts("(", out, err);
            pgf_print_cid(hypo->cid, out, err);
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

PGF_API void
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

		pgf_print_cid(type->cid, out, err);
    
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
		pgf_print_cid(type->cid, out, err);
	}
}

PGF_API void
pgf_print_context(PgfHypos *hypos, PgfPrintContext* ctxt,
                  GuOut *out, GuExn *err)
{
	PgfPrintContext* new_ctxt = ctxt;

    size_t n_hypos = gu_seq_length(hypos);
	for (size_t i = 0; i < n_hypos; i++) {
		if (i > 0)
			gu_putc(' ', out, err);

		PgfHypo *hypo = gu_seq_index(hypos, PgfHypo, i);
		new_ctxt = pgf_print_hypo(hypo, new_ctxt, 4, out, err);		
	}
}

PGF_API void
pgf_print_expr_tuple(size_t n_exprs, PgfExpr exprs[], PgfPrintContext* ctxt,
                     GuOut* out, GuExn* err)
{
	gu_putc('<', out, err);
	for (size_t i = 0; i < n_exprs; i++) {
		if (i > 0)
			gu_putc(',', out, err);
		pgf_print_expr(exprs[i], ctxt, 0, out, err);
	}
	gu_putc('>', out, err);
}

PGF_API bool
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
			
		if (strcmp(hypo1->cid, hypo2->cid) != 0)
			return false;
			
		if (!pgf_type_eq(hypo1->type, hypo2->type))
			return false;
	}
    
	if (strcmp(t1->cid, t2->cid) != 0)
		return false;

	if (t1->n_exprs != t2->n_exprs)
		return false;

	for (size_t i = 0; i < t1->n_exprs; i++) {
		if (!pgf_expr_eq(t1->exprs[i], t2->exprs[i]))
			return false;
	}

	return true;
}

PGF_API prob_t
pgf_compute_tree_probability(PgfPGF *gr, PgfExpr expr)
{
	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		return pgf_compute_tree_probability(gr, app->fun) +
		       pgf_compute_tree_probability(gr, app->arg);
	}
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;
		PgfAbsFun* absfun =
			gu_seq_binsearch(gr->abstract.funs, pgf_absfun_order, PgfAbsFun, fun->fun);
		if (absfun == NULL)
			return INFINITY;
		else
			return absfun->ep.prob;
	}
	default:
		return 0;
	}
}
