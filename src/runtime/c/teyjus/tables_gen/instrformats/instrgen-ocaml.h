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

/*************************************************************************/
/* functions for generating ocaml instr.mli and instr.ml                 */
/*************************************************************************/
/* include */
void ocgenInclude(char* include);

/* operand types */
void ocgenOpType(char* typeName, int numBytes, char* compType);
void ocgenOpCodeType(int numBytes);
void ocgenOps();

/* instruction category */
void ocgenInstrFormat(char* opName);
void ocgenOneInstrCat(char* catName);
void ocgenInstrLength(char* varName, char* numBytes);
void ocgenInstrCat();

/* instructions */
void ocgenOneInstr(char* opcode, char* insName, char* insCat, char* insLength,
                   int last);
void ocgenInstr();


/* dump files */
void ocSpitInstructionMLI(char * root);
void ocSpitInstructionML(char * root);

