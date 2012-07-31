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
/*  File hopu.h. This header file defines the interface components for the  */
/*  code in hopu.c that implements higher-order pattern unification.        */
/*                                                                          */
/****************************************************************************/
#ifndef HOPU_H
#define HOPU_H

#include "mctypes.h"
#include "dataformats.h"

/* A flag denoting whether new structure is created during the process of  */
/* finding substitutions.                                                  */
extern Boolean HOPU_copyFlagGlb;

/* Return the dereference of the abstraction body of the given term.       */
DF_TermPtr HOPU_lamBody(DF_TermPtr tPtr);

/* Globalize a rigid term and make a variable binding.                     */
/* If the term pointer to the rigid term is not one referring to a heap    */
/* address, its atomic content is then copied into the variable to be bound*/
/* Otherwise, the variable is made a reference to the rigid term.          */
void       HOPU_globalizeCopyRigid(DF_TermPtr rPtr, DF_TermPtr vPtr);


/* Globalize a flex term.                                                   */
/* If the term pointer is one referring to a stack address, (in which case  */
/* the flex term must be a free variable itself), the atomic content is     */
/* copied onto the current top of heap; the free variable on stack is then  */
/* bound to the new heap term, and the binding is trailed if necessary; the */
/* term pointer is updated to the new heap term.                            */ 
DF_TermPtr HOPU_globalizeFlex(DF_TermPtr fPtr);

/* Try to find the (partial) structure of the substitution for a flex head  */
/* of a LLambda term corresponding to an internal flex term which is not    */
/* known to be LLambda in the compiled form of pattern unification.         */
DF_TermPtr HOPU_flexNestedSubstC(DF_TermPtr fhPtr, DF_TermPtr args, int nargs,
                                 DF_TermPtr tmPtr, int emblev);

/* Try to find the (partial) binding of the head of a flex term when        */
/* unifying it with a rigid term possible under abstractions in the compiled*/
/* form of pattern unification.                                             */
DF_TermPtr HOPU_rigNestedSubstC(DF_TermPtr rhPtr, DF_TermPtr rPtr, 
                                DF_TermPtr args, int rnargs, int emblev);


/* Interpretively pattern unify first the pairs delayed on the PDL, then    */
/* those delayed on the live list, if binding occured during the first step */
/* or previous compiled unification process.                                */
/* Upon successful termination, PDL should be empty and pairs left on the   */
/* live list should be those other than LLambda.                            */
void HOPU_patternUnify();

/* Interpretively pattern unify a pair of terms given as parameters. This is*/
/* the counter part of HOPU_patterUnifyPDL that is invoked from the compiled*/
/* part of unification. In this situation, the procedure has to be applied  */
/* to two terms as opposed to pairs delayed on the PDL stack.               */
/*                                                                          */
/* The input term pointers may dereference to register and stack addresses  */
/* Care must be taken to avoid making a reference to a register (stack)     */
/* address in binding a variable, and in making a disagreement pair.        */
void HOPU_patternUnifyPair(DF_TermPtr tPtr1, DF_TermPtr tPtr2);


#endif //HOPU_H

