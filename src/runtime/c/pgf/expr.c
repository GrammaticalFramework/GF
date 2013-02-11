#include "pgf.h"
#include <gu/intern.h>
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
	       GU_MEMBER(PgfHypo, bindtype, PgfBindType),
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
	PGF_TOKEN_QUESTION,
	PGF_TOKEN_IDENT,
	PGF_TOKEN_INT,
	PGF_TOKEN_FLT,
	PGF_TOKEN_STR,
	PGF_TOKEN_UNKNOWN,
	PGF_TOKEN_EOF,
} PGF_TOKEN_TAG;

struct PgfExprParser {
	GuExn* err;
	GuReader* rdr;
	GuPool* expr_pool;
	GuPool* tmp_pool;
	PGF_TOKEN_TAG token_tag;
	GuChars token_value;
	int ch;
};

static void
pgf_expr_parser_getc(PgfExprParser* parser)
{
	parser->ch = gu_getc(parser->rdr, parser->err);
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
	
	if (parser->tmp_pool != NULL) {
		gu_pool_free(parser->tmp_pool);
		parser->tmp_pool = NULL;
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
	case '?':
		pgf_expr_parser_getc(parser);
		parser->token_tag = PGF_TOKEN_QUESTION;
		break;
	default: {
		parser->tmp_pool = gu_new_pool();
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

static PgfExpr
pgf_expr_parser_expr(PgfExprParser* parser);

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
pgf_expr_parser_expr(PgfExprParser* parser)
{
	PgfExpr expr = pgf_expr_parser_term(parser);
	if (gu_variant_is_null(expr))
		return expr;

	while (true) {
		PgfExpr arg = pgf_expr_parser_term(parser);
		if (gu_variant_is_null(arg)) {
			return expr;
		}
		expr = gu_new_variant_i(parser->expr_pool,
					PGF_EXPR_APP,
					PgfExprApp,
					expr, arg);
	}
}

PgfExpr
pgf_read_expr(GuReader* rdr, GuPool* pool, GuExn* err)
{
	GuPool* tmp_pool = gu_new_pool();
	PgfExprParser* parser = gu_new(PgfExprParser, tmp_pool);
	parser->err = err;
	parser->rdr = rdr;
	parser->expr_pool = pool;
	parser->tmp_pool = NULL;
	parser->ch = ' ';
	pgf_expr_parser_token(parser);
	PgfExpr expr = pgf_expr_parser_expr(parser);
	gu_pool_free(tmp_pool);
	return expr;
}

void
pgf_print_literal(PgfLiteral lit,
			  GuWriter* wtr, GuExn* err)
{
	GuVariantInfo ei = gu_variant_open(lit);
	switch (ei.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr* lit = ei.data;
        gu_putc('"', wtr, err);
		gu_string_write(lit->val, wtr, err);
        gu_putc('"', wtr, err);
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
}

void
pgf_print_expr(PgfExpr expr, int prec,
			  GuWriter* wtr, GuExn* err)
{
	GuVariantInfo ei = gu_variant_open(expr);
	switch (ei.tag) {
	case PGF_EXPR_FUN: {
		PgfExprFun* fun = ei.data;
		gu_string_write(fun->fun, wtr, err);
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp* app = ei.data;
		if (prec > 3) {
			gu_puts("(", wtr, err);
		}
		pgf_print_expr(app->fun, 3, wtr, err);
		gu_puts(" ", wtr, err);
		pgf_print_expr(app->arg, 4, wtr, err);
		if (prec > 3) {
			gu_puts(")", wtr, err);
		}
		break;
	}
	case PGF_EXPR_ABS:
	case PGF_EXPR_LIT: {
		PgfExprLit* lit = ei.data;
        pgf_print_literal(lit->lit, wtr, err);
		break;
	}
	case PGF_EXPR_META:
		gu_putc('?', wtr, err);
		break;
	case PGF_EXPR_VAR:
	case PGF_EXPR_TYPED:
	case PGF_EXPR_IMPL_ARG:
		gu_impossible();
		break;
	default:
		gu_impossible();
	}
}

void
pgf_print_hypo(PgfHypo *hypo, int prec, GuWriter *wtr, GuExn *err)
{
    if (hypo->bindtype == PGF_BIND_TYPE_IMPLICIT) {
        gu_puts("({", wtr, err);
        gu_string_write(hypo->cid, wtr, err);
        gu_puts("} : ", wtr, err);
        pgf_print_type(hypo->type, 0, wtr, err);
        gu_puts(")", wtr, err);
    } else {
        GuPool* tmp_pool = gu_new_pool();
        GuString tmp = gu_str_string("_", tmp_pool);
        
        if (!gu_string_eq(hypo->cid, tmp)) {
            gu_puts("(", wtr, err);
            gu_string_write(hypo->cid, wtr, err);
            gu_puts(" : ", wtr, err);
            pgf_print_type(hypo->type, 0, wtr, err);
            gu_puts(")", wtr, err);
        } else {
            pgf_print_type(hypo->type, prec, wtr, err);
        }
        
        gu_pool_free(tmp_pool);
    }
}

void
pgf_print_type(PgfType *type, int prec, GuWriter *wtr, GuExn *err)
{
    size_t n_hypos = gu_seq_length(type->hypos);
    
    if (n_hypos > 0) {
		if (prec > 0) gu_putc('(', wtr, err);
		
		for (size_t i = 0; i < n_hypos; i++) {
			PgfHypo *hypo = gu_seq_index(type->hypos, PgfHypo, i);
			pgf_print_hypo(hypo, 1, wtr, err);

			gu_puts(" -> ", wtr, err);
		}

		gu_string_write(type->cid, wtr, err);
    
		for (size_t i = 0; i < type->n_exprs; i++) {
			gu_puts(" ", wtr, err);
			pgf_print_expr(type->exprs[i], 4, wtr, err);
		}
		
		if (prec > 0) gu_putc(')', wtr, err);
	} else if (type->n_exprs > 0) {
		if (prec > 3) gu_putc('(', wtr, err);
		
		gu_string_write(type->cid, wtr, err);
    
		for (size_t i = 0; i < type->n_exprs; i++) {
			gu_puts(" ", wtr, err);
			pgf_print_expr(type->exprs[i], 4, wtr, err);
		}
		
		if (prec > 3) gu_putc(')', wtr, err);
	} else {
		gu_string_write(type->cid, wtr, err);
	}
}
