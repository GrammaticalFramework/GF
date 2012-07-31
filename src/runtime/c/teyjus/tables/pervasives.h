/****************************************************************************/
/* File pervasives.h.                                                       */ 
/****************************************************************************/

#ifndef PERVASIVES_H
#define PERVASIVES_H

#include "../simulator/mctypes.h"      //to be changed                      
#include "../simulator/dataformats.h"  //to be changed  


/****************************************************************************/
/*   PERVASIVE KIND                                                         */ 
/****************************************************************************/ 
//indices for predefined sorts and type constructors
typedef enum PERV_KindIndexType
{
    //  int 
    PERV_INT_INDEX = 0,
    //  real 
    PERV_REAL_INDEX = 1,
    //  bool 
    PERV_BOOL_INDEX = 2,
    //  string 
    PERV_STRING_INDEX = 3,
    //  list type constructor 
    PERV_LIST_INDEX = 4,
    //  in_stream 
    PERV_INSTREAM_INDEX = 5,
    //  out_stream 
    PERV_OUTSTREAM_INDEX = 6
} PERV_KindIndexType;

//total number of pervasive kinds
#define PERV_KIND_NUM 7

//pervasive kind data type                                                    
typedef struct                                                                 
{                                                                              
    char         *name;                                                        
    TwoBytes     arity;                                                        
} PERV_KindData;                                                             

//pervasive kind data table (array)                                           
extern PERV_KindData    PERV_kindDataTab[PERV_KIND_NUM];                     

//pervasive kind data access function                                         
PERV_KindData PERV_getKindData(int index);                                   

//pervasive kind table copy function (used in module space initialization)    
//this functiion relies on the assumption that the pervasive kind data         
//has the same structure as that of the run-time kind symbol table entries.    
void PERV_copyKindDataTab(PERV_KindData* dst);                               


/***************************************************************************/
/*   TYPE SKELETIONS FOR PERVASIVE CONSTANTS                                */ 
/****************************************************************************/

//total number of type skeletons needed for pervasive constants
#define PERV_TY_SKEL_NUM 42

//pervasive type skel data type                                               
typedef DF_TypePtr  PERV_TySkelData;                                         

//pervasive type skel table (array)                                           
extern  PERV_TySkelData   PERV_tySkelTab[PERV_TY_SKEL_NUM];                  

//pervasive type skeletons and type skeleton table initialization             
//Note that type skeltons have to be dynamically allocated, and so does the    
//info recorded in each entry of the pervasive type skeleton table             
void PERV_tySkelTabInit();                                                   

//pervasive tyskel table copy function                                        
void PERV_copyTySkelTab(PERV_TySkelData* dst);                               


/***************************************************************************/ 
/*   PERVASIVE CONSTANTS                                                   */  
/***************************************************************************/

//indices for predefined constants
typedef enum PERV_ConstIndexType
{
    //  logical and 
    PERV_AND_INDEX = 0,
    //  logical or 
    PERV_OR_INDEX = 1,
    //  existential quantifier 
    PERV_SOME_INDEX = 2,
    //  universal quantifier 
    PERV_ALL_INDEX = 3,
    //  true proposition 
    PERV_TRUE_INDEX = 4,
    //  cut predicate 
    PERV_CUT_INDEX = 5,
    //  fail predicate 
    PERV_FAIL_INDEX = 6,
    // empty
    //  another logical and 
    PERV_AMPAND_INDEX = 8,
    //  halt the system 
    PERV_HALT_INDEX = 9,
    //  return to top level 
    PERV_STOP_INDEX = 10,
    //  Prolog if; needed? 
    PERV_COLONDASH_INDEX = 11,
    //  implication; needed? 
    PERV_IMPL_INDEX = 12,
    // empty
    // empty
    //  solve; used by code generator 
    PERV_SOLVE_INDEX = 15,
    //  is 
    PERV_IS_INDEX = 16,
    //  not 
    PERV_NOT_INDEX = 17,
    //  equality (unify) predicate 
    PERV_EQ_INDEX = 18,
    //  less than on integers 
    PERV_INTLSS_INDEX = 19,
    //  greater than on integers 
    PERV_INTGRT_INDEX = 20,
    //  less than or eq on integers 
    PERV_INTLEQ_INDEX = 21,
    //  greater than or eq on integers
    PERV_INTGEQ_INDEX = 22,
    //  less than in reals 
    PERV_REALLSS_INDEX = 23,
    //  greater than on reals 
    PERV_REALGRT_INDEX = 24,
    //  less than or eq on reals 
    PERV_REALLEQ_INDEX = 25,
    //  greater than or eq on reals 
    PERV_REALGEQ_INDEX = 26,
    //  less than on strings 
    PERV_STRLSS_INDEX = 27,
    //  greater than on strings 
    PERV_STRGRT_INDEX = 28,
    //  less than or eq on strings 
    PERV_STRLEQ_INDEX = 29,
    //  greater than or eq on strings 
    PERV_STRGEQ_INDEX = 30,
    //  open_in 
    PERV_OPENIN_INDEX = 31,
    //  open_out 
    PERV_OPENOUT_INDEX = 32,
    //  open_append 
    PERV_OPENAPP_INDEX = 33,
    //  close_in 
    PERV_CLOSEIN_INDEX = 34,
    //  close_out 
    PERV_CLOSEOUT_INDEX = 35,
    //  open_string 
    PERV_OPENSTR_INDEX = 36,
    //  input 
    PERV_INPUT_INDEX = 37,
    //  output 
    PERV_OUTPUT_INDEX = 38,
    //  input_line 
    PERV_INPUTLINE_INDEX = 39,
    //  lookahead 
    PERV_LOOKAHEAD_INDEX = 40,
    //  eof      
    PERV_EOF_INDEX = 41,
    //  flush     
    PERV_FLUSH_INDEX = 42,
    //  print  
    PERV_PRINT_INDEX = 43,
    //  read   
    PERV_READ_INDEX = 44,
    //  printterm 
    PERV_PRINTTERM_INDEX = 45,
    //  term_to_string 
    PERV_TERMTOSTR_INDEX = 46,
    //  string_to_term 
    PERV_STRTOTERM_INDEX = 47,
    //  readterm 
    PERV_READTERM_INDEX = 48,
    //  getenv predicate; needed? 
    PERV_GETENV_INDEX = 49,
    //  open_socket predicate 
    PERV_OPENSOCKET_INDEX = 50,
    //  time predicate 
    PERV_TIME_INDEX = 51,
    //  system predicate  
    PERV_SYSTEM_INDEX = 52,
    // empty
    // empty
    // empty
    //  unary minus on integers 
    PERV_INTUMINUS_INDEX = 56,
    //  addition on integers 
    PERV_INTPLUS_INDEX = 57,
    //  subtraction on integers 
    PERV_INTMINUS_INDEX = 58,
    //  mutiplication on integers 
    PERV_INTMULT_INDEX = 59,
    //  integer division 
    PERV_INTDIV_INDEX = 60,
    //  modulus 
    PERV_MOD_INDEX = 61,
    //  coercion to real 
    PERV_ITOR_INDEX = 62,
    //  integer abs 
    PERV_IABS_INDEX = 63,
    //  unary minus on real 
    PERV_REALUMINUS_INDEX = 64,
    //  addition on reals 
    PERV_REALPLUS_INDEX = 65,
    //  subtraction on reals 
    PERV_REALMINUS_INDEX = 66,
    //  multiplication on reals 
    PERV_REALMULT_INDEX = 67,
    //  division 
    PERV_REALDIV_INDEX = 68,
    //  square root 
    PERV_SQRT_INDEX = 69,
    //  sine 
    PERV_SIN_INDEX = 70,
    //  cosine 
    PERV_COS_INDEX = 71,
    //  arc tan 
    PERV_ARCTAN_INDEX = 72,
    //  natural log 
    PERV_LOG_INDEX = 73,
    //  floor function 
    PERV_FLOOR_INDEX = 74,
    //  ceiling function 
    PERV_CEIL_INDEX = 75,
    //  truncation 
    PERV_TRUNC_INDEX = 76,
    //  real abs 
    PERV_RABS_INDEX = 77,
    //  string concatination 
    PERV_SCAT_INDEX = 78,
    //  string length 
    PERV_SLEN_INDEX = 79,
    //  chr function 
    PERV_ITOCHR_INDEX = 80,
    //  ord function 
    PERV_STOI_INDEX = 81,
    //  substring 
    PERV_SUBSTR_INDEX = 82,
    //  int to string 
    PERV_ITOSTR_INDEX = 83,
    //  real to string 
    PERV_RTOS_INDEX = 84,
    //  for unnamed universal constants (Note: tesize should be 0)
    PERV_UNIV_INDEX = 85,
    //  std_in 
    PERV_STDIN_INDEX = 86,
    //  std_out 
    PERV_STDOUT_INDEX = 87,
    //  std_err 
    PERV_STDERR_INDEX = 88,
    //  nil 
    PERV_NIL_INDEX = 89,
    //  integer constant 
    PERV_INTC_INDEX = 90,
    //   real constant 
    PERV_REALC_INDEX = 91,
    //  string constant 
    PERV_STRC_INDEX = 92,
    //  cons 
    PERV_CONS_INDEX = 93
} PERV_ConstIndexType;

//total number pervasive constants
#define PERV_CONST_NUM 94

//pervasive const data type                                                   
typedef struct                                                                 
{                                                                              
    char      *name;                                                           
    TwoBytes  typeEnvSize;                                                     
    TwoBytes  tskTabIndex;     //index to the type skeleton table              
    TwoBytes  neededness;      //neededness (predicate constant)               
    TwoBytes  univCount;                                                       
    int       precedence;                                                      
    int       fixity;                                                          
} PERV_ConstData; 

//pervasive const data table (array)                                          
extern PERV_ConstData    PERV_constDataTab[PERV_CONST_NUM]; 

//pervasive const data access function                                        
PERV_ConstData PERV_getConstData(int index);  

//pervasive const table copy function (used in module space initialization)   
//this functiion relies on the assumption that the pervasive kind data         
//has the same structure as that of the run-time kind symbol table entries.    
void PERV_copyConstDataTab(PERV_ConstData* dst); 

#define PERV_LSSTART      PERV_AND_INDEX     //begin of interpretable symbols
#define PERV_LSEND        PERV_STOP_INDEX     //end of interpretable symbols

#define PERV_PREDSTART      PERV_SOLVE_INDEX     //begin of predicate symbols
#define PERV_PREDEND        PERV_SYSTEM_INDEX     //end of predicate symbols

typedef enum PERV_LogicSymbTypes                                              
{
    PERV_AND = 0,
    PERV_OR = 1,
    PERV_SOME = 2,
    PERV_ALL = 3,
    PERV_L_TRUE = 4,
    PERV_CUT = 5,
    PERV_FAIL = 6,
    PERV_EQ = 7,
    PERV_AMPAND = 8,
    PERV_HALT = 9,
    PERV_STOP = 10,
} PERV_LogicSymbTypes;

//functions used by the simulator for interpreted goals                       
Boolean PERV_isLogicSymb(int index);                                           
Boolean PERV_isPredSymb(int index); 

PERV_LogicSymbTypes PERV_logicSymb(int index); 

int PERV_predBuiltin(int index); 


#endif //PERVASIVES_H

