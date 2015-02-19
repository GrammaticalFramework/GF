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

#define JIT_CAN_16 1
#define JIT_AP			_EBP

#define JIT_R_NUM		3
#define JIT_R(i)		(_EAX + (i))
#define JIT_V_NUM		3
#define JIT_V(i)		((i) == 0 ? _EBX : _ESI + (i) - 1)

struct jit_local_state {
  int	framesize;
  int	argssize;
  int	alloca_offset;
  int	alloca_slack;
  jit_insn *finish_ref;
};

/* Whether a register is used for the user-accessible registers.  */
#define jit_save(reg)		1

#define jit_base_prolog() (_jitl.framesize = 20, _jitl.alloca_offset = _jitl.alloca_slack = 0, _jitl.argssize = 0, \
  PUSHLr(_EBX), PUSHLr(_ESI), PUSHLr(_EDI), PUSHLr(_EBP), MOVLrr(_ESP, _EBP))
#define jit_base_ret(ofs)						  \
  (((ofs) < 0 ? LEAVE_() : POPLr(_EBP)),				  \
   POPLr(_EDI), POPLr(_ESI), POPLr(_EBX), RET_())

/* Used internally.  SLACK is used by the Darwin ABI which keeps the stack
   aligned to 16-bytes.  */

#define jit_allocai_internal(amount, slack)				  \
  (((amount) < _jitl.alloca_slack					  \
    ? (void)0								  \
    : (void)(_jitl.alloca_slack += (amount) + (slack),			  \
       ((amount) + (slack) == sizeof (int)				  \
        ? PUSHLr(_EAX)							  \
        : SUBLir((amount) + (slack), _ESP)))),				  \
   _jitl.alloca_slack -= (amount),					  \
   _jitl.alloca_offset -= (amount))
   
/* Stack */
#define jit_pushr_i(rs)		PUSHLr(rs)
#define jit_popr_i(rs)		POPLr(rs)

/* The += in argssize allows for stack pollution */

#ifdef __APPLE__
/* Stack must stay 16-byte aligned: */
# define jit_prepare_i(ni)	(((ni & 0x3) \
                                  ? (void)SUBLir(4 * ((((ni) + 3) & ~(0x3)) - (ni)), JIT_SP) \
                                  : (void)0), \
                                 _jitl.argssize += (((ni) + 3) & ~(0x3)))

#define jit_allocai(n)						\
  jit_allocai_internal ((n), (_jitl.alloca_slack - (n)) & 15)

#define jit_prolog(n)		(jit_base_prolog(), jit_subi_i (JIT_SP, JIT_SP, 12))
#define jit_ret()		jit_base_ret (-12)

#else
# define jit_prepare_i(ni)	(_jitl.argssize += (ni))

#define jit_allocai(n)						\
  jit_allocai_internal ((n), 0)

#define jit_prolog(n)		jit_base_prolog()
#define jit_ret()		jit_base_ret (_jitl.alloca_offset)
#endif

#define jit_bare_ret() RET_()

#define jit_calli(label)	(CALLm( ((unsigned long) (label))), _jit.x.pc)
#define jit_callr(reg)		CALLsr(reg)

#define jit_pusharg_i(rs)	PUSHLr(rs)
#define jit_finish(sub)  (_jitl.finish_ref = jit_calli((sub)), ADDLir(sizeof(long) * _jitl.argssize, JIT_SP), _jitl.argssize = 0, _jitl.finish_ref)
#define jit_finishr(reg) (jit_callr((reg)), ADDLir(sizeof(long) * _jitl.argssize, JIT_SP), _jitl.argssize = 0)

#define	jit_arg_c()		((_jitl.framesize += sizeof(int)) - sizeof(int))
#define	jit_arg_uc()		((_jitl.framesize += sizeof(int)) - sizeof(int))
#define	jit_arg_s()		((_jitl.framesize += sizeof(int)) - sizeof(int))
#define	jit_arg_us()		((_jitl.framesize += sizeof(int)) - sizeof(int))
#define	jit_arg_i()		((_jitl.framesize += sizeof(int)) - sizeof(int))
#define	jit_arg_ui()		((_jitl.framesize += sizeof(int)) - sizeof(int))
#define	jit_arg_l()		((_jitl.framesize += sizeof(long)) - sizeof(long))
#define	jit_arg_ul()		((_jitl.framesize += sizeof(long)) - sizeof(long))
#define	jit_arg_p()		((_jitl.framesize += sizeof(long)) - sizeof(long))

#define jit_movi_p(d, is)       (MOVLir (((long)(is)), (d)), _jit.x.pc)
#define jit_patch_long_at(jump_pc,v)  (*_PSL((jump_pc) - sizeof(long)) = _jit_SL((jit_insn *)(v) - (jump_pc)))
#define jit_patch_at(jump_pc,v)  jit_patch_long_at(jump_pc, v)
#define jit_patch_calli(jump_pc,v) jit_patch_long_at(jump_pc, v)

/* Memory */
#define jit_replace(s, rep, op)                         \
        (jit_pushr_i(rep),                              \
         MOVLrr((s), (rep)),                            \
         op, jit_popr_i(rep))

#define jit_movbrm(rs, dd, db, di, ds)                                          \
        (jit_check8(rs)                                                         \
                ? MOVBrm(jit_reg8(rs), dd, db, di, ds)                          \
                : jit_replace(rs,                                               \
                              ((dd != _EAX && db != _EAX && di != _EAX) ? _EAX :              \
                              ((dd != _ECX && db != _ECX && di != _ECX) ? _ECX : _EDX)),      \
                              MOVBrm(((dd != _EAX && db != _EAX && di != _EAX) ? _AL :        \
                                     ((dd != _ECX && db != _ECX && di != _ECX) ? _CL : _DL)), \
                                     dd, db, di, ds)))

#define jit_ldr_c(d, rs)                MOVSBLmr(0,    (rs), 0,    0, (d))
#define jit_ldxr_c(d, s1, s2)           MOVSBLmr(0,    (s1), (s2), 1, (d))
							    
#define jit_ldr_s(d, rs)                MOVSWLmr(0,    (rs), 0,    0, (d))
#define jit_ldxr_s(d, s1, s2)           MOVSWLmr(0,    (s1), (s2), 1, (d))
							    
#define jit_ldi_c(d, is)                MOVSBLmr((is), 0,    0,    0, (d))
#define jit_ldxi_c(d, rs, is)           MOVSBLmr((is), (rs), 0,    0, (d))

#define jit_ldi_uc(d, is)               MOVZBLmr((is), 0,    0,    0, (d))
#define jit_ldxi_uc(d, rs, is)          MOVZBLmr((is), (rs), 0,    0, (d))

#define jit_sti_c(id, rs)               jit_movbrm((rs), (id), 0,    0,    0)
#define jit_stxi_c(id, rd, rs)          jit_movbrm((rs), (id), (rd), 0,    0)

#define jit_ldi_s(d, is)                MOVSWLmr((is), 0,    0,    0, (d))
#define jit_ldxi_s(d, rs, is)           MOVSWLmr((is), (rs), 0,    0, (d))

#define jit_ldi_us(d, is)               MOVZWLmr((is), 0,    0,    0,  (d))
#define jit_ldxi_us(d, rs, is)          MOVZWLmr((is), (rs), 0,    0,  (d))

#define jit_sti_s(id, rs)               MOVWrm(jit_reg16(rs), (id), 0,    0,    0)
#define jit_stxi_s(id, rd, rs)          MOVWrm(jit_reg16(rs), (id), (rd), 0,    0)

#define jit_ldi_i(d, is)                MOVLmr((is), 0,    0,    0,  (d))
#define jit_ldxi_i(d, rs, is)           MOVLmr((is), (rs), 0,    0,  (d))

#define jit_ldr_i(d, rs)                MOVLmr(0,    (rs), 0,    0,  (d))
#define jit_ldxr_i(d, s1, s2)           MOVLmr(0,    (s1), (s2), 1,  (d))
							    
#define jit_sti_i(id, rs)               MOVLrm((rs), (id), 0,    0,    0)
#define jit_stxi_i(id, rd, rs)          MOVLrm((rs), (id), (rd), 0,    0)

#endif /* __lightning_core_h */
