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
#ifndef OP_H
#define OP_H

//fixity type
typedef enum {
    OP_INFIX, OP_INFIXL, OP_INFIXR, OP_PREFIX, OP_PREFIXR, OP_POSTFIX,
    OP_POSTFIXL, OP_NONE
} OP_Fixity;

typedef enum {
    OP_PREC, OP_PREC_NAME
} OP_PrecTypeCat;

//precedence type
typedef struct
{
    OP_PrecTypeCat cat;
    union
    {
        int    prec;
        char*  name;
    } data;
} OP_Prec;

OP_Prec OP_mkPrecMin1();
OP_Prec OP_mkPrecMin2();
OP_Prec OP_mkPrec(int prec);
OP_Prec OP_mkPrecMax();

int     OP_precIsMax(OP_Prec prec);


//code info type
typedef int OP_Code;

OP_Code OP_mkCodeInfoNone();
OP_Code OP_mkCodeInfo(int ind);

int     OP_codeInfoIsNone(OP_Code code);

#endif 
    
