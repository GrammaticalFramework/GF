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
/* ocamlcode.h{c}.                                                         */
/* These files contain usful macros and auxiliary functions for generating */
/* the pervasive.mli and pervasive.ml.                                     */
/* The parts of the ocaml files that are independent to the pervasives.in  */
/* also reside here.                                                       */
/* The length macros for string macros defined here may be larger than the */
/* extra lengthes of corresponding strings. This is ok because space and   */
/* time efficiency are not of concern in generating system files.          */
/***************************************************************************/
#include "types.h"
#include "op.h"
#include "../util/util.h"

/***************************************************************************/
/* Functions for making program components                                 */
/***************************************************************************/
/* let t = Table.add (Symbol.symbol "<name>") <varName> t in\n
*/
char* OC_mkTabEntry(char* name, char* varName);


/****************************************************************************/
/* functions for making pervasive kind relevant components                  */
/****************************************************************************/
/* k<name> */
char* OC_mkKVarName(char* name);
/* is<name> */
char* OC_mkIsKindFuncName(char* name);
/* val <kindVarName> : Absyn.akind \n*/
char* OC_mkKindVarDec(char* kindVarName);
/* val <funcName> : Absyn.akind -> bool */
char* OC_mkIsKindFuncDec(char* funcName);
/* let <funcName> tm = tm == <kindVarName> */
char* OC_mkIsKindFuncDef(char* funcName, char* kindVarName);


/* let <varName> = Absyn.PervasiveKind(Symbol.symbol "<kindName>", 
                  (Some <arity>), ref offset, Errormsg.none)
*/
char* OC_mkKindVar(char* varName, char* kindName, char* arity, char* offset);

/* let buildPervasiveKinds = 
   function () ->\n <inits> <entries>\n <tabName>\n\n */
char* OC_mkBuildKTabFunc(char* entries);

/****************************************************************************/
/* functions for making pervasive type skeleton components                  */
/****************************************************************************/
/* generating code for type skeleton */
char* OC_genTySkel(Type tyskel);

/* tyskel<number> */
char* OC_mkTySkelVarName(char* number);

/* Type Skeleton variable definition:
   let <varName> = Some(Absyn.Skeleton(<tySkel>, ref None, ref false))
*/
char* OC_mkTYSkelVar(char* varName, char* tySkel);

/* generate tyskels for overloaded constants */
char* OC_mkFixedTySkels(char* tySkels);


/****************************************************************************/
/* functions for making pervasive constants components                      */
/****************************************************************************/
/* <name>Constant */
char* OC_mkCVarName(char* name);
/* is<name> */
char* OC_mkIsConstFuncName(char* name);

/* val <constVarName> : Absyn.aconstant \n*/
char* OC_mkConstVarDec(char* constVarName);

/* Constant variable definition :
   let <varName> = Absyn.Constant(Symbol.symbolAlias "<constName>" "<printName>", 
                   ref <fixity>,
                   ref <prec>, ref false, ref false, ref false, ref false, 
                   ref false,  ref <typrev>, ref false, ref <tySkel>, 
                   ref <tyenvsize>, ref (Some <neededness>), ref <codeInfo>, 
                   ref <constantCat>, ref offset, Errormsg.none)
*/
char* OC_mkConstVar(char* constName, OP_Fixity fixity, OP_Prec prec, 
                    UTIL_Bool typrev, char* tySkel, int tyenvsize, 
                    int neededness, OP_Code codeInfo, UTIL_Bool reDef, 
                    char* varName, char* offset, char* printName);

/* val <funcName> : Absyn.aconstant -> bool */
char* OC_mkIsConstFuncDec(char* funcName);

/* let <funcName> tm = tm == <constVarName> */
char* OC_mkIsConstFuncDef(char* funcName, char* constVarName);

/* generate fixed constants */
char* OC_mkGenericConstVar(char* varList);
/* generate fixed constants decs */
char* OC_mkGenericConstVarDec(char* decList);

/* generate fixed constants entry in buildConstant function */
char* OC_mkGenericConstTabEntry(char* entries);
/* let buildPervasiveKinds = 
   function () ->\n <inits> <entries>\n <tabName>\n\n */
char* OC_mkBuildCTabFunc(char* entries);

/* make generaic const is function decs */
char* OC_mkGenericConstFuncDecs(char* funcDefs);
/* make generaic const is function defs */
char* OC_mkGenericConstFuncDefs(char* funcDefs);


char* OC_mkCompare(char* name);
char* OC_mkOr(char* operandl, char* operandr);

char* OC_mkRegClobFunc(char* body);
char* OC_mkBackTrackFunc(char* body);

/*****************************************************************************/
/* functions for making the fixed part of pervasive.mli                      */
/*****************************************************************************/
/* 
   val pervasiveKinds : Absyn.akind  Table.SymbolTable.t
   val pervasiveConstants : Absyn.aconstant Table.SymbolTable.t
   val pervasiveTypeAbbrevs : Absyn.atypeabbrev Table.SymbolTable.t
*/
char* OC_mkFixedMLI();

/*****************************************************************************/
/* functions for making the fixed part of pervasive.ml                       */
/*****************************************************************************/
/* 
   let pervasiveKinds = buildPervasiveKinds ()
   let pervasiveConstants = buildPervasiveConstants ()
   let pervasiveTypeAbbrevs = Table.SymbolTable.empty
*/
char* OC_mkFixedML();
