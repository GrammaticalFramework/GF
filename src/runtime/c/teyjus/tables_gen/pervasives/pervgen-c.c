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
/* File pervgen-c.c. This files contains function definitions for generating */
/* files pervasives.h and pervasives.c.                                      */
/*****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "pervgen-c.h"
#include "ccode.h"
#include "../util/util.h"

//dynamic string array type
typedef struct StringArray 
{
  char **array;
  int  length;
} StringArray;

//array initialization
static void arrayInit(char **array, int size)
{
    int i ;
    for (i =0; i < size; i++) array[i] = NULL;
}

//collect string in a StringArray into a single array
static char* collectStringArray(StringArray arr, char* emptyText)
{
    char *myText = NULL;
    char *myText2 = NULL;
    int  i;
    int  length = 0;

    for (i = 0; i < arr.length; i++) {
        char* text = arr.array[i];
        if (text == NULL) text = emptyText;

        if (myText) {
            myText2 = UTIL_mallocStr(strlen(text) + strlen(myText));
            strcpy(myText2, myText);
            strcat(myText2, text);
            free(myText); 
        } else {
            myText2 = UTIL_mallocStr(strlen(text));
            strcpy(myText2, text);
        }
        if (arr.array[i]) free(arr.array[i]);
        myText = myText2;
    }
    free(arr.array);
    
    return myText;    
}

/****************************************************************************/
/* kind relevant components                                                 */
/****************************************************************************/
/***********************************************************************/
/* pervasives.h                                                        */
/***********************************************************************/
//number of pervasive kinds
static char* numKinds = NULL;         

void cgenNumKinds(char* num)
{
    numKinds = C_mkNumKinds(num);
}

//pervasive kind indices declaration
static StringArray kindIndices;             //kind indices declaration

void cgenKindIndex(int index, char* name, char* indexT, char* comments)
{
    char* kindIndex; 
    char* kindIndexText;
  
    if (index >= kindIndices.length) {
        fprintf(stderr, "kind index exceed total number of kinds\n");
        exit(1);
    }
    kindIndex = C_mkIndex(name, indexT, comments);
    kindIndexText = UTIL_mallocStr(strlen(kindIndex) + 2);
    strcpy(kindIndexText, kindIndex);            free(kindIndex);
    if (index != (kindIndices.length - 1))  strcat(kindIndexText, ",");
    strcat(kindIndexText, "\n");
    
    kindIndices.array[index] = kindIndexText;
}

//pervasive kind relevant information in pervasives.h
static char* kindH;
void cgenKindH()
{
    char* emptyText = C_mkEmptyComments();
   
    char* kindIndexBody = collectStringArray(kindIndices, emptyText);
    char* kindIndexTypeDef = C_mkKindIndexType(kindIndexBody);
    
    kindH = C_mkKindH(kindIndexTypeDef, numKinds);
    free(kindIndexBody); free(kindIndexTypeDef); free(numKinds); 
    free(emptyText);
}

/***********************************************************************/
/* pervasives.c                                                        */
/***********************************************************************/
//pervasive kind table entries
static StringArray kindData;
void cgenKindData(int index, char* name, char* arity, char* comments)
{
    char* oneKindData;
    char* kindDataText;
    
    if (index >= kindData.length) {
      fprintf(stderr, "kind index exceed total number of kinds\n");
      exit(1);
    }
    oneKindData = C_mkKindTabEntry(name, arity, comments);
    kindDataText = UTIL_mallocStr(strlen(oneKindData) + 2);
    strcpy(kindDataText, oneKindData);            free(oneKindData);
    if (index != kindData.length - 1) strcat(kindDataText, ",");
    strcat(kindDataText, "\n");
    
    kindData.array[index] = kindDataText;
}

#define EMPTY_TEXT_KIND_TAB "    //nothing \n    {NULL,    0},\n"    

//pervasive kind relevant information in pervasives.c
static char* kindC;
void cgenKindC()
{
    char* kindTabBody = collectStringArray(kindData, EMPTY_TEXT_KIND_TAB);
    char* kindTab     = C_mkKindTab(kindTabBody);
    
    kindC = C_mkKindC(kindTab);
    free(kindTabBody); free(kindTab);
}

//kind indices info and kind table info initiation 
void cgenKindInit(int length)               
{
    kindIndices.length = length;
    kindIndices.array  = (char**)UTIL_malloc(sizeof(char*)*length);
    arrayInit(kindIndices.array, length);
    kindData.length    = length;
    kindData.array     = (char**)UTIL_malloc(sizeof(char*)*length);
    arrayInit(kindData.array, length);
}

/****************************************************************************/
/* type skeleton relevant components                                        */
/****************************************************************************/
/***********************************************************************/
/* pervasives.h                                                        */
/***********************************************************************/
//number of type skeletons for pervasive constants
static char* numTySkels = NULL;
void cgenNumTySkels(char* num)
{
    numTySkels = C_mkNumTySkels(num);
}

//type skeleton relevant information in pervasives.h
static char* tySkelsH;
void cgenTySkelsH()
{
    tySkelsH = C_mkTySkelsH(numTySkels);
    free(numTySkels);
}

/***********************************************************************/
/* pervasives.c                                                        */
/***********************************************************************/
//type skeleton creation code
static StringArray tySkels;
void cgenTySkelTab(int index, Type tyskel, char* comments) 
{
    if (index >= tySkels.length){
        fprintf(stderr, 
                "type skeleton index exceed total number of type skeletons\n");
        exit(1);
    }
    tySkels.array[index] = C_genTySkel(tyskel, comments);
}

//generate types skeleton initialization code 
static char* cgenTySkelTabInit()
{
    char* body = collectStringArray(tySkels, "");
    char* text = C_mkTySkelTabInit(body, C_totalSpace);
   
    free(body); 
    return text;
}

//type skeleton info initiation
void cgenTySkelInit(int length)
{
    if (length == 0) {
        fprintf(stderr, "The number of type skeletons cannot be 0\n");
        exit(1);
    }    
    tySkels.length = length;
    tySkels.array  = (char**)UTIL_malloc(sizeof(char*)*length);
    arrayInit(tySkels.array, length);
}

//type skeleton relevant information in pervasives.c
static char* tySkelsC;
void cgenTySkelsC()
{
    char* tySkelTab = cgenTySkelTabInit();
    tySkelsC = C_mkTySkelsC(tySkelTab);    free(tySkelTab);
}

/****************************************************************************/
/* constant relevant components                                             */
/****************************************************************************/
/***********************************************************************/
/* pervasives.h                                                        */
/***********************************************************************/
//number of pervasive constants
static char* numConsts = NULL;
void cgenNumConsts(char* num)
{
    numConsts = C_mkNumConsts(num);   
}

//pervasive constant indices declaration
static StringArray constIndices;

void cgenConstIndex(int index, char* name, char* indexT, char* comments)
{
    char* constIndex;
    char* constIndexText;
    
    if (index >= constIndices.length) {
        fprintf(stderr, "constant index exceed total number of constants\n");
        exit(1);
    }
    constIndex = C_mkIndex(name, indexT, comments);
    constIndexText = UTIL_mallocStr(strlen(constIndex) + 2);
    strcpy(constIndexText, constIndex);
    if (index != (constIndices.length - 1))  strcat(constIndexText, ",");
    strcat(constIndexText, "\n");
    
    constIndices.array[index] = constIndexText;
}

/***********************************************************************/
/* constant property functions                                         */
/***********************************************************************/
static StringArray logicSymbTypes;
//initiale logic symb types
void cgenLogicSymbolInit(int length)
{
    logicSymbTypes.length = length;
    logicSymbTypes.array = (char**)UTIL_malloc(sizeof(char*)*length);
    arrayInit(logicSymbTypes.array, length);
}

//generate logic symbol types
void cgenLogicSymbType(int index, char* name, char* indexT)
{
    char* constIndex;
    char* constIndexText;
    
    if (index >= logicSymbTypes.length) {
         fprintf(stderr, "logic symbol type index exceed the total number of logic symbols\n");
         exit(1);
    }
    constIndex = C_mkIndex2(name, indexT);
    constIndexText = UTIL_mallocStr(strlen(constIndex) + 2);
    strcpy(constIndexText, constIndex);
    if (index != (constIndices.length - 1))  strcat(constIndexText, ",");
    strcat(constIndexText, "\n"); 

    logicSymbTypes.array[index] = constIndexText;
}

static char* lsRange = NULL;
//generate logic symbol start/end position
void cgenLSRange(char* start, char* end)
{
    lsRange = C_mkLSRange(start, end);
}


static char* predRange = NULL;
//generate predicate symbol start/end position
void cgenPREDRange(char* start, char* end)
{
    predRange = C_mkPredRange(start, end);
}


static char* constProperty = NULL;
void cgenConstProperty()
{
    char* emptyText = C_mkEmptyComments();
    char* logicSymbTypeBody = collectStringArray(logicSymbTypes, emptyText);
    char* logicSymbTypeDec = C_mkLSTypeDec(logicSymbTypeBody);

    constProperty = UTIL_mallocStr(strlen(logicSymbTypeDec) + strlen(lsRange) 
                                   + strlen(predRange));
    strcpy(constProperty, lsRange);
    strcat(constProperty, predRange);
    strcat(constProperty , logicSymbTypeDec);
    
    free(emptyText); free(logicSymbTypeBody); free(logicSymbTypeDec);
    free(lsRange);   free(predRange);
}


//pervasive kind relevant information in pervasives.h
static char* constH;
void cgenConstH()
{
    char* emptyText = C_mkEmptyComments();
    char* constIndexBody = collectStringArray(constIndices, emptyText);
    char* constIndexTypeDef = C_mkConstIndexType(constIndexBody);
    
    constH = C_mkConstH(constIndexTypeDef, numConsts, constProperty);
    free(constIndexBody); free(constIndexTypeDef); 
    free(emptyText);  free(constProperty);
}

/***********************************************************************/
/* pervasives.c                                                        */
/***********************************************************************/
//pervasive const table entries
static StringArray constData;
void cgenConstData(int index, char* name, char* tesize, OP_Prec prec,
                   OP_Fixity fixity, int tySkelInd, char* neededness, 
                   char* comments)
{
    char* oneConstData;
    char* constDataText;
    char* tySkelIndText = UTIL_itoa(tySkelInd);

    if (index >= constData.length) {
        fprintf(stderr, "const index exceed total number of consts\n");
        exit(1);
    }
    oneConstData = C_mkConstTabEntry(name, tesize, prec, fixity, tySkelIndText,
                                     neededness, comments);
    free(tySkelIndText);
    constDataText = UTIL_mallocStr(strlen(oneConstData) + 2);
    strcpy(constDataText, oneConstData);        free(oneConstData);
    if (index != constData.length - 1) strcat(constDataText, ",");
    strcat(constDataText, "\n");
    
    constData.array[index] = constDataText;
}

#define EMPTY_TEXT_CONST_TAB \
"    //nothing\n    {NULL,   0,     0,     0,     0,   OP_NONE  },\n"

//pervasive const relevant information in pervasives.c
static char* constC;
void cgenConstC()
{
    char* constTabBody = collectStringArray(constData, EMPTY_TEXT_CONST_TAB);
    char* constTab     = C_mkConstTab(constTabBody);
    
    constC = C_mkConstC(constTab);
    free(constTabBody); free(constTab);
}


//const indices info and const table info initiation 
void cgenConstInit(int length)               
{
    constIndices.length = length;
    constIndices.array  = (char**)UTIL_malloc(sizeof(char*)*length);
    arrayInit(constIndices.array, length);
    constData.length    = length;
    constData.array     = (char**)UTIL_malloc(sizeof(char*)*length);
    arrayInit(constData.array, length);
}


/****************************************************************************/
/* Writing files                                                            */
/****************************************************************************/
static char* pervBegH;
static char* pervEndH;
static void  cgenFixedH()
{
    pervBegH = C_mkFixedBegH();
    pervEndH = C_mkFixedEndH();
}

static char* pervBegC;
static char* pervEndC;
static void  cgenFixedC()
{
    pervBegC = C_mkFixedBegC();
    pervEndC = C_mkFixedEndC();
}

/* dump peravsives.h   */
void spitCPervasivesH(char * root)
{
    FILE* outFile;
    char * filename = malloc(strlen(root) + 32);
    strcpy(filename, root);
    strcat(filename, "tables/pervasives.h");

    outFile = UTIL_fopenW(filename);
    cgenFixedH();
    fprintf(outFile, "%s\n", pervBegH); free(pervBegH);
    fprintf(outFile, "%s\n", kindH);    free(kindH);
    fprintf(outFile, "%s\n", tySkelsH); free(tySkelsH);
    fprintf(outFile, "%s\n", constH);   free(constH);
    fprintf(outFile, "%s\n", pervEndH); free(pervEndH);
    UTIL_fclose(outFile);
    free(filename);
}

/* dump pervasives.c */
void spitCPervasivesC(char * root)
{
    FILE* outFile;
    char * filename = malloc(strlen(root) + 32);
    strcpy(filename, root);
    strcat(filename, "tables/pervasives.c");
    outFile = UTIL_fopenW(filename);
    cgenFixedC();
    fprintf(outFile, "%s\n", pervBegC); free(pervBegC);
    fprintf(outFile, "%s\n", kindC);    free(kindC);
    fprintf(outFile, "%s\n", tySkelsC); free(tySkelsC);
    fprintf(outFile, "%s\n", constC);   free(constC);
    fprintf(outFile, "%s\n", pervEndC); free(pervEndC);
    UTIL_fclose(outFile);
    free(filename);
}
