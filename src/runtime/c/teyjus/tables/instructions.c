/****************************************************************************/
/*                                                                          */ 
/*   File  instructions.c. This file defines the operand types table and    */ 
/*   the instruction information table.                                     */ 
/*                                                                          */ 
/****************************************************************************/ 


#include "instructions.h"

/****************************************************************************/
/*    OPERAND TYPES TABLE                                                   */ 
/****************************************************************************/ 

/* Max number of operand that could be taken by instructions including the  */
/* padding bytes and one to terminate the list. (machine dependent)         */ 
#define INSTR_MAX_OPERAND     8

/* this array is indexed by instruction category.  For each category,         
   INSTR_operandTypeTab contains a string of values indicating the type        
   of the operand at that position, terminated by INSTR_X.  This               
   information is useful when parsing instruction streams. */                  
typedef INSTR_OperandType                                                      
        INSTR_OperandTypeTab[INSTR_NUM_INSTR_CATS][INSTR_MAX_OPERAND];         

INSTR_OperandTypeTab INSTR_operandTypeTable ={
    //INSTR_CAT_X
    {INSTR_P, INSTR_P, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RX
    {INSTR_R, INSTR_P, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_EX
    {INSTR_E, INSTR_P, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1X
    {INSTR_I1, INSTR_P, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_CX
    {INSTR_P, INSTR_C, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_KX
    {INSTR_P, INSTR_K, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_IX
    {INSTR_P, INSTR_P, INSTR_P, INSTR_I, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_FX
    {INSTR_P, INSTR_P, INSTR_P, INSTR_F, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_SX
    {INSTR_P, INSTR_P, INSTR_P, INSTR_S, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_MTX
    {INSTR_P, INSTR_P, INSTR_P, INSTR_MT, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_LX
    {INSTR_P, INSTR_P, INSTR_P, INSTR_L, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RRX
    {INSTR_R, INSTR_R, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_ERX
    {INSTR_E, INSTR_R, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RCX
    {INSTR_R, INSTR_C, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RIX
    {INSTR_R, INSTR_P, INSTR_P, INSTR_I, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RFX
    {INSTR_R, INSTR_P, INSTR_P, INSTR_F, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RSX
    {INSTR_R, INSTR_P, INSTR_P, INSTR_S, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RI1X
    {INSTR_R, INSTR_I1, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RCEX
    {INSTR_R, INSTR_CE, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_ECEX
    {INSTR_E, INSTR_CE, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_CLX
    {INSTR_P, INSTR_C, INSTR_L, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RKX
    {INSTR_R, INSTR_K, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_ECX
    {INSTR_E, INSTR_C, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1ITX
    {INSTR_I1, INSTR_P, INSTR_P, INSTR_IT, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1LX
    {INSTR_I1, INSTR_P, INSTR_P, INSTR_L, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_SEGLX
    {INSTR_SEG, INSTR_P, INSTR_P, INSTR_L, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1LWPX
    {INSTR_I1, INSTR_P, INSTR_P, INSTR_L, INSTR_WP, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1NX
    {INSTR_I1, INSTR_N, INSTR_P, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1HTX
    {INSTR_I1, INSTR_P, INSTR_P, INSTR_HT, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1BVTX
    {INSTR_I1, INSTR_P, INSTR_P, INSTR_BVT, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_CWPX
    {INSTR_P, INSTR_C, INSTR_WP, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1WPX
    {INSTR_I1, INSTR_P, INSTR_P, INSTR_WP, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RRI1X
    {INSTR_R, INSTR_R, INSTR_I1, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RCLX
    {INSTR_R, INSTR_C, INSTR_L, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_RCI1X
    {INSTR_R, INSTR_C, INSTR_I1, INSTR_P, INSTR_P, INSTR_P, INSTR_X, INSTR_X},
    //INSTR_CAT_SEGI1LX
    {INSTR_SEG, INSTR_I1, INSTR_P, INSTR_L, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1LLX
    {INSTR_I1, INSTR_P, INSTR_P, INSTR_L, INSTR_L, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_NLLX
    {INSTR_N, INSTR_P, INSTR_P, INSTR_L, INSTR_L, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_LLLLX
    {INSTR_P, INSTR_P, INSTR_P, INSTR_L, INSTR_L, INSTR_L, INSTR_L, INSTR_X},
    //INSTR_CAT_I1CWPX
    {INSTR_I1, INSTR_C, INSTR_WP, INSTR_X, INSTR_X, INSTR_X, INSTR_X, INSTR_X},
    //INSTR_CAT_I1I1WPX
    {INSTR_I1, INSTR_I1, INSTR_P, INSTR_WP, INSTR_X, INSTR_X, INSTR_X, INSTR_X}
};

INSTR_OperandType* INSTR_operandTypes(INSTR_InstrCategory index)              
{                                                                              
   return INSTR_operandTypeTable[index];                                       
}

/****************************************************************************/
/*    INSTRUCTION INFORMATION TABLE                                         */ 
/****************************************************************************/ 
typedef struct                        //entry of the instruction info table   
{                                                                              
    char* name;                                                                
    INSTR_InstrCategory type;                                                  
    int   size;                                                                
} INSTR_InstrInfoTab_;                                                       

typedef INSTR_InstrInfoTab_ INSTR_InstrInfoTab[INSTR_NUM_INSTRS];              

INSTR_InstrInfoTab INSTR_instrInfoTable ={
    {"put_variable_t",  INSTR_CAT_RRX,   INSTR_RRX_LEN},
    {"put_variable_p",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"put_value_t",  INSTR_CAT_RRX,   INSTR_RRX_LEN},
    {"put_value_p",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"put_unsafe_value",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"copy_value",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"put_m_const",  INSTR_CAT_RCX,   INSTR_RCX_LEN},
    {"put_p_const",  INSTR_CAT_RCX,   INSTR_RCX_LEN},
    {"put_nil",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"put_integer",  INSTR_CAT_RIX,   INSTR_RIX_LEN},
    {"put_float",  INSTR_CAT_RFX,   INSTR_RFX_LEN},
    {"put_string",  INSTR_CAT_RSX,   INSTR_RSX_LEN},
    {"put_index",  INSTR_CAT_RI1X,   INSTR_RI1X_LEN},
    {"put_app",  INSTR_CAT_RRI1X,   INSTR_RRI1X_LEN},
    {"put_list",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"put_lambda",  INSTR_CAT_RRI1X,   INSTR_RRI1X_LEN},
    {"set_variable_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"set_variable_te",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"set_variable_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"set_value_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"set_value_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"globalize_pt",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"globalize_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"set_m_const",  INSTR_CAT_CX,   INSTR_CX_LEN},
    {"set_p_const",  INSTR_CAT_CX,   INSTR_CX_LEN},
    {"set_nil",  INSTR_CAT_X,   INSTR_X_LEN},
    {"set_integer",  INSTR_CAT_IX,   INSTR_IX_LEN},
    {"set_float",  INSTR_CAT_FX,   INSTR_FX_LEN},
    {"set_string",  INSTR_CAT_SX,   INSTR_SX_LEN},
    {"set_index",  INSTR_CAT_I1X,   INSTR_I1X_LEN},
    {"set_void",  INSTR_CAT_I1X,   INSTR_I1X_LEN},
    {"deref",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"set_lambda",  INSTR_CAT_RI1X,   INSTR_RI1X_LEN},
    {"get_variable_t",  INSTR_CAT_RRX,   INSTR_RRX_LEN},
    {"get_variable_p",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"init_variable_t",  INSTR_CAT_RCEX,   INSTR_RCEX_LEN},
    {"init_variable_p",  INSTR_CAT_ECEX,   INSTR_ECEX_LEN},
    {"get_m_constant",  INSTR_CAT_RCX,   INSTR_RCX_LEN},
    {"get_p_constant",  INSTR_CAT_RCLX,   INSTR_RCLX_LEN},
    {"get_integer",  INSTR_CAT_RIX,   INSTR_RIX_LEN},
    {"get_float",  INSTR_CAT_RFX,   INSTR_RFX_LEN},
    {"get_string",  INSTR_CAT_RSX,   INSTR_RSX_LEN},
    {"get_nil",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"get_m_structure",  INSTR_CAT_RCI1X,   INSTR_RCI1X_LEN},
    {"get_p_structure",  INSTR_CAT_RCI1X,   INSTR_RCI1X_LEN},
    {"get_list",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_variable_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_variable_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"unify_value_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_value_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"unify_local_value_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_local_value_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"unify_m_constant",  INSTR_CAT_CX,   INSTR_CX_LEN},
    {"unify_p_constant",  INSTR_CAT_CLX,   INSTR_CLX_LEN},
    {"unify_integer",  INSTR_CAT_IX,   INSTR_IX_LEN},
    {"unify_float",  INSTR_CAT_FX,   INSTR_FX_LEN},
    {"unify_string",  INSTR_CAT_SX,   INSTR_SX_LEN},
    {"unify_nil",  INSTR_CAT_X,   INSTR_X_LEN},
    {"unify_void",  INSTR_CAT_I1X,   INSTR_I1X_LEN},
    {"put_type_variable_t",  INSTR_CAT_RRX,   INSTR_RRX_LEN},
    {"put_type_variable_p",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"put_type_value_t",  INSTR_CAT_RRX,   INSTR_RRX_LEN},
    {"put_type_value_p",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"put_type_unsafe_value",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"put_type_const",  INSTR_CAT_RKX,   INSTR_RKX_LEN},
    {"put_type_structure",  INSTR_CAT_RKX,   INSTR_RKX_LEN},
    {"put_type_arrow",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"set_type_variable_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"set_type_variable_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"set_type_value_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"set_type_value_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"set_type_local_value_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"set_type_local_value_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"set_type_constant",  INSTR_CAT_KX,   INSTR_KX_LEN},
    {"get_type_variable_t",  INSTR_CAT_RRX,   INSTR_RRX_LEN},
    {"get_type_variable_p",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"init_type_variable_t",  INSTR_CAT_RCEX,   INSTR_RCEX_LEN},
    {"init_type_variable_p",  INSTR_CAT_ECEX,   INSTR_ECEX_LEN},
    {"get_type_value_t",  INSTR_CAT_RRX,   INSTR_RRX_LEN},
    {"get_type_value_p",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"get_type_constant",  INSTR_CAT_RKX,   INSTR_RKX_LEN},
    {"get_type_structure",  INSTR_CAT_RKX,   INSTR_RKX_LEN},
    {"get_type_arrow",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_type_variable_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_type_variable_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"unify_type_value_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_type_value_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"unify_envty_value_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_envty_value_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"unify_type_local_value_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_type_local_value_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"unify_envty_local_value_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"unify_envty_local_value_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"unify_type_constant",  INSTR_CAT_KX,   INSTR_KX_LEN},
    {"pattern_unify_t",  INSTR_CAT_RRX,   INSTR_RRX_LEN},
    {"pattern_unify_p",  INSTR_CAT_ERX,   INSTR_ERX_LEN},
    {"finish_unify",  INSTR_CAT_X,   INSTR_X_LEN},
    {"head_normalize_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"head_normalize_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"incr_universe",  INSTR_CAT_X,   INSTR_X_LEN},
    {"decr_universe",  INSTR_CAT_X,   INSTR_X_LEN},
    {"set_univ_tag",  INSTR_CAT_ECX,   INSTR_ECX_LEN},
    {"tag_exists_t",  INSTR_CAT_RX,   INSTR_RX_LEN},
    {"tag_exists_p",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"tag_variable",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"push_impl_point",  INSTR_CAT_I1ITX,   INSTR_I1ITX_LEN},
    {"pop_impl_point",  INSTR_CAT_X,   INSTR_X_LEN},
    {"add_imports",  INSTR_CAT_SEGI1LX,   INSTR_SEGI1LX_LEN},
    {"remove_imports",  INSTR_CAT_SEGLX,   INSTR_SEGLX_LEN},
    {"push_import",  INSTR_CAT_MTX,   INSTR_MTX_LEN},
    {"pop_imports",  INSTR_CAT_I1X,   INSTR_I1X_LEN},
    {"allocate",  INSTR_CAT_I1X,   INSTR_I1X_LEN},
    {"deallocate",  INSTR_CAT_X,   INSTR_X_LEN},
    {"call",  INSTR_CAT_I1LX,   INSTR_I1LX_LEN},
    {"call_name",  INSTR_CAT_I1CWPX,   INSTR_I1CWPX_LEN},
    {"execute",  INSTR_CAT_LX,   INSTR_LX_LEN},
    {"execute_name",  INSTR_CAT_CWPX,   INSTR_CWPX_LEN},
    {"proceed",  INSTR_CAT_X,   INSTR_X_LEN},
    {"try_me_else",  INSTR_CAT_I1LX,   INSTR_I1LX_LEN},
    {"retry_me_else",  INSTR_CAT_I1LX,   INSTR_I1LX_LEN},
    {"trust_me",  INSTR_CAT_I1WPX,   INSTR_I1WPX_LEN},
    {"try",  INSTR_CAT_I1LX,   INSTR_I1LX_LEN},
    {"retry",  INSTR_CAT_I1LX,   INSTR_I1LX_LEN},
    {"trust",  INSTR_CAT_I1LWPX,   INSTR_I1LWPX_LEN},
    {"trust_ext",  INSTR_CAT_I1NX,   INSTR_I1NX_LEN},
    {"try_else",  INSTR_CAT_I1LLX,   INSTR_I1LLX_LEN},
    {"retry_else",  INSTR_CAT_I1LLX,   INSTR_I1LLX_LEN},
    {"branch",  INSTR_CAT_LX,   INSTR_LX_LEN},
    {"switch_on_term",  INSTR_CAT_LLLLX,   INSTR_LLLLX_LEN},
    {"switch_on_constant",  INSTR_CAT_I1HTX,   INSTR_I1HTX_LEN},
    {"switch_on_bvar",  INSTR_CAT_I1BVTX,   INSTR_I1BVTX_LEN},
    {"switch_on_reg",  INSTR_CAT_NLLX,   INSTR_NLLX_LEN},
    {"neck_cut",  INSTR_CAT_X,   INSTR_X_LEN},
    {"get_level",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"put_level",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"cut",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"call_builtin",  INSTR_CAT_I1I1WPX,   INSTR_I1I1WPX_LEN},
    {"builtin",  INSTR_CAT_I1X,   INSTR_I1X_LEN},
    {"stop",  INSTR_CAT_X,   INSTR_X_LEN},
    {"halt",  INSTR_CAT_X,   INSTR_X_LEN},
    {"fail",  INSTR_CAT_X,   INSTR_X_LEN},
    {"create_type_variable",  INSTR_CAT_EX,   INSTR_EX_LEN},
    {"execute_link_only",  INSTR_CAT_CWPX,   INSTR_CWPX_LEN},
    {"call_link_only",  INSTR_CAT_I1CWPX,   INSTR_I1CWPX_LEN},
    {"put_variable_te",  INSTR_CAT_RRX,   INSTR_RRX_LEN}
};

/* Accessing functions */                                                     
INSTR_InstrCategory INSTR_instrType(int index)                                 
{                                                                              
    return (INSTR_instrInfoTable[index]).type;                                 
}                                                                            

char* INSTR_instrName(int index)                                               
{                                                                              
    return (INSTR_instrInfoTable[index]).name;                                 
}                                                                            

int   INSTR_instrSize(int index)                                               
{                                                                              
    return (INSTR_instrInfoTable[index]).size;                                 
}


