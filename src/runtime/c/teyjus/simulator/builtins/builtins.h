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
/* File builtins.h. This files defines the indexes of the builtin table, and */
/* provides signature for the function indexing into the builtin table and   */
/* invokes the appropriate function.                                         */
/*****************************************************************************/ 

#ifndef BUILTINS_H
#define BUILTINS_H

#include "../../system/error.h"

/***********************************************************************/
/*             Builtin Dispatch Table Index                            */
/***********************************************************************/
typedef enum
{
    BI_SOLVE          = 0,
    BI_EVAL           = 1,
    BI_NOT            = 2,
    BI_UNIFY          = 3,
    // comparison operations
    BI_INT_LT         = 4, 
    BI_INT_GT         = 5,
    BI_INT_LE         = 6,
    BI_INT_GE         = 7,
    BI_FLOAT_LT       = 8,
    BI_FLOAT_GT       = 9, 
    BI_FLOAT_LE       = 10,
    BI_FLOAT_GE       = 11,
    BI_STR_LT         = 12,
    BI_STR_GT         = 13,
    BI_STR_LE         = 14,
    BI_STR_GE         = 15,
    //IO
    BI_IO_OPEN_IN     = 16,
    BI_IO_OPEN_OUT    = 17,
    BI_IO_OPEN_APP    = 18,
    BI_IO_CLOSE_IN    = 19,
    BI_IO_CLOSE_OUT   = 20,
    BI_IO_OPEN_STR    = 21,
    BI_IO_INPUT       = 22,
    BI_IO_OUTPUT      = 23,
    BI_IO_INPUT_LINE  = 24,
    BI_IO_LOOKAHEAD   = 25,
    BI_IO_EOF         = 26,
    BI_IO_FLUSH       = 27,
    BI_IO_PRINT       = 28,
    BI_IO_READ        = 29,
    BI_IO_PRINTTERM   = 30,
    BI_IO_TERM_TO_STR = 31,
    BI_IO_STR_TO_TERM = 32,
    BI_IO_READTERM    = 33,
    BI_IO_GETENV      = 34,
    BI_IO_OPEN_SOCKET = 35,
    BI_UNIX_TIME      = 36,
    BI_SYSTEM         = 37
} BI_BuiltinTabIndex;

/*****************************************************************************/
/* Dispatching function for the builtin table                                */
/*****************************************************************************/ 
void BI_dispatch(int number);

/* builtin index "register"*/
extern BI_BuiltinTabIndex BI_number;

/***************************######********************************************
 *                          ERROR INFORMATION
 *********************************######**************************************/

#define BI_NUM_ERROR_MESSAGES 28
enum
{
   BI_ERROR = BI_FIRST_ERR_INDEX,
   BI_ERROR_TERM,
   BI_ERROR_NOT_IMPLEMENTED,
   BI_ERROR_FVAR_CAP,
   BI_ERROR_TYFVAR_CAP,
   BI_ERROR_DIV_BY_ZERO,
   BI_ERROR_NEG_SQRT,
   BI_ERROR_NEG_LOG,
   BI_ERROR_CONST_IND,
   BI_ERROR_FLEX_HEAD,		/* takes term */
   BI_ERROR_ILLEGAL_ARG,	/* takes term */
   BI_ERROR_EVAL_TYPE,
   BI_ERROR_ILLEGAL_STREAM,
   BI_ERROR_FLEX_GOAL,
   BI_ERROR_NON_VAR_TERM,	/* takes term */
   BI_ERROR_INDEX_OUT_OF_BOUNDS,
   BI_ERROR_NEGATIVE_VALUE,
   BI_ERROR_UNBOUND_VARIABLE,	/* takes string indicating desired arg. */
   BI_ERROR_NON_STREAM_TERM,	/* takes term */
   BI_ERROR_STREAM_ALREADY_CLOSED,
   BI_ERROR_CANNOT_OPEN_STREAM,	/* takes filename */
   BI_ERROR_STREAM,		/* takes term (stream) */
   BI_ERROR_READING_STREAM,	/* takes term (stream) */
   BI_ERROR_WRITING_STREAM,	/* takes term (stream) */
   BI_ERROR_FLUSHING_STREAM,	/* takes term (stream) */
   BI_ERROR_OPENING_STRING,	/* takes string */
   BI_ERROR_INTEGER_EXPECTED,	/* takes term */
   BI_ERROR_SUBSTRING
};



/***************************######********************************************
 *                            Initialization
 *********************************######**************************************/
void BI_init();

#endif //BUILTINS_H
