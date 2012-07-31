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
/*   File  abstmachine.c. This file defines the various registers,          */
/*   data areas and record types and their operations  relevant to the      */
/*   abstract machine.                                                      */
/*                                                                          */
/****************************************************************************/
#ifndef ABSTMACHINE_C
#define ABSTMACHINE_C

#include   "mctypes.h"
#include   "mcstring.h"
#include   "dataformats.h"
#include   "abstmachine.h"
#include   "instraccess.h"
#include   "../system/error.h"   
#include   "../system/memory.h"  

/****************************************************************************/
/*                ABSTRACT MACHINE REGISTERS (AND FLAGS)                    */
/****************************************************************************/
AM_DataType  AM_regs[AM_NUM_OF_REG];//argument regs/temp variable
//data register access: return the address of the ith register
AM_DataTypePtr AM_reg(int i)        {  return (AM_regs + i);                 }

MemPtr       AM_hreg;                //heap top
MemPtr       AM_hbreg;               //heap backtrack point
MemPtr       AM_ereg;                //current environment
MemPtr       AM_breg;                //last choice point
MemPtr       AM_b0reg;               //cut point
MemPtr       AM_ireg;                //impl pt reg, defining prog context
MemPtr       AM_cireg;               //impl pt for current clause 
MemPtr       AM_cereg;               //closure environment  
MemPtr       AM_tosreg;              //top of stack impl or choice pt.
MemPtr       AM_trreg;               //trail top
MemPtr       AM_pdlTop;              //top of pdl
MemPtr       AM_pdlBot;              //(moving) bottom of pdl
MemPtr       AM_typespdlBot;         //(moving) bottom of types pdl

DF_TermPtr   AM_sreg;                //"structure" pointer 
DF_TypePtr   AM_tysreg;              //type structure pointer

CSpacePtr    AM_preg;                //program pointer
CSpacePtr    AM_cpreg;               //continuation pointer

Flag         AM_bndFlag;             //does binding of free var (term)  occur?
Flag         AM_writeFlag;           //in write mode?
Flag         AM_tyWriteFlag;         //in ty write mode? 
Flag         AM_ocFlag;              //occurs check?

Flag         AM_consFlag;            //cons?
Flag         AM_rigFlag;             //rigid?

//The size of AM_numAbs is decided by that of relevant fields in term
//representations which can be found in dataformats.c
TwoBytes     AM_numAbs;              //number of abstractions in hnf
//The size of AM_numArgs is decided by that of relevant fields in term
//representations which can be found in dataformats.c
TwoBytes     AM_numArgs;             //number of arguments in hnf

DF_TermPtr   AM_head;                //head of a hnf
DF_TermPtr   AM_argVec;              //argument vector of a hnf 

DF_TermPtr   AM_vbbreg;              //variable being bound for occ
DF_TypePtr   AM_tyvbbreg;            //type var being bound for occ

//The size of AM_adjreg is decided by that of relevant fields in term
//representations which can be found in dataformats.c
TwoBytes     AM_adjreg;              //univ count of variable being bound
TwoBytes     AM_ucreg;               //universe count register

DF_DisPairPtr AM_llreg;              //ptr to the live list

/****************************************************************************/
/*               STACK, HEAP, TRAIL AND PDL RELATED STUFF                   */
/****************************************************************************/

MemPtr     AM_heapBeg,                //beginning of the heap
           AM_heapEnd,                //end of the heap
           AM_stackBeg,               //beginning of the trail
           AM_stackEnd,               //end of the trail
           AM_trailBeg,               //beginning of the trail
           AM_trailEnd,               //end of the trail
           AM_pdlBeg,                 //beginning of pdl
           AM_pdlEnd,                 //end of pdl
           AM_fstCP;                  //the first choice point

/****************************************************************************/
/*            CODE PLACED IN THE HEAP BY THE SYSTEM                         */
/****************************************************************************/
CSpacePtr  AM_failCode;
CSpacePtr  AM_andCode;
CSpacePtr  AM_orCode;
CSpacePtr  AM_allCode;
CSpacePtr  AM_solveCode;
CSpacePtr  AM_builtinCode;
CSpacePtr  AM_eqCode;
CSpacePtr  AM_stopCode;
CSpacePtr  AM_haltCode;
CSpacePtr  AM_notCode1;
CSpacePtr  AM_notCode2;
CSpacePtr  AM_proceedCode;


Boolean    AM_isFailInstr(CSpacePtr cptr)    { return (cptr == AM_failCode); }
/****************************************************************************/
/*               VITUAL MACHINE MEMORY OPERATIONS                           */
/****************************************************************************/
//is the given addr referring to a register?
Boolean AM_regAddr(MemPtr p)
{
  //TODO:
  //  AM_reg lacked conversion to MemPtr; why is a function getting
  //  converted in this way?
  return ((((MemPtr)AM_reg) <= p) && (p < (MemPtr)((MemPtr)AM_reg + AM_NUM_OF_REG)));
}
//is the given addr on stack?
Boolean AM_stackAddr(MemPtr p)    { return (p > AM_hreg);                      }
//is the given addr not on heap?
Boolean AM_nHeapAddr(MemPtr p)    { return ((p > AM_hreg) || (AM_heapBeg > p));}

 //is the "first" impl/impt record?
Boolean AM_botIP(MemPtr p)        { return (p == AM_stackBeg);                 }
//is the "first" choice point"?
Boolean AM_botCP()                { return (AM_breg == AM_fstCP);              }
//no env record left on the stack?
Boolean AM_noEnv()                { return (AM_ereg == AM_stackBeg);           }


MemPtr  AM_findtos(int i)
{
    return ((AM_tosreg > AM_ereg) ? AM_tosreg :
            (MemPtr)(((AM_DataTypePtr)(AM_ereg + 2)) + i));
} 
MemPtr AM_findtosEnv()
{
    return ((AM_tosreg > AM_ereg) ? AM_tosreg :
            (MemPtr)(((AM_DataTypePtr)(AM_ereg + 2))+INSACC_CALL_I1(AM_cpreg)));
    
}
//set AM_tosreg to the top imp or choice pt
void    AM_settosreg()       
{
    if (AM_ireg > AM_breg) AM_tosreg = AM_ireg + AM_IMP_FIX_SIZE;
    else AM_tosreg = AM_breg + 1;
}


/***************************************************************************/
/*               ENVIRONMENT RECORD OPERATIONS                             */
/***************************************************************************/
//environment record creation function
MemPtr AM_mkEnv(MemPtr ep)                 //create the fixed part of env rec
{
    *((MemPtr *)(ep - 3)) = AM_cireg;             //CI field  
    *((MemPtr *)(ep - 2)) = AM_ereg;              //CE field
    *((int *)(ep - 1))    = AM_ucreg;             //UC field
    *((CSpacePtr *)ep)    = AM_cpreg;             //CP field 
    return (ep - 1);
}
MemPtr AM_mkEnvWOUC(MemPtr ep)              //ct fixed part of env without uc
{
    *((MemPtr *)(ep - 3)) = AM_cireg;             //CI field
    *((MemPtr *)(ep - 2)) = AM_ereg;              //CE field
    *((CSpacePtr *)ep)    = AM_cpreg;             //CP field
    return (ep - 1);
}

//environment record access functions (current top-level env record)
//the env continuation point 
CSpacePtr AM_envCP()              { return *((CSpacePtr *)(AM_ereg + 1));}    
//the uc value 
int       AM_envUC()              { return *((int *)AM_ereg);            }
//continuation point
MemPtr    AM_envCE()              { return *((MemPtr *)(AM_ereg - 1));   }
//impl point
MemPtr    AM_envCI(MemPtr ep)     { return *((MemPtr *)(AM_ereg - 2));   }
//the nth var fd 
AM_DataTypePtr AM_envVar(int n)        
{
    return (AM_DataTypePtr)(((AM_DataTypePtr)AM_ereg) + n);
}
//is p an address in the current env?
Boolean   AM_inCurEnv(MemPtr p)   { return (p > AM_ereg);                }

//access functions for clause environment
AM_DataTypePtr AM_cenvVar(int n)          //the nth var fd in clause env
{
    return (AM_DataTypePtr)(((AM_DataTypePtr)AM_cereg) + n);
}
    
/****************************************************************************/
/*                       CHOICE POINT OPERATIONS                            */
/****************************************************************************/
//choice point creation functions
void AM_mkCP(MemPtr cp, CSpacePtr label, int n)  //create a choice pt
{
    *((MemPtr *)cp)              = AM_hreg;           //heap point
    *((CSpacePtr *)(cp - 1))     = label;             //next clause ptr 
    *((MemPtr *)(cp - 2))        = AM_trreg;          //trail point
    *((DF_DisPairPtr *)(cp - 3)) = AM_llreg;          //live list 
    *((MemPtr *)(cp - 4))        = AM_b0reg;          //cut point
    *((MemPtr *)(cp - 5))        = AM_breg;           //previous choice pt
    *((MemPtr *)(cp - 6))        = AM_cireg;          //clause context
    *((MemPtr *)(cp - 7))        = AM_ireg;           //program context
    *((CSpacePtr *)(cp - 8))     = AM_cpreg;          //cont. code ptr
    *((MemPtr *)(cp - 9))        = AM_ereg;           //cont. env ptr
    *((TwoBytes *)(cp - 10))     = AM_ucreg;          //universe count

    for (; n > 0; n--)                                //save reg(1) to reg(n)
        *(((AM_DataTypePtr)(cp - 10)) - n) = *AM_reg(n);
}
void AM_saveStateCP(MemPtr cp, CSpacePtr label)
{
    *((MemPtr *)cp)              = AM_hreg;           //heap point
    *((CSpacePtr *)(cp - 1))     = label;             //next clause ptr 
    *((MemPtr *)(cp - 2))        = AM_trreg;          //trail point
    *((DF_DisPairPtr *)(cp - 3)) = AM_llreg;          //live list 
    *((MemPtr *)(cp - 4))        = AM_b0reg;          //cut point
    *((MemPtr *)(cp - 5))        = AM_breg;           //previous choice pt
    *((MemPtr *)(cp - 6))        = AM_cireg;          //clause context
    *((MemPtr *)(cp - 7))        = AM_ireg;           //program context
    *((CSpacePtr *)(cp - 8))     = AM_cpreg;          //cont. code ptr
    *((MemPtr *)(cp - 9))        = AM_ereg;           //cont. env ptr
    *((TwoBytes *)(cp - 10))     = AM_ucreg;          //universe count
}
//set the next clause field in the current top choice point
void AM_setNClCP(CSpacePtr ncl)
{
    *((CSpacePtr *)(AM_breg - 1)) = ncl;
}


//restore function
//restore all components of a choice point except the trail top and the 
//backtrack point registers 
void AM_restoreRegs(int n)          
{
    for (; n > 0; n--) 
        AM_regs[n] = *(((AM_DataTypePtr)(AM_breg - 10)) - n);

    AM_hreg    = *((MemPtr *)AM_breg);
    AM_llreg   = *((DF_DisPairPtr *)(AM_breg - 3));
    AM_b0reg   = *((MemPtr *)(AM_breg - 4));
    AM_cireg   = *((MemPtr *)(AM_breg - 6));
    AM_ireg    = *((MemPtr *)(AM_breg - 7));
    AM_cpreg   = *((CSpacePtr *)(AM_breg - 8));
    AM_ereg    = *((MemPtr *)(AM_breg - 9));
    AM_ucreg   = *((TwoBytes *)(AM_breg - 10));
}
//restore all components of a choice point except the trail top, the backtrack 
//point and the clause context registers
void AM_restoreRegsWoCI(int n)
{
    for (; n > 0; n--)
        AM_regs[n] = *(((AM_DataTypePtr)(AM_breg - 10)) - n);

    AM_hreg    = *((MemPtr *)AM_breg);
    AM_llreg   = *((DF_DisPairPtr *)(AM_breg - 3));
    AM_b0reg   = *((MemPtr *)(AM_breg - 4));
    AM_ireg    = *((MemPtr *)(AM_breg - 7));
    AM_cpreg   = *((CSpacePtr *)(AM_breg - 8));
    AM_ereg    = *((MemPtr *)(AM_breg - 9));
    AM_ucreg   = *((TwoBytes *)(AM_breg - 10));
}

//access functions
MemPtr    AM_cpH()   { return *((MemPtr *)(AM_breg));        }
CSpacePtr AM_cpNCL() { return *((CSpacePtr *)(AM_breg - 1)); }
MemPtr    AM_cpTR()  { return *((MemPtr *)(AM_breg - 2));    } 
MemPtr    AM_cpB()   { return *((MemPtr *)(AM_breg - 5));    }
MemPtr    AM_cpCI()  { return *((MemPtr *)(AM_breg - 6));    }

AM_DataTypePtr AM_cpArg(MemPtr cp, int n) //addr of nth arg in a given cp
{
    return ((AM_DataTypePtr)(cp - 10)) - n;
}

/***************************************************************************/
/*                IMPLICATION/IMPORT RECORD OPERATIONS                     */
/***************************************************************************/
/* The tags for distinguishing implication and import records */
typedef enum 
{
    AM_IMPTAG_IMPLICATION,                 //implication record
    AM_IMPTAG_IMPTWOLOCAL,                 //import record without locals
    AM_IMPTAG_IMPTWLOCAL                   //import record with locals
} AM_ImpTag;

//finding code for a predicate in the program context given by the value of
//the AM_ireg. 
void AM_findCode(int constInd, CSpacePtr *clPtr, MemPtr *iptr)
{
    CSpacePtr myclPtr = NULL;
    MemPtr    myiptr  = AM_ireg;
    int       size;    
    while (!AM_botIP(myiptr)) {
        if ((size = AM_impPSTS(myiptr)) && 
            (myclPtr = (*(AM_impFC(myiptr)))(constInd,size,AM_impPST(myiptr))))
            break;
        else myiptr = AM_impPIP(myiptr); 
    }
    *clPtr = myclPtr;
    *iptr  = myiptr;
}
//creating the fixed part of a new implication/import record
void AM_mkImplRec(MemPtr ip, MemPtr sTab, int sTabSize, MEM_FindCodeFnPtr fnPtr)
{
    *((MemPtr *)ip)      = AM_ereg;                    //CE: clause env 
    *(ip+1)              = (Mem)AM_IMPTAG_IMPLICATION; //tag 
    *((MemPtr *)(ip+2))  = sTab;                       //PST: search table addr
    *((MEM_FindCodeFnPtr *)(ip+3))  = fnPtr;           //FC: find code fn ptr 
    *((MemPtr *)(ip+4))  = AM_ireg;                    //PIP: previous ip addr 
    *((int *)(ip+5))     = sTabSize;                   //PSTS: search table size
}

//creating the fixed part of a new import record with local consts
void AM_mkImptRecWL(MemPtr ip, int npreds, MemPtr sTab, int sTabSize, 
                    MEM_FindCodeFnPtr fnPtr)
{
    *((int *)ip)         = npreds;                    //NPred: # preds 
    *(ip+1)              = (Mem)AM_IMPTAG_IMPTWLOCAL; //tag 
    *((MemPtr *)(ip+2))  = sTab;                      //PST: search table addr
    *((MEM_FindCodeFnPtr *)(ip+3)) = fnPtr;           //FC: find code fn ptr
    *((MemPtr *)(ip+4))  = AM_ireg;                   //PIP: previous ip addr
    *((int *)(ip+5))     = sTabSize;                  //PSTS: search table size
}
//creating the fixed part of a new import record without local consts
void AM_mkImptRecWOL(MemPtr ip, int npreds, MemPtr sTab, int sTabSize, 
                     MEM_FindCodeFnPtr fnPtr)
{
    *((int *)ip)         = npreds;                    //NPred: # preds 
    *(ip+1)              = (Mem)AM_IMPTAG_IMPTWOLOCAL;//tag 
    *((MemPtr *)(ip+2))  = sTab;                      //PST: search table addr
    *((MEM_FindCodeFnPtr *)(ip+3)) = fnPtr;           //FC: find code fn ptr
    *((MemPtr *)(ip+4))  = AM_ireg;                   //PIP: previous ip addr
    *((int *)(ip+5))     = sTabSize;                  //PSTS: search table size
}

//creating a dummy import point 
void AM_mkDummyImptRec(MemPtr ip)
{
    *((int *)ip) = 0;
    *(ip+1)      = (Mem)AM_IMPTAG_IMPTWOLOCAL;
}


/*initializing the next clause table in an implication/import record.*/
void AM_mkImpNCLTab(MemPtr ip, MemPtr linkTab, int size)
{
    int       constInd;
    CSpacePtr clausePtr;
    MemPtr    iptr;
    MemPtr    nextCl = AM_impNCL(ip, size);//the first entry in the NCL table
    size--;
    for (; size >= 0; size--) {
        constInd = MEM_implIthLT(linkTab, size);
        AM_findCode(constInd, &clausePtr, &iptr);
        if (clausePtr) { //if found
            *((CSpacePtr *)nextCl) = clausePtr; 
            *((MemPtr *)(nextCl+1))= iptr;
        } else {         //not found
            *((CSpacePtr *)nextCl) = AM_failCode;
            *((MemPtr *)(nextCl+1))= NULL;
        }
        nextCl += AM_NCLT_ENTRY_SIZE;
    } //for loop
}
//initializing the backchained vector in an import record
void AM_initBCKVector(MemPtr ip, int nclTabSize, int nSegs)
{
    MemPtr bcVecPtr = ip - nclTabSize - (AM_BCKV_ENTRY_SIZE * nSegs);
    for (; (nSegs > 0); nSegs--){
        *((int *)bcVecPtr)        = 0;     
        *((MemPtr *)(bcVecPtr+1)) = AM_breg;
        bcVecPtr += AM_BCKV_ENTRY_SIZE;
    }
}
//set back chained number in a given back chained field
void AM_setBCKNo(MemPtr bck, int n)          {  *((int *)bck) = n;             }
//set most recent cp in a given back chained field
void AM_setBCKMRCP(MemPtr bck, MemPtr mrcp)  {  *((MemPtr *)(bck+1)) = mrcp;   }
//initializing the universe indices in the symbol table entries for constants
//local to a module
void AM_initLocs(int nlocs, MemPtr locTab)
{
    nlocs--;
    for (; nlocs >= 0; nlocs--) 
        AM_setCstUnivCount(MEM_impIthLCT(locTab, nlocs), AM_ucreg);
}

//implication/import record access functions
//the ith entry of next clause tab 
MemPtr    AM_impNCL(MemPtr ip, int i) {return (ip - AM_NCLT_ENTRY_SIZE * i);}
//code in a next clause field
CSpacePtr AM_impNCLCode(MemPtr ncl)   {return *((CSpacePtr *)ncl);          } 
//ip in a next clause field      
MemPtr    AM_impNCLIP(MemPtr ncl)     {return *((MemPtr *)(ncl+1));         }
//the ith entry of back chained vec
MemPtr    AM_cimpBCK(int i)  
{ return (AM_cireg-AM_NCLT_ENTRY_SIZE*AM_cimpNPreds()-AM_BCKV_ENTRY_SIZE*i);  }
//back chain num in a bck field 
int       AM_impBCKNo(MemPtr bck)     {return *((int *)bck);                }
//most recent cp is a bck field               
MemPtr    AM_impBCKMRCP(MemPtr bck)   {return *((MemPtr *)(bck+1));         }
//clause env of in imp rec referred to by cireg
MemPtr    AM_cimpCE()                 {return *((MemPtr *)AM_cireg);        }
//# preds of impt rec
int       AM_cimpNPreds()             {return *((int *)AM_cireg);           }
 //search table addr 
MemPtr    AM_impPST(MemPtr ip)        {return *((MemPtr *)(ip + 2));        }
//find code function pointer
MEM_FindCodeFnPtr AM_impFC(MemPtr ip) {return *((MEM_FindCodeFnPtr *)(ip + 3));}
//PIP in given imp point
MemPtr    AM_impPIP(MemPtr ip)        {return *((MemPtr *)(ip + 4));         }
//previous ip in the current top imp point
MemPtr    AM_curimpPIP()              {return *((MemPtr *)(AM_ireg + 4));    }
//search table size
int       AM_impPSTS(MemPtr ip)       {return *((int *)(ip + 5));            }


Boolean AM_isImptWL(MemPtr ip) {           //is an imp rec a import rec w local
    return ((AM_ImpTag)(*(ip+1)) == AM_IMPTAG_IMPTWLOCAL); 
}
Boolean AM_isImptWOL(MemPtr ip){           //is an imp rec a import rec wo local
    return ((AM_ImpTag)(*(ip+1)) == AM_IMPTAG_IMPTWOLOCAL);
}   
Boolean AM_isImpl(MemPtr ip){              //is an imp rec a implication rec
    return ((AM_ImpTag)(*(ip+1)) == AM_IMPTAG_IMPLICATION);
}
Boolean AM_isImpt(MemPtr ip){              //is an imp rec a import rec 
    return ((AM_ImpTag)(*(ip+1)) != AM_IMPTAG_IMPLICATION);
}

Boolean AM_isImplCI(){                     //is rec referred to by CI impl?
    return ((AM_ImpTag)(*(AM_cireg+1)) == AM_IMPTAG_IMPLICATION);
}
Boolean AM_isCurImptWL(){              //is rec referred to by I impt with loc?
    return ((AM_ImpTag)(*(AM_ireg+1)) == AM_IMPTAG_IMPTWLOCAL); 
}  

/***************************************************************************/
/*                     LIVE LIST OPERATIONS                                */
/***************************************************************************/
//live list is empty?
Boolean AM_empLiveList() { return (AM_llreg == DF_EMPTY_DIS_SET);}

//live list not empty?
Boolean AM_nempLiveList(){ return (AM_llreg != DF_EMPTY_DIS_SET);}

//add a dis pair to the live list when not knowning it is empty or not
void    AM_addDisPair(DF_TermPtr tPtr1, DF_TermPtr tPtr2)
{
    MemPtr nhtop = AM_hreg + DF_DISPAIR_SIZE;
    AM_heapError(nhtop);
    DF_mkDisPair(AM_hreg, AM_llreg, tPtr1, tPtr2);
    AM_llreg = (DF_DisPairPtr)AM_hreg;
    AM_hreg = nhtop;
}

/***************************************************************************/
/*                        PDL OPERATIONS                                   */
/***************************************************************************/
//pop (term/type) PDL
MemPtr  AM_popPDL()              { return (MemPtr)(*(--AM_pdlTop));      }
//push (term/type) PDL
void    AM_pushPDL(MemPtr addr)  { (*AM_pdlTop++) = (Mem)addr;           }
//is empty PDL?
Boolean AM_emptyPDL()            { return (AM_pdlTop == AM_pdlBot);      }
//is not empty PDL?
Boolean AM_nemptyPDL()           { return (AM_pdlTop > AM_pdlBot);       }
//initialize PDL
void    AM_initPDL()             { AM_pdlTop = AM_pdlBot = AM_pdlBeg;    }
//is empty type PDL?
Boolean AM_emptyTypesPDL()       { return (AM_pdlTop == AM_typespdlBot); }
//is not empty type PDL?
Boolean AM_nemptyTypesPDL()      { return (AM_pdlTop > AM_typespdlBot);  }
//initialize type PDL
void    AM_initTypesPDL()        { AM_typespdlBot = AM_pdlTop;           }
//recover type PDL to the status before type unification 
void    AM_resetTypesPDL()       { AM_pdlTop = AM_typespdlBot;           }


/****************************************************************************/
/*                   RUN-TIME SYMBOL TABLES                                 */
/****************************************************************************/
MEM_KstPtr   AM_kstBase;     //starting addr of the kind symbol table
MEM_TstPtr   AM_tstBase;     //starting addr of the type skel table
MEM_CstPtr   AM_cstBase;     //starting addr of the const symbol table

/* Kind symbol table                                                        */
char* AM_kstName(int n)        //name of a type constructor in a given entry
{
    return MCSTR_toCString(
        DF_strDataValue(((MEM_KstPtr)(((MemPtr)AM_kstBase)
                                      + n*MEM_KST_ENTRY_SIZE)) -> name));
}

int   AM_kstArity(int n)       //arity of a type constructor in a given entry
{
    return ((MEM_KstPtr)(((MemPtr)AM_kstBase) + n*MEM_KST_ENTRY_SIZE)) -> arity;
}

/* Type skeleton table                                                      */
DF_TypePtr AM_tstSkel(int n)   //type skeleton in a given entry
{
    return (DF_TypePtr)(((MemPtr)AM_tstBase) + n*MEM_TST_ENTRY_SIZE);
}

/* Constant symbol table                                                    */
char* AM_cstName(int n)        //name of a constant in a given entry
{
  DF_StrDataPtr nameData = ((MEM_CstPtr)(((MemPtr)AM_cstBase) +
					 n * MEM_CST_ENTRY_SIZE)) -> name;
  if (nameData) return MCSTR_toCString(DF_strDataValue(nameData));
  else return NULL;
  //return MCSTR_toCString(
  //    DF_strDataValue(((MEM_CstPtr)(((MemPtr)AM_cstBase) +
  //                                    n*MEM_CST_ENTRY_SIZE)) -> name));
}

int   AM_cstTyEnvSize(int n)   //type environment size 
{
    return ((MEM_CstPtr)(((MemPtr)AM_cstBase)+n*MEM_CST_ENTRY_SIZE))->
        typeEnvSize;
}
int   AM_cstNeeded(int n)      //neededness info
{
    return ((MEM_CstPtr)(((MemPtr)AM_cstBase)+n*MEM_CST_ENTRY_SIZE))->
        neededness;
    
}
int   AM_cstUnivCount(int n)   //universe count 
{
    return ((MEM_CstPtr)(((MemPtr)AM_cstBase)+n*MEM_CST_ENTRY_SIZE))->univCount;
}
int   AM_cstPrecedence(int n)  //precedence
{
    return ((MEM_CstPtr)(((MemPtr)AM_cstBase)+n*MEM_CST_ENTRY_SIZE))->
        precedence;
}
int   AM_cstFixity(int n)      //fixity
{
    return ((MEM_CstPtr)(((MemPtr)AM_cstBase)+n*MEM_CST_ENTRY_SIZE))->fixity;
}
int   AM_cstTySkelInd(int n)   //type skeleton index
{
    return ((MEM_CstPtr)(((MemPtr)AM_cstBase)+n*MEM_CST_ENTRY_SIZE))->
        tskTabIndex;
}

void AM_setCstUnivCount(int n, int uc)    //set universe count
{
    ((MEM_CstPtr)(((MemPtr)AM_cstBase)+n*MEM_CST_ENTRY_SIZE))->univCount = uc;
}

/****************************************************************************
 *                         OVERFLOW ERROR FUNCTIONS                         *
 ****************************************************************************/
void AM_heapError(MemPtr p)                 //heap overflow
{
    if (AM_heapEnd < p) EM_error(SIM_ERROR_HEAP_OVERFL);
}
void AM_stackError(MemPtr p)               //stack overflow
{
    if (AM_stackEnd < p) EM_error(SIM_ERROR_STACK_OVERFL);
}
void AM_pdlError(int n)                    //pdl overflow for n cells
{
    if (AM_pdlEnd < (AM_pdlTop + n)) EM_error(SIM_ERROR_PDL_OVERFL);
}
void AM_trailError(int n)                  //trail overflow for n cells
{
    if (AM_trailEnd < (AM_trreg + n))
        EM_error(SIM_ERROR_TRAIL_OVERFL);
}

  
/****************************************************************************
 *                     MISCELLANEOUS OTHER ERRORS                           *
 ****************************************************************************/
void AM_embedError(int n)     //violation of max number of lambda embeddings 
{
    if (n > DF_MAX_BV_IND)
        EM_error(SIM_ERROR_TOO_MANY_ABSTRACTIONS, DF_MAX_BV_IND);
}
void AM_arityError(int n)    // violation of max number of arity in applications
{
    if (n > DF_TM_MAX_ARITY) EM_error(SIM_ERROR_TOO_MANY_ARGUMENTS, 
                                      DF_TM_MAX_ARITY);
}
void AM_ucError(int n)      //violation of maximum of universe count
{
    if (n == DF_MAX_UNIVIND) EM_error(SIM_ERROR_TOO_MANY_UNIV_QUANTS);
}

#endif //ABSTMACHINE_C
