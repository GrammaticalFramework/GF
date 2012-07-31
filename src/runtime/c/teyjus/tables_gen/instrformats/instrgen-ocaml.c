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
#include "../util/util.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

static char* addLine(char* str, char* addOn)
{
    size_t length = (str ? strlen(str) : 0) + strlen(addOn) + 2;
    char* newStr = UTIL_mallocStr(length);
    
    if (str) {
        strcpy(newStr, str);
        strcat(newStr, addOn);
    } else strcpy(newStr, addOn);
    strcat(newStr, "\n\n");    
    return newStr;
}

static char* addStr(char* str, char* addOn)
{
    size_t length = (str ? strlen(str) : 0) + strlen(addOn);
    char* newStr = UTIL_mallocStr(length);
    
    if (str) {
        strcpy(newStr, str);
        strcat(newStr, addOn);
    } else strcpy(newStr, addOn);
    return newStr;
}


/**********************************************************************/
/* auxiliary functions for making ocaml language constructs           */
/**********************************************************************/
#define TYPE_SUFFIX      "type"
#define SIZE_SUFFIX      "Size"
#define WRITE_PREFIX     "write"
#define READ_PREFIX      "read"
#define DISPLAY_PREFIX   "display"
#define INDENT           "  "
#define INDENT2          "    "
#define WRITE            "Bytecode.write"
#define READ             "Bytecode.read"
#define DISPLAY          "Bytecode.display"
#define INSCAT_PREFIX    "inscat"
#define INS_PREFIX       "Ins_"

static char* OC_mkVarDec(char* varName, char* varType)
{
    size_t length = strlen(varName) + strlen(varType) + 10;    
    char* vardec = UTIL_mallocStr(length);
    
    strcpy(vardec, "val ");
    strcat(vardec, varName);
    strcat(vardec, " : ");
    strcat(vardec, varType);
    strcat(vardec, "\n");
    
    return vardec;
}

static char* OC_mkVarDef(char* varName, char* defs)
{
    size_t length = strlen(varName) + strlen(defs) + 10;
    char* vardef = UTIL_mallocStr(length);
    
    strcpy(vardef, "let ");
    strcat(vardef, varName);
    strcat(vardef, " = ");
    strcat(vardef, defs);
    strcat(vardef, "\n");
    
    return vardef;
}

static char* OC_mkTypeDec(char* typeName, char* defs)
{
    size_t length = strlen(typeName) + strlen(defs) + 10;
    char* typedec = UTIL_mallocStr(length);
    
    strcpy(typedec, "type ");
    strcat(typedec, typeName);
    strcat(typedec, " = ");
    strcat(typedec, defs);
    strcat(typedec, "\n");
    
    return typedec;
}

static char* OC_mkFunc(char* funcName, char* arg, char* body)
{
    size_t length = strlen(funcName) + strlen(arg) + strlen(body) + 20;
    char* func = UTIL_mallocStr(length);
    
    strcpy(func, "let ");
    strcat(func, funcName);
    strcat(func, " ");
    strcat(func, arg);
    strcat(func, " = ");
    strcat(func, body);
    strcat(func, "\n");
    
    return func;
}

static char* OC_mkCrossType(char *lop, char *rop)
{
    size_t length = strlen(lop) + strlen(rop) + 5;
    char* crossType = UTIL_mallocStr(length);
    
    strcpy(crossType, lop);
    strcat(crossType, " * ");
    strcat(crossType, rop);
    
    return crossType;
}

static char* OC_mkValueCtr(char* ctrName, char* types)
{
    size_t length = strlen(ctrName) + strlen(types) + 10;
    char* ctr = UTIL_mallocStr(length);
    
    strcpy(ctr, ctrName);
    strcat(ctr, " of ");
    strcat(ctr, types);
    return ctr;
}

static char* OC_mkDisjValueCtrs(char* prev, char* next)
{
    size_t length = strlen(prev) + strlen(next) + 10;
    char* ctr = UTIL_mallocStr(length);
    
    strcpy(ctr, prev);
    strcat(ctr, "\n");
    strcat(ctr, INDENT);
    strcat(ctr, "| ");
    strcat(ctr, next);
    
    return ctr;
}

static char* OC_mkFuncSeq(char* prev, char* new)
{
    size_t length = strlen(prev) + strlen(new) + 20;
    char* funcSeq = UTIL_mallocStr(length);
    
    strcpy(funcSeq, prev);
    strcat(funcSeq, "; ");
    strcat(funcSeq, new);
    return funcSeq;
}

static char* OC_mkArgList(char* prev, char* new)
{
  size_t length = strlen(prev) + strlen(new) + 2;
  char* args = UTIL_mallocStr(length);
  
  strcpy(args, prev);
  strcat(args, ", ");
  strcat(args, new);
  
  return args;
}

static char* OC_mkStrConcat(char* prev, char* new)
{
    size_t length = strlen(prev) + strlen(new) + 20;
    char* str = UTIL_mallocStr(length);
  
    strcpy(str, "(");
    strcat(str, prev);
    strcat(str, ") ^ \", \" ^ (");
    strcat(str, new);
    strcat(str, ")");

    return str;
}


static char* OC_mkArrow(char* left, char* right)
{
    size_t length = strlen(left) + strlen(right) + 20;
    char* arrow = UTIL_mallocStr(length);
    
    strcpy(arrow, left);
    strcat(arrow, " -> ");
    strcat(arrow, right);

    return arrow;
}

static char* OC_mkStructure(char* func, char* arg)
{
    size_t length = strlen(func) + strlen(arg) + 5;
    char* app = UTIL_mallocStr(length);
    
    strcpy(app, func);
    strcat(app, "(");
    strcat(app, arg);
    strcat(app, ")");

    return app;
}

static char* OC_mkCond(char* cond, char* branch) 
{
    size_t length = strlen(cond) + strlen(branch) + 20;
    char* str = UTIL_mallocStr(length);
    
    strcpy(str, INDENT);
    strcat(str, "if ");
    strcat(str, cond);
    strcat(str, " then ");
    strcat(str, branch);
    strcat(str, "\n");
    strcat(str, INDENT);
    strcat(str, "else");
    
    return str;
}

static char* OC_mkLetIn(char* varName, char* def)
{
    size_t length = strlen(varName) + strlen(def) + 20;
    char* str = UTIL_mallocStr(length);
    
    strcpy(str, INDENT);
    strcat(str, "let ");
    strcat(str, varName);
    strcat(str, " = ");
    strcat(str, def);
    strcat(str, " in\n");
    
    return str;
}

/**************************************************************************/
/* type definitions                                                       */
/**************************************************************************/
static char* typeDefs;

void ocgenInclude(char* include)
{
    typeDefs = include;
}

/**************************************************************************/
/* operand types                                                          */
/**************************************************************************/
static char* opTypes;
static char* opSizesMLI;
static char* opSizesML;
static char* writeFuncs;
static char* readFuncs;

static char* ocgenWriteOpFunc(char* typeName, char* compType, int numBytes)
{
    char* funcName = UTIL_appendStr(WRITE_PREFIX, typeName);
    char* numBytesText = UTIL_itoa(numBytes);
    char* arg = "arg";
    char* funcBody1 = UTIL_mallocStr(strlen(WRITE) + strlen(compType) +
                                     strlen(numBytesText));
    char *funcBody2, *func;
    
    strcpy(funcBody1, WRITE);
    strcat(funcBody1, compType);
    strcat(funcBody1, numBytesText);                free(numBytesText);
    
    funcBody2 = UTIL_appendStr(funcBody1, " arg");  free(funcBody1);
    func = OC_mkFunc(funcName, arg, funcBody2); 
    free(funcName); free(funcBody2);
    return func;
}

static char* ocgenReadOpFunc(char* typeName, char* compType, int numBytes)
{
    char* funcName = UTIL_appendStr(READ_PREFIX, typeName);
    char* numBytesText = UTIL_itoa(numBytes);
    char* arg = "()";
    char* funcBody1 = UTIL_mallocStr(strlen(READ) + strlen(compType) + 
                                      strlen(numBytesText));
    char* funcBody2, *func;
    
    strcpy(funcBody1, READ);
    strcat(funcBody1, compType);
    strcat(funcBody1, numBytesText);                free(numBytesText);
    
    funcBody2 = UTIL_appendStr(funcBody1, " ()");  free(funcBody1);
    func = OC_mkFunc(funcName, arg, funcBody2);
    free(funcName); free(funcBody2);
    return func;
}

void ocgenOpType(char* typeName, int numBytes, char* compType)
{
    /* generate type declarations*/
    char* myName        = UTIL_lowerCase(typeName);
    char* myTypeName    = UTIL_appendStr(myName, TYPE_SUFFIX);
    char* myOpType      = OC_mkTypeDec(myTypeName, compType);
    char* myopTypes     = addStr(opTypes, myOpType);
    /* generate write functions */
    char* func          = ocgenWriteOpFunc(typeName, compType, numBytes);
    char* myWriteFuncs  = addStr(writeFuncs, func);
    /* generate read functions */
    char* readFunc      = ocgenReadOpFunc(typeName, compType, numBytes);
    char* myReadFuncs   = addStr(readFuncs, readFunc);

    /* generate sizes */
    if (numBytes < 4) {
        char* mySizeName    = UTIL_appendStr(myName, SIZE_SUFFIX);
        char* myOpSizeMLI   = OC_mkVarDec(mySizeName, "int");
        char* size          = UTIL_itoa((int)(0 /*pow(2,(numBytes * 8))-1*/));
        char* myOpSizeML    = OC_mkVarDef(mySizeName, size);
        char* myopSizesMLI  = addStr(opSizesMLI, myOpSizeMLI);
        char* myopSizesML   = addStr(opSizesML, myOpSizeML);

        free(mySizeName); free(size); free(myOpSizeMLI); free(myOpSizeML);
        free(opSizesMLI); free(opSizesML);
        opSizesMLI =  myopSizesMLI;  
        opSizesML   = myopSizesML;
    }
    free(myTypeName); free(myName);
    free(opTypes); free(myOpType);
    opTypes = myopTypes;
    free(writeFuncs); free(func);
    writeFuncs = myWriteFuncs;
    free(readFuncs);  free(readFunc);
    readFuncs = myReadFuncs;
}

void ocgenOpCodeType(int numBytes)
{
    char* mySizeName = UTIL_appendStr("opcode", SIZE_SUFFIX);
    char* size       = UTIL_itoa((int)(0 /*pow(2,(numBytes * 8))-1*/));
    char* myOpCodeSizeMLI = OC_mkVarDec(mySizeName, "int");
    char* myOpCodeSizeML  = OC_mkVarDef(mySizeName, size);
    char* myopSizeMLI = addLine(opSizesMLI, myOpCodeSizeMLI);
    char* myopSizeML  = addLine(opSizesML, myOpCodeSizeML);
    char* func = ocgenWriteOpFunc("opcode", "int", numBytes);
    char* myWriteFuncs = addLine(writeFuncs, func);
    char* readFunc = ocgenReadOpFunc("opcode", "int", numBytes);
    char* myReadFuncs = addLine(readFuncs, readFunc);
    
    free(size); free(mySizeName);
    free(opSizesMLI);   free(myOpCodeSizeMLI);
    free(opSizesML);    free(myOpCodeSizeML);  
    free(writeFuncs);   free(func);
    free(readFuncs);    free(readFunc);
    opSizesMLI = myopSizeMLI;
    opSizesML  = myopSizeML;
    writeFuncs = myWriteFuncs;
    readFuncs  = myReadFuncs;
}

static char* opMLI;
static char* opML;

void ocgenOps()
{
    char* wordSizeName = "wordSize";
    char* wordSizeMLI  = OC_mkVarDec(wordSizeName, "int");
    char* wordSize     = UTIL_itoa(sizeof(void*));
    char* wordSizeML   = OC_mkVarDef(wordSizeName, wordSize);
    char* text;
    
    free(wordSize);
    opMLI = addLine(opMLI, wordSizeMLI); free(wordSizeMLI);
    text = addLine(opMLI, opSizesMLI);   free(opMLI); free(opSizesMLI);
    opMLI = addLine(text, opTypes);      free(text); 

    opML = addLine(opML, wordSizeML);    free(wordSizeML);
    text = addLine(opML, opSizesML);     free(opML); free(opSizesML);
    opML = addLine(text, writeFuncs);    free(text); free(writeFuncs);
    text = addLine(opML, readFuncs);     free(opML); free(readFuncs);
    opML = addLine(text, opTypes);       free(text); free(opTypes);
}

/****************************************************************************/
/* instruction categories                                                   */
/****************************************************************************/
static char* instrCatWriteFunc = NULL;
static char* instrCatReadFunc  = NULL;
static char* instrCatDisplayFunc = NULL;
static char* instrCatType      = NULL;
static int   argInd            = 1;
static char* argList           = NULL;  

void ocgenInstrFormat(char* opName)
{
  char *myop, *myOpName, *myFuncName, *myArgInd, *myFuncCall, *myArg, 
      *myArgList, *myinstrCatType, *myinstrCatWriteFunc, *myReadBody,
      *myinstrCatReadFunc, * myinstrCatDisplayFunc;
    
    if (strcmp(opName, "P") == 0 || strcmp(opName, "WP") == 0 || 
        strcmp(opName, "X") == 0) return;

    //type declaration
    myop = UTIL_lowerCase(opName);
    myOpName = UTIL_appendStr(myop, TYPE_SUFFIX);     free(myop);
    if (instrCatType) {
        myinstrCatType = OC_mkCrossType(instrCatType, myOpName);
        free(instrCatType);   free(myOpName);
        instrCatType = myinstrCatType;
    } else instrCatType = myOpName;

    //argument 
    myArgInd = UTIL_itoa(argInd);
    argInd++;
    myArg = UTIL_appendStr("arg", myArgInd);              free(myArgInd);
    //argument list
    if (argList) {
      myArgList = OC_mkArgList(argList, myArg); free(argList);
      argList = myArgList;
    } else argList = myArg;
    
    //write function
    myFuncName = UTIL_appendStr(WRITE_PREFIX, opName);
    myFuncCall = UTIL_mallocStr(strlen(myFuncName) + strlen(myArg) + 5);
    strcpy(myFuncCall, myFuncName);     free(myFuncName);
    strcat(myFuncCall, " ");
    strcat(myFuncCall, myArg);    
    if (instrCatWriteFunc) {
        myinstrCatWriteFunc = OC_mkFuncSeq(instrCatWriteFunc, myFuncCall);
        free(instrCatWriteFunc);
        instrCatWriteFunc = myinstrCatWriteFunc;
        free(myFuncCall);
    } else instrCatWriteFunc =  myFuncCall;
    
    //read function
    myFuncName = UTIL_appendStr(READ_PREFIX, opName);
    myFuncCall = UTIL_mallocStr(strlen(myFuncName) + 5);
    strcpy(myFuncCall, myFuncName);   free(myFuncName);
    strcat(myFuncCall, " ()");
    myReadBody = OC_mkLetIn(myArg, myFuncCall); free(myFuncCall);
    if (instrCatReadFunc) {
        myinstrCatReadFunc = UTIL_appendStr(instrCatReadFunc, myReadBody);
        free(instrCatReadFunc);
        instrCatReadFunc = myinstrCatReadFunc;
        free(myReadBody);
    } else instrCatReadFunc = myReadBody;

    //display function
    myFuncName = UTIL_appendStr(DISPLAY, opName);
    myFuncCall = UTIL_mallocStr(strlen(myFuncName) + strlen(myArg) + 5);
    strcpy(myFuncCall, myFuncName);     free(myFuncName);
    strcat(myFuncCall, " ");
    strcat(myFuncCall, myArg);      
    if (instrCatDisplayFunc) {
        myinstrCatDisplayFunc = OC_mkStrConcat(instrCatDisplayFunc, myFuncCall);
        free(instrCatDisplayFunc);
        instrCatDisplayFunc = myinstrCatDisplayFunc;
        free(myFuncCall);
    } else instrCatDisplayFunc =  myFuncCall;
}

static char* instrCatTypes;
static char* instrCatWriteFuncs;
static char* instrCatReadFuncs;
static char* instrCatDisplayFuncs;


void ocgenOneInstrCat(char* catName)
{
  char *myCatName, *myInstrCatType, *myInstrCatTypes, *myArgs,
      *myWriteFuncName, *myWriteFunc, *myInstrCatWriteFuncs, 
      *myReadFuncName, *myReadFunc, *myReadFuncBody, *myInstrCatReadFuncs, 
      *myDisplayFuncName, *myDisplayFunc, *myInstrCatDisplayFuncs, *myArgs2, *temp;

  if (instrCatType) {
    myCatName = UTIL_appendStr(INSCAT_PREFIX, catName); 
    myInstrCatType = OC_mkTypeDec(myCatName, instrCatType);
    myInstrCatTypes = addStr(instrCatTypes, myInstrCatType);

    myArgs = UTIL_mallocStr(strlen(argList) + 5);
    strcpy(myArgs, "(");
    strcat(myArgs, argList);           
    strcat(myArgs, ")");

    /* write function */
    myWriteFuncName = UTIL_appendStr(WRITE_PREFIX, catName);
    myWriteFunc = OC_mkFunc(myWriteFuncName, myArgs, instrCatWriteFunc);
    myInstrCatWriteFuncs = addStr(instrCatWriteFuncs, myWriteFunc);
    
    /* read function */
    myReadFuncName = UTIL_appendStr(READ_PREFIX, catName);
    myArgs2 = UTIL_appendStr(INDENT, myArgs);
    temp = UTIL_appendStr(instrCatReadFunc, myArgs2); free(myArgs2);
    myReadFuncBody= UTIL_appendStr("\n", temp); free(temp);
    myReadFunc = OC_mkFunc(myReadFuncName, "()", myReadFuncBody);
    myInstrCatReadFuncs = addStr(instrCatReadFuncs, myReadFunc);

    /* display function */
    myDisplayFuncName = UTIL_appendStr(DISPLAY_PREFIX, catName);
    myDisplayFunc = OC_mkFunc(myDisplayFuncName, myArgs, instrCatDisplayFunc);
    myInstrCatDisplayFuncs = addStr(instrCatDisplayFuncs, myDisplayFunc);

    
    free(myCatName); free(myInstrCatType); 
    free(instrCatType); free(instrCatTypes);
    free(myWriteFuncName); free(myWriteFunc); 
    free(instrCatWriteFunc);  free(instrCatWriteFuncs);
    free(myReadFuncName); free(myReadFunc);
    free(instrCatReadFunc); free(instrCatReadFuncs);
    free(myDisplayFuncName); free(myDisplayFunc);
    free(instrCatDisplayFunc); free(instrCatDisplayFuncs);
    free(argList);

    argList = NULL; argInd = 1;
    instrCatType = NULL; 
    instrCatWriteFunc = NULL; instrCatReadFunc = NULL; 
    instrCatDisplayFunc = NULL;
    instrCatTypes = myInstrCatTypes; 
    instrCatWriteFuncs = myInstrCatWriteFuncs;
    instrCatReadFuncs = myInstrCatReadFuncs;
    instrCatDisplayFuncs = myInstrCatDisplayFuncs;					       
  }
}

static char* instrCatLength;
void ocgenInstrLength(char* varName, char* numBytes)
{
    char* myVarName = UTIL_appendStr(INSCAT_PREFIX, varName);
    char* varDef    = OC_mkVarDef(myVarName, numBytes);
    char* myInstrCatLength = addStr(instrCatLength, varDef);
    
    free(myVarName); free(varDef); free(instrCatLength);
    instrCatLength = myInstrCatLength;
}

static char* instrCatMLI;
static char* instrCatML;

void ocgenInstrCat()
{
  char* text = instrCatTypes;
  char* text2 = addLine(text, "\n");
  
  instrCatMLI = text;
  
  text        = addLine(text2, instrCatWriteFuncs); 
  free(instrCatWriteFuncs); free(text2);
  
  text2 = addLine(text, instrCatReadFuncs);
  free(instrCatReadFuncs); free(text);
  
  text = addLine(text2, instrCatDisplayFuncs);
  free(instrCatDisplayFuncs); free(text2);
  
  instrCatML = addLine(text, instrCatLength);  
  free(text); free(instrCatLength);
}

/****************************************************************************/
/* instructions                                                             */
/****************************************************************************/
#define GETSIZE_PREFIX "getSize_"
#define WRITEOPCODE    "writeopcode "

static char* instructionTypes;
static char* insWriteFuncBody;
static char* insReadFuncBody;
static char* insDisplayFuncBody;
static char* insSizesDec;
static char* insSizesDef;

static void ocgenReadFuncBody(char* opcode, char* myInsName, char* myInsLength, char* insCat, 
                              int last)
{
    char *ins, *readArgs, *returnValue, *myReadFuncBody, *mycond, *tmp;    
    
    if (strcmp(insCat, "X") == 0) ins = myInsName;
    else {
        readArgs = UTIL_appendStr(READ_PREFIX, insCat); 
        ins = UTIL_mallocStr(strlen(readArgs) + strlen(myInsName) + 10);
        strcpy(ins, myInsName);
        strcat(ins, " (");
        strcat(ins, readArgs);
        strcat(ins, " ())");
        free(readArgs);
    }
    returnValue = UTIL_mallocStr(strlen(ins) + strlen(myInsLength) + 5);
    strcpy(returnValue, "(");
    strcat(returnValue,  ins);
    strcat(returnValue, ", ");
    strcat(returnValue, myInsLength);
    strcat(returnValue, ")");
    
    if (last) { 
        tmp = UTIL_appendStr(" ", returnValue); free(returnValue);
    }else {
        mycond = UTIL_mallocStr(strlen(opcode) + 10);
        strcpy(mycond, "opcode = ");
        strcat(mycond, opcode);
        tmp = OC_mkCond(mycond, returnValue); 
        free(mycond); free(returnValue);
    }
    
    if (insReadFuncBody) {
        myReadFuncBody = UTIL_appendStr(insReadFuncBody, tmp);
        free(insReadFuncBody); free(tmp);
        insReadFuncBody = myReadFuncBody;
    } else insReadFuncBody = tmp;

}

static char* OC_mkWS(int size) 
{
    int   i;
    char* text;
    
    if (size > 0) {
        text = UTIL_mallocStr(size);
        for (i = 0; i < size; i++) text[i]= ' ';
        text[size] = '\0';
    } else text = strdup(" ");
    
    return text;
}    

static void ocgenDisplayFuncBody(char* pattern, char* insName, char* insLength,
                                 char* insCat)
{
    char *displayargs, *funcBody, *myInsName, *ins, *returnValue, *insText,
        *myDisplayFuncBody;
    
    myInsName = UTIL_appendStr(insName, OC_mkWS(25u - strlen(insName)));
    insText   = UTIL_mallocStr(strlen(myInsName) + 5);  
    strcpy(insText, "\"");
    strcat(insText, myInsName);       free(myInsName);
    strcat(insText, "\"");
    

    if (strcmp(insCat, "X") == 0) ins = insText;
    else {
        displayargs = UTIL_appendStr(DISPLAY_PREFIX, insCat); 
        ins = UTIL_mallocStr(strlen(displayargs) + strlen(insText) + 10);
        strcpy(ins, insText);
        strcat(ins, "^ (");
        strcat(ins, displayargs);
        strcat(ins, " arg)");
        free(displayargs); free(insText);
    }

    returnValue = UTIL_mallocStr(strlen(ins) + strlen(insLength) + 5);
    strcpy(returnValue, "(");
    strcat(returnValue,  ins);
    strcat(returnValue, ", ");
    strcat(returnValue, insLength);
    strcat(returnValue, ")");

    funcBody = OC_mkArrow(pattern, returnValue);
    free(returnValue);

    if (insDisplayFuncBody) {
        myDisplayFuncBody =  OC_mkDisjValueCtrs(insDisplayFuncBody, funcBody);
        free(insDisplayFuncBody); free(funcBody);
        insDisplayFuncBody = myDisplayFuncBody;
    } else {
        insDisplayFuncBody = UTIL_appendStr(INDENT2, funcBody);
        free(funcBody);
    }
}


void ocgenOneInstr(char* opcode, char* insName, char* insCat, char* insLength,
                   int last)
{
    char *myCatName, *myInsName, *myValueCtr, *myInstrTypes;
    char *myInsSizeName, *myInsLength, *mySizeDef, *mySizeDec, *mySizeDefs, 
        *mySizeDecs;
    char *myPattern, *myWriteOpCodeFunc, *myfuncBody, *myFunc, *myInsWriteFuncBody;
    
    /* value constructors for type instruction */
    myInsName = UTIL_appendStr(INS_PREFIX, insName);
    if (strcmp(insCat, "X") == 0) {
        myValueCtr = myInsName;
    } else {
        myCatName = UTIL_appendStr(INSCAT_PREFIX, insCat); 
        myValueCtr = OC_mkValueCtr(myInsName, myCatName);   free(myCatName);
    }
    if (instructionTypes) {
        myInstrTypes = OC_mkDisjValueCtrs(instructionTypes, myValueCtr);
        free(instructionTypes);
        instructionTypes = myInstrTypes;
    } else instructionTypes = myValueCtr;

    /* write function body */
    myWriteOpCodeFunc = UTIL_appendStr(WRITEOPCODE, opcode);
    if (strcmp(insCat, "X") == 0) {
        myPattern  = strdup(myInsName);   
        myfuncBody = myWriteOpCodeFunc;
    } else {
        char* myWriteArgsName = UTIL_appendStr(WRITE_PREFIX, insCat);
        char* myWriteArgs = UTIL_mallocStr(strlen(myWriteArgsName) + 5);
        myPattern = OC_mkStructure(myInsName, "arg"); 
        strcpy(myWriteArgs, myWriteArgsName);           free(myWriteArgsName);
        strcat(myWriteArgs, " arg");
        myfuncBody = OC_mkFuncSeq(myWriteOpCodeFunc, myWriteArgs);
        free(myWriteArgs);
    }
    myFunc = OC_mkArrow(myPattern, myfuncBody); 
    free(myfuncBody);
    if (insWriteFuncBody) {
        myInsWriteFuncBody =  OC_mkDisjValueCtrs(insWriteFuncBody, myFunc);
        free(insWriteFuncBody); free(myFunc);
        insWriteFuncBody = myInsWriteFuncBody;
    } else {
        insWriteFuncBody = UTIL_appendStr(INDENT2, myFunc);
        free(myFunc);
    }
    /* instruction sizes */
    myInsSizeName = UTIL_appendStr(GETSIZE_PREFIX, insName); 
    myInsLength = UTIL_appendStr(INSCAT_PREFIX, insLength); 
    mySizeDef =  OC_mkVarDef(myInsSizeName, myInsLength); 
    mySizeDec =  OC_mkVarDec(myInsSizeName, "int");       free(myInsSizeName);
    
    mySizeDefs = addStr(insSizesDef, mySizeDef); 
    free(insSizesDef); free(mySizeDef);
    mySizeDecs = addStr(insSizesDec, mySizeDec);
    free(insSizesDec); free(mySizeDec);
    
    insSizesDef = mySizeDefs;
    insSizesDec = mySizeDecs;

    ocgenReadFuncBody(opcode, myInsName, myInsLength, insCat, last);
    ocgenDisplayFuncBody(myPattern, insName, myInsLength, insCat);
    
    free(myInsName); free(myInsLength); free(myPattern);
}

#define INSTRTYPE_HEAD "type instruction = "

#define INSTWRITEFUNC_DEF_HEAD "let writeInstruction inst =\n  match inst with\n"
#define INSTWRITEFUNC_DEC "val writeInstruction : instruction -> unit\n"

#define INSTREADFUNC_DEF_HEAD \
"let readInstruction getKindFunc getConstantFunc =                             \n  Bytecode.setGetKindFn getKindFunc;                                           \n  Bytecode.setGetConstantFn getConstantFunc;                                   \n  let opcode = readopcode () in\n"

#define INSTREADFUNC_DEC \
"val readInstruction :                                                          \n(int -> int -> Absyn.akind option) -> (int -> int -> Absyn.aconstant option) ->\n(instruction * int)\n"

#define INSTDISPLAYFUNC_DEF_HEAD \
"let displayInstruction inst =\n match inst with\n"
#define INSTDISPLAYFUNC_DEC \
"val displayInstruction : instruction -> (string * int)\n"

static char* instrMLI;
static char* instrML;

void ocgenInstr()
{
    char* text = UTIL_appendStr(INSTRTYPE_HEAD, instructionTypes);
    char* text2 = UTIL_appendStr(text, "\n\n");
    
    free(instructionTypes); free(text);

    text = addLine(text2, insSizesDec); free(insSizesDec);
    instrMLI = addStr(text, INSTWRITEFUNC_DEC); free(text);
    text = addStr(instrMLI, INSTREADFUNC_DEC);  free(instrMLI);
    instrMLI = addStr(text, INSTDISPLAYFUNC_DEC); free(text);
    
    text =  addLine(text2, insSizesDef); free(text2); free(insSizesDef);
    text2 = addStr(text, INSTWRITEFUNC_DEF_HEAD);    free(text);    
    instrML = addStr(text2, insWriteFuncBody);   
    free(text2); free(insWriteFuncBody);
    text  = addStr(instrML, "\n\n"); free(instrML);
    text2 = addStr(text, INSTREADFUNC_DEF_HEAD);     free(text);
    instrML = addStr(text2, insReadFuncBody);        
    free(text2); free(insReadFuncBody);
    text = addStr(instrML, "\n\n"); free(instrML);
    text2 = addStr(text, INSTDISPLAYFUNC_DEF_HEAD);  free(text);
    instrML = addStr(text2, insDisplayFuncBody);
    free(text2); free(insDisplayFuncBody);
}

/****************************************************************************/
/* dump files                                                               */
/****************************************************************************/
/* dump files */
void ocSpitInstructionMLI(char * root)
{
    FILE* outFile;

    char * filename = malloc(strlen(root) + 32);
    strcpy(filename, root);
    strcat(filename, "compiler/instr.mli");

    outFile = UTIL_fopenW(filename);
    fprintf(outFile, typeDefs);          
    fprintf(outFile, opMLI);             free(opMLI);
    fprintf(outFile, instrCatMLI);       free(instrCatMLI);
    fprintf(outFile, "\n\n");
    fprintf(outFile, instrMLI);          free(instrMLI);
    UTIL_fclose(outFile);
    free(filename);
}

/* dump files */
void ocSpitInstructionML(char * root)
{
    FILE* outFile;

    char * filename = malloc(strlen(root) + 32);
    strcpy(filename, root);
    strcat(filename, "compiler/instr.ml");

    outFile = UTIL_fopenW(filename);
    fprintf(outFile, typeDefs);          free(typeDefs);
    fprintf(outFile, opML);              free(opML);
    fprintf(outFile, instrCatML);        free(instrCatML);
    fprintf(outFile, instrML);           free(instrML);
    UTIL_fclose(outFile);

    free(filename);
}

