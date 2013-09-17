#include <gu/seq.h>
#include <gu/out.h>
#include <gu/utf8.h>
#include <gu/str.h>

static bool
gu_out_is_buffering(GuOut* out)
{
	return !!out->buf_end;
}


static void
gu_out_end_buf(GuOut* out, GuExn* err)
{
	if (!gu_out_is_buffering(out)) {
		return;
	}
	GuOutStream* stream = out->stream;
	size_t curr_len = ((ptrdiff_t)out->buf_size) + out->buf_curr;
	stream->end_buf(stream, curr_len, err);
	out->buf_end = NULL;
	out->buf_size = out->buf_curr = 0;
}

static bool
gu_out_begin_buf(GuOut* out, size_t req, GuExn* err)
{
	GuOutStream* stream = out->stream;
	if (gu_out_is_buffering(out)) {
		if (out->buf_curr < 0) {
			return true;
		} else {
			gu_out_end_buf(out, err);
			if (!gu_ok(err)) {
				return false;
			}
		}
	}
	if (stream->begin_buf) {
		size_t sz = 0;
		uint8_t* buf = stream->begin_buf(stream, req, &sz, err);
		gu_assert(sz <= PTRDIFF_MAX);
		if (buf) {
			out->buf_end = &buf[sz];
			out->buf_curr = -(ptrdiff_t) sz;
			out->buf_size = sz;
			return true;
		}
	}
	return false;
}



static void
gu_out_fini(GuFinalizer* self)
{
	GuOut* out = gu_container(self, GuOut, fini);
	if (gu_out_is_buffering(out)) {
		GuPool* pool = gu_local_pool();
		GuExn* err = gu_new_exn(NULL, gu_kind(type), pool);
		gu_out_end_buf(out, err);
		gu_pool_free(pool);
	}
}

GuOut*
gu_new_out(GuOutStream* stream, GuPool* pool)
{
	gu_require(stream != NULL);

	GuOut* out = gu_new(GuOut, pool);
	out->buf_end = NULL,
	out->buf_curr = 0,
	out->stream = stream,
	out->fini.fn = gu_out_fini;
	gu_pool_finally(pool, &out->fini);
	return out;
}

extern inline bool
gu_out_try_buf_(GuOut* out, const uint8_t* src, size_t len);


extern inline size_t
gu_out_bytes(GuOut* out, const uint8_t* buf, size_t len, GuExn* err);

static size_t
gu_out_output(GuOut* out, const uint8_t* src, size_t len, GuExn* err)
{
	gu_out_end_buf(out, err);
	if (!gu_ok(err)) {
		return 0;
	}
	return out->stream->output(out->stream, src, len, err);
}




void 
gu_out_flush(GuOut* out, GuExn* err)
{
	GuOutStream* stream = out->stream;
	if (out->buf_end) {
		gu_out_end_buf(out, err);
		if (!gu_ok(err)) {
			return;
		}
	}
	if (stream->flush) {
		stream->flush(stream, err);
	}
}

uint8_t*
gu_out_begin_span(GuOut* out, size_t req, size_t* sz_out, GuExn* err)
{
	if (!out->buf_end && !gu_out_begin_buf(out, req, err)) {
		return NULL;
	}
	*sz_out = -out->buf_curr;
	return &out->buf_end[out->buf_curr];
}

void
gu_out_end_span(GuOut* out, size_t sz)
{
	ptrdiff_t new_curr = (ptrdiff_t) sz + out->buf_curr;
	gu_require(new_curr <= 0);
	out->buf_curr = new_curr;
}

size_t
gu_out_bytes_(GuOut* restrict out, const uint8_t* restrict src, size_t len, 
	      GuExn* err)
{
	if (!gu_ok(err)) {
		return 0;
	} else if (gu_out_try_buf_(out, src, len)) {
		return len;
	}
	if (gu_out_begin_buf(out, len, err)) {
		if (gu_out_try_buf_(out, src, len)) {
			return len;
		}
	}
	return gu_out_output(out, src, len, err);
}


void gu_out_u8_(GuOut* restrict out, uint8_t u, GuExn* err)
{
	if (gu_out_begin_buf(out, 1, err)) {
		if (gu_out_try_u8_(out, u)) {
			return;
		}
	}
	gu_out_output(out, &u, 1, err);
}


extern inline void
gu_out_u8(GuOut* restrict out, uint8_t u, GuExn* err);

extern inline void
gu_out_s8(GuOut* restrict out, int8_t i, GuExn* err);

extern inline bool
gu_out_is_buffered(GuOut* out);

extern inline bool
gu_out_try_u8_(GuOut* restrict out, uint8_t u);




typedef struct GuBufferedOutStream GuBufferedOutStream;

struct GuBufferedOutStream {
	GuOutStream stream;
	GuOut* real_out;
	size_t sz;
	uint8_t buf[];
};

static uint8_t*
gu_buffered_out_buf_begin(GuOutStream* self, size_t req, size_t* sz_out,
			  GuExn* err)
{
	(void) (req && err);
	GuBufferedOutStream* b =
		gu_container(self, GuBufferedOutStream, stream);
	*sz_out = b->sz;
	return b->buf;
}

static void
gu_buffered_out_buf_end(GuOutStream* self, size_t sz, GuExn* err)
{
	GuBufferedOutStream* b =
		gu_container(self, GuBufferedOutStream, stream);
	gu_require(sz <= b->sz);
	gu_out_bytes(b->real_out, b->buf, sz, err);
}

static size_t
gu_buffered_out_output(GuOutStream* self, const uint8_t* src, size_t sz,
		    GuExn* err)
{
	GuBufferedOutStream* bos =
		gu_container(self, GuBufferedOutStream, stream);
	return gu_out_bytes(bos->real_out, src, sz, err);
}

static void
gu_buffered_out_flush(GuOutStream* self, GuExn* err)
{
	GuBufferedOutStream* bos =
		gu_container(self, GuBufferedOutStream, stream);
	gu_out_flush(bos->real_out, err);
}

GuOut*
gu_new_buffered_out(GuOut* out, size_t sz, GuPool* pool)
{
	GuBufferedOutStream* b =
		gu_new_flex(pool, GuBufferedOutStream, buf, sz);
	b->stream = (GuOutStream) {
		.begin_buf = gu_buffered_out_buf_begin,
		.end_buf = gu_buffered_out_buf_end,
		.output = gu_buffered_out_output,
		.flush = gu_buffered_out_flush
	};
	b->real_out = out;
	b->sz = sz;
	return gu_new_out(&b->stream, pool);
}

GuOut*
gu_out_buffered(GuOut* out, GuPool* pool)
{
	if (gu_out_is_buffered(out)) {
		return out;
	}
	return gu_new_buffered_out(out, 4096, pool);
}


extern inline void
gu_putc(char c, GuOut* out, GuExn* err);

void
gu_puts(const char* str, GuOut* out, GuExn* err)
{
	gu_out_bytes(out, (const uint8_t*) str, strlen(str), err);
}

void
gu_vprintf(const char* fmt, va_list args, GuOut* out, GuExn* err)
{
	GuPool* tmp_pool = gu_local_pool();
	char* str = gu_vasprintf(fmt, args, tmp_pool);
	gu_out_bytes(out, (const uint8_t*) str, strlen(str), err);
	gu_pool_free(tmp_pool);
}

void
gu_printf(GuOut* out, GuExn* err, const char* fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	gu_vprintf(fmt, args, out, err);
	va_end(args);
}
