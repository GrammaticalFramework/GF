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
/*                                                                       */
/* File instraccess.h. Micros for access instruction arguments are       */
/* defined, which depends on the instruction format.                     */
/*************************************************************************/

#ifndef INSTRACCESS_H
#define INSTRACCESS_H

#include "../tables/instructions.h" //to be modified

#define INSACC_CALL_I1(op)  (*((INSTR_OneByteInt *)((op) - INSTR_CALL_I1_LEN)))

//INSTR_CAT_X
#define INSACC_X() { AM_preg += INSTR_X_LEN;      }

//INSTR_CAT_RX
#define INSACC_RX(op) {\
   (op) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RX_R)));   \
   AM_preg += INSTR_RX_LEN;                                   \
}

//INSTR_CAT_EX
#define INSACC_EX(op) {\
   (op) = AM_envVar(*((INSTR_EnvInd *)(AM_preg + INSTR_EX_E)));  \
   AM_preg += INSTR_EX_LEN;                                        \
}

//INSTR_CAT_I1X
#define INSACC_I1X(op) {\
   (op) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1X_I1));   \
   AM_preg += INSTR_I1X_LEN;                                 \
}

//INSTR_CAT_CX
#define INSACC_CX(op) {\
   (op) = *((INSTR_CstIndex *)(AM_preg + INSTR_CX_C));       \
   AM_preg += INSTR_CX_LEN;                                  \
}

//INSTR_CAT_KX
#define INSACC_KX(op) {\
   (op) = *((INSTR_KstIndex *)(AM_preg + INSTR_KX_K));       \
   AM_preg += INSTR_KX_LEN;                                  \
}

//INSTR_CAT_IX
#define INSACC_IX(op) {\
   (op) = *((INSTR_Int *)(AM_preg + INSTR_IX_I));    \
   AM_preg += INSTR_IX_LEN;                          \
}

//INSTR_CAT_FX
#define INSACC_FX(op) {\
   (op) = *((INSTR_Float *)(AM_preg + INSTR_FX_F));    \
   AM_preg += INSTR_FX_LEN;                            \
}

//INSTR_CAT_SX
#define INSACC_SX(op) {\
   (op) = *((INSTR_Str *)(AM_preg + INSTR_SX_S));    \
   AM_preg += INSTR_SX_LEN;                          \
}

//INSTR_CAT_MTX
#define INSACC_MTX(op) {\
   (op) = *((INSTR_ModTab *)(AM_preg + INSTR_MTX_MT)); \
   AM_preg += INSTR_MTX_LEN;                           \
}

//INSTR_CAT_RRX
#define INSACC_RRX(op1, op2) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RRX_R1))); \
   (op2) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RRX_R2))); \
   AM_preg += INSTR_RRX_LEN;                                    \
}

//INSTR_CAT_ERX
#define INSACC_ERX(op1, op2) {\
   (op1) = AM_envVar(*((INSTR_EnvInd *)(AM_preg + INSTR_ERX_E))); \
   (op2) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_ERX_R)));       \
   AM_preg += INSTR_ERX_LEN;                                         \
}

//INSTR_CAT_RCX
#define INSACC_RCX(op1, op2) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RCX_R)));   \
   (op2) = *((INSTR_CstIndex *)(AM_preg + INSTR_RCX_C));         \
   AM_preg += INSTR_RCX_LEN;                                     \
}

//INSTR_CAT_RIX
#define INSACC_RIX(op1, op2) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RIX_R)));  \
   (op2) = *((INSTR_Int *)(AM_preg + INSTR_RIX_I));             \
   AM_preg += INSTR_RIX_LEN;                                    \
}

//INSTR_CAT_RFX
#define INSACC_RFX(op1, op2) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RFX_R)));  \
   (op2) = *((INSTR_Float *)(AM_preg + INSTR_RFX_F));             \
   AM_preg += INSTR_RFX_LEN;                                    \
}

//INSTR_CAT_RSX
#define INSACC_RSX(op1, op2) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RSX_R)));  \
   (op2) = *((INSTR_Str *)(AM_preg + INSTR_RSX_S));             \
   AM_preg += INSTR_RSX_LEN;                                    \
}

//INSTR_CAT_RI1X
#define INSACC_RI1X(op1, op2) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RI1X_R))); \
   (op2) = *((INSTR_OneByteInt *)(AM_preg + INSTR_RI1X_I1));    \
   AM_preg += INSTR_RI1X_LEN;                                   \
}

//INSTR_CAT_RCEX
#define INSACC_RCEX(op1, op2) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RCEX_R)));         \
   (op2) = AM_cenvVar(*((INSTR_ClEnvInd *)(AM_preg + INSTR_RCEX_CE))); \
   AM_preg += INSTR_RCEX_LEN;                                           \
} 

//INSTR_CAT_ECEX
#define INSACC_ECEX(op1, op2) {\
   (op1) = AM_envVar(*((INSTR_EnvInd *)(AM_preg + INSTR_ECEX_E)));   \
   (op2) = AM_cenvVar(*((INSTR_ClEnvInd *)(AM_preg + INSTR_ECEX_CE))); \
   AM_preg += INSTR_ECEX_LEN;                                           \
}
 
//INSTR_CAT_CLX
#define INSACC_CLX(op1, op2) {\
   (op1) = *((INSTR_CstIndex *)(AM_preg + INSTR_CLX_C));     \
   (op2) = *((INSTR_CodeLabel *)(AM_preg + INSTR_CLX_L));    \
   AM_preg += INSTR_CLX_LEN;                                 \
}

//INSTR_CAT_RKX
#define INSACC_RKX(op1, op2) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RKX_R))); \
   (op2) = *((INSTR_KstIndex *)(AM_preg + INSTR_RKX_K));       \
   AM_preg += INSTR_RKX_LEN;                                   \
}

//INSTR_CAT_ECX
#define INSACC_ECX(op1, op2) {\
   (op1) = AM_envVar(*((INSTR_EnvInd *)(AM_preg + INSTR_ECX_E))); \
   (op2) = *((INSTR_CstIndex *)(AM_preg + INSTR_ECX_C));             \
   AM_preg += INSTR_ECX_LEN;                                         \
} 

//INSTR_CAT_I1ITX
#define INSACC_I1ITX(op1, op2) {\
   (op1) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1ITX_I1));   \
   (op2) = *((INSTR_ImplTab *)(AM_preg + INSTR_I1ITX_IT));      \
   AM_preg += INSTR_I1ITX_LEN;                                  \
}

//INSTR_CAT_I1LX
#define INSACC_I1LX(op1, op2) {\
   (op1) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1LX_I1));    \
   (op2) = *((INSTR_CodeLabel *)(AM_preg + INSTR_I1LX_L));      \
   AM_preg += INSTR_I1LX_LEN;                                   \
}

//INSTR_CAT_SEGLX
#define INSACC_SEGLX(op1, op2) {\
   (op1) = *((INSTR_ImpSegInd *)(AM_preg + INSTR_SEGLX_SEG));    \
   (op2) = *((INSTR_CodeLabel *)(AM_preg + INSTR_SEGLX_L));      \
   AM_preg += INSTR_SEGLX_LEN;                                   \
}


//INSTR_CAT_I1NX 
#define INSACC_I1NX(op1, op2) {\
   (op1) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1NX_I1));    \
   (op2) = *((INSTR_NextClauseInd *)(AM_preg + INSTR_I1NX_N));  \
   AM_preg += INSTR_I1NX_LEN;                                   \
}

//INSTR_CAT_I1HTX
#define INSACC_I1HTX(op1, op2) {\
   (op1) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1HTX_I1));  \
   (op2) = *((INSTR_HashTab *)(AM_preg + INSTR_I1HTX_HT));     \
   AM_preg += INSTR_I1HTX_LEN;                                 \
}

//INSTR_CAT_I1BVTX
#define INSACC_I1BVTX(op1, op2) {\
   (op1) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1BVTX_I1)); \
   (op2) = *((INSTR_BranchTab *)(AM_preg + INSTR_I1BVTX_BVT));  \
   AM_preg += INSTR_I1BVTX_LEN;                                \
}

//INSTR_CAT_CWPX
#define INSACC_CWPX(op) {\
   (op) = *((INSTR_CstIndex *)(AM_preg + INSTR_CWPX_C));    \
   AM_preg += INSTR_CWPX_LEN;                               \
}

//INSTR_CAT_I1WPX
#define INSACC_I1WPX(op) {\
   (op) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1WPX_I1)); \
   AM_preg += INSTR_I1WPX_LEN;                               \
}

//INSTR_CAT_RRI1X
#define INSACC_RRI1X(op1, op2, op3) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RRI1X_R1))); \
   (op2) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RRI1X_R2))); \
   (op3) = *((INSTR_OneByteInt *)(AM_preg + INSTR_RRI1X_I1));     \
   AM_preg += INSTR_RRI1X_LEN;                                    \
} 

//INSTR_CAT_RCLX
#define INSACC_RCLX(op1, op2, op3) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RCLX_R))); \
   (op2) = *((INSTR_CstIndex *)(AM_preg + INSTR_RCLX_C));       \
   (op3) = *((INSTR_CodeLabel *)(AM_preg + INSTR_RCLX_L));      \
   AM_preg += INSTR_RCLX_LEN;                                   \
}

//INSTR_CAT_RCI1X
#define INSACC_RCI1X(op1, op2, op3) {\
   (op1) = AM_reg(*((INSTR_RegInd *)(AM_preg + INSTR_RCI1X_R))); \
   (op2) = *((INSTR_CstIndex *)(AM_preg + INSTR_RCI1X_C));       \
   (op3) = *((INSTR_OneByteInt *)(AM_preg + INSTR_RCI1X_I1));    \
   AM_preg += INSTR_RCI1X_LEN;                                   \
}

//INSTR_CAT_SEGI1LX
#define INSACC_SEGI1LX(op1, op2, op3) {\
   (op1) = *((INSTR_ImpSegInd *)(AM_preg + INSTR_SEGI1LX_SEG)); \
   (op2) = *((INSTR_OneByteInt *)(AM_preg + INSTR_SEGI1LX_I1)); \
   (op3) = *((INSTR_CodeLabel *)(AM_preg + INSTR_SEGI1LX_L));    \
   AM_preg += INSTR_SEGI1LX_LEN;                                 \
}



//specialized
//INSTR_CAT_LX
#define INSACC_LX() {AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_LX_L));}

//INSTR_CAT_I1LX
#define INSACC_I1LX_I1(op) {\
   (op) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1LX_I1));    \
}

//INSTR_CAT_I1LWPX
#define INSACC_I1LWPX_I1(op) {\
   (op) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1LWPX_I1));  \
}

//INSACC_CAT_I1LLX
#define INSACC_I1LLX(op1, op2) {\
   (op1) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1LLX_I1)); \
   (op2) = *((INSTR_CodeLabel *)(AM_preg + INSTR_I1LLX_L1));  \
   AM_preg = *((INSTR_CodeLabel *)(AM_preg + INSTR_I1LLX_L2)); \
}

//INSACC_CAT_NLLX
#define INSACC_NLLX_N(op) {\
   (op) = *((INSTR_NextClauseInd *)(AM_preg + INSTR_NLLX_N)); \
}

//INSTR_CAT_I1CWPX
#define INSACC_I1CWPX_C(op) {\
   (op) = *((INSTR_CstIndex *)(AM_preg + INSTR_I1CWPX_C)); \
}


//INSTR_CAT_I1I1WPX
#define INSACC_I1I1WPX(op1) {\
   (op1) = *((INSTR_OneByteInt *)(AM_preg + INSTR_I1I1WPX_I12)); \
   AM_preg += INSTR_I1I1WPX_LEN;                                 \
}
#endif //INSTRACCESS_H
