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
/*   File  abstmachine.h. This header file defines the various registers,   */
/*   data areas and record types relevant to the abstract machine.          */
/*                                                                          */
/****************************************************************************/
#ifndef ABSTMACHINE_H
#define ABSTMACHINE_H

#include  <stdlib.h>
#include  <math.h>
#include  "mctypes.h"
#include  "dataformats.h"
#include  "../system/memory.h"
#include  "../system/error.h"

/***************************######********************************************
 *                          ERROR INFORMATION
 *********************************######**************************************/

#define SIM_NUM_ERROR_MESSAGES 13
enum
{
   SIM_ERROR = SIM_FIRST_ERR_INDEX,
   SIM_ERROR_TOO_MANY_ABSTRACTIONS,
   SIM_ERROR_TOO_MANY_ARGUMENTS,
   SIM_ERROR_TOO_MANY_UNIV_QUANTS,
   SIM_ERROR_HEAP_TOO_BIG,
   SIM_ERROR_HEAP_TOO_SMALL,
   SIM_ERROR_CANNOT_ALLOCATE_HEAP,
   SIM_ERROR_CANNOT_ALLOCATE_HEAP_MESSAGE,
   SIM_ERROR_CANNOT_ALLOCATE_HEAP_SUGGESTION,
   SIM_ERROR_TRAIL_OVERFL,
   SIM_ERROR_HEAP_OVERFL,
   SIM_ERROR_STACK_OVERFL,
   SIM_ERROR_PDL_OVERFL,
};

typedef union  //the type of data: (atomic) term or type 
{
    DF_Term term;
    DF_Type type;
} AM_DataType;

typedef AM_DataType *AM_DataTypePtr;

//#define AM_DATA_SIZE (int)ceil((double)sizeof(AM_DataType)/WORD_SIZE)
#define AM_DATA_SIZE  2

/****************************************************************************/
/*                ABSTRACT MACHINE REGISTERS (AND FLAGS)                    */
/****************************************************************************/

typedef enum {OFF = 0, ON = 1}     AM_FlagTypes;     //FLAG type
typedef Byte                       Flag;


/*There are 255 argument registers numbered 1 through 255; Reg_0 is never
  used. (agree with instruction format)*/
#define AM_NUM_OF_REG 256      
extern AM_DataType  AM_regs[AM_NUM_OF_REG];//argument regs/temp variables

//data register access: return the address of the ith register
AM_DataTypePtr      AM_reg(int i);               

extern MemPtr       AM_hreg;                //heap top
extern MemPtr       AM_hbreg;               //heap backtrack point
extern MemPtr       AM_ereg;                //current environment
extern MemPtr       AM_breg;                //last choice point
extern MemPtr       AM_b0reg;               //cut point
extern MemPtr       AM_ireg;                //impl pt reg, defining prog context
extern MemPtr       AM_cireg;               //impl pt for current clause   
extern MemPtr       AM_cereg;               //closure environment
extern MemPtr       AM_tosreg;              //top of stack impl or choice pt.
extern MemPtr       AM_trreg;               //trail top
extern MemPtr       AM_pdlTop;              //top of pdl
extern MemPtr       AM_pdlBot;              //(moving) bottom of pdl
extern MemPtr       AM_typespdlBot;         //(moving) bottom of types pdl

extern DF_TermPtr   AM_sreg;                //"structure" pointer
extern DF_TypePtr   AM_tysreg;              //type structure pointer

extern CSpacePtr    AM_preg;                //program pointer
extern CSpacePtr    AM_cpreg;               //continuation pointer

extern DF_DisPairPtr AM_llreg;              //ptr to the live list

extern Flag         AM_bndFlag;             //does binding on fv (term) occur?
extern Flag         AM_writeFlag;           //in write mode?
extern Flag         AM_tyWriteFlag;         //in ty write mode? 
extern Flag         AM_ocFlag;              //occurs check? 

extern Flag         AM_consFlag;            //cons? 
extern Flag         AM_rigFlag;             //rigid?

extern TwoBytes     AM_numAbs;              //number of abstractions in hnf
extern TwoBytes     AM_numArgs;             //number of arguments in hnf

extern DF_TermPtr   AM_head;                //head of a hnf 
extern DF_TermPtr   AM_argVec;              //argument vector of a hnf 

extern DF_TermPtr   AM_vbbreg;              //variable being bound for occ
extern DF_TypePtr   AM_tyvbbreg;            //type var being bound for occ
extern TwoBytes     AM_adjreg;              //univ count of variable being bound

extern TwoBytes     AM_ucreg;               //universe count register

/****************************************************************************/
/*               STACK, HEAP, TRAIL AND PDL RELATED STUFF                   */
/****************************************************************************/
extern MemPtr    AM_heapBeg,                //beginning of the heap
                 AM_heapEnd,                //end of the heap
                 AM_stackBeg,               //beginning of the stack
                 AM_stackEnd,               //end of the stack 
                 AM_trailBeg,               //beginning of the trail
                 AM_trailEnd,               //end of the trail
                 AM_pdlBeg,                 //beginning of pdl
                 AM_pdlEnd,                 //end of pdl
                 AM_fstCP;                  //the first choice point


/****************************************************************************/
/*            CODE PLACED IN THE HEAP BY THE SYSTEM                         */
/****************************************************************************/
extern CSpacePtr  AM_failCode;
extern CSpacePtr  AM_andCode;
extern CSpacePtr  AM_orCode;
extern CSpacePtr  AM_allCode;
extern CSpacePtr  AM_solveCode;
extern CSpacePtr  AM_builtinCode;
extern CSpacePtr  AM_eqCode;
extern CSpacePtr  AM_stopCode;
extern CSpacePtr  AM_haltCode;
extern CSpacePtr  AM_notCode1;
extern CSpacePtr  AM_notCode2;
extern CSpacePtr  AM_proceedCode;


Boolean AM_isFailInstr(CSpacePtr cptr);
/****************************************************************************/
/*               VITUAL MACHINE MEMORY OPERATIONS                           */
/****************************************************************************/
Boolean AM_regAddr(MemPtr p);      //is the given addr referring to a register?
Boolean AM_stackAddr(MemPtr p);    //is the given addr on stack?
Boolean AM_nHeapAddr(MemPtr p);    //is the given addr on heap?

Boolean AM_botIP(MemPtr p);        //is the "first" impl/impt record?
Boolean AM_botCP();                //is the "first" choice point?
Boolean AM_noEnv();                //no env record left on the stack?

MemPtr  AM_findtos(int i);
MemPtr  AM_findtosEnv();
void    AM_settosreg();            //set AM_tosreg to the top imp or choice pt

/***************************************************************************/
/*               ENVIRONMENT RECORD OPERATIONS                             */
/***************************************************************************/
#define   AM_ENV_FIX_SIZE   4                //size of the fix part of env rec

//environment record creation function
MemPtr AM_mkEnv(MemPtr ep);                  //create the fixed part of env rec
MemPtr AM_mkEnvWOUC(MemPtr ep);              //ct fixed part of env without uc

//environment record access functions (current top env record)
AM_DataTypePtr AM_envVar(int n);             //the nth var fd
int            AM_envUC();                   //the env universe count 
CSpacePtr      AM_envCP();                   //the env continuation point
MemPtr         AM_envCE();                   //continuation point 
MemPtr         AM_envCI();                   //impl point 
Boolean        AM_inCurEnv(MemPtr p);        //is p an addr in the curr env?

//access functions for clause environment
AM_DataTypePtr AM_cenvVar(int n);            //the nth var fd in clause env

/****************************************************************************/
/*                       CHOICE POINT OPERATIONS                            */
/****************************************************************************/
#define AM_CP_FIX_SIZE      11           //size of the fix part of choice point

//choice point creation functions
void AM_mkCP(MemPtr cp, CSpacePtr label, int n); //create a choice pt
void AM_saveStateCP(MemPtr cp, CSpacePtr label);   
void AM_setNClCP(CSpacePtr ncl);                 //set the ncl fd in top ch pt

//restore functions 
//restore all components of a choice point except the trail top and the 
//backtrack point registers 
void AM_restoreRegs(int n);           
//restore all components of a choice point except the trail top, the backtrack 
//point and the clause context registers
void AM_restoreRegsWoCI(int n);
//access functions
MemPtr    AM_cpH();
CSpacePtr AM_cpNCL();
MemPtr    AM_cpTR();
MemPtr    AM_cpB();
MemPtr    AM_cpCI();

AM_DataTypePtr AM_cpArg(MemPtr cp, int n); //addr of nth arg in a given cp

/***************************************************************************/
/*                IMPLICATION/IMPORT RECORD OPERATIONS                     */
/***************************************************************************/
#define AM_IMP_FIX_SIZE         6         //size of the fix part of impl/impt rec
#define AM_DUMMY_IMPT_REC_SIZE  2         //size of a dummy impt rec
#define AM_NCLT_ENTRY_SIZE      2         //size of each entry in next clause tab
#define AM_BCKV_ENTRY_SIZE      2         //size of ent. in back chained vector


//finding code for a predicate in the program context given by the value of
//the AM_ireg. 
void AM_findCode(int constInd, CSpacePtr *clPtr, MemPtr *iptr);

//creating the fixed part of a new implication record
void AM_mkImplRec(MemPtr ip,MemPtr sTab,int sTabSize, MEM_FindCodeFnPtr fnPtr);
//creating the fixed part of a new import record with local consts
void AM_mkImptRecWL(MemPtr ip, int npreds, MemPtr sTab, int sTabSize, 
                    MEM_FindCodeFnPtr fnPtr);
//creating the fixed part of a new import record without local consts
void AM_mkImptRecWOL(MemPtr ip, int npreds, MemPtr sTab, int sTabSize, 
                     MEM_FindCodeFnPtr fnPtr);
//creating a dummy import point 
void AM_mkDummyImptRec(MemPtr ip);

//initializing the next clause table in an implication/import record.
void AM_mkImpNCLTab(MemPtr ip, MemPtr linkTab, int size);
//initializing the backchained vector in an import record
void AM_initBCKVector(MemPtr ip, int nclTabSize, int noSegs);
//set back chained number in a given back chained field
void AM_setBCKNo(MemPtr bck, int n);
//set most recent cp in a given back chained field
void AM_setBCKMRCP(MemPtr bck, MemPtr cp);
//initializing the universe indices in the symbol table entries for constants
//local to a module
void AM_initLocs(int nlocs, MemPtr locTab);

//implication/import record access functions
MemPtr    AM_impNCL(MemPtr ip, int i); //the ith entry of next clause tab
CSpacePtr AM_impNCLCode(MemPtr ncl);   //code in a next clause field
MemPtr    AM_impNCLIP(MemPtr ncl);     //ip in a next clause field
MemPtr    AM_cimpBCK(int i);           //the ith entry of back chained vec in CI
int       AM_impBCKNo(MemPtr bck);     //back chain num in a bck field
MemPtr    AM_impBCKMRCP(MemPtr bck);   //most recent cp is a bck field   
MemPtr    AM_cimpCE();                 //clause env of impl rec in CI
int       AM_cimpNPreds();             //# preds of impt rec in CI
MemPtr    AM_impPST(MemPtr ip);        //search table field addr 
MEM_FindCodeFnPtr AM_impFC(MemPtr ip); //find code function field addr
MemPtr    AM_impPIP(MemPtr ip);        //PIP in given imp point
MemPtr    AM_curimpPIP();              //PIP in the current top imp point
int       AM_impPSTS(MemPtr ip);       //search table size field

Boolean AM_isImptWL(MemPtr ip);        //is an imp rec a import rec w local
Boolean AM_isImptWOL(MemPtr ip);       //is an imp rec a import rec wo local
Boolean AM_isImpl(MemPtr ip);          //is an imp rec a implication rec
Boolean AM_isImpt(MemPtr ip);          //is an imp rec a import rec 

Boolean AM_isImplCI();                 //is rec referred to by CI impl?
Boolean AM_isCurImptWL();              //is rec referred to by I impt with loc?


/***************************************************************************/
/*                     LIVE LIST OPERATIONS                                */
/***************************************************************************/
Boolean AM_empLiveList();                   //live list is empty?
Boolean AM_nempLiveList();                  //live list not empty?

//add a dpair to the beginning of live list
void    AM_addDisPair(DF_TermPtr tPtr1, DF_TermPtr tPtr2);

/***************************************************************************/
/*                        PDL OPERATIONS                                   */
/***************************************************************************/ 
MemPtr   AM_popPDL();                       //pop (term/type) PDL
void     AM_pushPDL(MemPtr);                //push (term/type) PDL

Boolean  AM_emptyPDL();                     //is empty PDL?
Boolean  AM_nemptyPDL();                    //is not empty PDL?
void     AM_initPDL();                      //initialize PDL

Boolean  AM_emptyTypesPDL();                //is empty type PDL?
Boolean  AM_nemptyTypesPDL();               //is not empty type PDL?
void     AM_initTypesPDL();                 //initialize type PDL
void     AM_resetTypesPDL();                //reset PDL to that before ty unif

/****************************************************************************/
/*                   RUN-TIME SYMBOL TABLES                                 */
/****************************************************************************/
extern  MEM_KstPtr   AM_kstBase;     //starting addr of the kind symbol table
extern  MEM_TstPtr   AM_tstBase;     //starting addr of the type skel table
extern  MEM_CstPtr   AM_cstBase;     //starting addr of the const symbol table

/* Kind symbol table                                                        */
char* AM_kstName(int n);        //name of a type constructor in a given entry
int   AM_kstArity(int n);       //arity of a type constructor in a given entry

/* Type skeleton table                                                      */
DF_TypePtr AM_tstSkel(int n);   //type skeleton in a given entry

/* Constant symbol table                                                    */
char* AM_cstName(int n);        //name of a constant in a given entry
int   AM_cstTyEnvSize(int n);   //type environment size 
int   AM_cstNeeded(int n);      //neededness info
int   AM_cstUnivCount(int n);   //universe count 
int   AM_cstPrecedence(int n);  //precedence
int   AM_cstFixity(int n);      //fixity
int   AM_cstTySkelInd(int n);   //type skeleton index

void  AM_setCstUnivCount(int n, int uc);    //set universe count
/****************************************************************************
 *                         OVERFLOW ERROR FUNCTIONS                         *
 ****************************************************************************/
void AM_heapError(MemPtr);                  //heap overflow
void AM_stackError(MemPtr);                 //stack overflow
void AM_pdlError(int);                      //pdl stack overflow for n cells
void AM_trailError(int);                    //trail overflow for n cells


/****************************************************************************
 *                     MISCELLANEOUS OTHER ERRORS                           *
 ****************************************************************************/
void AM_embedError(int);    // violation of max number of lambda embeddings
void AM_arityError(int);    // violation of max number of arity in applications
void AM_ucError(int);       // violation of maximum of universe count


#endif //ABSTMACHINE_H
