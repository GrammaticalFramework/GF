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
#ifndef OPERATORS_H
#define OPERATORS_H

//#include <limits.h>

/* Fixity types */
typedef  enum 
{ 
    OP_INFIX    = 0, 
    OP_INFIXL   = 1, 
    OP_INFIXR   = 2,            
    OP_NONE     = 3, 
    OP_PREFIX   = 4, 
    OP_PREFIXR  = 5, 
    OP_POSTFIX  = 6, 
    OP_POSTFIXL = 7 
} OP_FixityType;


typedef  enum {
    OP_WHOLE_TERM,
    OP_LEFT_TERM,
    OP_RIGHT_TERM
} OP_TermContext;

#define  OP_MAXPREC        255 
#define  OP_MINPREC        0

#define  OP_LAM_FIXITY     OP_PREFIXR
#define  OP_LAM_PREC       -1

#define  OP_APP_FIXITY     OP_INFIXL
#define  OP_APP_PREC       257 

//usful ?
/*
#define  OP_CCOMMA_FIXITY  OP_infixr
#define  OP_CCOMMA_PREC    -2





#define  OP_LT_FIXITY      OP_infix
#define  OP_LT_PREC        130

#define  OP_LE_FIXITY      OP_infix
#define  OP_LE_PREC        130

#define  OP_GT_FIXITY      OP_infix
#define  OP_GT_PREC        130

#define  OP_GE_FIXITY      OP_infix
#define  OP_GE_PREC        130

#define  OP_UM_FIXITY      OP_prefix
#define  OP_UM_PREC        256 //?

#define  OP_PLUS_FIXITY    OP_infixl
#define  OP_PLUS_PREC      150

#define  OP_MINUS_FIXITY   OP_infixl
#define  OP_MINUS_PREC     150

#define  OP_TIMES_FIXITY   OP_infixl
#define  OP_TIMES_PREC     160

#define  OP_COMMA_FIXITY   OP_infixl
#define  OP_COMMA_PREC     110
*/

#endif // OPERATORS_H
