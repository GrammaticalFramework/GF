/******************************** -*- C -*- ****************************
 *
 *	Run-time assembler for the arm
 *
 ***********************************************************************/

/***********************************************************************
 *
 * Copyright 2011 Free Software Foundation
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
 * Free Software Foundation, 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 *
 * Authors:
 *	Paulo Cesar Pereira de Andrade
 ***********************************************************************/

#ifndef __lightning_funcs_h
#define __lightning_funcs_h

#if defined(__linux__)
#  include <stdio.h>
#  include <string.h>
#endif

#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

#if defined(ios_HOST_OS) || defined (darwin_HOST_OS)
extern void sys_icache_invalidate(void *start, size_t len);

static void
jit_flush_code(void *start, void *end)
{
    mprotect(start, (char *)end - (char *)start,
	     PROT_READ | PROT_WRITE | PROT_EXEC);
    sys_icache_invalidate(start, (char *)end-(char *)start);
}
#else
extern void __clear_cache(void*, void*);

static void
jit_flush_code(void *start, void *end)
{
    mprotect(start, (char *)end - (char *)start,
	     PROT_READ | PROT_WRITE | PROT_EXEC);
    __clear_cache(start, end);
}
#endif

__attribute__((constructor)) static void
jit_get_cpu(void)
{
#if defined(__linux__)
    FILE	*fp;
    char	*ptr;
    char	 buf[128];
    static int	 initialized;

    if (initialized)
	return;
    initialized = 1;
    if ((fp = fopen("/proc/cpuinfo", "r")) == NULL)
	return;

    while (fgets(buf, sizeof(buf), fp)) {
	if (strncmp(buf, "CPU architecture:", 17) == 0) {
	    jit_cpu.version = strtol(buf + 17, &ptr, 10);
	    while (*ptr) {
		if (*ptr == 'T' || *ptr == 't') {
		    ++ptr;
		    jit_cpu.thumb = 1;
		}
		else if (*ptr == 'E' || *ptr == 'e') {
		    jit_cpu.extend = 1;
		    ++ptr;
		}
		else
		    ++ptr;
	    }
	}
	else if (strncmp(buf, "Features\t:", 10) == 0) {
	    if ((ptr = strstr(buf + 10, "vfpv")))
		jit_cpu.vfp = strtol(ptr + 4, NULL, 0);
	    if ((ptr = strstr(buf + 10, "neon")))
		jit_cpu.neon = 1;
	    if ((ptr = strstr(buf + 10, "thumb")))
		jit_cpu.thumb = 1;
	}
    }
    fclose(fp);
#endif
#if defined(__ARM_PCS_VFP)
    if (!jit_cpu.vfp)
	jit_cpu.vfp = 3;
    if (!jit_cpu.version)
	jit_cpu.version = 7;
    jit_cpu.abi = 1;
#endif
    /* armv6t2 todo (software float and thumb2) */
    if (!jit_cpu.vfp && jit_cpu.thumb)
	jit_cpu.thumb = 0;
}

static void
arm_patch_arguments(struct jit_local_state* jitl)
{	
    int		 reg;
    int		 ioff;
    int		 foff;
    int		 size;
    int		 index;
    jit_thumb_t	 thumb;
    int		 offset;
    union {
	_ui	*i;
	_us	*s;
    } u;

    ioff = foff = 0;
    for (index = jitl->nextarg_put - 1, offset = 0; index >= 0; index--) {
		if (jitl->types[index >> 5] & (1 << (index & 31)))
			size = sizeof(double);
		else
			size = sizeof(int);
		u.i = jitl->arguments[index];
#ifdef USE_THUMB_CODE
		code2thumb(thumb.s[0], thumb.s[1], u.s[0], u.s[1]);
		switch (thumb.i & 0xfff00f00) {
		case ARM_CC_AL|ARM_VSTR|ARM_P:
			if (jit_hardfp_p()) {
			if (foff < 16) {
				reg = (thumb.i >> 12) & 0xf;
				thumb.i = (ARM_CC_AL|ARM_VMOV_F |
					   ((foff >> 1) << 12) | reg);
				if (foff & 1)
				thumb.i |= ARM_V_D;
				thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]);
				++foff;
				continue;
			}
			}
			else {
			if (ioff < 4) {
				thumb.i = ((thumb.i & 0xfff0ff00) |
					   (JIT_FP << 16) | ioff);
				thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]);
				++ioff;
				continue;
			}
			}
			thumb.i = (thumb.i & 0xffffff00) | (offset >> 2);
			thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]);
			break;
		case ARM_CC_AL|ARM_VSTR|ARM_V_F64|ARM_P:
			if (jit_hardfp_p()) {
			if (foff & 1)
				++foff;
			if (foff < 16) {
				reg = (thumb.i >> 12) & 0xf;
				thumb.i = (ARM_CC_AL|ARM_VMOV_F|ARM_V_F64 |
					   ((foff >> 1) << 12) | reg);
				thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]);
				foff += 2;
				continue;
			}
			}
			else {
			if (ioff & 1)
				++ioff;
			if (ioff < 4) {
				thumb.i = ((thumb.i & 0xfff0ff00) |
					   (JIT_FP << 16) | ioff);
				thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]);
				ioff += 2;
				continue;
			}
			}
			if (offset & 7)
			offset += sizeof(int);
			thumb.i = (thumb.i & 0xffffff00) | (offset >> 2);
			thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]);
			break;
		case THUMB2_STRWI:
		thumb_stri:
			if (size == 8 && (ioff & 1))
			++ioff;
			if (ioff < 4) {
			thumb.i = ((thumb.i & 0xfff0f000) |
				   (JIT_FP << 16) | (ioff << 2));
			thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]);
			++ioff;
			if (size == 8) {
				code2thumb(thumb.s[0], thumb.s[1], u.s[2], u.s[3]);
				thumb.i = ((thumb.i & 0xfff0f000) |
					   (JIT_FP << 16) | (ioff << 2));
				thumb2code(thumb.s[0], thumb.s[1], u.s[2], u.s[3]);
				++ioff;
			}
			continue;
			}
			if (size == 8 && (offset & 7))
			offset += sizeof(int);
			thumb.i = (thumb.i & 0xfffff000) | offset;
			thumb2code(thumb.s[0], thumb.s[1], u.s[0], u.s[1]);
			if (size == 8) {
			code2thumb(thumb.s[0], thumb.s[1], u.s[2], u.s[3]);
			thumb.i = (thumb.i & 0xfffff000) | (offset + 4);
			thumb2code(thumb.s[0], thumb.s[1], u.s[2], u.s[3]);
			}
			break;
		default:
			/* offset too large */
			if ((thumb.i & 0xfff00000) == THUMB2_STRWI)
			goto thumb_stri;
			abort();
		}
#else
		switch (u.i[0] & 0xfff00f00) {
		case ARM_CC_AL|ARM_VSTR|ARM_P:
			if (jit_hardfp_p()) {
			if (foff < 16) {
				reg = (u.i[0] >> 12) & 0xf;
				u.i[0] = (ARM_CC_AL|ARM_VMOV_F |
					  ((foff >> 1) << 12) | reg);
				if (foff & 1)
				u.i[0] |= ARM_V_D;
				++foff;
				continue;
			}
			}
			else {
			if (ioff < 4) {
				u.i[0] = ((u.i[0] & 0xfff0ff00) |
					  (JIT_FP << 16) | ioff);
				++ioff;
				continue;
			}
			}
			u.i[0] = (u.i[0] & 0xffffff00) | (offset >> 2);
			break;
		case ARM_CC_AL|ARM_VSTR|ARM_V_F64|ARM_P:
			if (jit_hardfp_p()) {
			if (foff & 1)
				++foff;
			if (foff < 16) {
				reg = (u.i[0] >> 12) & 0xf;
				u.i[0] = (ARM_CC_AL|ARM_VMOV_F|ARM_V_F64 |
					  ((foff >> 1) << 12) | reg);
				foff += 2;
				continue;
			}
			}
			else {
			if (ioff & 1)
				++ioff;
			if (ioff < 4) {
				u.i[0] = ((u.i[0] & 0xfff0ff00) |
					  (JIT_FP << 16) | ioff);
				ioff += 2;
				continue;
			}
			}
			if (offset & 7)
			offset += sizeof(int);
			u.i[0] = (u.i[0] & 0xffffff00) | (offset >> 2);
			break;
		case ARM_CC_AL|ARM_STRI|ARM_P:
		arm_stri:
			if (size == 8 && (ioff & 1))
			++ioff;
			if (ioff < 4) {
			u.i[0] = ((u.i[0] & 0xfff0f000) |
				  (JIT_FP << 16) | (ioff << 2));
			++ioff;
			if (size == 8) {
				u.i[1] = ((u.i[1] & 0xfff0f000) |
					  (JIT_FP << 16) | (ioff << 2));
				++ioff;
			}
			continue;
			}
			if (size == 8 && (offset & 7))
			offset += sizeof(int);
			u.i[0] = (u.i[0] & 0xfffff000) | offset;
			if (size == 8)
			u.i[1] = (u.i[1] & 0xfffff000) | (offset + 4);
			break;
		default:
			/* offset too large */
			if ((u.i[0] & 0xfff00000) == (ARM_CC_AL|ARM_STRI|ARM_P))
			goto arm_stri;
			abort();
		}
#endif
		offset += size;
    }

    jitl->reglist = ((1 << ioff) - 1) & 0xf;
    if (jitl->stack_length < offset) {
		jitl->stack_length = offset;
		jit_patch_movi(jitl->stack, (void *)
		               ((jitl->alloca_offset + jitl->stack_length + 7) & -8));
    }
}

extern int	__aeabi_idivmod(int, int);
extern unsigned	__aeabi_uidivmod(unsigned, unsigned);

#pragma push_macro("_jit")
#ifdef _jit
#undef _jit
#endif
#define _jit (*jit)
static void
arm_divmod(jit_state* jit, int div, int sign,
           jit_gpr_t r0, jit_gpr_t r1, jit_gpr_t r2)
{
    int d;
    int l;
    void *p;
    l = 0xf;
    if ((int)r0 < 4)
		/* bogus extra push to align at 8 bytes */
		l = (l & ~(1 << r0)) | 0x10;
#ifdef USE_THUMB_CODE
	T1_PUSH(l);
#else
	_PUSH(l);
#endif
    if (r1 == _R1 && r2 == _R0) {
		jit_movr_i(JIT_FTMP, _R0);
		jit_movr_i(_R0, _R1);
		jit_movr_i(_R1, JIT_FTMP);
    } else if (r2 == _R0) {
		jit_movr_i(_R1, r2);
		jit_movr_i(_R0, r1);
    } else {
		jit_movr_i(_R0, r1);
		jit_movr_i(_R1, r2);
    }
	p = (sign) ? (void*) __aeabi_idivmod : (void*) __aeabi_uidivmod;
    if (!jit_exchange_p()) {
#ifdef USE_THUMB_CODE
	    d = (((int)p - (int)_jit.x.pc) >> 1) - 2;
#else
	    d = (((int)p - (int)_jit.x.pc) >> 2) - 2;
#endif
		if (_s24P(d)) {
#ifdef USE_THUMB_CODE
			T2_BLI(encode_thumb_jump(d));
#else
			_BLI(d & 0x00ffffff);
#endif
		}
		else
			goto fallback;
    } else {
fallback:
		jit_movi_i(JIT_FTMP, (int)p);
#ifdef USE_THUMB_CODE
		T1_BLX(JIT_FTMP);
#else
		_BLX(JIT_FTMP);
#endif
    }
    if (div) {
		jit_movr_i(r0, _R0);
    } else {
		jit_movr_i(r0, _R1);
	}
#ifdef USE_THUMB_CODE
	T1_POP(l);
#else
	_POP(l);
#endif
}
#pragma pop_macro("_jit")

#endif /* __lightning_funcs_h */
