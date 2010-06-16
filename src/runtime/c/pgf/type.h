#ifndef PGF_TYPE_H
#define PGF_TYPE_H

typedef struct _Hypo {
  BindType bt;
  CId var;
  Type ty;
} *Hypo;

typedef struct _Context {
  int  size;
  struct _Hypo hypos[];
} *Context;

struct _Type {
  Context hypos;
  CId  cat;
  int  nArgs;
  Expr args[];
};

#endif
