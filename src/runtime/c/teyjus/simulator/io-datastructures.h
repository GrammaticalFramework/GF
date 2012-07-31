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
 *  File io-datastructures.h.                                               *
 *                                                                          *
 ****************************************************************************/

#ifndef IODATASTRUCTURES_H
#define IODATASTRUCTURES_H

#include "mcstring.h"
#include "dataformats.h"
#include "mctypes.h"

/*****************************************************************************
 * A data structure for maintaining information about query term variables   *
 * and other free variables encountered in the course of displaying answers. *
 *****************************************************************************/
/* number of entries in the table for such variables. */
#define IO_MAX_FREE_VARS   500

/* Structure of each entry in the table; display name, and the rigid
   designator in the form of the memory cell corresponding to the variable are
   maintained. */
typedef struct 
{
    DF_StrDataPtr   varName;
    DF_TermPtr      rigdes;
} IO_FreeVarInfo;

/* The table itself */
extern IO_FreeVarInfo IO_freeVarTab[IO_MAX_FREE_VARS];

/* index for the topmost cell that has been used */
extern int IO_freeVarTabTop;

/* initialize */
void IO_initIO();

/* check if the free term variable table is full */
Boolean IO_freeVarTabFull(int incSize);

/* make an entry in the free term variable table */
void IO_enterFreeVarTab(DF_StrDataPtr name, DF_TermPtr varLoc);


#endif  //IODATASTRUCTURES_H
