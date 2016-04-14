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
