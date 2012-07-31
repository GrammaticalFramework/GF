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
/* File hnorm.c.                                                            */
/* This file contains the head normalization routines.                      */
/* These procedures are based on the suspension calculus, and the reduction */
/* strategy with lazy reduction, lazy substitution and lazy heap            */
/* commitment is chosen. A SML realization of this process is described in  */
/* paper "Choices in Representation and Reduction Strategies for Lambda     */
/* Terms in Intersional Contexts".                                          */
/****************************************************************************/

#ifndef HNORM_C
#define HNORM_C

#include <stdlib.h>
#include "dataformats.h"
#include "mctypes.h"
#include "hnorm.h"
#include "hnormlocal.h"
#include "abstmachine.h"
#include "../system/error.h" 

//for debugging: to be removed
#include <stdio.h>
#include "printterm.h"
#include "../system/stream.h"

/*****************************************************************************/
/* a global(to file hnorm.c) encoding  of the explicit suspension environment*/
/* and simple checking and updating functions on this environment            */
/*****************************************************************************/
/* environment of the implicit suspension, which is initialized to empty*/
static int        ol, nl;
static DF_EnvPtr  envlist;

/* clean the environment to empty */
static void    HN_setEmptyEnv()   { ol = 0; nl = 0; envlist = DF_EMPTY_ENV; }
/* set the environment according to given values */
static void    HN_setEnv(int o, int n, DF_EnvPtr e)
{   ol = o;   nl = n;   envlist = e; }
/* is an empty environment? */
static Boolean HN_isEmptyEnv()    { return ((ol == 0) && (nl == 0));       }

/****************************************************************************/
/* Functions for creating (modifying) the environment list in the suspension*/
/* environment defined by ol, nl and envlist according to their current     */
/* values.                                                                  */
/****************************************************************************/

/* Add n (n > 0) dummy environment items to the front of the current 
   environment list:   @(nl+n-1) :: ... :: @nl :: envlist.
   New dummy env items are created on the current heap top.
*/
static DF_EnvPtr HN_addNDummyEnv(int n)
{
    int i;
    DF_EnvPtr last = envlist, current;

    AM_heapError(AM_hreg + n * DF_ENV_DUMMY_SIZE);
    for (i = 0; i < n; i++){
        current = (DF_EnvPtr)AM_hreg;
        DF_mkDummyEnv(AM_hreg, nl+i, last);
        AM_hreg += DF_ENV_DUMMY_SIZE;
        last = current;
    }
    return current;
}

/* Add n (n > 0) pair environment items to the front of the current 
   environment list as the following:  
   ([|an,myol,mynl,myenv|],nl):: ... ::([|ai,myol,mynl,myenv|],nl)::envlist,
   where ai is the ith argument in the vector referred to by argvec.
   Note if ai is an atomic term, the suspension over it is eagerly evaluated.
 */
static DF_EnvPtr HN_addNPair(DF_TermPtr argvec, int myol, int mynl, 
                             DF_EnvPtr  myenv,  int n)
{
    int i;
    DF_EnvPtr   last = envlist, current;
    MemPtr      myEnvlist = AM_hreg;
    MemPtr      newhtop = AM_hreg + n * DF_ENV_PAIR_SIZE;
    
    AM_heapError(newhtop);
    AM_hreg = newhtop;              //spare space for n pair env items
    for (i = 1; i<= n; i++) {
        current = (DF_EnvPtr)myEnvlist;
        DF_mkPairEnv(myEnvlist, nl, HNL_suspAsEnv(argvec,myol,mynl,myenv), 
                     last);
        myEnvlist += DF_ENV_PAIR_SIZE;
        last = current;
        argvec = (DF_TermPtr)(((MemPtr)argvec) + DF_TM_ATOMIC_SIZE);
    }
    return current;
}   

/* A specialized version of HN_addNPair when the incoming environment is 
   empty.
   Now, n (n > 0) pair environment items are added to the front of the 
   current environment list as the following:
   (an,0) :: ... :: (a1,0) :: envlist, where ai is the ith argument in the
   vector referred to by argvec.
 */
static DF_EnvPtr HN_addNPairEmpEnv(DF_TermPtr argvec, int n)
{
    int i;
    DF_EnvPtr    last = envlist, current;
    AM_heapError(AM_hreg + n * DF_ENV_PAIR_SIZE);
    for (i = 1; i <= n; i++) {
        current = (DF_EnvPtr)AM_hreg;
        DF_mkPairEnv(AM_hreg, 0, argvec, last);
        AM_hreg += DF_ENV_PAIR_SIZE;
        last = current;
        argvec = (DF_TermPtr)(((MemPtr)argvec) + DF_TM_ATOMIC_SIZE);
    }
    return current;
}

/****************************************************************************/
/* A function for pushing suspension over n abstractions following the rule */
/* [|lam(n,body), ol, nl, envlist|]                                         */
/*     -> lam(n, [|body, ol+n, nl+n, @(nl+n-1) :: ... :: @nl :: envlist |]  */
/* The result is committed on the current top of heap.                      */
/* The top-level (implicit) suspension is given by the global variable      */
/* ol, nl, and envlist.                                                     */
/* This function is used in HN_hnormSusp, HN_hnormSuspOCC and HN_lnormSusp. */ 
/****************************************************************************/
static DF_TermPtr HN_pushSuspOverLam(DF_TermPtr lamPtr)
{
    DF_TermPtr    rtPtr;      //term pointer to be returned 
    DF_TermPtr    suspPtr;    //explicit susp as the lam body in the result
    int           numabs =DF_lamNumAbs(lamPtr);
    int           newol = ol + numabs, newnl = nl + numabs;
    MemPtr        newhtop = AM_hreg+ DF_TM_SUSP_SIZE+ numabs*DF_TM_ATOMIC_SIZE;
    DF_EnvPtr     newenv;

    AM_embedError(newol);
    AM_embedError(newnl);
    AM_heapError(newhtop);   
    newenv  = HN_addNDummyEnv(numabs);
    suspPtr = HNL_suspAsEnv(DF_lamBody(lamPtr), newol, newnl, newenv);
    rtPtr   = (DF_TermPtr)AM_hreg; //create lam over the susp
    DF_mkLam(AM_hreg, numabs, suspPtr);
    AM_hreg = newhtop;

    return rtPtr;
}

/****************************************************************************/
/* functions for (weak) head normalizing terms of known categories          */
/*--------------------------------------------------------------------------*/
/* General comments:                                                        */
/*  An implicit suspension is given by the global variables ol, nl and      */
/*  envlist together with the first argument tmPtr to the sub-functions:    */
/*  [|tmPtr, ol, nl, envlist|]                                              */
/*  The suspension environment could be empty in which case the term        */
/*  being normalized is tmPtr itself.                                       */
/*  The second argument of the sub-functions whnf is a flag indicating      */
/*  whether a head normal form or a weak head normal form is being          */
/*  computed.                                                               */ 
/****************************************************************************/
static DF_TermPtr HN_hnormDispatch(DF_TermPtr tmPtr, Boolean whnf);

/* (weak) head normalize bound variable or implicit suspension with 
   bound variable as term skeleton. */
static DF_TermPtr HN_hnormBV(DF_TermPtr bvPtr, Boolean whnf)
{
							
    DF_TermPtr rtPtr; //term pointer to be returned
    if (HN_isEmptyEnv()){                        //[|#i, 0, 0, nil|] -> #i
        rtPtr = bvPtr;
        HNL_setRegsRig(bvPtr);
    } else { //non-empty env       
        int dbind = DF_bvIndex(bvPtr);

        if (dbind > ol) {                        //[|#i,ol,nl,e|] -> #i-ol+nl
            int newind = dbind - ol + nl;

            AM_embedError(newind);
            rtPtr =(DF_TermPtr)AM_hreg;
            HNL_pushBV(newind); 
            HNL_setRegsRig(rtPtr);
            HN_setEmptyEnv();
        } else { // i <= ol
            DF_EnvPtr    envitem = DF_envListNth(envlist, dbind);
            int          nladj   = nl-DF_envIndex(envitem);

            if (DF_isDummyEnv(envitem)){         //[|#i,ol,nl,..@l..|]->#(nl-l)
                rtPtr = (DF_TermPtr)AM_hreg;
                HNL_pushBV(nladj); 
                HNL_setRegsRig(rtPtr);
                HN_setEmptyEnv();
            }  else { //pair env    [|#i,ol,nl,..(s,l)..|] -> [|s,0,(nl-l),nil|]
                DF_TermPtr tmPtr = DF_termDeref(DF_envPairTerm(envitem));
                if ((nladj != 0) && (DF_isSusp(tmPtr))) {//combine susp
                    int newnl = DF_suspNL(tmPtr)+nladj;
                    AM_embedError(newnl);
                    HN_setEnv(DF_suspOL(tmPtr), newnl, DF_suspEnv(tmPtr));
                    rtPtr = HN_hnormDispatch(DF_suspTermSkel(tmPtr), whnf);
                } else {      
                    HN_setEnv(0, nladj, DF_EMPTY_ENV); 
                    rtPtr = HN_hnormDispatch(tmPtr, whnf);
                }
            }         //pair env  
        }        // i<= ol    
    }        //non-empty env

    return rtPtr;    
}


/* (weak) head normalize an abstraction or implicit suspension with term
   skeleton as an abstraction. 
   If an implicit suspension is weak head normalized, the suspension itself
   is returned. The descendant of this suspension over its abstraction skeleton
   is performed in the subsequent app case on a fly.
   Note that this is the only case that hnorm termniates with a non-empty 
   environment.
*/
static DF_TermPtr HN_hnormLam(DF_TermPtr lamPtr, Boolean whnf)
{
    DF_TermPtr rtPtr; //term pointer to be returned

    if (whnf) return rtPtr = lamPtr; //weak hn 
    else {  //whnf = FALSE
        int numabs = DF_lamNumAbs(lamPtr);
        DF_TermPtr newbody;

        if (HN_isEmptyEnv()){
            newbody = HN_hnormDispatch(DF_lamBody(lamPtr), FALSE);
            rtPtr = lamPtr; //body must have been adjusted in place
        } else {  // non-empty env 
            //[|lam(n,t),ol,nl,e|] ->lam(n,[|t,ol+n,nl+n,@nl+n-1...::@nl::e|]
            int newol = ol+numabs, newnl = nl+numabs;
            
            AM_embedError(newol);
            AM_embedError(newnl);
            HN_setEnv(newol, newnl, HN_addNDummyEnv(numabs));
            newbody = HN_hnormDispatch(DF_lamBody(lamPtr), FALSE);
            /* create a new lam on the result of hn the lam body */
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushLam(newbody, numabs);
        }         // non-empty env
        AM_numAbs += numabs;
    }      //whnf == FALSE
    return rtPtr;
}

/* (weak) head normalize cons or implicit suspension over cons          */
static DF_TermPtr HN_hnormCons(DF_TermPtr consPtr, Boolean whnf)
{
    DF_TermPtr argvec = DF_consArgs(consPtr),
               rtPtr; //term pointer to be returned
    if (HN_isEmptyEnv()){
        AM_argVec = argvec;
        AM_numArgs = DF_CONS_ARITY;
        rtPtr = consPtr;
    } else {
        Boolean changed = HNL_makeConsArgvec(argvec, ol, nl, envlist);
        if (changed){ //new argvec is built because of pushing susp
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushCons(AM_argVec);
        } else rtPtr = consPtr;
	HN_setEmptyEnv();
    }
    HNL_setRegsCons(rtPtr);
    return rtPtr;
}

/* (weak) head normalize application or implicit suspension over 
   application. The old application term is destructively changed into
   a reference to its head normal form or its weak head normal form if
   the weak heap normal form is not an implicit suspension (in which
   case the term skeleton must be an abstraction.).
*/
static DF_TermPtr HN_hnormApp(DF_TermPtr appPtr, Boolean whnf)
{
    DF_TermPtr funPtr = DF_appFunc(appPtr), argvec = DF_appArgs(appPtr),
               rtPtr; // term pointer to be returned
    DF_TermPtr oldFunPtr = funPtr;
    int        arity = DF_appArity(appPtr);
    Boolean    emptyTopEnv = HN_isEmptyEnv();
    int        myol, mynl;       //for book keeping the implicit suspension env
    DF_EnvPtr  myenvlist;        //for book keeping the implicit suspension env
    int        myarity = arity;  //book keeping the arity before contraction    

    if (!emptyTopEnv) {          //book keeping the current environment
        myol = ol; mynl = nl; myenvlist = envlist; 
    }
    funPtr = HN_hnormDispatch(funPtr, TRUE); //whf of the function    
    while ((arity > 0) && (DF_isLam(funPtr))) {
        //perform contraction on top-level redexes while you can
        DF_TermPtr  lamBody = DF_lamBody(funPtr); //abs body
        int         numAbsInFun = DF_lamNumAbs(funPtr);   
        int         numContract = ((arity<=numAbsInFun) ? arity : numAbsInFun);
        DF_EnvPtr   newenv;
        int         newol = ol + numContract;        

        AM_embedError(newol);
        if (emptyTopEnv) newenv = HN_addNPairEmpEnv(argvec, numContract);
        else newenv = HN_addNPair(argvec, myol, mynl, myenvlist, numContract);
        HN_setEnv(newol, nl, newenv);

        if (arity == numAbsInFun){    	  
            funPtr = HN_hnormDispatch(lamBody, whnf);
            arity = 0;
        } else if (arity > numAbsInFun) {
            funPtr = HN_hnormDispatch(lamBody, TRUE);
            argvec=(DF_TermPtr)(((MemPtr)argvec)+numAbsInFun*DF_TM_ATOMIC_SIZE);
            arity -= numAbsInFun;
        } else {  //arity < numabsInFun
            DF_TermPtr newBody = (DF_TermPtr)AM_hreg;
            HNL_pushLam(lamBody, (numAbsInFun-arity));
            funPtr = HN_hnormDispatch(newBody, whnf);
            arity = 0;
        }
    }// while ((arity >0) && (DF_IsLam(fun)))
    
    //update or create application
    if (arity == 0) {  //app disappears   
        rtPtr = funPtr;
        if (emptyTopEnv && HN_isEmptyEnv()) HNL_updateToRef(appPtr, funPtr);
    } else {           //app persists; Note: now HN_isEmptyEnv must be TRUE
        Boolean changed;
        if (emptyTopEnv) changed = HNL_makeArgvecEmpEnv(argvec, arity);
        else changed = HNL_makeArgvec(argvec,arity,myol,mynl,myenvlist);

        if ((!changed) && (arity == myarity) && (funPtr == oldFunPtr)) {
	  rtPtr = appPtr;
        } else {// create new app and in place update the old if empty top env
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushApp(AM_head, AM_argVec, AM_numArgs);
            if (emptyTopEnv) HNL_updateToRef(appPtr, rtPtr);
        }
    }
    return rtPtr;
}

/* (weak) head normalize (explicit) suspension or implicit suspension
   with a suspension term skeletion. The explicit suspension is destructivly
   changed to its head normal form or weak head normal form in case
   that the whn is not an implicit susp itself (in which case the term
   skeleton must be an abstraction).
*/ 
static DF_TermPtr HN_hnormSusp(DF_TermPtr suspPtr, Boolean whnf)
{
    DF_TermPtr rtPtr; //term pointer to be returned
    int myol, mynl ;             // for book keeping the env of implicit susp
    DF_EnvPtr myenvlist;
    Boolean   emptyTopEnv = HN_isEmptyEnv();
    
    if (!emptyTopEnv){
        myol = ol; mynl = nl; myenvlist = envlist;
    }
    //first (weak) head normalize the explicit susp
    HN_setEnv(DF_suspOL(suspPtr), DF_suspNL(suspPtr), DF_suspEnv(suspPtr));
    rtPtr = HN_hnormDispatch(DF_suspTermSkel(suspPtr), whnf);
    if (emptyTopEnv) {
        if (HN_isEmptyEnv()) {
	  HNL_updateToRef(suspPtr, rtPtr);
	}
    } else {           // ! emptyTopEnv
        if (HN_isEmptyEnv()) HNL_updateToRef(suspPtr, rtPtr);
        else rtPtr = HN_pushSuspOverLam(rtPtr);
        //(weak) head norm the top-level (imp) susp
        HN_setEnv(myol, mynl, myenvlist);
        /* note that AM_numabs, AM_numargs and AM_argvec have to be 
           re-initialized, because the (w)hnf of the inner suspension
           is to be traversed again. */
        HNL_initRegs();
        rtPtr = HN_hnormDispatch(rtPtr, whnf);
    }
    return rtPtr;
}

/****************************************************************************/
/* Dispatching on various term categories.                                  */
/****************************************************************************/
static DF_TermPtr HN_hnormDispatch(DF_TermPtr tmPtr, Boolean whnf)
{
  restart:
    switch (DF_termTag(tmPtr)){
    case DF_TM_TAG_VAR: 
    {
        if (!HN_isEmptyEnv()) HN_setEmptyEnv();
        HNL_setRegsFlex(tmPtr);
        return tmPtr;
    }
    case DF_TM_TAG_CONST:
    case DF_TM_TAG_INT:
    case DF_TM_TAG_FLOAT:
    case DF_TM_TAG_NIL:
    case DF_TM_TAG_STR:
    case DF_TM_TAG_STREAM:
    {
        if (!HN_isEmptyEnv()) HN_setEmptyEnv();
        HNL_setRegsRig(tmPtr);
        return tmPtr;
    }
    case DF_TM_TAG_BVAR:     { return HN_hnormBV(tmPtr, whnf);           }
    case DF_TM_TAG_CONS:     { return HN_hnormCons(tmPtr, whnf);         }
    case DF_TM_TAG_LAM:      { return HN_hnormLam(tmPtr, whnf);          }
    case DF_TM_TAG_APP:      { return HN_hnormApp(tmPtr, whnf);          }
    case DF_TM_TAG_SUSP:     { return HN_hnormSusp(tmPtr, whnf);         }
    case DF_TM_TAG_REF:      { tmPtr = DF_termDeref(tmPtr); goto restart;}
    }

    //Impossible to reach this point.
    return NULL;
}

/****************************************************************************/  
/* the interface routine for head normalization                             */
/****************************************************************************/
void HN_hnorm(DF_TermPtr tmPtr)
{    
    HN_setEmptyEnv();            
    HNL_initRegs();
    HN_hnormDispatch(DF_termDeref(tmPtr), FALSE);
}


/****************************************************************************/
/*   HEAD (WEAK HEAD) NORMALIZATION WITH OCCURS CHECK                       */
/*--------------------------------------------------------------------------*/
/* General comments:                                                        */
/*  Checkings are added when the (dereference of) term to be normlized is   */
/*  an application or a cons. If the term is an application, checking is    */
/*  made on whether the application is currently referred                   */
/*  to by register AM_vbbreg, and this checking is added in the APP case    */
/*  of the dispatch function. If the term is a cons, checking is made on    */
/*  whether its argument vector is currently referred to by the register    */
/*  AM_vbbreg, and this checking is added in sub-function HN_hnormConsOcc.  */
/****************************************************************************/
static DF_TermPtr HN_hnormDispatchOcc(DF_TermPtr tmPtr, Boolean whnf);

/****************************************************************************/
/* functions for (weak) head normalizing terms with occurs-check            */
/* of known categories                                                      */
/****************************************************************************/

/* (weak) head normalize bound variable or implicit suspension with 
   bound variable as term skeleton. */
static DF_TermPtr HN_hnormBVOcc(DF_TermPtr bvPtr, Boolean whnf)
{
    DF_TermPtr rtPtr; //term pointer to be returned
    if (HN_isEmptyEnv()){                        //[|#i, 0, 0, nil|] -> #i
        rtPtr = bvPtr;
        HNL_setRegsRig(bvPtr);
    } else { //non-empty env       
        int dbind = DF_bvIndex(bvPtr);

        if (dbind > ol) {                        //[|#i,ol,nl,e|] -> #i-ol+nl
            int newind = dbind - ol + nl;

            AM_embedError(newind);
            rtPtr =(DF_TermPtr)AM_hreg;
            HNL_pushBV(newind); 
            HNL_setRegsRig(rtPtr);
            HN_setEmptyEnv();
        } else { // i <= ol
            DF_EnvPtr    envitem = DF_envListNth(envlist, dbind);
            int          nladj   = nl-DF_envIndex(envitem);

            if (DF_isDummyEnv(envitem)){         //[|#i,ol,nl,..@l..|]->#(nl-l)
                rtPtr = (DF_TermPtr)AM_hreg;
                HNL_pushBV(nladj); 
                HNL_setRegsRig(rtPtr);
                HN_setEmptyEnv();
            }  else { //pair env    [|#i,ol,nl,..(s,l)..|] -> [|s,0,(nl-l),nil|]
                DF_TermPtr tmPtr = DF_termDeref(DF_envPairTerm(envitem));
                if ((nladj != 0) && (DF_isSusp(tmPtr))) {//combine susp
                    int newnl = DF_suspNL(tmPtr)+nladj;
                    AM_embedError(newnl);
                    HN_setEnv(DF_suspOL(tmPtr), newnl, DF_suspEnv(tmPtr));
                    rtPtr = HN_hnormDispatchOcc(DF_suspTermSkel(tmPtr), whnf);
                } else {      
                    HN_setEnv(0, nladj, DF_EMPTY_ENV); 
                    rtPtr = HN_hnormDispatchOcc(tmPtr, whnf);
                }
            }         //pair env  
        }        // i<= ol    
    }        //non-empty env
    return rtPtr;
}

/* (weak) head normalize an abstraction or implicit suspension with term
   skeleton as an abstraction. */
static DF_TermPtr HN_hnormLamOcc(DF_TermPtr lamPtr, Boolean whnf)
{
    DF_TermPtr rtPtr; //term pointer to be returned

    if (whnf) return rtPtr = lamPtr; //weak hn 
    else {  //whnf = FALSE
        int numabs = DF_lamNumAbs(lamPtr);
        DF_TermPtr newbody;

        if (HN_isEmptyEnv()){
            newbody = HN_hnormDispatchOcc(DF_lamBody(lamPtr), FALSE);
            rtPtr = lamPtr; //body must have been adjusted in place
        } else {  // non-empty env 
            //[|lam(n,t),ol,nl,e|] ->lam(n,[|t,ol+n,nl+n,@nl+n-1...::@nl::e|]
            int newol = ol+numabs, newnl = nl+numabs;
            
            AM_embedError(newol);
            AM_embedError(newnl);
            HN_setEnv(newol, newnl, HN_addNDummyEnv(numabs));
            newbody = HN_hnormDispatchOcc(DF_lamBody(lamPtr), FALSE);
            /* create a new lam on the result of hn the lam body */
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushLam(newbody, numabs);
        }         // non-empty env
        AM_numAbs += numabs;
    }      //whnf == FALSE
    return rtPtr;
}

/* (weak) head normalize cons or implicit suspension over cons.
   Note checking on whether the argument vector of the cons term is referred to
   by the register AM_vbbreg is made.
*/
static DF_TermPtr HN_hnormConsOcc(DF_TermPtr consPtr, Boolean whnf)
{
    DF_TermPtr argvec = DF_consArgs(consPtr),
               rtPtr; //term pointer to be returned
    if (AM_vbbreg == argvec) EM_THROW(EM_FAIL);    
    if (HN_isEmptyEnv()){
        AM_argVec = argvec;
        AM_numArgs = DF_CONS_ARITY;
        rtPtr = consPtr;
    } else {
        Boolean changed = HNL_makeConsArgvec(argvec, ol, nl, envlist);
        if (changed){ //new argvec is built because of pushing susp
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushCons(AM_argVec);
        } else rtPtr = consPtr;
	HN_setEmptyEnv();
    }
    HNL_setRegsCons(rtPtr);
    return rtPtr;
}

/* (weak) head normalize application or implicit suspension over 
   application.
*/
static DF_TermPtr HN_hnormAppOcc(DF_TermPtr appPtr, Boolean whnf)
{
    DF_TermPtr funPtr = DF_appFunc(appPtr), argvec = DF_appArgs(appPtr),
               rtPtr; // term pointer to be returned
    DF_TermPtr oldFunPtr = funPtr;
    int        arity = DF_appArity(appPtr);
    Boolean    emptyTopEnv = HN_isEmptyEnv();
    int        myol, mynl;       //for book keeping the implicit suspension env
    DF_EnvPtr  myenvlist;        //for book keeping the implicit suspension env
    int        myarity = arity;  //book keeping the arity before contraction

    if (!emptyTopEnv) {          //book keeping the current environment
        myol = ol; mynl = nl; myenvlist = envlist; 
    }
    funPtr = HN_hnormDispatchOcc(funPtr, TRUE); //whf of the function    
    while ((arity > 0) && (DF_isLam(funPtr))) {
        //perform contraction on top-level redexes while you can
        DF_TermPtr  lamBody = DF_lamBody(funPtr); //abs body
        int         numAbsInFun = DF_lamNumAbs(funPtr);   
        int         numContract = ((arity<=numAbsInFun) ? arity : numAbsInFun);
        DF_EnvPtr   newenv;
        int         newol = ol + numContract;        

        AM_embedError(newol);
        if (emptyTopEnv) newenv = HN_addNPairEmpEnv(argvec, numContract);
        else newenv = HN_addNPair(argvec, myol, mynl, myenvlist, numContract);
        HN_setEnv(newol, nl, newenv);

        if (arity == numAbsInFun){            
            funPtr = HN_hnormDispatchOcc(lamBody, whnf);
            arity = 0;
        } else if (arity > numAbsInFun) {
            funPtr = HN_hnormDispatchOcc(lamBody, TRUE);
            argvec=(DF_TermPtr)(((MemPtr)argvec)+numAbsInFun*DF_TM_ATOMIC_SIZE);
            arity -= numAbsInFun;
        } else {  //arity < numabsInFun
            DF_TermPtr newBody = (DF_TermPtr)AM_hreg;
            HNL_pushLam(lamBody, (numAbsInFun-arity));
            funPtr = HN_hnormDispatchOcc(newBody, whnf);
            arity = 0;
        }
    }// while ((arity >0) && (DF_IsLam(fun)))
    
    //update or create application
    if (arity == 0) {  //app disappears
        rtPtr = funPtr;
        if (emptyTopEnv && HN_isEmptyEnv()) HNL_updateToRef(appPtr, funPtr);
    } else {           //app persists; Note: now HN_isEmptyEnv must be TRUE
        Boolean changed;
        if (emptyTopEnv) changed = HNL_makeArgvecEmpEnv(argvec, arity);
        else changed = HNL_makeArgvec(argvec,arity,myol,mynl,myenvlist);

        if ((!changed) && (arity == myarity) && (oldFunPtr == funPtr)) {
	  rtPtr = appPtr;
        } else {// create new app and in place update the old if empty top env
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushApp(AM_head, AM_argVec, AM_numArgs);
            if (emptyTopEnv) HNL_updateToRef(appPtr, rtPtr);
        }
    }
    return rtPtr;
}

/* (weak) head normalize (explicit) suspension or implicit suspension
   with a suspension term skeletion. 
*/ 
static DF_TermPtr HN_hnormSuspOcc(DF_TermPtr suspPtr, Boolean whnf)
{
    DF_TermPtr rtPtr; //term pointer to be returned
    int myol, mynl ;             // for book keeping the env of implicit susp
    DF_EnvPtr myenvlist;
    Boolean   emptyTopEnv = HN_isEmptyEnv();
    
    if (!emptyTopEnv){
        myol = ol; mynl = nl; myenvlist = envlist;
    }
    //first (weak) head normalize the explicit susp
    HN_setEnv(DF_suspOL(suspPtr), DF_suspNL(suspPtr), DF_suspEnv(suspPtr));
    rtPtr = HN_hnormDispatchOcc(DF_suspTermSkel(suspPtr), whnf);

    if (emptyTopEnv) {
        if (HN_isEmptyEnv()) HNL_updateToRef(suspPtr, rtPtr);
    } else {           // ! emptyTopEnv
        if (HN_isEmptyEnv()) HNL_updateToRef(suspPtr, rtPtr);
        else rtPtr = HN_pushSuspOverLam(rtPtr);
        //(weak) head norm the top-level (imp) susp
        HN_setEnv(myol, mynl, myenvlist);
        /* note that AM_numabs, AM_numargs and AM_argvec have to be 
           re-initialized, because the (w)hnf of the inner suspension
           is to be traversed again. */
        HNL_initRegs();
        rtPtr = HN_hnormDispatchOcc(rtPtr, whnf);
    }
    return rtPtr;
}

/****************************************************************************/
/* Dispatching on various term categories.                                  */
/****************************************************************************/
static DF_TermPtr HN_hnormDispatchOcc(DF_TermPtr tmPtr, Boolean whnf)
{
  restart_hnormOcc:
    switch (DF_termTag(tmPtr)){
    case DF_TM_TAG_VAR: 
    {
        if (!HN_isEmptyEnv()) HN_setEmptyEnv();
        HNL_setRegsFlex(tmPtr);
        return tmPtr;
    }
    case DF_TM_TAG_CONST:
    case DF_TM_TAG_INT:
    case DF_TM_TAG_FLOAT:
    case DF_TM_TAG_NIL:
    case DF_TM_TAG_STR:
    case DF_TM_TAG_STREAM:
    {
        if (!HN_isEmptyEnv()) HN_setEmptyEnv();
        HNL_setRegsRig(tmPtr);
        return tmPtr;
    }
    case DF_TM_TAG_BVAR:     { return HN_hnormBVOcc(tmPtr, whnf);           }
    case DF_TM_TAG_CONS:     { return HN_hnormConsOcc(tmPtr, whnf);         }
    case DF_TM_TAG_LAM:      { return HN_hnormLamOcc(tmPtr, whnf);          }
    case DF_TM_TAG_APP:      {
        if (AM_vbbreg == tmPtr) EM_THROW(EM_FAIL);
        return HN_hnormAppOcc(tmPtr, whnf);          }
    case DF_TM_TAG_SUSP:     { return HN_hnormSuspOcc(tmPtr, whnf);         }
    case DF_TM_TAG_REF:      {tmPtr=DF_termDeref(tmPtr); goto restart_hnormOcc;}
    }

    //Impossible to reach this point.
    return NULL;
}

/****************************************************************************/  
/* the interface routine for head normalization                             */
/****************************************************************************/
void HN_hnormOcc(DF_TermPtr tmPtr)
{    
    HN_setEmptyEnv();            
    HNL_initRegs();
    tmPtr = HN_hnormDispatchOcc(DF_termDeref(tmPtr), FALSE);
}


/****************************************************************************/
/*               FULL NORMALIZATION                                         */
/****************************************************************************/
static DF_TermPtr HN_lnormDispatch(DF_TermPtr, Boolean whnf);

/****************************************************************************/
/* Functions for creating argument vectors in full normalization            */
/*--------------------------------------------------------------------------*/
/* General comments:                                                        */
/*  This is the counter part of HNL_makeArgvec functions (hnormlocal.c)     */
/*  in the full normalization process for arranging arguments of            */
/*  applications (cons) when their "heads" are in (head) normal forms.      */
/*  Nested applications are unfolded.                                       */
/*  The difference is that HN_lnormDispatch is invoked on each argument     */
/*  to fully normalize it.                                                  */
/****************************************************************************/

/* Fully normalize (implicit) suspensions [| ai, myol, mynl, myenv |],
   where ai's are those in the vector referred to by argvec with size arity,
   and myol, mynl, myenv are given by other parameters.
   Note that a new argument vector is always created.
*/
static void HN_lnormArgvec(DF_TermPtr argvec, int arity, int myol, int mynl, 
                           DF_EnvPtr myenv)
{
    int i;
    //book keeping relevant regs.  
    DF_TermPtr head      = AM_head,    myArgvec = AM_argVec;
    int        numAbs    = AM_numAbs,  numArgs  = AM_numArgs;
    Flag       rigFlag   = AM_rigFlag, consFlag = AM_consFlag;

    MemPtr     newArgvec = AM_hreg;   //new argvec
    MemPtr     newhtop   = newArgvec + arity * DF_TM_ATOMIC_SIZE;   
    AM_heapError(newhtop);
    AM_hreg = newhtop;       //arrange heap top for creating terms in norm args

    for (i = 1; i <= arity; i++){
        HN_setEnv(myol, mynl, myenv);   //imp susp environment
        HNL_initRegs();
        DF_mkRef(newArgvec, HN_lnormDispatch(argvec, FALSE));
        newArgvec += DF_TM_ATOMIC_SIZE;
        argvec = (DF_TermPtr)(((MemPtr)argvec)+DF_TM_ATOMIC_SIZE);
    }
    //reset registers
    AM_head    = head;             AM_argVec   = myArgvec;
    AM_numAbs  = numAbs;           AM_numArgs  = numArgs;
    AM_rigFlag = rigFlag;          AM_consFlag = consFlag;
}

/* A specialized version of HN_lnormArgvec when the implicit suspension
   over each argument in the vector is known to be empty.
   Note that upon the return of HN_lnormDispatch, the argument has been 
   destructively updated to its normal form, which means the old argument
   vector is always used.
*/
static void HN_lnormArgvecEmpEnv(DF_TermPtr argvec, int arity)
{
    int i;
    //book keeping relevant regs.  
    DF_TermPtr head      = AM_head,    myArgvec = AM_argVec;
    int        numAbs    = AM_numAbs,  numArgs  = AM_numArgs;
    Flag       rigFlag   = AM_rigFlag, consFlag = AM_consFlag;
    
    for (i = 1; i <= arity; i++){
        HNL_initRegs();
        HN_lnormDispatch(argvec, FALSE);
        argvec = (DF_TermPtr)(((MemPtr)argvec) + DF_TM_ATOMIC_SIZE);
    }
    //reset registers
    AM_head    = head;             AM_argVec   = myArgvec;
    AM_numAbs  = numAbs;           AM_numArgs  = numArgs;
    AM_rigFlag = rigFlag;          AM_consFlag = consFlag;
}    

/* Create an argument vector for applications within a non-empty environment.
   Actions are carried out in two steps:
   First, nested applications are unfolded if arising. Second, the (implicit)
   suspensions formed by each argument and given parameters are fully 
   normalized.
   Note that a new argument vector is always created.
*/
static Boolean HN_makeArgvecLnorm(DF_TermPtr argvec, int arity, int myol, 
                                  int mynl, DF_EnvPtr myenv)
{
    DF_TermPtr newArgvec = (DF_TermPtr)AM_hreg; //new argvec
    int        newArity;

    if (AM_numArgs != 0){      //unfold nested app first
        MemPtr newhtop  = AM_hreg + AM_numArgs * DF_TM_ATOMIC_SIZE;
        AM_heapError(newhtop);
        newArity = arity + AM_numArgs;
        AM_arityError(newArity);
        HNL_copyArgs(AM_argVec, AM_numArgs);  //layout inner args
    } else newArity = arity;
    
    //fully normalize arguments
    HN_lnormArgvec(argvec, arity, myol, mynl, myenv);
    AM_argVec = newArgvec;
    AM_numArgs = newArity;
    return TRUE;
}

/* A specilized version of HN_makeArgvecLnorm when the enclosing environment 
   is known to be empty. Note that new argument vecoter is created 
   if nested applications were unfolded. Otherwise, the old is used.
   Boolean values TRUE or FALSE is returned to inidicate which situation it is.
*/ 
static Boolean HN_makeArgvecEmpEnvLnorm(DF_TermPtr argvec, int arity)
{
    HN_lnormArgvecEmpEnv(argvec, arity);          //lnorm arguments

    if (AM_numArgs != 0){                           //unfold nested app 
        int        newArity  = arity + AM_numArgs;
        DF_TermPtr newArgvec = (DF_TermPtr)AM_hreg; //new argument vector
        AM_arityError(newArity);
        AM_heapError(((MemPtr)newArgvec + newArity * DF_TM_ATOMIC_SIZE));

        HNL_copyArgs(AM_argVec, AM_numArgs);
        HNL_copyArgs(argvec, arity);
        
        AM_argVec = newArgvec;
        AM_numArgs = newArity;
        return TRUE;
    } else {
        AM_argVec = argvec;
        AM_numArgs = arity;
        return FALSE;
    }
}

/****************************************************************************/
/* functions for fully normalizing terms of known categories                */
/*--------------------------------------------------------------------------*/
/* General comments:                                                        */
/*                                                                          */
/*  An implicit suspension is given by the global variables ol, nl and      */
/*  envlist together with the first argument tmPtr to the sub-functions:    */
/*  [|tmPtr, ol, nl, envlist|]                                              */
/*  The suspension environment could be empty in which case the term        */
/*  being normalized is tmPtr itself.                                       */
/*  The second argument of the sub-functions whnf is a flag indicating      */
/*  whether a head normal form or a weak head normal form is being          */
/*  computed.                                                               */ 
/****************************************************************************/

/* Fully normalize or weak head normalize bound variable or implicit 
   suspension with bound variable as term skeleton. 
   The actions carried out are the same as the counter part in the head 
   normalization proceee, except that HN_lnormDispatch is invoked as opposed
   to HN_hnormDispatch when necessary.
*/
static DF_TermPtr HN_lnormBV(DF_TermPtr bvPtr, Boolean whnf)
{
    DF_TermPtr rtPtr; //term pointer to be returned
    if (HN_isEmptyEnv()){                        //[|#i, 0, 0, nil|] -> #i
        rtPtr = bvPtr;
        HNL_setRegsRig(bvPtr);
    } else { //non-empty env       
        int dbind = DF_bvIndex(bvPtr);

        if (dbind > ol) {                        //[|#i,ol,nl,e|] -> #i-ol+nl
            int newind = dbind - ol + nl;

            AM_embedError(newind);
            rtPtr =(DF_TermPtr)AM_hreg;
            HNL_pushBV(newind); 
            HNL_setRegsRig(rtPtr);
            HN_setEmptyEnv();
        } else { // i <= ol
            DF_EnvPtr    envitem = DF_envListNth(envlist, dbind);
            int          nladj   = nl-DF_envIndex(envitem);

            if (DF_isDummyEnv(envitem)){         //[|#i,ol,nl,..@l..|]->#(nl-l)
                rtPtr = (DF_TermPtr)AM_hreg;
                HNL_pushBV(nladj); 
                HNL_setRegsRig(rtPtr);
                HN_setEmptyEnv();
            }  else { //pair env    [|#i,ol,nl,..(s,l)..|] -> [|s,0,(nl-l),nil|]
                DF_TermPtr tmPtr = DF_termDeref(DF_envPairTerm(envitem));
                if ((nladj != 0) && (DF_isSusp(tmPtr))) {//combine susp
                    int newnl = DF_suspNL(tmPtr)+nladj;
                    AM_embedError(newnl);
                    HN_setEnv(DF_suspOL(tmPtr), newnl, DF_suspEnv(tmPtr));
                    rtPtr = HN_lnormDispatch(DF_suspTermSkel(tmPtr), whnf);
                } else {      
                    HN_setEnv(0, nladj, DF_EMPTY_ENV); 
                    rtPtr = HN_lnormDispatch(tmPtr, whnf);
                }
            }         //pair env  
        }        // i<= ol    
    }        //non-empty env
    return rtPtr;
}

/* Fully normalize or weak head normalize abstractions or implicit suspension 
   with abstractions as term skeletons. 
   The actions carried out are the same as the counter part in the head 
   normalization process, except that HN_lnormDispatch is invoked as opposed
   to HN_hnormDispatch when necessary.
*/
static DF_TermPtr HN_lnormLam(DF_TermPtr lamPtr, Boolean whnf)
{
    DF_TermPtr rtPtr; //term pointer to be returned
    if (whnf) return rtPtr = lamPtr; //weak hn 
    else {  //whnf = FALSE
        int numabs = DF_lamNumAbs(lamPtr);
        DF_TermPtr newbody;

        if (HN_isEmptyEnv()){
            newbody = HN_lnormDispatch(DF_lamBody(lamPtr), FALSE);
            rtPtr = lamPtr; //body must have been adjusted in place
        } else {  // non-empty env 
            //[|lam(n,t),ol,nl,e|] ->lam(n,[|t,ol+n,nl+n,@nl+n-1...::@nl::e|]
            int newol = ol+numabs, newnl = nl+numabs;
            
            AM_embedError(newol);
            AM_embedError(newnl);
            HN_setEnv(newol, newnl, HN_addNDummyEnv(numabs));
            newbody = HN_lnormDispatch(DF_lamBody(lamPtr), FALSE);
            /* create a new lam on the result of hn the lam body */
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushLam(newbody, numabs);
        }         // non-empty env
        AM_numAbs += numabs;
    }      //whnf == FALSE
    return rtPtr;
}

/* Fully normalize or weak head normalize cons or implicit suspension over 
   cons. The difference from HN_hnormCons is that the arguments of the cons
   are fully normalized.          
*/
static DF_TermPtr HN_lnormCons(DF_TermPtr consPtr, Boolean whnf)
{
    DF_TermPtr argvec = DF_consArgs(consPtr),
               rtPtr; //term pointer to be returned
    if (HN_isEmptyEnv()){
        HN_lnormArgvecEmpEnv(argvec, DF_CONS_ARITY);
        AM_argVec = argvec;
        AM_numArgs = DF_CONS_ARITY;
        rtPtr = consPtr;
    } else {
        DF_TermPtr newArgvec = (DF_TermPtr)AM_hreg;  //new argument vector
        HN_lnormArgvec(argvec, DF_CONS_ARITY, ol, nl, envlist);
        AM_argVec = newArgvec;
        AM_numArgs = DF_CONS_ARITY;
        rtPtr = (DF_TermPtr)AM_hreg;
        HNL_pushCons(AM_argVec);
	HN_setEmptyEnv();
    }
    HNL_setRegsCons(rtPtr);
    return rtPtr;
}

/* Fully normalize or weak head normalize application or implicit suspension 
   over application. The actions carried out here is the same as those in
   HN_hnormApp except that HN_lnormDispatch is invoked as HN_hnormDispatch, and
   in making argument vectors makeArgvecLnorm functions are used to fully
   normalize the arguments.
*/
static DF_TermPtr HN_lnormApp(DF_TermPtr appPtr, Boolean whnf)
{
    DF_TermPtr funPtr = DF_appFunc(appPtr), argvec = DF_appArgs(appPtr),
               rtPtr; // term pointer to be returned
    DF_TermPtr oldFunPtr = funPtr;
    int        arity = DF_appArity(appPtr);
    Boolean    emptyTopEnv = HN_isEmptyEnv();
    int        myol, mynl;       //for book keeping the implicit suspension env
    DF_EnvPtr  myenvlist;        //for book keeping the implicit suspension env
    int        myarity = arity;  //book keeping the arity before contraction

    if (!emptyTopEnv) {          //book keeping the current environment
        myol = ol; mynl = nl; myenvlist = envlist; 
    }
    funPtr = HN_lnormDispatch(funPtr, TRUE); //whf of the function    
    while ((arity > 0) && (DF_isLam(funPtr))) {
        //perform contraction on top-level redexes while you can
        DF_TermPtr  lamBody = DF_lamBody(funPtr); //abs body
        int         numAbsInFun = DF_lamNumAbs(funPtr);   
        int         numContract = ((arity<=numAbsInFun) ? arity : numAbsInFun);
        DF_EnvPtr   newenv;
        int         newol = ol + numContract;        

        AM_embedError(newol);
        if (emptyTopEnv) newenv = HN_addNPairEmpEnv(argvec, numContract);
        else newenv = HN_addNPair(argvec, myol, mynl, myenvlist, numContract);
        HN_setEnv(newol, nl, newenv);

        if (arity == numAbsInFun){            
            funPtr = HN_lnormDispatch(lamBody, whnf);
            arity = 0;
        } else if (arity > numAbsInFun) {
            funPtr = HN_lnormDispatch(lamBody, TRUE);
            argvec=(DF_TermPtr)(((MemPtr)argvec)+numAbsInFun*DF_TM_ATOMIC_SIZE);
            arity -= numAbsInFun;
        } else {  //arity < numabsInFun
            DF_TermPtr newBody = (DF_TermPtr)AM_hreg;
            HNL_pushLam(lamBody, (numAbsInFun-arity));
            funPtr = HN_lnormDispatch(newBody, whnf);
            arity = 0;
        }
    }// while ((arity >0) && (DF_IsLam(fun)))
    
    //update or create application
    if (arity == 0) {  //app disappears
        rtPtr = funPtr;
        if (emptyTopEnv && HN_isEmptyEnv()) HNL_updateToRef(appPtr, funPtr);
    } else {           //app persists; Note: now HN_isEmptyEnv must be TRUE
        Boolean changed;
        if (emptyTopEnv) changed = HN_makeArgvecEmpEnvLnorm(argvec, arity);
        else changed = HN_makeArgvecLnorm(argvec,arity,myol,mynl,myenvlist);

        if ((!changed) && (arity == myarity) && (oldFunPtr == funPtr)) { 
	  rtPtr = appPtr;
        } else {// create new app and in place update the old if empty top env
            rtPtr = (DF_TermPtr)AM_hreg;
            HNL_pushApp(AM_head, AM_argVec, AM_numArgs);
            if (emptyTopEnv) HNL_updateToRef(appPtr, rtPtr);
        }
    }
    return rtPtr;
}

/* Fuuly normlize or weak head normalize (explicit) suspension or implicit 
   suspension with a suspension term skeletion. The actions are the same
   as those in HN_hnormSusp except that HN_lnormDispatch is used as opposed
   to HN_hnormSusp with one exception: when the environment of the top-level
   suspension is not empty, the inner suspension is head normalized
   (HN_hnormDispatch).
*/

static DF_TermPtr HN_lnormSusp(DF_TermPtr suspPtr, Boolean whnf)
{
    DF_TermPtr rtPtr; //term pointer to be returned
    int        myol, mynl; // for book keeping the env of implicit susp
    DF_EnvPtr  myenvlist;
    Boolean    emptyTopEnv = HN_isEmptyEnv();
    
    if (!emptyTopEnv) {
        myol = ol; mynl = nl; myenvlist = envlist;
    }
    HN_setEnv(DF_suspOL(suspPtr), DF_suspNL(suspPtr), DF_suspEnv(suspPtr));

    if (emptyTopEnv){
        rtPtr = HN_lnormDispatch(DF_suspTermSkel(suspPtr), whnf);
        if (HN_isEmptyEnv()) HNL_updateToRef(suspPtr, rtPtr);
    } else {          //non-empty top-level env
        rtPtr = HN_hnormDispatch(DF_suspTermSkel(suspPtr), whnf);
    
        if (HN_isEmptyEnv()) HNL_updateToRef(suspPtr, rtPtr);
        else rtPtr = HN_pushSuspOverLam(rtPtr);
        //fully normalize top-level susp
        HN_setEnv(myol, mynl, myenvlist);        
        /* note that AM_numabs, AM_numargs and AM_argvec have to be 
           re-initialized, because the (w)hnf of the inner suspension
           is to be traversed again. */
        HNL_initRegs();
        rtPtr = HN_lnormDispatch(rtPtr, whnf);
    }
    return rtPtr;
}

/****************************************************************************/
/* Dispatching on various term categories.                                  */
/****************************************************************************/
static DF_TermPtr HN_lnormDispatch(DF_TermPtr tmPtr, Boolean whnf)
{
  restart_lnorm:
    switch (DF_termTag(tmPtr)){
    case DF_TM_TAG_VAR: 
    {
        if (!HN_isEmptyEnv()) HN_setEmptyEnv();
        HNL_setRegsFlex(tmPtr);
        return tmPtr;
    }
    case DF_TM_TAG_CONST:
    case DF_TM_TAG_INT:
    case DF_TM_TAG_FLOAT:
    case DF_TM_TAG_NIL:
    case DF_TM_TAG_STR:
    case DF_TM_TAG_STREAM:
    {
        if (!HN_isEmptyEnv()) HN_setEmptyEnv();
        HNL_setRegsRig(tmPtr);
        return tmPtr;
    }
    case DF_TM_TAG_BVAR:     { return HN_lnormBV(tmPtr, whnf);           }
    case DF_TM_TAG_CONS:     { return HN_lnormCons(tmPtr, whnf);         }
    case DF_TM_TAG_LAM:      { return HN_lnormLam(tmPtr, whnf);          }
    case DF_TM_TAG_APP:      { return HN_lnormApp(tmPtr, whnf);          }
    case DF_TM_TAG_SUSP:     { return HN_lnormSusp(tmPtr, whnf);         }
    case DF_TM_TAG_REF:      { tmPtr = DF_termDeref(tmPtr); goto restart_lnorm;}
    }

    //Impossible to reach this point.
    return NULL;
}

/****************************************************************************/  
/* the interface routine for head normalization                             */
/****************************************************************************/
void HN_lnorm(DF_TermPtr tmPtr)
{    
    HN_setEmptyEnv();            
    HNL_initRegs();
    tmPtr = HN_lnormDispatch(DF_termDeref(tmPtr), FALSE);
}

#endif //HNORM_C











