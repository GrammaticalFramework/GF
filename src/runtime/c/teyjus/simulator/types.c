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
/*  File types.c. This file contains routines implementing the interpretive */
/*  part of type unification including those needed within (interpretive)   */
/*  higher-order pattern unification.                                       */
/*                                                                          */
/****************************************************************************/
#ifndef TYPES_C
#define TYPES_C

#include "dataformats.h"
#include "abstmachine.h"
#include "trail.h"
#include "../system/error.h" 

/* Push n types onto PDL                                           */
static void TY_pushTypesToPDL(MemPtr tyPtr, int n)
{
    AM_pdlError(n);
    n--; tyPtr += n * DF_TY_ATOMIC_SIZE;  //start from the nth type
    for (; n >= 0; n--) { AM_pushPDL(tyPtr); tyPtr -= DF_TY_ATOMIC_SIZE; }
}

/* Push n pair of types onto PDL.                                  */
void TY_pushPairsToPDL(MemPtr tyPtr1, MemPtr tyPtr2, int n)
{
    AM_pdlError(2*n);
    n--; tyPtr1 += n * DF_TY_ATOMIC_SIZE; tyPtr2 += n * DF_TY_ATOMIC_SIZE;
    for (; n >= 0; n--){ //start from the nth pair
        AM_pushPDL(tyPtr1); tyPtr1 -= DF_TY_ATOMIC_SIZE;
        AM_pushPDL(tyPtr2); tyPtr2 -= DF_TY_ATOMIC_SIZE;
    }
}

/* Perform occurs check for the type variable currently referred to by
   AM_tyvbbreg over the type on the current top of PDL.
*/
static void TY_typesOcc()
{
    DF_TypePtr tyPtr;   // current type structure being examined
    MemPtr     pdlBotTmp = AM_pdlTop - 1; //tmp PDL 
    while (AM_pdlTop > pdlBotTmp){
        tyPtr = DF_typeDeref((DF_TypePtr)AM_popPDL());
        switch (DF_typeTag(tyPtr)){
        case DF_TY_TAG_REF: {
            if (AM_tyvbbreg == tyPtr) EM_THROW(EM_FAIL);
            break;
        }
        case DF_TY_TAG_SORT: break;
        case DF_TY_TAG_STR: {
            DF_TypePtr fPtr = DF_typeStrFuncAndArgs(tyPtr);
            TY_pushTypesToPDL((MemPtr)DF_typeStrArgs(fPtr), 
                              DF_typeStrFuncArity(fPtr));
            break;
        }
        case DF_TY_TAG_ARROW: {
            TY_pushTypesToPDL((MemPtr)DF_typeArrowArgs(tyPtr), 
                              DF_TY_ARROW_ARITY);
            break;
        }
        } //switch
    } //while (AM_pdlTop > pdlBotTmp
}    


/* Bind two free variables. The one with higher address is updated. */
static void TY_bindVars(DF_TypePtr varPtr1, DF_TypePtr varPtr2)
{
    if (varPtr2 < varPtr1){
        TR_trailType(varPtr1);
        DF_copyAtomicType(varPtr2, (MemPtr)varPtr1);
    } else {
        TR_trailType(varPtr2);
        DF_copyAtomicType(varPtr1, (MemPtr)varPtr2);
    }
}

/* Bind a variable to a type. Note occurs-check is performed.       */
static void TY_bind(DF_TypePtr varPtr, DF_TypePtr tyPtr)
{
    AM_pdlError(1);
    AM_pushPDL((MemPtr)tyPtr);
    AM_tyvbbreg = varPtr;      //type variable being bound
    TY_typesOcc();
    TR_trailType(varPtr);
    DF_copyAtomicType(tyPtr, (MemPtr)varPtr);
}        

/* The main routine for interpretive type unification. The assumption is 
   that the pair of types are referred from the top two cells in the PDL
   stack.
*/
void TY_typesUnify()
{
    DF_TypePtr tyPtr1, tyPtr2;
    
    while (AM_nemptyTypesPDL()){
        tyPtr2 = DF_typeDeref((DF_TypePtr)AM_popPDL());
        tyPtr1 = DF_typeDeref((DF_TypePtr)AM_popPDL());
        if (tyPtr1 != tyPtr2) {         //not referring to the same mem location
            if (DF_isRefType(tyPtr1))
                if (DF_isRefType(tyPtr2)) TY_bindVars(tyPtr1, tyPtr2);
                else TY_bind(tyPtr1, tyPtr2);
            else { //tyPtr1 is not reference
                switch (DF_typeTag(tyPtr2)){
                case DF_TY_TAG_REF:  {  TY_bind(tyPtr2, tyPtr1); break; }
                case DF_TY_TAG_SORT: {
                if (!(DF_isSortType(tyPtr1) &&  
                      DF_typeKindTabIndex(tyPtr1)==DF_typeKindTabIndex(tyPtr2)))
                    EM_THROW(EM_FAIL);
                break;
                }
                case DF_TY_TAG_ARROW:{
                if (!DF_isArrowType(tyPtr1)) EM_THROW(EM_FAIL);
                TY_pushPairsToPDL((MemPtr)DF_typeArrowArgs(tyPtr1),
                                  (MemPtr)DF_typeArrowArgs(tyPtr2), 
                                  DF_TY_ARROW_ARITY);
                break;
                }
                case DF_TY_TAG_STR:  {
                if (DF_isStrType(tyPtr1)){
                    DF_TypePtr fPtr1 = DF_typeStrFuncAndArgs(tyPtr1),
                               fPtr2 = DF_typeStrFuncAndArgs(tyPtr2);
                    if (DF_typeStrFuncInd(fPtr1) == DF_typeStrFuncInd(fPtr2))
                        TY_pushPairsToPDL((MemPtr)DF_typeStrArgs(fPtr1),
                                          (MemPtr)DF_typeStrArgs(fPtr2),
                                          DF_typeStrFuncArity(fPtr1));
                    else EM_THROW(EM_FAIL); //different function
                } else EM_THROW(EM_FAIL); //tyPtr1 not str or ref
                break;
                }
                } //switch
            } //tyPtr1 not ref
        } //tyPtr1 != tyPtr2
    } //while (AM_nemptyTypesPDL())
}


/*****************************************************************************
 *  Occurs check over types. This version is used when the check has to be   *
 *  performed within the compiled form of unification. In particular, this   *
 *  routine would be invoked from within the unify_type_value class of       *
 *  instructions in read mode. The peculiarity of this situation is that the *
 *  binding of the relevant type variable would have been started already by *
 *  a get_type_structure or get_type_arrow instruction, so we have to check  *
 *  for the occurrence of the structure created as a consequence of this     *
 *  rather than for a variable occurrence.                                   *
 *****************************************************************************/
void TY_typesOccC()
{
    DF_TypePtr tyPtr;
    while (AM_nemptyTypesPDL()){
        tyPtr = DF_typeDeref((DF_TypePtr)AM_popPDL());
        switch (DF_typeTag(tyPtr)) {
        case DF_TY_TAG_REF: case DF_TY_TAG_SORT: break;
        case DF_TY_TAG_STR: 
        {
            DF_TypePtr fPtr = DF_typeStrFuncAndArgs(tyPtr);
            if (AM_tyvbbreg == fPtr) EM_THROW(EM_FAIL);
            TY_pushTypesToPDL((MemPtr)DF_typeStrArgs(fPtr),
                              DF_typeStrFuncArity(fPtr));
            break;
        }
        case DF_TY_TAG_ARROW: 
        {
            DF_TypePtr args = DF_typeArrowArgs(tyPtr);
            if (AM_tyvbbreg == args) EM_THROW(EM_FAIL);
            TY_pushTypesToPDL((MemPtr)args, DF_TY_ARROW_ARITY);
            break;
        }
        } //switch
    } //while
}

#endif //TYPES_C
