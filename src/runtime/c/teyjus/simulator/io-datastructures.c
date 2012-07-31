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
 *  File io-datastructures.c.                                               *
 *                                                                          *
 ****************************************************************************/
#include "io-datastructures.h"

/* The io free term variable table */
IO_FreeVarInfo IO_freeVarTab[IO_MAX_FREE_VARS];

/* index for the topmost cell that has been used */
int IO_freeVarTabTop;

/* initialize */
void IO_initIO()
{
    IO_freeVarTabTop = 0;
}

/* check if the free term variable table is full */
Boolean IO_freeVarTabFull(int incSize)  
{
    return (IO_freeVarTabTop+incSize >= IO_MAX_FREE_VARS);
}

/* make an entry in the free term variable table */
void IO_enterFreeVarTab(DF_StrDataPtr name, DF_TermPtr varLoc)
{
    int i = IO_freeVarTabTop++;
    
    IO_freeVarTab[i].varName  = name;
    IO_freeVarTab[i].rigdes = varLoc;
}

