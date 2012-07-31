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
#include <stdlib.h>
#include <string.h>
#include "../util/util.h"
#include "op.h"

OP_Prec OP_mkPrecMin1()
{
    OP_Prec prec;
    prec.cat = OP_PREC;
    prec.data.prec = -1;
    
    return prec;
}

OP_Prec OP_mkPrecMin2()
{
    OP_Prec prec;
    prec.cat = OP_PREC;
    prec.data.prec = -2;
    
    return prec;
}

OP_Prec OP_mkPrec(int precedence)
{
    OP_Prec prec;
    prec.cat = OP_PREC;
    prec.data.prec = precedence ;
    
    return prec;
}

OP_Prec OP_mkPrecMax()
{
    OP_Prec prec;
    prec.cat = OP_PREC_NAME;
    prec.data.name = strdup("MAX");
    return prec;
}

int     OP_precIsMax(OP_Prec prec)
{
    if ((prec.cat == OP_PREC_NAME) && (strcmp(prec.data.name, "MAX") == 0))
        return 1;
    return 0;
}


OP_Code OP_mkCodeInfoNone()
{
    return -1;
}

OP_Code OP_mkCodeInfo(int ind)
{
    return ind;
}

int     OP_codeInfoIsNone(OP_Code code)
{
    return (code < 0);
}


