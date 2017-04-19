#ifndef GU_IN_H_
#define GU_IN_H_

#include <gu/defs.h>
#include <gu/exn.h>
#include <gu/assert.h>

typedef struct GuInStream GuInStream;

struct GuInStream {
	const uint8_t* (*begin_buffer)(GuInStream* self, size_t* sz_out, 
				       GuExn* err);
	void (*end_buffer)(GuInStream* self, size_t consumed, GuExn* err);
	size_t (*input)(GuInStream* self, uint8_t* buf, size_t max_sz, 
			GuExn* err);
};

typedef struct GuIn GuIn;

struct GuIn {
	const uint8_t* restrict buf_end;
	ptrdiff_t buf_curr;
	size_t buf_size;
	GuInStream* stream;
	GuFinalizer fini;
};

GU_API_DECL GuIn*
gu_new_in(GuInStream* stream, GuPool* pool);

GU_API_DECL const uint8_t*
gu_in_begin_span(GuIn* in, size_t *sz_out, GuExn* err);

GU_API_DECL void
gu_in_end_span(GuIn* in, size_t consumed);

GU_API_DECL size_t
gu_in_some(GuIn* in, uint8_t* buf, size_t max_len, GuExn* err);

inline void
gu_in_bytes(GuIn* in, uint8_t* buf, size_t sz, GuExn* err)
{
	gu_require(sz < PTRDIFF_MAX);
	ptrdiff_t curr = in->buf_curr;
	ptrdiff_t new_curr = curr + (ptrdiff_t) sz;
	if (GU_UNLIKELY(new_curr > 0)) {
		GU_API_DECL void gu_in_bytes_(GuIn* in, uint8_t* buf, size_t sz, 
					 GuExn* err);
		gu_in_bytes_(in, buf, sz, err);
		return;
	}
	memcpy(buf, &in->buf_end[curr], sz);
	in->buf_curr = new_curr;
}

inline int
gu_in_peek_u8(GuIn* restrict in)
{
	if (GU_UNLIKELY(in->buf_curr == 0)) {
		return -1;
	}
	return in->buf_end[in->buf_curr];
}

inline void
gu_in_consume(GuIn* restrict in, size_t sz)
{
	gu_require((ptrdiff_t) sz + in->buf_curr <= 0);
	in->buf_curr += sz;
}

inline uint8_t 
gu_in_u8(GuIn* restrict in, GuExn* err)
{
	if (GU_UNLIKELY(in->buf_curr == 0)) {
		GU_API_DECL uint8_t gu_in_u8_(GuIn* restrict in, GuExn* err);
		return gu_in_u8_(in, err);
	}
	return in->buf_end[in->buf_curr++];
}

GU_API_DECL int8_t 
gu_in_s8(GuIn* in, GuExn* err);

GU_API_DECL uint16_t
gu_in_u16le(GuIn* in, GuExn* err);

GU_API_DECL uint16_t
gu_in_u16be(GuIn* in, GuExn* err);

GU_API_DECL int16_t
gu_in_s16le(GuIn* in, GuExn* err);

GU_API_DECL int16_t
gu_in_s16be(GuIn* in, GuExn* err);

GU_API_DECL uint32_t
gu_in_u32le(GuIn* in, GuExn* err);

GU_API_DECL uint32_t
gu_in_u32be(GuIn* in, GuExn* err);

GU_API_DECL int32_t
gu_in_s32le(GuIn* in, GuExn* err);

GU_API_DECL int32_t
gu_in_s32be(GuIn* in, GuExn* err);

GU_API_DECL uint64_t
gu_in_u64le(GuIn* in, GuExn* err);

GU_API_DECL uint64_t
gu_in_u64be(GuIn* in, GuExn* err);

GU_API_DECL int64_t
gu_in_s64le(GuIn* in, GuExn* err);

GU_API_DECL int64_t
gu_in_s64be(GuIn* in, GuExn* err);

GU_API_DECL double
gu_in_f64le(GuIn* in, GuExn* err);

GU_API_DECL double
gu_in_f64be(GuIn* in, GuExn* err);

GU_API_DECL GuIn*
gu_buffered_in(GuIn* in, size_t sz, GuPool* pool);

GU_API_DECL GuIn*
gu_data_in(const uint8_t* buf, size_t size, GuPool* pool);


#endif // GU_IN_H_
