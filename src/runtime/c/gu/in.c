#include <gu/in.h>
#include <gu/bits.h>
#include <math.h>

GU_DEFINE_TYPE(GuEOF, abstract, _);


static bool
gu_in_is_buffering(GuIn* in)
{
	return (in->buf_end != NULL);
}

static void
gu_in_end_buffering(GuIn* in, GuExn* err)
{
	if (!gu_in_is_buffering(in)) {
		return;
	}
	if (in->stream->end_buffer) {
		size_t len = ((ptrdiff_t) in->buf_size) + in->buf_curr;
		in->stream->end_buffer(in->stream, len, err);
	}
	in->buf_curr = 0;
	in->buf_size = 0;
	in->buf_end = NULL;
}

static bool
gu_in_begin_buffering(GuIn* in, GuExn* err)
{
	if (gu_in_is_buffering(in)) {
		if (in->buf_curr < 0) {
			return true;
		} else {
			gu_in_end_buffering(in, err);
			if (!gu_ok(err)) return false;
		}
	}
	if (!in->stream->begin_buffer) {
		return false;
	}
	size_t sz = 0;
	const uint8_t* new_buf = 
		in->stream->begin_buffer(in->stream, &sz, err);
	if (new_buf) {
		in->buf_end = &new_buf[sz];
		in->buf_curr = -(ptrdiff_t) sz;
		in->buf_size = sz;
		return true;
	}
	return false;
}

static size_t
gu_in_input(GuIn* in, uint8_t* dst, size_t sz, GuExn* err)
{
	if (sz == 0) {
		return 0;
	}
	gu_in_end_buffering(in, err);
	if (!gu_ok(err)) {
		return 0;
	}
	GuInStream* stream = in->stream;
	if (stream->input) {
		return stream->input(stream, dst, sz, err);
	}
	gu_raise(err, GuEOF);
	return 0;
}

size_t
gu_in_some(GuIn* in, uint8_t* dst, size_t sz, GuExn* err)
{
	gu_require(sz <= PTRDIFF_MAX);
	if (!gu_in_begin_buffering(in, err)) {
		if (!gu_ok(err)) return 0; 
		return gu_in_input(in, dst, sz, err);
	}
	size_t real_sz = GU_MIN(sz, (size_t)(-in->buf_curr));
	memcpy(dst, &in->buf_end[in->buf_curr], real_sz);
	in->buf_curr += real_sz;
	return real_sz;
}

void
gu_in_bytes_(GuIn* in, uint8_t* dst, size_t sz, GuExn* err)
{
	size_t avail_sz = GU_MIN(sz, (size_t)(-in->buf_curr));
	memcpy(dst, &in->buf_end[in->buf_curr], avail_sz);
	in->buf_curr += avail_sz;
	if (avail_sz < sz) {
		gu_in_input(in, &dst[avail_sz], sz - avail_sz, err);
	}
}

const uint8_t*
gu_in_begin_span(GuIn* in, size_t *sz_out, GuExn* err)
{
	if (!gu_in_begin_buffering(in, err)) {
		return NULL;
	}
	*sz_out = (size_t) -in->buf_curr;
	return &in->buf_end[in->buf_curr];
}

void
gu_in_end_span(GuIn* in, size_t consumed)
{
	gu_require(consumed <= (size_t) -in->buf_curr);
	in->buf_curr += (ptrdiff_t) consumed;
}

uint8_t 
gu_in_u8_(GuIn* in, GuExn* err)
{
	if (gu_in_begin_buffering(in, err) && in->buf_curr < 0) {
		return in->buf_end[in->buf_curr++];
	}
	uint8_t u = 0;
	size_t r = gu_in_input(in, &u, 1, err);
	if (r < 1) {
		gu_raise(err, GuEOF);
		return 0;
	}
	return u;
}

static uint64_t
gu_in_be(GuIn* in, GuExn* err, int n)
{
	uint8_t buf[8];
	gu_in_bytes(in, buf, n, err);
	uint64_t u = 0;
	for (int i = 0; i < n; i++) {
		u = u << 8 | buf[i];
	}
	return u;
}

static uint64_t
gu_in_le(GuIn* in, GuExn* err, int n)
{
	uint8_t buf[8];
	gu_in_bytes(in, buf, n, err);
	uint64_t u = 0;
	for (int i = 0; i < n; i++) {
		u = u << 8 | buf[i];
	}
	return u;
}

int8_t 
gu_in_s8(GuIn* in, GuExn* err)
{
	return gu_decode_2c8(gu_in_u8(in, err), err);
}


uint16_t
gu_in_u16le(GuIn* in, GuExn* err)
{
	return gu_in_le(in, err, 2);
}

int16_t 
gu_in_s16le(GuIn* in, GuExn* err)
{
	return gu_decode_2c16(gu_in_u16le(in, err), err);
}

uint16_t
gu_in_u16be(GuIn* in, GuExn* err)
{
	return gu_in_be(in, err, 2);
}

int16_t 
gu_in_s16be(GuIn* in, GuExn* err)
{
	return gu_decode_2c16(gu_in_u16be(in, err), err);
}


uint32_t
gu_in_u32le(GuIn* in, GuExn* err)
{
	return gu_in_le(in, err, 4);
}

int32_t 
gu_in_s32le(GuIn* in, GuExn* err)
{
	return gu_decode_2c32(gu_in_u32le(in, err), err);
}

uint32_t
gu_in_u32be(GuIn* in, GuExn* err)
{
	return gu_in_be(in, err, 4);
}

int32_t 
gu_in_s32be(GuIn* in, GuExn* err)
{
	return gu_decode_2c32(gu_in_u32be(in, err), err);
}


uint64_t
gu_in_u64le(GuIn* in, GuExn* err)
{
	return gu_in_le(in, err, 8);
}

int64_t 
gu_in_s64le(GuIn* in, GuExn* err)
{
	return gu_decode_2c64(gu_in_u64le(in, err), err);
}

uint64_t
gu_in_u64be(GuIn* in, GuExn* err)
{
	return gu_in_be(in, err, 8);
}

int64_t 
gu_in_s64be(GuIn* in, GuExn* err)
{
	return gu_decode_2c64(gu_in_u64be(in, err), err);
}

double
gu_in_f64le(GuIn* in, GuExn* err)
{
	return gu_decode_double(gu_in_u64le(in, err));
}

double
gu_in_f64be(GuIn* in, GuExn* err)
{
	return gu_decode_double(gu_in_u64le(in, err));
}


static void
gu_in_fini(GuFinalizer* fin)
{
	GuIn* in = gu_container(fin, GuIn, fini);
	GuPool* pool = gu_local_pool();
	GuExn* err = gu_exn(NULL, type, pool);
	gu_in_end_buffering(in, err);
	gu_pool_free(pool);
}

GuIn
gu_init_in(GuInStream* stream)
{
	return (GuIn) {
		.buf_end = NULL,
		.buf_curr = 0,
		.buf_size = 0,
		.stream = stream,
		.fini.fn = gu_in_fini
	};
}

GuIn*
gu_new_in(GuInStream* stream, GuPool* pool)
{
	GuIn* in = gu_new(GuIn, pool);
	*in = gu_init_in(stream);
	return in;
}


typedef struct GuProxyInStream GuProxyInStream;

struct GuProxyInStream {
	GuInStream stream;
	GuIn* real_in;
};

static const uint8_t*
gu_proxy_in_begin_buffer(GuInStream* self, size_t* sz_out, GuExn* err)
{
	GuProxyInStream* pis = gu_container(self, GuProxyInStream, stream);
	return gu_in_begin_span(pis->real_in, sz_out, err);
}

static void
gu_proxy_in_end_buffer(GuInStream* self, size_t sz, GuExn* err)
{
	GuProxyInStream* pis = gu_container(self, GuProxyInStream, stream);
	gu_in_end_span(pis->real_in, sz);
}

static size_t
gu_proxy_in_input(GuInStream* self, uint8_t* dst, size_t sz, GuExn* err)
{
	GuProxyInStream* pis = gu_container(self, GuProxyInStream, stream);
	return gu_in_some(pis->real_in, dst, sz, err);
}

GuInStream*
gu_in_proxy_stream(GuIn* in, GuPool* pool)
{
	GuProxyInStream* ins = gu_new(GuProxyInStream, pool);
	ins->stream.begin_buffer = gu_proxy_in_begin_buffer;
	ins->stream.end_buffer = gu_proxy_in_end_buffer;
	ins->stream.input = gu_proxy_in_input;
	ins->real_in = in;
	return &ins->stream;
}

enum {
	GU_BUFFERED_IN_BUF_SIZE = 4096
};

typedef struct GuBufferedInStream GuBufferedInStream;

struct GuBufferedInStream {
	GuInStream stream;
	size_t alloc;
	size_t have;
	size_t curr;
	GuIn* in;
	uint8_t buf[];
};

static const uint8_t*
gu_buffered_in_begin_buffer(GuInStream* self, size_t* sz_out, GuExn* err)
{
	GuBufferedInStream* bis = 
		gu_container(self, GuBufferedInStream, stream);
	if (bis->curr == bis->have) {
		bis->curr = 0;
		bis->have = gu_in_some(bis->in, bis->buf, bis->alloc, err);
		if (!gu_ok(err)) return NULL;
	}
	*sz_out = bis->have - bis->curr;
	return &bis->buf[bis->curr];
}

static void
gu_buffered_in_end_buffer(GuInStream* self, size_t consumed, GuExn* err)
{
	GuBufferedInStream* bis = 
		gu_container(self, GuBufferedInStream, stream);
	gu_require(consumed < bis->have - bis->curr);
	bis->curr += consumed;
}

static size_t
gu_buffered_in_input(GuInStream* self, uint8_t* dst, size_t sz, GuExn* err)
{
	GuBufferedInStream* bis = 
		gu_container(self, GuBufferedInStream, stream);
	return gu_in_some(bis->in, dst, sz, err);
}

GuIn*
gu_buffered_in(GuIn* in, size_t buf_sz, GuPool* pool)
{
	GuBufferedInStream* bis = gu_new_flex(pool, GuBufferedInStream,
					      buf, buf_sz);
	bis->stream = (GuInStream) {
		.begin_buffer = gu_buffered_in_begin_buffer,
		.end_buffer = gu_buffered_in_end_buffer,
		.input = gu_buffered_in_input
	};
	bis->have = bis->curr = 0;
	bis->alloc = buf_sz;
	return gu_new_in(&bis->stream, pool);
}

typedef struct GuDataIn GuDataIn;

struct GuDataIn {
	GuInStream stream; 
	const uint8_t* data;
	size_t sz;
};

static const uint8_t*
gu_data_in_begin_buffer(GuInStream* self, size_t* sz_out, GuExn* err)
{
	(void) err;
	GuDataIn* di = gu_container(self, GuDataIn, stream);
	const uint8_t* buf = di->data;
	if (buf) {
		*sz_out = di->sz;
		di->data = NULL;
		di->sz = 0;
	}
	return buf;
}

GuIn*
gu_data_in(const uint8_t* data, size_t sz, GuPool* pool)
{
	GuDataIn* di = gu_new(GuDataIn, pool);
	di->stream.begin_buffer = gu_data_in_begin_buffer;
	di->stream.end_buffer = NULL;
	di->stream.input = NULL;
	di->data = data;
	di->sz = sz;
	return gu_new_in(&di->stream, pool);
}

extern inline uint8_t 
gu_in_u8(GuIn* restrict in, GuExn* err);

extern inline void
gu_in_bytes(GuIn* in, uint8_t* buf, size_t sz, GuExn* err);

extern inline int
gu_in_peek_u8(GuIn* restrict in);

extern inline void
gu_in_consume(GuIn* restrict in, size_t sz);
