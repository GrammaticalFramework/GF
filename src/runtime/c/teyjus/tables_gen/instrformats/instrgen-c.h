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

/******************************************************************************/
/* File instrgen-c.h. This files contains function declarations for generating*/
/* files instructions.h and instructions.c                                    */
/******************************************************************************/

/* instructions.h */
/* generating operand types */

void cgenOpTypes(char *name, char* typeName, char* types, char* comments, 
                int last);

void cgenOpCodeType(char* optype);

void cgenOpsH();

void cgenInstrCatH(char* callI1Len);

void cgenOneInstrCatH(char* name, int last);

void cgenInstrLength(char* name, char* length);

void cgenInstrH(char* numInstr);

void cgenOneInstrH(char* comments, char* opcode, char* name);


/* dump instructions.h" */
void cspitCInstructionsH(char * root);

/* instructions.c */

void cgenInstrFormat(char* opType, int last);

void cgenOneInstrCatC(char* name, int last);

void cgenInstrCatC(char* max_op);

void cinitInstrC(int numInstr);
void cgenOneInstrC(int opcode, char* name, char* cat, char* len, int last);
void cgenInstrC();

/* dump instructions.c" */
void cspitCInstructionsC(char * root);

/* simdispatch.c        */
void cinitSimDispatch(int size);
void cgenOneSimDispatch(int ind, char* instr, int last);
void cgenSimDispatch();

void cspitSimDispatch(char * root);
