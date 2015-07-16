/******************************** -*- C -*- ****************************
 *
 *	Platform-independent layer (i386 version)
 *
 ***********************************************************************/


/***********************************************************************
 *
 * Copyright 2000, 2001, 2002, 2003, 2006 Free Software Foundation, Inc.
 * Written by Paolo Bonzini and Matthew Flatt.
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
 ***********************************************************************/



#ifndef __lightning_core_h
#define __lightning_core_h

/* Used to implement ldc, stc, ... */
#define JIT_CAN_16 0
#define JIT_REXTMP		_R12

/* Number or integer argument registers */
#define JIT_ARG_MAX		6

/* Number of float argument registers */
#define JIT_FP_ARG_MAX		8

#define JIT_R_NUM		3
#define JIT_R(i)                ((i) == 0 ? _EAX : _R9 + (i))
#define JIT_V_NUM               3
#define JIT_V(i)                ((i) == 0 ? _EBX : _R12 + (i))

struct jit_local_state {
  int   long_jumps;
  int   nextarg_getfp;
  int   nextarg_putfp;
  int   nextarg_geti;
  int	nextarg_puti;
  int	framesize;
  int	argssize;
  int	fprssize;
  int   alloca_offset;
  int   alloca_slack;
  jit_insn *finish_ref;
};

/* Whether a register in the "low" bank is used for the user-accessible
   registers.  */
#define jit_save(reg)		((reg) == _EAX || (reg) == _EBX)

/* Keep the stack 16-byte aligned, the SSE hardware prefers it this way.  */
#define jit_allocai_internal(amount, slack)                           \
  (((amount) < _jitl.alloca_slack                                     \
    ? 0                                                               \
    : (_jitl.alloca_slack += (amount) + (slack),                      \
      SUBQir((amount) + (slack), _ESP))),                             \
   _jitl.alloca_slack -= (amount),                                    \
   _jitl.alloca_offset -= (amount))

#define jit_allocai(n)                                                \
  jit_allocai_internal ((n), (_jitl.alloca_slack - (n)) & 15)

/* 3-parameter operation */
#define jit_qopr_(d, s1, s2, op1d, op2d)					\
	( ((s2) == (d)) ? op1d :						\
	  (  (((s1) == (d)) ? (void)0 : (void)MOVQrr((s1), (d))), op2d )	\
	)

/* 3-parameter operation, with immediate. TODO: fix the case where mmediate
   does not fit! */
#define jit_qop_small(d, s1, op2d)					\
	(((s1) == (d)) ? op2d : (MOVQrr((s1), (d)), op2d))
#define jit_qop_(d, s1, is, op2d, op2i)					\
	(_s32P((long)(is))						\
	 ? jit_qop_small ((d), (s1), (op2d))				\
	 : (MOVQir ((is), JIT_REXTMP), jit_qop_small ((d), (s1), (op2i))))

#define jit_bra_qr(s1, s2, op)		(CMPQrr(s2, s1), op, _jit.x.pc)
#define _jit_bra_l(rs, is, op)		(CMPQir(is, rs), op, _jit.x.pc)

#define jit_bra_l(rs, is, op) (_s32P((long)(is)) \
                               ? _jit_bra_l(rs, is, op) \
                               : (MOVQir(is, JIT_REXTMP), jit_bra_qr(rs, JIT_REXTMP, op)))

/* When CMP with 0 can be replaced with TEST */
#define jit_bra_l0(rs, is, op, op0)					\
	( (is) == 0 ? (TESTQrr(rs, rs), op0, _jit.x.pc) : jit_bra_l(rs, is, op))

#define jit_reduceQ(op, is, rs)							\
	(_u8P(is) ? jit_reduce_(op##Bir(is, jit_reg8(rs))) :	\
	jit_reduce_(op##Qir(is, rs)) )

#define jit_addi_l(d, rs, is)						\
    /* Value is not zero? */						\
    ((is)								\
	/* Yes. Value is unsigned and fits in signed 32 bits? */	\
	? (_uiP(31, is)							\
	    /* Yes. d == rs? */						\
	    ? jit_opi_((d), (rs),					\
		/* Yes. Use add opcode */				\
		ADDQir((is), (d)),					\
		/* No. Use lea opcode */				\
		LEAQmr((is), (rs), 0, 0, (d)))				\
	    /* No. Need value in a register */				\
	    : (jit_movi_l(JIT_REXTMP, is),				\
	       jit_addr_l(d, rs, JIT_REXTMP)))				\
	: jit_movr_l(d, rs))
#define jit_addr_l(d, s1, s2)	jit_opo_((d), (s1), (s2), ADDQrr((s2), (d)), ADDQrr((s1), (d)), LEAQmr(0, (s1), (s2), 1, (d))  )
#define jit_addci_l(d, rs, is)	jit_qop_ ((d), (rs), (is), ADCQir((is), (d)), ADCQrr(JIT_REXTMP, (d)))
#define jit_addcr_l(d, s1, s2)	jit_qopr_((d), (s1), (s2), ADCQrr((s1), (d)), ADCQrr((s2), (d)) )
#define jit_addxi_l(d, rs, is)	jit_qop_ ((d), (rs), (is), ADDQir((is), (d)), ADDQrr(JIT_REXTMP, (d)))
#define jit_addxr_l(d, s1, s2)	jit_qopr_((d), (s1), (s2), ADDQrr((s1), (d)), ADDQrr((s2), (d)) )
#define jit_andi_l(d, rs, is)	jit_qop_ ((d), (rs), (is), ANDQir((is), (d)), ANDQrr(JIT_REXTMP, (d)))
#define jit_andr_l(d, s1, s2)	jit_qopr_((d), (s1), (s2), ANDQrr((s1), (d)), ANDQrr((s2), (d)) )
#define jit_orr_l(d, s1, s2)	jit_qopr_((d), (s1), (s2),  ORQrr((s1), (d)),  ORQrr((s2), (d)) )
#define jit_subr_l(d, s1, s2)	jit_qopr_((d), (s1), (s2), (SUBQrr((s1), (d)), NEGQr(d)),	SUBQrr((s2), (d))	       )
#define jit_xorr_l(d, s1, s2)	jit_qopr_((d), (s1), (s2), XORQrr((s1), (d)), XORQrr((s2), (d)) )

/* These can sometimes use byte or word versions! */
#define jit_ori_l(d, rs, is)	jit_qop_ ((d), (rs), (is),   jit_reduceQ(OR, (is), (d)), ORQrr(JIT_REXTMP, (d))	       )
#define jit_xori_l(d, rs, is)	jit_qop_ ((d), (rs), (is),   jit_reduceQ(XOR, (is), (d)), XORQrr(JIT_REXTMP, (d))	       )

#define jit_lshi_l(d, rs, is)	((is) <= 3 ?   LEAQmr(0, 0, (rs), 1 << (is), (d))   :   jit_qop_small ((d), (rs), SHLQir((is), (d)) ))
#define jit_rshi_l(d, rs, is)								jit_qop_small ((d), (rs), SARQir((is), (d))  )
#define jit_rshi_ul(d, rs, is)								jit_qop_small ((d), (rs), SHRQir((is), (d))  )
#define jit_lshr_l(d, r1, r2)	jit_shift((d), (r1), (r2), SHLQrr)
#define jit_rshr_l(d, r1, r2)	jit_shift((d), (r1), (r2), SARQrr)
#define jit_rshr_ul(d, r1, r2)	jit_shift((d), (r1), (r2), SHRQrr)


/* Stack */
#define jit_pushr_i(rs)		PUSHQr(rs)
#define jit_popr_i(rs)		POPQr(rs)

/* A return address is 8 bytes, plus 5 registers = 40 bytes, total = 48 bytes. */
#define jit_prolog(n) (_jitl.framesize = ((n) & 1) ? 56 : 48, _jitl.nextarg_getfp = _jitl.nextarg_geti = 0, _jitl.alloca_offset = 0, \
		       PUSHQr(_EBX), PUSHQr(_R12), PUSHQr(_R13), PUSHQr(_R14), PUSHQr(_EBP), MOVQrr(_ESP, _EBP))

#define jit_calli(sub)      (MOVQir((long) (sub), JIT_REXTMP), _jitl.finish_ref = _jit.x.pc, CALLsr(JIT_REXTMP), _jitl.finish_ref)
#define jit_callr(reg)		CALLsr((reg))

#define jit_prepare_i(ni)	(_jitl.nextarg_puti = (ni), \
				 _jitl.argssize = _jitl.nextarg_puti > JIT_ARG_MAX \
				 ? _jitl.nextarg_puti - JIT_ARG_MAX : 0)
#define jit_pusharg_i(rs)	(--_jitl.nextarg_puti >= JIT_ARG_MAX \
				 ? PUSHQr(rs) :	MOVQrr(rs, jit_arg_reg_order[_jitl.nextarg_puti]))

#define jit_finish(sub)		(_jitl.fprssize \
				 ? (MOVBir(_jitl.fprssize, _AL), _jitl.fprssize = 0) \
				 : MOVBir(0, _AL), \
				 ((_jitl.argssize & 1) \
				   ? (PUSHQr(_EAX), ++_jitl.argssize) : 0), \
				 jit_calli(sub), \
				 (_jitl.argssize \
				  ? (ADDQir(sizeof(long) * _jitl.argssize, JIT_SP), _jitl.argssize = 0) \
				  : 0), \
				 _jitl.finish_ref)
#define jit_reg_is_arg(reg)     ((reg) == _ECX || (reg) == _EDX)

#define jit_finishr(reg)	(_jitl.fprssize \
				 ? (MOVBir(_jitl.fprssize, _AL), _jitl.fprssize = 0) \
				 : MOVBir(0, _AL), \
				 ((_jitl.argssize & 1) \
				   ? (PUSHQr(_EAX), ++_jitl.argssize) : 0), \
				 (jit_reg_is_arg((reg)) \
				  ? (MOVQrr(reg, JIT_REXTMP), \
				     jit_callr(JIT_REXTMP)) \
				  : jit_callr(reg)), \
				 (_jitl.argssize \
				  ? (ADDQir(sizeof(long) * _jitl.argssize, JIT_SP), _jitl.argssize = 0) \
				  : 0))

#define jit_retval_l(rd)	((void)jit_movr_l ((rd), _EAX))
#define jit_arg_i()		(_jitl.nextarg_geti < JIT_ARG_MAX \
				 ? _jitl.nextarg_geti++ \
				 : (int) ((_jitl.framesize += sizeof(long)) - sizeof(long)))
#define jit_arg_c()		jit_arg_i()
#define jit_arg_uc()		jit_arg_i()
#define jit_arg_s()		jit_arg_i()
#define jit_arg_us()		jit_arg_i()
#define jit_arg_ui()		jit_arg_i()
#define jit_arg_l()		jit_arg_i()
#define jit_arg_ul()		jit_arg_i()
#define jit_arg_p()		jit_arg_i()

#define jit_getarg_c(reg, ofs)	((ofs) < JIT_ARG_MAX \
				 ? jit_extr_c_l((reg), jit_arg_reg_order[(ofs)]) \
				 : jit_ldxi_c((reg), JIT_FP, (ofs)))
#define jit_getarg_uc(reg, ofs)	((ofs) < JIT_ARG_MAX \
				 ? jit_extr_uc_ul((reg), jit_arg_reg_order[(ofs)]) \
				 : jit_ldxi_uc((reg), JIT_FP, (ofs)))
#define jit_getarg_s(reg, ofs)	((ofs) < JIT_ARG_MAX \
				 ? jit_extr_s_l((reg), jit_arg_reg_order[(ofs)]) \
				 : jit_ldxi_s((reg), JIT_FP, (ofs)))
#define jit_getarg_us(reg, ofs)	((ofs) < JIT_ARG_MAX \
				 ? jit_extr_us_ul((reg), jit_arg_reg_order[(ofs)]) \
				 : jit_ldxi_us((reg), JIT_FP, (ofs)))
#define jit_getarg_i(reg, ofs)	((ofs) < JIT_ARG_MAX \
				 ? jit_movr_l((reg), jit_arg_reg_order[(ofs)]) \
				 : jit_ldxi_i((reg), JIT_FP, (ofs)))
#define jit_getarg_ui(reg, ofs)	((ofs) < JIT_ARG_MAX \
				 ? jit_movr_ul((reg), jit_arg_reg_order[(ofs)]) \
				 : jit_ldxi_ui((reg), JIT_FP, (ofs)))
#define jit_getarg_l(reg, ofs)	((ofs) < JIT_ARG_MAX \
				 ? jit_movr_l((reg), jit_arg_reg_order[(ofs)]) \
				 : jit_ldxi_l((reg), JIT_FP, (ofs)))
#define jit_getarg_ul(reg, ofs)	((ofs) < JIT_ARG_MAX \
				 ? jit_movr_ul((reg), jit_arg_reg_order[(ofs)]) \
				 : jit_ldxi_ul((reg), JIT_FP, ofs))
#define jit_getarg_p(reg, ofs)	((ofs) < JIT_ARG_MAX \
				 ? jit_movr_p((reg), jit_arg_reg_order[(ofs)]) \
				 : jit_ldxi_p((reg), JIT_FP, (ofs)))

static int jit_arg_reg_order[] = { _EDI, _ESI, _EDX, _ECX, _R8D, _R9D };

#define jit_negr_l(d, rs)	jit_opi_((d), (rs), NEGQr(d), (XORQrr((d), (d)), SUBQrr((rs), (d))) )
#define jit_movr_l(d, rs)	((void)((rs) == (d) ? 0 : MOVQrr((rs), (d))))
#define jit_movi_p(d, is)	(MOVQir(((long)(is)), (d)), _jit.x.pc)
#define jit_movi_l(d, is)						\
    /* Value is not zero? */						\
    ((is)								\
	/* Yes. Value is unsigned and fits in signed 32 bits? */	\
	? (_uiP(31, is)							\
	    /* Yes. Use 32 bits opcode */				\
	    ? MOVLir(is, (d))						\
	    /* No. Use 64 bits opcode */				\
	    : MOVQir(is, (d)))						\
	/* No. Set register to zero. */					\
	: XORQrr ((d), (d)))

#define jit_bmsr_l(label, s1, s2)	(TESTQrr((s1), (s2)), JNZm(label), _jit.x.pc)
#define jit_bmcr_l(label, s1, s2)	(TESTQrr((s1), (s2)), JZm(label),  _jit.x.pc)
#define jit_boaddr_l(label, s1, s2)	(ADDQrr((s2), (s1)), JOm(label), _jit.x.pc)
#define jit_bosubr_l(label, s1, s2)	(SUBQrr((s2), (s1)), JOm(label), _jit.x.pc)
#define jit_boaddr_ul(label, s1, s2)	(ADDQrr((s2), (s1)), JCm(label), _jit.x.pc)
#define jit_bosubr_ul(label, s1, s2)	(SUBQrr((s2), (s1)), JCm(label), _jit.x.pc)

#define jit_boaddi_l(label, rs, is)	(ADDQir((is), (rs)), JOm(label), _jit.x.pc)
#define jit_bosubi_l(label, rs, is)	(SUBQir((is), (rs)), JOm(label), _jit.x.pc)
#define jit_boaddi_ul(label, rs, is)	(ADDQir((is), (rs)), JCm(label), _jit.x.pc)
#define jit_bosubi_ul(label, rs, is)	(SUBQir((is), (rs)), JCm(label), _jit.x.pc)

#define jit_patch_long_at(jump_pc,v)  (*_PSL((jump_pc) - sizeof(long)) = _jit_SL((jit_insn *)(v)))
#define jit_patch_short_at(jump_pc,v)  (*_PSI((jump_pc) - sizeof(int)) = _jit_SI((jit_insn *)(v) - (jump_pc)))
#define jit_patch_at(jump_pc,v) (_jitl.long_jumps ? jit_patch_long_at((jump_pc)-3, v) : jit_patch_short_at(jump_pc, v))
#define jit_patch_calli(pa,pv) (*_PSL((pa) - sizeof(long)) = _jit_SL((pv)))
#define jit_ret()			(LEAVE_(), POPQr(_R14), POPQr(_R13), POPQr(_R12), POPQr(_EBX), RET_())
#define jit_bare_ret() RET_()

/* Memory */

/* Used to implement ldc, stc, ... We have SIL and friends which simplify it all.  */
#define jit_movbrm(rs, dd, db, di, ds)         MOVBrm(jit_reg8(rs), dd, db, di, ds)

#define jit_ldr_c(d, rs)                MOVSBQmr(0,    (rs), 0,    0, (d))
#define jit_ldxr_c(d, s1, s2)           MOVSBQmr(0,    (s1), (s2), 1, (d))
							    
#define jit_ldr_s(d, rs)                MOVSWQmr(0,    (rs), 0,    0, (d))
#define jit_ldxr_s(d, s1, s2)           MOVSWQmr(0,    (s1), (s2), 1, (d))
							    
#define jit_ldi_c(d, is)                (_u32P((long)(is)) ? MOVSBQmr((is), 0,    0,    0, (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldr_c(d, JIT_REXTMP)))
#define jit_ldxi_c(d, rs, is)           (_u32P((long)(is)) ? MOVSBQmr((is), (rs), 0,    0, (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldxr_c(d, rs, JIT_REXTMP)))

#define jit_ldi_uc(d, is)               (_u32P((long)(is)) ? MOVZBLmr((is), 0,    0,    0, (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldr_uc(d, JIT_REXTMP)))
#define jit_ldxi_uc(d, rs, is)          (_u32P((long)(is)) ? MOVZBLmr((is), (rs), 0,    0, (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldxr_uc(d, rs, JIT_REXTMP)))

#define jit_sti_c(id, rs)               (_u32P((long)(id)) ? MOVBrm(jit_reg8(rs), (id), 0,    0,    0) : (jit_movi_l(JIT_REXTMP, id), jit_str_c(JIT_REXTMP, rs)))
#define jit_stxi_c(id, rd, rs)          (_u32P((long)(id)) ? MOVBrm(jit_reg8(rs), (id), (rd), 0,    0) : (jit_movi_l(JIT_REXTMP, id), jit_stxr_c(JIT_REXTMP, rd, rs)))

#define jit_ldi_s(d, is)                (_u32P((long)(is)) ? MOVSWQmr((is), 0,    0,    0, (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldr_s(d, JIT_REXTMP)))
#define jit_ldxi_s(d, rs, is)           (_u32P((long)(is)) ? MOVSWQmr((is), (rs), 0,    0, (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldxr_s(d, rs, JIT_REXTMP)))

#define jit_ldi_us(d, is)               (_u32P((long)(is)) ? MOVZWLmr((is), 0,    0,    0,  (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldr_us(d, JIT_REXTMP)))
#define jit_ldxi_us(d, rs, is)          (_u32P((long)(is)) ? MOVZWLmr((is), (rs), 0,    0,  (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldxr_us(d, rs, JIT_REXTMP)))

#define jit_sti_s(id, rs)               (_u32P((long)(id)) ? MOVWrm(jit_reg16(rs), (id), 0,    0,    0) : (jit_movi_l(JIT_REXTMP, id), jit_str_s(JIT_REXTMP, rs)))
#define jit_stxi_s(id, rd, rs)          (_u32P((long)(id)) ? MOVWrm(jit_reg16(rs), (id), (rd), 0,    0) : (jit_movi_l(JIT_REXTMP, id), jit_stxr_s(JIT_REXTMP, rd, rs)))

#define jit_ldi_ui(d, is)               (_u32P((long)(is)) ? MOVLmr((is), 0,    0,    0,  (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldr_ui(d, JIT_REXTMP)))
#define jit_ldxi_ui(d, rs, is)          (_u32P((long)(is)) ? MOVLmr((is), (rs), 0,    0,  (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldxr_ui(d, rs, JIT_REXTMP)))

#define jit_ldi_i(d, is)                (_u32P((long)(is)) ? MOVSLQmr((is), 0,    0,    0,  (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldr_i(d, JIT_REXTMP)))
#define jit_ldxi_i(d, rs, is)           (_u32P((long)(is)) ? MOVSLQmr((is), (rs), 0,    0,  (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldxr_i(d, rs, JIT_REXTMP)))

#define jit_sti_i(id, rs)               (_u32P((long)(id)) ? MOVLrm((rs), (id), 0,    0,    0) : (jit_movi_l(JIT_REXTMP, id), jit_str_i(JIT_REXTMP, rs)))
#define jit_stxi_i(id, rd, rs)          (_u32P((long)(id)) ? MOVLrm((rs), (id), (rd), 0,    0) : (jit_movi_l(JIT_REXTMP, id), jit_stxr_i(JIT_REXTMP, rd, rs)))

#define jit_ldi_l(d, is)                (_u32P((long)(is)) ? MOVQmr((is), 0,    0,    0,  (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldr_l(d, JIT_REXTMP)))
#define jit_ldxi_l(d, rs, is)           (_u32P((long)(is)) ? MOVQmr((is), (rs), 0,    0,  (d)) :  (jit_movi_l(JIT_REXTMP, is), jit_ldxr_l(d, rs, JIT_REXTMP)))

#define jit_sti_l(id, rs)               (_u32P((long)(id)) ? MOVQrm((rs), (id), 0,    0,    0) : (jit_movi_l(JIT_REXTMP, id), jit_str_l(JIT_REXTMP, rs)))
#define jit_stxi_l(id, rd, rs)          (_u32P((long)(id)) ? MOVQrm((rs), (id), (rd), 0,    0) : (jit_movi_l(JIT_REXTMP, id), jit_stxr_l(JIT_REXTMP, rd, rs)))

#define jit_ldr_ui(d, rs)               MOVLmr(0,    (rs), 0,    0,  (d))
#define jit_ldxr_ui(d, s1, s2)          MOVLmr(0,    (s1), (s2), 1,  (d))

#define jit_ldr_i(d, rs)                MOVSLQmr(0,    (rs), 0,    0,  (d))
#define jit_ldxr_i(d, s1, s2)           MOVSLQmr(0,    (s1), (s2), 1,  (d))

#define jit_ldr_l(d, rs)                MOVQmr(0,    (rs), 0,    0,  (d))
#define jit_ldxr_l(d, s1, s2)           MOVQmr(0,    (s1), (s2), 1,  (d))

#define jit_str_l(rd, rs)               MOVQrm((rs), 0,    (rd), 0,    0)
#define jit_stxr_l(d1, d2, rs)          MOVQrm((rs), 0,    (d1), (d2), 1)

#define jit_blti_l(label, rs, is)	jit_bra_l0((rs), (is), JLm(label), JSm(label) )
#define jit_blei_l(label, rs, is)	jit_bra_l ((rs), (is), JLEm(label)		    )
#define jit_bgti_l(label, rs, is)	jit_bra_l ((rs), (is), JGm(label)		    )
#define jit_bgei_l(label, rs, is)	jit_bra_l0((rs), (is), JGEm(label), JNSm(label) )
#define jit_beqi_l(label, rs, is)	jit_bra_l0((rs), (is), JEm(label), JEm(label) )
#define jit_bnei_l(label, rs, is)	jit_bra_l0((rs), (is), JNEm(label), JNEm(label) )
#define jit_blti_ul(label, rs, is)	jit_bra_l ((rs), (is), JBm(label)		    )
#define jit_blei_ul(label, rs, is)	jit_bra_l0((rs), (is), JBEm(label), JEm(label) )
#define jit_bgti_ul(label, rs, is)	jit_bra_l0((rs), (is), JAm(label), JNEm(label) )
#define jit_bgei_ul(label, rs, is)	jit_bra_l ((rs), (is), JAEm(label)		    )
#define jit_bmsi_l(label, rs, is)	(jit_reduceQ(TEST, (is), (rs)), JNZm(label), _jit.x.pc)
#define jit_bmci_l(label, rs, is)	(jit_reduceQ(TEST, (is), (rs)), JZm(label),  _jit.x.pc)

#define jit_pushr_l(rs) jit_pushr_i(rs)
#define jit_popr_l(rs)  jit_popr_i(rs)

#define jit_pusharg_l(rs) jit_pusharg_i(rs)
#define jit_retval_l(rd)	((void)jit_movr_l ((rd), _EAX))
#define jit_bltr_l(label, s1, s2)	jit_bra_qr((s1), (s2), JLm(label) )
#define jit_bler_l(label, s1, s2)	jit_bra_qr((s1), (s2), JLEm(label) )
#define jit_bgtr_l(label, s1, s2)	jit_bra_qr((s1), (s2), JGm(label) )
#define jit_bger_l(label, s1, s2)	jit_bra_qr((s1), (s2), JGEm(label) )
#define jit_beqr_l(label, s1, s2)	jit_bra_qr((s1), (s2), JEm(label) )
#define jit_bner_l(label, s1, s2)	jit_bra_qr((s1), (s2), JNEm(label) )
#define jit_bltr_ul(label, s1, s2)	jit_bra_qr((s1), (s2), JBm(label) )
#define jit_bler_ul(label, s1, s2)	jit_bra_qr((s1), (s2), JBEm(label) )
#define jit_bgtr_ul(label, s1, s2)	jit_bra_qr((s1), (s2), JAm(label) )
#define jit_bger_ul(label, s1, s2)	jit_bra_qr((s1), (s2), JAEm(label) )

/* Bool operations.  */
#define jit_bool_qr(d, s1, s2, op)                                      \
        (jit_replace8(d, CMPQrr(s2, s1), op))

#define jit_bool_qi(d, rs, is, op)                                      \
        (jit_replace8(d, CMPQir(is, rs), op))

/* When CMP with 0 can be replaced with TEST */
#define jit_bool_qi0(d, rs, is, op, op0)                                \
        ((is) != 0                                                      \
          ? (jit_replace8(d, CMPQir(is, rs), op))                       \
          : (jit_replace8(d, TESTQrr(rs, rs), op0)))

#define jit_ltr_l(d, s1, s2)    jit_bool_qr((d), (s1), (s2), SETLr  )
#define jit_ler_l(d, s1, s2)    jit_bool_qr((d), (s1), (s2), SETLEr )
#define jit_gtr_l(d, s1, s2)    jit_bool_qr((d), (s1), (s2), SETGr  )
#define jit_ger_l(d, s1, s2)    jit_bool_qr((d), (s1), (s2), SETGEr )
#define jit_eqr_l(d, s1, s2)    jit_bool_qr((d), (s1), (s2), SETEr  )
#define jit_ner_l(d, s1, s2)    jit_bool_qr((d), (s1), (s2), SETNEr )
#define jit_ltr_ul(d, s1, s2)   jit_bool_qr((d), (s1), (s2), SETBr  )
#define jit_ler_ul(d, s1, s2)   jit_bool_qr((d), (s1), (s2), SETBEr )
#define jit_gtr_ul(d, s1, s2)   jit_bool_qr((d), (s1), (s2), SETAr  )
#define jit_ger_ul(d, s1, s2)   jit_bool_qr((d), (s1), (s2), SETAEr )

#define jit_lti_l(d, rs, is)    jit_bool_qi0((d), (rs), (is), SETLr,  SETSr  )
#define jit_lei_l(d, rs, is)    jit_bool_qi ((d), (rs), (is), SETLEr         )
#define jit_gti_l(d, rs, is)    jit_bool_qi ((d), (rs), (is), SETGr          )
#define jit_gei_l(d, rs, is)    jit_bool_qi0((d), (rs), (is), SETGEr, SETNSr )
#define jit_eqi_l(d, rs, is)    jit_bool_qi0((d), (rs), (is), SETEr,  SETEr  )
#define jit_nei_l(d, rs, is)    jit_bool_qi0((d), (rs), (is), SETNEr, SETNEr )
#define jit_lti_ul(d, rs, is)   jit_bool_qi ((d), (rs), (is), SETBr          )
#define jit_lei_ul(d, rs, is)   jit_bool_qi0((d), (rs), (is), SETBEr, SETEr  )
#define jit_gti_ul(d, rs, is)   jit_bool_qi0((d), (rs), (is), SETAr,  SETNEr )
#define jit_gei_ul(d, rs, is)   jit_bool_qi0((d), (rs), (is), SETAEr, INCLr  )

/* Multiplication/division.  */
#define jit_mulr_ul_(s1, s2)				\
        jit_qopr_(_RAX, s1, s2, MULQr(s1), MULQr(s2))

#define jit_mulr_l_(s1, s2)				\
        jit_qopr_(_RAX, s1, s2, IMULQr(s1), IMULQr(s2))

#define jit_muli_l_(is, rs)                             \
        (MOVQir(is, rs == _RAX ? _RDX : _RAX),          \
         IMULQr(rs == _RAX ? _RDX : rs))

#define jit_muli_ul_(is, rs)                            \
        (MOVQir(is, rs == _RAX ? _RDX : _RAX),          \
         IMULQr(rs == _RAX ? _RDX : rs))

#define jit_divi_l_(result, d, rs, is)                  \
        (jit_might (d,    _RAX, jit_pushr_l(_RAX)),             \
        jit_might (d,    _RCX, jit_pushr_l(_RCX)),              \
        jit_might (d,    _RDX, jit_pushr_l(_RDX)),              \
        jit_might (rs,   _RAX, MOVQrr(rs, _RAX)),       \
        jit_might (rs,   _RDX, MOVQrr(rs, _RDX)),       \
        MOVQir(is, _RCX),                               \
        SARQir(63, _RDX),                               \
        IDIVQr(_RCX),                                   \
        jit_might(d,    result, MOVQrr(result, d)),     \
        jit_might(d,     _RDX,  jit_popr_l(_RDX)),              \
        jit_might(d,     _RCX,  jit_popr_l(_RCX)),              \
        jit_might(d,     _RAX,  jit_popr_l(_RAX)))

#define jit_divr_l_(result, d, s1, s2)                  \
        (jit_might (d,    _RAX, jit_pushr_l(_RAX)),             \
        jit_might (d,    _RCX, jit_pushr_l(_RCX)),              \
        jit_might (d,    _RDX, jit_pushr_l(_RDX)),              \
        ((s1 == _RCX) ? jit_pushr_l(_RCX) : 0),         \
        jit_might (s2,   _RCX, MOVQrr(s2, _RCX)),       \
        ((s1 == _RCX) ? jit_popr_l(_RDX) :                      \
        jit_might (s1,   _RDX, MOVQrr(s1, _RDX))),      \
        MOVQrr(_RDX, _RAX),                             \
        SARQir(63, _RDX),                               \
        IDIVQr(_RCX),                                   \
        jit_might(d,    result, MOVQrr(result, d)),     \
        jit_might(d,     _RDX,  jit_popr_l(_RDX)),              \
        jit_might(d,     _RCX,  jit_popr_l(_RCX)),              \
        jit_might(d,     _RAX,  jit_popr_l(_RAX)))

#define jit_divi_ul_(result, d, rs, is)                 \
        (jit_might (d,    _RAX, jit_pushr_l(_RAX)),             \
        jit_might (d,    _RCX, jit_pushr_l(_RCX)),              \
        jit_might (d,    _RDX, jit_pushr_l(_RDX)),              \
        jit_might (rs,   _RAX, MOVQrr(rs, _RAX)),       \
        MOVQir(is, _RCX),                               \
        XORQrr(_RDX, _RDX),                             \
        DIVQr(_RCX),                                    \
        jit_might(d,    result, MOVQrr(result, d)),     \
        jit_might(d,     _RDX,  jit_popr_l(_RDX)),              \
        jit_might(d,     _RCX,  jit_popr_l(_RCX)),              \
        jit_might(d,     _RAX,  jit_popr_l(_RAX)))

#define jit_divr_ul_(result, d, s1, s2)                 \
        (jit_might (d,    _RAX, jit_pushr_l(_RAX)),             \
        jit_might (d,    _RCX, jit_pushr_l(_RCX)),              \
        jit_might (d,    _RDX, jit_pushr_l(_RDX)),              \
        ((s1 == _RCX) ? jit_pushr_l(_RCX) : 0),         \
        jit_might (s2,   _RCX, MOVQrr(s2, _RCX)),       \
        ((s1 == _RCX) ? jit_popr_l(_RAX) :                      \
        jit_might (s1,   _RAX, MOVQrr(s1, _RAX))),      \
        XORQrr(_RDX, _RDX),                             \
        DIVQr(_RCX),                                    \
        jit_might(d,    result, MOVQrr(result, d)),     \
        jit_might(d,     _RDX,  jit_popr_l(_RDX)),              \
        jit_might(d,     _RCX,  jit_popr_l(_RCX)),              \
        jit_might(d,     _RAX,  jit_popr_l(_RAX)))

#define jit_muli_l(d, rs, is)	jit_qop_ ((d), (rs), (is), IMULQir((is), (d)), IMULQrr(JIT_REXTMP, (d)) )
#define jit_mulr_l(d, s1, s2)	jit_qopr_((d), (s1), (s2), IMULQrr((s1), (d)), IMULQrr((s2), (d)) )

/* As far as low bits are concerned, signed and unsigned multiplies are
   exactly the same. */
#define jit_muli_ul(d, rs, is)	jit_qop_ ((d), (rs), (is), IMULQir((is), (d)), IMULQrr(JIT_REXTMP, (d)) )
#define jit_mulr_ul(d, s1, s2)	jit_qopr_((d), (s1), (s2), IMULQrr((s1), (d)), IMULQrr((s2), (d)) )

#define jit_hmuli_l(d, rs, is)														\
	((d) == _RDX ? (	      jit_pushr_l(_RAX), jit_muli_l_((is), (rs)), 				     jit_popr_l(_RAX)		) :	\
	((d) == _RAX ? (jit_pushr_l(_RDX),		    jit_muli_l_((is), (rs)), MOVQrr(_RDX, _RAX),	     jit_popr_l(_RDX) ) :	\
	               (jit_pushr_l(_RDX), jit_pushr_l(_RAX), jit_muli_l_((is), (rs)), MOVQrr(_RDX, (d)), jit_popr_l(_RAX), jit_popr_l(_RDX) )))

#define jit_hmulr_l(d, s1, s2)													\
	((d) == _RDX ? (	      jit_pushr_l(_RAX), jit_mulr_l_((s1), (s2)), 			  jit_popr_l(_RAX)		    ) :	\
	((d) == _RAX ? (jit_pushr_l(_RDX),		    jit_mulr_l_((s1), (s2)), MOVQrr(_RDX, _RAX), 	       jit_popr_l(_RDX)  ) :	\
	 	       (jit_pushr_l(_RDX), jit_pushr_l(_RAX), jit_mulr_l_((s1), (s2)), MOVQrr(_RDX, (d)),   jit_popr_l(_RAX), jit_popr_l(_RDX)  )))

#define jit_hmuli_ul(d, rs, is)														\
	((d) == _RDX ? (	      jit_pushr_l(_RAX), jit_muli_ul_((is), (rs)), 				      jit_popr_l(_RAX)		) :	\
	((d) == _RAX ? (jit_pushr_l(_RDX),		    jit_muli_ul_((is), (rs)), MOVQrr(_RDX, _RAX),	      jit_popr_l(_RDX) ) :	\
	               (jit_pushr_l(_RDX), jit_pushr_l(_RAX), jit_muli_ul_((is), (rs)), MOVQrr(_RDX, (d)), jit_popr_l(_RAX), jit_popr_l(_RDX) )))

#define jit_hmulr_ul(d, s1, s2)													\
	((d) == _RDX ? (	      jit_pushr_l(_RAX), jit_mulr_ul_((s1), (s2)), 			  jit_popr_l(_RAX)		    ) :	\
	((d) == _RAX ? (jit_pushr_l(_RDX),		    jit_mulr_ul_((s1), (s2)), MOVQrr(_RDX, _RAX), 	       jit_popr_l(_RDX)  ) :	\
	 	       (jit_pushr_l(_RDX), jit_pushr_l(_RAX), jit_mulr_ul_((s1), (s2)), MOVQrr(_RDX, (d)),  jit_popr_l(_RAX), jit_popr_l(_RDX)  )))

#define jit_divi_l(d, rs, is)	jit_divi_l_(_RAX, (d), (rs), (is))
#define jit_divi_ul(d, rs, is)	jit_divi_ul_(_RAX, (d), (rs), (is))
#define jit_modi_l(d, rs, is)	jit_divi_l_(_RDX, (d), (rs), (is))
#define jit_modi_ul(d, rs, is)	jit_divi_ul_(_RDX, (d), (rs), (is))
#define jit_divr_l(d, s1, s2)	jit_divr_l_(_RAX, (d), (s1), (s2))
#define jit_divr_ul(d, s1, s2)	jit_divr_ul_(_RAX, (d), (s1), (s2))
#define jit_modr_l(d, s1, s2)	jit_divr_l_(_RDX, (d), (s1), (s2))
#define jit_modr_ul(d, s1, s2)	jit_divr_ul_(_RDX, (d), (s1), (s2))

#endif /* __lightning_core_h */
