/****************************************************************************/
/* File instructions.h.                                                     */ 
/* This file defines instruction operand types, instruction categories and  */ 
/* instruction opcode.                                                      */ 
/****************************************************************************/ 

#ifndef INSTRUCTIONS_H
#define INSTRUCTIONS_H

#include "../simulator/mctypes.h"      //to be changed                      
#include "../simulator/dataformats.h"   //to be changed                      

/****************************************************************************/
/*              OPERAND TYPES                                               */ 
/****************************************************************************/ 

/* possible types of instruction operands                                 */  
typedef enum INSTR_OperandType                                                 
{
    // (1 byte) padding 
    INSTR_P,
    // (1 word) padding 
    INSTR_WP,
    // argument register number 
    INSTR_R,
    // environment variable number 
    INSTR_E,
    // next clause number in impt or impl pt 
    INSTR_N,
    // 1 byte natural number 
    INSTR_I1,
    // closure environment variable number 
    INSTR_CE,
    // import segment index  
    INSTR_SEG,
    // constant symbol table index 
    INSTR_C,
    // kind symbol table index  
    INSTR_K,
    // code location  
    INSTR_L,
    // integer immediate value 
    INSTR_I,
    // floating point immediate value 
    INSTR_F,
    // string pointer 
    INSTR_S,
    // module table address 
    INSTR_MT,
    // impl table address 
    INSTR_IT,
    // hash table address 
    INSTR_HT,
    // branch table for bound var indexing 
    INSTR_BVT,
    // operand list terminator 
    INSTR_X
} INSTR_OperandType;

/**************************************************************************/  
/*                  Types for instruction operants                        */   
/**************************************************************************/   

typedef Byte  INSTR_OpCode;
typedef Byte  INSTR_RegInd;
typedef Byte  INSTR_EnvInd;
typedef Byte  INSTR_NextClauseInd;
typedef Byte  INSTR_OneByteInt;
typedef Byte  INSTR_ClEnvInd;
typedef Byte  INSTR_ImpSegInd;
typedef TwoBytes  INSTR_CstIndex;
typedef TwoBytes  INSTR_KstIndex;
typedef CSpacePtr  INSTR_CodeLabel;
typedef int  INSTR_Int;
typedef float  INSTR_Float;
typedef DF_StrDataPtr  INSTR_Str;
typedef MemPtr  INSTR_ModTab;
typedef MemPtr  INSTR_ImplTab;
typedef MemPtr  INSTR_HashTab;
typedef MemPtr  INSTR_BranchTab;

/***************************************************************************/ 
/*            INSTRUCTION CATEGORIES                                       */  
/***************************************************************************/  
 /* The names of instruction categories no longer include padding bytes.    */
/* Thus we do not need to maintain two sets of names for different machine */  
/* architectures.                                                          */  
typedef enum INSTR_InstrCategory                                               
{
    INSTR_CAT_X = 0,
    INSTR_CAT_RX = 1,
    INSTR_CAT_EX = 2,
    INSTR_CAT_I1X = 3,
    INSTR_CAT_CX = 4,
    INSTR_CAT_KX = 5,
    INSTR_CAT_IX = 6,
    INSTR_CAT_FX = 7,
    INSTR_CAT_SX = 8,
    INSTR_CAT_MTX = 9,
    INSTR_CAT_LX = 10,
    INSTR_CAT_RRX = 11,
    INSTR_CAT_ERX = 12,
    INSTR_CAT_RCX = 13,
    INSTR_CAT_RIX = 14,
    INSTR_CAT_RFX = 15,
    INSTR_CAT_RSX = 16,
    INSTR_CAT_RI1X = 17,
    INSTR_CAT_RCEX = 18,
    INSTR_CAT_ECEX = 19,
    INSTR_CAT_CLX = 20,
    INSTR_CAT_RKX = 21,
    INSTR_CAT_ECX = 22,
    INSTR_CAT_I1ITX = 23,
    INSTR_CAT_I1LX = 24,
    INSTR_CAT_SEGLX = 25,
    INSTR_CAT_I1LWPX = 26,
    INSTR_CAT_I1NX = 27,
    INSTR_CAT_I1HTX = 28,
    INSTR_CAT_I1BVTX = 29,
    INSTR_CAT_CWPX = 30,
    INSTR_CAT_I1WPX = 31,
    INSTR_CAT_RRI1X = 32,
    INSTR_CAT_RCLX = 33,
    INSTR_CAT_RCI1X = 34,
    INSTR_CAT_SEGI1LX = 35,
    INSTR_CAT_I1LLX = 36,
    INSTR_CAT_NLLX = 37,
    INSTR_CAT_LLLLX = 38,
    INSTR_CAT_I1CWPX = 39,
    INSTR_CAT_I1I1WPX = 40
} INSTR_InstrCategory;

#define INSTR_NUM_INSTR_CATS  41

#define INSTR_CALL_I1_LEN  7

/**************************************************************************/  
/* Macros defines instruction lengths and distances between op code and   */   
/* operands.                                                              */   
/* The assumption is that the op code occupies 1 byte.                    */   
/**************************************************************************/   

//INSTR_CAT_X
#define INSTR_X_LEN    4
//INSTR_CAT_RX
#define INSTR_RX_LEN    4
#define INSTR_RX_R    1
//INSTR_CAT_EX
#define INSTR_EX_LEN    4
#define INSTR_EX_E    1
//INSTR_CAT_I1X
#define INSTR_I1X_LEN    4
#define INSTR_I1X_I1    1
//INSTR_CAT_CX
#define INSTR_CX_LEN    4
#define INSTR_CX_C    2
//INSTR_CAT_KX
#define INSTR_KX_LEN    4
#define INSTR_KX_K    2
//INSTR_CAT_IX
#define INSTR_IX_LEN    8
#define INSTR_IX_I    4
//INSTR_CAT_FX
#define INSTR_FX_LEN    8
#define INSTR_FX_F    4
//INSTR_CAT_SX
#define INSTR_SX_LEN    8
#define INSTR_SX_S    4
//INSTR_CAT_MTX
#define INSTR_MTX_LEN    8
#define INSTR_MTX_MT    4
//INSTR_CAT_LX
#define INSTR_LX_LEN    8
#define INSTR_LX_L    4
//INSTR_CAT_RRX
#define INSTR_RRX_LEN    4
#define INSTR_RRX_R1    1
#define INSTR_RRX_R2    2
//INSTR_CAT_ERX
#define INSTR_ERX_LEN    4
#define INSTR_ERX_E    1
#define INSTR_ERX_R    2
//INSTR_CAT_RCX
#define INSTR_RCX_LEN    4
#define INSTR_RCX_R    1
#define INSTR_RCX_C    2
//INSTR_CAT_RIX
#define INSTR_RIX_LEN    8
#define INSTR_RIX_R    1
#define INSTR_RIX_I    4
//INSTR_CAT_RFX
#define INSTR_RFX_LEN    8
#define INSTR_RFX_R    1
#define INSTR_RFX_F    4
//INSTR_CAT_RSX
#define INSTR_RSX_LEN    8
#define INSTR_RSX_R    1
#define INSTR_RSX_S    4
//INSTR_CAT_RI1X
#define INSTR_RI1X_LEN    4
#define INSTR_RI1X_R    1
#define INSTR_RI1X_I1    2
//INSTR_CAT_RCEX
#define INSTR_RCEX_LEN    4
#define INSTR_RCEX_R    1
#define INSTR_RCEX_CE    2
//INSTR_CAT_ECEX
#define INSTR_ECEX_LEN    4
#define INSTR_ECEX_E    1
#define INSTR_ECEX_CE    2
//INSTR_CAT_CLX
#define INSTR_CLX_LEN    8
#define INSTR_CLX_C    2
#define INSTR_CLX_L    4
//INSTR_CAT_RKX
#define INSTR_RKX_LEN    4
#define INSTR_RKX_R    1
#define INSTR_RKX_K    2
//INSTR_CAT_ECX
#define INSTR_ECX_LEN    4
#define INSTR_ECX_E    1
#define INSTR_ECX_C    2
//INSTR_CAT_I1ITX
#define INSTR_I1ITX_LEN    8
#define INSTR_I1ITX_I1    1
#define INSTR_I1ITX_IT    4
//INSTR_CAT_I1LX
#define INSTR_I1LX_LEN    8
#define INSTR_I1LX_I1    1
#define INSTR_I1LX_L    4
//INSTR_CAT_SEGLX
#define INSTR_SEGLX_LEN    8
#define INSTR_SEGLX_SEG    1
#define INSTR_SEGLX_L    4
//INSTR_CAT_I1LWPX
#define INSTR_I1LWPX_LEN    12
#define INSTR_I1LWPX_I1    1
#define INSTR_I1LWPX_L    4
//INSTR_CAT_I1NX
#define INSTR_I1NX_LEN    4
#define INSTR_I1NX_I1    1
#define INSTR_I1NX_N    2
//INSTR_CAT_I1HTX
#define INSTR_I1HTX_LEN    8
#define INSTR_I1HTX_I1    1
#define INSTR_I1HTX_HT    4
//INSTR_CAT_I1BVTX
#define INSTR_I1BVTX_LEN    8
#define INSTR_I1BVTX_I1    1
#define INSTR_I1BVTX_BVT    4
//INSTR_CAT_CWPX
#define INSTR_CWPX_LEN    8
#define INSTR_CWPX_C    2
//INSTR_CAT_I1WPX
#define INSTR_I1WPX_LEN    8
#define INSTR_I1WPX_I1    1
//INSTR_CAT_RRI1X
#define INSTR_RRI1X_LEN    4
#define INSTR_RRI1X_R1    1
#define INSTR_RRI1X_R2    2
#define INSTR_RRI1X_I1    3
//INSTR_CAT_RCLX
#define INSTR_RCLX_LEN    8
#define INSTR_RCLX_R    1
#define INSTR_RCLX_C    2
#define INSTR_RCLX_L    4
//INSTR_CAT_RCI1X
#define INSTR_RCI1X_LEN    8
#define INSTR_RCI1X_R    1
#define INSTR_RCI1X_C    2
#define INSTR_RCI1X_I1    4
//INSTR_CAT_SEGI1LX
#define INSTR_SEGI1LX_LEN    8
#define INSTR_SEGI1LX_SEG    1
#define INSTR_SEGI1LX_I1    2
#define INSTR_SEGI1LX_L    4
//INSTR_CAT_I1LLX
#define INSTR_I1LLX_LEN    12
#define INSTR_I1LLX_I1    1
#define INSTR_I1LLX_L1    4
#define INSTR_I1LLX_L2    8
//INSTR_CAT_NLLX
#define INSTR_NLLX_LEN    12
#define INSTR_NLLX_N    1
#define INSTR_NLLX_L1    4
#define INSTR_NLLX_L2    8
//INSTR_CAT_LLLLX
#define INSTR_LLLLX_LEN    20
#define INSTR_LLLLX_L1    4
#define INSTR_LLLLX_L2    8
#define INSTR_LLLLX_L3    12
#define INSTR_LLLLX_L4    16
//INSTR_CAT_I1CWPX
#define INSTR_I1CWPX_LEN    8
#define INSTR_I1CWPX_I1    1
#define INSTR_I1CWPX_C    2
//INSTR_CAT_I1I1WPX
#define INSTR_I1I1WPX_LEN    8
#define INSTR_I1I1WPX_I11    1
#define INSTR_I1I1WPX_I12    2

/****************************************************************************/
/*               OPERAND TYPES TABLE                                        */ 
/****************************************************************************/ 
                                                                               
//the operand types array in a given entry                                     
INSTR_OperandType* INSTR_operandTypes(INSTR_InstrCategory index);              

/***************************************************************************/ 
/*              OPCODES OF INSTRUCTIONS                                    */  
/***************************************************************************/  
//  Instructions for term unification and creation  
#define put_variable_t   0
#define put_variable_p   1
#define put_value_t   2
#define put_value_p   3
#define put_unsafe_value   4
#define copy_value   5
#define put_m_const   6
#define put_p_const   7
#define put_nil   8
#define put_integer   9
#define put_float   10
#define put_string   11
#define put_index   12
#define put_app   13
#define put_list   14
#define put_lambda   15
#define set_variable_t   16
#define set_variable_te   17
#define set_variable_p   18
#define set_value_t   19
#define set_value_p   20
#define globalize_pt   21
#define globalize_t   22
#define set_m_const   23
#define set_p_const   24
#define set_nil   25
#define set_integer   26
#define set_float   27
#define set_string   28
#define set_index   29
#define set_void   30
#define deref   31
#define set_lambda   32
#define get_variable_t   33
#define get_variable_p   34
#define init_variable_t   35
#define init_variable_p   36
#define get_m_constant   37
#define get_p_constant   38
#define get_integer   39
#define get_float   40
#define get_string   41
#define get_nil   42
#define get_m_structure   43
#define get_p_structure   44
#define get_list   45
#define unify_variable_t   46
#define unify_variable_p   47
#define unify_value_t   48
#define unify_value_p   49
#define unify_local_value_t   50
#define unify_local_value_p   51
#define unify_m_constant   52
#define unify_p_constant   53
#define unify_integer   54
#define unify_float   55
#define unify_string   56
#define unify_nil   57
#define unify_void   58
// Instructions for type unification and creation 
#define put_type_variable_t   59
#define put_type_variable_p   60
#define put_type_value_t   61
#define put_type_value_p   62
#define put_type_unsafe_value   63
#define put_type_const   64
#define put_type_structure   65
#define put_type_arrow   66
#define set_type_variable_t   67
#define set_type_variable_p   68
#define set_type_value_t   69
#define set_type_value_p   70
#define set_type_local_value_t   71
#define set_type_local_value_p   72
#define set_type_constant   73
#define get_type_variable_t   74
#define get_type_variable_p   75
#define init_type_variable_t   76
#define init_type_variable_p   77
#define get_type_value_t   78
#define get_type_value_p   79
#define get_type_constant   80
#define get_type_structure   81
#define get_type_arrow   82
#define unify_type_variable_t   83
#define unify_type_variable_p   84
#define unify_type_value_t   85
#define unify_type_value_p   86
#define unify_envty_value_t   87
#define unify_envty_value_p   88
#define unify_type_local_value_t   89
#define unify_type_local_value_p   90
#define unify_envty_local_value_t   91
#define unify_envty_local_value_p   92
#define unify_type_constant   93
// Instructions for handling higher-order aspects  
#define pattern_unify_t   94
#define pattern_unify_p   95
#define finish_unify   96
#define head_normalize_t   97
#define head_normalize_p   98
// Instructions for handling logical aspects   
#define incr_universe   99
#define decr_universe   100
#define set_univ_tag   101
#define tag_exists_t   102
#define tag_exists_p   103
#define tag_variable   104
#define push_impl_point   105
#define pop_impl_point   106
#define add_imports   107
#define remove_imports   108
#define push_import   109
#define pop_imports   110
// Control Instructions  
#define allocate   111
#define deallocate   112
#define call   113
#define call_name   114
#define execute   115
#define execute_name   116
#define proceed   117
// Choice Instructions  
#define try_me_else   118
#define retry_me_else   119
#define trust_me   120
#define try   121
#define retry   122
#define trust   123
#define trust_ext   124
#define try_else   125
#define retry_else   126
#define branch   127
// Indexing Instructions 
#define switch_on_term   128
#define switch_on_constant   129
#define switch_on_bvar   130
#define switch_on_reg   131
// Cut Instructions  
#define neck_cut   132
#define get_level   133
#define put_level   134
#define cut   135
// Miscellaneous Instructions 
#define call_builtin   136
#define builtin   137
#define stop   138
#define halt   139
#define fail   140
// new added 
#define create_type_variable   141
// resolved by the linker 
#define execute_link_only   142
#define call_link_only   143
#define put_variable_te   144


#define INSTR_NUM_INSTRS   145

/***************************************************************************/ 
/*              INSTRUCTION INFORMATION TABLE                              */ 
/***************************************************************************/  
INSTR_InstrCategory INSTR_instrType(int index);  //instr type in a given entry 
char*               INSTR_instrName(int index);  //instr name in a given entry 
int                 INSTR_instrSize(int index);  //instr size in a given entry 

#endif //INSTRUCTIONS_H

