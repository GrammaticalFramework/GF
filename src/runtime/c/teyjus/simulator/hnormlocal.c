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
/*****************************************************************************/
/*                                                                           */
/* File hnormlocal.c.                                                        */
/* This file contains the definitions of some auxiliary functionw that are   */
/* used exclusively in the (head) normalization routines. (hnorm.c)          */
/*****************************************************************************/

#ifndef HNORMLOCAL_C
#define HNORMLOCAL_C

#include <stdlib.h>
#include "abstmachine.h"
#include "dataformats.h"
#include "trail.h"


/**********************************************************************/
/*      Register setting upon hnorm initiation or termination         */
/**********************************************************************/

/* initialize relevant registers           */
void HNL_initRegs()
{
    AM_numAbs = AM_numArgs = 0;
    AM_head   = AM_argVec  = NULL;
}

/* when a cons head is found               */
void HNL_setRegsCons(DF_TermPtr consPtr)
{
    AM_consFlag = AM_rigFlag = ON;
    AM_head = consPtr;
}

/* when a (special) constant head is found */
void HNL_setRegsRig(DF_TermPtr headPtr)
{
    AM_consFlag = OFF;
    AM_rigFlag = ON;
    AM_head = headPtr;
}

/* when a unbound variable head is found   */
void HNL_setRegsFlex(DF_TermPtr headPtr)
{
    AM_consFlag = AM_rigFlag = OFF;
    AM_head = headPtr;
}

/************************************************************************/
/*  Term creation functions                                             */
/************************************************************************/

/* Push de Bruijn index #ind on the current heap top                    */
void HNL_pushBV(int ind)
{
    MemPtr newhtop = AM_hreg + DF_TM_ATOMIC_SIZE; //new heap top
    AM_heapError(newhtop);
    DF_mkBV(AM_hreg, ind);
    AM_hreg = newhtop;    
}

/* Push abstraction lam(n, body) on the current heap top.               */
void HNL_pushLam(DF_TermPtr bodyPtr, int n)
{
    MemPtr newhtop = AM_hreg + DF_TM_LAM_SIZE;    //new heap top
    AM_heapError(newhtop);
    DF_mkLam(AM_hreg, n, bodyPtr);
    AM_hreg = newhtop;
}

/* Push cons(argvecPtr) on the current heap top                         */
void HNL_pushCons(DF_TermPtr argvecPtr)
{
    MemPtr newhtop = AM_hreg + DF_TM_CONS_SIZE;   //new heap top
    AM_heapError(newhtop);
    DF_mkCons(AM_hreg, argvecPtr);
    AM_hreg = newhtop;
}

/* Push an application on the current heap top.                         */
void HNL_pushApp(DF_TermPtr funcPtr, DF_TermPtr argvecPtr, int arity)
{
    MemPtr newhtop = AM_hreg + DF_TM_APP_SIZE;
    AM_heapError(newhtop);
    DF_mkApp(AM_hreg, arity, funcPtr, argvecPtr);
    AM_hreg = newhtop;
}

/* Push suspension [|skPtr, ol, nl, e|] on the current heap top.        */
void HNL_pushSusp(DF_TermPtr skPtr, int ol, int nl, DF_EnvPtr e)
{
    MemPtr newhtop = AM_hreg + DF_TM_SUSP_SIZE;   //new heap top
    AM_heapError(newhtop);
    DF_mkSusp(AM_hreg, ol, nl, skPtr, e);
    AM_hreg = newhtop;
}

/* Push suspension [|skPtr, ol, nl, e|] on a given location, the pointer to
   that location is increamented as side-effect                         */
void HNL_pushSuspOnLoc(DF_TermPtr skPtr, int ol, int nl, DF_EnvPtr e,
                       MemPtr *locPtr)
{
    MemPtr loc = *locPtr, newloc = loc + DF_TM_SUSP_SIZE;
    AM_heapError(newloc);
    DF_mkSusp(loc, ol, nl, skPtr, e);
    *locPtr = newloc;
}

/* Destructively change the cell referred to by tmPtr to a reference.
   The change is trailed if necessary.                                  */
void HNL_updateToRef(DF_TermPtr tmPtr, DF_TermPtr target)
{
    TR_trailHTerm(tmPtr);
    DF_mkRef((MemPtr)tmPtr, target);
}

/************************************************************************/
/*  Functions for eagerly evaluating implicit renumber suspensions      */
/*----------------------------------------------------------------------*/
/* General comments:                                                    */
/* Renumbering suspensions [|skPtr, 0, nl, nil|]                        */
/* Specifically, if skPtr is a (special) constant, de Bruijn index or a */
/* unbound variable, the suspension is eagerly evaluated; otherwise     */
/* it is suspended. In case skPtr is another suspension, combination is */
/* performed.                                                           */
/************************************************************************/

/* Used in HNL_BVSuspAsEnv.
   The renumber suspension belongs to an environment list.              
   A pointer to the evaluation result is returned. New suspensions are 
   pushed on the current heap top if necessary.                         
*/ 
static DF_TermPtr HNL_renumberAsEnv(DF_TermPtr skPtr, int nl)
{
    DF_TermPtr rtPtr = NULL; //term pointer to be returned
  restart_renumberAsEnv:
    switch (DF_termTag(skPtr)){    
    case DF_TM_TAG_VAR:
    case DF_TM_TAG_CONST:
    case DF_TM_TAG_INT:
    case DF_TM_TAG_FLOAT:
    case DF_TM_TAG_NIL:
    case DF_TM_TAG_STR:
    case DF_TM_TAG_STREAM:  
    {   rtPtr = skPtr; break; }
    case DF_TM_TAG_LAM:
    case DF_TM_TAG_CONS:
    case DF_TM_TAG_APP:  //[|skPtr, 0, nl, nil|]
    { 
        if (nl == 0) rtPtr = skPtr;
        else {
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushSusp(skPtr, 0, nl, DF_EMPTY_ENV);
        }
        break;
    }
    case DF_TM_TAG_SUSP: //[|[|t,ol,nl,e|],0,l,nil|] -> [|t,ol,nl+l,e|]
    {
        if (nl == 0) rtPtr = skPtr;
        else {
            int          myol    = DF_suspOL(skPtr),   mynl = DF_suspNL(skPtr);
            DF_EnvPtr    myenv   = DF_suspEnv(skPtr);
            int          newnl   = mynl+nl;
            
            AM_embedError(newnl);
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushSusp(skPtr, myol, newnl, myenv);
        }
        break;
    }                                
    case DF_TM_TAG_BVAR: //[|#i, 0, nl, nil |] -> #(i+nl)
    {    
        int newind = DF_bvIndex(skPtr)+nl;

        AM_embedError(newind);
        rtPtr = (DF_TermPtr)AM_hreg;
        HNL_pushBV(newind);
        break;
    }
    case DF_TM_TAG_REF:{skPtr=DF_termDeref(skPtr); goto restart_renumberAsEnv; }
    }//switch
    return rtPtr;
}

/* Used in HNL_BVSuspAsArg.
   The renumber suspension belongs to the arguments of an application or 
   cons. 
   In case the evaluation result has an atomic size and is not a unbound 
   variable, it is committed on the heap location referred to by loc.
   If the evaluation result is a free variable or a constant with type
   associations, a reference to the result is created on the heap location
   referred to by loc.
   Otherwise, the evaluation result must be a suspension, and in this case,
   the new suspension is created on the location referred to by (*spLocPtr),
   (*spLocPtr) is increamented by a suspension size, and a reference to the 
   new suspension is created on the location pointed by loc.               */
static void HNL_renumberAsArg(DF_TermPtr skPtr, int nl, MemPtr loc, 
                              MemPtr *spLocPtr)
{
  restart_renumberAsArg:
    switch (DF_termTag(skPtr)){    
    case DF_TM_TAG_VAR:    { DF_mkRef(loc, skPtr); break; }
    case DF_TM_TAG_CONST:
    {
        if (DF_isTConst(skPtr)) DF_mkRef(loc, skPtr);
        else DF_copyAtomic(skPtr, loc);
        break;
    }
    case DF_TM_TAG_INT:
    case DF_TM_TAG_FLOAT:
    case DF_TM_TAG_NIL:
    case DF_TM_TAG_STR:
    case DF_TM_TAG_STREAM: 
    {    DF_copyAtomic(skPtr, loc); break;}
    case DF_TM_TAG_LAM:
    case DF_TM_TAG_CONS:
    case DF_TM_TAG_APP:  //[|t, 0, nl, nil|]
    { 
        if (nl == 0) DF_mkRef(loc, skPtr);
        else {
            DF_mkRef(loc, (DF_TermPtr)(*spLocPtr)); 
            HNL_pushSuspOnLoc(skPtr, 0, nl, DF_EMPTY_ENV, spLocPtr); 
        }
        break;
    }
    case DF_TM_TAG_SUSP: //[|[|t,ol,nl,e|],0,l,nil|] -> [|t,ol,nl+l,e|]
    { 
        if (nl == 0) DF_mkRef(loc, skPtr);
        else {
            DF_TermPtr     myskPtr = DF_termDeref(DF_suspTermSkel(skPtr));
            int            myol  = DF_suspOL(skPtr),  mynl = DF_suspNL(skPtr);
            DF_EnvPtr      myenv = DF_suspEnv(skPtr);
            int            newnl = mynl+nl;
        
            AM_embedError(newnl);
            DF_mkRef(loc, (DF_TermPtr)(*spLocPtr)); 
            HNL_pushSuspOnLoc(myskPtr, myol, newnl, myenv, spLocPtr); 
        }          
	break;
    }
    case DF_TM_TAG_BVAR: //[|#i, 0, adj, nil |] -> #(i+adj)
    {    
        int newind = DF_bvIndex(skPtr)+nl;
        AM_embedError(newind);
        DF_mkBV(loc, newind);
        break;
    }
    case DF_TM_TAG_REF:{skPtr=DF_termDeref(skPtr); goto restart_renumberAsArg;}
    }
}


/************************************************************************/
/*  Functions for eagerly evaluating implicit suspensions with          */
/*  de Bruijn indices as term skeleton.                                 */
/*----------------------------------------------------------------------*/
/* General comments:                                                    */
/* suspension [|#ind, ol, nl, env|]                                     */
/* The suspension is eagerly evaluated till a non-suspension term or a  */
/* un-trivial suspension is resulted.                                   */
/************************************************************************/

/* Used in HNL_suspAsEnv.
   The suspension belongs to an environment list.
   A pointer to the evaluation result is returned. If new suspensions 
   need to be created, they are pushed on the current heap top.         */
static DF_TermPtr HNL_BVSuspAsEnv(int ind, int ol, int nl, DF_EnvPtr env)
{
    DF_TermPtr rtPtr; //term pointer to be returned
    if (ind > ol){          //[|#i, ol, nl, env|] -> #(i-ol+nl), where i>ol
        int newind = ind - ol + nl;
        
        AM_embedError(newind);
        rtPtr = (DF_TermPtr)AM_hreg;
        HNL_pushBV(newind);
    } else {// ind <= ol
        DF_EnvPtr   envitem = DF_envListNth(env, ind); //ith in env 
        int         nladj = nl - DF_envIndex(envitem);
        
        if (DF_isDummyEnv(envitem)){//[|#i,ol,nl,..@l..|]->#(nl-l), where i<=ol
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushBV(nladj); 
        } else { //DF_isPairEnv(envitem)
            DF_TermPtr tmPtr = DF_envPairTerm(envitem);
            
            rtPtr = HNL_renumberAsEnv(tmPtr, nladj);
        }
    }      // ind <= ol
    return rtPtr;
}

/* Used in HNL_suspAsArg.
   The suspension belongs to the arguments of an application or cons.
   The pointer loc refers to the heap location where the evaluation result
   or a reference of the evaluation result is to be created, and if new 
   suspensions need to be created, they are created on the heap location
   referred to by *spLocPtr.
*/
static void HNL_BVSuspAsArg(DF_TermPtr bv, int ol, int nl, DF_EnvPtr env, 
                            MemPtr loc, MemPtr *spLocPtr)
{
    int ind = DF_bvIndex(bv); //index of the bv
    if (ind > ol){            //[|#i, ol, nl, env|] -> #(i-ol+nl), where i>ol
        int newind = ind - ol + nl;

        AM_embedError(newind);
        DF_mkBV(loc, newind);
    } else {//ind <= ol
        DF_EnvPtr   envitem = DF_envListNth(env, ind); //ith item in env
        int         nladj = nl - DF_envIndex(envitem);
        
        if (DF_isDummyEnv(envitem)){//[|#i,ol,nl,..@l..|]->#(nl-l), where i<=ol 
            DF_mkBV(loc, nladj);
        } else { //DF_IsPairEnv(envitem)
            DF_TermPtr tmPtr = DF_envPairTerm(envitem); 
	    HNL_renumberAsArg(tmPtr, nladj, loc, spLocPtr);
        }   //ind <= ol
    }
}

/************************************************************************/
/*  Functions for eagerly evaluating implicit suspensions               */
/*----------------------------------------------------------------------*/
/* General comments:                                                    */
/* suspension [|skPtr ol, nl, env|]                                     */
/* The suspension is eagerly evaluated till a non-suspension term or a  */
/* un-trivial suspension is resulted.                                   */
/************************************************************************/

/* The suspension belongs to an environment list.
   A pointer to the evaluation result is returned. New suspensions are 
   pushed on the current heap top if necessary.                         */
DF_TermPtr HNL_suspAsEnv(DF_TermPtr skPtr, int ol, int nl, DF_EnvPtr env)
{
    DF_TermPtr rtPtr = NULL;      // term pointer to be returned
  restart_suspAsEnv:
    switch(DF_termTag(skPtr)){   //[|c, ol, nl, envlist|] -> c
    case DF_TM_TAG_VAR:
    case DF_TM_TAG_CONST:
    case DF_TM_TAG_INT:
    case DF_TM_TAG_FLOAT:
    case DF_TM_TAG_NIL:
    case DF_TM_TAG_STR:
    case DF_TM_TAG_STREAM:
    {   rtPtr = skPtr;   break; }
    case DF_TM_TAG_LAM:
    case DF_TM_TAG_CONS:
    case DF_TM_TAG_SUSP:
    case DF_TM_TAG_APP:
    {
        rtPtr = (DF_TermPtr)AM_hreg;
        HNL_pushSusp(skPtr, ol, nl, env);
        break;
    }
    case DF_TM_TAG_BVAR:
    {
        int  dbind = DF_bvIndex(skPtr);
        rtPtr = HNL_BVSuspAsEnv(dbind, ol, nl, env);
        break;
    }
    case DF_TM_TAG_REF: { skPtr = DF_termDeref(skPtr); goto restart_suspAsEnv; }
    }
    return rtPtr;
}

/* Used in HNL_pushSuspOverArgs.
   The suspension belongs to the arguments of an application or cons.
   The pointer loc refers to the heap location where the evaluation result
   or a reference of the evaluation result is to be created, and if new 
   suspensions need to be created, they are created on the heap location
   referred to by *spLocPtr.
   A flag CHANGED is used to indicate whether the evaluation result is different
   from skPtr.
*/
static void HNL_suspAsArg(DF_TermPtr skPtr, int ol, int nl, DF_EnvPtr env, 
                          MemPtr loc, MemPtr *spLocPtr, Boolean *changed)
{
  restart_suspAsArg:
    switch(DF_termTag(skPtr)){   
    case DF_TM_TAG_VAR: { DF_mkRef(loc, skPtr); break; }
    case DF_TM_TAG_CONST:
    {
        if (DF_isTConst(skPtr)) DF_mkRef(loc, skPtr);
        else DF_copyAtomic(skPtr, loc);
        break;
    }
    case DF_TM_TAG_INT:
    case DF_TM_TAG_FLOAT:
    case DF_TM_TAG_NIL:
    case DF_TM_TAG_STR:
    case DF_TM_TAG_STREAM:
    {        
        DF_copyAtomic(skPtr, loc);
        break;
    }
    case DF_TM_TAG_LAM:
    case DF_TM_TAG_CONS:
    case DF_TM_TAG_SUSP:
    case DF_TM_TAG_APP:
    {
        DF_mkRef(loc, (DF_TermPtr)(*spLocPtr));
        HNL_pushSuspOnLoc(skPtr, ol, nl, env, spLocPtr);
        *changed = TRUE;
        break;
    }
    case DF_TM_TAG_BVAR:
    {

        HNL_BVSuspAsArg(skPtr, ol, nl, env, loc, spLocPtr);
        *changed = TRUE;
        break;
    }
    case DF_TM_TAG_REF: { skPtr = DF_termDeref(skPtr); goto restart_suspAsArg; }
    }
}

/************************************************************************/
/* Functions for creating application argument vectors                  */
/*----------------------------------------------------------------------*/
/* Gerenal comments:                                                    */
/* Two issues are considered here.                                      */
/* 1. When the application (cons) is embedded inside a non-empty        */
/*    suspension, the suspension has to be propagated over their        */
/*    arguments. In this process, trivial suspensions (those over atomic*/
/*    terms including de Bruijn indices) are eagerly evaluated.         */
/* 2. When the application has a function being another application     */
/*    (indicated by AM_numArgs), the nested structures should be        */
/*    un-folded. In particular, an argument vector with that of the     */
/*    "top-level" application (possibly changed from propagating        */
/*    suspensions), and that of the "inner" application has to be       */
/*    created on the current top of heap.                               */
/* Such functionality is realized by the following procedures.          */
/************************************************************************/  

/* Copy an argument vector start from argvec onto the current top of 
   heap. Needed in unfolding nested applications.
   Note that a reference has to be made for unbound variables as opposed 
   to duplication.
*/   
void HNL_copyArgs(DF_TermPtr argvec, int arity)
{
    int i;
    for (i = 1; i <= arity; i++){
        if (DF_isFV(argvec)) DF_mkRef(AM_hreg, argvec);
        else DF_copyAtomic(argvec, AM_hreg);        
        AM_hreg += DF_TM_ATOMIC_SIZE;
        argvec = (DF_TermPtr)(((MemPtr)argvec)+DF_TM_ATOMIC_SIZE);
    }
}


/* Create an argument vector for applications inside an empty environment.
   If no other application is nested in this one, the old argument vector is 
   used. Specifically, AM_argVec is set to refer the starting address of 
   the old argument vector, AM_numArgs is set to its arity, and FALSE is
   returned to indicate no changes occur in the vector.
   Otherwise, a new vector copied from that referred to by argvec and 
   the other referred to by AM_argVec is created on the current top of heap.
   AM_argVec and AM_numArgs are updated correspondingly, and TRUE is 
   returned to indicate a new vector should be used for the application.
*/

Boolean HNL_makeArgvecEmpEnv(DF_TermPtr argvec, int arity)
{
    if (AM_numArgs == 0) {  //no nested app
        AM_argVec = argvec;   //reuse the old argvec
        AM_numArgs = arity;
        return FALSE;
    } else {                //unfold nested app
        DF_TermPtr newArgvec = (DF_TermPtr)AM_hreg; 
        int        newArity  = arity + AM_numArgs;
        MemPtr     newhtop   = AM_hreg + arity * DF_TM_ATOMIC_SIZE;
        
        AM_arityError(newArity);
        AM_heapError(newhtop);
        HNL_copyArgs(AM_argVec, AM_numArgs);   //lay out inner argvec
        HNL_copyArgs(argvec, arity);           //lay out top-level argvec
        
        AM_argVec  = newArgvec;
        AM_numArgs = newArity;
        return TRUE;
    }
}

/* Propagate a suspension environment given by (ol, nl, env) over the 
   argument vector referred to by argvec. Trivial suspensions are eagerly
   evaluated in this process. Non-trivial ones are created on the location
   referred to by *spLocPtr.
   Further, a flag changed is used to indicate whether the propagating 
   result is the same as the original argument vector.
*/
static void HNL_pushSuspOverArgs(DF_TermPtr argvec, int arity, int ol, int nl, 
                                 DF_EnvPtr env, MemPtr *spLocPtr,
                                 Boolean *changed)
{
    int i;
    MemPtr myArgvec = AM_hreg;//AM_hreg has not been moved yet

    for (i = 1; i <= arity; i++){
        HNL_suspAsArg(argvec, ol, nl, env, myArgvec, spLocPtr, changed);
        myArgvec = myArgvec + DF_TM_ATOMIC_SIZE;
        argvec   = (DF_TermPtr)(((MemPtr)argvec)+DF_TM_ATOMIC_SIZE);
    }
}

/* Create an argument vector for applications inside a non-empty environment.
   Actions are carried out in two steps:
   First, nested applications are unfolded if arising. Second, the 
   non-empty environment is propagated over the argument vector of the (top)
   application. 
   It is assumed that the vector will be changed in the beginning of both 
   processes, and a flag changed is used to indicate whether changes really
   occur. The new argument vector is used and the top of heap is updated only
   when the changed flag is TRUE upon termination. Otherwise, the old argument
   is used. The flag changed is also returned to the caller to indicate which
   vector is used.   
*/
Boolean HNL_makeArgvec(DF_TermPtr argvec, int arity, int ol, int nl,
                       DF_EnvPtr  env)
{
    Boolean  changed; //flag denoting if new argvec is made or the old is reused
    MemPtr   spLocPtr; //place where susps are to be created
    MemPtr   newArgvec = AM_hreg; 


    //unfold nested app first when necessary
    if (AM_numArgs == 0){  //no nested app
        //assume new arg vector has to be created because of susp propagating      
        spLocPtr = newArgvec + arity * DF_TM_ATOMIC_SIZE;  
        AM_heapError(spLocPtr);
        AM_numArgs = arity;
        changed = FALSE;   //indicating no change is made for unfolding app
    } else {               //unfold nested app
        int newArity = arity + AM_numArgs;
 
        AM_arityError(newArity);
        //assume new arg vector has to be created because of susp propagating
        spLocPtr = newArgvec + newArity * DF_TM_ATOMIC_SIZE;
        AM_heapError(spLocPtr);
        HNL_copyArgs(AM_argVec, AM_numArgs); //lay out inner argvec
        AM_numArgs = newArity;
        changed = TRUE;   //indicating changes are made for unfolding app
    }
    
    //push susp over the argument vector of the top-level app
    HNL_pushSuspOverArgs(argvec, arity, ol, nl, env, &spLocPtr, &changed);
 
    if (changed) {             //changes because of unfold app or propagate susp
        AM_hreg = spLocPtr;
        AM_argVec = (DF_TermPtr)newArgvec;
    } else AM_argVec = argvec; //no change, reuse the old arg vector
    return changed;
}

/* A specialized version of HNL_makeArgvec for argument vectors on cons.
   The arity of cons is fixed, and there is no need to considering "unfolding".
*/
Boolean HNL_makeConsArgvec(DF_TermPtr argvec, int ol, int nl, DF_EnvPtr env)
{
    MemPtr  spLocPtr;
    MemPtr  newArgvec = AM_hreg;
    Boolean changed = FALSE;
    
    spLocPtr = newArgvec + DF_CONS_ARITY * DF_TM_ATOMIC_SIZE;
    AM_heapError(spLocPtr);
    HNL_pushSuspOverArgs(argvec,DF_CONS_ARITY,ol,nl,env,&spLocPtr,&changed);

    AM_numArgs = DF_CONS_ARITY;
    if (changed){
        AM_hreg = spLocPtr;
        AM_argVec = (DF_TermPtr)newArgvec;
    } else AM_argVec = argvec;

    return changed;
}

#endif //HNORMLOCAL_C
