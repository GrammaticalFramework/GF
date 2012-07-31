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
#ifndef _SEARCHTAB_H_
#define _SEARCHTAB_H_

#include "../system/memory.h"

#define SEARCHTAB_FCF_SEQNSEARCH 0
#define SEARCHTAB_FCF_HASHSEARCH 1

extern WordPtr LD_SEARCHTAB_LoadHashTab(MEM_GmtEnt* ent, int* size);

extern WordPtr LD_SEARCHTAB_LoadSeqSTab(MEM_GmtEnt* ent, int* size);

/**
\brief Find code function for hash tables.
\return The address of the code corresponding to the given index.  Return address for values not in the table is undefined.
**/
extern CSpacePtr LD_SEARCHTAB_HashSrch(int constInd, int STabSize, MemPtr STabAddr);

/**
\brief Find code function for sequential search tables.
\return The address of the code corresponding to the given index.  Return address for values not in the table is undefined.
 **/
extern CSpacePtr LD_SEARCHTAB_SeqnSrch(int constInd, int STabSize, MemPtr STabAddr);

#endif //_SEARCHTAB_H_
