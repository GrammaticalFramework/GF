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
/*                                                                         */
/* File siminstrlocal.c. This file contains the definitions of auxiliary   */
/* functions used in siminstr.c.                                           */
/***************************************************************************/

#include "siminstrlocal.h"
#include "dataformats.h"
#include "abstmachine.h"
#include "trail.h"
#include "hnorm.h"
#include "hopu.h"
#include "../system/error.h" //to be modified

#include <stdio.h> //to be removed

//Bind a free variable to a constant (without type association)
//Note the BND register is set to ON
static void SINSTRL_bindConst(DF_TermPtr varPtr, int c)
{
    TR_trailTerm(varPtr);
    DF_mkConst((MemPtr)varPtr, AM_cstUnivCount(c), c);
    AM_bndFlag = ON;
}

//Bind a free variable to an integer                                        
//Note the BND register is set to ON
static void SINSTRL_bindInt(DF_TermPtr varPtr, int i)
{
    TR_trailTerm(varPtr);
    DF_mkInt((MemPtr)varPtr, i);
    AM_bndFlag = ON;
}

//Bind a free variable to a float    
//Note the BND register is set to ON                                       
static void SINSTRL_bindFloat(DF_TermPtr varPtr, float f)
{
    TR_trailTerm(varPtr);
    DF_mkFloat((MemPtr)varPtr, f);
    AM_bndFlag = ON;
}

//Bind a free variable to a string                                          
//Note the BND register is set to ON 
void SINSTRL_bindString(DF_TermPtr varPtr, DF_StrDataPtr str)
{
    TR_trailTerm(varPtr);
    DF_mkStr((MemPtr)varPtr, str);
    AM_bndFlag = ON;
}

//Bind a free variable to a constant with type association 
//Note the BND register is set to ON; the TYWIRTE mode is set to ON
static void SINSTRL_bindTConst(DF_TermPtr varPtr, int c)
{
    MemPtr nhreg = AM_hreg + DF_TM_TCONST_SIZE;
    AM_heapError(nhreg + DF_TY_ATOMIC_SIZE * AM_cstTyEnvSize(c));
    DF_mkTConst(AM_hreg, AM_cstUnivCount(c), c, (DF_TypePtr)nhreg);
    TR_trailTerm(varPtr);
    DF_mkRef((MemPtr)varPtr, (DF_TermPtr)AM_hreg);
    AM_hreg = nhreg;
    AM_bndFlag = ON;
    AM_tyWriteFlag = ON;
}

//Bind a free variable to nil                                               
//Note the BND register is set to ON
static void SINSTRL_bindNil(DF_TermPtr varPtr)
{
    TR_trailTerm(varPtr);
    DF_mkNil((MemPtr)varPtr);
    AM_bndFlag = ON;
}


//Bind a free variable to an application object with a non-type-associated
//constant head.
//Setting relevant registers for 1)entering WRITE mode 2)entering OCC mode
//   3)indicating the occurrence of binding (BND = ON).
void SINSTRL_bindStr(DF_TermPtr varPtr, int constInd, int arity)
{
    MemPtr args  = AM_hreg + DF_TM_APP_SIZE; 
    MemPtr func  = args + arity * DF_TM_ATOMIC_SIZE;
    MemPtr nhreg = func + DF_TM_ATOMIC_SIZE;         //new heap top
    AM_heapError(nhreg);
    DF_mkApp(AM_hreg, arity, (DF_TermPtr)func, (DF_TermPtr)args);  //mk app
    DF_mkConst(func, AM_cstUnivCount(constInd), constInd);         //mk const
    //enter WRITE mode
    AM_sreg = (DF_TermPtr)args; AM_writeFlag = ON;  
    //enter OCC mode
    AM_adjreg = DF_fvUnivCount(varPtr); AM_vbbreg = (DF_TermPtr)AM_hreg;
    AM_ocFlag = ON;
    //performing binding
    TR_trailTerm(varPtr);
    DF_mkRef((MemPtr)varPtr, (DF_TermPtr)AM_hreg);
    AM_bndFlag = ON;
    
    AM_hreg = nhreg;
}

//Bind a free variable to an application object with a type-associated
//constant head.
//Setting relevant registers for 1)entering WRITE and TYWRITE mode 2)entering 
//   OCC mode 3)indicating the occurrence of binding (BND = ON).
void SINSTRL_bindTStr(DF_TermPtr varPtr, int constInd, int arity)
{
    MemPtr args  = AM_hreg + DF_TM_APP_SIZE;
    MemPtr func  = args + arity * DF_TM_ATOMIC_SIZE;
    MemPtr nhreg = func + DF_TM_TCONST_SIZE;         //new heap top
    AM_heapError(nhreg + AM_cstTyEnvSize(constInd) + DF_TY_ATOMIC_SIZE);
    DF_mkApp(AM_hreg, arity, (DF_TermPtr)func, (DF_TermPtr)args);  //mk app
    DF_mkTConst(func, AM_cstUnivCount(constInd), constInd, (DF_TypePtr)nhreg);
    //enter WRITE and TYWRITE mode
    AM_sreg = (DF_TermPtr)args; AM_writeFlag = ON; AM_tyWriteFlag = ON;
    //enter OCC mode
    AM_adjreg = DF_fvUnivCount(varPtr); AM_vbbreg = (DF_TermPtr)AM_hreg;
    AM_ocFlag = ON;
    //perform binding
    TR_trailTerm(varPtr);
    DF_mkRef((MemPtr)varPtr, (DF_TermPtr)AM_hreg);
    AM_bndFlag = ON;
    
    AM_hreg = nhreg;
}

//Bind a free variable to a list cons.
//Setting relevant registers for 1)entering WRITE mode 2)entering OCC mode
//   3)indicating the occurrence of binding (BND = ON).
void SINSTRL_bindCons(DF_TermPtr varPtr)
{
    MemPtr nhreg = AM_hreg + DF_CONS_ARITY * DF_TM_ATOMIC_SIZE; //new heap top
    AM_heapError(nhreg);
    //enter WRITE mode
    AM_sreg = (DF_TermPtr)AM_hreg; AM_writeFlag = ON;
    //enter OCC mode
    AM_adjreg = DF_fvUnivCount(varPtr); AM_vbbreg = (DF_TermPtr)AM_hreg;
    AM_ocFlag = ON;
    //perform binding
    TR_trailTerm(varPtr);
    DF_mkCons((MemPtr)varPtr, AM_sreg);
    AM_bndFlag = ON;
    
    AM_hreg = nhreg;
}


// Delay a pair (onto the PDL stack) with a given term as the first, and a   
// constant (without type association) as the second.                        
// Note this function is invoked in get_m_constant() when the 'dynamic' term 
// is higher-order, and so it is guaranteed that tPtr is a heap address.   
static void SINSTRL_delayConst(DF_TermPtr tPtr, int c)
{
    MemPtr nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkConst(AM_hreg, AM_cstUnivCount(c), c);
    AM_pdlError(2);
    AM_pushPDL((MemPtr)tPtr); 
    AM_pushPDL(AM_hreg);
    AM_hreg = nhreg;
}

//Delay a pair (onto the PDL stack) with a given term as the first, and a    
//constant with type association the second.   
//Note TYWRITE mode is set to ON.
static void SINSTRL_delayTConst(DF_TermPtr tPtr, int c)
{
    MemPtr nhreg = AM_hreg + DF_TM_TCONST_SIZE;
    AM_heapError(nhreg + DF_TY_ATOMIC_SIZE * AM_cstTyEnvSize(c));
    DF_mkTConst(AM_hreg, AM_cstUnivCount(c), c, (DF_TypePtr)nhreg);
    AM_pdlError(2);
    AM_pushPDL((MemPtr)tPtr);
    AM_pushPDL(AM_hreg);
    AM_hreg = nhreg;
    AM_tyWriteFlag = ON;
}

//Delay a pair (onto the PDL stack) with a given term and an integer
static void SINSTRL_delayInt(DF_TermPtr tPtr, int i)
{
    MemPtr nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkInt(AM_hreg, i);
    AM_pdlError(2);
    AM_pushPDL((MemPtr)tPtr); 
    AM_pushPDL(AM_hreg);
    AM_hreg = nhreg;
}

//Delay a pair (onto the PDL stack) with a given term and a float
static void SINSTRL_delayFloat(DF_TermPtr tPtr, float f)
{
    MemPtr nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkFloat(AM_hreg, f);
    AM_pdlError(2);
    AM_pushPDL((MemPtr)tPtr); 
    AM_pushPDL(AM_hreg);
    AM_hreg = nhreg;
}
  
//Delay a pair (onto the PDL stack) with a given term and a string
static void SINSTRL_delayString(DF_TermPtr tPtr, DF_StrDataPtr str)
{
    MemPtr nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkStr(AM_hreg, str);
    AM_pdlError(2);
    AM_pushPDL((MemPtr)tPtr); 
    AM_pushPDL(AM_hreg);
    AM_hreg = nhreg;
}

//Delay a pair (onto the PDL stack) with a given term and nil list 
static void SINSTRL_delayNil(DF_TermPtr tPtr)
{
    MemPtr nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkNil(AM_hreg);
    AM_pdlError(2);
    AM_pushPDL((MemPtr)tPtr); 
    AM_pushPDL(AM_hreg);
    AM_hreg = nhreg;
}

//Delay a pair (onto the PDL stack) with a given term and an application
//object with a non-type-associated constant head.
//Setting registers 1)entering WRITE mode: S and WRITE; 2)entering OCC OFF
//mode; 3) ADJ
void SINSTRL_delayStr(DF_TermPtr tPtr, int constInd, int arity)
{
    MemPtr args  = AM_hreg + DF_TM_APP_SIZE;
    MemPtr func  = args + arity * DF_TM_ATOMIC_SIZE;
    MemPtr nhreg = func + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkApp(AM_hreg, arity, (DF_TermPtr)func, (DF_TermPtr)args);  //mk app
    DF_mkConst(func, AM_cstUnivCount(constInd), constInd);         //mk const
    //push onto PDL
    AM_pdlError(2);
    AM_pushPDL((MemPtr)tPtr);
    AM_pushPDL(AM_hreg);
    //enter WRITE mode
    AM_sreg = (DF_TermPtr)args; AM_writeFlag = ON;
    //enter OCC OFF mode
    AM_ocFlag = OFF;
    AM_adjreg = AM_ucreg;
    
    AM_hreg = nhreg;
}

//Delay a pair (onto the PDL stack) with a given term and an application
//object with a type-associated constant head.
//Setting registers 1)entering WRITE and TYWRITE mode: S, WRITE and TYWRITE; 
//  2)entering OCC OFF mode; 3) ADJ
void SINSTRL_delayTStr(DF_TermPtr tPtr, int constInd, int arity)
{
    MemPtr args  = AM_hreg + DF_TM_APP_SIZE;
    MemPtr func  = args + arity * DF_TM_ATOMIC_SIZE;
    MemPtr nhreg = func + DF_TM_TCONST_SIZE;    
    AM_heapError(nhreg + AM_cstTyEnvSize(constInd) + DF_TY_ATOMIC_SIZE);
    DF_mkApp(AM_hreg, arity, (DF_TermPtr)func, (DF_TermPtr)args);  //mk app
    DF_mkTConst(func, AM_cstUnivCount(constInd), constInd, (DF_TypePtr)nhreg);
    //push onto PDL
    AM_pdlError(2);
    AM_pushPDL((MemPtr)tPtr);
    AM_pushPDL(AM_hreg);
    //enter WRITE and TYWRITE mode
    AM_sreg = (DF_TermPtr)args; AM_writeFlag = ON; AM_tyWriteFlag = ON;
    //enter OCC OFF mode
    AM_ocFlag = OFF;
    AM_adjreg = AM_ucreg;

    AM_hreg = nhreg;
}

//Delay a pair (onto the PDL stack) with a given term and a list cons       
//Setting registers 1)entering WRITE mode: S and WRITE; 2)entering OCC OFF
//mode; 3) ADJ
void SINSTRL_delayCons(DF_TermPtr tPtr)
{
    MemPtr args  = AM_hreg + DF_TM_ATOMIC_SIZE;
    MemPtr nhreg = args + DF_CONS_ARITY * DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkCons(AM_hreg, (DF_TermPtr)args);
    //push onto PDL
    AM_pdlError(2);
    AM_pushPDL((MemPtr)tPtr);
    AM_pushPDL(AM_hreg);
    //enter WRITE mode
    AM_sreg = (DF_TermPtr)args; AM_writeFlag = ON;
    //enter OCC OFF mode
    AM_ocFlag = OFF;
    AM_adjreg = AM_ucreg;

    AM_hreg = nhreg;
}

/*The main action of unify_value in write mode. This code carries out the    */
/*necessary occurs checking in the binding of a variable that has already    */
/*commenced through an enclosing get_structure instruction.                  */
/*Care has been taken to avoid making a reference to a register or stack     */
/*address.                                                                   */ 
void SINSTRL_bindSreg(DF_TermPtr tmPtr)
{
    DF_TermPtr bndBody;
    int nabs;

    HN_hnormOcc(tmPtr);
    nabs = AM_numAbs;
    HOPU_copyFlagGlb = FALSE;
    if (AM_rigFlag) {
        bndBody = HOPU_rigNestedSubstC(AM_head, HOPU_lamBody(tmPtr), AM_argVec, 
                                       AM_numArgs, nabs);
        if (nabs) DF_mkLam((MemPtr)AM_sreg, nabs, bndBody); //no emb error
        else {
            if (HOPU_copyFlagGlb) DF_mkRef((MemPtr)AM_sreg, bndBody);
            else HOPU_globalizeCopyRigid(bndBody, AM_sreg);
        }
    } else { //AM_rigFlag = FALSE
        bndBody = HOPU_flexNestedSubstC(AM_head, AM_argVec, AM_numArgs, 
                                        HOPU_lamBody(tmPtr), nabs);
        if (HOPU_copyFlagGlb == FALSE) bndBody = HOPU_globalizeFlex(bndBody);
        if (nabs) DF_mkLam((MemPtr)AM_sreg, nabs, bndBody);
        else DF_mkRef((MemPtr)AM_sreg, bndBody);
    }
}

/*The main component of unify_local_value in write mode when it is determined */
/*that we are dealing with a heap cell.                                       */
void SINSTRL_bindSregH(DF_TermPtr tmPtr)
{
    DF_TermPtr bndBody;
    int nabs;
    
    HN_hnormOcc(tmPtr);
    nabs = AM_numAbs;
    HOPU_copyFlagGlb = FALSE;
    if (AM_rigFlag) {
        bndBody = HOPU_rigNestedSubstC(AM_head, HOPU_lamBody(tmPtr), AM_argVec,
                                       AM_numArgs, nabs);
        if (nabs) DF_mkLam((MemPtr)AM_sreg, nabs, bndBody);
        else DF_mkRef((MemPtr)AM_sreg, bndBody);
    } else { //AM_rigFlag = FALSE
        bndBody = HOPU_flexNestedSubstC(AM_head, AM_argVec, AM_numArgs,
                                        HOPU_lamBody(tmPtr), nabs);
        if (nabs) DF_mkLam((MemPtr)AM_sreg, nabs, bndBody);
        else DF_mkRef((MemPtr)AM_sreg, bndBody);
    }
}


/*****************************************************************************/
/* Auxiliary functions for unifying terms used in get- and unify- instrutions*/
/*****************************************************************************/

//attempting to unify a dereference term with a constant without type assoc
void SINSTRL_unifyConst(DF_TermPtr tmPtr, int constInd)
{
    switch (DF_termTag(tmPtr)) {
    case DF_TM_TAG_VAR: 
    { 
        if (DF_fvUnivCount(tmPtr)<AM_cstUnivCount(constInd)) EM_THROW(EM_FAIL);
        SINSTRL_bindConst(tmPtr, constInd);
        return;
    }
    case DF_TM_TAG_CONST:
    {
        if (constInd != DF_constTabIndex(tmPtr)) EM_THROW(EM_FAIL);
        return;
    }
    case DF_TM_TAG_APP:
    {
        if (DF_isConst(DF_termDeref(DF_appFunc(tmPtr)))) EM_THROW(EM_FAIL);
    }
    case DF_TM_TAG_LAM:  case DF_TM_TAG_SUSP: //and other APP cases
    { 
        HN_hnorm(tmPtr);
        if (AM_rigFlag) {
            if (DF_isConst(AM_head) && (DF_constTabIndex(AM_head) == constInd)){
                if (AM_numAbs != AM_numArgs) EM_THROW(EM_FAIL);
                if (AM_numAbs != 0) SINSTRL_delayConst(tmPtr, constInd);//h-ord
            } else EM_THROW(EM_FAIL);
        } else { // (AM_rigFlag == OFF)
            if (AM_numArgs == 0) {
                if ((AM_numAbs == 0) && 
                    (DF_fvUnivCount(AM_head) >= AM_cstUnivCount(constInd)))
                    SINSTRL_bindConst(AM_head, constInd);
                else EM_THROW(EM_FAIL);
            } else SINSTRL_delayConst(tmPtr, constInd); //higher-order
        }       //  (AM_rigFlag == OFF)
        return;
    }
    default:{ EM_THROW(EM_FAIL); } //CONS, NIL, BVAR, INT, FLOAT, STR, (STREAM)
    } //switch
}

//attempting to unify a dereferenced term with an integer
void SINSTRL_unifyInt(DF_TermPtr tmPtr, int intValue)
{
    switch (DF_termTag(tmPtr)) {
    case DF_TM_TAG_VAR: { SINSTRL_bindInt(tmPtr, intValue); return; }
    case DF_TM_TAG_INT: 
    { 
        if (intValue != DF_intValue(tmPtr)) EM_THROW(EM_FAIL);
        return;
    }
    case DF_TM_TAG_APP: 
    { //Note the functor of app cannot be an integer per well-typedness
        if (DF_isConst(DF_termDeref(DF_appFunc(tmPtr)))) EM_THROW(EM_FAIL);
    }
    case DF_TM_TAG_SUSP: //and other APP cases
    { // Note ABS cannot occur due to well-typedness
        HN_hnorm(tmPtr);
        if (AM_rigFlag) { 
            if (DF_isInt(AM_head) && (DF_intValue(AM_head) == intValue)) return;
            else EM_THROW(EM_FAIL);
        } else { //(AM_rigFlag == OFF)
            if (AM_numArgs == 0)  //note AM_numAbs must be 0 because of type
                SINSTRL_bindInt(AM_head, intValue);
            else SINSTRL_delayInt(tmPtr, intValue);
            return;
        }        //(AM_rigFlag == OFF)
    }
    default: { EM_THROW(EM_FAIL); } //BVAR, CONST
    } //switch
}

//attempting to unify a dereferenced term with a real number
void SINSTRL_unifyFloat(DF_TermPtr tmPtr, float floatValue)
{
    switch (DF_termTag(tmPtr)){
    case DF_TM_TAG_VAR: { SINSTRL_bindFloat(tmPtr, floatValue); return; }
    case DF_TM_TAG_FLOAT: 
    { 
        if (floatValue != DF_floatValue(tmPtr)) EM_THROW(EM_FAIL);
        return;
    }
    case DF_TM_TAG_APP: 
    { //Note the functor of app cannot be a float per well-typedness
        if (DF_isConst(DF_termDeref(DF_appFunc(tmPtr)))) EM_THROW(EM_FAIL);
    }
    case DF_TM_TAG_SUSP: //other APP cases
    { //Note ABS cannot occur due to well-typedness
        HN_hnorm(tmPtr);
        if (AM_rigFlag) { 
            if (DF_isFloat(AM_head) && (DF_floatValue(AM_head) == floatValue)) 
                return;
            else EM_THROW(EM_FAIL);
        } else { //(AM_rigFlag == OFF)
            if (AM_numArgs == 0)  //note AM_numAbs must be 0 because of type
                SINSTRL_bindFloat(AM_head, floatValue);
            else SINSTRL_delayFloat(tmPtr, floatValue);
            return;
        }        //(AM_rigFlag == OFF)
    }
    default: { EM_THROW(EM_FAIL); } //BVAR, CONST
    } //switch
}

//attempting to unify a dereferenced term with a string
void SINSTRL_unifyString(DF_TermPtr tmPtr, DF_StrDataPtr str)
{
    switch (DF_termTag(tmPtr)){
    case DF_TM_TAG_VAR: { SINSTRL_bindString(tmPtr, str);  return; }
    case DF_TM_TAG_STR: 
    {
        if (!DF_sameStrData(tmPtr, str)) EM_THROW(EM_FAIL);
        return;
    }
    case DF_TM_TAG_APP:
    { //Note the functor of app cannot be a string per well-typedness
        if (DF_isConst(DF_termDeref(DF_appFunc(tmPtr)))) EM_THROW(EM_FAIL);
    }
    case DF_TM_TAG_SUSP: //and other APP cases
    { //Note ABS cannot occur due to well-typedness
        HN_hnorm(tmPtr);
        if (AM_rigFlag) {
            if (DF_isStr(AM_head) && (DF_sameStrData(AM_head, str))) return;
            else EM_THROW(EM_FAIL);
        } else  {//(AM_rigFlag == OFF)
            if (AM_numArgs == 0) //note AM_numAbs must be 0 because of type
                SINSTRL_bindString(AM_head, str);
            else SINSTRL_delayString(tmPtr, str);
            return;
        }        //(AM_rigFlag == OFF)
    }
    default: { EM_THROW(EM_FAIL); } //BVAR, CONST
    } //switch
}


//attempting to unify a dereferenced term with a constant with type assoc
void SINSTRL_unifyTConst(DF_TermPtr tmPtr, int constInd, CSpacePtr label)
{
    switch (DF_termTag(tmPtr)) {
    case DF_TM_TAG_VAR: 
    {
        if (DF_fvUnivCount(tmPtr)<AM_cstUnivCount(constInd)) EM_THROW(EM_FAIL);
        SINSTRL_bindTConst(tmPtr, constInd);
        return;
    }
    case DF_TM_TAG_CONST:
    {
        if (constInd != DF_constTabIndex(tmPtr)) EM_THROW(EM_FAIL);
        AM_preg = label;
        return;
    }
    case DF_TM_TAG_APP:
    {
        if (DF_isConst(DF_termDeref(DF_appFunc(tmPtr)))) EM_THROW(EM_FAIL);
    }
    case DF_TM_TAG_LAM: case DF_TM_TAG_SUSP: //other APP cases
    { 
        HN_hnorm(tmPtr);
        if (AM_rigFlag) {
            if (DF_isConst(AM_head) && (DF_constTabIndex(AM_head) == constInd)){
                if (AM_numAbs != AM_numArgs) EM_THROW(EM_FAIL);
                if (AM_numAbs == 0) AM_preg = label;       //first-order
                else SINSTRL_delayTConst(tmPtr, constInd); //higher-order
            } else EM_THROW(EM_FAIL);
        } else { //(AM_rigFlag == OFF)
            if (AM_numAbs == 0) {
                if ((AM_numAbs == 0) &&
                    (DF_fvUnivCount(AM_head) >= AM_cstUnivCount(constInd)))
                    SINSTRL_bindTConst(AM_head, constInd);
                else EM_THROW(EM_FAIL);
            } else SINSTRL_delayTConst(tmPtr, constInd);   //higher-order
        }        //(AM_rigFlag == OFF)
        return;
    }
    default: { EM_THROW(EM_FAIL); } //CONS, NIL, BVAR, INT, FLOAT, STR, (STREAM)
    } //switch
}

//attempting to unify a dereferenced term with a nil list
void SINSTRL_unifyNil(DF_TermPtr tmPtr)
{
    switch (DF_termTag(tmPtr)){
    case DF_TM_TAG_VAR:  { SINSTRL_bindNil(tmPtr); return; }
    case DF_TM_TAG_NIL:  { return; }
    case DF_TM_TAG_CONS: { EM_THROW(EM_FAIL);}
    case DF_TM_TAG_APP:
    {
        if (DF_isConst(DF_termDeref(DF_appFunc(tmPtr)))) EM_THROW(EM_FAIL);
    }
    case DF_TM_TAG_SUSP: //and other APP cases
    { //Note ABS cannot occur due to well-typedness
        HN_hnorm(tmPtr);
        if (AM_consFlag) EM_THROW(EM_FAIL);
        if (AM_rigFlag) {
            if (DF_isNil(AM_head)) return;
            EM_THROW(EM_FAIL);
        } else { //(AM_rigFlag == OFF)
            if (AM_numArgs == 0)  //note AM_numAbs must be 0 because of type
                SINSTRL_bindNil(AM_head);
            else SINSTRL_delayNil(tmPtr);
            return;
        }        //(AM_rigFlag == OFF)
    }
    default: { EM_THROW(EM_FAIL); }//BVAR, CONST, CONS
    } //switch
}


