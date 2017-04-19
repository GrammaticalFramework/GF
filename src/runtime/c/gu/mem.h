/** @file
 *
 * Memory allocation tools.
 */

#ifndef GU_MEM_H_
#define GU_MEM_H_

#include <gu/defs.h>
#include <gu/fun.h>

/** @defgroup GuPool Memory pools */
//@{ 


/// A memory pool.
typedef struct GuPool GuPool;

/// @name Creating a pool 
//@{


/// Create a new memory pool.
GU_API_DECL GuPool*
gu_new_pool(void);

/**< 
 * @return A new memory pool.
 */


//@private
GU_API_DECL GuPool*
gu_local_pool_(uint8_t* init_buf, size_t sz);

//@private
#define GU_LOCAL_POOL_INIT_SIZE (16 * sizeof(GuWord))


/// Create a stack-allocated memory pool.
#define gu_local_pool()				\
	gu_local_pool_(gu_alloca(GU_LOCAL_POOL_INIT_SIZE),	\
		       GU_LOCAL_POOL_INIT_SIZE)
/**<
 * @return A memory pool whose first chunk is allocated directly from
 * the stack. This makes its creation faster, and more suitable for
 * functions that usually allocate only a little memory from the pool
 * until it is freed.
 *
 * @note The pool created with #gu_local_pool \e must be freed with
 * #gu_pool_free before the end of the block where #gu_local_pool was
 * called.
 *
 * @note Because #gu_local_pool uses relatively much stack space, it
 * should not be used in the bodies of recursive functions.
 */

/// Create a pool stored in a memory mapped file.
GU_API_DECL GuPool* 
gu_mmap_pool(char* fpath, void* addr, size_t size, void**pptr);

//@}
/// @name Destroying a pool
//@{


/// Free a memory pool and all objects allocated from it.
GU_API_DECL void
gu_pool_free(GU_ONLY GuPool* pool);
/**<
 * When the pool is freed, all finalizers registered by
 * #gu_pool_finally on \p pool are invoked in reverse order of
 * registration.
 * 
 * @note After the pool is freed, all objects allocated from it become
 * invalid and may no longer be used. */

//@}
/// @name Allocating from a pool
//@{
 

/// Allocate memory with a specified alignment.
GU_API_DECL void* 
gu_malloc_aligned(GuPool* pool, size_t size, size_t alignment); 

GU_API_DECL void*
gu_malloc_prefixed(GuPool* pool, size_t pre_align, size_t pre_size,
		   size_t align, size_t size);

/// Allocate memory from a pool.
inline void*
gu_malloc(GuPool* pool, size_t size) {
	return gu_malloc_aligned(pool, size, 0);
}

#include <string.h>

/** Allocate memory to store an array of objects of a given type. */

#define gu_new_n(type, n, pool)						\
	((type*)gu_malloc_aligned((pool),				\
				  sizeof(type) * (n),			\
				  gu_alignof(type)))
/**< 
 * @param type  The C type of the objects to allocate.
 *
 * @param n     The number of objects to allocate.
 * 
 * @param pool  The memory pool to allocate from.
 *
 * @return A pointer to a heap-allocated array of \p n uninitialized
 * objects of type \p type. 
 */ 


/** Allocate memory to store an object of a given type. */

#define gu_new(type, pool) \
	gu_new_n(type, 1, pool)
/**< 
 * @param type  The C type of the object to allocate.
 *
 * @param pool  The memory pool to allocate from.
 *
 * @return A pointer to a heap-allocated uninitialized object of type
 * \p type.
 */


#define gu_new_prefixed(pre_type, type, pool)				\
	((type*)(gu_malloc_prefixed((pool),				\
				    gu_alignof(pre_type), sizeof(pre_type), \
				    gu_alignof(type), sizeof(type))))

// Alas, there's no portable way to get the alignment of flex structs.
#define gu_new_flex(pool_, type_, flex_member_, n_elems_)		\
	((type_ *)gu_malloc_aligned(					\
		(pool_),						\
		GU_FLEX_SIZE(type_, flex_member_, n_elems_),		\
		gu_flex_alignof(type_)))


//@}
/// @name Finalizers
//@{


typedef struct GuFinalizer GuFinalizer;

struct GuFinalizer {
	void (*fn)(GuFinalizer* self);
	///< @param self A pointer to this finalizer.
};

/// Register a finalizer.
GU_API_DECL void gu_pool_finally(GuPool* pool, GuFinalizer* fini);

/**< Register \p fini to be called when \p pool is destroyed. The
 * finalizers are called in reverse order of registration.
 */


//@}
//@}

/** @defgroup GuMemBuf Memory buffers
 *
 * Resizable blocks of heap-allocated memory. These operations differ
 * from standard \c malloc, \c realloc and \c free -functions in that
 * memory buffers are not allocated by exact size. Instead, a minimum
 * size is requested, and the returned buffer may be larger. This
 * gives the memory allocator more flexibility when the client code
 * can make use of larger buffers than requested.
 * */

//@{


/// Allocate a new memory buffer.
GU_API_DECL void*
gu_mem_buf_alloc(size_t min_size, size_t* real_size);
/**<
 * @param min_size The minimum acceptable size for a returned memory block.
 *
 * @param[out] real_size The actual size of the returned memory
 * block. This is never less than \p min_size.
 *
 * @return A pointer to the memory buffer.
 */


/// Allocate a new memory buffer to replace an old one.
GU_API_DECL void*
gu_mem_buf_realloc(
	GU_NULL GU_ONLY GU_RETURNED
	void* buf,
	size_t min_size,
	size_t* real_size_out);


/// Free a memory buffer.
GU_API_DECL void
gu_mem_buf_free(GU_ONLY void* buf);


//@}


#endif // GU_MEM_H_
