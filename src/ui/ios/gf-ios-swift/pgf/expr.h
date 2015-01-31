#ifndef EXPR_H_
#define EXPR_H_

#include <gu/in.h>
#include <gu/out.h>
#include <gu/variant.h>
#include <gu/seq.h>

/// Abstract syntax trees
/// @file

/// An abstract syntax tree
typedef GuVariant PgfExpr;

typedef struct PgfHypo PgfHypo;
typedef struct PgfType PgfType;

typedef int PgfMetaId;

typedef enum {
	PGF_BIND_TYPE_EXPLICIT,
	PGF_BIND_TYPE_IMPLICIT
} PgfBindType;

// PgfLiteral

typedef GuVariant PgfLiteral;


typedef enum {
	PGF_LITERAL_STR,
	PGF_LITERAL_INT,
	PGF_LITERAL_FLT,
	PGF_LITERAL_NUM_TAGS
} PgfLiteralTag;

typedef struct {
	char val[0];  // a flexible array that contains the value
} PgfLiteralStr;

typedef struct {
	int val;
} PgfLiteralInt;

typedef struct {
	double val;
} PgfLiteralFlt;



struct PgfHypo {
	PgfBindType bind_type;

	PgfCId cid;
	/**< Locally scoped name for the parameter if dependent types
	 * are used. "_" for normal parameters. */

	PgfType* type;
};

typedef GuSeq PgfHypos;

struct PgfType {
	PgfHypos* hypos;
	PgfCId cid; /// XXX: resolve to PgfCat*?
	size_t n_exprs;
	PgfExpr exprs[];
};

			
typedef enum {
	PGF_EXPR_ABS,
	PGF_EXPR_APP,
	PGF_EXPR_LIT,
	PGF_EXPR_META,
	PGF_EXPR_FUN,
	PGF_EXPR_VAR,
	PGF_EXPR_TYPED,
	PGF_EXPR_IMPL_ARG,
	PGF_EXPR_NUM_TAGS
} PgfExprTag;

typedef struct {
	PgfBindType bind_type;
	PgfCId id;
	PgfExpr body;
} PgfExprAbs;

typedef struct {
	PgfExpr fun;
	PgfExpr arg;
} PgfExprApp;

typedef struct {
	PgfLiteral lit;
} PgfExprLit;

typedef struct {
	PgfMetaId id;
} PgfExprMeta;

typedef struct {
	char fun[0];
} PgfExprFun;

typedef struct {
	int var;
} PgfExprVar;

/**< A variable. The value is a de Bruijn index to the environment,
 * beginning from the innermost variable. */

typedef struct {
	PgfExpr expr;
	PgfType* type;
} PgfExprTyped;

typedef struct {
	PgfExpr expr;
} PgfExprImplArg;

typedef float prob_t;

typedef struct {
	prob_t prob;
	PgfExpr expr;
} PgfExprProb;

int
pgf_expr_arity(PgfExpr expr);

PgfExpr
pgf_expr_unwrap(PgfExpr expr);

typedef struct PgfApplication PgfApplication;

struct PgfApplication {
	PgfCId fun;
	int n_args;
	PgfExpr args[];
};

PgfApplication*
pgf_expr_unapply(PgfExpr expr, GuPool* pool);


PgfExpr
pgf_read_expr(GuIn* in, GuPool* pool, GuExn* err);

PgfType*
pgf_read_type(GuIn* in, GuPool* pool, GuExn* err);

bool
pgf_literal_eq(PgfLiteral lit1, PgfLiteral lit2);

bool
pgf_expr_eq(PgfExpr e1, PgfExpr e2);

bool
pgf_type_eq(PgfType* t1, PgfType* t2);

GuHash
pgf_literal_hash(GuHash h, PgfLiteral lit);

GuHash
pgf_expr_hash(GuHash h, PgfExpr e);

typedef struct PgfPrintContext PgfPrintContext;

struct PgfPrintContext {
	PgfCId name;
	PgfPrintContext* next;
};

void
pgf_print_cid(PgfCId id, GuOut* out, GuExn* err);

void
pgf_print_literal(PgfLiteral lit, GuOut* out, GuExn* err);

void
pgf_print_expr(PgfExpr expr, PgfPrintContext* ctxt, int prec, 
               GuOut* out, GuExn* err);

PgfPrintContext*
pgf_print_hypo(PgfHypo *hypo, PgfPrintContext* ctxt, int prec,
               GuOut* out, GuExn *err);

void
pgf_print_type(PgfType *type, PgfPrintContext* ctxt, int prec,
               GuOut* out, GuExn *err);

#endif /* EXPR_H_ */
