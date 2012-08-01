//////////////////////////////////////////////////////////////////////////////
//Copyright 2012
//  Krasimir Angelov
//////////////////////////////////////////////////////////////////////////////

/*************************************************************************/
/* functions for generating Haskell Instructions.hs                      */
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
    strcat(newStr, "\n");
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
#define PUT_PREFIX       "put"
#define GET_PREFIX       "get"
#define DISPLAY_PREFIX   "display"
#define INDENT           "  "
#define INDENT2          "    "
#define PUT              "putWord"
#define GET              "getWord"
#define DISPLAY          "pp"
#define INSCAT_PREFIX1   "inscat"
#define INSCAT_PREFIX2   "Inscat"
#define INS_PREFIX       "Ins_"

static char* HS_mkVarDef(char* varName, char* varType, char* defs)
{
    size_t length = strlen(varName) + strlen(defs) + strlen(varType) + 10;
    char* vardef = UTIL_mallocStr(length);
    
    strcpy(vardef, varName);
    strcat(vardef, " = ");
    strcat(vardef, defs);
    strcat(vardef, " :: ");
    strcat(vardef, varType);
    strcat(vardef, "\n");

    return vardef;
}

static char* HS_mkTypeDec(char* typeName, char* defs)
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

static char* HS_mkFunc(char* funcName, char* arg, char* body)
{
    size_t length = strlen(funcName) + strlen(arg) + strlen(body) + 20;
    char* func = UTIL_mallocStr(length);
    
    strcpy(func, funcName);
    strcat(func, " ");
    strcat(func, arg);
    strcat(func, " = ");
    strcat(func, body);
    strcat(func, "\n");
    
    return func;
}

static char* HS_mkCrossType(char *lop, char *rop)
{
    size_t length = strlen(lop) + strlen(rop) + 5;
    char* crossType = UTIL_mallocStr(length);
    
    strcpy(crossType, lop);
    strcat(crossType, ", ");
    strcat(crossType, rop);
    
    return crossType;
}

static char* HS_mkValueCtr(char* ctrName, char* types)
{
    size_t length = strlen(ctrName) + strlen(types) + 10;
    char* ctr = UTIL_mallocStr(length);
    
    strcpy(ctr, ctrName);
    strcat(ctr, " ");
    strcat(ctr, types);
    return ctr;
}

static char* HS_mkDisjValueCtrs(char* prev, char* next)
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

static char* HS_mkCase(char* prev, char* next)
{
    size_t length = strlen(prev) + strlen(next) + 10;
    char* ctr = UTIL_mallocStr(length);
    
    strcpy(ctr, prev);
    strcat(ctr, "\n");
    strcat(ctr, INDENT);
    strcat(ctr, "  ");
    strcat(ctr, next);
    
    return ctr;
}

static char* HS_mkFuncSeq(char* prev, char* new)
{
    size_t length = strlen(prev) + strlen(new) + 20;
    char* funcSeq = UTIL_mallocStr(length);
    
    strcpy(funcSeq, prev);
    strcat(funcSeq, " >> ");
    strcat(funcSeq, new);
    return funcSeq;
}

static char* HS_mkArgList(char* prev, char* new)
{
  size_t length = strlen(prev) + strlen(new) + 2;
  char* args = UTIL_mallocStr(length);
  
  strcpy(args, prev);
  strcat(args, ", ");
  strcat(args, new);
  
  return args;
}

static char* HS_mkStrConcat(char* prev, char* new)
{
    size_t length = strlen(prev) + strlen(new) + 25;
    char* str = UTIL_mallocStr(length);
  
    strcpy(str, "(");
    strcat(str, prev);
    strcat(str, ") ++ \", \" ++ (");
    strcat(str, new);
    strcat(str, ")");

    return str;
}


static char* HS_mkArrow(char* left, char* right)
{
    size_t length = strlen(left) + strlen(right) + 20;
    char* arrow = UTIL_mallocStr(length);
    
    strcpy(arrow, left);
    strcat(arrow, " -> ");
    strcat(arrow, right);

    return arrow;
}

static char* HS_mkStructure(char* func, char* arg)
{
    size_t length = strlen(func) + strlen(arg) + 5;
    char* app = UTIL_mallocStr(length);
    
    strcpy(app, func);
    strcat(app, " ");
    strcat(app, arg);

    return app;
}

static char* HS_mkDO(char* varName, char* def)
{
    size_t length = strlen(varName) + strlen(def) + 20;
    char* str = UTIL_mallocStr(length);
    
    strcpy(str, INDENT);
    strcat(str, varName);
    strcat(str, " <- ");
    strcat(str, def);
    strcat(str, "\n");
    
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
static char* opSizes;
static char* writeFuncs;
static char* readFuncs;

static char* ocgenWriteOpFunc(char* typeName, char* compType, int numBytes)
{
    char* funcName = UTIL_appendStr(PUT_PREFIX, typeName);
    char* numBitsText = UTIL_itoa(numBytes*8);
    char* funcBody = UTIL_mallocStr(strlen(PUT)+strlen(numBitsText)+20);
    char* func;

	if (strcmp(typeName, "F") == 0) {
		strcpy(funcBody, "putFloat");
		strcat(funcBody, numBitsText);
		
		if (numBytes > 1)
			strcat(funcBody, "be");
	} else if (strcmp(typeName, "C") == 0 || strcmp(typeName, "K") == 0) {
		strcpy(funcBody, "put");
	} else {
		strcpy(funcBody, PUT);
		strcat(funcBody, numBitsText);
    
		if (numBytes > 1)
			strcat(funcBody, "be");
			
		strcat(funcBody, " . fromIntegral");
	}
	
	free(numBitsText);

    func = HS_mkFunc(funcName, "", funcBody);
    free(funcName);
    free(funcBody);
    return func;
}

static char* ocgenReadOpFunc(char* typeName, char* compType, int numBytes)
{
    char* funcName = UTIL_appendStr(GET_PREFIX, typeName);
    char* numBitsText = UTIL_itoa(numBytes*8);
    char* funcBody = UTIL_mallocStr(strlen(GET)+strlen(numBitsText)+30);
    char* func;
    
    if (strcmp(typeName, "F") == 0) {
		strcpy(funcBody, "getFloat");
		strcat(funcBody, numBitsText);
		
		if (numBytes > 1)
			strcat(funcBody, "be");
	} else if (strcmp(typeName, "C") == 0 || strcmp(typeName, "K") == 0) {
		strcpy(funcBody, "get");
	} else {
		strcpy(funcBody, "fmap fromIntegral $ ");
		strcat(funcBody, GET);
		strcat(funcBody, numBitsText);
		
		if (numBytes > 1)
			strcat(funcBody, "be");
	}
	
	free(numBitsText);

    func = HS_mkFunc(funcName, "", funcBody);
    free(funcName);
    free(funcBody);
    return func;
}

void ocgenOpType(char* typeName, int numBytes, char* compType)
{
	char* myCompType =	
            (strcmp(compType, "int") == 0) ? "Int" :
            (strcmp(compType, "float") == 0) ? "Float" :
	        (strcmp(compType, "aconstant") == 0) ? "AConstant" :
	        (strcmp(compType, "akind") == 0) ? "AKind" :
	        (strcmp(compType, "intref") == 0) ? "IntRef" :
	        NULL;

    /* generate type declarations*/
    char* myTypeName    = UTIL_appendStr(typeName, TYPE_SUFFIX);
    char* myOpType      = HS_mkTypeDec(myTypeName, myCompType);
    char* myopTypes     = addStr(opTypes, myOpType);
    /* generate write functions */
    char* func          = ocgenWriteOpFunc(typeName, compType, numBytes);
    char* myWriteFuncs  = addStr(writeFuncs, func);
    /* generate read functions */
    char* readFunc      = ocgenReadOpFunc(typeName, compType, numBytes);
    char* myReadFuncs   = addStr(readFuncs, readFunc);

    /* generate sizes */
    if (numBytes < 4) {
		char* myName        = UTIL_lowerCase(typeName);
        char* mySizeName    = UTIL_appendStr(myName, SIZE_SUFFIX);
        char* size          = UTIL_itoa((int)(pow(2,(numBytes * 8))-1));
        char* myOpSize      = HS_mkVarDef(mySizeName, "Int", size);
        char* myopSizes     = addStr(opSizes, myOpSize);

        free(myName); free(mySizeName); free(size); free(myOpSize);
        free(opSizes);
        opSizes =  myopSizes;
    }
    free(myTypeName);
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
    char* size       = UTIL_itoa((int)(pow(2,(numBytes * 8))-1));
    char* myOpCodeSize = HS_mkVarDef(mySizeName, "Int", size);
    char* myopSizes = addLine(opSizes, myOpCodeSize);
    char* func = ocgenWriteOpFunc("opcode", "Int", numBytes);
    char* myWriteFuncs = addLine(writeFuncs, func);
    char* readFunc = ocgenReadOpFunc("opcode", "Int", numBytes);
    char* myReadFuncs = addLine(readFuncs, readFunc);
    
    free(size); free(mySizeName);
    free(opSizes);   free(myOpCodeSize);
    free(writeFuncs);   free(func);
    free(readFuncs);    free(readFunc);
    opSizes = myopSizes;
    writeFuncs = myWriteFuncs;
    readFuncs  = myReadFuncs;
}

static char* opHS;

void ocgenOps()
{
    char* wordSizeName = "wordSize";
    char* wordSize     = UTIL_itoa(sizeof(void*));
    char* wordSizeHS   = HS_mkVarDef(wordSizeName, "Int", wordSize);
    char* text;

    free(wordSize);
    opHS = addLine(NULL, wordSizeHS);  free(wordSizeHS);
    text = addLine(opHS, opSizes);     free(opSizes);     free(opHS);

    opHS = addLine(text, opTypes);     free(opTypes);     free(text);

    text = addLine(opHS, writeFuncs);  free(writeFuncs);  free(opHS);
    opHS = addLine(text, readFuncs);   free(readFuncs);   free(text);
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
  char *myOpName, *myFuncName, *myArgInd, *myFuncCall, *myArg, 
      *myArgList, *myinstrCatType, *myinstrCatWriteFunc, *myReadBody,
      *myinstrCatReadFunc, * myinstrCatDisplayFunc;
    
    if (strcmp(opName, "P") == 0 || strcmp(opName, "WP") == 0 || 
        strcmp(opName, "X") == 0) return;

    //type declaration
    myOpName = UTIL_appendStr(opName, TYPE_SUFFIX);
    if (instrCatType) {
        myinstrCatType = HS_mkCrossType(instrCatType, myOpName);
        free(instrCatType);   free(myOpName);
        instrCatType = myinstrCatType;
    } else instrCatType = myOpName;

    //argument 
    myArgInd = UTIL_itoa(argInd);
    argInd++;
    myArg = UTIL_appendStr("arg", myArgInd);              free(myArgInd);
    //argument list
    if (argList) {
      myArgList = HS_mkArgList(argList, myArg); free(argList);
      argList = myArgList;
    } else argList = myArg;
    
    //write function
    myFuncName = UTIL_appendStr(PUT_PREFIX, opName);
    myFuncCall = UTIL_mallocStr(strlen(myFuncName) + strlen(myArg) + 5);
    strcpy(myFuncCall, myFuncName);     free(myFuncName);
    strcat(myFuncCall, " ");
    strcat(myFuncCall, myArg);    
    if (instrCatWriteFunc) {
        myinstrCatWriteFunc = HS_mkFuncSeq(instrCatWriteFunc, myFuncCall);
        free(instrCatWriteFunc);
        instrCatWriteFunc = myinstrCatWriteFunc;
        free(myFuncCall);
    } else instrCatWriteFunc =  myFuncCall;
    
    //read function
    myFuncName = UTIL_appendStr(GET_PREFIX, opName);
    myReadBody = HS_mkDO(myArg, myFuncName); free(myFuncName);
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
        myinstrCatDisplayFunc = HS_mkStrConcat(instrCatDisplayFunc, myFuncCall);
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
	char* instrCatType2 = UTIL_mallocStr(strlen(instrCatType) + 3);
	strcpy(instrCatType2, "(");
	strcat(instrCatType2, instrCatType);
	strcat(instrCatType2, ")");
	
    myCatName = UTIL_appendStr(INSCAT_PREFIX2, catName); 
    myInstrCatType = HS_mkTypeDec(myCatName, instrCatType2);
    myInstrCatTypes = addStr(instrCatTypes, myInstrCatType);

    myArgs = UTIL_mallocStr(strlen(argList) + 5);
    strcpy(myArgs, "(");
    strcat(myArgs, argList);           
    strcat(myArgs, ")");

    /* write function */
    myWriteFuncName = UTIL_appendStr(PUT_PREFIX, catName);
    myWriteFunc = HS_mkFunc(myWriteFuncName, myArgs, instrCatWriteFunc);
    myInstrCatWriteFuncs = addStr(instrCatWriteFuncs, myWriteFunc);
    
    /* read function */
    myReadFuncName = UTIL_appendStr(GET_PREFIX, catName);
    temp = UTIL_appendStr(INDENT, "return ");
    myArgs2 = UTIL_appendStr(temp, myArgs); free(temp);
    temp = UTIL_appendStr(instrCatReadFunc, myArgs2); free(myArgs2);
    myReadFuncBody= UTIL_appendStr("do\n", temp); free(temp);
    myReadFunc = HS_mkFunc(myReadFuncName, "", myReadFuncBody);
    myInstrCatReadFuncs = addStr(instrCatReadFuncs, myReadFunc);

    /* display function */
    myDisplayFuncName = UTIL_appendStr(DISPLAY_PREFIX, catName);
    myDisplayFunc = HS_mkFunc(myDisplayFuncName, myArgs, instrCatDisplayFunc);
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
    char* myVarName = UTIL_appendStr(INSCAT_PREFIX1, varName);
    char* varDef    = HS_mkVarDef(myVarName, "Int", numBytes);
    char* myInstrCatLength = addStr(instrCatLength, varDef);
    
    free(myVarName); free(varDef); free(instrCatLength);
    instrCatLength = myInstrCatLength;
}

static char* instrCat;

void ocgenInstrCat()
{
  char* text = instrCatTypes;
  char* text2 = addLine(text, "\n");
    
  text        = addLine(text2, instrCatWriteFuncs); 
  free(instrCatWriteFuncs); free(text2);
  
  text2 = addLine(text, instrCatReadFuncs);
  free(instrCatReadFuncs); free(text);
  
  text = addLine(text2, instrCatDisplayFuncs);
  free(instrCatDisplayFuncs); free(text2);
  
  instrCat = addLine(text, instrCatLength);  
  free(text); free(instrCatLength);
}

/****************************************************************************/
/* instructions                                                             */
/****************************************************************************/
#define GETSIZE_PREFIX "getSize_"
#define PUTOPCODE    "putopcode "

static char* instructionTypes;
static char* insWriteFuncBody;
static char* insReadFuncBody;
static char* insDisplayFuncBody;
static char* insSizesDec;
static char* insSizesDef;

static void ocgenReadFuncBody(char* opcode, char* myInsName, char* myInsLength, char* insCat, 
                              int last)
{
    char *ins, *readArgs, *returnValue, *myReadFuncBody, *tmp;    
    
    if (strcmp(insCat, "X") == 0) {
		readArgs = strdup(""); 
		ins = myInsName;
	} else {
        readArgs = UTIL_mallocStr(strlen(GET_PREFIX) +
                                  strlen(insCat) + 
                                  20);
        strcpy(readArgs, GET_PREFIX);
        strcat(readArgs, insCat);
        strcat(readArgs, " >>= \\x -> ");

        ins = UTIL_mallocStr(strlen(readArgs) + strlen(myInsName) + 10);
        strcpy(ins, myInsName);
        strcat(ins, " x");
    }
    
    returnValue = UTIL_mallocStr(strlen(readArgs) + 
                                 strlen(ins) + 
                                 strlen(myInsLength) + 
                                 20);
    strcpy(returnValue, readArgs);
    strcat(returnValue, "return (");
    strcat(returnValue, ins);
    strcat(returnValue, ", ");
    strcat(returnValue, myInsLength);
    strcat(returnValue, ")");

	free(readArgs);

    char *tmp2 = "     ";
    tmp  = addStr(tmp2, opcode);
    tmp2 = addStr(tmp, " -> "); free(tmp);
    tmp  = addStr(tmp2, returnValue); free(tmp2);
    tmp2 = addStr(tmp, "\n"); free(tmp);
    tmp  = tmp2;
    free(returnValue);
    
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
        strcat(ins, " ++ ");
        strcat(ins, displayargs);
        strcat(ins, " arg");
        free(displayargs); free(insText);
    }

    returnValue = UTIL_mallocStr(strlen(ins) + strlen(insLength) + 5);
    strcpy(returnValue, "(");
    strcat(returnValue,  ins);
    strcat(returnValue, ", ");
    strcat(returnValue, insLength);
    strcat(returnValue, ")");

    funcBody = HS_mkArrow(pattern, returnValue);
    free(returnValue);

    if (insDisplayFuncBody) {
        myDisplayFuncBody =  HS_mkCase(insDisplayFuncBody, funcBody);
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
        myCatName = UTIL_appendStr(INSCAT_PREFIX2, insCat); 
        myValueCtr = HS_mkValueCtr(myInsName, myCatName);   free(myCatName);
    }
    if (instructionTypes) {
        myInstrTypes = HS_mkDisjValueCtrs(instructionTypes, myValueCtr);
        free(instructionTypes);
        instructionTypes = myInstrTypes;
    } else instructionTypes = myValueCtr;

    /* write function body */
    myWriteOpCodeFunc = UTIL_appendStr(PUTOPCODE, opcode);
    if (strcmp(insCat, "X") == 0) {
        myPattern  = strdup(myInsName);   
        myfuncBody = myWriteOpCodeFunc;
    } else {
        char* myWriteArgsName = UTIL_appendStr(PUT_PREFIX, insCat);
        char* myWriteArgs = UTIL_mallocStr(strlen(myWriteArgsName) + 5);
        myPattern = HS_mkStructure(myInsName, "arg"); 
        strcpy(myWriteArgs, myWriteArgsName);           free(myWriteArgsName);
        strcat(myWriteArgs, " arg");
        myfuncBody = HS_mkFuncSeq(myWriteOpCodeFunc, myWriteArgs);
        free(myWriteArgs);
    }
    myFunc = HS_mkArrow(myPattern, myfuncBody); 
    free(myfuncBody);
    if (insWriteFuncBody) {
        myInsWriteFuncBody = HS_mkCase(insWriteFuncBody, myFunc);
        free(insWriteFuncBody); free(myFunc);
        insWriteFuncBody = myInsWriteFuncBody;
    } else {
        insWriteFuncBody = UTIL_appendStr(INDENT2, myFunc);
        free(myFunc);
    }
    /* instruction sizes */
    myInsSizeName = UTIL_appendStr(GETSIZE_PREFIX, insName); 
    myInsLength = UTIL_appendStr(INSCAT_PREFIX1, insLength); 
    mySizeDef =  HS_mkVarDef(myInsSizeName, "Int", myInsLength); 
    free(myInsSizeName);

    mySizeDefs = addStr(insSizesDef, mySizeDef); 
    free(insSizesDef); free(mySizeDef);
    
    insSizesDef = mySizeDefs;

    ocgenReadFuncBody(opcode, myInsName, myInsLength, insCat, last);
    ocgenDisplayFuncBody(myPattern, insName, myInsLength, insCat);
    
    free(myInsName); free(myInsLength); free(myPattern);
}

#define INSTRTYPE_HEAD "data Instruction\n  = "

#define INSTWRITEFUNC_DEF_HEAD "putInstruction :: Instruction -> Put\n" \
                               "putInstruction inst =\n" \
                               "  case inst of\n"

#define INSTREADFUNC_DEF_HEAD "getInstruction :: Get (Instruction,Int)\n" \
                              "getInstruction = do\n" \
                              "  opcode <- getopcode\n" \
                              "  case opcode of\n"

#define INSTDISPLAYFUNC_DEF_HEAD \
  "showInstruction :: Instruction -> (String, Int)\n" \
  "showInstruction inst =\n" \
  "  case inst of\n"

static char* instrHS;

void ocgenInstr()
{
    char* text = UTIL_appendStr(INSTRTYPE_HEAD, instructionTypes);
    char* text2 = UTIL_appendStr(text, "\n\n");
    
    free(instructionTypes); free(text);
    
    text =  addLine(text2, insSizesDef); free(text2); free(insSizesDef);
    text2 = addStr(text, INSTWRITEFUNC_DEF_HEAD);    free(text);    
    instrHS = addStr(text2, insWriteFuncBody);   
    free(text2); free(insWriteFuncBody);
    text  = addStr(instrHS, "\n\n"); free(instrHS);
    text2 = addStr(text, INSTREADFUNC_DEF_HEAD);     free(text);
    instrHS = addStr(text2, insReadFuncBody);        
    free(text2); free(insReadFuncBody);
    text = addStr(instrHS, "\n\n"); free(instrHS);
    text2 = addStr(text, INSTDISPLAYFUNC_DEF_HEAD);  free(text);
    instrHS = addStr(text2, insDisplayFuncBody);
    free(text2); free(insDisplayFuncBody);
}

/****************************************************************************/
/* dump files                                                               */
/****************************************************************************/
/* dump files */
void ocSpitInstructionHS(char * root)
{
    FILE* outFile;

    char * loc_path = "../../../compiler/GF/Compile/Instructions.hs";
    char * filename = malloc(strlen(root) + strlen(loc_path)+1);
    strcpy(filename, root);
    strcat(filename, loc_path);

    outFile = UTIL_fopenW(filename);
    fputs("module GF.Compile.Instructions where\n", outFile);
    fputs("\n", outFile);
    fputs("import Data.IORef\n", outFile);
    fputs("import Data.Binary\n", outFile);
    fputs("import Data.Binary.Put\n", outFile);
    fputs("import Data.Binary.Get\n", outFile);
    fputs("import Data.Binary.IEEE754\n", outFile);
    fputs("import PGF.CId\n", outFile);
    fputs("import PGF.Binary\n", outFile);
    fputs("\n", outFile);
    fputs("type IntRef = Int\n", outFile);
    fputs("type AConstant = CId\n", outFile);
    fputs("type AKind = CId\n", outFile);
	fputs("\n", outFile);
	fputs("ppE = undefined\n", outFile);
	fputs("ppF = undefined\n", outFile);
	fputs("ppL = undefined\n", outFile);
	fputs("ppC = undefined\n", outFile);
	fputs("ppN = undefined\n", outFile);
	fputs("ppR = undefined\n", outFile);
	fputs("ppK = undefined\n", outFile);
	fputs("ppS = undefined\n", outFile);
	fputs("ppI = undefined\n", outFile);
	fputs("ppI1 = undefined\n", outFile);
	fputs("ppIT = undefined\n", outFile);
	fputs("ppCE = undefined\n", outFile);
	fputs("ppMT = undefined\n", outFile);
	fputs("ppHT = undefined\n", outFile);
	fputs("ppSEG = undefined\n", outFile);
	fputs("ppBVT = undefined\n", outFile);	
	fputs("\n", outFile);

    fputs(opHS, outFile);              free(opHS);
    fputs(instrCat, outFile);          free(instrCat);
    fputs("\n\n", outFile);
    fputs(instrHS, outFile);           free(instrHS);
   	free(typeDefs);

    UTIL_fclose(outFile);    
    free(filename);
}
