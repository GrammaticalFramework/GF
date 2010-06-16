#ifndef PGF_EXPR_H
#define PGF_EXPR_H

#define LIT_STR   0
#define LIT_INT   1
#define LIT_FLOAT 2

struct _Literal {
  int tag;
};

typedef struct _LiteralStr {
  struct _Literal _;
  String val;
} *LiteralStr;

typedef struct _LiteralInt {
  struct _Literal _;
  int val;
} *LiteralInt;

typedef struct _LiteralFloat {
  struct _Literal _;
  double val;
} *LiteralFloat;

#define TAG_ABS 0
#define TAG_APP 1
#define TAG_LIT 2
#define TAG_MET 3
#define TAG_FUN 4
#define TAG_VAR 5
#define TAG_TYP 6
#define TAG_IMP 7

struct _Expr {
  int tag;
};

typedef struct _ExprAbs {
  struct _Expr _;
  BindType bt;
  CId var;
  Expr body;
} *ExprAbs;

typedef struct _ExprApp {
  struct _Expr _;
  Expr left, right;
} *ExprApp;

typedef struct _ExprLit {
  struct _Expr _;
  Literal lit;
} *ExprLit;

typedef struct _ExprMeta {
  struct _Expr _;
  int id;
} *ExprMeta;

typedef struct _ExprFun {
  struct _Expr _;
  CId fun;
} *ExprFun;

typedef struct _ExprVar {
  struct _Expr _;
  int index;
} *ExprVar;

typedef struct _ExprTyped {
  struct _Expr _;
  Expr e;
  Type ty;
} *ExprTyped;

typedef struct _ExprImplArg {
  struct _Expr _;
  Expr e;
} *ExprImplArg;

#define TAG_PAPP   0
#define TAG_PVAR   1
#define TAG_PAT    2
#define TAG_PWILD  3
#define TAG_PLIT   4
#define TAG_PIMP   5
#define TAG_PTILDE 6

typedef struct _Patt {
  int tag;
} *Patt;

typedef struct _Patts {
  int count;
  Patt pats[];
} *Patts;

typedef struct _PattApp {
  struct _Patt _;
  CId fun;
  struct _Patts args;
} *PattApp;

typedef struct _PattVar {
  struct _Patt _;
  CId var;
} *PattVar;

typedef struct _PattAt {
  struct _Patt _;
  CId  var;
  Patt pat;
} *PattAt;

typedef struct _PattWild {
  struct _Patt _;
} *PattWild;

typedef struct _PattLit {
  struct _Patt _;
  Literal lit;
} *PattLit;

typedef struct _PattImplArg {
  struct _Patt _;
  Patt pat;
} *PattImplArg;

typedef struct _PattTilde {
  struct _Patt _;
  Expr e;
} *PattTilde;

typedef struct _Equations {
  int count;
  struct _Equation {
    Patts lhs;
    Expr  rhs;
  } equs[];
} *Equations;

#endif
