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
/*   File trail.c. This file defines the trail operations including         */
/*   trailing and unwinding.                                                */
/*                                                                          */
/****************************************************************************/

#ifndef TRAIL_C
#define TRAIL_C

#include "trail.h"

static int TR_trailItemTag(TR_TrailItem *trPtr)     { return (trPtr -> tag); }
static MemPtr TR_trailItemAddr(TR_TrailItem *trPtr) { return (trPtr -> addr);}

/***************************************************************************/
/*       TRAILING FUNCTIONS                                                */
/***************************************************************************/
void TR_trailTerm(DF_TermPtr addr)         //trailing a term of atomic size
{
    if (((MemPtr)addr <= AM_hbreg) ||
        (AM_hreg < (MemPtr)addr) && ((MemPtr)addr < AM_breg)) {
        AM_trailError(TR_TRAIL_TERM_SIZE);
        DF_copyAtomic(addr, AM_trreg);
        ((TR_TrailItem*)(AM_trreg+DF_TM_ATOMIC_SIZE))->tag = TR_TAG_TERM;
        ((TR_TrailItem*)(AM_trreg+DF_TM_ATOMIC_SIZE))->addr = (MemPtr)addr;
        AM_trreg += TR_TRAIL_TERM_SIZE;
    }
}

void TR_trailHTerm(DF_TermPtr addr)       //trailing a heap term of atomic size 
{
    if ((MemPtr)addr < AM_hbreg) {
        AM_trailError(TR_TRAIL_TERM_SIZE);
        DF_copyAtomic(addr, AM_trreg);
        ((TR_TrailItem*)(AM_trreg+DF_TM_ATOMIC_SIZE)) -> tag = TR_TAG_TERM;
        ((TR_TrailItem*)(AM_trreg+DF_TM_ATOMIC_SIZE)) -> addr = (MemPtr)addr;
        AM_trreg += TR_TRAIL_TERM_SIZE;
    }
}

void TR_trailETerm(DF_TermPtr addr)      //trailing a stack term 
{
    if ((MemPtr)addr < AM_breg) {
        AM_trailError(TR_TRAIL_TERM_SIZE);
        DF_copyAtomic(addr, AM_trreg);
        ((TR_TrailItem*)(AM_trreg+DF_TM_ATOMIC_SIZE)) -> tag = TR_TAG_TERM;
        ((TR_TrailItem*)(AM_trreg+DF_TM_ATOMIC_SIZE)) -> addr = (MemPtr)addr;
        AM_trreg += TR_TRAIL_TERM_SIZE;
    }
}

    
void TR_trailType(DF_TypePtr addr)       //trailing a type (free variable)
{
    if (((MemPtr)addr < AM_hbreg) || 
        ((AM_hreg < (MemPtr)addr) && ((MemPtr)addr < AM_breg))){
        AM_trailError(TR_TRAIL_TYPE_SIZE);
        ((TR_TrailItem*)AM_trreg) -> tag = TR_TAG_TYPE;
        ((TR_TrailItem*)AM_trreg) -> addr = (MemPtr)addr;
        AM_trreg += TR_TRAIL_TYPE_SIZE;
    }
}

//temp
void TR_trailImport(MemPtr addr)        //trailing a backchained field
{
    AM_trailError(TR_TRAIL_MOD_SIZE);
    *AM_trreg = *addr;
    *(AM_trreg+1) = *(addr+1);
    ((TR_TrailItem*)(AM_trreg+2)) -> tag = TR_TAG_MOD;
    ((TR_TrailItem*)(AM_trreg+2)) -> addr = addr;
    AM_trreg += TR_TRAIL_MOD_SIZE;
}

/****************************************************************************/
/*       UNWIND TRAIL FUNCTION                                              */
/****************************************************************************/
void TR_unwindTrail(MemPtr trOld)
{
    MemPtr addr;
    
    while (AM_trreg > trOld){
        AM_trreg -= TR_TRAIL_ITEM_HEAD_SIZE;
        addr = TR_trailItemAddr((TR_TrailItem*)AM_trreg);
        switch (TR_trailItemTag((TR_TrailItem*)AM_trreg)){
        case TR_TAG_TERM: 
        {
            AM_trreg -= DF_TM_ATOMIC_SIZE;
            DF_copyAtomic((DF_TermPtr)AM_trreg, addr);
            break;
        }
        case TR_TAG_MULTERM1:
        {
            AM_trreg -= DF_TM_APP_SIZE;
            DF_copyApp((DF_TermPtr)AM_trreg, addr);
            break;
        }
        case TR_TAG_MULTERM2:
        {
            AM_trreg -= DF_TM_SUSP_SIZE;
            DF_copySusp((DF_TermPtr)AM_trreg, addr);
            break;
        }
        case TR_TAG_TYPE:
        {
            DF_mkFreeVarType(addr);
            break;
        }
        case TR_TAG_MOD: //temp
        {
            AM_trreg -= 2;
            *addr = *AM_trreg;
            *(addr+1) = *(AM_trreg + 1);
            break;
        }
        } //switch
    } //while
}    


#endif  //TRAIL_C
