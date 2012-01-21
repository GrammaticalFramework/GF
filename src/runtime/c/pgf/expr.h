#ifndef EXPR_H_
#define EXPR_H_

#include <gu/read.h>
#include <gu/write.h>
#include <gu/variant.h>
#include <gu/seq.h>
#include <pgf/pgf.h>

/// Abstract syntax trees
/// @file

/// An abstract syntax tree
typedef GuVariant PgfExpr;

GU_DECLARE_TYPE(PgfExpr, GuVariant);

typedef GuList(PgfExpr) PgfExprs;

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
	GuStr val;
} PgfLiteralStr;

typedef struct {
	int val;
} PgfLiteralInt;

typedef struct {
	double val;
} PgfLiteralFlt;



struct PgfHypo {
	PgfBindType bindtype;

	PgfCId cid;
	/**< Locally scoped name for the parameter if dependent types
	 * are used. "_" for normal parameters. */

	PgfType* type;
};

typedef GuSeq PgfHypos;
extern GU_DECLARE_TYPE(PgfHypos, GuSeq);

struct PgfType {
	PgfHypos hypos;
	PgfCId cid; /// XXX: resolve to PgfCat*?
	int n_exprs;
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
	PgfCId id; // 
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
	PgfCId fun;
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
pgf_read_expr(GuReader* rdr, GuPool* pool, GuExn* err);

void
pgf_print_expr(PgfExpr expr, int prec, GuWriter* wtr, GuExn* err);

void
pgf_print_hypo(PgfHypo *hypo, int prec, GuWriter *wtr, GuExn *err);

void
pgf_print_type(PgfType *type, int prec, GuWriter *wtr, GuExn *err);

#endif /* EXPR_H_ */
