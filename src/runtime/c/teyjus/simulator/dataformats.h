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
/* File dataformat.h.                                                       */
/* The header file identifies the low-level representation of data objects  */
/* that are manipulated by the machine, through various structure types.    */ 
/****************************************************************************/
#ifndef DATAFORMATS_H
#define DATAFORMATS_H

#include <limits.h>           // to be removed
#include <stdlib.h>
//#include <math.h>
#include "mctypes.h"
#include "mcstring.h"

/********************************************************************/
/*   DATA TAG FIELD IN TYPES AND TERMS                              */
/********************************************************************/

/* The first byte is assumed to contain a type or term category tag, 
   and the second is to be used for marking in garbage collection   */
typedef struct 
{
    Byte   categoryTag;
    Byte   mark;                    //to be used in garbage collection
} DF_Tag;

/* The tags of heap items */
typedef enum
{
    //type categories
    DF_TY_TAG_SORT = 0,       //sort
    DF_TY_TAG_REF,            //reference
    DF_TY_TAG_SKVAR,          //skeleton variable
    DF_TY_TAG_ARROW,          //type arrow
    DF_TY_TAG_STR,            //type structure
    DF_TY_TAG_FUNC,           //functor of type structure

    //term categories
    DF_TM_TAG_VAR  = 6,       // existential variables
    DF_TM_TAG_CONST,          // constants 
    DF_TM_TAG_INT,            // integers
    DF_TM_TAG_FLOAT,          // floats
    DF_TM_TAG_NIL,            // empty lists
    DF_TM_TAG_STR,            // strings
    DF_TM_TAG_STREAM,         // streams
    DF_TM_TAG_BVAR,           // lambda bound variables (de Bruijn index)
                              // -- atoms above
    DF_TM_TAG_REF,            // references
                              // -- complex terms below
    DF_TM_TAG_CONS,           // list constructors
    DF_TM_TAG_LAM,            // abstractions
    DF_TM_TAG_APP,            // applications
    DF_TM_TAG_SUSP,           // suspensions

    DF_TM_TAG_STRBODY = 19,   // string body

    //suspension environment items 
    DF_ENV_TAG_DUMMY = 20,    //dummy environment
    DF_ENV_TAG_PAIR,          //pair environment 
    
    //disagreement pair
    DF_DISPAIR = 22           
} DF_HeapDataCategory;


/********************************************************************/
/*                                                                  */
/*                         TYPE REPRESENTATION                      */
/*                                                                  */
/********************************************************************/

/********************************************************************/
/* Only generic types are visible from outside.                     */
/* The "public" information for each specific type category is their*/
/* sizes. Their structure declarations are hidden in dataformat.c.  */
/* Construction, recognization and decomposition of types should be */
/* performed through interface functions with declarations present  */
/* in this file.                                                    */
/********************************************************************/

/*
//type categories
enum DF_TypeCategory
{
    DF_TY_TAG_SORT,  //sort
    DF_TY_TAG_REF,   //reference
    DF_TY_TAG_SKVAR, //skeleton variable
    DF_TY_TAG_ARROW, //type arrow
    DF_TY_TAG_STR    //type structure
};
*/

//generic type (head) for every category
typedef struct               
{
    DF_Tag          tag;     /* the common field for every type (head); can 
                                be any one of enum TypeCategory.
                                rely on struct alignment */ 
    Word            dummy;   /* a place holder which enforces the size of the 
                                generic term to be 2 words. */
} DF_Type;

typedef DF_Type *DF_TypePtr;      //type pointer

//sizes of different type items
#define DF_TY_ATOMIC_SIZE    2    //atomic size

//attributes of special type constructors
#define DF_TY_ARROW_ARITY    2    //arity of type arrow


/******************************************************************/
/*                      Interface functions                       */
/******************************************************************/

/* TYPE DEREFERENCE */
DF_TypePtr DF_typeDeref(DF_TypePtr);

/* TYPE RECOGNITION */
Boolean DF_isSortType(DF_TypePtr);     // is sort?
Boolean DF_isRefType(DF_TypePtr);      // is reference? (including free var)
Boolean DF_isFreeVarType(DF_TypePtr);  // is free var?
Boolean DF_isSkelVarType(DF_TypePtr);  // is skeleton var?
Boolean DF_isArrowType(DF_TypePtr);    // is type arrow?
Boolean DF_isStrType(DF_TypePtr);      // is type structure?

/* TYPE DECOMPOSITION */
int DF_typeTag(DF_TypePtr);                      //generic type
int DF_typeKindTabIndex(DF_TypePtr);             //sorts
int DF_typeSkelVarIndex(DF_TypePtr);             //skel var
DF_TypePtr DF_typeRefTarget(DF_TypePtr);         //reference
DF_TypePtr DF_typeArrowArgs(DF_TypePtr);         //arrows
DF_TypePtr DF_typeStrFuncAndArgs(DF_TypePtr);    //structures
int DF_typeStrFuncInd(DF_TypePtr);           
int DF_typeStrFuncArity(DF_TypePtr); 
DF_TypePtr DF_typeStrArgs(DF_TypePtr);

/* TYPE CONSTRUCTION */
void DF_copyAtomicType(DF_TypePtr src, MemPtr dest);
void DF_mkSortType(MemPtr loc, int ind);
void DF_mkRefType(MemPtr loc, DF_TypePtr target);
void DF_mkFreeVarType(MemPtr loc);
void DF_mkSkelVarType(MemPtr loc, int offset);
void DF_mkArrowType(MemPtr loc, DF_TypePtr args);
void DF_mkStrType(MemPtr loc, DF_TypePtr funcAndArgs);
void DF_mkStrFuncType(MemPtr loc, int ind, int n);


/********************************************************************/
/*                                                                  */
/*                         TERM REPRESENTATION                      */
/*                                                                  */
/********************************************************************/

/********************************************************************/
/* Only generic terms (environment items) are visible from outside. */
/* The "public" information for each specific term category is their*/
/* sizes. Their structure declarations are hidden in dataformat.c.  */
/* Construction, recognization and decomposition of terms should be */
/* performed through interface functions with declarations present  */
/* in this file.                                                    */
/********************************************************************/

/* 
//term categories
enum DF_TermCategory 
{ 
    DF_TM_TAG_VAR,            // existential variables
    DF_TM_TAG_CONST,          // constants 
    DF_TM_TAG_INT,            // integers
    DF_TM_TAG_FLOAT,          // floats
    DF_TM_TAG_NIL,            // empty lists
    DF_TM_TAG_STR,            // strings
    DF_TM_TAG_STREAM,         // streams
    DF_TM_TAG_BVAR,           // lambda bound variables (de Bruijn index)
                              // -- atoms above
    DF_TM_TAG_REF,            // references
                              // -- complex terms below
    DF_TM_TAG_CONS,           // list constructors
    DF_TM_TAG_LAM,            // abstractions
    DF_TM_TAG_APP,            // applications
    DF_TM_TAG_SUSP            // suspensions
};
*/

// a generic term (head) for every category
typedef struct               
{
    DF_Tag       tag;        /* the common field for every term (head); can 
                                be any one of enum TermCategory.
                                rely on struct alignment */
    Word         dummy;      /* a place holder which enforces the size of the 
                                generic term to be 2 words. */
} DF_Term;

typedef DF_Term *DF_TermPtr; //term pointer

//sizes of different term items
#define DF_TM_ATOMIC_SIZE  2       // atomic size
#define DF_TM_TCONST_SIZE  3       // type associated constant (config set) 
#define DF_TM_APP_SIZE     3       // application head
#define DF_TM_LAM_SIZE     2       // abstraction
#define DF_TM_CONS_SIZE    2       // cons 
#define DF_TM_SUSP_SIZE    4       // suspension               (config set)

// attributes of some special constants 
#define  DF_CONS_ARITY     2       //arity of cons

// head of string body (a tag word should be followed by encoding of literals)
typedef union                     
{
    DF_Tag        tag;
    Word          dummy;
} DF_StrData;                 

typedef DF_StrData *DF_StrDataPtr;

//#define DF_STRDATA_HEAD_SIZE   (int)ceil((double)sizeof(DF_StrData)/WORD_SIZE)
#define DF_STRDATA_HEAD_SIZE  2     

//a generic environment item in suspension
typedef struct DF_env
{
    //Boolean          isDummy;
    DF_Tag           tag;
    TwoBytes         embedLevel;
    struct DF_env    *rest;        //the tail of the list
} DF_Env;

typedef DF_Env *DF_EnvPtr;

// empty environment list 
#define DF_EMPTY_ENV NULL

//sizes of different environment items
#define DF_ENV_DUMMY_SIZE  2       // dummy environment item
#define DF_ENV_PAIR_SIZE   3       // pair environment item

//limits (to be set by configuration)
#define DF_MAX_BV_IND      USHRT_MAX        //max db ind (embedding level)
#define DF_TM_MAX_ARITY    USHRT_MAX        //max arity 
#define DF_MAX_UNIVIND     USHRT_MAX        //max universe index


/******************************************************************/
/*                      Interface functions                       */
/******************************************************************/

/* DEREFERENCE      */
DF_TermPtr DF_termDeref(DF_TermPtr); // term dereference

/* TERM RECOGNITION */
Boolean DF_isAtomic(DF_TermPtr); //note ref is neither atomic nor complex
Boolean DF_isNAtomic(DF_TermPtr);                                    
Boolean DF_isFV(DF_TermPtr);     // is unbound variable?
Boolean DF_isConst(DF_TermPtr);  // is constant (typed and untyped)?
Boolean DF_isTConst(DF_TermPtr); // is a type associated constant?
                                 // Note we assume the arg is known to be const
Boolean DF_isInt(DF_TermPtr);    // is integer?
Boolean DF_isFloat(DF_TermPtr);  // is float?
Boolean DF_isNil(DF_TermPtr);    // is list nil?
Boolean DF_isStr(DF_TermPtr);    // is string?
Boolean DF_isBV(DF_TermPtr);     // is de Bruijn index?
Boolean DF_isStream(DF_TermPtr); // is stream?
Boolean DF_isRef(DF_TermPtr);    // is reference?
Boolean DF_isCons(DF_TermPtr);   // is list cons?
Boolean DF_isLam(DF_TermPtr);    // is abstraction?
Boolean DF_isApp(DF_TermPtr);    // is application?
Boolean DF_isSusp(DF_TermPtr);   // is suspension?

Boolean DF_isEmpEnv(DF_EnvPtr);  // is empty environment?
Boolean DF_isDummyEnv(DF_EnvPtr);// is dummy environment item?
                      
/* TERM DECOMPOSITION */
//generic term
int DF_termTag(DF_TermPtr);                  // term category tag
//unbound variable
int DF_fvUnivCount(DF_TermPtr);              // universe count
//constants (w/oc type associations)
int DF_constUnivCount(DF_TermPtr);           // universe index
int DF_constTabIndex(DF_TermPtr);            // symbol table index
//constants with type associations
DF_TypePtr DF_constType(DF_TermPtr);         // type environment
//integer
long DF_intValue(DF_TermPtr);                // integer value (long)
//float
float DF_floatValue(DF_TermPtr);             // float value
//string
MCSTR_Str DF_strValue(DF_TermPtr);           // string value
DF_StrDataPtr DF_strData(DF_TermPtr tmPtr);  // string data field
MCSTR_Str DF_strDataValue(DF_StrDataPtr tmPtr);  //acc str value from data fd
//stream
WordPtr DF_streamTabIndex(DF_TermPtr);       // stream table index 
//de Bruijn indices
int DF_bvIndex(DF_TermPtr);                  // de Bruijn index
//reference
DF_TermPtr DF_refTarget(DF_TermPtr);         // target
//list cons
DF_TermPtr DF_consArgs(DF_TermPtr);          // arg vector
//abstractions
int DF_lamNumAbs(DF_TermPtr);                // embedding level
DF_TermPtr DF_lamBody(DF_TermPtr);           // lambda body
//application
int DF_appArity(DF_TermPtr);                 // arity
DF_TermPtr DF_appFunc(DF_TermPtr);           // functor
DF_TermPtr DF_appArgs(DF_TermPtr);           // arg vector
//suspension
int DF_suspOL(DF_TermPtr);                   // ol
int DF_suspNL(DF_TermPtr);                   // nl
DF_TermPtr DF_suspTermSkel(DF_TermPtr);      // term skel
DF_EnvPtr  DF_suspEnv(DF_TermPtr);           // environment list

//environment item (dummy/pair)
DF_EnvPtr DF_envListRest(DF_EnvPtr);         // next env item
DF_EnvPtr DF_envListNth(DF_EnvPtr, int);     // the nth item 
int DF_envIndex(DF_EnvPtr);                  // l in @l or (t,l)
//pair environment item 
DF_TermPtr DF_envPairTerm(DF_EnvPtr);        // t in (t,l)
                        

/* TERM CONSTRUCTION */
void DF_copyAtomic(DF_TermPtr src, MemPtr dest);   //copy atomic 
void DF_copyApp(DF_TermPtr src, MemPtr dest);      //copy application
void DF_copySusp(DF_TermPtr src, MemPtr dest);     //copy suspension
void DF_mkVar(MemPtr loc, int uc);                 //unbound variable
void DF_mkBV(MemPtr loc, int ind);                 //de Bruijn index
void DF_mkConst(MemPtr loc, int uc, int ind);      //const 
void DF_mkTConst(MemPtr loc, int uc, int ind, DF_TypePtr typeEnv);
                                                  //const with type association
void DF_mkInt(MemPtr loc, long value);             //int
void DF_mkFloat(MemPtr loc, float value);          //float
void DF_mkStr(MemPtr loc, DF_StrDataPtr data);     //string
void DF_mkStrDataHead(MemPtr loc);                 //string data head
void DF_mkStream(MemPtr loc, WordPtr ind);         //stream 
void DF_setStreamInd(DF_TermPtr tm, WordPtr ind);  //update index of a stream
void DF_mkNil(MemPtr loc);                         //nil
void DF_mkRef(MemPtr loc, DF_TermPtr target);      //reference
void DF_mkCons(MemPtr loc, DF_TermPtr args);       //cons
void DF_mkLam(MemPtr loc, int n, DF_TermPtr body); //abstraction
void DF_mkApp(MemPtr loc, int n, DF_TermPtr func, DF_TermPtr args); 
                                                   //application
void DF_mkSusp(MemPtr loc, int ol, int nl, DF_TermPtr tp, DF_EnvPtr env);
                                                   //suspension
void DF_mkDummyEnv(MemPtr loc, int l, DF_EnvPtr rest);    //@l env item
void DF_mkPairEnv(MemPtr loc, int l, DF_TermPtr t, DF_EnvPtr rest);
                                                          // (t, l) env item

/* TERM MODIFICATION */
void DF_modVarUC(DF_TermPtr vPtr, int uc);

/* (NON_TRIVIAL) TERM COMPARISON */
Boolean DF_sameConsts(DF_TermPtr const1, DF_TermPtr const2);     //same const?
Boolean DF_sameStrs(DF_TermPtr str1, DF_TermPtr str2);           //same string?
Boolean DF_sameStrData(DF_TermPtr tmPtr, DF_StrDataPtr strData); //same str?

/********************************************************************/
/*                                                                  */
/*                    DISAGREEMENT SET REPRESENTATION               */
/*                                                                  */
/*                    Linked list                                   */
/********************************************************************/

typedef struct DF_disPair   //each node in the disagreement set
{
    DF_Tag               tag;
    struct DF_disPair    *next;
    DF_TermPtr           firstTerm;
    DF_TermPtr           secondTerm;
} DF_DisPair;

typedef DF_DisPair  *DF_DisPairPtr; //pointer to a disagreement pair

//note this arithmatic should in reality be performed in configuration
#define DF_DISPAIR_SIZE   (int)ceil((double)sizeof(DF_DisPair)/WORD_SIZE)

#define DF_EMPTY_DIS_SET  NULL      //empty disagreement set

/******************************************************************/
/*                      Interface functions                       */
/******************************************************************/

//create a new node at the given location
void DF_mkDisPair(MemPtr loc, DF_DisPairPtr next, DF_TermPtr first, 
                  DF_TermPtr second);

//decomposition
DF_DisPairPtr DF_disPairNext(DF_DisPairPtr disPtr);
DF_TermPtr    DF_disPairFirstTerm(DF_DisPairPtr disPtr);
DF_TermPtr    DF_disPairSecondTerm(DF_DisPairPtr disPtr);

//whether a given disagreement set is empty
Boolean       DF_isEmpDisSet(DF_DisPairPtr disPtr);
Boolean       DF_isNEmpDisSet(DF_DisPairPtr disPtr);

#endif  //DATAFORMATS_H


