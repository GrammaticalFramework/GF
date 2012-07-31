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
/* ocamlcode.c.                                                            */
/* This file defines auxiliary functions in making pervasives.h and        */
/* pervasives.c.                                                           */
/* Since space and time efficiency is not an important concern in the      */
/* system source code generation phase, the code here is structured in the */
/* way for the convenience of making changes on pervasive.mli{ml}.         */
/***************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ccode.h"
#include "types.h"
#include "../util/util.h" //to be modified

/**************************************************************************/
/* Functions for making various language constructs                       */
/**************************************************************************/
/* // <comments> */
char* C_mkOneLineComments(char* comments)
{
  size_t length = strlen(comments) + 5;
  char* commentsText = UTIL_mallocStr(length);

  strcpy(commentsText, "// ");
  strcat(commentsText, comments);

  return commentsText;
}

/* <varName> = <varValue> */
char* C_mkAssign(char* varName, char* varValue)
{
  size_t length = strlen(varName) + strlen(varValue) + 5;
  char* assign = UTIL_mallocStr(length);

  strcpy(assign, varName);
  strcat(assign, " = ");
  strcat(assign, varValue);

  return assign;
}

/* #define <macroName> <macroValue> */
char* C_mkDefine(char* macroName, char* macroValue)
{
  size_t length = strlen(macroName) + strlen(macroValue) + 10;
  char* def = UTIL_mallocStr(length);
  
  strcpy(def, "#define ");
  strcat(def, macroName);
  strcat(def, " ");
  strcat(def, macroValue);

  return def;
}

/* enum <typeName>\n {\n <body> } */
char* C_mkEnum(char* typeName, char* body)
{
  size_t length = strlen(typeName) + strlen(body) + 15;
  char* enumText = UTIL_mallocStr(length);
  
  strcpy(enumText, "enum ");
  strcat(enumText, typeName);
  strcat(enumText, "\n{\n");
  strcat(enumText, body);
  strcat(enumText, "}");

  return enumText;
}

/* typedef <typeStr> <typeName>; \n\n */
char* C_mkTypeDef(char* typeStr, char* typeName)
{
  size_t length = strlen(typeStr) + strlen(typeName) + 15;
  char* typeDefText = UTIL_mallocStr(length);
  
  strcpy(typeDefText, "typedef ");
  strcat(typeDefText, typeStr);
  strcat(typeDefText, " ");
  strcat(typeDefText, typeName);
  strcat(typeDefText, ";\n\n");

  return typeDefText;
}

/********************************************************************/
/* Names                                                            */
/********************************************************************/
#define C_INDENT        "    "

#define C_PREFIX        "PERV_"
#define C_SUFFIX        "_INDEX"

#define C_NUMKINDS      "PERV_KIND_NUM" 
#define C_NUMTYSKELS    "PERV_TY_SKEL_NUM"
#define C_NUMCONSTS     "PERV_CONST_NUM"    

#define C_TY_KINDIND    "PERV_KindIndexType"
#define C_TY_CONSTIND   "PERV_ConstIndexType"


/* PERV_<name>_INDEX */
char* C_mkIndexName(char* name)
{
  char* nameUC = UTIL_upperCase(name);
  size_t   length = strlen(nameUC) + strlen(C_PREFIX) + strlen(C_SUFFIX);
  char* indexName = UTIL_mallocStr(length);

  strcpy(indexName, C_PREFIX);
  strcat(indexName, nameUC);          free(nameUC);
  strcat(indexName, C_SUFFIX);

  return indexName;
}

/* PERV_<name> */
char* C_mkIndexName2(char* name)
{
  char* nameUC = UTIL_upperCase(name);
  size_t length = strlen(nameUC) + strlen(C_PREFIX);
  char* indexName = UTIL_mallocStr(length);

  strcpy(indexName, C_PREFIX);
  strcat(indexName, nameUC);          free(nameUC);

  return indexName;    
}

/* 
    //comments \n
    PERV_<name>_INDEX = <indexNum>
*/
char* C_mkIndex(char* name, char* indexNum, char* comments)
{
  char* commentText = (comments) ? C_mkOneLineComments(comments) : NULL;
  char* varName = C_mkIndexName(name);
  char* assign  = C_mkAssign(varName, indexNum);
  size_t length  = ((commentText) ? strlen(commentText) + strlen(C_INDENT): 0) 
      + strlen(assign) + strlen(C_INDENT) + 5;
  char* index = UTIL_mallocStr(length);

  free(varName);
  strcpy(index, C_INDENT);
  if (commentText) {
    strcat(index, commentText); strcat(index, "\n"); 
    strcat(index, C_INDENT);    free(commentText);
  }
  strcat(index, assign);   free(assign);

  return index;
}

/*
    PERV_<name> = <indexNum>
*/
char* C_mkIndex2(char* name, char* indexNum)
{
    char* varName = C_mkIndexName2(name);
    char* assign  = C_mkAssign(varName, indexNum); 
    char* index   = UTIL_mallocStr(strlen(assign) + strlen(C_INDENT));

    free(varName);
    strcpy(index, C_INDENT);  
    strcat(index, assign);   free(assign);
    
    return index;
}

/*    // empty */
char* C_mkEmptyComments()
{
    size_t length = strlen(C_INDENT) + 10;
    char* text = UTIL_mallocStr(length);
    
    strcpy(text, C_INDENT);
    strcat(text, "// empty\n");
    
    return text;
}

/********************************************************************/
/* Kind relevant components                                         */
/********************************************************************/
/***************************************************************/
/* pervasives.h                                                */
/***************************************************************/
#define C_NUMKINDS_COMMENTS "//total number of pervasive kinds\n"

/* 
  //total number of pervasive kinds \n" 
  #define PERV_KIND_NUM <num> \n
*/
char* C_mkNumKinds(char* num)
{
  char* def = C_mkDefine(C_NUMKINDS, num);
  size_t length = strlen(def) + strlen(C_NUMKINDS_COMMENTS) + 5;
  char* numKinds = UTIL_mallocStr(length);

  strcpy(numKinds, C_NUMKINDS_COMMENTS);
  strcat(numKinds, def);         free(def);
  strcat(numKinds, "\n\n");
  
  return numKinds;
}

#define C_KINDINDEX_COMMENTS \
"//indices for predefined sorts and type constructors\n"
/*
  //indices for predefined sorts and type constructors\n"
  typedef enum PERV_KindIndexType \n
  { <body> } PERV_KindIndexType; \n
*/      
char* C_mkKindIndexType(char* body)
{
    char* enumText = C_mkEnum(C_TY_KINDIND, body);
    char* typeDefText = C_mkTypeDef(enumText, C_TY_KINDIND);
    size_t length = strlen(typeDefText) + strlen(C_KINDINDEX_COMMENTS);
    char* kindIndexType = UTIL_mallocStr(length);
    
    strcpy(kindIndexType, C_KINDINDEX_COMMENTS);
    strcat(kindIndexType, typeDefText);
    free(enumText); free(typeDefText);
    
    return kindIndexType;
}

//comments
#define C_KIND_COMMENTS \
"/****************************************************************************/\n/*   PERVASIVE KIND                                                         */ \n/****************************************************************************/ \n"
//PERV_KindData 
#define C_KINDDATA_TYPE_DEF \
"//pervasive kind data type                                                    \ntypedef struct                                                                 \n{                                                                              \n    char         *name;                                                        \n    TwoBytes     arity;                                                        \n} PERV_KindData;                                                             \n\n" 

//PERV_kindDataTab
#define C_KINDDATATAB_DEC \
"//pervasive kind data table (array)                                           \nextern PERV_KindData    PERV_kindDataTab[PERV_KIND_NUM];                     \n\n"

//PERV_genKindData
#define C_GETKINDDATA_DEC \
"//pervasive kind data access function                                         \nPERV_KindData PERV_getKindData(int index);                                   \n\n"

//PERV_copyKindDataTab
#define C_COPYKINDDATATAB_DEC \
"//pervasive kind table copy function (used in module space initialization)    \n//this functiion relies on the assumption that the pervasive kind data         \n//has the same structure as that of the run-time kind symbol table entries.    \nvoid PERV_copyKindDataTab(PERV_KindData* dst);                               \n\n"
char* C_mkKindH(char* kindIndexType, char* numKinds)
{
    size_t length = strlen(C_KIND_COMMENTS) + strlen(kindIndexType) + 
        strlen(numKinds) + strlen(C_KINDDATA_TYPE_DEF) + 
        strlen(C_KINDDATATAB_DEC) + strlen(C_GETKINDDATA_DEC) + 
        strlen(C_COPYKINDDATATAB_DEC);
    char* kindH = UTIL_mallocStr(length);
    
    strcpy(kindH, C_KIND_COMMENTS);
    strcat(kindH, kindIndexType);
    strcat(kindH, numKinds);
    strcat(kindH, C_KINDDATA_TYPE_DEF);
    strcat(kindH, C_KINDDATATAB_DEC);
    strcat(kindH, C_GETKINDDATA_DEC);
    strcat(kindH, C_COPYKINDDATATAB_DEC);

    return kindH;
}

/***************************************************************/
/* pervasives.c                                                */
/***************************************************************/
/*
  //comments \n
  {"<name>",     <arity>}
*/
char* C_mkKindTabEntry(char* name, char* arity, char* comments)
{
    char* commentText = (comments) ? C_mkOneLineComments(comments) : NULL;
    size_t length = ((commentText) ? strlen(commentText) + strlen(C_INDENT): 0) 
        + strlen(name) + strlen(arity) + strlen(C_INDENT)*2 + 10;
    char* entry = UTIL_mallocStr(length);
    
    strcpy(entry, C_INDENT);
    if (commentText) {
    strcat(entry, commentText); strcat(entry, "\n"); 
    strcat(entry, C_INDENT);    free(commentText);
    }
    strcat(entry, "{\"");
    strcat(entry, name);
    strcat(entry, "\",");
    strcat(entry, C_INDENT);
    strcat(entry, arity);
    strcat(entry, "}");
    
    return entry;
}

#define C_KIND_TAB_BEG \
"//pervasive kind data table (array)                                           \nPERV_KindData   PERV_kindDataTab[PERV_KIND_NUM] = {                            \n   //name,            arity                                                    \n"
#define C_KIND_TAB_END       "};\n\n"

/* 
  //pervasive kind data table (array)                                           
  PERV_KindData   PERV_kindDataTab[PERV_KIND_NUM] = { \n body \n};\n
*/
char* C_mkKindTab(char* body)
{
    size_t length = strlen(C_KIND_TAB_BEG) + strlen(C_KIND_TAB_END) + strlen(body);
    char* kindTab = UTIL_mallocStr(length);
    
    strcpy(kindTab, C_KIND_TAB_BEG);
    strcat(kindTab, body);
    strcat(kindTab, C_KIND_TAB_END);
    
    return kindTab;
}

//PERV_getKindData
#define C_GETKINDDATA_DEF \
"PERV_KindData PERV_getKindData(int index)                                     \n{                                                                              \n    return PERV_kindDataTab[index];                                            \n}                                                                            \n\n"
//PERV_copyKindDataTab
#define C_COPYKINDDATATAB_DEF \
"void PERV_copyKindDataTab(PERV_KindData* dst)                                 \n{                                                                              \n    //this way of copy relies on the assumption that the pervasive kind data   \n    //has the same structure as that of the run-time kind symbol table entries.\n    memcpy((void*)dst, (void*)PERV_kindDataTab,                                \n           sizeof(PERV_KindData) * PERV_KIND_NUM);                             \n}                                                                            \n\n"

char* C_mkKindC(char* kindTab)
{
    size_t length = strlen(C_KIND_COMMENTS) + strlen(kindTab) +
        strlen(C_GETKINDDATA_DEF) + strlen(C_COPYKINDDATATAB_DEF);
    char* kindC = UTIL_mallocStr(length);
    
    strcpy(kindC, C_KIND_COMMENTS);
    strcat(kindC, kindTab);
    strcat(kindC, C_GETKINDDATA_DEF);
    strcat(kindC, C_COPYKINDDATATAB_DEF);
    
    return kindC;
}


/*********************************************************************/
/* Type Skeleton relevant components                                 */
/*********************************************************************/
#define C_NUMTYSKELS_COMMENTS \
"//total number of type skeletons needed for pervasive constants\n"


/* 
  //total number of type skeletons needed for pervasive constants\n
  #define PERV_TY_SKEL_NUM <num> \n
*/
char* C_mkNumTySkels(char* num)
{
  char* def = C_mkDefine(C_NUMTYSKELS, num);
  size_t length = strlen(def) + strlen(C_NUMTYSKELS_COMMENTS) + 5;
  char* numTySkels = UTIL_mallocStr(length);

  strcpy(numTySkels, C_NUMTYSKELS_COMMENTS);
  strcat(numTySkels, def);         free(def);
  strcat(numTySkels, "\n\n");
  
  return numTySkels;
}

//comments
#define C_TYSKEL_COMMENTS \
"/***************************************************************************/\n/*   TYPE SKELETIONS FOR PERVASIVE CONSTANTS                                */ \n/****************************************************************************/\n\n"
//PERV_TySkelData
#define C_TYSKELDATA_TYPE_DEF \
"//pervasive type skel data type                                               \ntypedef DF_TypePtr  PERV_TySkelData;                                         \n\n"

//PERV_TySkelTab
#define C_TYSKELTAB_DEC \
"//pervasive type skel table (array)                                           \nextern  PERV_TySkelData   PERV_tySkelTab[PERV_TY_SKEL_NUM];                  \n\n"

//PERV_tySkelTabInit
#define C_TYSKELTABINIT_DEC \
"//pervasive type skeletons and type skeleton table initialization             \n//Note that type skeltons have to be dynamically allocated, and so does the    \n//info recorded in each entry of the pervasive type skeleton table             \nvoid PERV_tySkelTabInit();                                                   \n\n"

//PERV_copyTySkelTab
#define C_COPYTYSKELTAB_DEC \
"//pervasive tyskel table copy function                                        \nvoid PERV_copyTySkelTab(PERV_TySkelData* dst);                               \n\n"

char* C_mkTySkelsH(char* numTySkels)
{
    size_t length = strlen(C_TYSKEL_COMMENTS) + strlen(numTySkels) + 
        strlen(C_TYSKELDATA_TYPE_DEF) + strlen(C_TYSKELTAB_DEC) + 
        strlen(C_TYSKELTABINIT_DEC) + strlen(C_COPYTYSKELTAB_DEC);
    char* tySkelsH = UTIL_mallocStr(length);
    
    strcpy(tySkelsH, C_TYSKEL_COMMENTS);
    strcat(tySkelsH, numTySkels);
    strcat(tySkelsH, C_TYSKELDATA_TYPE_DEF);
    strcat(tySkelsH, C_TYSKELTAB_DEC);
    strcat(tySkelsH, C_TYSKELTABINIT_DEC);
    strcat(tySkelsH, C_COPYTYSKELTAB_DEC);
    
    return tySkelsH;
}

/************************************************************************/
/* pervasives.c                                                         */
/************************************************************************/
//manipulating each type skeleton
#define MKSKVARTYPE_BEG "    DF_mkSkelVarType(tySkelBase, "
#define MKSORTTYPE_BEG  "    DF_mkSortType(tySkelBase, "
#define MKATOMTYPE_END  ");\n"
#define MKARROWTYPE_BEG \
"    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + "
#define MKSTRTYPE_BEG  \
"    DF_mkStrType(tySkelBase, (DF_TypePtr)(tySkelBase + "
#define MKSTRFUNCTYPE_BEG "    DF_mkStrFuncType(tySkelBase, "
#define MKCOMPTYPE_END " * DF_TY_ATOMIC_SIZE));\n"
#define TYSKELBASE_INC "    tySkelBase += DF_TY_ATOMIC_SIZE;\n"

static char* C_genTySkelSort(char* name)
{
    char* kindName = C_mkIndexName(name);
    char* mytext = NULL;
    mytext = UTIL_mallocStr(strlen(MKSORTTYPE_BEG) + strlen(MKATOMTYPE_END) +
                            strlen(kindName) + strlen(TYSKELBASE_INC));

    strcpy(mytext, MKSORTTYPE_BEG);
    strcat(mytext, kindName);           free(kindName);
    strcat(mytext, MKATOMTYPE_END);
    strcat(mytext, TYSKELBASE_INC);
    return mytext;
}

static char* C_genTySkelSkVar(char* index)
{
    char* mytext = NULL;
    mytext = UTIL_mallocStr(strlen(MKSKVARTYPE_BEG) + strlen(MKATOMTYPE_END) +
                            strlen(index) + strlen(TYSKELBASE_INC));
  
    strcpy(mytext, MKSKVARTYPE_BEG);
    strcat(mytext, index);
    strcat(mytext, MKATOMTYPE_END);
    strcat(mytext, TYSKELBASE_INC);
    return mytext;
}

static char* C_genTySkelFunc(char* name, char* arity)
{
    char* kindName = C_mkIndexName(name);
    char* mytext = NULL;
    mytext = UTIL_mallocStr(strlen(MKSTRFUNCTYPE_BEG) + strlen(kindName) +
                            strlen(arity) + strlen(MKATOMTYPE_END) +
                            strlen(TYSKELBASE_INC) + 5);

    strcpy(mytext, MKSTRFUNCTYPE_BEG);
    strcat(mytext, kindName);              free(kindName);
    strcat(mytext, ", ");
    strcat(mytext, arity);
    strcat(mytext, MKATOMTYPE_END);
    strcat(mytext, TYSKELBASE_INC);
    return mytext;
}

static char* C_genTySkelArrow(int argPosNum)
{
    char* argPos = UTIL_itoa(argPosNum);
    char* mytext = NULL;
    mytext = UTIL_mallocStr(strlen(MKARROWTYPE_BEG) + strlen(argPos) +
                            strlen(MKCOMPTYPE_END) + strlen(TYSKELBASE_INC));

    strcpy(mytext, MKARROWTYPE_BEG);
    strcat(mytext, argPos);           free(argPos);
    strcat(mytext, MKCOMPTYPE_END);
    strcat(mytext, TYSKELBASE_INC);
    return mytext;
}

static char* C_genTySkelStr(int argPosNum)
{
    char* argPos = UTIL_itoa(argPosNum);
    char* mytext = NULL;
    mytext = UTIL_mallocStr(strlen(MKSTRTYPE_BEG) + strlen(argPos) +
                            strlen(MKCOMPTYPE_END) + strlen(TYSKELBASE_INC));

    strcpy(mytext, MKSTRTYPE_BEG);
    strcat(mytext, argPos);          free(argPos);
    strcat(mytext, MKCOMPTYPE_END);
    strcat(mytext, TYSKELBASE_INC);
    return mytext;
}    

//data structure used for breath-first traversal of type skels
typedef struct Types
{
    int      length;
    TypeList types;
} Types;

int C_totalSpace = 0;

static char* C_genOneTySkel(Types types)
{
    TypeList typeList = types.types;
    int      length   = types.length;
    char*    mytext   = NULL;
    
    if (length) {
        Type     myType    = typeList -> oneType;
        TypeList remaining = typeList -> next;
        char *mytext1 = NULL, *mytext2 = NULL;
        free(typeList);
        switch (myType -> tag){
        case SORT:
        {
            mytext1 = C_genTySkelSort(myType->data.sort);
            C_totalSpace++;
            types.types = remaining;
            types.length = length-1;
            mytext2 = C_genOneTySkel(types);
            break;
        }
        case SKVAR:
        {
            mytext1 = C_genTySkelSkVar(myType->data.skvar);
            C_totalSpace++;
            types.types = remaining;
            types.length = length-1;
            mytext2 = C_genOneTySkel(types);
            break;
        }
        case FUNC:
        {
            mytext1 = C_genTySkelFunc(myType->data.func.name, 
                                      myType->data.func.arity);
            C_totalSpace++;
            types.types = remaining;
            types.length = length -1;
            mytext2 = C_genOneTySkel(types); 
            break;
        }
        case ARROW:
        {            
            Type lop = myType->data.arrow.lop;
            Type rop = myType->data.arrow.rop;
            mytext1 = C_genTySkelArrow(length);
            C_totalSpace++;
            remaining = addItemToEnd(remaining, lop);
            types.types = addItemToEnd(remaining, rop);
            types.length = length+1;
            mytext2 = C_genOneTySkel(types);
            break;
        }
        case STR:
        {
            Type     func = myType->data.str.functor;
            TypeList args = myType->data.str.args;
            int      arity = myType -> data.str.arity;
            mytext1 = C_genTySkelStr(length);
            C_totalSpace++;
            remaining = addItemToEnd(remaining, func);
            types.types = append(remaining, args);
            types.length = length + arity;
            mytext2 = C_genOneTySkel(types);
            break;
        }
        }
        freeType(myType);
        mytext = UTIL_mallocStr(strlen(mytext1) + strlen(mytext2));
        strcpy(mytext, mytext1); free(mytext1);
        strcat(mytext, mytext2); free(mytext2);
    } else {
        mytext = strdup("");
    }  
    return mytext;
}

#define C_TYSKELS_PRE \
"PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;\n    tySkelInd++;\n"

char* C_genTySkel(Type tyskel, char* comments)
{
    char* commentText = (comments) ? C_mkOneLineComments(comments) : NULL;
    Types tyskels;
    char* tyskelText1;
    char* tyskelText2;
    size_t length; 
    
    tyskels.length = 1;
    tyskels.types  = addItem(tyskel, NULL);
    tyskelText1 = C_genOneTySkel(tyskels);

    length = ((commentText) ? strlen(commentText) + strlen(C_INDENT): 0)
        + strlen(tyskelText1) + strlen(C_TYSKELS_PRE) + strlen(C_INDENT) + 5;
    tyskelText2 = UTIL_mallocStr(length);
    
    strcpy(tyskelText2, C_INDENT);
    if (commentText) {
        strcat(tyskelText2, commentText); free(commentText);
        strcat(tyskelText2, "\n");
    }
    strcat(tyskelText2, C_INDENT);
    strcat(tyskelText2, C_TYSKELS_PRE);
    strcat(tyskelText2, tyskelText1);     free(tyskelText1);
    strcat(tyskelText2, "\n");
    
    return tyskelText2;
}

#define TYSKELTABINIT_BEG \
"//pervasive type skeletons and type skeleton table initialization             \n//The type skeletons are created in the memory of the system through malloc,   \n//and addresses are entered into the pervasive type skeleton table.            \nvoid PERV_tySkelTabInit()                                                      \n{                                                                              \n    int tySkelInd = 0; //ts tab index\n"
#define TYSKELTABINIT_END "}\n\n"

#define TYSPACE_BEG "    MemPtr tySkelBase = (MemPtr)EM_malloc(WORD_SIZE * "
#define TYSPACE_END " ); //ts area\n\n"

char* C_mkTySkelTabInit(char* body, int space)
{
    char* spaceText = UTIL_itoa(space * 2);
    char* tabInit = UTIL_mallocStr(strlen(TYSKELTABINIT_BEG) + 
                                   strlen(TYSPACE_BEG) + strlen(spaceText) +
                                   strlen(TYSPACE_END) + strlen(body) +
                                   strlen(TYSKELTABINIT_END));
    strcpy(tabInit, TYSKELTABINIT_BEG);
    strcat(tabInit, TYSPACE_BEG);
    strcat(tabInit, spaceText);          free(spaceText);
    strcat(tabInit, TYSPACE_END);
    strcat(tabInit, body);
    strcat(tabInit, TYSKELTABINIT_END);
    
    return tabInit;
}


//PERV_tySkelTab
#define TYSKELTAB_DEF     \
"//pervasive type skeleton table (array)                                       \nPERV_TySkelData   PERV_tySkelTab[PERV_TY_SKEL_NUM];                        \n\n"

//PERV_copyTySkelTab
#define COPYTYSKELTAB_DEF \
"void PERV_copyTySkelTab(PERV_TySkelData* dst)                                 \n{                                                                              \n    memcpy((void*)dst, (void*)PERV_tySkelTab,                                  \n           sizeof(PERV_TySkelData) * PERV_KIND_NUM);                           \n}\n\n"
char* C_mkTySkelsC(char* tySkelTab)
{
    char* text = UTIL_mallocStr(strlen(C_TYSKEL_COMMENTS) + 
                                strlen(TYSKELTAB_DEF) +
                                strlen(tySkelTab) +
                                strlen(COPYTYSKELTAB_DEF));
    strcpy(text, C_TYSKEL_COMMENTS);
    strcat(text, TYSKELTAB_DEF);
    strcat(text, tySkelTab);
    strcat(text, COPYTYSKELTAB_DEF);
    
    return text;
}
  
/*********************************************************************/
/* Constant relevant components                                      */
/*********************************************************************/
#define C_NUMCONSTS_COMMENTS \
"//total number pervasive constants\n"

/*  
  //total number pervasive constants\n
  #define PERV_CONST_NUM <num> \n
*/
char* C_mkNumConsts(char* num)
{
    char* def = C_mkDefine(C_NUMCONSTS, num); 
    size_t length = strlen(def) + strlen(C_NUMCONSTS_COMMENTS) + 5;
    char* numConsts = UTIL_mallocStr(length);
    
    strcpy(numConsts, C_NUMCONSTS_COMMENTS);
    strcat(numConsts, def);         free(def);
    strcat(numConsts, "\n\n");
    
    return numConsts;
}

#define C_CONSTINDEX_COMMENTS \
"//indices for predefined constants\n"

char* C_mkConstIndexType(char* body)
{
    char* enumText = C_mkEnum(C_TY_CONSTIND, body);
    char* typeDefText = C_mkTypeDef(enumText, C_TY_CONSTIND);
    size_t length = strlen(typeDefText) + strlen(C_CONSTINDEX_COMMENTS);
    char* constIndexType = UTIL_mallocStr(length);
    
    strcpy(constIndexType, C_CONSTINDEX_COMMENTS);
    strcat(constIndexType, typeDefText);
    free(enumText); free(typeDefText);
    
    return constIndexType;
}

//comments
#define C_CONST_COMMENTS \
"/***************************************************************************/ \n/*   PERVASIVE CONSTANTS                                                   */  \n/***************************************************************************/\n\n"

//PERV_ConstData
#define C_CONSTDATA_TYPE \
"//pervasive const data type                                                   \ntypedef struct                                                                 \n{                                                                              \n    char      *name;                                                           \n    TwoBytes  typeEnvSize;                                                     \n    TwoBytes  tskTabIndex;     //index to the type skeleton table              \n    TwoBytes  neededness;      //neededness (predicate constant)               \n    TwoBytes  univCount;                                                       \n    int       precedence;                                                      \n    int       fixity;                                                          \n} PERV_ConstData; \n\n"

//PERV_ConstDataTab
#define C_CONSTDATA_TAB_DEC \
"//pervasive const data table (array)                                          \nextern PERV_ConstData    PERV_constDataTab[PERV_CONST_NUM]; \n\n"

//PERV_getConstData
#define C_GETCONSTDATA_DEC  \
"//pervasive const data access function                                        \nPERV_ConstData PERV_getConstData(int index);  \n\n"

//PERV_copyConstDataTab
#define C_COPYCONSTDATATAB_DEC \
"//pervasive const table copy function (used in module space initialization)   \n//this functiion relies on the assumption that the pervasive kind data         \n//has the same structure as that of the run-time kind symbol table entries.    \nvoid PERV_copyConstDataTab(PERV_ConstData* dst); \n\n"

//PERV_isLogicSymb PERV_isPredSymb
#define C_ISLS_ISPS_DEC \
"//functions used by the simulator for interpreted goals                       \nBoolean PERV_isLogicSymb(int index);                                           \nBoolean PERV_isPredSymb(int index); \n\n"


//PERV_logicSymb
#define C_LOGICSYMB_DEC "PERV_LogicSymbTypes PERV_logicSymb(int index); \n\n"

//PERV_predBuiltin
#define C_PREDBUILTIN_DEC "int PERV_predBuiltin(int index); \n\n"

char*  C_mkConstH(char* constIndexType, char* numConsts, char* property)
{
    size_t length = strlen(C_CONST_COMMENTS) + strlen(constIndexType) + 
        strlen(numConsts) + strlen(C_CONSTDATA_TYPE) + 
        strlen(C_CONSTDATA_TAB_DEC) + strlen(C_GETCONSTDATA_DEC) + 
        strlen(C_COPYCONSTDATATAB_DEC) + strlen(property) +
        strlen(C_ISLS_ISPS_DEC) + strlen(C_LOGICSYMB_DEC) + 
        strlen(C_PREDBUILTIN_DEC);
    char* constH = UTIL_mallocStr(length);
    
    strcpy(constH, C_CONST_COMMENTS);
    strcat(constH, constIndexType);
    strcat(constH, numConsts);
    strcat(constH, C_CONSTDATA_TYPE);
    strcat(constH, C_CONSTDATA_TAB_DEC);
    strcat(constH, C_GETCONSTDATA_DEC);
    strcat(constH, C_COPYCONSTDATATAB_DEC);
    strcat(constH, property);
    strcat(constH, C_ISLS_ISPS_DEC);
    strcat(constH, C_LOGICSYMB_DEC);
    strcat(constH, C_PREDBUILTIN_DEC);
    
    return constH;
}

/***************************************************************/
/* pervasives.c                                                */
/***************************************************************/
//traslate precedence info into a string
static char* C_mkPrec(OP_Prec prec)
{
    if (OP_precIsMax(prec)) return strdup("256");
    else return UTIL_itoa(prec.data.prec);
}
//translate fixity info into a string
static char* C_mkFixity(OP_Fixity fixity)
{
    switch (fixity){
    case OP_INFIX        : return strdup("OP_INFIX");
    case OP_INFIXL       : return strdup("OP_INFIXL");
    case OP_INFIXR       : return strdup("OP_INFIXR");
    case OP_PREFIX       : return strdup("OP_PREFIX");
    case OP_PREFIXR      : return strdup("OP_PREFIXR");
    case OP_POSTFIX      : return strdup("OP_POSTFIX");
    case OP_POSTFIXL     : return strdup("OP_POSTFIXL");
    case OP_NONE         : return strdup("OP_NONE");
    default              : return strdup("OP_NONE");
    }
}


//   { name,  tesize, tst, (need), UC, prec, fixity }   
char* C_mkConstTabEntry(char* name, char* tesize, OP_Prec prec, 
                        OP_Fixity fixity, char* tyskelInd, char* neededness,
                        char* comments)
{
    char* commentText = (comments) ? C_mkOneLineComments(comments) : NULL;
    char* precText    = C_mkPrec(prec);
    char* fixityText  = C_mkFixity(fixity);
    size_t length = ((commentText) ? strlen(commentText) + strlen(C_INDENT): 0)
        + strlen(name) + strlen(tesize) + strlen(tyskelInd)  
        + strlen(neededness) + strlen(precText) + strlen(fixityText) 
        + strlen(C_INDENT)*7 + 15;
    char* entry = UTIL_mallocStr(length);
        
    strcpy(entry, C_INDENT);
    if (commentText) {
        strcat(entry, commentText); strcat(entry, "\n"); 
        strcat(entry, C_INDENT);    free(commentText);
    }
    strcat(entry, "{\"");
    strcat(entry, name);
    strcat(entry, "\",");
    strcat(entry, C_INDENT);
    strcat(entry, tesize);
    strcat(entry, ",");
    strcat(entry, C_INDENT);
    strcat(entry, tyskelInd);
    strcat(entry, ",");
    strcat(entry, C_INDENT);
    strcat(entry, neededness);
    strcat(entry, ",");
    strcat(entry, C_INDENT);
    strcat(entry, "0,");
    strcat(entry, C_INDENT);
    strcat(entry, precText);   free(precText);
    strcat(entry, ",");
    strcat(entry, C_INDENT);
    strcat(entry, fixityText); free(fixityText);
    strcat(entry, "}");
    
    return entry;
}


#define C_CONST_TAB_BEG \
"//pervasive constant data table (array)                                       \nPERV_ConstData   PERV_constDataTab[PERV_CONST_NUM] = {                         \n    //name,   tesize, tst, neededness, UC, prec,  fixity                       \n"
#define C_CONST_TAB_END       "};\n\n"

/* 
  //pervasive const data table (array)                                         
  PERV_ConstData   PERV_constDataTab[PERV_CONST_NUM] = { \n body \n};\n
*/
char* C_mkConstTab(char* body)
{
    size_t length = strlen(C_CONST_TAB_BEG) + strlen(C_CONST_TAB_END) + 
        strlen(body);
    char* constTab = UTIL_mallocStr(length);
    
    strcpy(constTab, C_CONST_TAB_BEG);
    strcat(constTab, body);
    strcat(constTab, C_CONST_TAB_END);
    
    return constTab;
}

//PERV_getConstData
#define C_GETCONSTDATA_DEF \
"PERV_ConstData PERV_getConstData(int index)                                   \n{                                                                              \n        return PERV_constDataTab[index];                                       \n}                                                                          \n\n"

//PERV_copyConstDataTab
#define C_COPYCONSTDATATAB_DEF \
"void PERV_copyConstDataTab(PERV_ConstData* dst)                               \n{                                                                              \n    //this way of copy relies on the assumption that the pervasive kind data   \n    //has the same structure as that of the run-time kind symbol table entries.\n    memcpy((void*)dst, (void*)PERV_constDataTab,                               \n           sizeof(PERV_ConstData) * PERV_CONST_NUM);                           \n}                                                                          \n\n"

//PERV_isLogicSymb
#define C_ISLOGICSYMB_DEF \
"Boolean PERV_isLogicSymb(int index)                                           \n{                                                                              \n    return ((index >= PERV_LSSTART) && (index <= PERV_LSEND));                  \n}\n\n"

//PERV_isPredSymb
#define C_ISPREDSYMB_DEF \
"Boolean PERV_isPredSymb(int index)                                            \n{                                                                              \n    return ((index >= PERV_PREDSTART) && (index <= PERV_PREDEND));           \n}\n\n"

//PERV_logicSymb
#define C_LOGICSYMB_DEF \
"PERV_LogicSymbTypes PERV_logicSymb(int index)                                 \n{                                                                              \n    return ((PERV_LogicSymbTypes)(index - PERV_LSSTART));                      \n}\n\n"

//PERV_predBuiltin
#define C_PREDBUILTIN_DEF \
"int PERV_predBuiltin(int index)                                               \n{                                                                              \n    return (index - PERV_PREDSTART);                                           \n}\n\n"

char* C_mkConstC(char* constTab)
{
    size_t length = strlen(C_CONST_COMMENTS) + strlen(constTab) +
        strlen(C_GETCONSTDATA_DEF) + strlen(C_COPYCONSTDATATAB_DEF) +
        strlen(C_ISLOGICSYMB_DEF) + strlen(C_ISPREDSYMB_DEF) + 
        strlen(C_LOGICSYMB_DEF) + strlen(C_PREDBUILTIN_DEF);
    char* constC = UTIL_mallocStr(length);
    
    strcpy(constC, C_CONST_COMMENTS);
    strcat(constC, constTab);               
    strcat(constC, C_GETCONSTDATA_DEF);
    strcat(constC, C_COPYCONSTDATATAB_DEF);
    strcat(constC, C_ISLOGICSYMB_DEF);
    strcat(constC, C_ISPREDSYMB_DEF);
    strcat(constC, C_LOGICSYMB_DEF);
    strcat(constC, C_PREDBUILTIN_DEF);

    return constC;
}

#define LOGICSYMBTYPE_DEC_BEG \
"typedef enum PERV_LogicSymbTypes                                              \n{\n"
#define LOGICSYMBTYPE_DEC_END "} PERV_LogicSymbTypes;\n\n"

char* C_mkLSTypeDec(char* body)
{
    size_t length = strlen(LOGICSYMBTYPE_DEC_BEG) + strlen(LOGICSYMBTYPE_DEC_END)
        + strlen(body);
    char* text = UTIL_mallocStr(length);
    
    strcpy(text, LOGICSYMBTYPE_DEC_BEG);
    strcat(text, body);               
    strcat(text, LOGICSYMBTYPE_DEC_END);
    
    return text;
}

//PERV_LSSTART
#define LSSTART_BEG "#define PERV_LSSTART     "
#define LSSTART_END "     //begin of interpretable symbols\n"
#define LSEND_BEG   "#define PERV_LSEND       "
#define LSEND_END   "     //end of interpretable symbols\n"
char* C_mkLSRange(char* start, char* end)
{
    char* range;
    char* startInd = C_mkIndexName(start);
    char* endInd   = C_mkIndexName(end);
    size_t length = strlen(startInd) + strlen(LSSTART_BEG) + strlen(LSSTART_END) +
        strlen(endInd) + strlen(LSEND_BEG) + strlen(LSEND_END) + 5;

    range = UTIL_mallocStr(length);    
    strcpy(range, LSSTART_BEG);
    strcat(range, " ");
    strcat(range, startInd);           free(startInd);
    strcat(range, LSSTART_END);
    strcat(range, LSEND_BEG);
    strcat(range, " ");
    strcat(range, endInd);             free(endInd);
    strcat(range, LSEND_END); 
    strcat(range, "\n");
    
    return range;
}

//PERV_PREDSTART
#define PREDSTART_BEG "#define PERV_PREDSTART     "
#define PREDSTART_END "     //begin of predicate symbols\n"
#define PREDEND_BEG   "#define PERV_PREDEND       "
#define PREDEND_END   "     //end of predicate symbols\n"

char* C_mkPredRange(char* start, char* end)
{
    char* range;
    char* startInd = C_mkIndexName(start);
    char* endInd   = C_mkIndexName(end);
    size_t length = strlen(startInd) + strlen(PREDSTART_BEG) + 
        strlen(PREDSTART_END) + strlen(endInd) + strlen(PREDEND_BEG) + 
        strlen(PREDEND_END) + 5;

    range = UTIL_mallocStr(length);    
    strcpy(range, PREDSTART_BEG);
    strcat(range, " ");
    strcat(range, startInd);           free(startInd);
    strcat(range, PREDSTART_END);
    strcat(range, PREDEND_BEG);
    strcat(range, " ");
    strcat(range, endInd);             free(endInd);
    strcat(range, PREDEND_END); 
    strcat(range, "\n");
    
    return range;
}


/*********************************************************************/
/* fixed part of pervasives.h{c}                                     */
/*********************************************************************/
#define C_COMMENTS_BEG_H \
"/****************************************************************************/\n/* File pervasives.h.                                                       */ \n/****************************************************************************/\n\n"


#define C_COMPDEF_BEG_H "#ifndef PERVASIVES_H\n#define PERVASIVES_H\n\n"
#define C_COMPDEF_END_H "#endif //PERVASIVES_H\n"

#define C_INCLUDE_H \
"#include \"../simulator/mctypes.h\"      //to be changed                      \n#include \"../simulator/dataformats.h\"  //to be changed  \n\n"

char* C_mkFixedBegH()
{
    char* text = UTIL_mallocStr(strlen(C_COMMENTS_BEG_H) + 
                                strlen(C_COMPDEF_BEG_H) +
                                strlen(C_INCLUDE_H));
    strcpy(text, C_COMMENTS_BEG_H);
    strcat(text, C_COMPDEF_BEG_H);
    strcat(text, C_INCLUDE_H);
    return text;
}

char* C_mkFixedEndH()
{
    char* text = strdup(C_COMPDEF_END_H);
    return text;
}

#define C_COMMENTS_BEG_C  \
"/***************************************************************************/ \n/* File pervasives.c.                                                      */  \n/***************************************************************************/\n\n"

#define C_COMPDEF_BEG_C  "#ifndef PERVASIVES_C\n#define PERVASIVES_C\n\n"
#define C_COMPDEF_END_C  "#endif //PERVASIVES_C\n"

#define C_INCLUDE_C \
"#include <string.h>                                                           \n#include \"pervasives.h\"                                                      \n#include \"../system/error.h\"     //to be changed                             \n#include \"../system/operators.h\" //to be changed                           \n\n"

char* C_mkFixedBegC()
{
    char* text = UTIL_mallocStr(strlen(C_COMMENTS_BEG_C) + 
                                strlen(C_COMPDEF_BEG_C) +
                                strlen(C_INCLUDE_C));
    strcpy(text, C_COMMENTS_BEG_C);
    strcat(text, C_COMPDEF_BEG_C);
    strcat(text, C_INCLUDE_C);
    return text;
}

char* C_mkFixedEndC()
{
    char* text = strdup(C_COMPDEF_END_C);
    return text;
}

