#include <gu/mem.h>
#include <gu/fun.h>
#include <gu/bits.h>
#include <gu/assert.h>
#include <string.h>
#include <stdlib.h>
#if !defined(_WIN32) && !defined(_WIN64)
#include <sys/mman.h>
#include <sys/stat.h>
#endif
#if !defined(_MSC_VER)
#include <unistd.h>
#endif
#include <fcntl.h>

#ifdef USE_VALGRIND
#include <valgrind/valgrind.h>
#define VG(X) X
#else
#define VG(X) GU_NOP
#endif

static const size_t
// Maximum request size for a chunk. The actual maximum chunk size
// may be somewhat larger.
    gu_mem_chunk_max_size = 1024 * sizeof(void*),

// number of bytes to allocate in the pool when it is created
	gu_mem_pool_initial_size = 24 * sizeof(void*),

// Pool allocations larger than this will get their own chunk if
// there's no room in the current one. Allocations smaller than this may trigger
// the creation of a new chunk, in which case the remaining space in
// the current chunk is left unused (internal fragmentation).
	gu_mem_max_shared_alloc = 64 * sizeof(void*),
	
// Should not be smaller than the granularity for malloc
	gu_mem_unit_size = 2 * sizeof(void*),

/* Malloc tuning: the additional memory used by malloc next to the
   allocated object */
	gu_malloc_overhead = sizeof(size_t);

static void*
gu_mem_realloc(void* p, size_t size)
{
	void* buf = realloc(p, size);
	if (size != 0 && buf == NULL) {
		gu_fatal("Memory allocation failed");
	}
	return buf;
}

static void*
gu_mem_alloc(size_t size)
{
	void* buf = malloc(size);
	if (buf == NULL) {
		gu_fatal("Memory allocation failed");
	}
	return buf;
}

static void
gu_mem_free(void* p)
{
	free(p);
}

static size_t
gu_mem_padovan(size_t min)
{
	// This could in principle be done faster with Q-matrices for
	// Padovan numbers, but not really worth it for our commonly
	// small numbers.
	if (min <= 5) {
		return min;
	}
	size_t a = 7, b = 9, c = 12;
	while (min > a) {
		if (b < a) {
			// overflow
			return SIZE_MAX;
		}
		size_t tmp = a + b;
		a = b;
		b = c;
		c = tmp;
	}
	return a;
}

GU_API void*
gu_mem_buf_realloc(void* old_buf, size_t min_size, size_t* real_size_out)
{
	size_t min_blocks = ((min_size + gu_malloc_overhead - 1) /
			     gu_mem_unit_size) + 1;
	size_t blocks = gu_mem_padovan(min_blocks);
	size_t size = blocks * gu_mem_unit_size - gu_malloc_overhead;
	void* buf = gu_mem_realloc(old_buf, size);
	*real_size_out = buf ? size : 0;
	return buf;
}

GU_API void*
gu_mem_buf_alloc(size_t min_size, size_t* real_size_out)
{
	return gu_mem_buf_realloc(NULL, min_size, real_size_out);
}

GU_API void
gu_mem_buf_free(void* buf)
{
	gu_mem_free(buf);
}


typedef struct GuMemChunk GuMemChunk;

struct GuMemChunk {
	GuMemChunk* next;
	uint8_t data[];
};

typedef struct GuFinalizerNode GuFinalizerNode;

struct GuFinalizerNode {
	GuFinalizerNode* next;
	GuFinalizer* fin;
};

enum GuPoolType {
	GU_POOL_HEAP,
	GU_POOL_LOCAL,
	GU_POOL_MMAP
};

struct GuPool {
	uint8_t* curr_buf; // actually GuMemChunk*
	GuMemChunk* chunks;
	GuFinalizerNode* finalizers;
	uint16_t type;
	size_t left_edge;
	size_t right_edge;
	size_t curr_size;
	uint8_t init_buf[];
};

static GuPool*
gu_init_pool(uint8_t* buf, size_t sz)
{
	gu_require(gu_aligned((uintptr_t) (void*) buf, gu_alignof(GuPool)));
	gu_require(sz >= sizeof(GuPool));
	GuPool* pool = (GuPool*) buf;
	pool->type = GU_POOL_HEAP;
	pool->curr_size = sz;
	pool->curr_buf = (uint8_t*) pool;
	pool->chunks = NULL;
	pool->finalizers = NULL;
	pool->left_edge = offsetof(GuPool, init_buf);
	pool->right_edge = sz;
	VG(VALGRIND_CREATE_MEMPOOL(pool, 0, false));
	return pool;
}

GU_API GuPool*
gu_local_pool_(uint8_t* buf, size_t sz)
{
	GuPool* pool = gu_init_pool(buf, sz);
	pool->type = GU_POOL_LOCAL;
	return pool;
}

GU_API GuPool* 
gu_new_pool(void)
{
	size_t sz = GU_FLEX_SIZE(GuPool, init_buf, gu_mem_pool_initial_size);
	uint8_t* buf = gu_mem_buf_alloc(sz, &sz);
	GuPool* pool = gu_init_pool(buf, sz);
	return pool;
}

GU_API GuPool* 
gu_mmap_pool(char* fpath, void* addr, size_t size, void**pptr)
{
#if !defined(_WIN32) && !defined(_WIN64)
	int prot = PROT_READ;
	int fd = open(fpath, O_RDONLY);
	if (fd < 0) {
		if (errno == ENOENT) {
			fd = open(fpath, O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
			if (fd < 0)
				return NULL;

			if (ftruncate(fd, size) < 0) {
				close(fd);
				return NULL;
			}

			prot |= PROT_WRITE;
		} else {
			return NULL;
		}
	}

	void *ptr = mmap(addr, size, prot, MAP_SHARED | MAP_FIXED, fd, 0);
	if (ptr == MAP_FAILED) {
		close(fd);
		return NULL;
	}

	gu_require(ptr == addr);

	*pptr = (prot & PROT_WRITE) ? NULL : ptr;

	size_t sz = GU_FLEX_SIZE(GuPool, init_buf, sizeof(int));
	uint8_t* buf = gu_mem_buf_alloc(sz, &sz);
	GuPool* pool = gu_init_pool(buf, size);

	uint8_t* pfd = pool->init_buf;
	*((int*) pfd) = fd;

	pool->type = GU_POOL_MMAP;
	pool->curr_buf = ptr;
	pool->left_edge = 0;

	return pool;
#else
	return NULL;
#endif
}

static void
gu_pool_expand(GuPool* pool, size_t req)
{
	gu_require(pool->type != GU_POOL_MMAP);
	size_t real_req = GU_MAX(req, GU_MIN(((size_t)pool->curr_size) + 1,
					     gu_mem_chunk_max_size));
	gu_assert(real_req >= sizeof(GuMemChunk));
	size_t size = 0;
	GuMemChunk* chunk = gu_mem_buf_alloc(real_req, &size);
	chunk->next = pool->chunks;
	pool->chunks = chunk;
	pool->curr_buf = (uint8_t*) chunk;
	pool->left_edge = offsetof(GuMemChunk, data);
	pool->right_edge = pool->curr_size = size;
	gu_assert((size_t) pool->right_edge == size); 
}

static size_t
gu_mem_advance(size_t old_pos, size_t pre_align, size_t pre_size,
	       size_t align, size_t size)
{
	size_t p = gu_align_forward(old_pos, pre_align);
	p += pre_size;
	p = gu_align_forward(p, align);
	p += size;
	return p;
}

static void*
gu_pool_malloc_aligned(GuPool* pool, size_t pre_align, size_t pre_size,
		       size_t align, size_t size) 
{
	size_t pos = gu_mem_advance(pool->left_edge, pre_align, pre_size,
				    align, size);
	if (pos > (size_t) pool->right_edge) {
		pos = gu_mem_advance(offsetof(GuMemChunk, data),
				     pre_align, pre_size, align, size);
		gu_pool_expand(pool, pos);
		gu_assert(pos <= pool->right_edge);
	}
	pool->left_edge = pos;
	uint8_t* addr = &pool->curr_buf[pos - size];
	VG(VALGRIND_MEMPOOL_ALLOC(pool, addr - pre_size, size + pre_size ));
	return addr;
}

static size_t
gu_pool_avail(GuPool* pool)
{
	return (size_t) pool->right_edge - (size_t) pool->left_edge;
}

GU_API void*
gu_pool_malloc_unaligned(GuPool* pool, size_t size)
{
	if (size > gu_pool_avail(pool)) {
		gu_pool_expand(pool, offsetof(GuMemChunk, data) + size);
		gu_assert(size <= gu_pool_avail(pool));
	}
	pool->right_edge -= size;
	void* addr = &pool->curr_buf[pool->right_edge];
	VG(VALGRIND_MEMPOOL_ALLOC(pool, addr, size));
	return addr;
}

GU_API void*
gu_malloc_prefixed(GuPool* pool, size_t pre_align, size_t pre_size,
		   size_t align, size_t size)
{
	void* ret = NULL;
	if (pre_align == 0) {
		pre_align = gu_alignof(GuMaxAlign);
	}
	if (align == 0) {
		align = gu_alignof(GuMaxAlign);
	}
	size_t full_size = gu_mem_advance(offsetof(GuMemChunk, data),
					  pre_align, pre_size, align, size);
	if (full_size > gu_mem_max_shared_alloc &&
	    pool->type != GU_POOL_MMAP) {
		GuMemChunk* chunk = gu_mem_alloc(full_size);
		chunk->next = pool->chunks;
		pool->chunks = chunk;
		uint8_t* addr = &chunk->data[full_size - size
					     - offsetof(GuMemChunk, data)];
		VG(VALGRIND_MEMPOOL_ALLOC(pool, addr - pre_size,
					  pre_size + size));
		ret = addr;
	} else if (pre_align == 1 && align == 1) {
		uint8_t* buf = gu_pool_malloc_unaligned(pool, pre_size + size);
		ret = &buf[pre_size];
	} else {
		ret = gu_pool_malloc_aligned(pool, pre_align, pre_size,
					     align, size);
	}
	return ret;
}

GU_API void*
gu_malloc_aligned(GuPool* pool, size_t size, size_t align)
{
	return gu_malloc_prefixed(pool, 1, 0, align, size);
}

GU_API void 
gu_pool_finally(GuPool* pool, GuFinalizer* finalizer)
{
	gu_require(pool->type != GU_POOL_MMAP);
	GuFinalizerNode* node = gu_new(GuFinalizerNode, pool);
	node->next = pool->finalizers;
	node->fin = finalizer;
	pool->finalizers = node;
}

GU_API void
gu_pool_free(GuPool* pool)
{
	GuFinalizerNode* node = pool->finalizers;
	while (node) {
		node->fin->fn(node->fin);
		node = node->next;
	}
	GuMemChunk* chunk = pool->chunks;
	while (chunk) {
		GuMemChunk* next = chunk->next;
		gu_mem_buf_free(chunk);
		chunk = next;
	}
	VG(VALGRIND_DESTROY_MEMPOOL(pool));
	if (pool->type == GU_POOL_HEAP) {
		gu_mem_buf_free(pool);
	} else if (pool->type == GU_POOL_MMAP) {
#if !defined(_WIN32) && !defined(_WIN64)
		uint8_t* pfd = pool->init_buf;
		int fd = *(pfd);

		munmap(pool->curr_buf, pool->curr_size);
		close(fd);
#endif
	}
}


extern inline void* gu_malloc(GuPool* pool, size_t size);
