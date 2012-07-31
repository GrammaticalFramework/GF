//////////////////////////////////////////////////////////////////////////////
// This file is part of Teyjus.                                             //
//                                                                          //
// Teyjus is free software: you can redistribute it and/or modify           //
// it under the terms of the GNU General Public License as published by     //
// the Free Software Foundation, either version 3 of the License, or        //
// (at your option) any later version.                                      //
//                                                                          //
// Teyjus is distributed in the hope that it will be useful,                //
// but WITHOUT ANY WARRANTY; without even the implied warranty of           //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            //
// GNU General Public License for more details.                             //
//                                                                          //
// You should have received a copy of the GNU General Public License        //
// along with Teyjus.  If not, see <http://www.gnu.org/licenses/>.          //
//////////////////////////////////////////////////////////////////////////////
/***************************************************************************/
/* ocamlcode.c.                                                            */
/* This file defines auxiliary functions in making pervasive.mli and       */
/* pervasive.ml.                                                           */
/* Since space and time efficiency is not an important concern in the      */
/* system source code generation phase, the code here is structured in the */
/* way for the convenience of making changes on pervasive.mli{ml}.         */
/***************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ocamlcode.h"

/***************************************************************************/
/* Functions for making various language constructs                        */
/***************************************************************************/
/* Make a string of form  <first>.<second> */
static char* OC_mkDotStr(char* first, char* second)
{
  size_t length = strlen(first) + strlen(second) + 1;
  char* ptr = UTIL_mallocStr(length+1);

  strcpy(ptr, first);
  strcat(ptr, ".");
  strcat(ptr, second);

  return ptr;
}

/*
    (Some <info>)
*/
char* OC_mkSome(char* info)
{
  size_t length = strlen(info) + 10;
  char* rtptr = UTIL_mallocStr(length + 1);

  strcpy(rtptr, "(Some ");
  strcat(rtptr, info);
  strcat(rtptr, ")");

  return rtptr;
}

/*
     (ref <info>)
*/
char* OC_mkRef(char* info)
{
  size_t length = strlen(info) + 10;
  char* rtptr = UTIL_mallocStr(length + 1);

  strcpy(rtptr, "(ref ");
  strcat(rtptr, info);
  strcat(rtptr, ")");

  return rtptr;
}


/* Make a variable definition:
      let <varName> = <defs>
*/
static char* OC_mkVarDef(char* varName, char* defs)
{
  size_t length = strlen(varName) + strlen(defs) + 10;
  char* vardef = UTIL_mallocStr(length + 1);

  strcpy(vardef, "let ");
  strcat(vardef, varName);
  strcat(vardef, " = ");
  strcat(vardef, defs);

  return vardef;
}

/* Make a variable declaration:
      val <varName> : <varType>"\n"
*/
static char* OC_mkVarDec(char* varName, char* varType)
{
  size_t length = strlen(varName) + strlen(varType) + 10;
  char* vardec = UTIL_mallocStr(length + 1);

  strcpy(vardec, "val ");
  strcat(vardec, varName);
  strcat(vardec, " : ");
  strcat(vardec, varType);
  strcat(vardec, "\n");

  return vardec;
}

/* Make arrow type:
      <type1> -> <type2>
*/
static char* OC_mkArrowType(char* ty1, char* ty2)
{
  size_t length = strlen(ty1) + strlen(ty2) + 5;
  char* arrowType = UTIL_mallocStr(length);

  strcpy(arrowType, ty1);
  strcat(arrowType, " -> ");
  strcat(arrowType, ty2);
  return arrowType;
}


/**************************************************************************/
/* Names from other modules                                               */
/**************************************************************************/
/********************************************************/
/* Fixities                                             */
/********************************************************/
#define INFIX     "Absyn.Infix"
#define INFIXL    "Absyn.Infixl"
#define INFIXR    "Absyn.Infixr"
#define PREFIX    "Absyn.Prefix"
#define PREFIXR   "Absyn.Prefixr"
#define POSTFIX   "Absyn.Postfix"
#define POSTFIXL  "Absyn.Postfixl"
#define NOFIXITY  "Absyn.NoFixity"

#define MAXPREC   "maxPrec + 1"

/********************************************************/
/* module names                                         */
/********************************************************/
#define ABSYN       "Absyn"
#define SYMBOL      "Symbol"
#define ERRORMSG    "Errormsg"
#define TABLE       "Table"

/********************************************************/
/* types                                                */
/********************************************************/
//absyn
#define TY_KIND     "akind"
#define TY_CONST    "aconstant"
#define TY_TERM     "aterm"
#define TY_TYABBREV "atypeabbrev"
//table
#define TY_SYMTAB   "SymbolTable.t"

/********************************************************/
/* value constructors                                   */
/********************************************************/
//absyn
#define VCTR_KIND         "Kind"
#define VCTR_KINDTYPE     "PervasiveKind"
#define VCTR_CONSTANT     "Constant"
#define VCTR_PERVCONST    "PervasiveConstant"
#define VCTR_TYSKEL       "Skeleton"
#define VCTR_APPTYPE      "ApplicationType"
#define VCTR_ARROWTYPE    "ArrowType"
#define VCTR_SKELVARTYPE  "SkeletonVarType"
#define VCTR_BUILTIN      "Builtin"

//errormsg
#define VCTR_NULLPOS  "none"

//symbol
#define VCTR_SYMBOL        "symbol"
#define VCTR_SYMBOL_ALIAS  "symbolAlias"

//table
#define VCTR_EMPTYTAB "SymbolTable.empty"

/********************************************************/
/* functions                                            */
/********************************************************/
//table
#define FUNC_ADD       "add"
//absyn
#define FUNC_MAKETYSETVAR "makeTypeSetVariable"

/***************************************************************************/
/* Local names                                                             */
/***************************************************************************/
#define BUILDPERVKIND  "buildPervasiveKinds"
#define BUILDPERVCONST "buildPervasiveConstants"

#define PERVKIND       "pervasiveKinds"
#define PERVCONST      "pervasiveConstants"
#define PERVTYABBR     "pervasiveTypeAbbrevs"

#define KVAR_PREFIX    "k"
#define CVAR_POSTFIX   "Constant"
#define TSKVAR_PREFIX  "tyskel"
#define TAB            "t"

#define IS               "is"
#define SETVARIR         "tysetvarIR"
#define SETVARIRS        "tysetvarIRS"
#define OVERLOADTYSKEL1  "overloadTySkel1"
#define OVERLOADTYSKEL2  "overloadTySkel2"
#define OVERLOADTYSKEL3  "overloadTySkel3"

/***************************************************************************/
/* Functions for making program components                                 */
/***************************************************************************/
/*
     (Symbol.symbol "<name>")
*/
static char* OC_mkSymbol(char* name)
{
  char* symbolCtr = OC_mkDotStr(SYMBOL, VCTR_SYMBOL);
  size_t length = strlen(symbolCtr) + strlen(name) + 10;
  char* rtptr= UTIL_mallocStr(length + 1);

  strcpy(rtptr, "(");
  strcat(rtptr, symbolCtr);        free(symbolCtr);
  strcat(rtptr, " \"");
  strcat(rtptr, name);
  strcat(rtptr, "\")");
  return rtptr;
}

/*
    (Symbol.symbolAlias "<name>" "<printName>")
*/
static char* OC_mkSymbolAlias(char *name, char *printName)
{
  char* symbolCtr = OC_mkDotStr(SYMBOL, VCTR_SYMBOL_ALIAS);
  size_t length = strlen(symbolCtr) + strlen(name) + strlen(printName) + 10;
  char* rtptr= UTIL_mallocStr(length + 1);

  strcpy(rtptr, "(");
  strcat(rtptr, symbolCtr);        free(symbolCtr);
  strcat(rtptr, " \"");
  strcat(rtptr, name);
  strcat(rtptr, "\" \"");
  strcat(rtptr, printName);
  strcat(rtptr, "\")");
  return rtptr;
}

/* let t = Table.add (Symbol.symbol "<name>") <varName> t in\n
 */
char* OC_mkTabEntry(char* name, char* varName)
{
  char* entry;
  char* tableAdd  = OC_mkDotStr(TABLE, FUNC_ADD);
  char* symbol    = OC_mkSymbol(name);
  size_t length   = strlen(tableAdd) + strlen(symbol) + strlen(varName) +
    strlen(TAB) + 15;
  char* def       = UTIL_mallocStr(length + 1);

  strcpy(def, tableAdd);             free(tableAdd);
  strcat(def, " ");
  strcat(def, symbol);               free(symbol);
  strcat(def, " ");
  strcat(def, varName);
  strcat(def, " ");
  strcat(def, TAB);
  strcat(def, " in\n  ");

  entry = OC_mkVarDef(TAB, def); free(def);
  return entry;
}

/* let t = Table.SymbolTable.empty in \n*/
static char* OC_mkTabInit()
{
  char* init;
  char* emptyTab = OC_mkDotStr(TABLE, VCTR_EMPTYTAB);
  size_t length   = strlen(emptyTab) + 10;
  char* def      = UTIL_mallocStr(length + 1);

  strcpy(def, emptyTab);             free(emptyTab);
  strcat(def, " in\n  ");

  init = OC_mkVarDef(TAB, def);  free(def);

  return init;
}

/* let <funcName> = function () ->\n
   let t = Table.SymbolTable.empty in <entries> t\n\n */
static char* OC_mkBuildTabFunc(char* funcName, char* entries)
{
  char* func;
  char* inits = OC_mkTabInit();
  size_t length = strlen(entries) + strlen(TAB) + strlen(inits) + 30;
  char* def    = UTIL_mallocStr(length + 1);

  strcpy(def, "function () ->\n  ");
  strcat(def, inits);             free(inits);
  strcat(def, entries);
  strcat(def, TAB);
  strcat(def, "\n\n");

  func = OC_mkVarDef(funcName, def); free(def);

  return func;
}

/* let <tabName> = <buildFunc> ()\n\n */
static char* OC_mkTab(char* tabName, char* buildFuncName)
{
  char* tab;
  size_t length = strlen(buildFuncName) + 10;
  char* def    = UTIL_mallocStr(length + 1);

  strcpy(def, buildFuncName);
  strcat(def, " ()\n\n");

  tab = OC_mkVarDef(tabName, def);  free(def);

  return tab;
}

/* val <tabName> = Absyn.<typeName>  Table.SymbolTable.t\n */
static char* OC_mkTabDec(char* tabName, char* typeName)
{
  char* dec;
  char* symbolTab = OC_mkDotStr(TABLE, TY_SYMTAB);
  char* myType    = OC_mkDotStr(ABSYN, typeName);
  size_t length    = strlen(symbolTab) + strlen(myType) + 5;
  char* typedec   = UTIL_mallocStr(length + 1);

  strcpy(typedec, myType);        free(myType);
  strcat(typedec, " ");
  strcat(typedec, symbolTab);     free(symbolTab);
  strcat(typedec, "\n");

  dec = OC_mkVarDec(tabName, typedec); free(typedec);

  return dec;
}

/****************************************************************************/
/* functions for making pervasive kind relevant components                  */
/****************************************************************************/
/* k<name> */
char* OC_mkKVarName(char* name)
{
  return UTIL_appendStr(KVAR_PREFIX, name);
}

/* is<name> */
char* OC_mkIsKindFuncName(char* name)
{
  return UTIL_appendStr(IS, name);
}

/* val <kindVarName> : Absyn.akind \n*/
char* OC_mkKindVarDec(char* kindVarName)
{
  char* kindType = OC_mkDotStr(ABSYN, TY_KIND);
  char* dec = OC_mkVarDec(kindVarName, kindType);
  free(kindType);
  return dec;
}

/* val <funcName> : Absyn.akind -> bool */
char* OC_mkIsKindFuncDec(char* funcName)
{
  char* kindType = OC_mkDotStr(ABSYN, TY_KIND);
  char* arrowType = OC_mkArrowType(kindType, "bool");
  char* dec = OC_mkVarDec(funcName, arrowType);
  free(kindType); free(arrowType);
  return dec;
}

/* let <funcName> tm = tm == <kindVarName> */
char* OC_mkIsKindFuncDef(char* funcName, char* kindVarName)
{
  char* funchead = UTIL_mallocStr(strlen(funcName) + 3);
  char* defbody = UTIL_mallocStr(strlen(kindVarName) + 10);
  char* def;

  strcpy(funchead, funcName);
  strcat(funchead, " tm");

  strcpy(defbody, "(tm == ");
  strcat(defbody, kindVarName);
  strcat(defbody, ")");

  def = OC_mkVarDef(funchead, defbody); free(funchead); free(defbody);
  return def;
}

/*Kind variable definition:
    let <varName> = Absyn.PervasiveKind(Symbol.symbol "<kindName>",
                      (Some <arity>), ref offset, Errormsg.none)
*/
char* OC_mkKindVar(char* varName, char* kindName, char* arity, char* offset)
{
  char* kindvar;
  char* ctr    = OC_mkDotStr(ABSYN, VCTR_KIND);
  char* symbol = OC_mkSymbol(kindName);
  char* nargs  = OC_mkSome(arity);
  char* index  = OC_mkRef(offset);
  char* ktype  = OC_mkDotStr(ABSYN, VCTR_KINDTYPE);
  char* pos    = OC_mkDotStr(ERRORMSG, VCTR_NULLPOS);
  size_t length = strlen(ctr) + strlen(symbol) + strlen(nargs) +
    strlen(index) + strlen(ktype) + strlen(pos) + 10;

  char* def = UTIL_mallocStr(length + 1);

  strcpy(def, ctr);      free(ctr);
  strcat(def, "(");
  strcat(def, symbol);   free(symbol);
  strcat(def, ", ");
  strcat(def, nargs);    free(nargs);
  strcat(def, ", ");
  strcat(def, index);    free(index);
  strcat(def, ", ");
  strcat(def, ktype);    free(ktype);
  strcat(def, ", ");
  strcat(def, pos);      free(pos);
  strcat(def, ")");

  kindvar = OC_mkVarDef(varName, def);   free(def);
  return kindvar;
}

/* let buildPervasiveKinds =
   function () ->\n <inits> <entries>\n <tabName>\n\n */
char* OC_mkBuildKTabFunc(char* entries)
{
  return OC_mkBuildTabFunc(BUILDPERVKIND, entries);
}

/****************************************************************************/
/* functions for making pervasive type skeleton components                  */
/****************************************************************************/
/* Absyn.SkeletonVarType(ref <ind>)
 */
static char* genTySkelVar(char* ind)
{
  char* ctr       = OC_mkDotStr(ABSYN, VCTR_SKELVARTYPE);
  char* ref       = OC_mkRef(ind);
  size_t length    = strlen(ctr) + strlen(ref) + 5;
  char* skelVar   = UTIL_mallocStr(length + 1);

  strcpy(skelVar, ctr);        free(ctr);
  strcat(skelVar, "(");
  strcat(skelVar, ref);        free(ref);
  strcat(skelVar, ")");

  return skelVar;
}

/* Absyn.ArrowType(<type1>, <type2>)
 */
static char* genTySkelArrow(char* type1, char* type2)
{
  char* ctr       = OC_mkDotStr(ABSYN, VCTR_ARROWTYPE);
  size_t length    = strlen(ctr) + strlen(type1) + strlen(type2) + 5;
  char* arrowtype = UTIL_mallocStr(length + 1);

  strcpy(arrowtype, ctr);      free(ctr);
  strcat(arrowtype, "(");
  strcat(arrowtype, type1);
  strcat(arrowtype, ", ");
  strcat(arrowtype, type2);
  strcat(arrowtype, ")");

  return arrowtype;
}

/* Absyn.AppType(k<sortName>, <args>)
 */
static char* genTySkelApp(char* sortName, char* args)
{
  char* ctr     = OC_mkDotStr(ABSYN, VCTR_APPTYPE);
  char* sortVar = OC_mkKVarName(sortName);
  size_t length  = strlen(ctr) + strlen(sortVar) + strlen(args) + 5;
  char* apptype = UTIL_mallocStr(length + 1);

  strcpy(apptype, ctr);        free(ctr);
  strcat(apptype, "(");
  strcat(apptype, sortVar);    free(sortVar);
  strcat(apptype, ", ");
  strcat(apptype, args);
  strcat(apptype, ")");

  return apptype;
}

/* Absyn.AppType(k<sortName>, [])
 */
static char* genTySkelSort(char* sortName)
{
  return genTySkelApp(sortName, "[]");
}

//forward declaration
char* OC_genTySkel(Type args);

static char* OC_genTySkelArgs(TypeList args)
{
  size_t length;
  char* mytext1 = NULL;
  char* mytext  = NULL;
  char* oneTypeText = NULL;
  Type  oneType = args -> oneType;

  args = args -> next;
  mytext1 = OC_genTySkel(oneType);

  while (args) {
    oneType = args -> oneType;
    args    = args -> next;
    oneTypeText = OC_genTySkel(oneType);

    length  = strlen(mytext1) + strlen(oneTypeText) + 5;
    mytext  = UTIL_mallocStr(length + 1);
    strcpy(mytext, mytext1);          free(mytext1);
    strcat(mytext, " :: ");
    strcat(mytext, oneTypeText);      free(oneTypeText);
    mytext1 = mytext;
  }
  length = strlen(mytext1) + 10;
  mytext = UTIL_mallocStr(length + 1);
  strcpy(mytext, "(");
  strcat(mytext, mytext1);              free(mytext1);
  strcat(mytext, " :: [])");

  return mytext;
}

char* OC_genTySkel(Type tyskel)
{
  char* mytext1;
  char* mytext2;
  char* mytext3;

  switch(tyskel -> tag) {
  case SORT:
    {
      mytext1 = genTySkelSort(tyskel -> data.sort);
      return mytext1;
    }
  case SKVAR:
    {
      mytext1 = genTySkelVar(tyskel -> data.skvar);
      return mytext1;
    }
  case STR:
    {
      mytext1 = OC_genTySkelArgs(tyskel -> data.str.args);
      mytext2 = genTySkelApp((tyskel -> data.str.functor)->data.func.name,
			     mytext1);
      free(mytext1);
      return mytext2;
    }
  case ARROW:
    {
      mytext1 = OC_genTySkel(tyskel -> data.arrow.lop);
      mytext2 = OC_genTySkel(tyskel -> data.arrow.rop);
      mytext3 = genTySkelArrow(mytext1, mytext2);
      free(mytext1); free(mytext2);
      return mytext3;
    }
  default:
    return strdup("");
  }
}

/* tyskel<number> */
char* OC_mkTySkelVarName(char* number)
{
  return UTIL_appendStr(TSKVAR_PREFIX, number);
}

/* Type Skeleton variable definition:
      let <varName> = Some(Absyn.Skeleton(<tySkel>, ref None, ref false))
*/
char* OC_mkTYSkelVar(char* varName, char* tySkel)
{
  char* tyskelvar;
  char* ctr      = OC_mkDotStr(ABSYN, VCTR_TYSKEL);
  char* index    = OC_mkRef("None");
  char* adjust   = OC_mkRef("false");
  size_t length   = strlen(ctr) + strlen(index) + strlen(adjust) +
    strlen(tySkel) + 15;
  char* def      = UTIL_mallocStr(length + 1);
  char* somedef;

  strcpy(def, "(");
  strcat(def, ctr);      free(ctr);
  strcat(def, "(");
  strcat(def, tySkel);
  strcat(def, ", ");
  strcat(def, index);    free(index);
  strcat(def, ", ");
  strcat(def, adjust);   free(adjust);
  strcat(def, "))");

  somedef = OC_mkSome(def); free(def);
  tyskelvar = OC_mkVarDef(varName, somedef); free(somedef);

  return tyskelvar;
}


static char* OC_mkTypeSetVar(char* defaultty, char* arglist, char* tyName)
{
  char* setVar;
  char* func = OC_mkDotStr(ABSYN, FUNC_MAKETYSETVAR);
  char* def  = UTIL_mallocStr(strlen(func) + strlen(arglist) + strlen(defaultty) + 2);
  strcpy(def, func);          free(func);
  strcat(def, " ");
  strcat(def, defaultty);
  strcat(def, " ");
  strcat(def, arglist);

  setVar = OC_mkVarDef(tyName, def);  free(def);
  return setVar;
}

/*********************************************/
/* generate tyskels for overloaded constants */
/*********************************************/
static char* OC_mkTySkelRef(char* tySkel)
{
  char* ctr      = OC_mkDotStr(ABSYN, VCTR_TYSKEL);
  char* index    = OC_mkRef("None");
  char* adjust   = OC_mkRef("false");
  size_t length   = strlen(ctr) + strlen(index) + strlen(adjust) +
    strlen(tySkel) + 15;
  char* def      = UTIL_mallocStr(length + 1);
  char* somedef;
  char* ref;

  strcpy(def, "(");
  strcat(def, ctr);      free(ctr);
  strcat(def, "(");
  strcat(def, tySkel);
  strcat(def, ", ");
  strcat(def, index);    free(index);
  strcat(def, ", ");
  strcat(def, adjust);   free(adjust);
  strcat(def, "))");

  somedef = OC_mkSome(def); free(def);
  ref = OC_mkRef(somedef);  free(somedef);
  return ref;
}

char* OC_mkFixedTySkels(char* tySkels)
{
  char  *text;
      char* setvarIntReal =
	OC_mkTypeSetVar("(Absyn.ApplicationType(kint,[]))",
			"(Absyn.ApplicationType(kint,[]) :: Absyn.ApplicationType(kreal,[]) :: [])", SETVARIR);
          char* setvarIntRealStr =
	    OC_mkTypeSetVar("(Absyn.ApplicationType(kint,[]))",
			    "(Absyn.ApplicationType(kint,[]) :: Absyn.ApplicationType(kreal,[]) :: Absyn.ApplicationType(kstring, []) :: [])", SETVARIRS);
	  char *tyskelBody, *tyskelBody2;
	  char *tyskel, *tyskelText;

	  text = UTIL_appendStr(tySkels, setvarIntReal);        free(setvarIntReal);
	  tySkels = UTIL_appendStr(text, "\n");                 free(text);

	  tyskelBody = genTySkelArrow(SETVARIR, SETVARIR);
	  tyskelText = OC_mkTySkelRef(tyskelBody);
	  tyskel = OC_mkVarDef(OVERLOADTYSKEL1, tyskelText);    free(tyskelText);
	  text = UTIL_appendStr(tySkels, tyskel);               free(tyskel);
	  tySkels = UTIL_appendStr(text, "\n");                 free(text);

	  tyskelBody2 = genTySkelArrow(SETVARIR, tyskelBody);   free(tyskelBody);
	  tyskelText = OC_mkTySkelRef(tyskelBody2);             free(tyskelBody2);
	  tyskel = OC_mkVarDef(OVERLOADTYSKEL2, tyskelText);    free(tyskelText);
	  text = UTIL_appendStr(tySkels, tyskel);               free(tyskel);
	  tySkels = UTIL_appendStr(text, "\n\n");               free(text);

	  text = UTIL_appendStr(tySkels, setvarIntRealStr);   free(setvarIntRealStr);
	  tySkels = UTIL_appendStr(text, "\n");               free(text);

	  tyskelBody = genTySkelArrow(SETVARIRS, "Absyn.ApplicationType(kbool, [])");
	  tyskelBody2 = genTySkelArrow(SETVARIRS, tyskelBody); free(tyskelBody);
	  tyskelText = OC_mkTySkelRef(tyskelBody2);            free(tyskelBody2);
	  tyskel = OC_mkVarDef(OVERLOADTYSKEL3, tyskelText);   free(tyskelText);
	  text = UTIL_appendStr(tySkels, tyskel);               free(tyskel);
	  tySkels = UTIL_appendStr(text, "\n\n");               free(text);

	  return tySkels;
}

/****************************************************************************/
/* functions for making pervasive constants components                      */
/****************************************************************************/
/* <name>Constant */
char* OC_mkCVarName(char* name)
{
  return UTIL_appendStr(name, CVAR_POSTFIX);
}
/* is<name>Constant */
char* OC_mkIsConstFuncName(char* name)
{
  return UTIL_appendStr(IS, name);
}

/* val <constVarName> : Absyn.aconstant \n*/
char* OC_mkConstVarDec(char* constVarName)
{
  char* constType = OC_mkDotStr(ABSYN, TY_CONST);
  char* dec = OC_mkVarDec(constVarName, constType);
  free(constType);
  return dec;
}

/* val <funcName> : Absyn.aconstant -> bool */
char* OC_mkIsConstFuncDec(char* funcName)
{
  char* constType = OC_mkDotStr(ABSYN, TY_CONST);
  char* arrowType = OC_mkArrowType(constType, "bool");
  char* dec = OC_mkVarDec(funcName, arrowType);
  free(constType); free(arrowType);
  return dec;
}


/* let <funcName> tm = tm == <constVarName> */
char* OC_mkIsConstFuncDef(char* funcName, char* constVarName)
{
  char* funchead = UTIL_mallocStr(strlen(funcName) + 3);
  char* defbody = UTIL_mallocStr(strlen(constVarName) + 10);
  char* def;

  strcpy(funchead, funcName);
  strcat(funchead, " tm");

  strcpy(defbody, "(tm == ");
  strcat(defbody, constVarName);
  strcat(defbody, ")");

  def = OC_mkVarDef(funchead, defbody); free(funchead); free(defbody);
  return def;
}

/* (ref fixity) */
static char* OC_mkFixity(OP_Fixity fixity)
{
  switch (fixity){
  case OP_INFIX        : return OC_mkRef(strdup(INFIX));
  case OP_INFIXL       : return OC_mkRef(strdup(INFIXL));
  case OP_INFIXR       : return OC_mkRef(strdup(INFIXR));
  case OP_PREFIX       : return OC_mkRef(strdup(PREFIX));
  case OP_PREFIXR      : return OC_mkRef(strdup(PREFIXR));
  case OP_POSTFIX      : return OC_mkRef(strdup(POSTFIX));
  case OP_POSTFIXL     : return OC_mkRef(strdup(POSTFIXL));
  case OP_NONE         : return OC_mkRef(strdup(NOFIXITY));
  default              : return OC_mkRef(strdup(NOFIXITY));
  }
}

/* (ref prec) */
static char* OC_mkPrec(OP_Prec prec)
{
  char* precNum;
  char* precText;
  if (OP_precIsMax(prec)) {
    char* temp = OC_mkDotStr(ABSYN, MAXPREC);
    precNum = UTIL_mallocStr(strlen(temp) + 2);
    strcpy(precNum, "(");
    strcat(precNum, temp);
    strcat(precNum, ")");
  } else precNum = UTIL_itoa(prec.data.prec);
  precText = OC_mkRef(precNum); free(precNum);
  return precText;
}

/* (ref true/false ) */
static char* OC_mkRefBool(UTIL_Bool value)
{
  if (value) return OC_mkRef("true");
  else return OC_mkRef("false");
}

static char* OC_mkRefInt(int value)
{
  char* valueText = UTIL_itoa(value);
  char* text = OC_mkRef(valueText);
  free(valueText);
  return text;
}

static char* OC_mkCodeInfo(OP_Code codeInfo)
{
  char* code;
  char* ref;
  if (OP_codeInfoIsNone(codeInfo)) {
    code = strdup("None");
  } else {
    char* codeInd = UTIL_itoa(codeInfo);
    char* ctr     = OC_mkDotStr(ABSYN, VCTR_BUILTIN);
    char* codeText = UTIL_mallocStr(strlen(codeInd) + strlen(ctr) + 10);
    strcpy(codeText, "(");
    strcat(codeText, ctr);           free(ctr);
    strcat(codeText, "(");
    strcat(codeText, codeInd);       free(codeInd);
    strcat(codeText, "))");
    code = OC_mkSome(codeText);      free(codeText);
  }
  ref  = OC_mkRef(code);   free(code);
  return ref;
}

static char* OC_mkConstCat(UTIL_Bool redef)
{
  char* ctr = OC_mkDotStr(ABSYN,VCTR_PERVCONST);
  char* boolValue;
  char* cat;
  char* ref;

  if (redef) boolValue = strdup("true");
  else boolValue = strdup("false");

  cat = UTIL_mallocStr(strlen(ctr) + strlen(boolValue) + 10);
  strcpy(cat, "(");
  strcat(cat, ctr);         free(ctr);
  strcat(cat, "(");
  strcat(cat, boolValue);   free(boolValue);
  strcat(cat, "))");

  ref = OC_mkRef(cat);      free(cat);
  return ref;
}

static char* OC_mkSkelNeededness(int tyenvsize)
{
  char* length = UTIL_itoa(tyenvsize);
  char* some;
  char* ref;
  char* init = UTIL_mallocStr(strlen(length) + 20);
  strcpy(init, "(Array.make ");
  strcat(init, length);  free(length);
  strcat(init, " true)");

  some = OC_mkSome(init);  free(init);
  ref = OC_mkRef(some);    free(some);
  return ref;
}

static char* OC_mkNeededness(int neededness, int tyenvsize)
{
  char* length = UTIL_itoa(tyenvsize);
  char* init;
  char* some;
  char* ref;

  if (neededness == tyenvsize) {
    init = UTIL_mallocStr(strlen(length) + 20);
    strcpy(init, "(Array.make ");
    strcat(init, length);            free(length);
    strcat(init, " true)");
  } else {
    char* num = UTIL_itoa(neededness);
    init = UTIL_mallocStr(strlen(length) + strlen(num) + 60);
    strcpy(init, "(Array.init ");
    strcat(init, length);            free(length);
    strcat(init, " (fun x -> if x >= ");
    strcat(init, num);               free(num);
    strcat(init, " then false else true))");
  }
  some = OC_mkSome(init);    free(init);
  ref  = OC_mkRef(some);     free(some);
  return ref;
}


static char* OC_mkConstVarText(char* constName, char* fixity, char* prec,
			       char* typrev, char* tyskel, char* tyenvsize,
			       char* skelneededness, char* neededness, char* codeinfo,
			       char* constcat, char* varname, char* offset, 
			       char* printName)
{
  char* constVar;
  char* ctr      = OC_mkDotStr(ABSYN, VCTR_CONSTANT);
  char* symbol   = OC_mkSymbolAlias(constName, printName);
  char* refFalse = OC_mkRef("false");
  char* refTrue  = OC_mkRef("true");
  char* index    = OC_mkRef(offset);
  char* pos      = OC_mkDotStr(ERRORMSG, VCTR_NULLPOS);

  size_t length   = strlen(ctr) + strlen(symbol) + strlen(fixity) +
    strlen(prec) + strlen(typrev) + strlen(tyskel) + strlen(tyenvsize) +
    strlen(skelneededness) + strlen(neededness) + strlen(codeinfo) +
    strlen(constcat) + strlen(index) + strlen(pos) + strlen(refFalse) * 6 + 35;
  char* def      = UTIL_mallocStr(length);

  strcpy(def, ctr);            free(ctr);
  strcat(def, "(");
  strcat(def, symbol);         free(symbol);
  strcat(def, ", ");
  strcat(def, fixity);
  strcat(def, ", ");
  strcat(def, prec);
  strcat(def, ", ");
  strcat(def, refFalse);
  strcat(def, ", ");
  strcat(def, refFalse);
  strcat(def, ", ");
  strcat(def, refTrue);        free(refTrue); /*  no defs */
  strcat(def, ", ");
  strcat(def, refFalse);
  strcat(def, ", ");
  strcat(def, typrev);
  strcat(def, ", ");
  strcat(def, refFalse);       free(refFalse);
  strcat(def, ", ");
  strcat(def, tyskel);
  strcat(def, ", ");
  strcat(def, tyenvsize);
  strcat(def, ", ");
  strcat(def, skelneededness);
  strcat(def, ", ");
  strcat(def, neededness);
  strcat(def, ", ");
  strcat(def, codeinfo);
  strcat(def, ", ");
  strcat(def, constcat);
  strcat(def, ", ");
  strcat(def, index);          free(index);
  strcat(def, ", ");
  strcat(def, pos);            free(pos);
  strcat(def, ")");

  constVar = OC_mkVarDef(varname, def); free(def);
  return constVar;
}

/* Constant variable definition :
   let <varName> = Absyn.Constant(Symbol.symbolAlias "<constName>" "<printName>", 
             ref <fixity>, ref <prec>, ref false, ref false, ref false, ref false,
             ref false,  ref <typrev>, ref false, ref <tySkel>,
	     ref <tyenvsize>, ref (Some <skelneededness>),	     
             ref (Some <neededness>), ref <codeInfo>,
	     ref <constantCat>, ref 0, Errormsg.none)
*/
char* OC_mkConstVar(char* constName, OP_Fixity fixity, OP_Prec prec,
		    UTIL_Bool typrev, char* tySkel, int tyenvsize,
		    int neededness, OP_Code codeInfo, UTIL_Bool reDef,
		    char* varName, char* offset, char* printName)
{
  char* constVar;
  char* fixityText         = OC_mkFixity(fixity);
  char* precText           = OC_mkPrec(prec);
  char* typrevText         = OC_mkRefBool(typrev);
  char* tySkelText         = OC_mkRef(tySkel);
  char* tyenvsizeText      = OC_mkRefInt(tyenvsize);
  char* skelneedednessText = OC_mkSkelNeededness(tyenvsize);
  char* needednessText     = OC_mkNeededness(neededness, tyenvsize);
  char* codeInfoText       = OC_mkCodeInfo(codeInfo);
  char* constCatText       = OC_mkConstCat(reDef);

  constVar = OC_mkConstVarText(constName, fixityText, precText,
			       typrevText, tySkelText, tyenvsizeText,
			       skelneedednessText, needednessText, codeInfoText,
			       constCatText, varName, offset, printName);

  free(fixityText); free(precText); free(typrevText); free(tySkelText);
  free(tyenvsizeText); free(skelneedednessText); free(needednessText);
  free(codeInfoText); free(constCatText);

  return constVar;
}

#define GENERICAPPLY     "genericApplyConstant"
#define OVERLOADUMINUS   "overloadUMinusConstant"
#define OVERLOADABS      "overloadAbsConstant"
#define OVERLOADPLUS     "overloadPlusConstant"
#define OVERLOADMINUS    "overloadMinusConstant"
#define OVERLOADTIME     "overloadTimeConstant"
#define OVERLOADLT       "overloadLTConstant"
#define OVERLOADGT       "overloadGTConstant"
#define OVERLOADLE       "overloadLEConstant"
#define OVERLOADGE       "overloadGEConstant"

static char* OC_mkOverLoadConstVar(char* name, char* fixity, char* prec,
				   char* tyskel, char* varName)
{
  char* constVar;
  constVar = OC_mkConstVarText(name, fixity, prec, "ref true", tyskel,
			       "ref 0", "ref(Some(Array.make 0 true))", "ref None", "ref None",
			       "ref(Absyn.PervasiveConstant(false))",
			       varName, "0", name);
  return constVar;
}

/* generate fixed constants */
char* OC_mkGenericConstVar(char* varList)
{
  char* text;
  char* constVar;

  constVar = OC_mkConstVarText(" apply", "ref Absyn.Infixl",
			       "ref (Absyn.maxPrec + 2)", "ref false",
			       "ref(Some(Absyn.Skeleton(Absyn.ErrorType, ref None, ref false)))",
			       "ref 0", "ref(Some(Array.make 0 true))", "ref None", "ref None",
			       "ref(Absyn.PervasiveConstant(false))", GENERICAPPLY, "0", 
			       " apply");
  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);

  constVar = OC_mkOverLoadConstVar("~", "ref Absyn.Prefix",
				   "ref (Absyn.maxPrec + 1)", OVERLOADTYSKEL1,
				   OVERLOADUMINUS);
  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);

  
  constVar =  OC_mkConstVarText("abs", "ref Absyn.NoFixity", 
				"ref 0", "ref true", 
				OVERLOADTYSKEL1,
				"ref 0", "ref(Some(Array.make 0 true))", 
				"ref None", "ref None",
				"ref(Absyn.PervasiveConstant(true))",
				OVERLOADABS, "0", "abs");

  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);
  

  constVar = OC_mkOverLoadConstVar("+", "ref Absyn.Infixl", "ref 150",
				   OVERLOADTYSKEL2, OVERLOADPLUS);
  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);

  constVar = OC_mkOverLoadConstVar("-", "ref Absyn.Infixl", "ref 150",
				   OVERLOADTYSKEL2, OVERLOADMINUS);
  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);

  constVar = OC_mkOverLoadConstVar("*", "ref Absyn.Infixl", "ref 160",
				   OVERLOADTYSKEL2, OVERLOADTIME);
  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);

  constVar = OC_mkOverLoadConstVar("<", "ref Absyn.Infix", "ref 130",
				   OVERLOADTYSKEL3, OVERLOADLT);
  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);

  constVar = OC_mkOverLoadConstVar(">", "ref Absyn.Infix", "ref 130",
				   OVERLOADTYSKEL3, OVERLOADGT);
  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);

  constVar = OC_mkOverLoadConstVar("<", "ref Absyn.Infix", "ref 130",
				   OVERLOADTYSKEL3, OVERLOADLE);
  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);

  constVar = OC_mkOverLoadConstVar(">=", "ref Absyn.Infix", "ref 130",
				   OVERLOADTYSKEL3, OVERLOADGE);
  text = UTIL_appendStr(varList, constVar);   free(constVar);
  varList = UTIL_appendStr(text, "\n\n");       free(text);
  return varList;
}

/* generate fixed constants decs */
char* OC_mkGenericConstVarDec(char* decList)
{
  char* text;
  char* dec;

  dec = OC_mkConstVarDec(GENERICAPPLY);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;

  dec = OC_mkConstVarDec(OVERLOADUMINUS);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;

  
  dec = OC_mkConstVarDec(OVERLOADABS);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;
  

  dec = OC_mkConstVarDec(OVERLOADPLUS);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;

  dec = OC_mkConstVarDec(OVERLOADMINUS);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;

  dec = OC_mkConstVarDec(OVERLOADTIME);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;

  dec = OC_mkConstVarDec(OVERLOADLT);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;

  dec = OC_mkConstVarDec(OVERLOADGT);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;

  dec = OC_mkConstVarDec(OVERLOADLE);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;

  dec = OC_mkConstVarDec(OVERLOADGE);
  text = UTIL_appendStr(decList, dec);   free(decList); free(dec);
  decList = text;

  return decList;
}


/* generate fixed constants entry in buildConstant function */
char* OC_mkGenericConstTabEntry(char* entries)
{
  char* text;
  char* tabEntry;

  tabEntry = OC_mkTabEntry("~", OVERLOADUMINUS);
  text = UTIL_appendStr(entries, tabEntry);
  free(tabEntry); free(entries);
  entries = text;

  
  tabEntry = OC_mkTabEntry("abs", OVERLOADABS);
  text = UTIL_appendStr(entries, tabEntry);
  free(tabEntry); free(entries);
  entries = text;
  

  tabEntry = OC_mkTabEntry("+", OVERLOADPLUS);
  text = UTIL_appendStr(entries, tabEntry);
  free(tabEntry); free(entries);
  entries = text;

  tabEntry = OC_mkTabEntry("-", OVERLOADMINUS);
  text = UTIL_appendStr(entries, tabEntry);
  free(tabEntry); free(entries);
  entries = text;

  tabEntry = OC_mkTabEntry("*", OVERLOADTIME);
  text = UTIL_appendStr(entries, tabEntry);
  free(tabEntry); free(entries);
  entries = text;

  tabEntry = OC_mkTabEntry("<", OVERLOADLT);
  text = UTIL_appendStr(entries, tabEntry);
  free(tabEntry); free(entries);
  entries = text;

  tabEntry = OC_mkTabEntry(">", OVERLOADGT);
  text = UTIL_appendStr(entries, tabEntry);
  free(tabEntry); free(entries);
  entries = text;

  tabEntry = OC_mkTabEntry("<=", OVERLOADLE);
  text = UTIL_appendStr(entries, tabEntry);
  free(tabEntry); free(entries);
  entries = text;

  tabEntry = OC_mkTabEntry(">=", OVERLOADGE);
  text = UTIL_appendStr(entries, tabEntry);
  free(tabEntry); free(entries);
  entries = text;

  return entries;
}

/* let buildPervasiveKinds =
   function () ->\n <inits> <entries>\n <tabName>\n\n */
char* OC_mkBuildCTabFunc(char* entries)
{
  return OC_mkBuildTabFunc(BUILDPERVCONST, entries);
}

/* make generaic const is function decs */
char* OC_mkGenericConstFuncDecs(char* funcDefs)
{
  char* funcName;
  char* def;
  char* text;

  funcName = OC_mkIsConstFuncName(GENERICAPPLY);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;

  funcName = OC_mkIsConstFuncName(OVERLOADUMINUS);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;

  
  funcName = OC_mkIsConstFuncName(OVERLOADABS);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;
  

  funcName = OC_mkIsConstFuncName(OVERLOADPLUS);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;

  funcName = OC_mkIsConstFuncName(OVERLOADMINUS);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;

  funcName = OC_mkIsConstFuncName(OVERLOADTIME);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;

  funcName = OC_mkIsConstFuncName(OVERLOADLT);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;

  funcName = OC_mkIsConstFuncName(OVERLOADGT);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;

  funcName = OC_mkIsConstFuncName(OVERLOADLE);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;

  funcName = OC_mkIsConstFuncName(OVERLOADGE);
  def = OC_mkIsConstFuncDec(funcName);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = text;

  return funcDefs;
}


/* make generaic const is function defs */
char* OC_mkGenericConstFuncDefs(char* funcDefs)
{
  char* funcName;
  char* def;
  char* text;

  funcName = OC_mkIsConstFuncName(GENERICAPPLY);
  def = OC_mkIsConstFuncDef(funcName, GENERICAPPLY);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);


  funcName = OC_mkIsConstFuncName(OVERLOADUMINUS);
  def = OC_mkIsConstFuncDef(funcName, OVERLOADUMINUS);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);

  
  funcName = OC_mkIsConstFuncName(OVERLOADABS);
  def = OC_mkIsConstFuncDef(funcName, OVERLOADABS);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);
  

  funcName = OC_mkIsConstFuncName(OVERLOADPLUS);
  def = OC_mkIsConstFuncDef(funcName, OVERLOADPLUS);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);

  funcName = OC_mkIsConstFuncName(OVERLOADMINUS);
  def = OC_mkIsConstFuncDef(funcName, OVERLOADMINUS);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);

  funcName = OC_mkIsConstFuncName(OVERLOADTIME);
  def = OC_mkIsConstFuncDef(funcName, OVERLOADTIME);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);

  funcName = OC_mkIsConstFuncName(OVERLOADLT);
  def = OC_mkIsConstFuncDef(funcName, OVERLOADLT);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);

  funcName = OC_mkIsConstFuncName(OVERLOADGT);
  def = OC_mkIsConstFuncDef(funcName, OVERLOADGT);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);

  funcName = OC_mkIsConstFuncName(OVERLOADLE);
  def = OC_mkIsConstFuncDef(funcName, OVERLOADLE);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);

  funcName = OC_mkIsConstFuncName(OVERLOADGE);
  def = OC_mkIsConstFuncDef(funcName, OVERLOADGE);   free(funcName);
  text = UTIL_appendStr(funcDefs, def);  free(def); free(funcDefs);
  funcDefs = UTIL_appendStr(text, "\n\n"); free(text);

  return funcDefs;
}

char* OC_mkCompare(char* name)
{
  char* text = UTIL_mallocStr(strlen(name) + 15);
  strcpy(text, "(const == ");
  strcat(text, name);
  strcat(text, ")");
  return text;
}


char* OC_mkOr(char* operandl, char* operandr)
{
  char* text = UTIL_mallocStr(strlen(operandl) + strlen(operandr) + 5);
  strcpy(text, operandl);
  strcat(text, " || ");
  strcat(text, operandr);

  return text;
}


#define PERV_REGCLOB_DEF_BEG "let regClobberingPerv const =  \n  if ("
#define PERV_REGCLOB_DEF_END ") then true else false \n\n"
char* OC_mkRegClobFunc(char* body)
{
  char* text = UTIL_mallocStr(strlen(PERV_REGCLOB_DEF_BEG) + strlen(body) +
			      strlen(PERV_REGCLOB_DEF_END));
  strcpy(text, PERV_REGCLOB_DEF_BEG);
  strcat(text, body);
  strcat(text, PERV_REGCLOB_DEF_END);

  return text;
}

#define PERV_BCK_DEF_BEG "let backtrackablePerv const =  \n  if ("
#define PERV_BCK_DEF_END ") then true else false \n\n"
char* OC_mkBackTrackFunc(char* body)
{
  char* text = UTIL_mallocStr(strlen(PERV_BCK_DEF_BEG) + strlen(body) +
			      strlen(PERV_BCK_DEF_END));
  strcpy(text, PERV_BCK_DEF_BEG);
  strcat(text, body);
  strcat(text, PERV_BCK_DEF_END);

  return text;
}



/*****************************************************************************/
/* functions for making the fixed part of pervasive.mli                      */
/*****************************************************************************/
#define TERM_DECS \
"val implicationTerm : Absyn.aterm\nval andTerm : Absyn.aterm\n"

#define PERV_FUNC_DECS \
"val isPerv : Absyn.aconstant -> bool                                          \nval regClobberingPerv : Absyn.aconstant -> bool                                \nval backtrackablePerv : Absyn.aconstant -> bool\n"

/*
     val pervasiveKinds : Absyn.akind  Table.SymbolTable.t
        val pervasiveConstants : Absyn.aconstant Table.SymbolTable.t
	   val pervasiveTypeAbbrevs : Absyn.atypeabbrev Table.SymbolTable.t
*/
char* OC_mkFixedMLI()
{
  char* kindDec    = OC_mkTabDec(PERVKIND, TY_KIND);
  char* constDec   = OC_mkTabDec(PERVCONST, TY_CONST);
  char* tyabbrDec  = OC_mkTabDec(PERVTYABBR, TY_TYABBREV);
  size_t length     = strlen(kindDec) + strlen(constDec) + strlen(tyabbrDec) +
    strlen(TERM_DECS) + strlen(PERV_FUNC_DECS) + 10;
  char* decs       = UTIL_mallocStr(length + 1);

  strcpy(decs, kindDec);     free(kindDec);
  strcat(decs, constDec);    free(constDec);
  strcat(decs, tyabbrDec);   free(tyabbrDec);
  strcat(decs, "\n");
  strcat(decs, TERM_DECS);
  strcat(decs, "\n");
  strcat(decs, PERV_FUNC_DECS);
  strcat(decs, "\n");

  return decs;
}

/*****************************************************************************/
/* functions for making the fixed part of pervasive.ml                       */
/*****************************************************************************/
#define TERM_DEFS \
"let andTerm = Absyn.ConstantTerm(andConstant, [], false, Errormsg.none)       \nlet implicationTerm = Absyn.ConstantTerm(implConstant, [], false, Errormsg.none)\n"

#define PERV_ISPERV_DEF \
"let isPerv const =                                                            \n  let constCat = Absyn.getConstantType(const) in                                \n  match constCat with                                                          \n   Absyn.PervasiveConstant(_) -> true                                        \n  | _ -> false                                                                 \n"

/*
     let pervasiveKinds = buildPervasiveKinds ()
        let pervasiveConstants = buildPervasiveConstants ()
	   let pervasiveTypeAbbrevs = Table.SymbolTable.empty
*/
char* OC_mkFixedML()
{
  char* kindDef     = OC_mkTab(PERVKIND, BUILDPERVKIND);
  char* constDef    = OC_mkTab(PERVCONST, BUILDPERVCONST);
  char* emptyTab    = OC_mkDotStr(TABLE, VCTR_EMPTYTAB);
  char* tyabbrDef   = OC_mkVarDef(PERVTYABBR, emptyTab);
  size_t length      = strlen(kindDef) + strlen(constDef) + strlen(tyabbrDef) +
    strlen(TERM_DEFS)  + strlen(PERV_ISPERV_DEF)  + 10;
  char* defs        = UTIL_mallocStr(length + 1);

  free(emptyTab);
  strcpy(defs, kindDef);      free(kindDef);
  strcat(defs, constDef);     free(constDef);
  strcat(defs, tyabbrDef);    free(tyabbrDef);
  strcat(defs, "\n\n");
  strcat(defs, TERM_DEFS);
  strcat(defs, "\n");
  strcat(defs, PERV_ISPERV_DEF);
  strcat(defs, "\n");

  return defs;
}
