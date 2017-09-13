#ifndef GU_BITS_H_
#define GU_BITS_H_

#include <gu/defs.h>
#include <gu/assert.h>


#define GU_WORD_BITS (sizeof(GuWord) * CHAR_BIT)


/*
 * Based on the Bit Twiddling Hacks collection by Sean Eron Anderson
 * <http://graphics.stanford.edu/~seander/bithacks.html>
 */

GU_INTERNAL_DECL
unsigned gu_ceil2e(unsigned i);

static inline int
gu_sign(int i) {
	return (i > 0) - (i < 0);
}

static inline size_t
gu_ceildiv(size_t size, size_t div)
{
	return (size + div - 1) / div;
}

static inline bool
gu_aligned(uintptr_t addr, size_t alignment)
{
	//gu_require(alignment == gu_ceil2e(alignment));
	return (addr & (alignment - 1)) == 0;
}

static inline uintptr_t
gu_align_forward(uintptr_t addr, size_t alignment) {
	//gu_require(alignment == gu_ceil2e(alignment));
	uintptr_t mask = alignment - 1;
	return (addr + mask) & ~mask;
}

static inline uintptr_t
gu_align_backward(uintptr_t addr, size_t alignment) {
	//gu_require(alignment == gu_ceil2e(alignment));
	return addr & ~(alignment - 1);
}

static inline bool
gu_bits_test(const GuWord* bitmap, int idx) {
	return !!(bitmap[idx / GU_WORD_BITS] & 1 << (idx % GU_WORD_BITS));
}

static inline void
gu_bits_set(GuWord* bitmap, int idx) {
	bitmap[idx / GU_WORD_BITS] |= ((GuWord) 1) << (idx % GU_WORD_BITS);
}

static inline void
gu_bits_clear(GuWord* bitmap, int idx) {
	bitmap[idx / GU_WORD_BITS] &= ~(((GuWord) 1) << (idx % GU_WORD_BITS));
}

static inline size_t
gu_bits_size(size_t n_bits) {
	return gu_ceildiv(n_bits, GU_WORD_BITS) * sizeof(GuWord);
}

static inline void*
gu_word_ptr(GuWord w)
{
	return (void*) w;
}

static inline GuWord
gu_ptr_word(void* p)
{
	return (GuWord) p;
}

#define GuOpaque() struct { GuWord w_; }

typedef GuWord GuTagged;

#define GU_TAG_MAX (sizeof(GuWord) - 1)

static inline size_t
gu_tagged_tag(GuTagged t) {
	return (int) (t & (sizeof(GuWord) - 1));
}

static inline void*
gu_tagged_ptr(GuTagged w) {
	return (void*) gu_align_backward(w, sizeof(GuWord));
}

static inline GuTagged
gu_tagged(void* ptr, size_t tag) {
	gu_require(tag < sizeof(GuWord));
	uintptr_t u = (uintptr_t) ptr;
	gu_require(gu_align_backward(u, sizeof(GuWord)) == u);
	return (GuWord) { u | tag };
}

#include <gu/exn.h>

#define GU_DECODE_2C_(u_, t_, umax_, posmax_, tmin_, err_)	\
	(((u_) <= (posmax_))					\
	 ? (t_) (u_)						\
	 : (tmin_) + ((t_) ((umax_) - (u_))) < 0		\
	 ? (t_) (-1 - ((t_) ((umax_) - (u_))))				\
	 : (t_) (gu_raise(err_, GuIntDecodeExn), -1))


static inline int8_t
gu_decode_2c8(uint8_t u, GuExn* err)
{
	return GU_DECODE_2C_(u, int8_t, UINT8_C(0xff), 
			     UINT8_C(0x7f), INT8_MIN, err);
}

static inline int16_t
gu_decode_2c16(uint16_t u, GuExn* err)
{
	return GU_DECODE_2C_(u, int16_t, UINT16_C(0xffff), 
			     UINT16_C(0x7fff), INT16_MIN, err);
}

static inline int32_t
gu_decode_2c32(uint32_t u, GuExn* err)
{
	return GU_DECODE_2C_(u, int32_t, UINT32_C(0xffffffff), 
			     UINT32_C(0x7fffffff), INT32_MIN, err);
}

static inline int64_t
gu_decode_2c64(uint64_t u, GuExn* err)
{
	return GU_DECODE_2C_(u, int64_t, UINT64_C(0xffffffffffffffff), 
			     UINT64_C(0x7fffffffffffffff), INT64_MIN, err);
}

GU_INTERNAL_DECL double
gu_decode_double(uint64_t u);

GU_INTERNAL_DECL uint64_t
gu_encode_double(double d);

#endif // GU_BITS_H_
