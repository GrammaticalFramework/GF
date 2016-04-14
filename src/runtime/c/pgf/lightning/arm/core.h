/******************************** -*- C -*- ****************************
 *
 *	Platform-independent layer (arm version)
 *
 ***********************************************************************/

/***********************************************************************
 *
 * Copyright 2011 Free Software Foundation, Inc.
 *
 * This file is part of GNU lightning.
 *
 * GNU lightning is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 *
 * GNU lightning is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with GNU lightning; see the file COPYING.LESSER; if not, write to the
 * Free Software Foundation, 59 Temple Place - Suite 330, Boston,
 * MA 02111-1307, USA.
 *
 * Authors:
 *	Paulo Cesar Pereira de Andrade
 ***********************************************************************/

#ifndef __lightning_core_arm_h
#define __lightning_core_arm_h

typedef unsigned char		_uc, jit_insn;

struct {
    _ui		version		: 4;
    _ui		extend		: 1;
    /* only generate thumb instructions for thumb2 */
    _ui		thumb		: 1;
    _ui		vfp		: 3;
    _ui		neon		: 1;
    _ui		abi		: 2;
} jit_cpu;
struct {
    /* prevent using thumb instructions that set flags? */
    _ui		no_set_flags	: 1;
} jit_flags;

struct jit_local_state {
    int		 reglist;
    int		 framesize;
    int		 nextarg_get;
    int		 nextarg_put;
    int		 nextarg_getf;
    int		 alloca_offset;
    int		 stack_length;
    int		 stack_offset;
    void	*stack;
    jit_thumb_t	thumb;
    jit_insn* thumb_pc;
    jit_insn* thumb_tmp;
    int tmp;
    /* hackish mostly to make test cases work; use arm instruction
     * set in jmpi if did not yet see a prolog */
    int		 after_prolog;
    void	*arguments[256];
    int		 types[8];
#ifdef JIT_NEED_PUSH_POP
    /* minor support for unsupported code but that exists in test cases... */
    int		 push[32];
    int		 pop;
#endif
};

#define JIT_R_NUM			4
static const jit_gpr_t
jit_r_order[JIT_R_NUM] = {
    _R0, _R1, _R2, _R3
};
#define JIT_R(i)			jit_r_order[i]

#define JIT_V_NUM			4
static const jit_gpr_t
jit_v_order[JIT_V_NUM] = {
    _R4, _R5, _R6, _R7
};
#define JIT_V(i)			jit_v_order[i]

#define JIT_FRAMESIZE			48

#define jit_no_set_flags()		jit_flags.no_set_flags
#define jit_thumb_p()			jit_cpu.thumb
#define jit_armv5_p()			(jit_cpu.version >= 5)
#define jit_armv5e_p()			(jit_cpu.version >= 5 && jit_cpu.extend)
#define jit_armv7r_p()			0
#define jit_swf_p()			(jit_cpu.vfp == 0)
#define jit_hardfp_p()			jit_cpu.abi

#define __jit_inline static

#ifdef USE_THUMB_CODE
#define jit_nop(n) \
{ \
    assert(n >= 0); \
	for (; n > 0; n -= 2) \
		T1_NOP(); \
}
#else
#define jit_nop(n) \
{ \
    assert(n >= 0); \
	for (; n > 0; n -= 4) \
		_NOP(); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_movr_i(r0, r1) \
{ \
    if (r0 != r1) { \
	    T1_MOV(r0, r1); \
    } \
}
#else
#define jit_movr_i(r0, r1) \
{ \
    if (r0 != r1) { \
		_MOV(r0, r1); \
    } \
}
#endif

#define jit_movi_i(r0, i0) \
	((!jit_no_set_flags() && r0 < 8 && !(i0 & 0xffffff80)) ? \
	     T1_MOVI(r0, i0) : \
	 ((_jitl.tmp = encode_thumb_immediate(i0)) != -1) ? \
	     T2_MOVI(r0, _jitl.tmp) : \
	 ((_jitl.tmp = encode_thumb_immediate(~i0)) != -1) ? \
	     T2_MVNI(r0, _jitl.tmp) : \
	 ( T2_MOVWI(r0, _jit_US(i0)), \
	     ((i0 & 0xffff0000) ? T2_MOVTI(r0, _jit_US((unsigned)i0 >> 16)) : 0) ))

#ifdef USE_THUMB_CODE
#define jit_movi_p(r0, i0) \
	(T2_MOVWI(r0, _jit_US((int)i0)), T2_MOVTI(r0, _jit_US((int)i0 >> 16)), _jit.x.pc-8)
#else
#define jit_movi_p(r0, i0) \
	((jit_armv6_p()) ? \
	    (_MOVWI(r0, _jit_US((unsigned int)i0)), \
	     _MOVTI(r0, _jit_US(((unsigned int)i0) >> 16)), \
	     _jit.x.pc - 8) : \
	    (_MOVI(r0, encode_arm_immediate(((int) i0) & 0xff000000)), \
	     _ORRI(r0, r0, encode_arm_immediate(((int) i0) & 0x00ff0000)), \
	     _ORRI(r0, r0, encode_arm_immediate(((int) i0) & 0x0000ff00)), \
	     _ORRI(r0, r0, ((int) i0) & 0x000000ff), \
	     _jit.x.pc - 16))
#endif

#ifdef USE_THUMB_CODE
#define jit_patch_movi(i0, i1) \
{ \
    union { \
	short		*s; \
	int		*i; \
	void		*v; \
    } u; \
    jit_thumb_t		 thumb; \
    unsigned int	 im; \
    int			 q0, q1, q2, q3; \
    im = (unsigned int)i1;		u.v = i0; \
\
	q0 = (im & 0xf000) << 4; \
	q1 = (im & 0x0800) << 15; \
	q2 = (im & 0x0700) << 4; \
	q3 =  im & 0x00ff; \
	code2thumb(thumb.s[0], thumb.s[1], u.s[0], u.s[1]); \
	assert(   (thumb.i & 0xfbf00000) == THUMB2_MOVWI); \
	thumb.i = (thumb.i & 0xfbf00f00) | q0 | q1 | q2 | q3; \
	thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]); \
	im >>= 16; \
	q0 = (im & 0xf000) << 4; \
	q1 = (im & 0x0800) << 15; \
	q2 = (im & 0x0700) << 4; \
	q3 =  im & 0x00ff; \
	code2thumb(thumb.s[0], thumb.s[1], u.s[2], u.s[3]); \
	assert(   (thumb.i & 0xfbf00000) == THUMB2_MOVTI); \
	thumb.i = (thumb.i & 0xfbf00f00) | q0 | q1 | q2 | q3; \
	thumb2code(thumb.s[0], thumb.s[1], u.s[2], u.s[3]); \
} 
#else
#define jit_patch_movi(i0, i1) \
{ \
    union { \
	short		*s; \
	int		*i; \
	void		*v; \
    } u; \
    jit_thumb_t		 thumb; \
    unsigned int	 im; \
    int			 q0, q1, q2, q3; \
    im = (unsigned int)i1;		u.v = i0; \
\
	if (jit_armv6_p()) { \
	    q0 =  im &      0xfff; \
	    q1 = (im &     0xf000) <<  4; \
	    q2 = (im &  0xfff0000) >> 16; \
	    q3 = (im & 0xf0000000) >> 12; \
	    assert(  (u.i[0] & 0x0ff00000) == (ARM_MOVWI)); \
	    assert(  (u.i[1] & 0x0ff00000) == (ARM_MOVTI)); \
	    u.i[0] = (u.i[0] & 0xfff0f000) | q1 | q0; \
	    u.i[1] = (u.i[1] & 0xfff0f000) | q3 | q2; \
	} \
	else { \
	    q0 = im & 0x000000ff;	q1 = im & 0x0000ff00; \
	    q2 = im & 0x00ff0000;	q3 = im & 0xff000000; \
	    assert(  (u.i[0] & 0x0ff00000) == (ARM_MOV|ARM_I)); \
	    u.i[0] = (u.i[0] & 0xfffff000) | encode_arm_immediate(q3); \
	    assert(  (u.i[1] & 0x0ff00000) == (ARM_ORR|ARM_I)); \
	    u.i[1] = (u.i[1] & 0xfffff000) | encode_arm_immediate(q2); \
	    assert(  (u.i[2] & 0x0ff00000) == (ARM_ORR|ARM_I)); \
	    u.i[2] = (u.i[2] & 0xfffff000) | encode_arm_immediate(q1); \
	    assert(  (u.i[3] & 0x0ff00000) == (ARM_ORR|ARM_I)); \
	    u.i[3] = (u.i[3] & 0xfffff000) | encode_arm_immediate(q0); \
	} \
} 
#endif

#define jit_patch_calli(i0, i1)		jit_patch_at(i0, i1)

#ifdef USE_THUMB_CODE
#define jit_patch_at(jump, label) \
{ \
    long d; \
    union { \
		short *s; \
		int *i; \
		void *v; \
    } u; \
    jit_thumb_t		 thumb; \
    u.v = jump; \
    if (jump >= _jitl.thumb_pc) \
	{ \
	    code2thumb(thumb.s[0], thumb.s[1], u.s[0], u.s[1]); \
	    if ((thumb.i & THUMB2_B) == THUMB2_B) { \
			d = (((long)label - (long)jump) >> 1) - 2; \
			assert(_s24P(d)); \
			thumb.i = THUMB2_B | encode_thumb_jump(d); \
			thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]); \
	    } \
	    else if ((thumb.i & THUMB2_B) == THUMB2_CC_B) { \
			d = (((long)label - (long)jump) >> 1) - 2; \
			assert(_s20P(d)); \
			thumb.i = THUMB2_CC_B | (thumb.i & 0x3c00000) | \
			          encode_thumb_cc_jump(d); \
			thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]); \
	    } \
	    else if ((thumb.i & 0xfbf08000) == THUMB2_MOVWI) { \
			jit_patch_movi(jump, label); \
	    } else \
			assert(!"handled branch opcode"); \
	} else { \
		/* 0x0e000000 because 0x01000000 is (branch&) link modifier */ \
		if ((u.i[0] & 0x0e000000) == ARM_B) { \
			d = (((long)label - (long)jump) >> 2) - 2; \
			assert(_s24P(d)); \
			u.i[0] = (u.i[0] & 0xff000000) | (d & 0x00ffffff); \
		} else if ((jit_armv6_p() && (u.i[0] & 0x0ff00000) == ARM_MOVWI) || \
		           (!jit_armv6_p() && (u.i[0] & 0x0ff00000) == (ARM_MOV|ARM_I))) { \
			jit_patch_movi(jump, label); \
		} else { \
			assert(!"handled branch opcode"); \
		} \
    } \
}
#else
#define jit_patch_at(jump, label) \
{ \
    union { \
		short *s; \
		int *i; \
		void *v; \
    } u; \
    u.v = jump; \
	/* 0x0e000000 because 0x01000000 is (branch&) link modifier */ \
	if ((u.i[0] & 0x0e000000) == ARM_B) { \
		long d = (((long)label - (long)jump) >> 2) - 2; \
		assert(_s24P(d)); \
		u.i[0] = (u.i[0] & 0xff000000) | (d & 0x00ffffff); \
	} else if ((jit_armv6_p() && (u.i[0] & 0x0ff00000) == ARM_MOVWI) || \
			   (!jit_armv6_p() && (u.i[0] & 0x0ff00000) == (ARM_MOV|ARM_I))) { \
		jit_patch_movi(jump, label); \
	} else { \
		assert(!"handled branch opcode"); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_notr_i(r0, r1) \
	((!jit_no_set_flags() && (r0|r1) < 8) ? T1_NOT(r0, r1) : T2_NOT(r0, r1))
#else
#define jit_notr_i(r0, r1) \
	_NOT(r0, r1)
#endif

#ifdef USE_THUMB_CODE
#define jit_negr_i(r0, r1) \
	((!jit_no_set_flags() && (r0|r1) < 8) ? T1_RSBI(r0, r1), T2_RSBI(r0, r1, 0))
#else
#define jit_negr_i(r0, r1) \
	_RSBI(r0, r1, 0)
#endif

#ifdef USE_THUMB_CODE
#define jit_addr_i(r0, r1, r2) \
{ \
	if (!jit_no_set_flags() && (r0|r1|r2) < 8) \
	    T1_ADD(r0, r1, r2); \
	else if (r0 == r1 || r0 == r2) \
	    T1_ADDX(r0, r0 == r1 ? r2 : r1); \
	else \
	    T2_ADD(r0, r1, r2); \
}
#else
#define jit_addr_i(r0, r1, r2) \
	_ADD(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_addi_i(r0, r1, i0) \
{ \
    int		i; \
    jit_gpr_t	reg; \
	if (!jit_no_set_flags() && (r0|r1) < 8 && !(i0 & ~7)) \
	    T1_ADDI3(r0, r1, i0); \
	else if (!jit_no_set_flags() && (r0|r1) < 8 && !(-i0 & ~7)) \
	    T1_SUBI3(r0, r1, -i0); \
	else if (!jit_no_set_flags() && r0 < 8 && r0 == r1 && !(i0 & ~0xff)) \
	    T1_ADDI8(r0, i0); \
	else if (!jit_no_set_flags() && r0 < 8 && r0 == r1 && !(-i0 & ~0xff)) \
	    T1_SUBI8(r0, -i0); \
	else if ((i = encode_thumb_immediate(i0)) != -1) \
	    T2_ADDI(r0, r1, i); \
	else if ((i = encode_thumb_immediate(-i0)) != -1) \
	    T2_SUBI(r0, r1, i); \
	else if ((i = encode_thumb_word_immediate(i0)) != -1) \
	    T2_ADDWI(r0, r1, i); \
	else if ((i = encode_thumb_word_immediate(-i0)) != -1) \
	    T2_SUBWI(r0, r1, i); \
	else { \
	    reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    T2_ADD(r0, r1, reg); \
	} \
}
#else
#define jit_addi_i(r0, r1, i0) 0
#endif

#ifdef USE_THUMB_CODE
#define jit_addcr_i(r0, r1, r2) \
	/* thumb auto set carry if not inside IT block */ \
	((r0|r1|r2) < 8) ? T1_ADD(r0, r1, r2) : T2_ADDS(r0, r1, r2)
#else
#define jit_addcr_i(r0, r1, r2) \
	_ADDS(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_addci_i(r0, r1, i0) \
{  \
    int		i; \
	if ((r0|r1) < 8 && !(i0 & ~7)) \
	    T1_ADDI3(r0, r1, i0); \
	else if ((r0|r1) < 8 && !(-i0 & ~7)) \
	    T1_SUBI3(r0, r1, -i0); \
	else if (r0 < 8 && r0 == r1 && !(i0 & ~0xff)) \
	    T1_ADDI8(r0, i0); \
	else if (r0 < 8 && r0 == r1 && !(-i0 & ~0xff)) \
	    T1_SUBI8(r0, -i0); \
	else if ((i = encode_thumb_immediate(i0)) != -1) \
	    T2_ADDSI(r0, r1, i); \
	else if ((i = encode_thumb_immediate(-i0)) != -1) \
	    T2_SUBSI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    T2_ADDS(r0, r1, reg); \
	} \
} 
#else
#define jit_addci_i(r0, r1, i0) \
{  \
    int	i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _ADDSI(r0, r1, i); \
	else if ((i = encode_arm_immediate(-i0)) != -1) \
	    _SUBSI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _ADDS(r0, r1, reg); \
	} \
} 
#endif

#ifdef USE_THUMB_CODE
#define jit_addxr_i(r0, r1, r2) \
{   /* keep setting carry because don't know last ADC */ \
	/* thumb auto set carry if not inside IT block */ \
	if ((r0|r1|r2) < 8 && (r0 == r1 || r0 == r2)) \
	    T1_ADC(r0, r0 == r1 ? r2 : r1); \
	else \
	    T2_ADCS(r0, r1, r2); \
}
#else
#define jit_addxr_i(r0, r1, r2) \
    /* keep setting carry because don't know last ADC */ \
	_ADCS(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_addxi_i(r0, r1, i0) \
{ \
    int		i; \
	if ((i = encode_thumb_immediate(i0)) != -1) \
	    T2_ADCSI(r0, r1, i); \
	else if ((i = encode_thumb_immediate(-i0)) != -1) \
	    T2_SBCSI(r0, r1, i); \
	else { \
	    int no_set_flags = jit_no_set_flags(); \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_no_set_flags() = 1; \
	    jit_movi_i(reg, i0); \
	    jit_no_set_flags() = no_set_flags; \
	    T2_ADCS(r0, r1, reg); \
	} \
}
#else
#define jit_addxi_i(r0, r1, i0) \
{ \
    int i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _ADCSI(r0, r1, i); \
	else if ((i = encode_arm_immediate(-i0)) != -1) \
	    _SBCSI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _ADCS(r0, r1, reg); \
    } \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_subr_i(r0, r1, r2) \
{ \
	if (!jit_no_set_flags() && (r0|r1|r2) < 8) \
	    T1_SUB(r0, r1, r2); \
	else \
	    T2_SUB(r0, r1, r2); \
}
#else
#define jit_subr_i(r0, r1, r2) \
	_SUB(r0, r1, r2);
#endif

#ifdef USE_THUMB_CODE
#define jit_subi_i(r0, r1, i0) \
{ \
    int	i; \
	if (!jit_no_set_flags() && (r0|r1) < 8 && !(i0 & ~7)) \
	    T1_SUBI3(r0, r1, i0); \
	else if (!jit_no_set_flags() && (r0|r1) < 8 && !(-i0 & ~7)) \
	    T1_ADDI3(r0, r1, -i0); \
	else if (!jit_no_set_flags() && r0 < 8 && r0 == r1 && !(i0 & ~0xff)) \
	    T1_SUBI8(r0, i0); \
	else if (!jit_no_set_flags() && r0 < 8 && r0 == r1 && !(-i0 & ~0xff)) \
	    T1_ADDI8(r0, -i0); \
	else if ((i = encode_thumb_immediate(i0)) != -1) \
	    T2_SUBI(r0, r1, i); \
	else if ((i = encode_thumb_immediate(-i0)) != -1) \
	    T2_ADDI(r0, r1, i); \
	else if ((i = encode_thumb_word_immediate(i0)) != -1) \
	    T2_SUBWI(r0, r1, i); \
	else if ((i = encode_thumb_word_immediate(-i0)) != -1) \
	    T2_ADDWI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    T2_SUB(r0, r1, reg); \
	} \
}
#else
#define jit_subi_i(r0, r1, i0) \
{ \
    int	i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _SUBI(r0, r1, i); \
	else if ((i = encode_arm_immediate(-i0)) != -1) \
	    _ADDI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _SUB(r0, r1, reg); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_subcr_i(r0, r1, r2) \
	/* thumb auto set carry if not inside IT block */ \
	((r0|r1|r2) < 8) ? T1_SUB(r0, r1, r2) : T2_SUBS(r0, r1, r2)
#else
#define jit_subcr_i(r0, r1, r2) \
	_SUBS(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_subci_i(r0, r1, i0) \
{ \
    int		i; \
	if ((r0|r1) < 8 && !(i0 & ~7)) \
	    T1_SUBI3(r0, r1, i0); \
	else if ((r0|r1) < 8 && !(-i0 & ~7)) \
	    T1_ADDI3(r0, r1, -i0); \
	else if (r0 < 8 && r0 == r1 && !(i0 & ~0xff)) \
	    T1_SUBI8(r0, i0); \
	else if (r0 < 8 && r0 == r1 && !(-i0 & ~0xff)) \
	    T1_ADDI8(r0, -i0); \
	else if ((i = encode_thumb_immediate(i0)) != -1) \
	    T2_SUBSI(r0, r1, i); \
	else if ((i = encode_thumb_immediate(-i0)) != -1) \
	    T2_ADDSI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    T2_SUBS(r0, r1, reg); \
	} \
}
#else
#define jit_subci_i(r0, r1, i0) \
{ \
    int i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _SUBSI(r0, r1, i); \
	else if ((i = encode_arm_immediate(-i0)) != -1) \
	    _ADDSI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _SUBS(r0, r1, reg); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_subxr_i(r0, r1, r2) \
    /* keep setting carry because don't know last ADC */ \
	/* thumb auto set carry if not inside IT block */ \
	((r0|r1|r2) < 8 && r0 == r1) ? T1_SBC(r0, r2) : T2_SBCS(r0, r1, r2)
#else
#define jit_subxr_i(r0, r1, r2) \
    /* keep setting carry because don't know last ADC */ \
	_SBCS(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_subxi_i(r0, r1, i0) \
{ \
	int	i; \
	if ((i = encode_thumb_immediate(i0)) != -1) \
		T2_SBCSI(r0, r1, i); \
	else if ((i = encode_thumb_immediate(-i0)) != -1) \
		T2_ADCSI(r0, r1, i); \
	else { \
		int no_set_flags = jit_no_set_flags(); \
		jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
		jit_no_set_flags() = 1; \
		jit_movi_i(reg, i0); \
		jit_no_set_flags() = no_set_flags; \
		T2_SBCS(r0, r1, reg); \
	} \
}
#else
#define jit_subxi_i(r0, r1, i0) \
{ \
    int i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _SBCSI(r0, r1, i); \
	else if ((i = encode_arm_immediate(-i0)) != -1) \
	    _ADCSI(r0, r1, i); \
	else { \
	    reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _SBCS(r0, r1, reg); \
    } \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_rsbr_i(r0, r1, r2) \
	T2_RSB(r0, r1, r2)
#else
#define jit_rsbr_i(r0, r1, r2) \
	_RSB(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_rsbi_i(r0, r1, i0) \
{ \
    int	i; \
	if (i0 == 0) \
		jit_negr_i(r0, r1); \
	else if ((i = encode_thumb_immediate(i0)) != -1) \
		T2_RSBI(r0, r1, i); \
	else { \
		jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
		jit_movi_i(reg, i0); \
		T2_RSB(r0, r1, reg); \
	} \
}
#else
#define jit_rsbi_i(r0, r1, i0) \
{ \
    int	i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _RSBI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _RSB(r0, r1, reg); \
    } \
}
#endif

#define jit_mulr_i(r0, r1, r2)		jit_mulr_ui(r0, r1, r2)
#ifdef USE_THUMB_CODE
#define jit_mulr_ui(r0, r1, r2) \
{ \
	if (!jit_no_set_flags() && r0 == r2 && (r0|r1) < 8) \
	    T1_MUL(r0, r1); \
	else if (!jit_no_set_flags() && r0 == r1 && (r0|r2) < 8) \
	    T1_MUL(r0, r2); \
	else \
	    T2_MUL(r0, r1, r2); \
}
#else
#define jit_mulr_ui(r0, r1, r2) \
{ \
	if (r0 == r1 && !jit_armv6_p()) { \
		if (r0 != r2) \
			_MUL(r0, r2, r1); \
		else { \
			_MOV(JIT_TMP, r1); \
			_MUL(r0, JIT_TMP, r2); \
		} \
	} \
	else \
		_MUL(r0, r1, r2); \
}
#endif

#define jit_muli_i(r0, r1, i0)		jit_muli_ui(r0, r1, i0)
#define jit_muli_ui(r0, r1, i0) \
{ \
    jit_gpr_t	reg; \
    reg = r0 != r1 ? r0 : JIT_TMP; \
    jit_movi_i(reg, i0); \
    jit_mulr_i(r0, r1, reg); \
}

#ifdef USE_THUMB_CODE
#define jit_hmulr_i(r0, r1, r2)	\
	T2_SMULL(JIT_TMP, r0, r1, r2)
#else
#define jit_hmulr_i(r0, r1, r2)	\
{ \
	if (r0 == r1 && !jit_armv6_p()) { \
	    assert(r2 != JIT_TMP); \
	    _SMULL(JIT_TMP, r0, r2, r1); \
	} \
	else \
	    _SMULL(JIT_TMP, r0, r1, r2); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_hmuli_i(r0, r1, i0) \
{ \
	assert(r0 != JIT_TMP); \
	jit_movi_i(JIT_TMP, i0); \
	T2_SMULL(JIT_TMP, r0, r1, JIT_TMP); \
}
#else
#define jit_hmuli_i(r0, r1, i0) \
{ \
    jit_gpr_t	reg; \
	if (r0 != r1 || jit_armv6_p()) { \
	    jit_movi_i(JIT_TMP, i0); \
	    _SMULL(JIT_TMP, r0, r1, JIT_TMP); \
	} \
	else { \
	    if (r0 != _R0)	    reg = _R0; \
	    else if (r0 != _R1)     reg = _R1; \
	    else if (r0 != _R2)     reg = _R2; \
	    else		    reg = _R3; \
	    _PUSH(1<<reg); \
	    jit_movi_i(reg, i0); \
	    _SMULL(JIT_TMP, r0, r1, reg); \
	    _POP(1<<reg); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_hmulr_ui(r0, r1, r2) \
	T2_UMULL(JIT_TMP, r0, r1, r2)
#else
#define jit_hmulr_ui(r0, r1, r2) \
{ \
	if (r0 == r1 && !jit_armv6_p()) { \
	    assert(r2 != JIT_TMP); \
	    _UMULL(JIT_TMP, r0, r2, r1); \
	} \
	else \
	    _UMULL(JIT_TMP, r0, r1, r2); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_hmuli_ui(r0, r1, i0) \
{ \
	assert(r0 != JIT_TMP); \
	jit_movi_i(JIT_TMP, i0); \
	T2_UMULL(JIT_TMP, r0, r1, JIT_TMP); \
}
#else
#define jit_hmuli_ui(r0, r1, i0) \
{ \
	if (r0 != r1 || jit_armv6_p()) { \
	    jit_movi_i(JIT_TMP, i0); \
	    _UMULL(JIT_TMP, r0, r1, JIT_TMP); \
	} else { \
		jit_gpr_t reg; \
	    if (r0 != _R0)	    reg = _R0; \
	    else if (r0 != _R1) reg = _R1; \
	    else if (r0 != _R2) reg = _R2; \
	    else                reg = _R3; \
	    _PUSH(1<<reg); \
	    jit_movi_i(reg, i0); \
	    _UMULL(JIT_TMP, r0, r1, reg); \
	    _POP(1<<reg); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_divr_i(r0, r1, r2) \
{ \
    if (jit_armv7r_p()) \
		T2_SDIV(r0, r1, r2); \
    else \
		arm_divmod(&_jit, 1, 1, r0, r1, r2); \
}
#else
#define jit_divr_i(r0, r1, r2) \
	arm_divmod(&_jit, 1, 1, r0, r1, r2)
#endif

#define jit_divi_i(r0, r1, i0) \
{ \
    jit_movi_i(JIT_TMP, i0); \
    jit_divr_i(r0, r1, JIT_TMP); \
}

#ifdef USE_THUMB_CODE
#define jit_divr_ui(r0, r1, r2) \
{ \
    if (jit_armv7r_p()) \
		T2_UDIV(r0, r1, r2); \
    else \
		arm_divmod(&_jit, 1, 0, r0, r1, r2); \
}
#else
#define jit_divr_ui(r0, r1, r2) \
		arm_divmod(&_jit, 1, 0, r0, r1, r2);
#endif

#define jit_divi_ui(r0, r1, i0) \
	(jit_movi_i(JIT_TMP, i0), \
	 jit_divr_ui(_jit, r0, r1, JIT_TMP))

#define jit_modr_i(r0, r1, r2) \
    arm_divmod(&_jit, 0, 1, r0, r1, r2)

#define jit_modi_i(r0, r1, i0) \
    (jit_movi_i(JIT_TMP, i0), jit_modr_i(r0, r1, JIT_TMP))

#define jit_modr_ui(r0, r1, r2) \
    arm_divmod(&_jit, 0, 0, r0, r1, r2)

#define jit_modi_ui(r0, r1, i0) \
	(jit_movi_i(JIT_TMP, i0), jit_modr_ui(_jit, r0, r1, JIT_TMP))

#ifdef USE_THUMB_CODE
#define jit_andr_i(r0, r1, r2) \
	(!jit_no_set_flags() && (r0|r1|r2) < 8 && (r0 == r1 || r0 == r2)) ? T1_AND(r0, r0 == r1 ? r2 : r1) : T2_AND(r0, r1, r2)
#else
#define jit_andr_i(r0, r1, r2) \
	_AND(r0, r1, r2);
#endif

#ifdef USE_THUMB_CODE
#define jit_andi_i(r0, r1, i0) \
{ \
	int i; \
	if ((i = encode_thumb_immediate(i0)) != -1) \
		T2_ANDI(r0, r1, i); \
	else if ((i = encode_thumb_immediate(~i0)) != -1) \
		T2_BICI(r0, r1, i); \
	else { \
		jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
		jit_movi_i(reg, i0); \
		T2_AND(r0, r1, reg); \
	} \
}
#else
#define jit_andi_i(r0, r1, i0) \
{ \
    int i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _ANDI(r0, r1, i); \
	else if ((i = encode_arm_immediate(~i0)) != -1) \
	    _BICI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _AND(r0, r1, reg); \
    } \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_orr_i(r0, r1, r2) \
{ \
	if (!jit_no_set_flags() && (r0|r1|r2) < 8 && (r0 == r1 || r0 == r2)) \
		T1_ORR(r0, r0 == r1 ? r2 : r1); \
	else \
		T2_ORR(r0, r1, r2); \
}
#else
#define jit_orr_i(r0, r1, r2) \
	_ORR(r0, r1, r2);
#endif

#ifdef USE_THUMB_CODE
#define jit_ori_i(r0, r1, i0) \
{ \
    int i; \
	if ((i = encode_thumb_immediate(i0)) != -1) \
	    T2_ORRI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    T2_ORR(r0, r1, reg); \
	} \
}
#else
#define jit_ori_i(r0, r1, i0) \
{ \
    int i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _ORRI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _ORR(r0, r1, reg); \
    } \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_xorr_i(r0, r1, r2) \
{ \
	if (!jit_no_set_flags() && (r0|r1|r2) < 8 && (r0 == r1 || r0 == r2)) \
	    T1_EOR(r0, r0 == r1 ? r2 : r1); \
	else \
	    T2_EOR(r0, r1, r2); \
}
#else
#define jit_xorr_i(r0, r1, r2) \
	_EOR(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_xori_i(r0, r1, i0) \
{ \
    int	i; \
	if ((i = encode_thumb_immediate(i0)) != -1) \
	    T2_EORI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    T2_EOR(r0, r1, reg); \
	} \
}
#else
#define jit_xori_i(r0, r1, i0) \
{ \
    int i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _EORI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _EOR(r0, r1, reg); \
    } \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_lshr_i(r0, r1, r2) \
	if (!jit_no_set_flags() && (r0|r1|r2) < 8 && r0 == r1) \
	    T1_LSL(r0, r2); \
	else \
	    T2_LSL(r0, r1, r2);
#else
#define jit_lshr_i(r0, r1, r2) \
	_LSL(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_lshi_i(r0, r1, i0) \
{ \
    assert(i0 >= 0 && i0 <= 31); \
    if (i0 == 0) \
		jit_movr_i(r0, r1); \
    else \
		if (!jit_no_set_flags() && (r0|r1) < 8) \
			T1_LSLI(r0, r1, i0); \
		else \
			T2_LSLI(r0, r1, i0); \
}
#else
#define jit_lshi_i(r0, r1, i0) \
{ \
    assert(i0 >= 0 && i0 <= 31); \
    if (i0 == 0) \
		jit_movr_i(r0, r1); \
    else \
		_LSLI(r0, r1, i0); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_rshr_i(r0, r1, r2) \
{ \
	if (!jit_no_set_flags() && (r0|r1|r2) < 8 && r0 == r1) \
	    T1_ASR(r0, r2); \
	else \
	    T2_ASR(r0, r1, r2); \
}
#else
#define jit_rshr_i(r0, r1, r2) \
	_ASR(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_rshi_i(r0, r1, i0) \
{ \
	assert(i0 >= 0 && i0 <= 31); \
	if (i0 == 0) \
		jit_movr_i(r0, r1); \
	else if (!jit_no_set_flags() && (r0|r1) < 8) \
		T1_ASRI(r0, r1, i0); \
	else \
		T2_ASRI(r0, r1, i0); \
}
#else
#define jit_rshi_i(r0, r1, i0) \
{ \
	assert(i0 >= 0 && i0 <= 31); \
	if (i0 == 0) \
		jit_movr_i(r0, r1); \
	else \
		_ASRI(r0, r1, i0); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_rshr_ui(r0, r1, r2) \
{ \
	if (!jit_no_set_flags() && (r0|r1|r2) < 8 && r0 == r1) \
	    T1_LSR(r0, r2); \
	else \
	    T2_LSR(r0, r1, r2); \
}
#else
#define jit_rshr_ui(r0, r1, r2) \
	_LSR(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_rshi_ui(r0, r1, i0) \
{ \
    assert(i0 >= 0 && i0 <= 31); \
    if (i0 == 0) \
		jit_movr_i(r0, r1); \
    else if (!jit_no_set_flags() && (r0|r1) < 8) \
		T1_LSRI(r0, r1, i0); \
	else \
		T2_LSRI(r0, r1, i0); \
}
#else
#define jit_rshi_ui(r0, r1, i0) \
{ \
	assert(i0 >= 0 && i0 <= 31); \
	if (i0 == 0) \
		jit_movr_i(r0, r1); \
	else \
		_LSRI(r0, r1, i0); \
}
#endif

#ifdef USE_THUMB_CODE
#define arm_ccr(ct, cf, r0, r1, r2) \
{ \
	assert((ct ^ cf) >> 28 == 1); \
	if ((r1|r2) < 8) \
		T1_CMP(r1, r2); \
	else if ((r1&r2) & 8) \
		T1_CMPX(r1, r2); \
	else \
		T2_CMP(r1, r2); \
	_ITE(ct); \
	if (r0 < 8) { \
		T1_MOVI(r0, 1); \
		T1_MOVI(r0, 0); \
	} else { \
	    T2_MOVI(r0, 1); \
	    T2_MOVI(r0, 0); \
	} \
}
#else
#define arm_ccr(ct, cf, r0, r1, r2) \
{ \
	_CMP(r1, r2); \
	_CC_MOVI(ct, r0, 1); \
	_CC_MOVI(cf, r0, 0); \
}
#endif

#ifdef USE_THUMB_CODE
#define arm_cci(ct, cf, r0, r1, i0) \
{ \
    int i; \
	if (r1 < 7 && !(i0 & 0xffffff00)) \
	    T1_CMPI(r1, i0); \
	else if ((i = encode_thumb_immediate(i0)) != -1) \
	    T2_CMPI(r1, i); \
	else if ((i = encode_thumb_immediate(-i0)) != -1) \
	    T2_CMNI(r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    arm_ccr(_jit, ct, cf, r0, r1, reg); \
	    goto next; \
	} \
	_ITE(ct); \
	if (r0 < 8) { \
		T1_MOVI(r0, 1); \
		T1_MOVI(r0, 0); \
	} \
	else { \
	    T2_MOVI(r0, 1); \
	    T2_MOVI(r0, 0); \
	} \
next: \
}
#else
#define arm_cci(ct, cf, r0, r1, i0) \
{ \
	int	i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
		_CMPI(r1, i); \
	else if ((i = encode_arm_immediate(-i0)) != -1) \
		_CMNI(r1, i); \
	else { \
		jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
		jit_movi_i(reg, i0); \
		_CMP(r1, reg); \
	} \
	_CC_MOVI(ct, r0, 1); \
	_CC_MOVI(cf, r0, 0); \
}
#endif

#define jit_ltr_i(r0, r1, r2)	arm_ccr(_jit,ARM_CC_LT,ARM_CC_GE,r0,r1,r2)
#define jit_lti_i(r0, r1, i0)	arm_cci(_jit,ARM_CC_LT,ARM_CC_GE,r0,r1,i0)
#define jit_ltr_ui(r0, r1, r2)	arm_ccr(_jit,ARM_CC_LO,ARM_CC_HS,r0,r1,r2)
#define jit_lti_ui(r0, r1, i0)	arm_cci(_jit,ARM_CC_LO,ARM_CC_HS,r0,r1,i0)
#define jit_ler_i(r0, r1, r2)	arm_ccr(_jit,ARM_CC_LE,ARM_CC_GT,r0,r1,r2)
#define jit_lei_i(r0, r1, i0)	arm_cci(_jit,ARM_CC_LE,ARM_CC_GT,r0,r1,i0)
#define jit_ler_ui(r0, r1, r2)	arm_ccr(_jit,ARM_CC_LS,ARM_CC_HI,r0,r1,r2)
#define jit_lei_ui(r0, r1, i0)	arm_cci(_jit,ARM_CC_LS,ARM_CC_HI,r0,r1,i0)
#define jit_eqr_i(r0, r1, r2)	arm_ccr(_jit,ARM_CC_EQ,ARM_CC_NE,r0,r1,r2)
#define jit_eqi_i(r0, r1, i0)	arm_cci(_jit,ARM_CC_EQ,ARM_CC_NE,r0,r1,i0)
#define jit_ger_i(r0, r1, r2)	arm_ccr(_jit,ARM_CC_GE,ARM_CC_LT,r0,r1,r2)
#define jit_gei_i(r0, r1, i0)	arm_cci(_jit,ARM_CC_GE,ARM_CC_LT,r0,r1,i0)
#define jit_ger_ui(r0, r1, r2)	arm_ccr(_jit,ARM_CC_HS,ARM_CC_LO,r0,r1,r2)
#define jit_gei_ui(r0, r1, i0)	arm_cci(_jit,ARM_CC_HS,ARM_CC_LO,r0,r1,i0)
#define jit_gtr_i(r0, r1, r2)	arm_ccr(_jit,ARM_CC_GT,ARM_CC_LE,r0,r1,r2)
#define jit_gti_i(r0, r1, i0)	arm_cci(_jit,ARM_CC_GT,ARM_CC_LE,r0,r1,i0)
#define jit_gtr_ui(r0, r1, r2)	arm_ccr(_jit,ARM_CC_HI,ARM_CC_LS,r0,r1,r2)
#define jit_gti_ui(r0, r1, i0)	arm_cci(_jit,ARM_CC_HI,ARM_CC_LS,r0,r1,i0)

#ifdef USE_THUMB_CODE
#define jit_ner_i(r0, r1, r2) \
	arm_ccr(_jit, ARM_CC_NE, ARM_CC_EQ, r0, r1, r2)
#else
#define jit_ner_i(r0, r1, r2) \
	(_SUBS(r0, r1, r2), _CC_MOVI(ARM_CC_NE, r0, 1))
#endif

#ifdef USE_THUMB_CODE
#define jit_nei_i(r0, r1, i0) \
	arm_cci(_jit, ARM_CC_NE, ARM_CC_EQ, r0, r1, i0)
#else
#define jit_nei_i(r0, r1, i0) \
{ \
    int i; \
	if ((i = encode_arm_immediate(i0)) != -1) \
	    _SUBSI(r0, r1, i); \
	else if ((i = encode_arm_immediate(-i0)) != -1) \
	    _ADDSI(r0, r1, i); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _SUBS(r0, r1, reg); \
	} \
	_CC_MOVI(ARM_CC_NE, r0, 1); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_jmpr(r0) T1_MOV(_R15, r0)
#else
#define jit_jmpr(r0) _MOV(_R15, r0)
#endif

#ifdef USE_THUMB_CODE
#define jit_jmpi(i0) \
	(_jitl.thumb_tmp = _jit.x.pc, \
	 (_jitl.after_prolog) ? \
	     ((_s20P((((long)i0 - (long)_jitl.thumb_tmp) >> 1) - 2)) ? \
	          T2_B(encode_thumb_jump((((long)i0 - (long)_jitl.thumb_tmp) >> 1) - 2)) : \
	          (jit_movi_p(JIT_TMP, i0), jit_jmpr(JIT_TMP))) : \
         (assert(_s24P((((long)i0 - (long)_jitl.thumb_tmp) >> 2) - 2)), \
	      _CC_B(ARM_CC_AL, ((((long)i0 - (long)_jitl.thumb_tmp) >> 2) - 2) & 0x00ffffff)) \
     _jitl.thumb_tmp)
#else
#define jit_jmpi(i0) \
    (_jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s24P((((long)i0 - (long)_jitl.thumb_tmp) >> 2) - 2)), \
	 _CC_B(ARM_CC_AL, ((((long)i0 - (long)_jitl.thumb_tmp) >> 2) - 2) & 0x00ffffff), \
	 _jitl.thumb_tmp)
#endif

#ifdef USE_THUMB_CODE
#define arm_bccr(cc, i0, r0, r1) \
	(((r0|r1) < 8) ? T1_CMP(r0, r1) : (((r0&r1) & 8) ? T1_CMPX(r0, r1) : T2_CMP(r0, r1)), \
	 /* use only thumb2 conditional as does not know if will be patched */ \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s20P((((long)i0 - (long)l) >> 1) - 2)), \
	 T2_CC_B(cc, encode_thumb_cc_jump((((long)i0 - (long)l) >> 1) - 2)), \
     _jitl.thumb_tmp)
#else
#define arm_bccr(cc, i0, r0, r1) \
	(_CMP(r0, r1), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s24P((((long)(i0) - (long)_jit.x.pc) >> 2) - 2)), \
	 _CC_B(cc, ((((long)(i0) - (long)_jit.x.pc) >> 2) - 2) & 0x00ffffff), \
     _jitl.thumb_tmp)
#endif

#ifdef USE_THUMB_CODE
#define arm_bcci(cc, i0, r0, i1) \
	(((r0 < 7 && !(i1 & 0xffffff00)) ? \
	      T1_CMPI(r0, i1) : \
	      ((encode_thumb_immediate(i1) != -1) ? \
	           T2_CMPI(r0, encode_thumb_immediate(i1)) : \
	           ((encode_thumb_immediate(-i1) != -1) ? \
	                T2_CMNI(r0, encode_thumb_immediate(-i1)) : \
	                (jit_movi_i(JIT_TMP, i1), T2_CMP(r0, JIT_TMP))))), \
	 /* use only thumb2 conditional as does not know if will be patched */ \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s20P((((long)i0 - (long)_jitl.thumb_tmp) >> 1) - 2)), \
	 T2_CC_B(cc, encode_thumb_cc_jump((((long)i0 - (long)l) >> 1) - 2)), \
     _jitl.thumb_tmp)
#else
#define arm_bcci(cc, i0, r0, i1) \
	(((encode_arm_immediate(i1) != -1) ? \
	      _CMPI(r0, encode_arm_immediate(i1)) : \
	      ((encode_arm_immediate(-i1) != -1) ? \
	           _CMNI(r0, encode_arm_immediate(-i1)) : \
	           (jit_movi_i(JIT_TMP, i1), _CMP(r0, JIT_TMP)))), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s24P((((long)i0 - (long)_jitl.thumb_tmp) >> 2) - 2)), \
	 _CC_B(cc, ((((long)i0 - (long)_jitl.thumb_tmp) >> 2) - 2) & 0x00ffffff), \
     _jitl.thumb_tmp)
#endif

#define jit_bltr_i(i0, r0, r1)		arm_bccr(ARM_CC_LT, i0, r0, r1)
#define jit_blti_i(i0, r0, i1)		arm_bcci(ARM_CC_LT, i0, r0, i1)
#define jit_bltr_ui(i0, r0, r1) 	arm_bccr(ARM_CC_LO, i0, r0, r1)
#define jit_blti_ui(i0, r0, i1) 	arm_bcci(ARM_CC_LO, i0, r0, i1)
#define jit_bler_i(i0, r0, r1)		arm_bccr(ARM_CC_LE, i0, r0, r1)
#define jit_blei_i(i0, r0, i1)		arm_bcci(ARM_CC_LE, i0, r0, i1)
#define jit_bler_ui(i0, r0, r1) 	arm_bccr(ARM_CC_LS, i0, r0, r1)
#define jit_blei_ui(i0, r0, i1) 	arm_bcci(ARM_CC_LS, i0, r0, i1)
#define jit_beqr_i(i0, r0, r1)		arm_bccr(ARM_CC_EQ, i0, r0, r1)
#define jit_beqi_i(i0, r0, i1)		arm_bcci(ARM_CC_EQ, i0, r0, i1)
#define jit_bger_i(i0, r0, r1)		arm_bccr(ARM_CC_GE, i0, r0, r1)
#define jit_bgei_i(i0, r0, i1)		arm_bcci(ARM_CC_GE, i0, r0, i1)
#define jit_bger_ui(i0, r0, r1) 	arm_bccr(ARM_CC_HS, i0, r0, r1)
#define jit_bgei_ui(i0, r0, i1) 	arm_bcci(ARM_CC_HS, i0, r0, i1)
#define jit_bgtr_i(i0, r0, r1)		arm_bccr(ARM_CC_GT, i0, r0, r1)
#define jit_bgti_i(i0, r0, i1)		arm_bcci(ARM_CC_GT, i0, r0, i1)
#define jit_bgtr_ui(i0, r0, r1) 	arm_bccr(ARM_CC_HI, i0, r0, r1)
#define jit_bgti_ui(i0, r0, i1) 	arm_bcci(ARM_CC_HI, i0, r0, i1)
#define jit_bner_i(i0, r0, r1)		arm_bccr(ARM_CC_NE, i0, r0, r1)
#define jit_bnei_i(i0, r0, i1)		arm_bcci(ARM_CC_NE, i0, r0, i1)

#ifdef USE_THUMB_CODE
#define arm_baddr(cc, i0, r0, r1) \
	(((r0|r1) < 8) ? T1_ADD(r0, r0, r1) : T2_ADDS(r0, r0, r1), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s20P((((long)i0 - (long)l) >> 1) - 2)), \
	 T2_CC_B(cc, encode_thumb_cc_jump((((long)i0 - (long)l) >> 1) - 2)), \
	 _jitl.thumb_tmp)
#else
#define arm_baddr(cc, i0, r0, r1) \
	(_ADDS(r0, r0, r1), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s24P((((long)i0 - (long)l) >> 2) - 2)), \
	 _CC_B(cc, ((((long)i0 - (long)l) >> 2) - 2) & 0x00ffffff), \
	 _jitl.thumb_tmp)
#endif

#ifdef USE_THUMB_CODE
#define arm_baddi(cc, i0, r0, i1) \
	(((r0 < 8 && !(i1 & ~7)) ? \
	      T1_ADDI3(r0, r0, i1) : \
	      ((r0 < 8 && !(-i1 & ~7)) ? \
	           T1_SUBI3(r0, r0, -i1) : \
	           ((r0 < 8 && !(i1 & ~0xff)) ? \
	                T1_ADDI8(r0, i1) : \
	                ((r0 < 8 && !(-i1 & ~0xff)) ? \
	                     T1_SUBI8(r0, -i1) : \
	                     ((encode_thumb_immediate(i1) != -1) ? \
	                          T2_ADDSI(r0, r0, encode_thumb_immediate(i1)) : \
	                          ((encode_thumb_immediate(-i1) != -1) ? \
	                               T2_SUBSI(r0, r0, encode_thumb_immediate(-i1)) : \
	                               (jit_movi_i(JIT_TMP, i1), T2_ADDS(r0, r0, JIT_TMP)))))))), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s20P((((long)i0 - (long)l) >> 1) - 2)), \
	 T2_CC_B(cc, encode_thumb_cc_jump((((long)i0 - (long)l) >> 1) - 2)), \
	 _jitl.thumb_tmp)
#else
#define arm_baddi(cc, i0, r0, i1) \
	(((encode_arm_immediate(i1) != -1) ? \
	      _ADDSI(r0, r0, encode_arm_immediate(i1)) : \
	      ((encode_arm_immediate(-i1) != -1) ? \
	           _SUBSI(r0, r0, encode_arm_immediate(-i1)) : \
	           (jit_movi_i(JIT_TMP, i1), _ADDS(r0, r0, JIT_TMP)))), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s24P((((long)i0 - (long)l) >> 2) - 2)), \
	 _CC_B(cc, ((((long)i0 - (long)l) >> 2) - 2) & 0x00ffffff), \
	 _jitl.thumb_tmp)
#endif

#define jit_boaddr_i(i0, r0, r1)	arm_baddr(ARM_CC_VS, i0, r0, r1)
#define jit_boaddi_i(i0, r0, i1)	arm_baddi(ARM_CC_VS, i0, r0, i1)
#define jit_boaddr_ui(i0, r0, r1)	arm_baddr(ARM_CC_HS, i0, r0, r1)
#define jit_boaddi_ui(i0, r0, i1)	arm_baddi(ARM_CC_HS, i0, r0, i1)

#ifdef USE_THUMB_CODE
#define arm_bsubr(cc, i0, r0, r1) \
	(((r0|r1) < 8) ? T1_SUB(r0, r0, r1) : T2_SUBS(r0, r0, r1), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s20P((((long)i0 - (long)l) >> 1) - 2)), \
	 T2_CC_B(cc, encode_thumb_cc_jump((((long)i0 - (long)l) >> 1) - 2)), \
     _jitl.thumb_tmp)
#else
#define arm_bsubr(cc, i0, r0, r1) \
	(_SUBS(r0, r0, r1), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s24P((((long)i0 - (long)l) >> 2) - 2)), \
	 _CC_B(cc, ((((long)i0 - (long)l) >> 2) - 2) & 0x00ffffff), \
     _jitl.thumb_tmp)
#endif

#ifdef USE_THUMB_CODE
#define arm_bsubi(cc, i0, r0, i1) \
	(((r0 < 8 && !((i1) & ~7)) ? \
	      T1_SUBI3(r0, r0, i1) : \
	      ((r0 < 8 && !(-(i1) & ~7)) ? \
	           T1_ADDI3(r0, r0, -i1) : \
	           ((r0 < 8 && !((i1) & ~0xff)) ? \
	                T1_SUBI8(r0, i1) : \
	                ((r0 < 8 && !(-(i1) & ~0xff)) ? \
	                     T1_ADDI8(r0, -(i1)) : \
	                     ((encode_thumb_immediate(i1) != -1) ? \
	                          T2_SUBSI(r0, r0, encode_thumb_immediate(i1)) : \
	                          ((encode_thumb_immediate(-i1) != -1) ? \
	                               T2_ADDSI(r0, r0, encode_thumb_immediate(-i1)) : \
	                               (jit_movi_i(JIT_TMP, i1), T2_SUBS(r0, r0, JIT_TMP)))))))), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s20P((((long)i0 - (long)_jitl.thumb_tmp) >> 1) - 2)), \
	 T2_CC_B(cc, encode_thumb_cc_jump((((long)(i0) - (long)_jitl.thumb_tmp) >> 1) - 2)), \
	 _jitl.thumb_tmp)
#else
#define arm_bsubi(cc, i0, r0, i1) \
	(((encode_arm_immediate(i1) != -1) ? \
	    _SUBSI(r0, r0, encode_arm_immediate(i1)) : \
	    ((encode_arm_immediate(-i1) != -1) ? \
	       _ADDSI(r0, r0, encode_arm_immediate(-i1)) : \
	       (jit_movi_i(JIT_TMP, i1), _SUBS(r0, r0, JIT_TMP)))), \
	 _jitl.thumb_tmp = _jit.x.pc, \
	 assert(_s24P((((long)i0 - (long)l) >> 2) - 2)), \
	 _CC_B(cc, ((((long)i0 - (long)l) >> 2) - 2) & 0x00ffffff), \
     _jitl.thumb_tmp)
#endif

#define jit_bosubr_i(i0, r0, r1)	arm_bsubr(ARM_CC_VS, i0, r0, r1)
#define jit_bosubi_i(i0, r0, i1)	arm_bsubi(ARM_CC_VS, i0, r0, i1)
#define jit_bosubr_ui(i0, r0, r1)	arm_bsubr(ARM_CC_LO, i0, r0, r1)
#define jit_bosubi_ui(i0, r0, i1)	arm_bsubi(ARM_CC_LO, i0, r0, i1)

#ifdef USE_THUMB_CODE
#define arm_bmxr(cc, i0, r0, r1) \
	(((r0|r1) < 8) ? T1_TST(r0, r1) : T2_TST(r0, r1), \
	 _jitl.thumb_pc = _jit.x.pc, \
	 assert(_s20P((((long)i0 - (long)l) >> 1) - 2)), \
	 T2_CC_B(cc, encode_thumb_cc_jump((((long)i0 - (long)l) >> 1) - 2)), \
	 _jitl.thumb_pc)
#else
#define arm_bmxr(cc, i0, r0, r1) \
	(((jit_armv5_p()) ? _TST(r0, r1) : _ANDS(JIT_TMP, r0, r1)), \
	 _jitl.thumb_pc = _jit.x.pc, \
	 assert(_s24P((((long)i0 - (long)l) >> 2) - 2)), \
	 _CC_B(cc, ((((long)i0 - (long)l) >> 2) - 2) & 0x00ffffff), \
	 _jitl.thumb_pc)
#endif

#ifdef USE_THUMB_CODE
#define arm_bmxi(cc, i0, r0, i1) \
	((jit_armv5_p()) ? \
	     ((encode_arm_immediate(i1) != -1) ? \
		     _TSTI(r0, encode_arm_immediate(i1)) : \
		     (jit_movi_i(JIT_TMP, i1), _TST(r0, JIT_TMP))) \
	     (((i = encode_arm_immediate(i1)) != -1) ? \
		      _ANDSI(JIT_TMP, r0, i) : \
	          (((encode_arm_immediate(~i1)) != -1) ? \
		           _BICSI(JIT_TMP, r0, encode_arm_immediate(~i1)) : \
	               (jit_movi_i(JIT_TMP, i1), _ANDS(JIT_TMP, r0, JIT_TMP)))), \
	 _jitl.thumb_pc = _jit.x.pc, \
	 assert(_s24P((((long)i0 - (long)_jitl.thumb_pc) >> 2) - 2)), \
	 _CC_B(cc, ((((long)i0 - (long)_jitl.thumb_pc) >> 2) - 2) & 0x00ffffff), \
     _jitl.thumb_pc)
#else
#define arm_bmxi(cc, i0, r0, i1) \
	((jit_armv5_p()) ? \
	     ((encode_arm_immediate(i1) != -1) ? \
		      _TSTI(r0, encode_arm_immediate(i1)) : \
	          (jit_movi_i(JIT_TMP, i1), _TST(r0, JIT_TMP))) : \
	     ((encode_arm_immediate(i1) != -1) ? \
		 	  _ANDSI(JIT_TMP, r0, encode_arm_immediate(i1)) : \
	          ((encode_arm_immediate(~(i1)) != -1) ? \
			       _BICSI(JIT_TMP, r0, encode_arm_immediate(~i1)) : \
	               (jit_movi_i(JIT_TMP, i1), _ANDS(JIT_TMP, r0, JIT_TMP)))), \
	 _jitl.thumb_pc = _jit.x.pc, \
	 assert(_s24P((((long)(i0) - (long)_jitl.thumb_pc) >> 2) - 2)), \
	 _CC_B(cc, ((((long)(i0) - (long)_jitl.thumb_pc) >> 2) - 2) & 0x00ffffff), \
     _jitl.thumb_pc)
#endif

#define jit_bmsr_i(i0, r0, r1)		arm_bmxr(ARM_CC_NE, i0, r0, r1)
#define jit_bmsi_i(i0, r0, i1)		arm_bmxi(ARM_CC_NE, i0, r0, i1)
#define jit_bmcr_i(i0, r0, r1)		arm_bmxr(ARM_CC_EQ, i0, r0, r1)
#define jit_bmci_i(i0, r0, i1)		arm_bmxi(ARM_CC_EQ, i0, r0, i1)

#ifdef USE_THUMB_CODE
#define jit_ldr_c(r0, r1) T2_LDRSBI(r0, r1, 0)
#else
#define jit_ldr_c(r0, r1) _LDRSBI(r0, r1, 0)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldi_c(r0, i0) \
{ \
    jit_movi_i(JIT_TMP, (int)i0); \
	T2_LDRSBI(r0, JIT_TMP, 0); \
}
#else
#define jit_ldi_c(r0, i0) \
{ \
    jit_movi_i(JIT_TMP, (int)i0); \
	_LDRSBI(r0, JIT_TMP, 0); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxr_c(r0, r1, r2) \
	((r0|r1|r2) < 8) ? T1_LDRSB(r0, r1, r2) : T2_LDRSB(r0, r1, r2)
#else
#define jit_ldxr_c(r0, r1, r2) _LDRSB(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxi_c(r0, r1, i0) \
{ \
	if (i0 >= 0 && i0 <= 255) \
		T2_LDRSBI(r0, r1, i0); \
	else if (i0 < 0 && i0 >= -255) \
		T2_LDRSBIN(r0, r1, -i0); \
	else if (i0 >= 0 && i0 <= 4095) \
		T2_LDRSBWI(r0, r1, i0); \
	else { \
		jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
		jit_movi_i(reg, i0); \
		if ((r0|r1|reg) < 8) \
			T1_LDRSB(r0, r1, reg); \
		else \
			T2_LDRSB(r0, r1, reg); \
	} \
}
#else
#define jit_ldxi_c(r0, r1, i0) \
{ \
	if (i0 >= 0 && i0 <= 255) \
		_LDRSBI(r0, r1, i0); \
	else if (i0 < 0 && i0 >= -255) \
		_LDRSBIN(r0, r1, -i0); \
	else { \
		jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
		jit_movi_i(reg, i0); \
		_LDRSB(r0, r1, reg); \
    } \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_ldr_uc(r0, r1) T2_LDRBI(r0, r1, 0)
#else
#define jit_ldr_uc(r0, r1) _LDRBI(r0, r1, 0)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldi_uc(r0, i0) \
    (jit_movi_i(JIT_TMP, (int)i0), T2_LDRBI(r0, JIT_TMP, 0))
#else
#define jit_ldi_uc(r0, i0) \
	(jit_movi_i(JIT_TMP, (int)i0), _LDRBI(r0, JIT_TMP, 0))
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxr_uc(r0, r1, r2) \
	((r0|r1|r2) < 8) ? T1_LDRB(r0, r1, r2) : T2_LDRB(r0, r1, r2)
#else
#define jit_ldxr_uc(r0, r1, r2) _LDRB(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxi_uc(r0, r1, i0) \
{ \
	if ((r0|r1) < 8 && i0 >= 0 && i0 < 0x20) \
		T1_LDRBI(r0, r1, i0); \
	else if (i0 >= 0 && i0 <= 255) \
		T2_LDRBI(r0, r1, i0); \
	else if (i0 < 0 && i0 >= -255) \
		T2_LDRBIN(r0, r1, -i0); \
	else if (i0 >= 0 && i0 <= 4095) \
		T2_LDRBWI(r0, r1, i0); \
	else { \
		jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
		jit_movi_i(reg, i0); \
		if ((r0|r1|reg) < 8) \
			T1_LDRB(r0, r1, reg); \
		else \
			T2_LDRB(r0, r1, reg); \
	} \
}
#else
#define jit_ldxi_uc(r0, r1, i0) \
{ \
	if (i0 >= 0 && i0 <= 4095) \
	    _LDRBI(r0, r1, i0); \
	else if (i0 < 0 && i0 >= -4095) \
	    _LDRBIN(r0, r1, -i0); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _LDRB(r0, r1, reg); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_ldr_s(r0, r1) T2_LDRSHI(r0, r1, 0)
#else
#define jit_ldr_s(r0, r1) _LDRSHI(r0, r1, 0)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldi_s(r0, i0) \
	(jit_movi_i(JIT_TMP, (int)i0), T2_LDRSHI(r0, JIT_TMP, 0))
#else
#define jit_ldi_s(r0, i0) \
	(jit_movi_i(JIT_TMP, (int)i0), _LDRSHI(r0, JIT_TMP, 0))
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxr_s(r0, r1, r2) \
	((r0|r1|r2) < 8) ? T1_LDRSH(r0, r1, r2) : T2_LDRSH(r0, r1, r2)
#else
#define jit_ldxr_s(r0, r1, r2) _LDRSH(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxi_s(r0, r1, i0) \
{ \
	if (i0 >= 0 && i0 <= 255) \
	    T2_LDRSHI(r0, r1, i0); \
	else if (i0 < 0 && i0 >= -255) \
	    T2_LDRSHIN(r0, r1, -i0); \
	else if (i0 >= 0 && i0 <= 4095) \
	    T2_LDRSHWI(r0, r1, i0); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    if ((r0|r1|reg) < 8) \
			T1_LDRSH(r0, r1, reg); \
	    else \
			T2_LDRSH(r0, r1, reg); \
	} \
}
#else
#define jit_ldxi_s(r0, r1, i0) \
{ \
	if (i0 >= 0 && i0 <= 255) \
	    _LDRSHI(r0, r1, i0); \
	else if (i0 < 0 && i0 >= -255) \
	    _LDRSHIN(r0, r1, -i0); \
	else { \
		jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _LDRSH(r0, r1, reg); \
    } \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_ldr_us(r0, r1)  T2_LDRHI(r0, r1, 0)
#else
#define jit_ldr_us(r0, r1) _LDRHI(r0, r1, 0)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldi_us(r0, i0) \
	(jit_movi_i(JIT_TMP, (int)i0), T2_LDRHI(r0, JIT_TMP, 0))
#else
#define jit_ldi_us(r0, i0) \
	(jit_movi_i(JIT_TMP, (int)i0), _LDRHI(r0, JIT_TMP, 0))
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxr_us(r0, r1, r2) \
	((r0|r1|r2) < 8) ? T1_LDRH(r0, r1, r2) : T2_LDRH(r0, r1, r2)
#else
#define jit_ldxr_us(r0, r1, r2) _LDRH(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxi_us(r0, r1, i0) \
{ \
 	if ((r0|r1) < 8 && i0 >= 0 && !(i0 & 1) && (i0 >> 1) < 0x20) \
		T1_LDRHI(r0, r1, i0 >> 1); \
	else if (i0 >= 0 && i0 <= 255) \
		T2_LDRHI(r0, r1, i0); \
	else if (i0 < 0 && i0 >= -255) \
		T2_LDRHIN(r0, r1, -i0); \
	else if (i0 >= 0 && i0 <= 4095) \
		T2_LDRHWI(r0, r1, i0); \
	else { \
		jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
		jit_movi_i(reg, i0); \
		if ((r0|r1|reg) < 8) \
			T1_LDRH(r0, r1, reg); \
		else \
			T2_LDRH(r0, r1, reg); \
	} \
}
#else
#define jit_ldxi_us(r0, r1, i0) \
{ \
	if (i0 >= 0 && i0 <= 255) \
	    _LDRHI(r0, r1, i0); \
	else if (i0 < 0 && i0 >= -255) \
	    _LDRHIN(r0, r1, -i0); \
	else { \
	    jit_gpr_t reg = r0 != r1 ? r0 : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _LDRH(r0, r1, reg); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_ldr_i(r0, r1) T2_LDRI(r0, r1, 0)
#else
#define jit_ldr_i(r0, r1) _LDRI(r0, r1, 0)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldi_i(r0, i0) \
	(jit_movi_i(JIT_TMP, (int)i0), T2_LDRI(r0, JIT_TMP, 0))
#else
#define jit_ldi_i(r0, i0) \
	(jit_movi_i(JIT_TMP, (int)i0), _LDRI(r0, JIT_TMP, 0))
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxr_i(r0, r1, r2) \
	(((r0|r1|r2) < 8) ? T1_LDR(r0, r1, r2) : T2_LDR(r0, r1, r2))
#else
#define jit_ldxr_i(r0, r1, r2) _LDR(r0, r1, r2)
#endif

#ifdef USE_THUMB_CODE
#define jit_ldxi_i(r0, r1, i0) \
{ \
	if (((r0)|(r1)) < 8 && (i0) >= 0 && !((i0) & 3) && ((i0) >> 2) < 0x20) \
	    T1_LDRI(r0, r1, (i0) >> 2); \
	else if ((r1) == _R13 && (r0) < 8 && \
		 (i0) >= 0 && !((i0) & 3) && ((i0) >> 2) <= 255) \
	    T1_LDRISP(r0, (i0) >> 2); \
	else if ((i0) >= 0 && (i0) <= 255) \
	    T2_LDRI(r0, r1, i0); \
	else if ((i0) < 0 && (i0) >= -255) \
	    T2_LDRIN((r0), (r1), -(i0)); \
	else if ((i0) >= 0 && (i0) <= 4095) \
	    T2_LDRWI(r0, r1, i0); \
	else { \
	    jit_gpr_t reg = (r0) != (r1) ? (r0) : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    if (((r0)|(r1)|reg) < 8) \
			T1_LDR(r0, r1, reg); \
	    else \
			T2_LDR(r0, r1, reg); \
	} \
}
#else
#define jit_ldxi_i(r0, r1, i0) \
{ \
	if ((i0) >= 0 && (i0) <= 4095) \
	    _LDRI(r0, r1, i0); \
	else if ((i0) < 0 && (i0) >= -4095) \
	    _LDRIN(r0, r1, -i0); \
	else { \
	    jit_gpr_t reg = (r0) != (r1) ? (r0) : JIT_TMP; \
	    jit_movi_i(reg, i0); \
	    _LDR(r0, r1, reg); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_str_c(r0, r1) T2_STRBI(r1, r0, 0);
#else
#define jit_str_c(r0, r1) _STRBI(r1, r0, 0);
#endif

#ifdef USE_THUMB_CODE
#define jit_sti_c(r0, i0) (jit_movi_i(JIT_TMP, (int)i0), T2_STRBI(r0, JIT_TMP, 0))
#else
#define jit_sti_c(r0, i0) (jit_movi_i(JIT_TMP, (int)i0), _STRBI(r0, JIT_TMP, 0))
#endif

#ifdef USE_THUMB_CODE
#define jit_stxr_c(r0, r1, r2) \
	(((r0)|(r1)|(r2)) < 8) ? T1_STRB(r2, r1, r0) : T2_STRB(r2, r1, r0)
#else
#define jit_stxr_c(r0, r1, r2) _STRB(r2, r1, r0)
#endif

#ifdef USE_THUMB_CODE
#define jit_stxi_c(r0, r1, i0) \
{ \
	if ((r0|r1) < 8 && i0 >= 0 && i0 < 0x20) \
	    T1_STRBI(r1, r0, i0); \
	else if (i0 >= 0 && i0 <= 255) \
	    T2_STRBI(r1, r0, i0); \
	else if (i0 < 0 && i0 >= -255) \
	    T2_STRBIN(r1, r0, -i0); \
	else if (i0 >= 0 && i0 <= 4095) \
	    T2_STRBWI(r1, r0, i0); \
	else { \
	    jit_movi_i(JIT_TMP, (int)i0); \
	    if ((r0|r1|JIT_TMP) < 8) \
			T1_STRB(r1, r0, JIT_TMP); \
	    else \
			T2_STRB(r1, r0, JIT_TMP); \
	} \
}
#else
#define jit_stxi_c(r0, r1, i0) \
{ \
	if (i0 >= 0 && i0 <= 4095) \
	    _STRBI(r1, r0, i0); \
	else if (i0 < 0 && i0 >= -4095) \
	    _STRBIN(r1, r0, -i0); \
	else { \
	    jit_movi_i(JIT_TMP, i0); \
	    _STRB(r1, r0, JIT_TMP); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_str_s(r0, r1) T2_STRHI(r1, r0, 0)
#else
#define jit_str_s(r0, r1) _STRHI(r1, r0, 0)
#endif

#ifdef USE_THUMB_CODE
#define jit_sti_s(r0, i0) (jit_movi_i(JIT_TMP, (int)i0), T2_STRHI(r0, JIT_TMP, 0))
#else
#define jit_sti_s(r0, i0) (jit_movi_i(JIT_TMP, (int)i0), _STRHI(r0, JIT_TMP, 0))
#endif

#ifdef USE_THUMB_CODE
#define jit_stxr_s(r0, r1, r2) \
	((((r0)|(r1)|(r2)) < 8) ? T1_STRH(r2, r1, r0) : T2_STRH(r2, r1, r0))
#else
#define jit_stxr_s(r0, r1, r2) _STRH(r2, r1, r0)
#endif

#ifdef USE_THUMB_CODE
#define jit_stxi_s(r0, r1, i0) \
{ \
	if ((r0|r1) < 8 && i0 >= 0 && !(i0 & 1) && (i0 >> 1) < 0x20) \
	    T1_STRHI(r1, r0, i0 >> 1); \
	else if (i0 >= 0 && i0 <= 255) \
	    T2_STRHI(r1, r0, i0); \
	else if (i0 < 0 && i0 >= -255) \
	    T2_STRHIN(r1, r0, -i0); \
	else if (i0 >= 0 && i0 <= 4095) \
	    T2_STRHWI(r1, r0, i0); \
	else { \
	    jit_movi_i(JIT_TMP, (int)i0); \
	    if ((r0|r1|JIT_TMP) < 8) \
			T1_STRH(r1, r0, JIT_TMP); \
	    else \
			T2_STRH(r1, r0, JIT_TMP); \
	} \
}
#else
#define jit_stxi_s(r0, r1, i0) \
{ \
	if (i0 >= 0 && i0 <= 255) \
	    _STRHI(r1, r0, i0); \
	else if (i0 < 0 && i0 >= -255) \
	    _STRHIN(r1, r0, -i0); \
	else { \
	    jit_movi_i(JIT_TMP, i0); \
	    _STRH(r1, r0, JIT_TMP); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_str_i(r0, r1) T2_STRI(r1, r0, 0)
#else
#define jit_str_i(r0, r1) _STRI(r1, r0, 0)
#endif

#ifdef USE_THUMB_CODE
#define jit_sti_i(r0, i0) (jit_movi_i(JIT_TMP, (int)i0), T2_STRI(r0, JIT_TMP, 0))
#else
#define jit_sti_i(r0, i0) (jit_movi_i(JIT_TMP, (int)i0), _STRI(r0, JIT_TMP, 0))
#endif

#ifdef USE_THUMB_CODE
#define jit_stxr_i(r0, r1, r2) ((((r0)|(r1)|(r2)) < 8) ? T1_STR(r2, r1, r0) : T2_STR(r2, r1, r0))
#else
#define jit_stxr_i(r0, r1, r2) _STR(r2, r1, r0)
#endif

#ifdef USE_THUMB_CODE
#define jit_stxi_i(i0, r0, r1) \
{ \
	if ((r0|r1) < 8 && i0 >= 0 && !(i0 & 3) && (i0 >> 2) < 0x20) \
		T1_STRI(r1, r0, i0 >> 2); \
	else if (r0 == _R13 && r1 < 8 && \
	         i0 >= 0 && !(i0 & 3) && (i0 >> 2) <= 255) \
		T1_STRISP(r1, i0 >> 2); \
	else if (i0 >= 0 && i0 <= 255) \
		T2_STRI(r1, r0, i0); \
	else if (i0 < 0 && i0 >= -255) \
		T2_STRIN(r1, r0, -i0); \
	else if (i0 >= 0 && i0 <= 4095) \
		T2_STRWI(r1, r0, i0); \
	else { \
	    jit_movi_i(JIT_TMP, (int)i0); \
		if ((r0|r1|JIT_TMP) < 8) \
			T1_STR(r1, r0, JIT_TMP); \
		else \
			T2_STR(r1, r0, JIT_TMP); \
	} \
}
#else
#define jit_stxi_i(i0, r0, r1) \
{ \
	if (i0 >= 0 && i0 <= 4095) \
	    _STRI(r1, r0, i0); \
	else if (i0 < 0 && i0 >= -4095) \
	    _STRIN(r1, r0, -i0); \
	else { \
	    jit_movi_i(JIT_TMP, i0); \
	    _STR(r1, r0, JIT_TMP); \
	} \
}
#endif

#if __BYTE_ORDER == __LITTLE_ENDIAN
/* inline glibc htons (without register clobber) */
#ifdef USE_THUMB_CODE
#define jit_ntoh_us(r0, r1) \
	((r0|r1) < 8) ? T1_REV16(r0, r1) : T2_REV16(r0, r1)
#else
#define jit_ntoh_us(r0, r1) \
{ \
	if (jit_armv6_p()) \
		_REV16(r0, r1); \
	else { \
		_LSLI(JIT_TMP, r1, 24); \
		_LSRI(r0, r1, 8); \
		_ORR_SI(r0, r0, JIT_TMP, ARM_LSR, 16); \
	} \
}
#endif

/* inline glibc htonl (without register clobber) */
#ifdef USE_THUMB_CODE
#define jit_ntoh_ui(r0, r1) \
	((r0|r1) < 8) ? T1_REV(r0, r1) : T2_REV(r0, r1)
#else
#define jit_ntoh_ui(r0, r1) \
{ \
	if (jit_armv6_p()) \
	    _REV(r0, r1); \
	else { \
	    _EOR_SI(JIT_TMP, r1, r1, ARM_ROR, 16); \
	    _LSRI(JIT_TMP, JIT_TMP, 8); \
	    _BICI(JIT_TMP, JIT_TMP, encode_arm_immediate(0xff00)); \
	    _EOR_SI(r0, JIT_TMP, r1, ARM_ROR, 8); \
    } \
}
#endif
#endif

#ifdef USE_THUMB_CODE
#define jit_extr_c_i(r0, r1) \
	((r0|r1) < 8) ? T1_SXTB(r0, r1) : T2_SXTB(r0, r1)
#else
#define jit_extr_c_i(r0, r1) \
{ \
	if (jit_armv6_p()) \
		_SXTB(r0, r1); \
	else { \
		_LSLI(r0, r1, 24); \
		_ASRI(r0, r0, 24); \
	} \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_extr_c_ui(r0, r1) \
	((r0|r1) < 8) ? T1_UXTB(r0, r1) : T2_UXTB(r0, r1)
#else
#define jit_extr_c_ui(r0, r1) \
	jit_armv6_p() ? _UXTB(r0, r1) : _ANDI(r0, r1, 0xff)
#endif

#ifdef USE_THUMB_CODE
#define jit_extr_s_i(r0, r1) \
	((r0|r1) < 8) ? T1_SXTH(r0, r1) : T2_SXTH(r0, r1)
#else
#define jit_extr_s_i(r0, r1) \
	(jit_armv6_p()) ? _SXTH(r0, r1) : (_LSLI(r0, r1, 16), _ASRI(r0, r0, 16))
#endif

#ifdef USE_THUMB_CODE
#define jit_extr_s_ui(r0, r1) \
	((r0|r1) < 8) ? T1_UXTH(r0, r1) : T2_UXTH(r0, r1)
#else
#define jit_extr_s_ui(r0, r1) \
    /* _ANDI(r0, r1, 0xffff) needs more instructions */ \
	(jit_armv6_p()) ? _UXTH(r0, r1) : (_LSLI(r0, r1, 16), _LSRI(r0, r0, 16))
#endif

#define jit_allocai(i0) \
	(assert((i0) >= 0), \
     _jitl.alloca_offset += i0, \
     jit_patch_movi(_jitl.stack, (void *) \
                    ((_jitl.alloca_offset + _jitl.stack_length + 7) & -8)), \
     (-_jitl.alloca_offset))

#ifdef USE_THUMB_CODE
#define jit_prolog(n) \
{ \
	/*  switch to thumb mode (better approach would be to
	 * or 1 address being called, but no clear distinction
	 * of what is a pointer to a jit function, or if patching
	 * a pointer to a jit function) */ \
	_ADDI(_R12, _R15, 1); \
	_BX(_R12); \
	if (!_jitl.after_prolog) { \
	    _jitl.after_prolog = 1; \
	    _jitl.thumb_pc = _jit.x.pc; \
	}  \
	if (jit_hardfp_p()) { \
	    T2_PUSH((1<<_R4)|(1<<_R5)|(1<<_R6)|(1<<_R7)|(1<<_R8)|(1<<_R9)| \
		    /* previous fp and return address */ \
		    (1<<JIT_FP)|(1<<JIT_LR)); \
	    _VPUSH_F64(_D8, 8); \
	    T2_PUSH(/* arguments (should keep state and only save "i0" registers) */ \
		    (1<<_R0)|(1<<_R1)|(1<<_R2)|(1<<_R3)); \
	} \
	else \
	    T2_PUSH(/* arguments (should keep state and only save "i0" registers) */ \
		    (1<<_R0)|(1<<_R1)|(1<<_R2)|(1<<_R3)| \
		    (1<<_R4)|(1<<_R5)|(1<<_R6)|(1<<_R7)|(1<<_R8)|(1<<_R9)| \
		    /* previous fp and return address */ \
		    (1<<JIT_FP)|(1<<JIT_LR)); \
	T2_MOV(JIT_FP, JIT_SP); \
	\
    _jitl.nextarg_get = _jitl.nextarg_getf = 0; \
    _jitl.nextarg_put = 0; \
    _jitl.framesize = JIT_FRAMESIZE; \
    if (jit_hardfp_p()) \
		_jitl.framesize += 64; \
	\
    /* patch alloca and stack adjustment */ \
    _jitl.stack = (int *)_jit.x.pc; \
	\
    if (jit_swf_p()) \
	/* 6 soft double precision float registers */ \
		_jitl.alloca_offset = 48; \
    else \
		_jitl.alloca_offset = 0; \
	\
    jit_movi_p(JIT_TMP, (void *)_jitl.alloca_offset); \
    jit_subr_i(JIT_SP, JIT_SP, JIT_TMP); \
    _jitl.stack_length = _jitl.stack_offset = 0; \
}
#else
#define jit_prolog(n) \
{ \
	if (!_jitl.after_prolog) { \
	    _jitl.after_prolog = 1; \
	    _jitl.thumb_pc = _jit.x.pc; \
	}  \
	if (jit_hardfp_p()) { \
	    _PUSH((1<<_R4)|(1<<_R5)|(1<<_R6)|(1<<_R7)|(1<<_R8)|(1<<_R9)| \
		    /* previous fp and return address */ \
		    (1<<JIT_FP)|(1<<JIT_LR)); \
	    _VPUSH_F64(_D8, 8); \
	    _PUSH(/* arguments (should keep state and only save "i0" registers) */ \
		    (1<<_R0)|(1<<_R1)|(1<<_R2)|(1<<_R3)); \
	} \
	else \
	    _PUSH(/* arguments (should keep state and only save "i0" registers) */ \
		    (1<<_R0)|(1<<_R1)|(1<<_R2)|(1<<_R3)| \
		    (1<<_R4)|(1<<_R5)|(1<<_R6)|(1<<_R7)|(1<<_R8)|(1<<_R9)| \
		    /* previous fp and return address */ \
		    (1<<JIT_FP)|(1<<JIT_LR)); \
	_MOV(JIT_FP, JIT_SP); \
	\
    _jitl.nextarg_get = _jitl.nextarg_getf = 0; \
    _jitl.nextarg_put = 0; \
    _jitl.framesize = JIT_FRAMESIZE; \
    if (jit_hardfp_p()) \
		_jitl.framesize += 64; \
	\
    /* patch alloca and stack adjustment */ \
    _jitl.stack = (int *)_jit.x.pc; \
	\
    if (jit_swf_p()) \
	/* 6 soft double precision float registers */ \
		_jitl.alloca_offset = 48; \
    else \
		_jitl.alloca_offset = 0; \
	\
	jit_movi_p(JIT_TMP, (void *)_jitl.alloca_offset); \
    jit_subr_i(JIT_SP, JIT_SP, JIT_TMP); \
    _jitl.stack_length = _jitl.stack_offset = 0; \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_callr(r0) T1_BLX(r0)
#else
#define jit_callr(r0) _BLX(r0)
#endif

#ifdef USE_THUMB_CODE
#define jit_calli(i0) \
    (_jitl.thumb_tmp = jit_movi_p(JIT_TMP, i0), \
	 T1_BLX(JIT_TMP), \
	 _jitl.thumb_tmp)
#else
#define jit_calli(i0) \
    (_jitl.thumb_tmp = jit_movi_p(JIT_TMP, i0), \
	 _BLX(JIT_TMP), \
	 _jitl.thumb_tmp)
#endif

#define jit_prepare_i(i0) \
    (assert((i0) >= 0 && !_jitl.stack_offset && !_jitl.nextarg_put), \
     _jitl.stack_offset = i0 << 2)

#define jit_arg_c()			jit_arg_p()
#define jit_arg_uc()		jit_arg_p()
#define jit_arg_s()			jit_arg_p()
#define jit_arg_us()		jit_arg_p()
#define jit_arg_i()			jit_arg_p()
#define jit_arg_ui()		jit_arg_p()
#define jit_arg_l()			jit_arg_p()
#define jit_arg_ul()		jit_arg_p()
#define jit_arg_p()	\
    ((_jitl.nextarg_get > 2) ? \
	    ((_jitl.framesize += sizeof(int)) - sizeof(int)) : \
        (_jitl.nextarg_get++))

#define jit_getarg_c(r0, i0) \
    jit_ldxi_c(r0, JIT_FP, (((i0) < 4) ? (i0) << 2 : (i0)) + ((__BYTE_ORDER == __BIG_ENDIAN) ? (sizeof(int) - sizeof(char)) : 0))

#define jit_getarg_uc(r0, i0) \
	jit_ldxi_uc(r0, JIT_FP, (((i0) < 4) ? (i0) << 2 : (i0)) + ((__BYTE_ORDER == __BIG_ENDIAN) ? (sizeof(int) - sizeof(char)) : 0))

#define jit_getarg_s(r0, i0) \
	jit_ldxi_s(r0, JIT_FP, (((i0) < 4) ? (i0) << 2 : (i0)) + ((__BYTE_ORDER == __BIG_ENDIAN) ? (sizeof(int) - sizeof(short)) : 0))

#define jit_getarg_us(r0, i0) \
	jit_ldxi_us(r0, JIT_FP, (((i0) < 4) ? (i0) << 2 : (i0)) + ((__BYTE_ORDER == __BIG_ENDIAN) ? (sizeof(int) - sizeof(short)) : 0))

#define jit_getarg_i(r0, i0)		arm_getarg_i(_jit, r0, i0)
#define jit_getarg_ui(r0, i0)		arm_getarg_i(_jit, r0, i0)
#define jit_getarg_l(r0, i0)		arm_getarg_i(_jit, r0, i0)
#define jit_getarg_ul(r0, i0)		arm_getarg_i(_jit, r0, i0)
#define jit_getarg_p(r0, i0) \
    jit_ldxi_i(r0, JIT_FP, (((i0) < 4) ? (i0) << 2 : (i0)));  /* arguments are saved in prolog */

#ifdef USE_THUMB_CODE
#define jit_pusharg_i(r0) \
{ \
    int ofs = _jitl.nextarg_put++; \
    assert(ofs < 256); \
    _jitl.stack_offset -= sizeof(int); \
    _jitl.arguments[ofs] = (int *)_jit.x.pc; \
    _jitl.types[ofs >> 5] &= ~(1 << (ofs & 31)); \
    /* force 32 bit instruction due to possibly needing to trasform it */ \
	T2_STRWI(r0, JIT_SP, 0); \
}
#else
#define jit_pusharg_i(r0) \
{ \
    int		ofs = _jitl.nextarg_put++; \
    assert(ofs < 256); \
    _jitl.stack_offset -= sizeof(int); \
    _jitl.arguments[ofs] = (int *)_jit.x.pc; \
    _jitl.types[ofs >> 5] &= ~(1 << (ofs & 31)); \
	_STRI(r0, JIT_SP, 0); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_finishr(rs) \
{ \
    assert(!_jitl.stack_offset); \
    if (r0 < 4) { \
		jit_movr_i(JIT_TMP, r0); \
		r0 = JIT_TMP; \
    } \
    arm_patch_arguments(&_jitl); \
    _jitl.nextarg_put = 0; \
    if (_jitl.reglist) { \
		T2_LDMIA(JIT_FP, _jitl.reglist); \
		_jitl.reglist = 0; \
    } \
    jit_callr(r0); \
}
#else
#define jit_finishr(rs) \
{ \
    assert(!_jitl.stack_offset); \
    if (r0 < 4) { \
		jit_movr_i(JIT_TMP, r0); \
		r0 = JIT_TMP; \
    } \
    arm_patch_arguments(&_jitl); \
    _jitl.nextarg_put = 0; \
    if (_jitl.reglist) { \
		_LDMIA(JIT_FP, _jitl.reglist); \
		_jitl.reglist = 0; \
    } \
    jit_callr(r0); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_finish(i0) \
	(assert(!_jitl.stack_offset), \
	 arm_patch_arguments(&_jitl), \
	 _jitl.nextarg_put = 0, \
	 (_jitl.reglist) ? \
		(T2_LDMIA(JIT_FP, _jitl.reglist), \
		 _jitl.reglist = 0) : 0, \
     jit_calli(i0))
#else
#define jit_finish(i0) \
	(assert(!_jitl.stack_offset), \
	 arm_patch_arguments(&_jitl), \
	 _jitl.nextarg_put = 0, \
	 (_jitl.reglist) ? \
		(_LDMIA(JIT_FP, _jitl.reglist), \
		 _jitl.reglist = 0) : 0, \
     jit_calli(i0))
#endif

#define jit_retval_i(r0)		jit_movr_i(r0, JIT_RET)

#ifdef USE_THUMB_CODE
#define jit_ret() \
{ \
    /* do not restore arguments */ \
    jit_addi_i(JIT_SP, JIT_FP, 16); \
    if (jit_hardfp_p()) \
		_VPOP_F64(_D8, 8); \
	T2_POP(/* callee save */ \
	       (1<<_R4)|(1<<_R5)|(1<<_R6)|(1<<_R7)|(1<<_R8)|(1<<_R9)| \
	       /* previous fp and return address */ \
	       (1<<JIT_FP)|(1<<JIT_PC)); \
    if (((int)_jit.x.pc & 2)) \
		T1_NOP(); \
}
#else
#define jit_ret() \
{ \
    /* do not restore arguments */ \
    jit_addi_i(JIT_SP, JIT_FP, 16); \
    if (jit_hardfp_p()) \
		_VPOP_F64(_D8, 8); \
	_POP(/* callee save */ \
	     (1<<_R4)|(1<<_R5)|(1<<_R6)|(1<<_R7)|(1<<_R8)|(1<<_R9)| \
	     /* previous fp and return address */ \
	     (1<<JIT_FP)|(1<<JIT_PC)); \
}
#endif

#ifdef USE_THUMB_CODE
#define jit_bare_ret() T2_POP(1<<JIT_PC)
#else
#define jit_bare_ret() _POP(1<<JIT_PC)
#endif

/* just to pass make check... */
#ifdef JIT_NEED_PUSH_POP
# define jit_pushr_i(r0) \
    (assert(_jitl.pop < sizeof(_jitl.push) / sizeof(_jitl.push[0])), \
     _jitl.push[_jitl.pop++] = jit_allocai(4), \
     jit_stxi_i(_jitl.push[_jitl.pop], JIT_FP, r0))

# define jit_popr_i(r0) \
	(assert(_jitl.pop > 0), \
	 _jitl.pop--, \
	 jit_ldxi_i(r0, JIT_FP, _jitl.push[_jitl.pop]))
#else
# define jit_pushr_i(r0) 0
# define jit_popr_i(r0) 0
#endif
#endif /* __lightning_core_arm_h */
