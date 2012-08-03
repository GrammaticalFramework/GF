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
/****************************************************************************
 *                                                                          *
 * File printterm.c. This file contains routines for printing out lambda    *
 * terms. It is assumed that these routines will be needed in two           *
 * situations: printing out answers to queries and displaying terms as      *
 * needed by invocation of builtin goals.                                   *
 * The difference between these two situations is in the display of         *
 * free term variables. Only when displaying answers is an attempt made to  *
 * present these using sensible names: in this case, either the name in the *
 * query is used or a concise name is cooked up. In the other situation,    *
 * the address of the variable cell is used as the name.                    *
 *                                                                          *
 * Certain assumptions are relevant to avoiding name clashes. For local     *
 * constants, the assumption is that no constant names in user              *
 * programs begin with <lc- and end with >. The use of this idea is         *
 * buried inside the routine PRINT_writeHCName.                             *
 * Violation of this condition is *not* checked. For term variables, the    *
 * assumption is that bound variables do not begin with _.                  *
 *                                                                          *
 ****************************************************************************/
#include <stdlib.h>
#include <string.h>
#include "printterm.h"
#include "mctypes.h"
#include "mcstring.h"
#include "hnorm.h"
#include "dataformats.h"
#include "abstmachine.h"
#include "io-datastructures.h"
#include "builtins/builtins.h"
#include "../system/stream.h"
#include "../system/error.h"
#include "../system/operators.h"
#include "../tables/pervasives.h"

//temp
#include <stdio.h>

/* This variable records the number of query variables */
int PRINT_numQueryVars;

/* flag determining whether or not to print sensible names for free vars */
Boolean PRINT_names = FALSE;

static void PRINT_writeTerm(WordPtr outStream, DF_TermPtr tmPtr, 
                            OP_FixityType infx, int inprec, OP_TermContext tc);

/****************************************************************************
 *                   Auxiliary routines used in this file                   *
 ****************************************************************************/
static Boolean PRINT_parenNeeded(OP_FixityType opfx, int opprec, 
                                 OP_TermContext context, OP_FixityType fx, 
                                 int prec)
{
    Boolean pparen = FALSE;
    if (context == OP_LEFT_TERM) {
        switch (fx) {
        case OP_INFIX: case OP_INFIXR: case OP_POSTFIX:
            if (opprec <= prec) pparen = TRUE;   break;
        case OP_INFIXL: case OP_POSTFIXL: 
        {
            switch (opfx) {
            case OP_PREFIX: case OP_INFIX: case OP_INFIXL: case OP_POSTFIX:
            case OP_POSTFIXL: 
                if (opprec < prec) pparen = TRUE; break;
            default:
                if (opprec <= prec) pparen = TRUE; break;
            }
            break;
        }
        default:
			break;
        }
    } else if (context == OP_RIGHT_TERM) {
        switch (fx) {
        case OP_INFIX: case OP_INFIXL: case OP_PREFIX:
            if (opprec <= prec) pparen = TRUE; break;
        case OP_INFIXR: case OP_PREFIXR:
        {
            switch (opfx) {
            case OP_INFIXL: case OP_POSTFIXL:
                if (opprec <= prec) pparen = TRUE; break;
            default:
                if (opprec < prec) pparen = TRUE; break;
            }
        }
        default:
			break;
        }
    }
    return pparen;
}

/* making a name from the address of an unbound term variable */
static long PRINT_makeNumberName(DF_TermPtr tmPtr)
{ return (long)tmPtr - (long)AM_heapBeg;                      }


/****************************************************************************
 * Routines for printing out keywords and punctuation symbols in the course *
 * of displaying lambda terms. These have been extracted out of the other   *
 * routines so as to make stylistic changes at a later point easier to      *
 * effect.                                                                  *
 ****************************************************************************/
static void PRINT_writeLParen(WordPtr outStream)
{ STREAM_printf(outStream, "(");                             }

static void PRINT_writeRParen(WordPtr outStream)
{ STREAM_printf(outStream, ")");                             }

static void PRINT_writeConsSymbol(WordPtr outStream)
{ STREAM_printf(outStream, " :: ");                          }

static void PRINT_writeNilSymbol(WordPtr outStream)
{ STREAM_printf(outStream, "nil");                           }

static void PRINT_writeInfixLam(WordPtr outStream)
{ STREAM_printf(outStream, "\\ ");                           }

static void PRINT_writeSpace(WordPtr outStream, int i)
{ while (i--) STREAM_printf(outStream, " ");                 }    

static void PRINT_writeEquals(WordPtr outStream) 
{ STREAM_printf(outStream, " = ");                           }

static void PRINT_writeComma(WordPtr outStream)
{ STREAM_printf(outStream, ",");                             }

static void PRINT_writeDPairStart(WordPtr outStream)
{ STREAM_printf(outStream, "<");                             }
    
static void PRINT_writeDPairEnd(WordPtr outStream)
{ STREAM_printf(outStream, ">");                             }

/***************************************************************************
 * Writing out terms corresponding to the builtin constants.               *
 ***************************************************************************/
/* Writing out an integer term to a given output stream */
static void PRINT_writeInt(WordPtr outStream, DF_TermPtr tmPtr)
{ STREAM_printf(outStream, "%d", DF_intValue(tmPtr));        }

/* Writing out a float term to a given output stream */
static void PRINT_writeFloat(WordPtr outStream, DF_TermPtr tmPtr)
{ STREAM_printf(outStream, "%f", DF_floatValue(tmPtr));      }

/* Writing out a string term to a given output stream */
static void PRINT_writeString(WordPtr outStream, DF_TermPtr tmPtr)
{ STREAM_printf(outStream, "\"%s\"", MCSTR_toCString(DF_strValue(tmPtr))); }

/* Writing out a stream constant to a given output stream */
static void PRINT_writeStream(WordPtr outStream, DF_TermPtr tmPtr)
{
    WordPtr stream = DF_streamTabIndex(tmPtr);
    STREAM_printf(outStream, "<stream ");
    if (stream == STREAM_ILLEGAL) STREAM_printf(outStream, "-- closed>");
    else STREAM_printf(outStream, "-- \"%s\">", STREAM_getName(stream));
}

/****************************************************************************
 *  Writing out a constant. Use the index into the runtime constant table   *
 *  stored in the constant to get the constant name if one exists. If one   *
 *  does not exist, i.e. if the constant is a local or hidden one, look for *
 *  it in a list of constants. If it is not in this list, make up a new     *
 *  name. Eventually, the name consists of three parts: a generic name for  *
 *  hidden constants, a part based on the runtime table index and a part    *
 *  based on the universe index.                                            *
 ****************************************************************************/
/* A structure for maintaining information about local constants encountered
while printing; this structure enables the assignment of a unique integer
to each runtime symbol table slot for such a constant. */
typedef struct  PRINT_ConstList_ *PRINT_ConstList;

struct  PRINT_ConstList_ 
{
    int   constInd;
    int   count;
    PRINT_ConstList  next; 
};

static PRINT_ConstList PRINT_clist = NULL;
static int PRINT_lccount = 0;

static void PRINT_cleanCList()
{
    PRINT_ConstList tmp;
    
    PRINT_lccount = 0;
    while (PRINT_clist){
        tmp = PRINT_clist;
        PRINT_clist = PRINT_clist -> next;
        free(tmp);
    }
}

/* writing out a hidden (local) constant name; as side effect, a note may be 
   made of a new hidden (local) constant seen during this printing. */
static void PRINT_writeHCName(WordPtr outStream, int constInd, int uc)
{
    PRINT_ConstList lclist = PRINT_clist;
    while (lclist && (lclist->constInd != constInd)) lclist = lclist->next;
    
    if (!lclist) {
        lclist = (PRINT_ConstList)EM_malloc(sizeof(struct PRINT_ConstList_));
        lclist->constInd = constInd;
        lclist->count    = PRINT_lccount++;
        lclist->next     = PRINT_clist;
        PRINT_clist      = lclist;
    }
    
    STREAM_printf(outStream, "<lc-%d-%d>", lclist->count, uc);
}

/* Writing out a constant, hidden or global. */
static void PRINT_writeConst(WordPtr outStream, DF_TermPtr tmPtr)
{
    int   constInd = DF_constTabIndex(tmPtr);
    char* name     = AM_cstName(constInd);
    
    if (name) STREAM_printf(outStream, "%s", name);
    else PRINT_writeHCName(outStream, constInd, DF_constUnivCount(tmPtr));
}

/****************************************************************************
 * Writing out a free variable. Two situations are possible, one where a    *
 * symbolic name is to be produced and the other where the `address' could  *
 * serve as the name. In the first case, if the variable is a query         *
 * variable, then its name from the query is used. Otherwise a new name is  *
 * invented that is distinct from other free term variable names; the       *
 * initial segment of the name guarantees that it will be distinct from     *
 * that of  bound variables.                                                *
 ****************************************************************************/
/* counter used to generate free variable name */
static int  PRINT_fvcounter = 1;

/* Create a free term variable name; this starts with _ has a standard
   string prefix and then a digit sequence */
static DF_StrDataPtr PRINT_makeFVarName()
{
    int           digits = 0;
    int           i = PRINT_fvcounter;
    int           length;
    char*         cname;
    DF_StrDataPtr fvname;

    while(i) { digits++; i = i/10; }

    length = digits + 3;
    cname = (char*)EM_malloc(sizeof(char)*length);
    cname[0] = '_';
    cname[1] = 'T';
    cname[length-1] = '\0';
    
    i = PRINT_fvcounter;
    while(i) {
        cname[digits+1] = (i%10 + '0');
        i = i/10;
        digits--;
    }
    PRINT_fvcounter++;

    fvname = (DF_StrDataPtr)EM_malloc(sizeof(Word)*(MCSTR_numWords(length) +
						    DF_STRDATA_HEAD_SIZE));
    DF_mkStrDataHead((MemPtr)fvname);
    MCSTR_toString((MemPtr)((MemPtr)fvname + DF_STRDATA_HEAD_SIZE),
                   cname, length);
    free(cname);
    return fvname;
}

/* Does a made up name occur in the free term variable table? Clash can
only occur with names in the user query */
static Boolean PRINT_nameInFVTab(DF_StrDataPtr name)
{
    int i;
    for (i = 0; i < PRINT_numQueryVars ; i++){
      if (MCSTR_sameStrs(DF_strDataValue(name), 
			 DF_strDataValue(IO_freeVarTab[i].varName)))
	return TRUE;
    }
    return FALSE;
}

/* The main routine for printing out an unbound term variable */
static void PRINT_writeFVar(WordPtr outStream, DF_TermPtr tmPtr)
{
    int           fvind = 0;
    DF_StrDataPtr fvname;

		//PRINT_names = TRUE;
    if (PRINT_names) {
        IO_freeVarTab[IO_freeVarTabTop].rigdes = tmPtr;
        
        while (tmPtr != IO_freeVarTab[fvind].rigdes) fvind++;
        
        if (fvind == IO_freeVarTabTop) {
            /* i.e., a free variable not seen before */
            if (IO_freeVarTabTop == IO_MAX_FREE_VARS) 
                EM_error(BI_ERROR_TYFVAR_CAP);
            
            while(1) {//make a name
                fvname = PRINT_makeFVarName();
                if (!PRINT_nameInFVTab(fvname)) break;
                free(fvname);
            }
            
            IO_freeVarTab[fvind].varName = fvname;
            IO_freeVarTabTop++;
        }
        STREAM_printf(outStream, 
	       MCSTR_toCString(DF_strDataValue(IO_freeVarTab[fvind].varName)));
    } else { //PRINT_names = FALSE
        STREAM_printf(outStream, "_%ld", PRINT_makeNumberName(tmPtr));
    }
}

/****************************************************************************
 * Routines for writing out bound variables (in lambda abstraction and      *
 * bound variable occurrence)                                               *
 ****************************************************************************/
/* prefix for bound variables */
static char* PRINT_bvname = "W";

/* a counter for determining the suffix part of bound variables */
static int PRINT_bvcounter = 1;

/* A structure for maintaining information about bound variable names */
typedef struct PRINT_BVList_ *PRINT_BVList;

struct PRINT_BVList_ {
  DF_StrDataPtr name;
  PRINT_BVList  next; };

/* the initial list of bound variable names; initialized in SIM_InitIo */
static  PRINT_BVList  PRINT_bvs = NULL;

static void PRINT_cleanBV(PRINT_BVList bv)
{
  free(bv->name);
  free(bv);
}

/* releasing the space for bound variables; needed only in case of error
   exit */  
static void PRINT_cleanBVList()
{
  PRINT_BVList tbvl;

  PRINT_bvcounter = 1;
  while (PRINT_bvs) {
    tbvl = PRINT_bvs; PRINT_bvs = PRINT_bvs->next; 
    PRINT_cleanBV(tbvl);
  }
}

/****************************************************************************
 * Writing out a bound variable                                             *
 ****************************************************************************/
static void PRINT_writeBVar(WordPtr outStream, DF_TermPtr tmPtr)
{
  int i;
  int bvind = DF_bvIndex(tmPtr);
  PRINT_BVList lbvs = PRINT_bvs;

  for (i = bvind; ((i != 1) && lbvs) ; i--) 
    lbvs = lbvs->next;

  // Is this checking and the else branch really necessary? 
  // Printing should start from top-level closed terms?
  if (lbvs) STREAM_printf(outStream, "%s", 
			  MCSTR_toCString(DF_strDataValue(lbvs->name)));
  else STREAM_printf(outStream, "#%d", i); 
}

/****************************************************************************
 * Writing out an empty list                                                *
 ****************************************************************************/
static void PRINT_writeNil(WordPtr outStream)
{  PRINT_writeNilSymbol(outStream);                      }

/****************************************************************************
 * Writing out a non-empty list.                                            *
 ****************************************************************************/
static void PRINT_writeCons(WordPtr outStream, DF_TermPtr tmPtr, 
                            OP_FixityType fx, int prec, OP_TermContext tc)
{
    DF_TermPtr    args     = DF_consArgs(tmPtr);
    OP_FixityType consfix  = (OP_FixityType)AM_cstFixity(PERV_CONS_INDEX);
    int           consprec = AM_cstPrecedence(PERV_CONS_INDEX);
    Boolean       pparen   = PRINT_parenNeeded(consfix, consprec, tc, fx,prec);

    if (pparen) PRINT_writeLParen(outStream);
    PRINT_writeTerm(outStream, args, consfix, consprec, OP_LEFT_TERM);    
    PRINT_writeConsSymbol(outStream);
    
    do {
        args++;
        tmPtr = DF_termDeref(args);
        if (DF_termTag(tmPtr) != DF_TM_TAG_CONS) break;
        args = DF_consArgs(tmPtr);
        PRINT_writeTerm(outStream, args, consfix, consprec, OP_LEFT_TERM);
        PRINT_writeConsSymbol(outStream);
    } while(1);
    
    PRINT_writeTerm(outStream, tmPtr, consfix, consprec, OP_RIGHT_TERM);
    if (pparen) PRINT_writeRParen(outStream);
}

/****************************************************************************
 * Writing out an abstraction.                                              *
 ****************************************************************************/
/* creating a bound variable name with bound variable prefix followed by the*/
/* current bound variable counter value.                                    */
static DF_StrDataPtr PRINT_makeBVarName()
{
  int            digits = 0;
  int            i = PRINT_bvcounter;
  int            length;
  char*          cname;
  DF_StrDataPtr  bvname;

  while(i) { digits++; i = i/10; }

  length = digits + 2;
  cname = (char*)EM_malloc(sizeof(char)*length);
  strcpy(cname, PRINT_bvname);
  cname[length-1] = '\0';
  
  i = PRINT_bvcounter;
  while(i) {
    cname[digits] = (i%10 + '0');
    i = i/10;
    digits--;
  }
  PRINT_bvcounter++;

  bvname = (DF_StrDataPtr)EM_malloc(sizeof(Word)*(MCSTR_numWords(length) +
						  DF_STRDATA_HEAD_SIZE));
 
  DF_mkStrDataHead((MemPtr)bvname);
  MCSTR_toString((MemPtr)((MemPtr)bvname + DF_STRDATA_HEAD_SIZE),
		 cname, length);
  free(cname);
  return bvname;
}

static void PRINT_writeAbstBinders(WordPtr outStream, int nabs) 
{
  DF_StrDataPtr bvname;
  PRINT_BVList  tmpbvs;

  while(nabs > 0) {
    nabs--;
    while(1) {//make a bvname not in FV table
      bvname = PRINT_makeBVarName();
      if (!PRINT_nameInFVTab(bvname)) break;
      free(bvname);
    }

    //record the name into the head of the current bvlist
    tmpbvs = (PRINT_BVList)EM_malloc(sizeof(struct PRINT_BVList_));
    tmpbvs->name = bvname;
    tmpbvs->next = PRINT_bvs;
    PRINT_bvs = tmpbvs;
    //write out binder
    STREAM_printf(outStream, "%s", MCSTR_toCString(DF_strDataValue(bvname)));
    PRINT_writeInfixLam(outStream);
  }
}

static void PRINT_writeAbst(WordPtr outStream, DF_TermPtr tmPtr, 
                            OP_FixityType fx, int prec, OP_TermContext tc)
{    
    int     numabs = 0;
    Boolean pparen = PRINT_parenNeeded(OP_LAM_FIXITY,OP_LAM_PREC,tc,fx,prec);
    PRINT_BVList tmpbvs;
    int          tmpbvc = PRINT_bvcounter;
    
    if (pparen) PRINT_writeLParen(outStream);
    while (DF_isLam(tmPtr)){
        numabs += DF_lamNumAbs(tmPtr);
        tmPtr = DF_termDeref(DF_lamBody(tmPtr));
    }
    PRINT_writeAbstBinders(outStream, numabs);
    PRINT_writeTerm(outStream, tmPtr, OP_LAM_FIXITY,OP_LAM_PREC,OP_RIGHT_TERM);
    if (pparen) PRINT_writeRParen(outStream);

    while (numabs > 0) {
      numabs--;
      tmpbvs = PRINT_bvs;
      PRINT_bvs = PRINT_bvs->next;
      PRINT_cleanBV(tmpbvs);
    } 
    PRINT_bvcounter = tmpbvc;
}      

/****************************************************************************
 *                      WRITING OUT AN APPLICATION                          *
 *                                                                          *
 * Note that it is assumed that nested application structures are flattened *
 * during the full normalization process.                                   *
 ****************************************************************************/
/* Getting the fixity and precedence for the head of an application. 
   Assume the pointer to the term head is already dereferenced. */
static void PRINT_getHeadInfo(DF_TermPtr hdPtr, OP_FixityType *fx, int* prec)
{
    int cstInd;
    switch (DF_termTag(hdPtr)) {
    case DF_TM_TAG_CONST:
        cstInd = DF_constTabIndex(hdPtr);
        if (AM_cstName(cstInd)) {
            *fx   = (OP_FixityType)AM_cstFixity(cstInd);
            *prec = AM_cstPrecedence(cstInd);
        } else {
            *fx   = OP_NONE;
            *prec = 0;
        }
        break;
    case DF_TM_TAG_VAR:
        *fx   = OP_NONE;
        *prec = OP_MINPREC;
        break;
    case DF_TM_TAG_BVAR:
        *fx   = OP_NONE;
        *prec = OP_MINPREC;
        break;
    }
}    
        
/* Writing out a term with a prefix operator as head; we use the knowledge
that the operator must be a constant here and that the pointer to it is
fully dereferenced */
static void PRINT_writePrefixTerm(WordPtr outStream, DF_TermPtr head,
                                  OP_FixityType opfx, int opprec,
                                  OP_TermContext tc, OP_FixityType fx,int prec,
                                  DF_TermPtr args)
{
    Boolean pparen = PRINT_parenNeeded(opfx, opprec, tc, fx, prec);
    
    if (pparen) PRINT_writeLParen(outStream);
    PRINT_writeConst(outStream, head);
    PRINT_writeSpace(outStream, 1);
    PRINT_writeTerm(outStream, args, opfx, opprec, OP_RIGHT_TERM);
    if (pparen) PRINT_writeRParen(outStream);
}

static void PRINT_writeInfixTerm(WordPtr outStream, DF_TermPtr head,
                                 OP_FixityType opfx, int opprec, 
                                 OP_TermContext tc, OP_FixityType fx, int prec,
                                 DF_TermPtr args)
{
    Boolean pparen = PRINT_parenNeeded(opfx, opprec, tc, fx, prec);
    if(pparen) PRINT_writeLParen(outStream);
    PRINT_writeTerm(outStream, args, opfx, opprec, OP_LEFT_TERM);
    PRINT_writeSpace(outStream, 1);
    PRINT_writeConst(outStream, head);
    PRINT_writeSpace(outStream, 1);
    PRINT_writeTerm(outStream, args+1, opfx, opprec, OP_RIGHT_TERM);
    if (pparen) PRINT_writeRParen(outStream);
}                                  

static void PRINT_writePostfixTerm(WordPtr outStream, DF_TermPtr head,
                                   OP_FixityType opfx, int opprec, 
                                   OP_TermContext tc,OP_FixityType fx,int prec,
                                   DF_TermPtr args) 
{
    Boolean pparen = PRINT_parenNeeded(opfx, opprec, tc, fx, prec);
    if(pparen) PRINT_writeLParen(outStream);
    PRINT_writeTerm(outStream, args, opfx, opprec, OP_LEFT_TERM);
    PRINT_writeSpace(outStream, 1);
    PRINT_writeConst(outStream, head);
    if (pparen) PRINT_writeRParen(outStream);
}                                  

/* Main routine for writing out an application term */
static void PRINT_writeApp(WordPtr outStream, DF_TermPtr tmPtr, 
                           OP_FixityType infx, int inprec, OP_TermContext tc)
{   
  
    DF_TermPtr head   = DF_termDeref(DF_appFunc(tmPtr));
    DF_TermPtr args   = DF_appArgs(tmPtr);
    int        arity  = DF_appArity(tmPtr);
    Boolean    pparen = PRINT_parenNeeded(OP_APP_FIXITY, OP_APP_PREC, tc, infx,
                                          inprec);
    OP_FixityType  fix = 0;
    int            prec = 0;

    HN_hnorm(tmPtr);
    PRINT_getHeadInfo(AM_head, &fix, &prec);  
    
    switch(fix){
    case OP_PREFIX: case OP_PREFIXR:
      if (arity == 1) {
	pparen = FALSE;
	PRINT_writePrefixTerm(outStream, head, fix, prec, tc, infx, inprec,
			      args);
	
       } else { 
	 if (pparen) PRINT_writeLParen(outStream);
	 PRINT_writePrefixTerm(outStream, head, fix, prec, OP_LEFT_TERM,
			       OP_APP_FIXITY, OP_APP_PREC, args);
       }
      arity--; args++;
      break;
    case OP_INFIX: case OP_INFIXL: case OP_INFIXR:
      if (arity == 2) {
	pparen = FALSE;
	PRINT_writeInfixTerm(outStream, head, fix, prec, tc, infx, inprec, 
			     args);
      } else {
	if (pparen) PRINT_writeLParen(outStream);
	PRINT_writeInfixTerm(outStream, head, fix, prec, OP_LEFT_TERM,
			     OP_APP_FIXITY, OP_APP_PREC, args);
      }
      arity -= 2; args += 2;
      break;
    case OP_POSTFIX: case OP_POSTFIXL:
      if (arity == 1) {
	pparen = FALSE;
	PRINT_writePostfixTerm(outStream, head, fix, prec, tc, infx,
			       inprec, args);
      }  else { 
	if (pparen) PRINT_writeLParen(outStream);
	PRINT_writePostfixTerm(outStream, head, fix, prec, OP_LEFT_TERM,
			       OP_APP_FIXITY, OP_APP_PREC, args);
      }
      break;
    case OP_NONE:
      if (pparen) PRINT_writeLParen(outStream);
      PRINT_writeTerm(outStream,head,OP_APP_FIXITY,OP_APP_PREC,OP_LEFT_TERM);
      break;
    } /*switch*/

    /* print the arguments (if any) of the application */
    while (arity > 0) {
        PRINT_writeSpace(outStream, 1);
        PRINT_writeTerm(outStream, args, OP_APP_FIXITY, OP_APP_PREC,
			OP_RIGHT_TERM);
        args++;
        arity--;
    }
    if (pparen) PRINT_writeRParen(outStream);
}


/*****************************************************************************
 * The main routine for writing out a term; this is called by the interface  *
 * routines to do the real job of printing.                                  *
 *****************************************************************************/
static void PRINT_writeTerm(WordPtr outStream, DF_TermPtr tmPtr, 
                            OP_FixityType infx, int inprec, OP_TermContext tc)
{
    tmPtr = DF_termDeref(tmPtr);
    switch (DF_termTag(tmPtr)) {
    case DF_TM_TAG_INT:     PRINT_writeInt(outStream, tmPtr);    break;
    case DF_TM_TAG_FLOAT:   PRINT_writeFloat(outStream, tmPtr);  break;
    case DF_TM_TAG_STR:     PRINT_writeString(outStream, tmPtr); break;
    case DF_TM_TAG_STREAM:  PRINT_writeStream(outStream, tmPtr); break;
    case DF_TM_TAG_CONST:   PRINT_writeConst(outStream, tmPtr);  break;
    case DF_TM_TAG_VAR:     PRINT_writeFVar(outStream, tmPtr);   break;
    case DF_TM_TAG_BVAR:    PRINT_writeBVar(outStream, tmPtr);   break;
    case DF_TM_TAG_NIL:     PRINT_writeNil(outStream);           break;
    case DF_TM_TAG_CONS:    
        PRINT_writeCons(outStream, tmPtr, infx, inprec, tc);     break;
    case DF_TM_TAG_LAM:     
        PRINT_writeAbst(outStream, tmPtr, infx, inprec, tc);     break;
    case DF_TM_TAG_APP:
        PRINT_writeApp(outStream, tmPtr, infx, inprec, tc);      break;
    } /* switch */    
}


/* Printing a term to a specified output stream; names will be invented for
free variables if the boolean variable PRINT_names is set. */
void PRINT_fPrintTerm(WordPtr outStream, DF_TermPtr tmPtr)
{
  HN_lnorm(tmPtr);
  PRINT_writeTerm(outStream, tmPtr, OP_NONE, 0, OP_WHOLE_TERM);
}

/* Printing routine for debugging */
void PRINT_printTerm(DF_TermPtr tmPtr)
{
    PRINT_fPrintTerm(STREAM_stdout, tmPtr);
    STREAM_printf(STREAM_stdout, "\n");
}

/* printing an answer substitution pair */
static void PRINT_printSubsPair(WordPtr outStream, int ind)
{
    DF_TermPtr tmPtr;
    char *varName = 
        MCSTR_toCString(DF_strDataValue(IO_freeVarTab[ind].varName));    

    /* print the variable name if it is not an anonymous variable */
    if (strcmp(varName, "_") != 0) {        
        STREAM_printf(outStream, varName);
        
        /* Print the equals sign */
        PRINT_writeEquals(outStream);
        
        /* Print the binding of the variable */
        tmPtr = IO_freeVarTab[ind].rigdes;
        HN_lnorm(tmPtr);
        PRINT_writeTerm(outStream, tmPtr, OP_NONE, 0, OP_WHOLE_TERM);
    }    
}

void PRINT_showAnswerSubs()
{
    int i;
    
    PRINT_names = TRUE;
    
    for (i = 0; i < PRINT_numQueryVars; i++) {
        PRINT_printSubsPair(STREAM_stdout, i);
        STREAM_printf(STREAM_stdout, "\n");
    }
}

/* Printing a disagreement pair to a specified output stream */
static void PRINT_printDPair(WordPtr outStream, DF_DisPairPtr dpair)
{
    DF_TermPtr tmPtr;
    
    PRINT_writeDPairStart(outStream);
    
    tmPtr = DF_disPairFirstTerm(dpair);
    HN_lnorm(tmPtr);
    PRINT_writeTerm(outStream, tmPtr, OP_NONE, 0, OP_WHOLE_TERM);
    
    PRINT_writeComma(outStream);
    PRINT_writeSpace(outStream, 1);
    
    tmPtr = DF_disPairSecondTerm(dpair);
    HN_lnorm(tmPtr);    
    PRINT_writeTerm(outStream, tmPtr, OP_NONE, 0, OP_WHOLE_TERM);

    PRINT_writeDPairEnd(outStream);
}

void PRINT_showDisAgreeList()
{
    DF_DisPairPtr liveList = AM_llreg;
    
    while (DF_isNEmpDisSet(liveList)) {
        PRINT_printDPair(STREAM_stdout, liveList);
        liveList = DF_disPairNext(liveList);
        STREAM_printf(STREAM_stdout, "\n");
    }    
}

void PRINT_setQueryFreeVariables()
{
    PRINT_numQueryVars = IO_freeVarTabTop;
}

/* Use this function to reset the top of the free variable table
after a read; this is logical and also needed to avoid trying 
to release print name space accidentally at some other point. */
void PRINT_resetFreeVarTab()
{
  IO_freeVarTabTop = PRINT_numQueryVars;
}


void PRINT_resetPrintState()
{
    /* release space for term variables created during printing */
    while (IO_freeVarTabTop > PRINT_numQueryVars){
        IO_freeVarTabTop--;
        free(IO_freeVarTab[IO_freeVarTabTop].varName);
    }
    
    /* reset counters used in names of anonymous term and type variables */
    PRINT_fvcounter = 1; 

    /* free space for information created for local consts and reset counter */
    PRINT_cleanCList();    
    
    /* free space for information created for bound vars and reset counter */
    PRINT_cleanBVList();
}

Boolean PRINT_queryHasVars()
{
    int i = PRINT_numQueryVars - 1;
    while (!(i < 0) && 
           (strcmp(MCSTR_toCString(DF_strDataValue(IO_freeVarTab[i].varName)),
                   "_") == 0)) 
        i--;
    
    if (i < 0) return FALSE;
    else return TRUE;
    
}
