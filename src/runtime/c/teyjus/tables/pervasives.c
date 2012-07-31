/***************************************************************************/ 
/* File pervasives.c.                                                      */  
/***************************************************************************/

#ifndef PERVASIVES_C
#define PERVASIVES_C

#include <string.h>                                                           
#include "pervasives.h"                                                      
#include "../system/error.h"     //to be changed                             
#include "../system/operators.h" //to be changed                           


/****************************************************************************/
/*   PERVASIVE KIND                                                         */ 
/****************************************************************************/ 
//pervasive kind data table (array)                                           
PERV_KindData   PERV_kindDataTab[PERV_KIND_NUM] = {                            
   //name,            arity                                                    
    //  int 
    {"int",    0},
    //  real 
    {"real",    0},
    //  bool 
    {"o",    0},
    //  string 
    {"string",    0},
    //  list type constructor 
    {"list",    1},
    //  in_stream 
    {"in_stream",    0},
    //  out_stream 
    {"out_stream",    0}
};

PERV_KindData PERV_getKindData(int index)                                     
{                                                                              
    return PERV_kindDataTab[index];                                            
}                                                                            

void PERV_copyKindDataTab(PERV_KindData* dst)                                 
{                                                                              
    //this way of copy relies on the assumption that the pervasive kind data   
    //has the same structure as that of the run-time kind symbol table entries.
    memcpy((void*)dst, (void*)PERV_kindDataTab,                                
           sizeof(PERV_KindData) * PERV_KIND_NUM);                             
}                                                                            


/***************************************************************************/
/*   TYPE SKELETIONS FOR PERVASIVE CONSTANTS                                */ 
/****************************************************************************/

//pervasive type skeleton table (array)                                       
PERV_TySkelData   PERV_tySkelTab[PERV_TY_SKEL_NUM];                        

//pervasive type skeletons and type skeleton table initialization             
//The type skeletons are created in the memory of the system through malloc,   
//and addresses are entered into the pervasive type skeleton table.            
void PERV_tySkelTabInit()                                                      
{                                                                              
    int tySkelInd = 0; //ts tab index
    MemPtr tySkelBase = (MemPtr)EM_malloc(WORD_SIZE * 336 ); //ts area

    //  A 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  (list A) 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkStrType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkStrFuncType(tySkelBase, PERV_LIST_INDEX, 1);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  A->(list A)->(list A) 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkStrType(tySkelBase, (DF_TypePtr)(tySkelBase + 2 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkStrType(tySkelBase, (DF_TypePtr)(tySkelBase + 3 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkStrFuncType(tySkelBase, PERV_LIST_INDEX, 1);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkStrFuncType(tySkelBase, PERV_LIST_INDEX, 1);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  int 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  real 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  o (type of proposition)
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  int -> int 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  int -> int -> int 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  int -> int -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  int -> real 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  real -> int 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  real -> real 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  real -> string 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  real -> real -> real 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  real -> real -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_REAL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> int 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  int -> string 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> string -> string 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> string -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> int -> int -> string 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  o -> o -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  (A -> o) -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 2 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  A -> A -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  in_stream 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkSortType(tySkelBase, PERV_INSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  out_stream 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkSortType(tySkelBase, PERV_OUTSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> in_stream -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> out_stream -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_OUTSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  in_stream -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  out_stream -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_OUTSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  A -> string -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> A -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  out_stream -> string -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_OUTSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  in_stream -> int -> string -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  in_stream -> string -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  A -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  out_stream -> A -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_OUTSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  in_stream -> A -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSkelVarType(tySkelBase, 0);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  o -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> int -> in_stream -> out_stream -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_OUTSTREAM_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

    //  string -> int -> o 
    PERV_tySkelTab[tySkelInd] = (PERV_TySkelData)tySkelBase;
    tySkelInd++;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_STRING_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkArrowType(tySkelBase, (DF_TypePtr)(tySkelBase + 1 * DF_TY_ATOMIC_SIZE));
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_INT_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;
    DF_mkSortType(tySkelBase, PERV_BOOL_INDEX);
    tySkelBase += DF_TY_ATOMIC_SIZE;

}

void PERV_copyTySkelTab(PERV_TySkelData* dst)                                 
{                                                                              
    memcpy((void*)dst, (void*)PERV_tySkelTab,                                  
           sizeof(PERV_TySkelData) * PERV_KIND_NUM);                           
}


/***************************************************************************/ 
/*   PERVASIVE CONSTANTS                                                   */  
/***************************************************************************/

//pervasive constant data table (array)                                       
PERV_ConstData   PERV_constDataTab[PERV_CONST_NUM] = {                         
    //name,   tesize, tst, neededness, UC, prec,  fixity                       
    //  logical and 
    {",",    0,    21,    0,    0,    110,    OP_INFIXL},
    //  logical or 
    {";",    0,    21,    0,    0,    100,    OP_INFIXL},
    //  existential quantifier 
    {"sigma",    1,    22,    1,    0,    0,    OP_NONE},
    //  universal quantifier 
    {"pi",    1,    22,    1,    0,    0,    OP_NONE},
    //  true proposition 
    {"true",    0,    6,    0,    0,    0,    OP_NONE},
    //  cut predicate 
    {"!",    0,    6,    0,    0,    0,    OP_NONE},
    //  fail predicate 
    {"fail",    0,    6,    0,    0,    0,    OP_NONE},
    //nothing
    {NULL,   0,     0,     0,     0,   OP_NONE  },
    //  another logical and 
    {"&",    0,    21,    0,    0,    120,    OP_INFIXR},
    //  halt the system 
    {"halt",    0,    6,    0,    0,    0,    OP_NONE},
    //  return to top level 
    {"stop",    0,    6,    0,    0,    0,    OP_NONE},
    //  Prolog if; needed? 
    {":-",    0,    21,    0,    0,    0,    OP_INFIXL},
    //  implication; needed? 
    {"=>",    0,    21,    0,    0,    130,    OP_INFIXR},
    //nothing
    {NULL,   0,     0,     0,     0,   OP_NONE  },
    //nothing
    {NULL,   0,     0,     0,     0,   OP_NONE  },
    //  solve; used by code generator 
    {"solve",    0,    39,    0,    0,    0,    OP_NONE},
    //  is 
    {"is",    1,    23,    1,    0,    130,    OP_INFIX},
    //  not 
    {"not",    0,    39,    0,    0,    0,    OP_NONE},
    //  equality (unify) predicate 
    {"=",    1,    23,    1,    0,    130,    OP_INFIX},
    //  less than on integers 
    {"<",    0,    9,    0,    0,    130,    OP_INFIX},
    //  greater than on integers 
    {">",    0,    9,    0,    0,    130,    OP_INFIX},
    //  less than or eq on integers 
    {"<=",    0,    9,    0,    0,    130,    OP_INFIX},
    //  greater than or eq on integers
    {">=",    0,    9,    0,    0,    130,    OP_INFIX},
    //  less than in reals 
    {"<",    0,    15,    0,    0,    130,    OP_INFIX},
    //  greater than on reals 
    {">",    0,    15,    0,    0,    130,    OP_INFIX},
    //  less than or eq on reals 
    {"<=",    0,    15,    0,    0,    130,    OP_INFIX},
    //  greater than or eq on reals 
    {">=",    0,    15,    0,    0,    130,    OP_INFIX},
    //  less than on strings 
    {"<",    0,    19,    0,    0,    130,    OP_INFIX},
    //  greater than on strings 
    {">",    0,    19,    0,    0,    130,    OP_INFIX},
    //  less than or eq on strings 
    {"<=",    0,    19,    0,    0,    130,    OP_INFIX},
    //  greater than or eq on strings 
    {">=",    0,    19,    0,    0,    130,    OP_INFIX},
    //  open_in 
    {"open_in",    0,    26,    0,    0,    0,    OP_NONE},
    //  open_out 
    {"open_out",    0,    27,    0,    0,    0,    OP_NONE},
    //  open_append 
    {"open_append",    0,    27,    0,    0,    0,    OP_NONE},
    //  close_in 
    {"close_in",    0,    28,    0,    0,    0,    OP_NONE},
    //  close_out 
    {"close_out",    0,    29,    0,    0,    0,    OP_NONE},
    //  open_string 
    {"open_string",    0,    26,    0,    0,    0,    OP_NONE},
    //  input 
    {"input",    0,    33,    0,    0,    0,    OP_NONE},
    //  output 
    {"output",    0,    32,    0,    0,    0,    OP_NONE},
    //  input_line 
    {"input_line",    0,    34,    0,    0,    0,    OP_NONE},
    //  lookahead 
    {"lookahead",    0,    34,    0,    0,    0,    OP_NONE},
    //  eof      
    {"eof",    0,    28,    0,    0,    0,    OP_NONE},
    //  flush     
    {"flush",    0,    29,    0,    0,    0,    OP_NONE},
    //  print  
    {"print",    0,    35,    0,    0,    0,    OP_NONE},
    //  read   
    {"read",    1,    36,    1,    0,    0,    OP_NONE},
    //  printterm 
    {"printterm",    1,    37,    0,    0,    0,    OP_NONE},
    //  term_to_string 
    {"term_to_string",    1,    30,    0,    0,    0,    OP_NONE},
    //  string_to_term 
    {"string_to_term",    1,    31,    1,    0,    0,    OP_NONE},
    //  readterm 
    {"readterm",    1,    38,    1,    0,    0,    OP_NONE},
    //  getenv predicate; needed? 
    {"getenv",    0,    19,    0,    0,    0,    OP_NONE},
    //  open_socket predicate 
    {"open_socket",    0,    40,    0,    0,    0,    OP_NONE},
    //  time predicate 
    {"time",    0,    9,    0,    0,    0,    OP_NONE},
    //  system predicate  
    {"system",    0,    41,    0,    0,    0,    OP_NONE},
    //nothing
    {NULL,   0,     0,     0,     0,   OP_NONE  },
    //nothing
    {NULL,   0,     0,     0,     0,   OP_NONE  },
    //nothing
    {NULL,   0,     0,     0,     0,   OP_NONE  },
    //  unary minus on integers 
    {"-",    0,    7,    0,    0,    256,    OP_PREFIX},
    //  addition on integers 
    {"+",    0,    8,    0,    0,    150,    OP_INFIXL},
    //  subtraction on integers 
    {"-",    0,    8,    0,    0,    150,    OP_INFIXL},
    //  mutiplication on integers 
    {"*",    0,    8,    0,    0,    160,    OP_INFIXL},
    //  integer division 
    {"div",    0,    8,    0,    0,    160,    OP_INFIXL},
    //  modulus 
    {"mod",    0,    7,    0,    0,    160,    OP_INFIXL},
    //  coercion to real 
    {"int_to_real",    0,    10,    0,    0,    0,    OP_NONE},
    //  integer abs 
    {"abs",    0,    7,    0,    0,    0,    OP_NONE},
    //  unary minus on real 
    {"-",    0,    12,    0,    0,    256,    OP_PREFIX},
    //  addition on reals 
    {"+",    0,    14,    0,    0,    150,    OP_INFIXL},
    //  subtraction on reals 
    {"-",    0,    14,    0,    0,    150,    OP_INFIXL},
    //  multiplication on reals 
    {"*",    0,    14,    0,    0,    160,    OP_INFIXL},
    //  division 
    {"/",    0,    14,    0,    0,    160,    OP_INFIXL},
    //  square root 
    {"sqrt",    0,    12,    0,    0,    0,    OP_NONE},
    //  sine 
    {"sin",    0,    12,    0,    0,    0,    OP_NONE},
    //  cosine 
    {"cos",    0,    12,    0,    0,    0,    OP_NONE},
    //  arc tan 
    {"arctan",    0,    12,    0,    0,    0,    OP_NONE},
    //  natural log 
    {"ln",    0,    12,    0,    0,    0,    OP_NONE},
    //  floor function 
    {"floor",    0,    11,    0,    0,    0,    OP_NONE},
    //  ceiling function 
    {"ceil",    0,    11,    0,    0,    0,    OP_NONE},
    //  truncation 
    {"truncate",    0,    11,    0,    0,    0,    OP_NONE},
    //  real abs 
    {"rabs",    0,    12,    0,    0,    0,    OP_NONE},
    //  string concatination 
    {"^",    0,    18,    0,    0,    150,    OP_INFIXL},
    //  string length 
    {"size",    0,    16,    0,    0,    0,    OP_NONE},
    //  chr function 
    {"chr",    0,    17,    0,    0,    0,    OP_NONE},
    //  ord function 
    {"string_to_int",    0,    16,    0,    0,    0,    OP_NONE},
    //  substring 
    {"substring",    0,    20,    0,    0,    0,    OP_NONE},
    //  int to string 
    {"int_to_string",    0,    17,    0,    0,    0,    OP_NONE},
    //  real to string 
    {"real_to_string",    0,    13,    0,    0,    0,    OP_NONE},
    //  for unnamed universal constants (Note: tesize should be 0)
    {"<constant>",    0,    0,    0,    0,    0,    OP_NONE},
    //  std_in 
    {"std_in",    0,    24,    0,    0,    0,    OP_NONE},
    //  std_out 
    {"std_out",    0,    25,    0,    0,    0,    OP_NONE},
    //  std_err 
    {"std_err",    0,    25,    0,    0,    0,    OP_NONE},
    //  nil 
    {"nil",    0,    1,    0,    0,    0,    OP_NONE},
    //  integer constant 
    {"<int_constant>",    0,    3,    0,    0,    0,    OP_NONE},
    //   real constant 
    {"<real_constant>",    0,    4,    0,    0,    0,    OP_NONE},
    //  string constant 
    {"<str_constant>",    0,    5,    0,    0,    0,    OP_NONE},
    //  cons 
    {"::",    0,    2,    0,    0,    140,    OP_INFIXR}
};

PERV_ConstData PERV_getConstData(int index)                                   
{                                                                              
        return PERV_constDataTab[index];                                       
}                                                                          

void PERV_copyConstDataTab(PERV_ConstData* dst)                               
{                                                                              
    //this way of copy relies on the assumption that the pervasive kind data   
    //has the same structure as that of the run-time kind symbol table entries.
    memcpy((void*)dst, (void*)PERV_constDataTab,                               
           sizeof(PERV_ConstData) * PERV_CONST_NUM);                           
}                                                                          

Boolean PERV_isLogicSymb(int index)                                           
{                                                                              
    return ((index >= PERV_LSSTART) && (index <= PERV_LSEND));                  
}

Boolean PERV_isPredSymb(int index)                                            
{                                                                              
    return ((index >= PERV_PREDSTART) && (index <= PERV_PREDEND));           
}

PERV_LogicSymbTypes PERV_logicSymb(int index)                                 
{                                                                              
    return ((PERV_LogicSymbTypes)(index - PERV_LSSTART));                      
}

int PERV_predBuiltin(int index)                                               
{                                                                              
    return (index - PERV_PREDSTART);                                           
}


#endif //PERVASIVES_C

