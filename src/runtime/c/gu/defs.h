/* 
 * Copyright 2010 University of Helsinki.
 *   
 * This file is part of libgu.
 * 
 * Libgu is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 * 
 * Libgu is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
 * License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with libgu. If not, see <http://www.gnu.org/licenses/>.
 */

/** @file
 *
 * Miscellaneous macros.
 */

#ifndef GU_DEFS_H_
#define GU_DEFS_H_

// MSVC requires explicit export/import of
// symbols in DLLs. CMake takes care of this
// for functions, but not for data/variables.
#if defined(_MSC_VER)
#if defined(COMPILING_GU)
#define GU_API_DATA_DECL __declspec(dllexport)
#define GU_API_DATA __declspec(dllexport)
#else
#define GU_API_DATA_DECL __declspec(dllimport)
#define GU_API_DATA ERROR_NOT_COMPILING_LIBGU
#endif

#else
#define GU_API_DATA_DECL extern
#define GU_API_DATA
#endif
// end MSVC workaround

#include <stddef.h>
#include <inttypes.h>
#include <stdbool.h>
#include <assert.h>
#include <limits.h>
#include <stdarg.h>
#include <gu/sysdeps.h>

#define gu_container(mem_p, container_type, member) \
	((container_type*)(((uint8_t*) (mem_p)) - offsetof(container_type, member)))
/**< Find the address of a containing structure.
 *
 * If @c s has type @c t*, where @c t is a struct or union type with a
 * member @m, then <tt>GU_CONTAINER_P(&s->m, t, m) == s</tt>.
 * 
 * @param mem_p           Pointer to the member of a structure.
 * @param container_type  The type of the containing structure.
 * @param member          The name of the member of @a container_type
 * @return  The address of the containing structure.
 *
 * @hideinitializer */


#define gu_member_p(struct_p_, offset_)		\
	((void*)&((uint8_t*)(struct_p_))[offset_])

#define gu_member(t_, struct_p_, offset_) \
	(*(t_*)gu_member_p(struct_p_, offset_))

#ifdef GU_ALIGNOF
# define gu_alignof GU_ALIGNOF
#else
# define gu_alignof(t_) \
	((size_t)(offsetof(struct { char c_; t_ e_; }, e_)))
#endif

#define GU_PLIT(type, expr) \
	((type[1]){ expr })

#define GU_LVALUE(type, expr) \
	(*((type[1]){ expr }))

#define GU_COMMA ,

#define GU_ARRAY_LEN(t,a) (sizeof((const t[])a) / sizeof(t))

#define GU_ID(...) __VA_ARGS__

// This trick is by Laurent Deniau <laurent.deniau@cern.ch>
#define GU_N_ARGS(...)				\
	GU_N_ARGS_(__VA_ARGS__,						\
		   31,30,29,28,27,26,25,24,				\
		   23,22,21,20,19,18,17,16,				\
		   15,14,13,12,11,10,9,8,				\
		   7,6,5,4,3,2,1,0)					
#define GU_N_ARGS_(...) GU_N_ARGS__(__VA_ARGS__)
#define GU_N_ARGS__(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,			\
		    q,r,s,t,u,v,w,x,y,z,aa,ab,ac,ad,ae,N,...)		\
	N

#define GU_ARG1(a1, ...) a1
#define GU_ARG2(a1, a2, ...) a2

#define GU_BEGIN do {
#define GU_END } while (false)

#define GU_NOP GU_BEGIN (void) 0; GU_END

/**< @hideinitializer */

//
// Assert
//

#define GU_MAX(a_, b_) ((a_) > (b_) ? (a_) : (b_))
#define GU_MIN(a_, b_) ((a_) < (b_) ? (a_) : (b_))

static inline int
gu_max(int a, int b) {
	return GU_MAX(a, b);
}

static inline int
gu_min(int a, int b) {
	return GU_MIN(a, b);
}

#ifdef GU_ALIGNOF
#define gu_flex_alignof gu_alignof
#else
#define gu_flex_alignof(t) 0
#endif

static inline size_t
gu_flex_size(size_t ssize, size_t offset, int n_elems, size_t e_size)
{
	return GU_MAX(ssize, offset + n_elems * e_size);
}

#define GU_FLEX_SIZE(type, flex_member, n_elems)			\
	gu_flex_size(sizeof(type), offsetof(type, flex_member),		\
		     n_elems, sizeof(((type*)NULL)->flex_member[0]))


// The following are directly from gmacros.h in GLib

#define GU_PASTE_ARGS(id1_,id2_)	\
	id1_ ## id2_

#define GU_PASTE(id1_, id2_)			\
	GU_PASTE_ARGS(id1_, id2_)

#define GU_STATIC_ASSERT(expr_)						\
	typedef struct {						\
		char static_assert[(expr_) ? 1 : -1];			\
	} GU_PASTE(GuStaticAssert_, __LINE__)


#define GU_ENSURE_TYPE(T, EXPR)			\
	((void)(sizeof(*(T*)NULL=(EXPR))),(EXPR))

#define GU_END_DECLS \
	extern void gu_dummy_(void)

extern void* const gu_null;

// Dummy struct used for generic struct pointers
typedef struct GuStruct GuStruct;

GU_API_DATA_DECL GuStruct* const gu_null_struct;

typedef uintptr_t GuWord;

#define GU_WORD_MAX UINTPTR_MAX

// TODO: use max_align_t once C1X is supported
typedef union {
	char c;
	short s;
	int i;
	long l;
	long long ll;
	intmax_t im;
	float f;
	double d;
	long double ld;
	void* p;
	void (*fp)();
} GuMaxAlign;

#define gu_alloca(N)				\
	(((union { GuMaxAlign align_; uint8_t buf_[N]; }){{0}}).buf_)


// For Doxygen
#define GU_PRIVATE /** @private */

#ifdef GU_GNUC
# define GU_LIKELY(EXPR) __builtin_expect(EXPR, 1)
# define GU_UNLIKELY(EXPR) __builtin_expect(EXPR, 0)
# define GU_IS_CONSTANT(EXPR) __builtin_constant_p(EXPR)
#else
# define GU_LIKELY(EXPR) (EXPR)
# define GU_UNLIKELY(EXPR) (EXPR)
# ifdef GU_OPTIMIZE_SIZE
#  define GU_IS_CONSTANT(EXPR) false
# else
#  define GU_IS_CONSTANT(EXPR) true
# endif
#endif

// Splint annotations
#define GU_ONLY GU_SPLINT(only)
#define GU_NULL GU_SPLINT(null)
#define GU_NOTNULL GU_SPLINT(notnull) 
#define GU_RETURNED GU_SPLINT(returned)
#define GU_ABSTRACT GU_SPLINT(abstract)
#define GU_IMMUTABLE GU_SPLINT(immutable)
#define GU_NOTREACHED GU_SPLINT(notreached)
#define GU_UNUSED GU_SPLINT(unused) GU_GNUC_ATTR(unused)
#define GU_OUT GU_SPLINT(out)
#define GU_IN GU_SPLINT(in)
#define GU_NORETURN GU_SPLINT(noreturn) GU_GNUC_ATTR(noreturn)
#define GU_MODIFIES(x) GU_SPLINT(modifies x)

#endif // GU_DEFS_H_
