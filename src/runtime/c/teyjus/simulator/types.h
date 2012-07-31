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
/*  File types.h. This header file identifies the routines defined in       */
/*  types.c that are exported from there. These routines implement          */
/*  operations on types, in particular the interpretive unification on      */
/*  types. These operations are typically needed in the simulator           */
/*  (simulator.c) and higher-order pattern unification (houp.c).            */
/*                                                                          */
/****************************************************************************/
#ifndef TYPES_H
#define TYPES_H

void TY_typesUnify();                       //interpretive unification on types
void TY_pushPairsToPDL(MemPtr, MemPtr, int);//push n pairs of types to PDL

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
void TY_typesOccC();                        

#endif //TYPES_H
