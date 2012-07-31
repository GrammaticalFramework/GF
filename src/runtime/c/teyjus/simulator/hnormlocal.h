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
/* File hnormlocal.h.                                                        */
/* This header file identifies functions that are used exclusively in the    */ 
/* (head) normalization routines. Thus, this file is imported only by        */
/* hnorm.c.                                                                  */
/*****************************************************************************/

#ifndef HNORMLOCAL_H
#define HNORMLOCAL_H

#include "dataformats.h"

/**********************************************************************/
/*      Register setting upon hnorm initiation or termination         */
/**********************************************************************/
void HNL_initRegs();                 // initialize relevant registers
void HNL_setRegsCons(DF_TermPtr);    // when a cons head is found
void HNL_setRegsRig(DF_TermPtr);     // when a (special) constant head is found 
void HNL_setRegsFlex(DF_TermPtr);    // when a unbound variable head is found

/************************************************************************/
/*  Term creation and destructive modification functions                */
/************************************************************************/
/* Push de Bruijn index #ind on the current heap top.                   */
void HNL_pushBV(int ind);
/* Push abstraction lam(n, body) on the current heap top.               */
void HNL_pushLam(DF_TermPtr body, int n);
/* Push cons on the current heap top.                                   */
void HNL_pushCons(DF_TermPtr argvecPtr);
/* Push an application on the current heap top.                         */
void HNL_pushApp(DF_TermPtr funcPtr, DF_TermPtr argvecPtr, int arity);  
/* Destructively change the cell referred to by tmPtr to a reference    
   The change is trailed if necessary.                                  */
void HNL_updateToRef(DF_TermPtr tmPtr, DF_TermPtr target);

/************************************************************************/
/*  Functions for eagerly evaluating implicit suspensions               */
/************************************************************************/
/* The suspension belongs to an environment list. */
DF_TermPtr HNL_suspAsEnv(DF_TermPtr skPtr, int ol, int nl, DF_EnvPtr env);

/************************************************************************/
/* Functions for creating application argument vectors                  */
/************************************************************************/
/* Copy an argument vector start from argvec onto the current top of heap.    */
void HNL_copyArgs(DF_TermPtr argvec, int arity);
/* Create an argument vector for applications inside an empty environment.    */
Boolean HNL_makeArgvecEmpEnv(DF_TermPtr argvec, int arity);
/* Create an argument vector for applications inside a non-empty environment. */
Boolean HNL_makeArgvec(DF_TermPtr argvec, int arity, int ol, int nl,
                       DF_EnvPtr  env);
/* A specialized version of HNL_makeArgvec for argument vectors on cons.      */
Boolean HNL_makeConsArgvec(DF_TermPtr argvec, int ol, int nl, DF_EnvPtr env);

#endif //HNORMLOCAL_H
