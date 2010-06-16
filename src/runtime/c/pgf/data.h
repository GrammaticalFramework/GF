#ifndef PGF_DATA_H
#define PGF_DATA_H

typedef int BindType;

#include "expr.h"
#include "type.h"

struct _String {
  int len;
  unsigned int chars[];
};

struct _CId {
  int len;
  char chars[];
};

typedef struct _CIdList {
  int count;
  CId names[];
} *CIdList;

typedef struct _AbsCat {
  CId name;
  Context hypos;
  CIdList funs;
} *AbsCat;

typedef struct _AbsCats {
  int count;
  struct _AbsCat lst[];
} *AbsCats;

typedef struct _AbsFun {
  CId name;
  Type ty;
  int arrity;
  Equations equs;
} *AbsFun;

typedef struct _AbsFuns {
  int count;
  struct _AbsFun lst[];
} *AbsFuns;

struct _Flag {
  CId name;
  Literal value;
} ;

typedef struct _Flags {
  int count;
  struct _Flag values[];
} *Flags;

typedef struct _Abstract {
  CId name;
  Flags flags;
  AbsFuns funs;
  AbsCats cats;
} *Abstract;

typedef struct _Concrete {
  CId name;
  Flags flags;
} *Concrete;

struct _PGF {
  Flags flags;
  int   nConcr;
  struct _Abstract abstract;
  struct _Concrete concretes[];
};

#endif
