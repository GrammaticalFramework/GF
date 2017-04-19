#ifndef GU_OUT_H_
#define GU_OUT_H_

#include <gu/defs.h>
#include <gu/assert.h>
#include <gu/exn.h>
#include <gu/ucs.h>

typedef struct GuOut GuOut;

typedef struct GuOutStream GuOutStream;

struct GuOutStream {
	uint8_t* (*begin_buf)(GuOutStream* self, size_t req, size_t* sz_out,
			      GuExn* err);
	void (*end_buf)(GuOutStream* self, size_t span, GuExn* err);
	size_t (*output)(GuOutStream* self, const uint8_t* buf, size_t size,
			 GuExn* err);
	void (*flush)(GuOutStream* self, GuExn* err);
};


struct GuOut {
	uint8_t* restrict buf_end;
	ptrdiff_t buf_curr;
	size_t buf_size;
	GuOutStream* stream;
	GuFinalizer fini;
};

GU_API_DECL GuOut*
gu_new_out(GuOutStream* stream, GuPool* pool);

inline bool
gu_out_is_buffered(GuOut* out)
{
	return !!out->stream->begin_buf;
}

GU_API_DECL GuOut*
gu_new_buffered_out(GuOut* out, size_t buf_sz, GuPool* pool);

GU_API_DECL GuOut*
gu_out_buffered(GuOut* out, GuPool* pool);

GU_API_DECL uint8_t*
gu_out_begin_span(GuOut* out, size_t req, size_t* sz_out, GuExn* err);

GU_API_DECL uint8_t*
gu_out_force_span(GuOut* out, size_t min, size_t max, size_t* sz_out,
		  GuExn* err);

GU_API_DECL void
gu_out_end_span(GuOut* out, size_t sz);

GU_API_DECL size_t
gu_out_bytes_(GuOut* restrict out, const uint8_t* restrict src, 
	      size_t len, GuExn* err);

inline bool
gu_out_try_buf_(GuOut* restrict out, const uint8_t* restrict src, size_t len)
{
	gu_require(len <= PTRDIFF_MAX);
	ptrdiff_t curr = out->buf_curr;
	ptrdiff_t new_curr = curr + (ptrdiff_t) len;
	if (GU_UNLIKELY(new_curr > 0)) {
		return false;
	}
	memcpy(&out->buf_end[curr], src, len);
	out->buf_curr = new_curr;
	return true;
}

inline size_t
gu_out_bytes(GuOut* restrict out, const uint8_t* restrict src, size_t len, 
	     GuExn* err)
{
	if (GU_LIKELY(gu_out_try_buf_(out, src, len))) {
		return len;
	}
	return gu_out_bytes_(out, src, len, err);
}

GU_API_DECL void
gu_out_flush(GuOut* out, GuExn* err);

inline bool
gu_out_try_u8_(GuOut* restrict out, uint8_t u)
{
	ptrdiff_t curr = out->buf_curr;
	ptrdiff_t new_curr = curr + 1;
	if (GU_UNLIKELY(new_curr > 0)) {
		return false;
	}
	out->buf_end[curr] = u;
	out->buf_curr = new_curr;
	return true;
}

inline void
gu_out_u8(GuOut* restrict out, uint8_t u, GuExn* err)
{
	if (GU_UNLIKELY(!gu_out_try_u8_(out, u))) {
		GU_API_DECL void gu_out_u8_(GuOut* restrict out, uint8_t u, 
				       GuExn* err);
		gu_out_u8_(out, u, err);
	}
}

inline void
gu_out_s8(GuOut* restrict out, int8_t i, GuExn* err)
{
	gu_out_u8(out, (uint8_t) i, err);
}

GU_API_DECL void
gu_out_u16le(GuOut* out, uint16_t u, GuExn* err);

GU_API_DECL void
gu_out_u16be(GuOut* out, uint16_t u, GuExn* err);

GU_API_DECL void
gu_out_s16le(GuOut* out, int16_t u, GuExn* err);

GU_API_DECL void
gu_out_s16be(GuOut* out, int16_t u, GuExn* err);

GU_API_DECL void
gu_out_u32le(GuOut* out, uint32_t u, GuExn* err);

GU_API_DECL void
gu_out_u32be(GuOut* out, uint32_t u, GuExn* err);

GU_API_DECL void
gu_out_s32le(GuOut* out, int32_t u, GuExn* err);

GU_API_DECL void
gu_out_s32be(GuOut* out, int32_t u, GuExn* err);

GU_API_DECL void
gu_out_u64le(GuOut* out, uint64_t u, GuExn* err);

GU_API_DECL void
gu_out_u64be(GuOut* out, uint64_t u, GuExn* err);

GU_API_DECL void
gu_out_s64le(GuOut* out, int64_t u, GuExn* err);

GU_API_DECL void
gu_out_s64be(GuOut* out, int64_t u, GuExn* err);

GU_API_DECL void
gu_out_f64le(GuOut* out, double d, GuExn* err);

GU_API_DECL void
gu_out_f64be(GuOut* out, double d, GuExn* err);

inline void
gu_putc(char c, GuOut* out, GuExn* err)
{
	GuUCS ucs = gu_char_ucs(c);
	gu_out_u8(out, (uint8_t) ucs, err);
}

GU_API_DECL void
gu_puts(const char* str, GuOut* out, GuExn* err);

GU_API_DECL void
gu_vprintf(const char* fmt, va_list args, GuOut* out, GuExn* err);

GU_API_DECL void
gu_printf(GuOut* out, GuExn* err, const char* fmt, ...);

#endif // GU_OUT_H_
