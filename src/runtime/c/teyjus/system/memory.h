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
/*   Files memory.h{c}. These files define the system memory structures and */
/*   their access functions, including the system memory, run-time symbol   */
/*   tables, implication and import tables and the system module table.     */
/*                                                                          */
/****************************************************************************/

#ifndef MEMORY_H
#define MEMORY_H

#include <limits.h>
#include <math.h>
#include "../simulator/mctypes.h"        //to be changed
#include "../simulator/dataformats.h"    //to be changed
//#include "../config.h"

/******************************************************************************/
/*                FIND CODE FUNCTION                                          */
/******************************************************************************/
//arguments: constInd, search table size, search table addr
typedef CSpacePtr (*MEM_FindCodeFnPtr)(int, int, MemPtr);

/******************************************************************************/
/*                SYSTEM MEMORY MANAGEMENT                                    */
/******************************************************************************/
extern  WordPtr MEM_memBeg;       //starting addr of the system memory
extern  WordPtr MEM_memEnd;       //end addr of the system memory
extern  WordPtr MEM_memTop;       //the first usable word in the system memory
extern  WordPtr MEM_memBot;       //the last usable word in the system memory

/* Asking for the system memory of a given size (in word),                    */
/* and initialize relevant global variables.                                  */
void    MEM_memInit(unsigned int size);
/* Asking the simulator (system) memory for space of a given size (in word)  */
WordPtr MEM_memExtend(unsigned int size);

/******************************************************************************/
/*                MODULE SPACE COMPONENTS                                     */
/*----------------------------------------------------------------------------*/
/* I.  Run time symbol tables: kind table; type skeleton table; constant table*/
/* II. Implication table                                                      */
/* III.Import table                                                           */
/******************************************************************************/

/*****************************************************************************/
/*                          KIND SYMBOL TABLE                                */
/*****************************************************************************/
/*  kind symbol table entry                                                  */
typedef struct                                       
{
    DF_StrDataPtr name;
    TwoBytes      arity; //agree with DF_StrTypeArity (simulator/dataformats.c)
} MEM_KstEnt;

typedef MEM_KstEnt *MEM_KstPtr;

/*  max possible index of kind table                                        */
/*  (agree with DF_KstTabInd in simulator/dataformats.c)                    */ 
#define MEM_KST_MAX_IND        USHRT_MAX

/*  size of each entry of this table (in word)                              */
//Note this arithematic should in reality go into "config.h"
#define MEM_KST_ENTRY_SIZE     (int)ceil((double)sizeof(MEM_KstEnt)/WORD_SIZE)

/*****************************************************************************/
/*                         TYPE SKELETON TABLE                               */
/*****************************************************************************/
/* type skeleton table entry                                                 */
typedef DF_TypePtr MEM_TstEnt;

typedef MEM_TstEnt *MEM_TstPtr;

/*  max possible index of type skeleton table                                */
#define MEM_TST_MAX_IND        USHRT_MAX 

/*  size of each entry of this table (in word)                               */
//Note this arithematic should in reality go into "config.h"
#define MEM_TST_ENTRY_SIZE    (int)ceil((double)sizeof(MEM_TstEnt)/WORD_SIZE)

/*****************************************************************************/
/*                        CONSTANT SYMBOL TABLE                              */
/*****************************************************************************/
/*  constant symbol table entry                                              */ 
typedef struct
{
    DF_StrDataPtr name;
    TwoBytes      typeEnvSize;
    TwoBytes      tskTabIndex;     //index to the type skeleton table 
    TwoBytes      neededness;      //neededness info 
    TwoBytes      univCount;
    int           precedence;
    int           fixity;
} MEM_CstEnt;

typedef MEM_CstEnt *MEM_CstPtr;

/*  max possible index of constant symbol table                             */
/*  (agree with DF_CstTabInd in simulator/dataformats.c)                    */
#define MEM_CST_MAX_IND     USHRT_MAX
                                          //add one entry at the current top
/*  size of each entry of this table (in word)                               */
//Note this arithematic should in reality go into "config.h"
#define MEM_CST_ENTRY_SIZE    (int)(sizeof(MEM_CstEnt)/WORD_SIZE)

/*****************************************************************************/
/*               ACCESSING THE IMPLICATION GOAL TABLE                        */
/*****************************************************************************/
#define MEM_IMPL_FIX_SIZE    3
/* functions for filling in the fields of an impl table                      */
/* Q: the data stored in each field in byte code: are they word or in their  */
/*    specific types?                                                        */
void MEM_implPutLTS(WordPtr tab, int lts);               //# pred (def extended)
void MEM_implPutFC(WordPtr tab, MEM_FindCodeFnPtr fcPtr);//ptr to find code func
void MEM_implPutPSTS(WordPtr tab, int tabSize);          //# entries link tab
void MEM_implPutLT(WordPtr tab, int ind, int cst);       //link tab; ind from 0

/* functions for retrieving the addresses of associated tables               */
MemPtr MEM_implLT(MemPtr tab);           //start add of seq. of pred (link tab)
MemPtr MEM_implPST(MemPtr tab, int lts); //start add of pred search tab

/* functions for retrieving the fields of a impl table                       */
int MEM_implLTS(MemPtr tab);                 //pred field (def extended)
MEM_FindCodeFnPtr MEM_implFC(MemPtr tab);    //ptr to find code func
int MEM_implPSTS(MemPtr tab);                //num entries in link tab
int MEM_implIthLT(MemPtr ltab, int index);   /* value in ith entry of link tab 
                                                 ltab is the addr of link tab;
                                                 index should start from 0    */

/*****************************************************************************
 *                  ACCESSING THE IMPORTED MODULE TABLE                      *
 *****************************************************************************/
#define MEM_IMP_FIX_SIZE    5
/* functions for filling in the fields of an import table                   */
/* Q: the data stored in each field in byte code: are they word or in their  */
/*    specific types?                                                        */
void MEM_impPutNCSEG(WordPtr tab, int nseg);           //# code segments
void MEM_impPutNLC(WordPtr tab, int nlc);              //# local constants
void MEM_impPutLTS(WordPtr tab, int lts);              //# pred (def extended)
void MEM_impPutFC(WordPtr tab, MEM_FindCodeFnPtr fcp); //ptr to find code func
void MEM_impPutPSTS(WordPtr tab, int tabSize);         //# entries in link tab
void MEM_impPutLT(WordPtr tab, int ind, int cst);      //link tab; ind from 0
void MEM_impPutLCT(WordPtr lcTab, int ind, int cst);   /*loc c tab(may null)
                                                         lcTab addr of local 
                                                         ctab; ind from 0 */

/* functions for retrieving the addresses of associated tables               */
MemPtr MEM_impLT(MemPtr tab);           //start addr of seq. of pred (link tab)
MemPtr MEM_impLCT(MemPtr tab, int lts); //start addr of local const table
MemPtr MEM_impPST(MemPtr tab, int lts, int nlc); //start addr of pred search tab

/* functions for retrieving the fields of a impl table                       */
int MEM_impNCSEG(MemPtr tab);             //# code segments
int MEM_impNLC(MemPtr tab);               //# local constants
int MEM_impLTS(MemPtr tab);               //# of preds (def extended)
MEM_FindCodeFnPtr MEM_impFC(MemPtr tab);  //ptr to find code func
int MEM_impPSTS(MemPtr tab);              //# entries in link tab
int MEM_impIthLT(MemPtr lt, int ind);    /* ith entry in the link table: lt addr
                                            of link tab; ind start from 0 */
int MEM_impIthLCT(MemPtr lct, int ind);  /* ith entry in the local const table:
                                            lct local c tab; ind start from 0 */


/*****************************************************************************/
/*    ACCESSING THE BOUND VARIABLE INDEXING TABLE (BRACHING TABLE)           */
/*****************************************************************************/
int       MEM_branchTabIndexVal(MemPtr tab, int index); //the nth index value
CSpacePtr MEM_branchTabCodePtr(MemPtr tab, int index);  //transfer addr 

/*****************************************************************************/
/*                          SYSTEM MODULE TABLE                              */
/*****************************************************************************/
typedef struct
{
    char        *modname;        //(top-level) module name 
    CSpacePtr   addtable;        //addr to the add code table of the top module
    MEM_KstPtr  kstBase;         //starting addr of kind table
    MEM_TstPtr  tstBase;         //starting addr of type skel table
    MEM_CstPtr  cstBase;         //starting addr of constant table
    WordPtr     modSpaceBeg;     //starting addr of module space
    WordPtr     modSpaceEnd;     //ending addr of module space
	WordPtr     codeSpaceBeg;    //starting addr of module space
	WordPtr     codeSpaceEnd;    //ending addr of module space
} MEM_GmtEnt;

#define MEM_MAX_MODULES    255   //max number of modules (temp)

typedef MEM_GmtEnt MEM_Gmt[MEM_MAX_MODULES];

extern  MEM_Gmt    MEM_modTable; //global module table

MEM_GmtEnt *MEM_findInModTable(char* name);
MEM_GmtEnt *MEM_findFreeModTableEntry();
void MEM_removeModTableEntry(char* name);


extern MEM_GmtEnt  MEM_topModule; //top module 
void MEM_topModuleInit();

extern MEM_GmtEnt *MEM_currentModule; //current module being used


#endif  //MEMORY_H
