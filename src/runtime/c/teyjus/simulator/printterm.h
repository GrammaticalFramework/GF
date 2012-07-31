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
 * File printterm.h{c}. This file contains routines for printing out lambda *
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

#ifndef  PRINTTERM_H
#define  PRINTTERM_H

#include "dataformats.h"
#include "mctypes.h"

/* set this variable to FALSE if variable names are to be displayed as
`numbers' */
extern Boolean PRINT_names;

void PRINT_fPrintTerm(WordPtr outStream, DF_TermPtr tmPtr);
void PRINT_showAnswerSubs();
void PRINT_showDisAgreeList();

void PRINT_resetFreeVarTab();
void PRINT_setQueryFreeVariables();
void PRINT_resetPrintState();
Boolean PRINT_queryHasVars();

//for debugging (display on stdout )
void PRINT_printTerm(DF_TermPtr tmPtr);
#endif   //PRINTTERM_H
