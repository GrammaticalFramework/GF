/******************************** -*- C -*- ****************************
 *
 *	Run-time assembler for the i386
 *
 ***********************************************************************/


/***********************************************************************
 *
 * Copyright 2003 Gwenole Beauchesne
 * Copyright 2006 Free Software Foundation, Inc.
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




#ifndef __lightning_asm_h
#define __lightning_asm_h

#ifndef LIGHTNING_DEBUG

/*	OPCODE	+ i		= immediate operand
 *		+ r		= register operand
 *		+ m		= memory operand (disp,base,index,scale)
 *		+ sr/sm		= a star preceding a register or memory
 */

#if !_ASM_SAFETY
#  define _r1(R)		_rN(R)
#  define _r2(R)		_rN(R)
#  define _r4(R)		_rN(R)
#  define _r8(R)		_rN(R)
#  define _rM(R)		_rN(R)
#  define _rX(R)		_rN(R)
#else
/* _r1() used to check only for _AL and _AH but there is
 * usage of _CL and _DL when _*AX is already an operand */
#  define _r1(R)							\
    /* Valid 32 bit register? */					\
    ((!((R) & ~0x77)							\
	/* 32, 16 or 8 bit register? */					\
	&& (((_rC(R) == 0x40 || _rC(R) == 0x30 || _rC(R) == 0x10)	\
	    /* Yes. Register is _AL, _CL or _DL? */			\
	    && (   (_rN(R) | 0x10) == _AL				\
		|| (_rN(R) | 0x10) == _CL				\
		|| (_rN(R) | 0x10) == _DL))				\
	    /* No. Register is _AH? */					\
	|| ((_rC(R) == 0x20 && (_rN(R) | 0x20) == _AH))))		\
	? _rN(R) : JITFAIL("bad 8-bit register " #R))
#  define _r2(R)							\
    /* Valid 32 bit register? */					\
    ((!((R) & ~0x77)							\
	/* 32, 16 or 8 bit register? */					\
	&& (_rC(R) == 0x40 || _rC(R) == 0x30 || _rC(R) == 0x10))	\
	? _rN(R) : JITFAIL("bad 16-bit register " #R))
#  define _r4(R)							\
    /* Valid 32 bit register? */					\
    ((!((R) & ~0x77)							\
	/* 32, 16 or 8 bit register? */					\
	&& (_rC(R) == 0x40 || _rC(R) == 0x30 || _rC(R) == 0x10))	\
	? _rN(R) : JITFAIL("bad 32-bit register " #R))
#  define _r8(R)							\
	JITFAIL("bad 64-bit register " #R)
#  define _rM(R)							\
    /* Valid MMX register? */						\
    ((!((R) & ~0x67) && _rC(R) == 0x60)					\
	? _rN(R) : JITFAIL("bad MMX register " #R))
#  define _rX(R)							\
    /* Valid SSE register? */						\
    ((!((R) & ~0x77) && _rC(R) == 0x70)					\
	? _rN(R) : JITFAIL("bad SSE register " #R))
#endif

#define _rA(R)			_r4(R)

#define jit_check8(rs)		((_rN(rs) | _AL) == _AL)
#define jit_reg8(rs)							\
    ((jit_reg16(rs) == _SI || jit_reg16(rs) == _DI)			\
	? _AL : (_rN(rs) | _AL))
#define jit_reg16(rs)		(_rN(rs) | _AX)

/* Use RIP-addressing in 64-bit mode, if possible */
#define _r_X(   R, D,B,I,S,O)	(_r0P(I) ? (_r0P(B)    ? _r_D   (R,D                ) : \
				           (_rsp12P(B) ? _r_DBIS(R,D,_ESP,_ESP,1)   : \
						         _r_DB  (R,D,     B       )))  : \
				 (_r0P(B)	       ? _r_4IS (R,D,	         I,S)   : \
				 (!_rspP(I)            ? _r_DBIS(R,D,     B,     I,S)   : \
						         JITFAIL("illegal index register: %esp"))))
#define _m32only(X)		(X)
#define _m64only(X)		JITFAIL("invalid instruction in 32-bit mode")
#define _m64(X)			((void)0)

#define _AH		0x24
#define _CH		0x25
#define _DH		0x26
#define _BH		0x27

#define CALLsr(R)			CALLLsr(R)
#define JMPsr(R)			JMPLsr(R)

#define DECWr(RD)	(_d16(),	_Or		(0x48,_r2(RD)							))
#define DECLr(RD)		 	_Or		(0x48,_r4(RD)							)
#define INCWr(RD)	(_d16(),	_Or		(0x40,_r2(RD)							))
#define INCLr(RD)	 		_Or		(0x40,_r4(RD)							)

#endif
#endif /* __lightning_asm_h */
