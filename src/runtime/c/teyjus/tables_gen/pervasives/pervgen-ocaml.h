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
/* File pervgen-ocaml.c. This files contains function definitions for        */
/* generating files pervasive.mli and pervasive.ml.                          */
/*****************************************************************************/
#include "op.h"
#include "types.h"
#include "../util/util.h"

/**************************************************************************/
/* generating pervasive kind relevant part                                */
/**************************************************************************/
void ocamlGenNumKinds(char* number);
void ocamlGenKind(char* kindName, char* kVarName, char* arity, char* offset);
void ocamlGenKinds();

/**************************************************************************/
/* generating pervasive type skeleton relevant part                       */
/**************************************************************************/
void ocamlGenTySkel(char* ind, Type tySkel);

/**************************************************************************/
/* generating pervasive constants relevant part                           */
/**************************************************************************/
void ocamlGenNumConsts(char* number);
void ocamlGenConst(char* ind, char* name, char* cVarName, OP_Fixity fixity, 
                   OP_Prec prec, UTIL_Bool tyPrev, UTIL_Bool redef, int tesize,
                   int tyskelInd, int neededness, OP_Code codeInfo, 
                   char* offset, char* printName);

void ocamlGenConsts();

void ocamlCollectConsts(char* name, int last);

void ocamlGenRC();
void ocamlGenBC();
/***************************************************************************/
/* Dump code into pervasive.ml and pervasive.mli                           */
/***************************************************************************/
/* dump peravsive.ml   */
void spitOCPervasiveML(char * root);
/* dump peravsive.mli   */
void spitOCPervasiveMLI(char * root);


