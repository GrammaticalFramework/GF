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
/***************************************************************************/
/*                                                                         */
/* File siminstrlocal.h. This file contains the declarations of auxiliary  */
/* functions used in siminstr.c.                                           */
/***************************************************************************/
#ifndef SIMINSTRL_H
#define SIMINSTRL_H

#include "dataformats.h"

/*****************************************************************************/
/* Auxiliary functions for unifying terms used in get- and unify- instrutions*/
/*****************************************************************************/

//attempting to unify a dereferenced term with a constant without type assoc
void SINSTRL_unifyConst(DF_TermPtr tmPtr, int constInd);

//attempting to unify a dereferenced term with an integer
void SINSTRL_unifyInt(DF_TermPtr tmPtr, int intValue);

//attempting to unify a dereferenced term with a real number
void SINSTRL_unifyFloat(DF_TermPtr tmPtr, float floatValue);

//attempting to unify a dereferenced term with a string
void SINSTRL_unifyString(DF_TermPtr tmPtr, DF_StrDataPtr str);

//attempting to unify a dereferenced term with a constant with type assoc
void SINSTRL_unifyTConst(DF_TermPtr tmPtr, int constInd, CSpacePtr label);

//attempting to unify a dereferenced term with a nil list
void SINSTRL_unifyNil(DF_TermPtr tmPtr);

//Bind a free variable to an application object with a non-type-associated
//constant head.
//Setting relevant registers for 1)entering WRITE mode 2)entering OCC mode
//   3)indicating the occurrence of binding (BND = ON).
void SINSTRL_bindStr(DF_TermPtr varPtr, int constInd, int arity);

//Bind a free variable to an application object with a type-associated
//constant head.
//Setting relevant registers for 1)entering WRITE and TYWRITE mode 2)entering 
//   OCC mode 3)indicating the occurrence of binding (BND = ON).
void SINSTRL_bindTStr(DF_TermPtr varPtr, int constInd, int arity);

//Bind a free variable to a list cons.
//Setting relevant registers for 1)entering WRITE mode 2)entering OCC mode
//   3)indicating the occurrence of binding (BND = ON).
void SINSTRL_bindCons(DF_TermPtr varPtr);

//Delay a pair (onto the PDL stack) with a given term and an application
//object with a non-type-associated constant head.
//Setting registers 1)entering WRITE mode: S and WRITE; 2)entering OCC OFF
//mode; 3) ADJ
void SINSTRL_delayStr(DF_TermPtr tPtr, int constInd, int arity);

//Delay a pair (onto the PDL stack) with a given term and an application
//object with a type-associated constant head.
//Setting registers 1)entering WRITE and TYWRITE mode: S, WRITE and TYWRITE; 
//  2)entering OCC OFF mode; 3) ADJ
void SINSTRL_delayTStr(DF_TermPtr tPtr, int constInd, int arity);

//Delay a pair (onto the PDL stack) with a given term and a list cons       
//Setting registers 1)entering WRITE mode: S and WRITE; 2)entering OCC OFF
//mode; 3) ADJ
void SINSTRL_delayCons(DF_TermPtr tPtr);


/*The main action of unify_value in write mode. This code carries out the    */
/*necessary occurs checking in the binding of a variable that has already    */
/*commenced through an enclosing get_structure instruction.                  */
/*Care has been taken to avoid making a reference to a register or stack     */
/*address.                                                                   */ 
void SINSTRL_bindSreg(DF_TermPtr tmPtr);

/*The main component of unify_local_value in write mode when it is determined */
/*that we are dealing with a heap cell.                                       */
void SINSTRL_bindSregH(DF_TermPtr tmPtr);


#endif //SIMINSTRL_H
