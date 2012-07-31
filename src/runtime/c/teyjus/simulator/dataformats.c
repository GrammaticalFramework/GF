//////////////////////////////////////////////////////////////////////////////
//Copyright 2008
//  Andrew Gacek, Steven Holte, Gopalan Nadathur, Xiaochu Qi, Zach Snow
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
/****************************************************************************/
/*                                                                          */
/* File dataformat.c.                                                       */
/* The header file identifies the low-level representation of data objects  */
/* that are manipulated by the machine, through various structure types.    */ 
/****************************************************************************/
#ifndef DATAFORMATS_C
#define DATAFORMATS_C

#include <math.h>
#include <string.h>
#include "dataformats.h"
#include "mctypes.h"
#include "mcstring.h"

/********************************************************************/
/*                                                                  */
/*                         TYPE REPRESENTATION                      */
/*                                                                  */
/********************************************************************/

/* Types of relevant fields in type representations.                */
typedef TwoBytes      DF_KstTabInd;    //kind symbol table index
typedef TwoBytes      DF_StrTypeArity; //arity of type structure
typedef TwoBytes      DF_SkelInd;      //offset of variables in type skeletons


/* Structure definitions of each type category.                     */
typedef struct                         //type sort
{
    DF_Tag            tag;
    DF_KstTabInd      kindTabIndex;
} DF_SortType;

typedef struct                         //type reference
{
    DF_Tag            tag;      
    DF_TypePtr        target;
} DF_RefType;

typedef struct                         //variables in type skeletons
{
    DF_Tag            tag;
    DF_SkelInd        offset;
} DF_SkVarType;

typedef struct                         //type arrows
{
    DF_Tag            tag;       
    DF_TypePtr        args;
} DF_ArrowType;

typedef struct                         //type functors
{
    DF_Tag            tag;
    DF_StrTypeArity   arity;
    DF_KstTabInd      kindTabIndex;
} DF_FuncType;

typedef struct                         //type structures
{
    DF_Tag            tag;       
    DF_FuncType       *funcAndArgs;
} DF_StrType;

/******************************************************************/
/*                      Interface functions                       */
/******************************************************************/

/* TYPE DEREFERENCE */
DF_TypePtr DF_typeDeref(DF_TypePtr tyPtr)
{
    DF_Type ty = *tyPtr;
    while ((ty.tag.categoryTag == DF_TY_TAG_REF)){
        DF_TypePtr target = (DF_TypePtr)(ty.dummy);
        if (tyPtr == target) return tyPtr;
        tyPtr = target;
        ty = *tyPtr;
    }
    return tyPtr;
}

/* TYPE RECOGNITION */

Boolean DF_isSortType(DF_TypePtr tyPtr) 
{   return (tyPtr->tag.categoryTag == DF_TY_TAG_SORT); }
Boolean DF_isRefType(DF_TypePtr tyPtr)  
{   return (tyPtr->tag.categoryTag == DF_TY_TAG_REF);  }
Boolean DF_isSkelVarType(DF_TypePtr tyPtr)
{   return (tyPtr->tag.categoryTag == DF_TY_TAG_SKVAR);}
Boolean DF_isArrowType(DF_TypePtr tyPtr)
{   return (tyPtr->tag.categoryTag == DF_TY_TAG_ARROW);}
Boolean DF_isStrType(DF_TypePtr tyPtr)  
{   return (tyPtr->tag.categoryTag == DF_TY_TAG_STR);  }
Boolean DF_isFreeVarType(DF_TypePtr tyPtr)
{   return ((tyPtr->tag.categoryTag == DF_TY_TAG_REF)
            && ((DF_RefType*)tyPtr)->target == tyPtr); }
    

/* TYPE DECOMPOSITION */
int DF_typeTag(DF_TypePtr tyPtr)                          //generic type
{  
    return tyPtr->tag.categoryTag;                         
}
int DF_typeKindTabIndex(DF_TypePtr tyPtr)                 //sorts
{   
    return ((DF_SortType*)tyPtr) -> kindTabIndex;         
}
int DF_typeSkelVarIndex(DF_TypePtr tyPtr)                 //skel var
{   
    return ((DF_SkVarType*)tyPtr) -> offset;               
}
DF_TypePtr DF_typeRefTarget(DF_TypePtr tyPtr)             //reference
{
    return ((DF_RefType*)tyPtr) -> target;
}
DF_TypePtr DF_typeArrowArgs(DF_TypePtr tyPtr)             //arrows
{
    return ((DF_ArrowType*)tyPtr) -> args;
}
DF_TypePtr DF_typeStrFuncAndArgs(DF_TypePtr tyPtr)        //structures
{
    return (DF_TypePtr)(((DF_StrType*)tyPtr)->funcAndArgs);
}
int DF_typeStrFuncInd(DF_TypePtr tyPtr) 
{//Note tyPtr must refer to funcAndArgs field
    return ((DF_FuncType*)tyPtr)->kindTabIndex;
}
int DF_typeStrFuncArity(DF_TypePtr tyPtr)
{//Note tyPtr must refer to funcAndArgs field
    return ((DF_FuncType*)tyPtr)->arity;
}   
DF_TypePtr DF_typeStrArgs(DF_TypePtr tyPtr)
{//Note tyPtr must refer to funcAndArgs field
    return (DF_TypePtr)(((MemPtr)tyPtr) + DF_TY_ATOMIC_SIZE);
}

/* TYPE CONSTRUCTION */
void DF_copyAtomicType(DF_TypePtr src, MemPtr dest)
{
    *((DF_TypePtr)dest) = *src;
}
void DF_mkSortType(MemPtr loc, int ind)
{
    ((DF_SortType*)loc)->tag.categoryTag = DF_TY_TAG_SORT;
    ((DF_SortType*)loc)->kindTabIndex = ind;
}
void DF_mkRefType(MemPtr loc, DF_TypePtr target)
{
    ((DF_RefType*)loc)->tag.categoryTag = DF_TY_TAG_REF;
    ((DF_RefType*)loc)->target = target;
}
void DF_mkFreeVarType(MemPtr loc)
{
    ((DF_RefType*)loc)->tag.categoryTag = DF_TY_TAG_REF;
    ((DF_RefType*)loc)->target = (DF_TypePtr)loc;
}
void DF_mkSkelVarType(MemPtr loc, int offset)
{
    ((DF_SkVarType*)loc)->tag.categoryTag = DF_TY_TAG_SKVAR;
    ((DF_SkVarType*)loc)->offset = offset;
}
void DF_mkArrowType(MemPtr loc, DF_TypePtr args)
{
    ((DF_ArrowType*)loc)->tag.categoryTag = DF_TY_TAG_ARROW;
    ((DF_ArrowType*)loc)->args = args;
}
void DF_mkStrType(MemPtr loc, DF_TypePtr funcAndArgs)
{
    ((DF_StrType*)loc)->tag.categoryTag = DF_TY_TAG_STR;
    ((DF_StrType*)loc)->funcAndArgs = (DF_FuncType*)funcAndArgs;
}
void DF_mkStrFuncType(MemPtr loc, int ind, int n)
{
    ((DF_FuncType*)loc)->tag.categoryTag = DF_TY_TAG_FUNC;
    ((DF_FuncType*)loc)->kindTabIndex = ind;
    ((DF_FuncType*)loc)->arity = n;
}

/********************************************************************/
/*                                                                  */
/*                         TERM REPRESENTATION                      */
/*                                                                  */
/********************************************************************/

/* types of relevant fields in term representions                   */
typedef TwoBytes  DF_UnivInd;   //universe count
typedef TwoBytes  DF_CstTabInd; //constant symbol table index
typedef TwoBytes  DF_Arity;     //application arity
typedef TwoBytes  DF_DBInd;     //de Bruijn ind, embed level and num of lams
typedef WordPtr   DF_StreamTabInd; 

typedef struct                  //logic variables          
{
    DF_Tag         tag;
    DF_UnivInd     univCount;
} DF_VarTerm;

typedef struct                  //de Bruijn indices
{
    DF_Tag         tag;
    DF_DBInd       index;
} DF_BVTerm;

typedef struct {                //name and universe count field for constants
    DF_UnivInd     univCount;        
    DF_CstTabInd   symTabIndex; 
} DF_NameAndUC;

typedef struct {                //constant without type association
    DF_Tag         tag; 
    Boolean        withType;        
    union {
        unsigned int       value;
        DF_NameAndUC       nameAndUC;
    } data;
} DF_ConstTerm;

typedef struct {                //constant with type association
    DF_Tag         tag; 
    Boolean        withType;        
    union {
        unsigned int    value;
        DF_NameAndUC    nameAndUC;
    } data;
    DF_TypePtr     typeEnv;
} DF_TConstTerm;

typedef struct                  //integers
{
    DF_Tag        tag;     
    long int      value;
} DF_IntTerm;

typedef struct                  //floats
{
    DF_Tag        tag;     
    float         value;
} DF_FloatTerm;

typedef struct                  //string
{
    DF_Tag        tag;
    DF_StrDataPtr value;
} DF_StrTerm;

typedef struct                  //stream
{
    DF_Tag        tag;     
    DF_StreamTabInd index;
} DF_StreamTerm;

typedef struct                  //empty list
{
    DF_Tag        tag;     
} DF_NilTerm;

typedef struct                  //reference
{
    DF_Tag        tag;     
    DF_TermPtr    target;
} DF_RefTerm;

typedef struct                  //list cons
{
    DF_Tag        tag;     
    DF_TermPtr    args;
} DF_ConsTerm;

typedef struct                  //abstractions
{
    DF_Tag        tag;     
    DF_DBInd      numOfLams;      
    DF_TermPtr    body;
} DF_LamTerm;

typedef struct                  //applications
{
    DF_Tag        tag;     
    DF_Arity      arity;
    DF_TermPtr    functor;
    DF_TermPtr    args;
} DF_AppTerm;

typedef struct                  //suspensions
{
    DF_Tag         tag;   
    DF_DBInd       ol;
    DF_DBInd       nl;
    DF_TermPtr     termSkel;
    DF_EnvPtr      envList;
} DF_SuspTerm;


//environment items
typedef struct                  //dummy environment item
{
    //Boolean           isDummy;
    DF_Tag            tag;
    DF_DBInd          embedLevel;
    DF_EnvPtr         rest;
} DF_DummyEnv;

typedef struct                  //pair environment item
{
    //Boolean          isDummy;
    DF_Tag           tag;
    DF_DBInd         embedLevel;
    DF_EnvPtr        rest;
    DF_TermPtr       term;
} DF_PairEnv;


/******************************************************************/
/*                      Interface functions                       */
/******************************************************************/

/* DEREFERENCE      */
DF_TermPtr DF_termDeref(DF_TermPtr tmPtr)
{
    while (DF_isRef(tmPtr)) tmPtr = ((DF_RefTerm*)tmPtr)->target;    
    return tmPtr;
}

/* TERM RECOGNITION */
//note ref is neither atomic nor complex
Boolean DF_isAtomic(DF_TermPtr tmPtr)  
{   return (tmPtr -> tag.categoryTag < DF_TM_TAG_REF);    }
Boolean DF_isNAtomic(DF_TermPtr tmPtr) 
{   return (tmPtr -> tag.categoryTag > DF_TM_TAG_REF);    }
Boolean DF_isFV(DF_TermPtr tmPtr)      
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_VAR);   }
Boolean DF_isConst(DF_TermPtr tmPtr)   
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_CONST); }
/*assume the tmPtr is known to be a constant */
Boolean DF_isTConst(DF_TermPtr tmPtr)  
{   return ((DF_ConstTerm*)tmPtr) -> withType;                       }
Boolean DF_isInt(DF_TermPtr tmPtr)     
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_INT);   }
Boolean DF_isFloat(DF_TermPtr tmPtr)   
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_FLOAT); }
Boolean DF_isNil(DF_TermPtr tmPtr)     
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_NIL);   }
Boolean DF_isStr(DF_TermPtr tmPtr)     
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_STR);   }
Boolean DF_isBV(DF_TermPtr tmPtr)
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_BVAR);  }
Boolean DF_isStream(DF_TermPtr tmPtr)  
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_STREAM);}
Boolean DF_isRef(DF_TermPtr tmPtr)     
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_REF);   }
Boolean DF_isCons(DF_TermPtr tmPtr)    
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_CONS);  }
Boolean DF_isLam(DF_TermPtr tmPtr)     
{   return (tmPtr -> tag.categoryTag == DF_TM_TAG_LAM);   }
Boolean DF_isApp(DF_TermPtr tmPtr)     
{   return (tmPtr-> tag.categoryTag == DF_TM_TAG_APP);    }
Boolean DF_isSusp(DF_TermPtr tmPtr)    
{   return (tmPtr-> tag.categoryTag == DF_TM_TAG_SUSP);   }
Boolean DF_isEmpEnv(DF_EnvPtr envPtr)   
{   return (envPtr == DF_EMPTY_ENV);                                 }
Boolean DF_isDummyEnv(DF_EnvPtr envPtr) 
{   return envPtr -> tag.categoryTag == DF_ENV_TAG_DUMMY; }
                                            

/* TERM DECOMPOSITION */
int DF_termTag(DF_TermPtr tmPtr)              // tag 
{
    return tmPtr -> tag.categoryTag;
}
//unbound variables
int DF_fvUnivCount(DF_TermPtr tmPtr)                //universe count
{
    return ((DF_VarTerm*)tmPtr)->univCount;
}
//constant (w/oc type associations)
int DF_constUnivCount(DF_TermPtr tmPtr)             //universe count
{
    return ((DF_ConstTerm*)tmPtr)->data.nameAndUC.univCount;
}
int DF_constTabIndex(DF_TermPtr tmPtr)              //table index
{
    return ((DF_ConstTerm*)tmPtr)->data.nameAndUC.symTabIndex;
}
//constants with type associations
DF_TypePtr DF_constType(DF_TermPtr tmPtr)           //type env
{
    return ((DF_TConstTerm*)tmPtr)->typeEnv;
}
//integer
long DF_intValue(DF_TermPtr tmPtr)                  //integer value
{
    return ((DF_IntTerm*)tmPtr)->value;
}
//float
float DF_floatValue(DF_TermPtr tmPtr)               //float value
{
    return ((DF_FloatTerm*)tmPtr)->value;
}
//string
MCSTR_Str DF_strValue(DF_TermPtr tmPtr)             //string value
{
    return (MCSTR_Str)(((MemPtr)(((DF_StrTerm*)tmPtr)->value))
                       + DF_STRDATA_HEAD_SIZE);
}
DF_StrDataPtr DF_strData(DF_TermPtr tmPtr)          //string data field
{
    return ((DF_StrTerm*)tmPtr)->value;
}
MCSTR_Str DF_strDataValue(DF_StrDataPtr tmPtr)     //acc str value from data fd
{
    return (MCSTR_Str)(((MemPtr)tmPtr) + DF_STRDATA_HEAD_SIZE);
}

//stream TEMP
WordPtr DF_streamTabIndex(DF_TermPtr tmPtr)        //stream table index
{
    return ((DF_StreamTerm*)tmPtr)->index;
}
//de Bruijn index
int DF_bvIndex(DF_TermPtr tmPtr)                    //de Bruijn index
{
    return ((DF_BVTerm*)tmPtr)->index;
}
//reference
DF_TermPtr DF_refTarget(DF_TermPtr tmPtr)           //target
{ 
    return ((DF_RefTerm*)tmPtr)->target;
}
//list cons
DF_TermPtr DF_consArgs(DF_TermPtr tmPtr)            //arg vector
{
    return ((DF_ConsTerm*)tmPtr)->args;
}
//abstraction
int DF_lamNumAbs(DF_TermPtr tmPtr)                  //embedding level
{
    return ((DF_LamTerm*)tmPtr)->numOfLams;
}
DF_TermPtr DF_lamBody(DF_TermPtr tmPtr)             //abstraction body
{
    return ((DF_LamTerm*)tmPtr)->body;
}
//application
int DF_appArity(DF_TermPtr tmPtr)                   //arity
{
    return ((DF_AppTerm*)tmPtr)->arity;
}
DF_TermPtr DF_appFunc(DF_TermPtr tmPtr)             //functor
{
    return ((DF_AppTerm*)tmPtr)->functor;
}
DF_TermPtr DF_appArgs(DF_TermPtr tmPtr)             //arg vector
{
    return ((DF_AppTerm*)tmPtr)->args;
}
//suspension
int DF_suspOL(DF_TermPtr tmPtr)                     //ol
{
    return ((DF_SuspTerm*)tmPtr)->ol;
}
int DF_suspNL(DF_TermPtr tmPtr)                     //nl
{
    return ((DF_SuspTerm*)tmPtr)->nl;
}
DF_TermPtr DF_suspTermSkel(DF_TermPtr tmPtr)        //term skeleton
{
    return ((DF_SuspTerm*)tmPtr)->termSkel;
}
DF_EnvPtr DF_suspEnv(DF_TermPtr tmPtr)              //environment list
{
    return ((DF_SuspTerm*)tmPtr)->envList;
}

//environment item (dummy/pair)
DF_EnvPtr DF_envListRest(DF_EnvPtr envPtr)          //next env item
{
    return envPtr->rest;
}
DF_EnvPtr DF_envListNth(DF_EnvPtr envPtr, int n)    //nth item 
{
    int i; 
    for (i=n; (i!=1); i--) envPtr = envPtr -> rest;
    return envPtr;
}
int DF_envIndex(DF_EnvPtr envPtr)                   //l in @l or (t,l) 
{
    return envPtr -> embedLevel;
}
//pair environment item
DF_TermPtr DF_envPairTerm(DF_EnvPtr envPtr)         //t in (t,l)
{
    return ((DF_PairEnv*)envPtr) -> term;
}

/* TERM CONSTRUCTION */
void DF_copyAtomic(DF_TermPtr src, MemPtr dest)              //copy atomic 
{
    *((DF_TermPtr)dest) = *src;
}
void DF_copyApp(DF_TermPtr src, MemPtr dest)                 //copy application
{
    *((DF_AppTerm*)dest) = *((DF_AppTerm*)src);
}
void DF_copySusp(DF_TermPtr src, MemPtr dest)                //copy suspension
{
    *((DF_SuspTerm*)dest) = *((DF_SuspTerm*)src);
}
void DF_mkVar(MemPtr loc, int uc)                            //unbound variable
{
    ((DF_VarTerm*)loc) -> tag.categoryTag = DF_TM_TAG_VAR;
    ((DF_VarTerm*)loc) -> univCount = uc;
}
void DF_mkBV(MemPtr loc, int ind)                            //de Bruijn index
{
    ((DF_BVTerm*)loc) -> tag.categoryTag = DF_TM_TAG_BVAR;
    ((DF_BVTerm*)loc) -> index = ind;
}
void DF_mkConst(MemPtr loc, int uc, int ind)                 //const 
{
    ((DF_ConstTerm*)loc) -> tag.categoryTag = DF_TM_TAG_CONST;
    ((DF_ConstTerm*)loc) -> withType = FALSE;
    (((DF_ConstTerm*)loc) -> data).nameAndUC.univCount = uc;
    (((DF_ConstTerm*)loc) -> data).nameAndUC.symTabIndex = ind;
}
void DF_mkTConst(MemPtr loc, int uc, int ind, DF_TypePtr typeEnv)        
                                                   //const with type association
{
    ((DF_TConstTerm*)loc) -> tag.categoryTag = DF_TM_TAG_CONST;
    ((DF_TConstTerm*)loc) -> withType = TRUE;
    (((DF_TConstTerm*)loc) -> data).nameAndUC.univCount = uc;
    (((DF_TConstTerm*)loc) -> data).nameAndUC.symTabIndex = ind;
    ((DF_TConstTerm*)loc) -> typeEnv = typeEnv;
}
void DF_mkInt(MemPtr loc, long value)                        //int
{
    ((DF_IntTerm*)loc) -> tag.categoryTag = DF_TM_TAG_INT;
    ((DF_IntTerm*)loc) -> value = value;
}
void DF_mkFloat(MemPtr loc, float value)                     //float
{
    ((DF_FloatTerm*)loc) -> tag.categoryTag = DF_TM_TAG_FLOAT;
    ((DF_FloatTerm*)loc) -> value = value;
}
void DF_mkStr(MemPtr loc, DF_StrDataPtr data)                //string
{
    ((DF_StrTerm*)loc) -> tag.categoryTag = DF_TM_TAG_STR;
    ((DF_StrTerm*)loc) -> value = data;
}
void DF_mkStrDataHead(MemPtr loc)                            //string data head
{
    ((DF_StrDataPtr)loc) -> tag.categoryTag = DF_TM_TAG_STRBODY;
}

void DF_mkStream(MemPtr loc, WordPtr ind)                    //stream 
{
    ((DF_StreamTerm*)loc) -> tag.categoryTag = DF_TM_TAG_STREAM;
    ((DF_StreamTerm*)loc) -> index = ind;
}
void DF_setStreamInd(DF_TermPtr tm, WordPtr ind)             //update stream ind
{
    ((DF_StreamTerm*)tm) -> index = ind;
}
void DF_mkNil(MemPtr loc)                                    //nil
{
    ((DF_NilTerm*)loc) -> tag.categoryTag = DF_TM_TAG_NIL;
}
void DF_mkRef(MemPtr loc, DF_TermPtr target)                 //reference
{
    ((DF_RefTerm*)loc) -> tag.categoryTag = DF_TM_TAG_REF;
    ((DF_RefTerm*)loc) -> target = target;
}
void DF_mkCons(MemPtr loc, DF_TermPtr args)                  //cons
{
    ((DF_ConsTerm*)loc) -> tag.categoryTag = DF_TM_TAG_CONS;
    ((DF_ConsTerm*)loc) -> args = args;
}
void DF_mkLam(MemPtr loc, int n, DF_TermPtr body)            //abstraction
{
    ((DF_LamTerm*)loc) -> tag.categoryTag = DF_TM_TAG_LAM;
    ((DF_LamTerm*)loc) -> numOfLams = n;
    ((DF_LamTerm*)loc) -> body = body;
}
void DF_mkApp(MemPtr loc, int n, DF_TermPtr func, DF_TermPtr args) 
{                                                            //application
    ((DF_AppTerm*)loc) -> tag.categoryTag = DF_TM_TAG_APP;
    ((DF_AppTerm*)loc) -> arity = n;
    ((DF_AppTerm*)loc) -> functor = func;
    ((DF_AppTerm*)loc) -> args = args;
}
void DF_mkSusp(MemPtr loc, int ol, int nl, DF_TermPtr tmPtr, DF_EnvPtr env) 
                                                             //suspension
{
    ((DF_SuspTerm*)loc) -> tag.categoryTag = DF_TM_TAG_SUSP;
    ((DF_SuspTerm*)loc) -> ol = ol;
    ((DF_SuspTerm*)loc) -> nl = nl;
    ((DF_SuspTerm*)loc) -> termSkel = tmPtr;
    ((DF_SuspTerm*)loc) -> envList = env;
}

void DF_mkDummyEnv(MemPtr loc, int l, DF_EnvPtr rest)        //@l env item
{
    ((DF_DummyEnv*)loc) -> tag.categoryTag = DF_ENV_TAG_DUMMY;
    ((DF_DummyEnv*)loc) -> embedLevel = l;
    ((DF_DummyEnv*)loc) -> rest = rest;
}
void DF_mkPairEnv(MemPtr loc, int l, DF_TermPtr t, DF_EnvPtr rest)
{ 
                                                             // (t, l) env item
    ((DF_PairEnv*)loc) -> tag.categoryTag = DF_ENV_TAG_PAIR;
    ((DF_PairEnv*)loc) -> embedLevel = l;
    ((DF_PairEnv*)loc) -> rest = rest;
    ((DF_PairEnv*)loc) -> term = t;    
}


/* TERM MODIFICATION  */
void DF_modVarUC(DF_TermPtr vPtr, int uc)
{
    ((DF_VarTerm*)vPtr) -> univCount = uc;
}


/* (NON_TRIVIAL) TERM COMPARISON */
Boolean DF_sameConsts(DF_TermPtr const1, DF_TermPtr const2)   //same constant?
{
    return (((DF_ConstTerm*)const1)->data.value == 
            ((DF_ConstTerm*)const2)->data.value);
}
Boolean DF_sameStrs(DF_TermPtr str1, DF_TermPtr str2)         //same string?
{
    if (str1 == str2) return TRUE;
    else if (((DF_StrTerm*)str1)->value == 
             ((DF_StrTerm*)str2)->value) return TRUE; //compare data fd addr
    //compare literals
    return MCSTR_sameStrs(
        (MCSTR_Str)(((MemPtr)(((DF_StrTerm*)str1)->value)) + 
                    DF_STRDATA_HEAD_SIZE),
        (MCSTR_Str)(((MemPtr)(((DF_StrTerm*)str2)->value)) +
                    DF_STRDATA_HEAD_SIZE));
    
}
Boolean DF_sameStrData(DF_TermPtr tmPtr, DF_StrDataPtr strData)
{
    if (((DF_StrTerm*)tmPtr) -> value == strData) return TRUE; //compare addr
    return MCSTR_sameStrs(
        (MCSTR_Str)(((MemPtr)(((DF_StrTerm*)tmPtr)->value)) + 
                    DF_STRDATA_HEAD_SIZE),
        (MCSTR_Str)(((MemPtr)strData) + DF_STRDATA_HEAD_SIZE));
}

/********************************************************************/
/*                                                                  */
/*                     DISAGREEMENT SET REPRESENTATION              */
/*                                                                  */
/*                    A double linked list                          */
/********************************************************************/

//create a new node at the given location
void DF_mkDisPair(MemPtr loc, DF_DisPairPtr next, DF_TermPtr first, 
                  DF_TermPtr second)
{
    ((DF_DisPairPtr)(loc)) -> tag.categoryTag = DF_DISPAIR;
    ((DF_DisPairPtr)(loc)) -> next       = next;
    ((DF_DisPairPtr)(loc)) -> firstTerm  = first;
    ((DF_DisPairPtr)(loc)) -> secondTerm = second;
}

//decomposition
DF_DisPairPtr DF_disPairNext(DF_DisPairPtr disPtr){return disPtr -> next;      }
DF_TermPtr    DF_disPairFirstTerm(DF_DisPairPtr disPtr)
{
    return disPtr -> firstTerm; 
}
DF_TermPtr    DF_disPairSecondTerm(DF_DisPairPtr disPtr)
{
    return disPtr -> secondTerm;
}

//whether a given disagreement set is empty
Boolean       DF_isEmpDisSet(DF_DisPairPtr disPtr)
{
    return (disPtr == DF_EMPTY_DIS_SET);
}

Boolean       DF_isNEmpDisSet(DF_DisPairPtr disPtr)
{
    return (disPtr != DF_EMPTY_DIS_SET);
}


#endif  //DATAFORMATS_C
