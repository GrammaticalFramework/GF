#include "../pgf.h"
#include "data.h"
#include "panic.h"
#include <stdlib.h>

static void freeCId(CId id) {
  free(id);
}

static void freeCIdList(CIdList ids) {
  int i;
  for (i = 0; i < ids->count; i++) {
    freeCId(ids->names[i]);
  }
  free(ids);
}

static void freeString(String str) {
  free(str);
}

static void freeLiteral(Literal lit) {
  switch (lit->tag) {
  case LIT_STR:
    freeString (((LiteralStr) lit)->val);
    break;
  }
  free(lit);
}

static void freeFlags(Flags flags) {
  int i;
  for (i = 0; i < flags->count; i++) {
    freeCId(flags->values[i].name);
    freeLiteral(flags->values[i].value);
  }  
  free(flags);
}

static void freeContext(Context ctxt);
static void freeType(Type ty);

static void freeExpr(Expr e0) {
	
  switch (e0->tag) {
  case TAG_ABS:
    {
        ExprAbs e = (ExprAbs) e0;
        freeCId(e->var);
        freeExpr(e->body);
    }
    break;
  case TAG_APP:
    {
        ExprApp e = (ExprApp) e0;
        freeExpr(e->left);
        freeExpr(e->right);
    }
    break;
  case TAG_LIT:
    {
        ExprLit e = (ExprLit) e0;
        freeLiteral(e->lit);
    }
    break;
  case TAG_MET:
    {
        ExprMeta e = (ExprMeta) e0;
    }
    break;
  case TAG_FUN:
    {
        ExprFun e = (ExprFun) e0;
        freeCId(e->fun);
    }
    break;
  case TAG_VAR:
    {
        ExprVar e = (ExprVar) e0;
    }
    break;
  case TAG_TYP:
    {
        ExprTyped e = (ExprTyped) e0;
        freeExpr(e->e);
        freeType(e->ty);
    }
    break;
  case TAG_IMP:
    {
        ExprImplArg e = (ExprImplArg) e0;
        freeExpr(e->e);
    }
    break;
  default:
    __pgf_panic("Unknown expression tag");
  }
  
  free(e0);
}

static void freeType(Type ty) {
  freeContext(ty->hypos);
  freeCId(ty->cat);
   
  int i;
  for (i = 0; i < ty->nArgs; i++) {
    freeExpr(ty->args[i]);
  }
  
  free(ty);
}

static void freeHypo(Hypo hypo) {
  freeCId(hypo->var);
  freeType(hypo->ty);
}

static void freeContext(Context ctxt) {
  int i;
  for (i = 0; i < ctxt->size; i++) {
    freeHypo(&ctxt->hypos[i]);
  }  
  free(ctxt);
}

static void freePatt(Patt p0) {
  switch (p0->tag) {
  case TAG_PAPP:
    {
       int i;
       PattApp p = (PattApp) p0;
  
       freeCId(p->fun);
       for (i = 0; i < p->args.count; i++) {
         freePatt(p->args.pats[i]);
       }
    }
    break;
  case TAG_PVAR:
    {
        PattVar p = (PattVar) p0;
        freeCId(p->var);
    }
    break;
  case TAG_PAT:
    {
        PattAt p = (PattAt) p0;
        freeCId(p->var);
        freePatt(p->pat);
    }
    break;
  case TAG_PWILD:
    {
        PattWild p = (PattWild) p0;
    }
    break;
  case TAG_PLIT:
    {
        PattLit p = (PattLit) p0;
        freeLiteral(p->lit);
    }
    break;
  case TAG_PIMP:
    {
        PattImplArg p = (PattImplArg) p0;
        freePatt(p->pat);
    }
    break;
  case TAG_PTILDE:
    {
        PattTilde p = (PattTilde) p0;
        freeExpr(p->e);
    }
    break;
  default:
    __pgf_panic("Unknown pattern tag");
  }
  
  free(p0);
}

static void freePatts(Patts pats) {
  int i;
  for (i = 0; i < pats->count; i++) {
    freePatt(pats->pats[i]);
  }
  free(pats);
}

static void freeEquations(Equations equs) {
  int i;
  for (i = 0; i < equs->count; i++) {
    freePatts(equs->equs[i].lhs);
    freeExpr(equs->equs[i].rhs);
  }
  free(equs);
}

static void freeAbsFun(AbsFun fun) {
  freeCId(fun->name);
  freeType(fun->ty);
  freeEquations(fun->equs);
}

static void freeAbsFuns(AbsFuns funs) {
  int i;
  for (i = 0; i < funs->count; i++) {
    freeAbsFun(&funs->lst[i]);
  }  
  free(funs);
}

static void freeAbsCat(AbsCat cat) {
  freeCId(cat->name);
  freeContext(cat->hypos);
  freeCIdList(cat->funs);
}

static void freeAbsCats(AbsCats cats) {
  int i;
  for (i = 0; i < cats->count; i++) {
    freeAbsCat(&cats->lst[i]);
  }  
  free(cats);
}

static void freeAbstract(Abstract abstr) {
  freeCId(abstr->name);
  freeFlags(abstr->flags);
  freeAbsFuns(abstr->funs);
  freeAbsCats(abstr->cats);
}

static void freeConcrete(Concrete concr) {
//  freeCId(concr->name);
//  freeFlags(concr->flags);
}

void freePGF(PGF pgf) {
  int i;
  
  freeFlags(pgf->flags);
  freeAbstract(&pgf->abstract);
  for (i = 0; i < pgf->nConcr; i++)
    freeConcrete(&pgf->concretes[i]);
  free(pgf);
}
