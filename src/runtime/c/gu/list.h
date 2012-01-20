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
 * Lists.
 */

#ifndef GU_LIST_H_
#define GU_LIST_H_

#include <gu/mem.h>


#define GuList(t)	   \
	struct {	   \
		const int len;  \
		t elems[]; \
	}

void* gu_list_alloc(GuPool* pool, size_t base_size, size_t elem_size, 
		    int n_elems, size_t alignment);

#define gu_new_list(t, pool, n)						\
	((t*) gu_list_alloc(pool,					\
			    sizeof(t),					\
			    sizeof(((t*)NULL)->elems[0]),		\
			    (n),					\
			    gu_flex_alignof(t)))

static inline int
gu_list_length(const void* list)
{
	return *(const int*) list;
}

#define gu_list_elems(lst) \
	((lst)->elems)

#define gu_list_index(lst, i) \
	(gu_list_elems(lst)[i])

typedef GuList(void*) GuPointers; 
//typedef GuList(uint8_t) GuBytes;

typedef GuList(int) GuInts;		      


#define GuListN(t_, len_)			\
	struct {				\
	int len;				\
	t elems[len_];				\
	}

#define gu_list_(qual_, t_, ...)			\
	((qual_ GuList(t_) *)				\
	((qual_ GuListN(t_, (sizeof((t_[]){__VA_ARGS__}) / sizeof(t_)))[]){ \
	__VA_ARGS__							\
	}))

#define gu_list(t_, ...)			\
	gu_list_(, t_, __VA_ARGS__)

#define gu_clist(t_, ...)			\
	gu_list_(const, t_, __VA_ARGS__)
			
#define GuSList(t)				\
	const struct {				\
		int len;			\
		t* elems;			\
	}

#define GU_SLIST_0 { .len = 0, .elems = NULL }

#define GU_SLIST(t, ...)						\
	{								\
		.len = GU_ARRAY_LEN(t,GU_ID({__VA_ARGS__})),		\
		.elems = ((t[]){__VA_ARGS__})			\
	}


#include <gu/type.h>

//
// list
//

typedef const struct GuListType GuListType, GuType_GuList;

struct GuListType {
	GuType_abstract abstract_base;
	size_t size;
	size_t align;
	GuType* elem_type;
	ptrdiff_t elems_offset;
};

#define GU_TYPE_INIT_GuList(k_, t_, elem_type_) {	\
	.abstract_base = GU_TYPE_INIT_abstract(k_, t_, _),	\
	.size = sizeof(t_), \
	.align = gu_alignof(t_),		\
	.elem_type = elem_type_,	\
	.elems_offset = offsetof(t_, elems)	\
}

extern GU_DECLARE_KIND(GuList);

void*
gu_list_type_alloc(GuListType* ltype, int n_elems, GuPool* pool);

void*
gu_list_type_index(GuListType* ltype, void* list, int i);

#include <gu/str.h>


typedef GuList(GuStr) GuStrs;
typedef GuStrs* GuStrsP;
		       
extern GU_DECLARE_TYPE(GuStrs, GuList);
extern GU_DECLARE_TYPE(GuStrsP, pointer);


#endif // GU_LIST_H_
