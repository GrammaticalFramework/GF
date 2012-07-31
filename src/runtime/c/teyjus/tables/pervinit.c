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
/* File pervinit.h{c}.                                                     */
/* Functions for setting up the symbol tables of pervasive constants and   */
/* kinds are provided.                                                     */
/***************************************************************************/
#include <string.h>
#include <stdio.h>

#include "pervinit.h"
#include "pervasives.h"
#include "../system/memory.h"
#include "../simulator/dataformats.h"
#include "../simulator/mcstring.h"
#include "../simulator/mctypes.h"

DF_StrDataPtr PERVINIT_writeName(char* name)
{
    int     length = strlen(name);
    MemPtr  rtPtr, mcStr;
    
    rtPtr = (MemPtr)MEM_memExtend(MCSTR_numWords(length) + 
                                  DF_STRDATA_HEAD_SIZE);
    mcStr = rtPtr + DF_STRDATA_HEAD_SIZE;
    
    //create data head
    DF_mkStrDataHead((MemPtr)rtPtr);
    //create the string data
    MCSTR_toString((MCSTR_Str)mcStr, name, length);    
    return (DF_StrDataPtr)rtPtr;
}

/***************************************************************************/
/*                   PERVASIVE KINDS                                       */
/***************************************************************************/
MEM_KstEnt PERVINIT_kindDataTab[PERV_KIND_NUM];

/* Set up pervasive kind symbol table.                                     */
/* The kind names are supposed to be written in the current top of system  */
/* memory.                                                                 */
static void PERVINIT_kindTabInit()
{
    int tabInd;
    for (tabInd = 0; tabInd < PERV_KIND_NUM; tabInd++) {
        if (PERV_kindDataTab[tabInd].name) 
            PERVINIT_kindDataTab[tabInd].name= 
                PERVINIT_writeName(PERV_kindDataTab[tabInd].name);
        else PERVINIT_kindDataTab[tabInd].name = NULL;

        PERVINIT_kindDataTab[tabInd].arity=PERV_kindDataTab[tabInd].arity;
    }
}

/* copy the pervasive kind table into given address                        */
void PERVINIT_copyKindDataTab(MEM_KstPtr dst)
{
    memcpy((void*)dst, (void*)PERVINIT_kindDataTab, 
           MEM_KST_ENTRY_SIZE * WORD_SIZE * PERV_KIND_NUM);    
}

/***************************************************************************/
/*                   PERVASIVE TYPE SKELETONS                              */
/***************************************************************************/
MEM_TstPtr PERVINIT_tySkelTab;

/* Set up pervasive type skeleton table.                                   */
static void PERVINIT_tySkelTabInit()
{
    PERVINIT_tySkelTab = PERV_tySkelTab;
    PERV_tySkelTabInit();
}

/* copy the pervasive type skeleton table into given address               */
void PERVINIT_copyTySkelTab(PERV_TySkelData* dst)
{                                                                              
    memcpy((void*)dst, (void*)PERVINIT_tySkelTab,
           MEM_TST_ENTRY_SIZE * WORD_SIZE * PERV_TY_SKEL_NUM);   
}

/***************************************************************************/
/*                   PERVASIVE CONSTANTS                                   */
/***************************************************************************/
MEM_CstEnt PERVINIT_constDataTab[PERV_CONST_NUM];

/* Set up pervasive constant symbol table.                                 */
/* The constant names are supposed to be written in the current top of     */
/* system memory.                                                          */
static void PERVINIT_constTabInit()
{
    int tabInd;
    
    for (tabInd = 0; tabInd < PERV_CONST_NUM; tabInd++) {
        if (PERV_constDataTab[tabInd].name)
            PERVINIT_constDataTab[tabInd].name =
                PERVINIT_writeName(PERV_constDataTab[tabInd].name);
        else PERVINIT_constDataTab[tabInd].name = NULL;
        
        PERVINIT_constDataTab[tabInd].typeEnvSize = 
            PERV_constDataTab[tabInd].typeEnvSize;
        PERVINIT_constDataTab[tabInd].tskTabIndex =
            PERV_constDataTab[tabInd].tskTabIndex;
        PERVINIT_constDataTab[tabInd].neededness = 
            PERV_constDataTab[tabInd].neededness;
        PERVINIT_constDataTab[tabInd].univCount = 
            PERV_constDataTab[tabInd].univCount;
        PERVINIT_constDataTab[tabInd].precedence = 
            PERV_constDataTab[tabInd].precedence;
        PERVINIT_constDataTab[tabInd].fixity = 
            PERV_constDataTab[tabInd].fixity;
    }   
}

/* copy the pervsive constant table into given address                     */
void PERVINIT_copyConstDataTab(MEM_CstPtr dst)
{
    memcpy((void*)dst, (void*)PERVINIT_constDataTab,   
           MEM_CST_ENTRY_SIZE * WORD_SIZE * PERV_CONST_NUM);
    
}

/***************************************************************************/
/*                PERVASIVE TABLES INITIALIZATION                          */
/* Fill in the actual pervasive tables; create string data needed for names*/
/* onto the current top of the system memory; create the type skeletons in */
/* a malloced space.                                                       */
/***************************************************************************/
void PERVINIT_tableInit()
{   
    PERVINIT_kindTabInit();
    PERVINIT_tySkelTabInit();
    PERVINIT_constTabInit();    
}

