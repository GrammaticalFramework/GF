#include "../pgf.h"
#include "data.h"
#include "panic.h"
#include <stdio.h>
#include <stdlib.h>

static int readTag(FILE *f) {
  return getc(f);
}

static int readInt16(FILE *f) {
  int x = getc(f);
  int y = getc(f);
  return ((x << 8) | y);
}

static int readInt(FILE *f) {
  unsigned int x = (unsigned int) getc(f);
  if (x <= 0x7f)
    return (int) x;
  else {
    unsigned int y = (unsigned int) readInt(f);
    return (int) ((y << 7) | (x & 0x7f)) ;
  }
}

static double readFloat(FILE *f) {
  double d;
  fread(&d, sizeof(d), 1, f);
  return d;
}

static String readString(FILE *f) {
  int len = readInt(f);
  String str = (String) malloc(sizeof(struct _CId)+len*sizeof(unsigned int));
  str->len = len;
  
  int i;
  for (i = 0; i < len; i++) {
    int c = fgetc(f);
    str->chars[i] = c;
  }
  
  return str;
}

static CId readCId(FILE *f) {
  int len = readInt(f);
  CId cid = (CId) malloc(sizeof(struct _CId)+len*sizeof(char));
  cid->len = len;
  fread(&cid->chars, sizeof(char), len, f);
  return cid;
}

static CIdList readCIdList(FILE *f) {
  int i;
  int count = readInt(f);
  CIdList list = (CIdList) malloc(sizeof(struct _CIdList)+count*sizeof(CId));
  
  list->count = count;
  for (i = 0; i < count; i++) {
    list->names[i]  = readCId(f);
  }

  return list;
}

static Literal readLiteral(FILE *f) {
  int tag = readTag(f);
  switch (tag) {
    case LIT_STR:
      { 
	LiteralStr lit = (LiteralStr) malloc(sizeof(struct _LiteralStr));
        lit->_.tag = tag;
        lit->val   = readString(f);
        return ((Literal) lit);
      }
    case LIT_INT:
      { 
	LiteralInt lit = (LiteralInt) malloc(sizeof(struct _LiteralInt));
        lit->_.tag = tag;
        lit->val   = readInt(f);
        return ((Literal) lit);
      }
    case LIT_FLOAT:
      {
        LiteralFloat lit = (LiteralFloat) malloc(sizeof(struct _LiteralFloat));
        lit->_.tag = tag;
        lit->val   = readFloat(f);
        return ((Literal) lit);
      }
    default:
      __pgf_panic("Unknown literal tag");
  }
}

static Flags readFlags(FILE *f) {
  int i;
  int count = readInt(f);
  Flags flags = (Flags) malloc(sizeof(struct _Flags)+count*sizeof(struct _Flag));
  
  flags->count = count;
  for (i = 0; i < count; i++) {
    flags->values[i].name  = readCId(f);
    flags->values[i].value = readLiteral(f);
  }

  return flags;
}

static Context readContext(FILE *f);
static Type readType(FILE *f);

static Expr readExpr(FILE *f) {
  int tag = readTag(f);
  
  switch (tag) {
  case TAG_ABS:
    {
        ExprAbs e = (ExprAbs) malloc(sizeof(struct _ExprAbs));
        e->_.tag = tag;
        e->bt    = readTag(f);
        e->var   = readCId(f);
        e->body  = readExpr(f);
        return ((Expr) e);
    }
  case TAG_APP:
    {
        ExprApp e = (ExprApp) malloc(sizeof(struct _ExprApp));
        e->_.tag = tag;
        e->left  = readExpr(f);
        e->right = readExpr(f);
        return ((Expr) e);
    }
  case TAG_LIT:
    {
        ExprLit e = (ExprLit) malloc(sizeof(struct _ExprLit));
        e->_.tag = tag;
        e->lit   = readLiteral(f);
        return ((Expr) e);
    }
  case TAG_MET:
    {
        ExprMeta e = (ExprMeta) malloc(sizeof(struct _ExprMeta));
        e->_.tag = tag;
        e->id    = readInt(f);
        return ((Expr) e);
    }
  case TAG_FUN:
    {
        ExprFun e = (ExprFun) malloc(sizeof(struct _ExprFun));
        e->_.tag = tag;
        e->fun   = readCId(f);
        return ((Expr) e);
    }
  case TAG_VAR:
    {
        ExprVar e = (ExprVar) malloc(sizeof(struct _ExprVar));
        e->_.tag = tag;
        e->index = readInt(f);
        return ((Expr) e);
    }
  case TAG_TYP:
    {
        ExprTyped e = (ExprTyped) malloc(sizeof(struct _ExprTyped));
        e->_.tag = tag;
        e->e     = readExpr(f);
        e->ty    = readType(f);
        return ((Expr) e);
    }
  case TAG_IMP:
    {
        ExprImplArg e = (ExprImplArg) malloc(sizeof(struct _ExprImplArg));
        e->_.tag = tag;
        e->e     = readExpr(f);
        return ((Expr) e);
    }
  default:
    __pgf_panic("Unknown expression tag");
  }
}
	
static Type readType(FILE *f) {
  Context hypos = readContext(f);
  CId     cat   = readCId(f);
  
  int i;
  int count = readInt(f);
  Type ty = (Type) malloc(sizeof(struct _Type)+count*sizeof(Expr));
  
  ty->hypos = hypos;
  ty->cat   = cat;
  ty->nArgs = count;
  for (i = 0; i < count; i++) {
    ty->args[i]  = readExpr(f);
  }
  
  return ty;
}

static void readHypo(FILE *f, Hypo h) {
  h->bt  = readTag(f);
  h->var = readCId(f);
  h->ty  = readType(f);
}

static Context readContext(FILE *f) {
  int i;
  int size = readInt(f);
  Context ctxt = (Context) malloc(sizeof(struct _Context)+size*sizeof(struct _Hypo));
  
  ctxt->size = size;
  for (i = 0; i < size; i++) {
    readHypo(f, &ctxt->hypos[i]);
  }
  
  return ctxt;
}

static Patt readPatt(FILE *f) {
  int tag = readTag(f);

  switch (tag) {
  case TAG_PAPP:
    {
       CId fun = readCId(f);
       
       int i;
       int count = readInt(f);
       PattApp p = (PattApp) malloc(sizeof(struct _PattApp)+count*sizeof(Patt));
  
       p->_.tag      = tag;
       p->fun        = fun;
       p->args.count = count;
       for (i = 0; i < count; i++) {
         p->args.pats[i] = readPatt(f);
       }
       
       return ((Patt) p);
    }
  case TAG_PVAR:
    {
        PattVar p = (PattVar) malloc(sizeof(struct _PattVar));
        p->_.tag = tag;
        p->var   = readCId(f);
        return ((Patt) p);
    }
  case TAG_PAT:
    {
        PattAt p = (PattAt) malloc(sizeof(struct _PattAt));
        p->_.tag = tag;
        p->var   = readCId(f);
        p->pat   = readPatt(f);
        return ((Patt) p);
    }
  case TAG_PWILD:
    {
        PattWild p = (PattWild) malloc(sizeof(struct _PattWild));
        p->_.tag = tag;
        return ((Patt) p);
    }
  case TAG_PLIT:
    {
        PattLit p = (PattLit) malloc(sizeof(struct _PattLit));
        p->_.tag = tag;
        p->lit   = readLiteral(f);
        return ((Patt) p);
    }
  case TAG_PIMP:
    {
        PattImplArg p = (PattImplArg) malloc(sizeof(struct _PattImplArg));
        p->_.tag = tag;
        p->pat   = readPatt(f);
        return ((Patt) p);
    }
  case TAG_PTILDE:
    {
        PattTilde p = (PattTilde) malloc(sizeof(struct _PattTilde));
        p->_.tag = tag;
        p->e     = readExpr(f);
        return ((Patt) p);
    }
  default:
    __pgf_panic("Unknown pattern tag");
  }  
}

static Patts readPatts(FILE *f) {
  int i;
  int count = readInt(f);
  Patts pats = (Patts) malloc(sizeof(struct _Patts)+count*sizeof(Patt));
  
  pats->count = count;
  for (i = 0; i < count; i++) {
    pats->pats[i] = readPatt(f);
  }

  return pats;
}

static Equations readEquations(FILE *f) {
  int i;
  int count = readInt(f);
  Equations equs = (Equations) malloc(sizeof(struct _Equations)+count*sizeof(struct _Equation));
  
  equs->count = count;
  for (i = 0; i < count; i++) {
    equs->equs[i].lhs = readPatts(f);
    equs->equs[i].rhs = readExpr(f);
  }

  return equs;
}

static void readAbsFun(FILE *f, AbsFun fun) {
  fun->name   = readCId(f);
  fun->ty     = readType(f);
  fun->arrity = readInt(f);
  if (readTag(f) != 0)
    fun->equs   = readEquations(f);
  else
    fun->equs   = NULL;
}

static AbsFuns readAbsFuns(FILE *f) {
  int i;
  int count = readInt(f);
  AbsFuns funs = (AbsFuns) malloc(sizeof(struct _AbsFuns)+count*sizeof(struct _AbsFun));
  
  funs->count = count;
  for (i = 0; i < count; i++) {
    readAbsFun(f, &funs->lst[i]);
  }
  
  return funs;
}

static void readAbsCat(FILE *f, AbsCat cat) {
  cat->name  = readCId(f);
  cat->hypos = readContext(f);
  cat->funs  = readCIdList(f);
}

static AbsCats readAbsCats(FILE *f) {
  int i;
  int count = readInt(f);
  AbsCats cats = (AbsCats) malloc(sizeof(struct _AbsCats)+count*sizeof(struct _AbsCat));
  
  cats->count = count;
  for (i = 0; i < count; i++) {
    readAbsCat(f, &cats->lst[i]);
  }
  
  return cats;
}

static void readAbstr(FILE *f, Abstract abstr) {
  abstr->name  = readCId(f);
  abstr->flags = readFlags(f);
  abstr->funs  = readAbsFuns(f);
  abstr->cats  = readAbsCats(f);
}

static void readConcr(FILE *f, Concrete concr) {
  concr->name  = readCId(f);
  concr->flags = readFlags(f);
}

PGF readPGF(char *filename) {
  FILE *f = fopen(filename, "rb");
  if (f == NULL)
    return NULL;
    
  int maj_ver = readInt16(f);
  int min_ver = readInt16(f);
  
  Flags flags = readFlags(f);
  
  struct _Abstract abstr;
  readAbstr(f, &abstr);
  
  int nConcr = readInt(f);
  PGF pgf = (PGF) malloc(sizeof(struct _PGF)+sizeof(Concrete)*nConcr);
  
  pgf->flags    = flags;
  pgf->abstract = abstr;
  pgf->nConcr   = nConcr;
  
  int i;
//  for (i = 0; i < nConcr; i++) {
//    readConcr(f, &pgf->concretes[i]);
//  }

  fclose(f);
  return pgf;
}
