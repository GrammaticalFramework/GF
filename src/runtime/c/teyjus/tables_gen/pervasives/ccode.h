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
#include "types.h"
#include "op.h"

/*******************************************************************/
/* commen structures                                               */
/*******************************************************************/
/* // <comments> */
char* C_mkOneLineComments(char* comments);
/*    // empty */
char* C_mkEmptyComments();
/* 
    //comments \n
    PERV_<name>_INDEX = <indexNum>
*/
char* C_mkIndex(char* name, char* indexNum, char* comments);
/*
    PERV_<name> = <indexNum>
*/
char* C_mkIndex2(char* name, char* indexNum);

/******************************************************************/
/* kind relevant components                                       */
/******************************************************************/
char* C_mkNumKinds(char* num);
char* C_mkKindIndexType(char* body);
char* C_mkKindH(char* indexType, char* kindNum);

char* C_mkKindTabEntry(char* name, char* arity, char* comments);
char* C_mkKindTab(char* body);
char* C_mkKindC(char* kindTab);

/******************************************************************/
/* type skeleton relevant components                              */
/******************************************************************/
char* C_mkNumTySkels(char* num);
char* C_mkTySkelsH(char* numTySkels);

extern int C_totalSpace;
char* C_genTySkel(Type tyskel, char* comments);
char* C_mkTySkelTabInit(char* body, int space);
char* C_mkTySkelsC(char* tySkelTab);

/******************************************************************/
/* constant relevant components                                   */
/******************************************************************/
char* C_mkNumConsts(char* num);
char* C_mkConstIndexType(char* body);
char* C_mkConstH(char* constIndexType, char* numConsts, char* property);

char* C_mkConstTabEntry(char* name, char* tesize, OP_Prec prec, 
                        OP_Fixity fixity, char* tyskelInd, char* neededness,
                        char* comments);
char* C_mkConstTab(char* body);
char* C_mkConstC(char* constTab);


char* C_mkLSTypeDec(char* body);
char* C_mkLSRange(char* start, char* end);
char* C_mkPredRange(char* start, char* end);

char* C_mkFixedBegH();
char* C_mkFixedEndH();
char* C_mkFixedBegC();
char* C_mkFixedEndC();
