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
/**************************************************************************/
/*                                                                        */
/*  File siminit.c.                                                       */
/**************************************************************************/
#ifndef SIMINIT_C
#define SIMINIT_C

#include "siminit.h"
#include "abstmachine.h"
#include "dataformats.h"
#include "io-datastructures.h"
#include "builtins/builtins.h"
#include "../tables/instructions.h"
#include "../system/error.h"
#include "../system/message.h"

#include <stdio.h>
/***************************######********************************************
 *                          ERROR INFORMATION
 *********************************######**************************************/
static MSG_Msg SIM_errorMessages[SIM_NUM_ERROR_MESSAGES] =
{
   { SIM_ERROR,
     0,
     "Simulator: ",
     0, 0, 0 },
   { SIM_ERROR_TOO_MANY_ABSTRACTIONS,
     SIM_ERROR,
     "Abstraction embedding depth has exceeded maximum of %d.",
     EM_NEWLINE, EM_TOP_LEVEL, 4 },
   { SIM_ERROR_TOO_MANY_ARGUMENTS,
     SIM_ERROR,
     "Application arguments has exceeded maximum of %d.",
     EM_NEWLINE, EM_TOP_LEVEL, 4 },
   { SIM_ERROR_TOO_MANY_UNIV_QUANTS,
     SIM_ERROR,
     "Too many universal quantifiers.",
     EM_NEWLINE, EM_TOP_LEVEL, 3 },
   { SIM_ERROR_HEAP_TOO_BIG,
     SIM_ERROR,
     "Specified heap size (%uK) is larger than maximum of 256Gb.",
     EM_NEWLINE, EM_ABORT, 1 },
   { SIM_ERROR_HEAP_TOO_SMALL,
     SIM_ERROR,
     "Specified heap size (%uK) is smaller than minimum of 10K.",
     EM_NEWLINE, EM_ABORT, 1 },
   { SIM_ERROR_CANNOT_ALLOCATE_HEAP,
     SIM_ERROR_CANNOT_ALLOCATE_HEAP_MESSAGE,
     "",
     SIM_ERROR_CANNOT_ALLOCATE_HEAP_SUGGESTION, EM_ABORT, 1 },
   { SIM_ERROR_CANNOT_ALLOCATE_HEAP_MESSAGE,
     SIM_ERROR,
     "Could not allocate heap of size %uK at 0x%08x using %s.",
     EM_NEWLINE, EM_NO_EXN, 1 },
   { SIM_ERROR_CANNOT_ALLOCATE_HEAP_SUGGESTION,
     SIM_ERROR,
     "Try modifying the configuration and recompiling.",
     EM_NEWLINE, EM_NO_EXN, 1 },
   { SIM_ERROR_TRAIL_OVERFL,
     SIM_ERROR,
     "Trail overflow.",
     EM_NEWLINE, EM_TOP_LEVEL, 1 },
   { SIM_ERROR_HEAP_OVERFL,
     SIM_ERROR,
     "Heap overflow.",
     EM_NEWLINE, EM_TOP_LEVEL, 1 },
   { SIM_ERROR_STACK_OVERFL,
     SIM_ERROR,
     "Stack overflow.",
     EM_NEWLINE, EM_TOP_LEVEL, 1 },
   { SIM_ERROR_PDL_OVERFL,
     SIM_ERROR,
     "PDL overflow.",
     EM_NEWLINE, EM_TOP_LEVEL, 1 }
};


/*************************************************************************/
/*            SETTING UP SPECIAL CODE SEGMENTS                           */
/*************************************************************************/
static const int SINIT_initSize = 31;

static void SINIT_initCode()
{
    MemPtr    nhreg  = AM_hreg + SINIT_initSize;
    CSpacePtr myhreg = (CSpacePtr)AM_hreg;
    
    AM_heapError(nhreg);
    
    //builtinCode
    AM_builtinCode = myhreg;
    *((INSTR_OpCode*)myhreg) = builtin;         //builtin ...
    myhreg += INSTR_I1X_LEN;
    
    //eqCode
    AM_eqCode = myhreg;
    *((INSTR_OpCode*)myhreg) = pattern_unify_t; //pattern_unify A1, A2
    *((INSTR_RegInd*)(myhreg + INSTR_RRX_R1)) = 1;
    *((INSTR_RegInd*)(myhreg + INSTR_RRX_R2)) = 2;
    myhreg += INSTR_RRX_LEN;
    *((INSTR_OpCode*)myhreg) = finish_unify;    //finish_unify
    myhreg += INSTR_X_LEN;
    *((INSTR_OpCode*)myhreg) = proceed;         //proceed
    myhreg += INSTR_X_LEN;
    
    //failCode
    AM_failCode = myhreg;
    *((INSTR_OpCode*)myhreg) = fail;            //fail
    myhreg += INSTR_X_LEN;
    
    //andCode
    *((INSTR_OneByteInt*)(myhreg + INSTR_I1LX_I1)) = 2;//"call" 2 L
    myhreg += INSTR_I1LX_LEN;
    AM_andCode = myhreg;
    *((INSTR_OpCode*)myhreg) = put_value_p;            //put_value Y1, A1
    *((INSTR_EnvInd*)(myhreg + INSTR_ERX_E)) = 1;
    *((INSTR_RegInd*)(myhreg + INSTR_ERX_R)) = 1;
    myhreg += INSTR_ERX_LEN;
    *((INSTR_OpCode*)myhreg) = put_level;              //put_level Y2
    *((INSTR_EnvInd*)(myhreg + INSTR_EX_E))  = 2;
    myhreg += INSTR_EX_LEN;
    *((INSTR_OpCode*)myhreg) = deallocate;             //deallocate
    myhreg += INSTR_X_LEN;
    
    //solveCode
    AM_solveCode = myhreg;
    *((INSTR_OpCode*)myhreg) = builtin;         //builtin BI_SOLVE
    *((INSTR_OneByteInt*)(myhreg + INSTR_I1X_I1)) = BI_SOLVE;
    myhreg += INSTR_I1X_LEN;
    
    //proceed
    AM_proceedCode = myhreg;                    //proceed
    *((INSTR_OpCode*)myhreg) = proceed;
    myhreg += INSTR_X_LEN;
    
    //orCode
    AM_orCode = myhreg;
    *((INSTR_OpCode*)myhreg) = trust_me;        //trust_me 1 
    *((INSTR_OneByteInt*)(myhreg + INSTR_I1WPX_I1)) = 1;
    myhreg += INSTR_I1WPX_LEN;
    *((INSTR_OpCode*)myhreg) = builtin;         //builtin BI_SOLVE
    *((INSTR_OneByteInt*)(myhreg + INSTR_I1X_I1)) = BI_SOLVE;
    myhreg += INSTR_I1X_LEN;
    
    //allcode
    *((INSTR_OneByteInt*)(myhreg + INSTR_I1LX_I1)) = 0; //"call" 0 L
    myhreg += INSTR_I1LX_LEN;
    AM_allCode = myhreg;
    *((INSTR_OpCode*)myhreg) = decr_universe;           //decr_universe
    myhreg += INSTR_X_LEN;
    *((INSTR_OpCode*)myhreg) = deallocate;              //deallocate
    myhreg += INSTR_X_LEN;
    *((INSTR_OpCode*)myhreg) = proceed;                 //proceed
    myhreg += INSTR_X_LEN;
    
    //stopCode
    AM_stopCode = myhreg;
    *((INSTR_OpCode*)myhreg) = stop;            //stop
    myhreg += INSTR_X_LEN;
    
    //notCode2   
    AM_notCode2 = myhreg;
    *((INSTR_OpCode*)myhreg) = trust_me;        //trust_me 0
    *((INSTR_OneByteInt*)(myhreg + INSTR_I1WPX_I1)) = 0;
    myhreg += INSTR_I1WPX_LEN;
    *((INSTR_OpCode*)myhreg) = proceed;         //proceed
    myhreg += INSTR_X_LEN;
    
    //notCode1
    AM_notCode1 = myhreg;
    *((INSTR_OpCode*)myhreg) = allocate;        //allocate 2
    *((INSTR_OneByteInt*)(myhreg + INSTR_I1X_I1)) = 2;
    myhreg += INSTR_I1X_LEN;
    *((INSTR_OpCode*)myhreg) = get_level;       //get_level Y1
    *((INSTR_EnvInd*)(myhreg + INSTR_EX_E)) = 1;
    myhreg += INSTR_EX_LEN;
    *((INSTR_OpCode*)myhreg) = call_builtin;    //call_builtin 1 BI_SOLVE
    *((INSTR_OneByteInt*)(myhreg + INSTR_I1I1WPX_I11)) = 1;
    *((INSTR_OneByteInt*)(myhreg + INSTR_I1I1WPX_I12)) = BI_SOLVE;
    myhreg += INSTR_I1I1WPX_LEN;
    *((INSTR_OpCode*)myhreg) = cut;             //cut 1
    *((INSTR_EnvInd*)(myhreg + INSTR_EX_E)) = 1;
    myhreg += INSTR_EX_LEN;
    *((INSTR_OpCode*)myhreg) = fail;            //fail
    myhreg += INSTR_X_LEN;
    
    //haltCode
    AM_haltCode = myhreg;
    *((INSTR_OpCode*)myhreg) = halt;            //halt
    myhreg += INSTR_X_LEN;
    
    AM_hreg = nhreg;
}

/*****************************************************************************
 *                          THE PUBLIC ROUTINES                              *
 *****************************************************************************/
void SINIT_preInit()
{
    /* errors get initialized before ANYTHING */
    MSG_addMessages(SIM_NUM_ERROR_MESSAGES, SIM_errorMessages);
}

void SINIT_simInit()
{
    AM_hreg  = AM_heapBeg;           //heap
    AM_hbreg = AM_heapBeg;
    AM_ereg  = AM_stackBeg;          //stack
    AM_ireg  = AM_stackBeg;
    AM_cireg = AM_stackBeg;
    AM_initPDL();                    //pdl 
    AM_trreg = AM_trailBeg;          //trail
    AM_llreg = DF_EMPTY_DIS_SET;     //live list
    AM_bndFlag = OFF;                //bind flag
    AM_ucreg = 0;                    //uc reg

    //make a dummy first mod point at the beginning of the stack
    AM_mkDummyImptRec(AM_ireg);

    /* perform initialization for the term io system */
    IO_initIO();

    /* and set up some built-in code */
    SINIT_initCode();

    /* set up the base branch register to put the heap back to this point */
    AM_breg = AM_stackBeg + AM_DUMMY_IMPT_REC_SIZE;
    *AM_breg = (Mem)AM_hreg;
    
    AM_fstCP = AM_b0reg = AM_breg;
    AM_tosreg = AM_breg + 1;
}

void SINIT_reInitSimState(Boolean inDoInitializeImports)
{   
    AM_initPDL();                 //pdl
    AM_ereg  = AM_stackBeg;       //stack
    AM_trreg = AM_trailBeg;       //trail
    AM_llreg = DF_EMPTY_DIS_SET;  //live list
    AM_ucreg = 0;                 //uc reg
    AM_bndFlag = OFF;             //bind flag
    AM_breg = AM_fstCP;
    AM_hreg = AM_cpH();
    AM_hreg = *((MemPtr *)AM_breg);
    
    /* initialize ireg if necessary */
    if (inDoInitializeImports) {
        AM_ireg = AM_stackBeg;
        AM_tosreg = AM_breg + 1;
    }

    IO_initIO();
}


#endif //SIMINIT_H
