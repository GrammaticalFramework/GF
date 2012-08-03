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
/*****************************************************************************/
/*                                                                           */
/* File siminstr.c. The instruction set of the virtual machine.              */
/*****************************************************************************/
#ifndef SIMINSTR_C
#define SIMINSTR_C

#include "siminstr.h"
#include "dataformats.h"
#include "abstmachine.h"
#include "trail.h"
#include "hnorm.h"
#include "hopu.h"
#include "types.h"
#include "instraccess.h"
#include "siminstrlocal.h"
#include "builtins/builtins.h"
#include "../system/error.h" 
#include "../tables/pervasives.h"
#include "../tables/instructions.h"
#include "../loader/searchtab.h"


#include <stdio.h>  
#include "printterm.h"
#include "../system/stream.h"

static AM_DataTypePtr regX, regA;
static AM_DataTypePtr envY, clenvY;
static DF_TermPtr     tmPtr, func;
static DF_TypePtr     tyPtr;
static MemPtr         nhreg, ip, ep, cp;
static MemPtr         impTab;
static MemPtr         table;
static MemPtr         bckfd;
static MemPtr         nextcl;
static int            constInd, kindInd, tablInd;
static int            n, m, l, uc, numAbs;
static int            intValue;
static float          floatValue;
static DF_StrDataPtr  str;
static CSpacePtr      label, cl;

/****************************************************************************/
/* INSTRUCTIONS FOR UNIFYING AND CREATING TERMS                             */
/****************************************************************************/

/**************************************************************************/
/* PUT CLASS                                                              */
/**************************************************************************/
void SINSTR_put_variable_t()              //put_variable Xn,Ai -- R_R_X
{
    INSACC_RRX(regX, regA);
    nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkVar(AM_hreg, AM_ucreg);
    DF_mkRef((MemPtr)regX, (DF_TermPtr)AM_hreg); 
    *regA = *regX;                               
    AM_hreg = nhreg;
}

void SINSTR_put_variable_te()             //put_variable_te Xn,Ai -- R_R_X
{
    INSACC_RRX(regX, regA);
    nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkVar(AM_hreg,  AM_envUC());
    DF_mkRef((MemPtr)regX, (DF_TermPtr)AM_hreg); 
    *regA = *regX;                               
    AM_hreg = nhreg;
}

void SINSTR_put_variable_p()              //put_variable Yn,Ai -- E_R_X
{
    INSACC_ERX(envY, regA);
    DF_mkVar((MemPtr)envY, AM_envUC());         
    DF_mkRef((MemPtr)regA, (DF_TermPtr)envY); 
}

void SINSTR_put_value_t()                 //put_value Xn,Ai -- R_R_X
{
    INSACC_RRX(regX, regA);
    *regA = *regX;
}

void SINSTR_put_value_p()                 //put_value Yn,Ai -- E_R_X
{
    INSACC_ERX(envY, regA);
    tmPtr = DF_termDeref((DF_TermPtr)envY);
    if ((!AM_stackAddr((MemPtr)tmPtr)) || DF_isFV(tmPtr))
        DF_mkRef((MemPtr)regA, tmPtr);
    else *regA = *((AM_DataTypePtr)tmPtr); //cons or (mono) constants on stack
}

void SINSTR_put_unsafe_value()           //put_unsafe_value Yn,Ai -- E_R_X
{
    INSACC_ERX(envY, regA);

    tmPtr = DF_termDeref((DF_TermPtr)envY);
    switch (DF_termTag(tmPtr)) {
    case DF_TM_TAG_NIL:
    case DF_TM_TAG_CONS:
    case DF_TM_TAG_INT:
    case DF_TM_TAG_FLOAT:
    case DF_TM_TAG_STR:
    case DF_TM_TAG_STREAM:
    {*regA = *((AM_DataTypePtr)tmPtr);  break; }
    case DF_TM_TAG_CONST:
    {
        if (DF_isTConst(tmPtr)) DF_mkRef((MemPtr)regA, tmPtr);
        else *regA = *((AM_DataTypePtr)tmPtr);
        break; 
    }
    case DF_TM_TAG_VAR:
    {
        if (AM_inCurEnv((MemPtr)tmPtr)) {
            AM_heapError(AM_hreg + DF_TM_ATOMIC_SIZE);
            TR_trailETerm(tmPtr);
            DF_copyAtomic(tmPtr, AM_hreg);
            DF_mkRef((MemPtr)tmPtr, (DF_TermPtr)AM_hreg);
            AM_hreg += DF_TM_ATOMIC_SIZE;
            *regA = *((AM_DataTypePtr)tmPtr);
        } else 
            DF_mkRef((MemPtr)regA, tmPtr);
        break;
    }
    default: { DF_mkRef((MemPtr)regA, tmPtr); break; }
    }
}

void SINSTR_copy_value()                  //copy_value Yn,Ai -- E_R_X
{
    INSACC_ERX(envY, regA);
    tmPtr = DF_termDeref((DF_TermPtr)envY);
    if (AM_stackAddr((MemPtr)tmPtr)) {
        *regA = *((AM_DataTypePtr)tmPtr); 
    } else DF_mkRef((MemPtr)regA, tmPtr);
}

void SINSTR_put_m_const()                 //put_m_const Ai,c -- R_C_X
{
    INSACC_RCX(regA, constInd);
    DF_mkConst((MemPtr)regA, AM_cstUnivCount(constInd), constInd);
}

void SINSTR_put_p_const()                 //put_p_const Ai,c -- R_C_X
{
    INSACC_RCX(regA, constInd);
    nhreg = AM_hreg + DF_TM_TCONST_SIZE;
    AM_heapError((MemPtr)(((DF_TypePtr)nhreg) + AM_cstTyEnvSize(constInd)));
    DF_mkTConst(AM_hreg, AM_cstUnivCount(constInd), constInd,(DF_TypePtr)nhreg);
    DF_mkRef((MemPtr)regA, (DF_TermPtr)AM_hreg);
    AM_hreg = nhreg;
}

void SINSTR_put_nil()                     //put_nil Ai -- R_X
{
    INSACC_RX(regA);
    DF_mkNil((MemPtr)regA);
}

void SINSTR_put_integer()                 //put_integer Ai,i -- R_I_X
{
    INSACC_RIX(regA, intValue);
    DF_mkInt((MemPtr)regA, intValue);
}

void SINSTR_put_float()                   //put_float Ai,f -- R_F_X
{
    INSACC_RFX(regA, floatValue);
    DF_mkFloat((MemPtr)regA, floatValue);
}

void SINSTR_put_string()                  //put_string Ai,str -- R_S_X
{
    INSACC_RSX(regA, str);
    DF_mkStr((MemPtr)regA, str);
}

void SINSTR_put_index()                   //put_index Ai,n -- R_I1_X
{
    INSACC_RI1X(regA, n);
    nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkBV(AM_hreg, n);
    DF_mkRef((MemPtr)regA, (DF_TermPtr)AM_hreg);
    AM_hreg = nhreg;
}

void SINSTR_put_app()                     //put_app Ai,Xj,n -- R_R_I1_X
{
    INSACC_RRI1X(regA, regX, n);   
    nhreg = (MemPtr)(((DF_TermPtr)(AM_hreg + DF_TM_APP_SIZE)) + n);
    if (DF_isRef((DF_TermPtr)regX)) {
        AM_heapError(nhreg);
        tmPtr = DF_refTarget((DF_TermPtr)regX);
    } else { //regX not a reference
        nhreg += DF_TM_ATOMIC_SIZE;
        AM_heapError(nhreg);
        DF_copyAtomic((DF_TermPtr)regX, AM_hreg);
        tmPtr = (DF_TermPtr)AM_hreg;
        AM_hreg += DF_TM_ATOMIC_SIZE;
    }
    AM_sreg = (DF_TermPtr)(AM_hreg + DF_TM_APP_SIZE);    
    DF_mkApp(AM_hreg, n, tmPtr, AM_sreg);
    DF_mkRef((MemPtr)regA, (DF_TermPtr)AM_hreg);    
    AM_hreg = nhreg;
}

void SINSTR_put_list()                    //put_list Ai -- R_X
{
    INSACC_RX(regA);
    nhreg = (MemPtr)(((DF_TermPtr)AM_hreg) + DF_CONS_ARITY);
    AM_heapError(nhreg);
    AM_sreg = (DF_TermPtr)AM_hreg;
    DF_mkCons((MemPtr)regA, AM_sreg);
    AM_hreg = nhreg;
}

void SINSTR_put_lambda()                  //put_lambda Ai,Xj,n -- R_R_I1_X
{
    INSACC_RRI1X(regA, regX, n);    
    nhreg = AM_hreg + DF_TM_LAM_SIZE;
    if (DF_isRef((DF_TermPtr)regX)) {
        AM_heapError(nhreg);
        tmPtr = DF_refTarget((DF_TermPtr)regX);
    } else {
        nhreg += DF_TM_ATOMIC_SIZE;
        AM_heapError(nhreg);
        DF_copyAtomic((DF_TermPtr)regX, AM_hreg);
        tmPtr = (DF_TermPtr)AM_hreg;
        AM_hreg += DF_TM_ATOMIC_SIZE;
    }
    DF_mkLam(AM_hreg, n, tmPtr);
    DF_mkRef((MemPtr)regA, (DF_TermPtr)AM_hreg);
    AM_hreg = nhreg;
}

/*************************************************************************/
/* SET CLASS                                                             */
/*************************************************************************/
void SINSTR_set_variable_t()              //set_variable Xi -- R_X
{
    INSACC_RX(regX);
    DF_mkVar((MemPtr)AM_sreg, AM_ucreg);
    DF_mkRef((MemPtr)regX, AM_sreg);
    AM_sreg++;
}

void SINSTR_set_variable_te()             //set_variable_te Xi -- R_X
{
    INSACC_RX(regX);
    DF_mkVar((MemPtr)AM_sreg, AM_envUC());
    DF_mkRef((MemPtr)regX, AM_sreg);
    AM_sreg++;
}

void SINSTR_set_variable_p()              //set_variable_p Yi -- E_X
{
    INSACC_EX(envY);
    DF_mkVar((MemPtr)AM_sreg, AM_envUC());
    DF_mkRef((MemPtr)envY, AM_sreg);
    AM_sreg++;
}

void SINSTR_set_value_t()                 //set_value Xi -- R_X
{
    INSACC_RX(regX);
    DF_copyAtomic((DF_TermPtr)regX, (MemPtr)AM_sreg);
    AM_sreg++;
}

void SINSTR_set_value_p()                 //set_value Yi -- E_X
{
    INSACC_EX(envY);
    tmPtr = DF_termDeref((DF_TermPtr)envY);
    if (AM_stackAddr((MemPtr)tmPtr)) { //needed?; in fact, what if a fv?
      //printf("set_value_p -- stack addr\n");
        DF_copyAtomic(tmPtr, (MemPtr)AM_sreg);
    } else DF_mkRef((MemPtr)AM_sreg, tmPtr);
    AM_sreg++;
}

void SINSTR_globalize_pt()                //globalize_pt Yj,Xi -- E_R_X
{
    INSACC_ERX(envY, regX);
    tmPtr = DF_termDeref((DF_TermPtr)envY);
    if (AM_stackAddr((MemPtr)tmPtr)) {
        nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
        AM_heapError(nhreg);
        DF_copyAtomic(tmPtr, AM_hreg);
        if (DF_isFV(tmPtr)) {
            TR_trailETerm(tmPtr);
            DF_mkRef((MemPtr)tmPtr, (DF_TermPtr)AM_hreg);
        }
        DF_mkRef((MemPtr)regX, (DF_TermPtr)AM_hreg);
        AM_hreg = nhreg;
    } else DF_mkRef((MemPtr)regX, tmPtr);    
}

void SINSTR_globalize_t()                 //globalize_t Xi -- R_X
{
    INSACC_RX(regX);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    if (AM_nHeapAddr((MemPtr)tmPtr)){
        nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
        AM_heapError(nhreg);
        DF_copyAtomic(tmPtr, AM_hreg);
        if (DF_isFV(tmPtr)) {
            TR_trailETerm(tmPtr);
            DF_mkRef((MemPtr)tmPtr, (DF_TermPtr)AM_hreg);
        }
        DF_mkRef((MemPtr)regX, (DF_TermPtr)AM_hreg);
        AM_hreg = nhreg;
    } else DF_mkRef((MemPtr)regX, tmPtr);
}

void SINSTR_set_m_const()                 //set_m_const c -- C_X
{
    INSACC_CX(constInd);
    DF_mkConst((MemPtr)AM_sreg, AM_cstUnivCount(constInd), constInd);
    AM_sreg++;
}

void SINSTR_set_p_const()                 //set_p_const c -- C_X
{
    INSACC_CX(constInd);    
    nhreg = AM_hreg + DF_TM_TCONST_SIZE;
    AM_heapError(nhreg + AM_cstTyEnvSize(constInd) * DF_TY_ATOMIC_SIZE);
    DF_mkTConst(AM_hreg,AM_cstUnivCount(constInd),constInd,(DF_TypePtr)nhreg);
    DF_mkRef((MemPtr)AM_sreg, (DF_TermPtr)AM_hreg);
    AM_sreg++;
    AM_hreg = nhreg;
}

void SINSTR_set_nil()                     //set_nil -- X
{
    INSACC_X();
    DF_mkNil((MemPtr)AM_sreg);
    AM_sreg++;
}

void SINSTR_set_integer()                 //set_integer i -- I_X
{
    INSACC_IX(intValue);
    DF_mkInt((MemPtr)AM_sreg, intValue);
    AM_sreg++;
}

void SINSTR_set_float()                   //set_float f -- F_X
{
    INSACC_FX(floatValue);
    DF_mkFloat((MemPtr)AM_sreg, floatValue);
    AM_sreg++;
}

void SINSTR_set_string()                  //set_string str -- S_X
{
    INSACC_SX(str);
    DF_mkStr((MemPtr)AM_sreg, str);
    AM_sreg++;
}

void SINSTR_set_index()                   //set_index n -- I1_X
{
    INSACC_I1X(n);
    DF_mkBV((MemPtr)AM_sreg, n);
    AM_sreg++;
}

void SINSTR_set_void()                    //set_void n -- I1_X
{
    INSACC_I1X(n);
    while (n > 0) {
        DF_mkVar((MemPtr)AM_sreg, AM_ucreg);
        AM_sreg++;
        n--;
    }
}

void SINSTR_deref()                       //deref Xi -- R_X; needed?
{
    INSACC_RX(regX);
    regA = (AM_DataTypePtr)(DF_termDeref((DF_TermPtr)regX));    
    *regX = *regA; //assume an atomic term?
}

void SINSTR_set_lambda()                  //set_lambda Xi, n -- R_I1_X; needed?
{
    INSACC_RI1X(regX, n);
    if (!DF_isRef((DF_TermPtr)regX)) {
        nhreg += DF_TM_ATOMIC_SIZE;
        AM_heapError(nhreg);
        DF_copyAtomic((DF_TermPtr)regX, AM_hreg);
        DF_mkRef((MemPtr)regX, (DF_TermPtr)AM_hreg);
        AM_hreg += DF_TM_ATOMIC_SIZE;
    } 
    DF_mkLam((MemPtr)AM_sreg, n, DF_refTarget((DF_TermPtr)regX));
    AM_sreg++;
}

/*************************************************************************/
/* GET CLASS                                                             */
/*************************************************************************/

void SINSTR_get_variable_t()            //get_variable Xn,Ai -- R_R_X
{
    INSACC_RRX(regX, regA);
    *regX = *regA;
}

void SINSTR_get_variable_p()            //get_variable Yn,Ai -- E_R_X 
{
    INSACC_ERX(envY, regA);
    *envY = *regA;
}

void SINSTR_init_variable_t()           //init_variable Xn,Ym -- R_CE_X
{
    INSACC_RCEX(regA, clenvY);
    DF_mkRef((MemPtr)regA, DF_termDeref((DF_TermPtr)clenvY));
}

void SINSTR_init_variable_p()           //init_variable Yn,Ym -- E_CE_X
{
    INSACC_ECEX(envY, clenvY);
    DF_mkRef((MemPtr)envY, DF_termDeref((DF_TermPtr)clenvY));
}

void SINSTR_get_m_constant()            //get_m_constant Xi,c -- R_C_X
{    
    INSACC_RCX(regX, constInd);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    SINSTRL_unifyConst(tmPtr, constInd);
}

void SINSTR_get_p_constant()            //get_p_constant Xi,c,L -- R_C_L_X
{
    INSACC_RCLX(regX, constInd, label);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    SINSTRL_unifyTConst(tmPtr, constInd, label);
}

void SINSTR_get_integer()               //get_integer Xi,i -- R_I_X
{
    INSACC_RIX(regX, intValue);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    SINSTRL_unifyInt(tmPtr, intValue);
}

void SINSTR_get_float()                 //get_float Xi,f -- R_F_X
{
    INSACC_RFX(regX, floatValue);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    SINSTRL_unifyFloat(tmPtr, floatValue);
}

void SINSTR_get_string()                //get_string Xi,str --R_S_X
{
    INSACC_RSX(regX, str);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    SINSTRL_unifyString(tmPtr, str);
}
    
void SINSTR_get_nil()                   //get_nil Xi --  R_X
{
    INSACC_RX(regX);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    SINSTRL_unifyNil(tmPtr);
   
}

void SINSTR_get_m_structure()           //get_m_structure Xi,f,n--R_C_I1_X
{
    INSACC_RCI1X(regX, constInd, n);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    switch (DF_termTag(tmPtr)) {
    case DF_TM_TAG_VAR: 
    { 
      if (DF_fvUnivCount(tmPtr) >= AM_cstUnivCount(constInd)) {
	SINSTRL_bindStr(tmPtr, constInd, n);
	return; 
      } else {
	EM_THROW(EM_FAIL);
      }
    }
    case DF_TM_TAG_APP: 
    {
        func = DF_termDeref(DF_appFunc(tmPtr));
        if (DF_isConst(func)) {
            if ((DF_constTabIndex(func)==constInd)&&(DF_appArity(tmPtr)==n)){
                AM_sreg = DF_appArgs(tmPtr); AM_writeFlag = OFF; //READ MODE
                return;
            } else EM_THROW(EM_FAIL); //diff const head 
        } //otherwise continue with the next case
    }
    case DF_TM_TAG_LAM: case DF_TM_TAG_SUSP: //and other APP cases
    { 
        HN_hnorm(tmPtr);
        if (AM_rigFlag) {
            if (DF_isConst(AM_head) && (DF_constTabIndex(AM_head) == constInd)){
                if (AM_numArgs == (AM_numAbs + n)){
                    if (AM_numAbs == 0) {
                        AM_sreg = AM_argVec; AM_writeFlag = OFF; //READ MODE
                    } else SINSTRL_delayStr(tmPtr, constInd, n); //#abs > 0
                } else EM_THROW(EM_FAIL); //numArgs != numAbs + n
            } else EM_THROW(EM_FAIL); //non const rig head or diff const head
        } else { //AM_rigFlag == OFF
            if (AM_numArgs == 0) {
                if ((AM_numAbs == 0) && 
                    (DF_fvUnivCount(AM_head) >= AM_cstUnivCount(constInd)))
                    SINSTRL_bindStr(AM_head, constInd, n);
                else EM_THROW(EM_FAIL);
            } else SINSTRL_delayStr(tmPtr, constInd, n);
        }        //AM_rigFlag == OFF
        return;
    }
    default: 
    {//CONS, NIL, CONST, INT, FLOAT, STR, BV, (STREAM)
        EM_THROW(EM_FAIL);
    }
    } //switch
}

void SINSTR_get_p_structure()           //get_p_structure Xi,f,n--R_C_I1_X
{
    INSACC_RCI1X(regX, constInd, n);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    switch (DF_termTag(tmPtr)) {
    case DF_TM_TAG_VAR:
    {
      if (DF_fvUnivCount(tmPtr) >= AM_cstUnivCount(constInd)) {
	SINSTRL_bindTStr(tmPtr, constInd, n);
	return; 
      } else {
	EM_THROW(EM_FAIL);
      }
    }
    case DF_TM_TAG_APP:
    {
        func = DF_termDeref(DF_appFunc(tmPtr));
        if (DF_isConst(func)) {
            if ((DF_constTabIndex(func)==constInd)&&(DF_appArity(tmPtr)==n)){
                AM_sreg   = DF_appArgs(tmPtr);    AM_writeFlag = OFF;
                AM_tysreg = DF_constType(func);   AM_tyWriteFlag = OFF;
                return;
            } else EM_THROW(EM_FAIL); //diff const head
        } //otherwise continue with the next case
    }
    case DF_TM_TAG_LAM: case DF_TM_TAG_SUSP: //and other APP cases
    {
        HN_hnorm(tmPtr);
        if (AM_rigFlag) {
            if (DF_isConst(AM_head) && (DF_constTabIndex(AM_head) == constInd)){
                if (AM_numAbs == (AM_numArgs + n)){
                    if (AM_numAbs == 0) {//first order app
                        AM_sreg   = AM_argVec;            AM_writeFlag   = OFF;
                        AM_tysreg = DF_constType(AM_head);AM_tyWriteFlag = OFF;
                    } else SINSTRL_delayTStr(tmPtr, constInd, n);//#abs > 0
                } else EM_THROW(EM_FAIL); //numArgs != numAbs + n
            } else EM_THROW(EM_FAIL); //non const rig head or diff const head
        } else {  //AM_rigFlag == OFF
            if (AM_numArgs == 0) {
                if ((AM_numArgs == 0) && 
                    (DF_fvUnivCount(AM_head) >= AM_cstUnivCount(constInd)))
                    SINSTRL_bindTStr(AM_head, constInd, n);
                else EM_THROW(EM_FAIL);
            } else SINSTRL_delayTStr(tmPtr, constInd, n);
        }         //AM_rigFlag == OFF
        return;
    }
    default:
    { //CONS, NIL, CONST, INT, FLOAT, STR, BV, (STREAM)
        EM_THROW(EM_FAIL);
    }
    } //switch
}
        
void SINSTR_get_list()                  //get_list Xi -- R_X
{
    INSACC_RX(regX);
    tmPtr = DF_termDeref((DF_TermPtr)regX);
    switch (DF_termTag(tmPtr)){
    case DF_TM_TAG_VAR:{ SINSTRL_bindCons(tmPtr); return; }
    case DF_TM_TAG_CONS: {AM_sreg=DF_consArgs(tmPtr); AM_writeFlag=OFF; return; }
    case DF_TM_TAG_APP: 
    {
        if (DF_isConst(DF_termDeref(DF_appFunc(tmPtr)))) EM_THROW(EM_FAIL);
	//otherwise continue with next case
    }
    case DF_TM_TAG_SUSP: //and other APP cases 
    { //Note ABS cannot arise here due to well-typedness
        HN_hnorm(tmPtr);
        if (AM_consFlag) { //#abs must be 0 and #args must be 2 due to type
            AM_sreg = AM_argVec; AM_writeFlag = OFF;
            return;
        } 
        if (AM_rigFlag) EM_THROW(EM_FAIL); //non cons rigid term
        //otherwise flex term with #abs being 0 (due to well-typedness)
        if (AM_numArgs == 0) SINSTRL_bindCons(AM_head); //fv
        else SINSTRL_delayCons(tmPtr);                 //higher-order
        return;
    }
    default: { EM_THROW(EM_FAIL); } //NIL, CONST, BV
    } //switch
}

/*************************************************************************/
/* UNIFY CLASS                                                           */
/*************************************************************************/
void SINSTR_unify_variable_t()          //unify_variable_t Xi -- R_X
{
    INSACC_RX(regX);
    if (AM_writeFlag) {
        DF_mkVar((MemPtr)AM_sreg, AM_adjreg);
        DF_mkRef((MemPtr)regX, AM_sreg);
    } else { //read mode
        if (DF_isFV(AM_sreg)) 
            DF_mkRef((MemPtr)regX, AM_sreg);
        else *regX = *((AM_DataTypePtr)AM_sreg);
    }
    AM_sreg++;
}

void SINSTR_unify_variable_p()          //unify_variable_p Yi -- E_X
{
    INSACC_EX(envY);
    if (AM_writeFlag) {
        DF_mkVar((MemPtr)AM_sreg, AM_adjreg);
        DF_mkRef((MemPtr)envY, AM_sreg);
    } else { //read mode
        if (DF_isFV(AM_sreg))
            DF_mkRef((MemPtr)envY, AM_sreg);
        else *envY = *((AM_DataTypePtr)AM_sreg);
    }
    AM_sreg++;
}

void SINSTR_unify_value_t()             //unify_value Xi -- R_X
{
    INSACC_RX(regX);
    if (AM_writeFlag) {
      if (AM_ocFlag) SINSTRL_bindSreg(DF_termDeref((DF_TermPtr)regX));
      else *((AM_DataTypePtr)AM_sreg) = *regX;

    } else  {
      HOPU_patternUnifyPair((DF_TermPtr)regX, AM_sreg);  //read mode
    }
    AM_sreg++;
}

void SINSTR_unify_value_p()             //unify_value Yi -- E_X
{
    INSACC_EX(envY);
    if (AM_writeFlag) {
        tmPtr = DF_termDeref((DF_TermPtr)envY);
        if (AM_ocFlag) SINSTRL_bindSreg(tmPtr);
        else {// AM_ocFlag == OFF
            if (AM_stackAddr((MemPtr)tmPtr)) { //needed?; in fact, what if a fv?
                //printf("unify_value_p -- stack addr\n");
                DF_copyAtomic(tmPtr, (MemPtr)AM_sreg);
            } else DF_mkRef((MemPtr)AM_sreg, tmPtr);
        }
    } else HOPU_patternUnifyPair((DF_TermPtr)envY, AM_sreg); //read mode
    AM_sreg++;
}

void SINSTR_unify_local_value_t()       //unify_local_value Xi -- R_X
{
    INSACC_RX(regX);
    if (AM_writeFlag){
        tmPtr = DF_termDeref((DF_TermPtr)regX);
        if (DF_isCons(tmPtr)) {
            *regX = *((AM_DataTypePtr)tmPtr);             //update reg Xi
            if (AM_ocFlag) SINSTRL_bindSreg(tmPtr);
            else DF_copyAtomic(tmPtr, (MemPtr)AM_sreg);
        } else { //tmPtr not cons
            if (AM_nHeapAddr((MemPtr)tmPtr)) { //then globalize and then bind
                if (DF_isConst(tmPtr)) { //must be a const without type assoc
                    if (AM_ocFlag && (DF_constUnivCount(tmPtr) > AM_adjreg))
                        EM_THROW(EM_FAIL);
                    DF_copyAtomic(tmPtr, (MemPtr)AM_sreg);//move the cst to heap
                    *regX = *((AM_DataTypePtr)tmPtr); //update reg Xi
                } else { //not const
                    if (DF_isFV(tmPtr)) {
                        TR_trailETerm(tmPtr);
                        if (AM_ocFlag && (DF_fvUnivCount(tmPtr) > AM_adjreg)){
                            DF_modVarUC(tmPtr, AM_adjreg);
                            AM_bndFlag = ON;
                        }
                        DF_copyAtomic(tmPtr, (MemPtr)AM_sreg);//move fv to heap
                        DF_mkRef((MemPtr)regX, AM_sreg);      //reg Xi
                        DF_mkRef((MemPtr)tmPtr, AM_sreg);     //env cell
                    } else {//INT, FLOAT, STR, (STREAM), NIL
                        DF_copyAtomic(tmPtr, (MemPtr)AM_sreg);//move to heap
                        *regX = *((AM_DataTypePtr)tmPtr); //update reg Xi
                    }
                }        //not const
            } else { //tmPtr is a heap address
                DF_mkRef((MemPtr)regX, tmPtr);  //update reg Xi
                if (AM_ocFlag) SINSTRL_bindSregH(tmPtr);
                else DF_mkRef((MemPtr)AM_sreg, tmPtr);
            }        //tmPtr is a heap address
        }       //tmPtr not cons
    } else HOPU_patternUnifyPair((DF_TermPtr)regX, AM_sreg); //read mode
    AM_sreg++;
}

void SINSTR_unify_local_value_p()       //unify_local_value Yi -- E_X
{
    INSACC_EX(envY);
    if (AM_writeFlag) {
        tmPtr = DF_termDeref((DF_TermPtr)envY);
        if (DF_isCons(tmPtr)) 
            if (AM_ocFlag) SINSTRL_bindSreg(tmPtr);
            else DF_copyAtomic(tmPtr, (MemPtr)AM_sreg);
        else { //tmPtr not cons
            if (AM_nHeapAddr((MemPtr)tmPtr)) { //then globalize and then bind
                if (DF_isConst(tmPtr)) { //must be a const without type assoc
                    if (AM_ocFlag && (DF_constUnivCount(tmPtr) > AM_adjreg))
                        EM_THROW(EM_FAIL);
                    DF_copyAtomic(tmPtr, (MemPtr)AM_sreg);
                } else { //not const
                    if (DF_isFV(tmPtr)) {
                        TR_trailETerm(tmPtr);
                        if (AM_ocFlag && (DF_fvUnivCount(tmPtr) > AM_adjreg)){
                            DF_modVarUC(tmPtr, AM_adjreg);
                            AM_bndFlag = ON;
                        }
                        DF_copyAtomic(tmPtr, (MemPtr)AM_sreg);//move fv to heap
                        DF_mkRef((MemPtr)tmPtr, AM_sreg);     //env cell
                    } else DF_copyAtomic(tmPtr, (MemPtr)AM_sreg); //I/F/STR/NIL
                }        //not const
            } else { //tmPtr is a heap address
                if (AM_ocFlag) SINSTRL_bindSregH(tmPtr);
                else DF_mkRef((MemPtr)AM_sreg, tmPtr);
            }        //tmPtr is a heap address
        }      //tmPtr not cons
    } else //read mode
        HOPU_patternUnifyPair((DF_TermPtr)envY, AM_sreg);
    AM_sreg++;
}

void SINSTR_unify_m_constant()          //unify_m_constant C -- C_X
{
    INSACC_CX(constInd);
    if (AM_writeFlag) {
        if (AM_ocFlag && (AM_adjreg < (uc = AM_cstUnivCount(constInd)))) 
            EM_THROW(EM_FAIL);
        DF_mkConst((MemPtr)AM_sreg, uc, constInd);
    } else { //read mode
        tmPtr = DF_termDeref(AM_sreg); 
        SINSTRL_unifyConst(tmPtr, constInd);
    }
    AM_sreg++;
}

void SINSTR_unify_p_constant()          //unify_p_constant C,L -- C_L_X 
{
    INSACC_CLX(constInd, label);
    if (AM_writeFlag) {
        if (AM_ocFlag && (AM_adjreg < (uc = AM_cstUnivCount(constInd))))
            EM_THROW(EM_FAIL);
        nhreg = AM_hreg + DF_TM_TCONST_SIZE;
        AM_heapError(nhreg + AM_cstTyEnvSize(constInd) * DF_TY_ATOMIC_SIZE);
        DF_mkTConst(AM_hreg, uc, constInd, (DF_TypePtr)nhreg);
        DF_mkRef((MemPtr)AM_sreg, (DF_TermPtr)AM_hreg);
        AM_hreg = nhreg;
        AM_tyWriteFlag = ON;
    } else {// read mode
        tmPtr = DF_termDeref(AM_sreg);
        SINSTRL_unifyTConst(tmPtr, constInd, label);
    }
    AM_sreg++;
}

void SINSTR_unify_integer()             //unify_integer i -- I_X
{
    INSACC_IX(intValue);
    if (AM_writeFlag) DF_mkInt((MemPtr)AM_sreg, intValue);
    else { //read mode
        tmPtr = DF_termDeref(AM_sreg);
        SINSTRL_unifyInt(tmPtr, intValue);
    }
    AM_sreg++;
}

void SINSTR_unify_float()               //unify_float f -- F_X
{
    INSACC_FX(floatValue);
    if (AM_writeFlag) DF_mkFloat((MemPtr)AM_sreg, floatValue);
    else { //read mode
        tmPtr = DF_termDeref(AM_sreg);
        SINSTRL_unifyFloat(tmPtr, floatValue);
    }
    AM_sreg++;
}

void SINSTR_unify_string()              //unify_string str -- S_X
{
    INSACC_SX(str);
    if (AM_writeFlag) DF_mkStr((MemPtr)AM_sreg, str);
    else { //read mode
        tmPtr = DF_termDeref(AM_sreg);
        SINSTRL_unifyString(tmPtr, str);
    }
    AM_sreg++;
}

void SINSTR_unify_nil()                 //unify_nil -- X
{
    INSACC_X();
    if (AM_writeFlag)  DF_mkNil((MemPtr)AM_sreg);
    else { // in read mode
        tmPtr = DF_termDeref(AM_sreg);
        SINSTRL_unifyNil(tmPtr);
    }
    AM_sreg++;
}

void SINSTR_unify_void()                //unify_void n -- I1_X
{
    INSACC_I1X(n);
    if (AM_writeFlag) {
        while (n > 0) {
            DF_mkVar((MemPtr)AM_sreg, AM_adjreg);
            AM_sreg++;
            n--;
        }
    } else AM_sreg += n;    
}
 
/*****************************************************************************/
/*   INSTRUCTIONS FOR UNIFYING AND CREATING TYPES                            */
/*****************************************************************************/
void SINSTR_put_type_variable_t()       //put_type_variable Xn,Ai -- R_R_X
{
    INSACC_RRX(regX, regA);
    nhreg = AM_hreg + DF_TY_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkFreeVarType(AM_hreg);
    *regA = *regX = *((AM_DataTypePtr)AM_hreg);
    AM_hreg = nhreg;
}

void SINSTR_put_type_variable_p()       //put_type_variable Yn,Ai -- E_R_X
{
    INSACC_ERX(envY, regA);
    DF_mkFreeVarType((MemPtr)envY);
    *regA = *envY;
}

void SINSTR_put_type_value_t()          //put_type_value Xn,Ai -- R_R_X
{
    INSACC_RRX(regX, regA);
    *regA = *((AM_DataTypePtr)DF_typeDeref((DF_TypePtr)regX));
}

void SINSTR_put_type_value_p()          //put_type_value Yn,Ai -- E_R_X  
{
    INSACC_ERX(envY, regA);
    *regA = *((AM_DataTypePtr)DF_typeDeref((DF_TypePtr)envY));
}

void SINSTR_put_type_unsafe_value()     //put_type_unsafe_value Yn,Ai -- E_R_X
{
    INSACC_ERX(envY, regA);
    tyPtr = DF_typeDeref((DF_TypePtr)envY);
    if (DF_isRefType(tyPtr) && AM_inCurEnv((MemPtr)tyPtr)){
        nhreg = AM_hreg + DF_TY_ATOMIC_SIZE;
        AM_heapError(nhreg);
        DF_mkFreeVarType(AM_hreg);
        TR_trailType(tyPtr);
        DF_mkRefType((MemPtr)tyPtr, (DF_TypePtr)AM_hreg);
        *regA = *((AM_DataTypePtr)tyPtr);
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else *regA = *((AM_DataTypePtr)tyPtr);
}


void SINSTR_put_type_const()            //put_type_const Ai,k -- R_K_X
{
    INSACC_RKX(regA, kindInd);
    DF_mkSortType((MemPtr)regA, kindInd);
}

void SINSTR_put_type_structure()        //put_type_structure Ai,k -- R_K_X
{
    INSACC_RKX(regA, kindInd);
    n = AM_kstArity(kindInd);
    nhreg = AM_hreg + DF_TY_ATOMIC_SIZE;
    AM_heapError(nhreg + n * DF_TY_ATOMIC_SIZE);
    DF_mkStrType((MemPtr)regA, (DF_TypePtr)AM_hreg);
    DF_mkStrFuncType(AM_hreg, kindInd, n);
    AM_hreg = nhreg;
}

void SINSTR_put_type_arrow()            //put_type_arrow Ai -- R_X
{
    INSACC_RX(regA);
    AM_heapError(AM_hreg + DF_TY_ATOMIC_SIZE * DF_TY_ARROW_ARITY);
    DF_mkArrowType((MemPtr)regA, (DF_TypePtr)AM_hreg);
}

/**********************************************************/
/* SET CLASS                                              */
/**********************************************************/
void SINSTR_set_type_variable_t()       //set_type_variable Xi -- R_X
{
    INSACC_RX(regX);
    DF_mkFreeVarType(AM_hreg);
    *regX = *((AM_DataTypePtr)AM_hreg);
    AM_hreg += DF_TY_ATOMIC_SIZE;    
}

void SINSTR_set_type_variable_p()       //set_type_variable Yi -- E_X
{
    INSACC_EX(envY);
    DF_mkFreeVarType(AM_hreg);
    *envY = *((AM_DataTypePtr)AM_hreg);
    AM_hreg += DF_TY_ATOMIC_SIZE;
}

void SINSTR_set_type_value_t()          //set_type_value Xi -- R_X
{
    INSACC_RX(regX);
    tyPtr = DF_typeDeref((DF_TypePtr)regX);
    DF_copyAtomicType(tyPtr, AM_hreg);
    AM_hreg += DF_TY_ATOMIC_SIZE;    
}
   
void SINSTR_set_type_value_p()          //set_type_value Yi -- E_X
{
    INSACC_EX(envY);
    tyPtr = DF_typeDeref((DF_TypePtr)envY);
    DF_copyAtomicType(tyPtr, AM_hreg);
    AM_hreg += DF_TY_ATOMIC_SIZE;    
}

void SINSTR_set_type_local_value_t()    //set_type_local_value Xi -- R_X
{
    INSACC_RX(regX);
    tyPtr = DF_typeDeref((DF_TypePtr)regX);
    if (DF_isRefType(tyPtr) && AM_stackAddr((MemPtr)tyPtr)){//fv on stack
        TR_trailType(tyPtr);
        DF_mkFreeVarType(AM_hreg);        
        DF_mkRefType((MemPtr)tyPtr, (DF_TypePtr)AM_hreg);
    } else  DF_copyAtomicType(tyPtr, AM_hreg);
    AM_hreg += DF_TY_ATOMIC_SIZE;
}

void SINSTR_set_type_local_value_p()    //set_type_local_value Yi -- E_X
{
    INSACC_EX(envY);
    tyPtr = DF_typeDeref((DF_TypePtr)envY);
    if (DF_isRefType(tyPtr) && AM_stackAddr((MemPtr)tyPtr)) {//fv on stack
        TR_trailType(tyPtr);
        DF_mkFreeVarType(AM_hreg);
        DF_mkRefType((MemPtr)tyPtr, (DF_TypePtr)AM_hreg);
    } else DF_copyAtomicType(tyPtr, AM_hreg);
    AM_hreg += DF_TY_ATOMIC_SIZE;
}

void SINSTR_set_type_constant()         //set_type_constant k -- K_X
{
    INSACC_KX(kindInd);
    DF_mkSortType(AM_hreg, kindInd);
    AM_hreg += DF_TY_ATOMIC_SIZE;
}

/**********************************************************/
/* GET CLASS                                              */
/**********************************************************/
void SINSTR_get_type_variable_t()       //get_type_variable Xn,Ai -- R_R_X
{
    INSACC_RRX(regX, regA);
    *regX = *regA;
}

void SINSTR_get_type_variable_p()       //get_type_variable Yn,Ai -- E_R_X
{
    INSACC_ERX(envY, regA);
    *envY = *regA;
}

void SINSTR_init_type_variable_t()      //init_type_variable Xn,Ym -- R_CE_X
{
    INSACC_RCEX(regX, clenvY);
    *regX = *((AM_DataTypePtr)DF_typeDeref((DF_TypePtr)clenvY));
}

void SINSTR_init_type_variable_p()      //init_type_variable Yn,Ym -- E_CE_X
{
    INSACC_ECEX(envY, clenvY);
    *envY = *((AM_DataTypePtr)DF_typeDeref((DF_TypePtr)clenvY));
}

void SINSTR_get_type_value_t()          //get_type_value Xn,Ai -- R_R_X
{
    INSACC_RRX(regX, regA);
    AM_pdlError(2);
    AM_initTypesPDL();
    AM_pushPDL((MemPtr)regX);
    AM_pushPDL((MemPtr)regA);
    TY_typesUnify();
}

void SINSTR_get_type_value_p()          //get_type_value Yn,Ai -- E_R_X
{
    INSACC_ERX(envY, regA);
    AM_pdlError(2);
    AM_initTypesPDL();
    AM_pushPDL((MemPtr)envY);
    AM_pushPDL((MemPtr)regA);
    TY_typesUnify();
}

void SINSTR_get_type_constant()         //get_type_constant Xi,k -- R_K_X
{
    INSACC_RKX(regX, kindInd);
    tyPtr = DF_typeDeref((DF_TypePtr)regX);
    if (DF_isRefType(tyPtr)) {
        TR_trailType(tyPtr);
        DF_mkSortType((MemPtr)tyPtr, kindInd);
        return;
    } 
    if (DF_isSortType(tyPtr) && (DF_typeKindTabIndex(tyPtr) == kindInd)) return;
    EM_THROW(EM_FAIL); //all other cases
}

void SINSTR_get_type_structure()        //get_type_structure Xi,k -- R_K_X
{
    INSACC_RKX(regX, kindInd);
    tyPtr = DF_typeDeref((DF_TypePtr)regX);
    if (DF_isRefType(tyPtr)) {
        nhreg = AM_hreg + DF_TY_ATOMIC_SIZE;
        n = AM_kstArity(kindInd);
        AM_heapError(nhreg + DF_TY_ATOMIC_SIZE * n);
        TR_trailType(tyPtr);
        DF_mkStrType((MemPtr)tyPtr, (DF_TypePtr)AM_hreg);
        DF_mkStrFuncType(AM_hreg, kindInd, n);
        AM_tyvbbreg = (DF_TypePtr)AM_hreg;
        AM_tyWriteFlag = ON;

        AM_hreg += DF_TY_ATOMIC_SIZE;
        return;
    } //else not ref
    if (DF_isStrType(tyPtr)) {
        tyPtr = DF_typeStrFuncAndArgs(tyPtr);
        if (DF_typeStrFuncInd(tyPtr) == kindInd) {
            AM_tysreg = DF_typeStrArgs(tyPtr);
            AM_tyWriteFlag = OFF;
            return;
        }
    }
    EM_THROW(EM_FAIL);
}

void SINSTR_get_type_arrow()            //get_type_arrow Xi -- R_X
{
    INSACC_RX(regX);
    tyPtr = DF_typeDeref((DF_TypePtr)regX);
    if (DF_isRefType(tyPtr)) {
        AM_heapError(nhreg + DF_TY_ATOMIC_SIZE * DF_TY_ARROW_ARITY);
        TR_trailType(tyPtr);
        DF_mkArrowType((MemPtr)tyPtr, (DF_TypePtr)AM_hreg);
        AM_tyvbbreg = (DF_TypePtr)AM_hreg;
        AM_tyWriteFlag = ON;
        return;
    } //else not ref
    if (DF_isArrowType(tyPtr)) {
        AM_tysreg = DF_typeArrowArgs(tyPtr);
        AM_tyWriteFlag = OFF;
        return;
    }
    EM_THROW(EM_FAIL);
}

/**********************************************************/
/* UNIFY CLASS                                            */
/**********************************************************/
void SINSTR_unify_type_variable_t()     //unify_type_variable Xi -- R_X
{
    INSACC_RX(regX);
    if (AM_tyWriteFlag) {
        DF_mkFreeVarType(AM_hreg);
        *regX = *((AM_DataTypePtr)AM_hreg);
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //read mode
        *regX = *((AM_DataTypePtr)AM_tysreg);
        AM_tysreg++;
    }
}

void SINSTR_unify_type_variable_p()     //unify_type_variable Yi -- E_X
{
    INSACC_EX(envY);
    if (AM_tyWriteFlag) {
        DF_mkFreeVarType(AM_hreg);
        *envY = *((AM_DataTypePtr)AM_hreg);
        AM_hreg += DF_TM_ATOMIC_SIZE;
    } else { //read mode
        *envY = *((AM_DataTypePtr)AM_tysreg);
        AM_tysreg++;
    }
}

void SINSTR_unify_type_value_t()         //unify_type_value Xi -- R_X
{
    INSACC_RX(regX);
    tyPtr = DF_typeDeref((DF_TypePtr)regX);
    if (AM_tyWriteFlag) {
        AM_pdlError(1);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        TY_typesOccC();
        DF_copyAtomicType(tyPtr, AM_hreg);
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //readmode
        AM_pdlError(2);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        AM_pushPDL((MemPtr)AM_tysreg);
        TY_typesUnify();
        AM_tysreg++;
    }
}

void SINSTR_unify_type_value_p()        //unify_type_value Yi -- E_X
{
    INSACC_EX(envY);
    tyPtr = DF_typeDeref((DF_TypePtr)envY);
    if (AM_tyWriteFlag) {
        AM_pdlError(1);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        TY_typesOccC();
        DF_copyAtomicType(tyPtr, AM_hreg);
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //readmode
        AM_pdlError(2);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        AM_pushPDL((MemPtr)AM_tysreg);
        TY_typesUnify();
        AM_tysreg++;
    }
}

void SINSTR_unify_envty_value_t()      //unify_envty_value Xi -- R_X
{
    INSACC_RX(regX);
    tyPtr = DF_typeDeref((DF_TypePtr)regX);
    if (AM_tyWriteFlag) {
        DF_copyAtomicType(tyPtr, AM_hreg);
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //readmode
        AM_pdlError(2);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        AM_pushPDL((MemPtr)AM_tysreg);
        TY_typesUnify();
        AM_tysreg++;
    }
}

void SINSTR_unify_envty_value_p()      //unify_envty_value Yi -- E_X
{
    INSACC_EX(envY);
    tyPtr = DF_typeDeref((DF_TypePtr)envY);
    if (AM_tyWriteFlag) {
        DF_copyAtomicType(tyPtr, AM_hreg);
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //readmode
        AM_pdlError(2);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        AM_pushPDL((MemPtr)AM_tysreg);
        TY_typesUnify();
        AM_tysreg++;
    }
}
 
void SINSTR_unify_type_local_value_t() //unify_type_local_value Xi -- R_X
{
    INSACC_RX(regX);
    tyPtr = DF_typeDeref((DF_TypePtr)regX);
    if (AM_tyWriteFlag) {
        if (DF_isRefType(tyPtr)) {
            if (AM_stackAddr((MemPtr)tyPtr)) {
                TR_trailType(tyPtr);
                DF_mkFreeVarType(AM_hreg);
                DF_mkRefType((MemPtr)tyPtr, (DF_TypePtr)AM_hreg);
                *regX = *((AM_DataTypePtr)tyPtr);
            } else DF_copyAtomicType(tyPtr, AM_hreg); //a heap address
        } else { //not free var type
            AM_pdlError(1);
            AM_initTypesPDL();
            AM_pushPDL((MemPtr)tyPtr);
            TY_typesOccC();
            DF_copyAtomicType(tyPtr, AM_hreg);
        }
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //readmode
        AM_pdlError(2);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        AM_pushPDL((MemPtr)AM_tysreg);
        TY_typesUnify();
        AM_tysreg++;
    }
}

void SINSTR_unify_type_local_value_p() //unify_type_local_value Yi -- E_X
{
    INSACC_EX(envY);
    tyPtr = DF_typeDeref((DF_TypePtr)envY);
    if (AM_tyWriteFlag) {
        if (DF_isRefType(tyPtr)) {
            if (AM_stackAddr((MemPtr)tyPtr)) {
                TR_trailType(tyPtr);
                DF_mkFreeVarType(AM_hreg);
                DF_mkRefType((MemPtr)tyPtr, (DF_TypePtr)AM_hreg);
            } else DF_copyAtomicType(tyPtr, AM_hreg);
        } else { //not free var type
            AM_pdlError(1);
            AM_initTypesPDL();
            AM_pushPDL((MemPtr)tyPtr);
            TY_typesOccC();
            DF_copyAtomicType(tyPtr, AM_hreg);
        }
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //readmode
        AM_pdlError(2);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        AM_pushPDL((MemPtr)AM_tysreg);
        TY_typesUnify();
        AM_tysreg++;
    }
}

void SINSTR_unify_envty_local_value_t() //unify_envty_local_value Xi -- R_X
{
    INSACC_RX(regX);
    tyPtr = DF_typeDeref((DF_TypePtr)regX);
    if (AM_tyWriteFlag) {
        if (DF_isRefType(tyPtr) && (AM_stackAddr((MemPtr)tyPtr))) {
            TR_trailType(tyPtr);
            DF_mkFreeVarType(AM_hreg);
            DF_mkRefType((MemPtr)tyPtr, (DF_TypePtr)AM_hreg);
            *regX = *((AM_DataTypePtr)tyPtr);
        } else DF_copyAtomicType(tyPtr, AM_hreg);
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //read mode
        AM_pdlError(2);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        AM_pushPDL((MemPtr)AM_tysreg);
        TY_typesUnify();
        AM_tysreg++;
    }
}

void SINSTR_unify_envty_local_value_p() //unify_envty_local_value Yi -- E_X
{
    INSACC_EX(envY);
    tyPtr = DF_typeDeref((DF_TypePtr)envY);
    if (AM_tyWriteFlag) {
        if (DF_isRefType(tyPtr) && (AM_stackAddr((MemPtr)tyPtr))) {
            TR_trailType(tyPtr);
            DF_mkFreeVarType(AM_hreg);
            DF_mkRefType((MemPtr)tyPtr, (DF_TypePtr)AM_hreg);
        } else DF_copyAtomicType(tyPtr, AM_hreg);
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //read mode
        AM_pdlError(2);
        AM_initTypesPDL();
        AM_pushPDL((MemPtr)tyPtr);
        AM_pushPDL((MemPtr)AM_tysreg);
        TY_typesUnify();
        AM_tysreg++;
    }
}

void SINSTR_unify_type_constant()       //unify_type_constant k -- K_X
{
    INSACC_KX(kindInd);
    if (AM_tyWriteFlag) {
        DF_mkSortType(AM_hreg, kindInd);
        AM_hreg += DF_TY_ATOMIC_SIZE;
    } else { //read mode
        tyPtr = DF_typeDeref(AM_tysreg);
        AM_tysreg++;
        if (DF_isRefType(tyPtr)) {
            TR_trailType(tyPtr);
            DF_mkSortType((MemPtr)tyPtr, kindInd);
            return;
        } //otherwise not ref
        if (DF_isSortType(tyPtr) && (DF_typeKindTabIndex(tyPtr) == kindInd))
            return;
        EM_THROW(EM_FAIL);
    }
}

/* init type var for implication goal */
void SINSTR_create_type_variable()      //create_type_variable Yi -- E_X
{
    INSACC_EX(envY);
    DF_mkFreeVarType((MemPtr)envY);
}
    
/*****************************************************************************/
/*   HIGHER-ORDER INSTRUCTIONS                                               */
/*****************************************************************************/
void SINSTR_pattern_unify_t()           //pattern_unify Xi,Aj -- R_R_X
{
    INSACC_RRX(regX, regA);
    HOPU_patternUnifyPair((DF_TermPtr)regX, (DF_TermPtr)regA);
}

void SINSTR_pattern_unify_p()           //pattern_unify Yi,Aj -- E_R_X
{
    INSACC_ERX(envY, regA);
    HOPU_patternUnifyPair((DF_TermPtr)envY, (DF_TermPtr)regA);
}

void SINSTR_finish_unify()              //finish_unify -- X
{
    INSACC_X();
    HOPU_patternUnify();
}

void SINSTR_head_normalize_t()          //head_normalize Xi -- R_X
{
    INSACC_RX(regX);
    HN_hnorm((DF_TermPtr)regX); //no need to deref (hnorm takes care of it)
}

void SINSTR_head_normalize_p()          //head_normalize Yi -- E_X
{
    INSACC_EX(envY);
    HN_hnorm((DF_TermPtr)envY); //no need to deref (hnorm takes care of it)
}

/*****************************************************************************/
/*   LOGICAL INSTRUCTIONS                                                    */
/*****************************************************************************/
void SINSTR_incr_universe()             //incr_universe -- X
{
    INSACC_X();
    AM_ucError(AM_ucreg);
    AM_ucreg++;
}

void SINSTR_decr_universe()             //decr_universe -- X
{
    INSACC_X();
    AM_ucreg--;
}

void SINSTR_set_univ_tag()              //set_univ_tag Yi,c -- E_C_X
{
    INSACC_ECX(envY, constInd);
    DF_mkConst((MemPtr)envY, AM_ucreg, constInd);
}

void SINSTR_tag_exists_t()              //tag_exists Xi -- R_X
{
    INSACC_RX(regX);
    nhreg = AM_hreg + DF_TM_ATOMIC_SIZE;
    AM_heapError(nhreg);
    DF_mkVar(AM_hreg, AM_ucreg);
    DF_mkRef((MemPtr)regX, (DF_TermPtr)AM_hreg);
    AM_hreg = nhreg;
}

void SINSTR_tag_exists_p()              //tag_exists Yi -- E_X
{
    INSACC_EX(envY);
    DF_mkVar((MemPtr)envY, AM_ucreg);
}

void SINSTR_tag_variable()              //tag_variable Yi -- E_X
{
    INSACC_EX(envY);
    DF_mkVar((MemPtr)envY, AM_envUC());    
}

void SINSTR_push_impl_point()           //put_impl_point n,t -- I1_IT_X
{
    INSACC_I1ITX(n, impTab);
    m = MEM_implLTS(impTab);
    ip = AM_findtos(n) + AM_NCLT_ENTRY_SIZE * m;
    AM_tosreg = ip + AM_IMP_FIX_SIZE;
    AM_stackError(AM_tosreg);
    AM_mkImplRec(ip, MEM_implPST(impTab, m), MEM_implPSTS(impTab),
                 MEM_implFC(impTab));
    if (m > 0) AM_mkImpNCLTab(ip, MEM_implLT(impTab), m);
    AM_ireg = ip;
}

void SINSTR_pop_impl_point()            //pop_impl_point -- X
{
    INSACC_X();
    AM_ireg = AM_curimpPIP();
    AM_settosreg();
}

void SINSTR_add_imports()               //add_imports n,m,L -- SEG_I1_L_X 
{
    INSACC_SEGI1LX(n, m, label);
    bckfd = AM_cimpBCK(n);
    l = AM_impBCKNo(bckfd);
    if (AM_breg > AM_impBCKMRCP(bckfd)) TR_trailImport(bckfd);
    AM_setBCKNo(bckfd, l+1);
    AM_setBCKMRCP(bckfd, AM_breg);
    if (l > 0) AM_preg = label;
    else AM_tosreg = AM_findtos(m);
}

void SINSTR_remove_imports()            //remove_imports n,L -- SEG_L_X
{
    INSACC_SEGLX(n, label);
    bckfd = AM_cimpBCK(n);
    l = AM_impBCKNo(bckfd);
    if (AM_breg > AM_impBCKMRCP(bckfd)) TR_trailImport(bckfd);
    AM_setBCKNo(bckfd, l-1);
    AM_setBCKMRCP(bckfd, AM_breg);
    if (l > 1) AM_preg = label;
}

void SINSTR_push_import()               //push_import t -- MT_X
{
    INSACC_MTX(impTab);
    n = MEM_impNCSEG(impTab);      // n = # code segs (# bc field)
    m = MEM_impLTS(impTab);        // m = link tab size
    l = AM_NCLT_ENTRY_SIZE * m;    // l = space for next clause table
    ip = AM_tosreg + (AM_BCKV_ENTRY_SIZE * n) + l;
    AM_tosreg = ip + AM_IMP_FIX_SIZE;
    AM_stackError(AM_tosreg);
    if (n > 0) AM_initBCKVector(ip, l, n);
    n = MEM_impNLC(impTab);        // reuse n as the number of local consts
    if (n > 0) {
        AM_mkImptRecWL(ip, m, MEM_impPST(impTab, m, n), MEM_impPSTS(impTab),
                       MEM_impFC(impTab));
        AM_ucError(AM_ucreg);
        AM_ucreg++;
        AM_initLocs(n, MEM_impLCT(impTab, m));
    } else AM_mkImptRecWOL(ip, m, MEM_impPST(impTab, m, n), MEM_impPSTS(impTab),
                           MEM_impFC(impTab));
    if (m > 0) AM_mkImpNCLTab(ip, MEM_impLT(impTab), m);
    AM_ireg = ip;
}

void SINSTR_pop_imports()               //pop_imports n -- I1_X
{
    INSACC_I1X(n);
    for (; n > 0; n--){
        if (AM_isCurImptWL()) AM_ucreg--;
        AM_ireg = AM_curimpPIP();
    }
    AM_settosreg();
}

/*****************************************************************************/
/*   CONTROL INSTRUCTIONS                                                    */
/*****************************************************************************/
void SINSTR_allocate()                  //allocate n -- I1_X
{
    INSACC_I1X(n);
    ep = AM_findtosEnv() + AM_ENV_FIX_SIZE;
    AM_stackError(ep + AM_DATA_SIZE * n);
    AM_ereg = AM_mkEnv(ep);
}

void SINSTR_deallocate()                //deallocate -- X
{
    INSACC_X();
    AM_cpreg = AM_envCP();
    AM_ereg  = AM_envCE();
}

void SINSTR_call()                      //call n,L -- I1_L_X
{
    AM_cpreg = AM_preg + INSTR_I1LX_LEN; //next instruction
    AM_cereg = AM_ereg;
    AM_b0reg = AM_breg;
    AM_preg  = *((INSTR_CodeLabel *)(AM_preg + INSTR_I1LX_L));
}

void SINSTR_call_name()                 //call_name n,c -- I1_C_WP_X
{
    INSACC_I1CWPX_C(constInd);
    AM_findCode(constInd, &cl, &ip);
    if (cl) {
        AM_cpreg = (AM_preg + INSTR_I1CWPX_LEN); // next instr
        AM_b0reg = AM_breg;
        AM_preg  = cl;
        AM_cireg = ip;
        if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    } else EM_THROW(EM_FAIL);
}

void SINSTR_execute()                   //execute label -- L_X
{
    INSACC_LX();        //AM_preg has been set to label 
    AM_b0reg = AM_breg;
}

void SINSTR_execute_name()              //execute_name c -- C_WP_X
{
    INSACC_CWPX(constInd);
    AM_findCode(constInd, &cl, &ip);
    if (cl) {
        AM_b0reg = AM_breg;
        AM_preg  = cl;
        AM_cireg = ip;
        if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    } else EM_THROW(EM_FAIL);
}

void SINSTR_proceed()                   //proceed -- X
{   
   /* We use a nonlocal procedure exit to get back to the toplevel
      when a query has a result.  We do this so that we don't have to
      return values from instruction functions, and we don't have to
      do any checks in the simulator loop.  We use the exception
      mechanism to acheive our nonlocal exit. */
    if (AM_noEnv()) EM_THROW(EM_QUERY_RESULT);
    else {
        AM_preg  = AM_cpreg;
        AM_cireg = AM_envCI();
        if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    }
}

/*****************************************************************************/
/*   CHOICE INSTRUCTIONS                                                     */
/*****************************************************************************/
void SINSTR_try_me_else()               //try_me_else n,lab -- I1_L_X
{
    INSACC_I1LX(n, label);
    AM_tosreg = (MemPtr)((AM_DataTypePtr)(AM_findtosEnv() + AM_CP_FIX_SIZE)+n);
    AM_stackError(AM_tosreg);
    cp = AM_tosreg - 1;
    AM_mkCP(cp, label, n);
    AM_breg = cp;
    AM_hbreg = AM_hreg;
}

void SINSTR_retry_me_else()             //retry_me_else n,lab -- I1_L_X
{
    INSACC_I1LX(n, label);
    AM_restoreRegs(n);
    AM_hbreg = AM_hreg;
    if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    AM_setNClCP(label);
}

void SINSTR_trust_me()                  //trust_me n -- I1_WP_X
{
    INSACC_I1WPX(n);
    AM_restoreRegs(n);
    if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    AM_breg = AM_cpB();
    AM_hbreg = AM_cpH();
    AM_settosreg();
}

void SINSTR_try()                	    //try n,label -- I1_L_X 
{
    INSACC_I1LX_I1(n);
    AM_tosreg = (MemPtr)((AM_DataTypePtr)(AM_findtosEnv() + AM_CP_FIX_SIZE)+n);
    AM_stackError(AM_tosreg);
    cp = AM_tosreg - 1;
    AM_mkCP(cp, (AM_preg + INSTR_I1LX_LEN), n);
    AM_breg = cp;
    AM_hbreg = AM_hreg;
    AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_I1LX_L));
}

void SINSTR_retry()                     //retry n,label -- I1_L_X
{
    INSACC_I1LX_I1(n);
    AM_restoreRegs(n);
    AM_hbreg = AM_hreg;
    if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    AM_setNClCP(AM_preg + INSTR_I1LX_LEN);
    AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_I1LX_L));
}

void SINSTR_trust()                     //trust n,label -- I1_L_WP_X
{
    INSACC_I1LWPX_I1(n);
    AM_restoreRegs(n);
    if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    AM_breg = AM_cpB();
    AM_hbreg = AM_cpH();
    AM_settosreg();
    AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_I1LWPX_L));
}

void SINSTR_trust_ext()                 //trust_ext n,m -- I1_N_X
{
    INSACC_I1NX(n, m);
    nextcl = AM_impNCL(AM_cpCI(), m);    
    AM_preg = AM_impNCLCode(nextcl);
    
    if (AM_isFailInstr(AM_preg)) {
        AM_breg = AM_cpB();
        AM_settosreg();
        EM_THROW(EM_FAIL);
    }
    AM_restoreRegsWoCI(n);
    AM_cireg = AM_impNCLIP(nextcl);
    if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    AM_breg = AM_cpB();
    AM_hbreg = AM_cpH();
    AM_settosreg();
}

void SINSTR_try_else()                  //try_else n,lab1,lab2 -- I1_L_L_X
{
    INSACC_I1LLX(n, label); //AM_preg has been set
    AM_tosreg = (MemPtr)((AM_DataTypePtr)(AM_findtosEnv() + AM_CP_FIX_SIZE)+n);
    AM_stackError(AM_tosreg);
    cp = AM_tosreg - 1;
    AM_mkCP(cp, label, n);
    AM_breg = cp;
    AM_hbreg = AM_hreg;
}

void SINSTR_retry_else()                //retry_else n,lab1,lab2 -- I1_L_L_X
{
    INSACC_I1LLX(n, label); //AM_preg has been set
    AM_restoreRegs(n);
    AM_hbreg = AM_hreg;
    if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    AM_setNClCP(label);
}

void SINSTR_branch()                    //branch lab -- L_X
{
    INSACC_LX(); //AM_preg has been set to label
}


/*****************************************************************************/
/*   INDEXING INSTRUCTIONS                                                   */
/*****************************************************************************/
void SINSTR_switch_on_term()          //switch_on_term lv,lc,ll,lbv --L_L_L_L_X
{   
    regA = AM_reg(1);
    tmPtr = DF_termDeref((DF_TermPtr)regA);
    numAbs = 0;
    while (DF_isLam(tmPtr)) {
        numAbs += DF_lamNumAbs(tmPtr);
        tmPtr = DF_termDeref(DF_lamBody(tmPtr));
    }
    if (DF_isCons(tmPtr)) {
        AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LLLLX_L3));
        return;
    } else {
        if (DF_isApp(tmPtr))  tmPtr = DF_termDeref(DF_appFunc(tmPtr));
        if (DF_isNAtomic(tmPtr)) {
            HN_hnorm(tmPtr);
            numAbs += AM_numAbs;
            tmPtr = AM_head;
        }
        switch (DF_termTag(tmPtr)) {
        case DF_TM_TAG_VAR:   { 
            AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LLLLX_L1));
            return;                  
        }
        case DF_TM_TAG_CONST: {
            tablInd = DF_constTabIndex(tmPtr); 
            AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LLLLX_L2));
            return;
        }    
        case DF_TM_TAG_INT:   { 
            tablInd = PERV_INTC_INDEX; 
            AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LLLLX_L2));
            return;
        }
        case DF_TM_TAG_FLOAT: {
            tablInd = PERV_REALC_INDEX;
            AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LLLLX_L2));
            return;
        }
        case DF_TM_TAG_STR:   {
            tablInd = PERV_STRC_INDEX;
            AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LLLLX_L2));
            return;
        }
        case DF_TM_TAG_NIL:   {
            tablInd = PERV_NIL_INDEX;
            AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LLLLX_L2));
            return;
        }
        case DF_TM_TAG_STREAM:{ EM_THROW(EM_FAIL); }
        case DF_TM_TAG_CONS:  {
             AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LLLLX_L3));
             return; 
        }
        case DF_TM_TAG_BVAR:   
        {
            numAbs = numAbs - DF_bvIndex(tmPtr); 
            AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LLLLX_L4));
            return;
        }
        }
    }
}

void SINSTR_switch_on_constant()        //switch_on_constant n,tab -- I1_HT_X
{
    INSACC_I1HTX(n, table);
    cl = LD_SEARCHTAB_HashSrch(tablInd, n, table);
    if (cl) {
        AM_preg = cl;
        return;
    } else EM_THROW(EM_FAIL);
}

void SINSTR_switch_on_bvar()            //switch_on_bvar n,tab -- I1_BVT_X
{
    INSACC_I1BVTX(n, table);
    for (m = 0; m != n; m++) 
        if ((numAbs = MEM_branchTabIndexVal(table, m))) break;
    if (m < n) AM_preg = MEM_branchTabCodePtr(table, m);
    else EM_THROW(EM_FAIL);
}

void SINSTR_switch_on_reg()             //switch_on_reg n,SL1,FL2 -- N_L_L_X
{
    INSACC_NLLX_N(n);
    nextcl = AM_impNCL(AM_cireg, n);
    if (AM_isFailInstr(AM_impNCLCode(nextcl))){
      AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_NLLX_L2));}
    else {
      AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_NLLX_L1));
    }
}

/*****************************************************************************/
/*   CUT INSTRUCTIONS                                                        */
/*****************************************************************************/
void SINSTR_neck_cut()                  //neck_cut -- X
{
    INSACC_X();
    AM_breg = AM_b0reg;
    AM_hbreg = AM_cpH();
    AM_settosreg();
}

void SINSTR_get_level()                 //get_level Yn -- E_X
{
    INSACC_EX(envY);
    *((MemPtr *)envY) = AM_b0reg;
}

void SINSTR_put_level()                 //put_level Yn -- E_X
{
    INSACC_EX(envY);
    AM_b0reg = *((MemPtr *)envY);
}

void SINSTR_cut()                       //cut Yn -- E_X
{
    INSACC_EX(envY);
    AM_breg = *((MemPtr *)envY);
    AM_hbreg = AM_cpH();
    AM_settosreg();
}

/*****************************************************************************/
/*   MISCELLANEOUS INSTRUCTIONS                                              */
/*****************************************************************************/
void SINSTR_call_builtin()              //call_builtin n -- I1_WP_X
{
    INSACC_I1I1WPX(n);
    AM_cpreg = AM_preg;
    BI_dispatch(n);
}

void SINSTR_builtin()                   //builtin n -- I1_X
{
    INSACC_I1X(n);
    if (!AM_noEnv()) {
        AM_cireg = AM_envCI();
        if (AM_isImplCI()) AM_cereg = AM_cimpCE();
    }
    BI_dispatch(n);
}

void SINSTR_stop()                      //stop -- X
{
    EM_THROW(EM_TOP_LEVEL);
}

void SINSTR_halt()                      //halt -- X
{
    EM_THROW(EM_EXIT);
}

void SINSTR_fail()                      //fail -- X
{
    EM_THROW(EM_FAIL);
}


/**************************************************************************/
/*       linker only                                                      */
/**************************************************************************/
void SINSTR_execute_link_only()
{
  EM_THROW(EM_ABORT);
}

void SINSTR_call_link_only()
{
  EM_THROW(EM_ABORT);
}


#endif //SIMINSTR_C
