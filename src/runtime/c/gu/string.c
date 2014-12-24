#include <gu/out.h>
#include <gu/map.h>
#include <gu/string.h>
#include <gu/seq.h>
#include <gu/utf8.h>
#include <gu/assert.h>
#include <stdlib.h>
#ifdef __MINGW32__
#include <malloc.h>
#endif

struct GuStringBuf {
	GuOutStream stream;
	GuBuf* buf;
	GuOut* out;
};

static size_t
gu_string_buf_output(GuOutStream* stream, const uint8_t* src, size_t sz,
                     GuExn* err)
{
	(void) err;
	GuStringBuf* sbuf = gu_container(stream, GuStringBuf, stream);
	gu_buf_push_n(sbuf->buf, src, sz);
	return sz;
}

static uint8_t*
gu_string_buf_begin(GuOutStream* stream, size_t req, size_t* sz_out, GuExn* err)
{
	(void) req;
	(void) err;
	GuStringBuf* sbuf = gu_container(stream, GuStringBuf, stream);
	size_t len = gu_buf_length(sbuf->buf);
	gu_buf_require(sbuf->buf, len + req);
	size_t avail = sbuf->buf->avail_len;
	gu_assert(len < avail);
	*sz_out = (avail - len);
	return (uint8_t*) gu_buf_index(sbuf->buf, char, len);
}

static void
gu_string_buf_end(GuOutStream* stream, size_t sz, GuExn* err)
{
	(void) err;
	GuStringBuf* sbuf = gu_container(stream, GuStringBuf, stream);
	size_t len = gu_buf_length(sbuf->buf);
	gu_require(sz < len - sbuf->buf->avail_len);
	sbuf->buf->seq->len = len + sz;
}

GuStringBuf*
gu_string_buf(GuPool* pool)
{
	GuStringBuf* sbuf = gu_new(GuStringBuf, pool);
	sbuf->stream.output = gu_string_buf_output;
	sbuf->stream.begin_buf = gu_string_buf_begin;
	sbuf->stream.end_buf = gu_string_buf_end;
	sbuf->stream.flush = NULL;
	sbuf->buf = gu_new_buf(char, pool);
	sbuf->out = gu_new_out(&sbuf->stream, pool);
	return sbuf;
}

GuOut*
gu_string_buf_out(GuStringBuf* sb)
{
	return sb->out;
}

GuString
gu_string_buf_freeze(GuStringBuf* sb, GuPool* pool)
{
	gu_out_flush(sb->out, NULL);
	char* data = gu_buf_data(sb->buf);
	size_t len = gu_buf_length(sb->buf);

	char* p = gu_malloc_aligned(pool, len+1, 2);
	memcpy(p, data, len);
	p[len] = 0;

	return p;
}

GuIn*
gu_string_in(GuString s, GuPool* pool)
{
	return gu_data_in((uint8_t*) s, strlen(s), pool);
}

GuString
gu_string_copy(GuString string, GuPool* pool)
{
	size_t len = strlen(string);
	char* p = gu_malloc_aligned(pool, len+1, 2);
	memcpy(p, string, len+1);
	return p;
}

void
gu_string_write(GuString s, GuOut* out, GuExn* err)
{
	gu_out_bytes(out, (uint8_t*) s, strlen(s), err);
}

GuString
gu_string_read(size_t len, GuPool* pool, GuIn* in, GuExn* err)
{
	char* buf = alloca(len*6+1);
	char* p   = buf;
	for (size_t i = 0; i < len; i++) {
		gu_in_utf8_buf((uint8_t**) &p, in, err);
	}
	*p++ = 0;

	p = gu_malloc_aligned(pool, p-buf, 2);
	strcpy(p, buf);

	return p;
}

GuString
gu_string_read_latin1(size_t len, GuPool* pool, GuIn* in, GuExn* err)
{
	char* p = gu_malloc_aligned(pool, len+1, 2);
	gu_in_bytes(in, (uint8_t*)p, len, err);
	p[len] = 0;
	return p;
}

GuString
gu_format_string_v(const char* fmt, va_list args, GuPool* pool)
{
	GuPool* tmp_pool = gu_local_pool();
	GuStringBuf* sb = gu_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sb);
	gu_vprintf(fmt, args, out, NULL);
	gu_out_flush(out, NULL);
	GuString s = gu_string_buf_freeze(sb, pool);
	gu_pool_free(tmp_pool);
	return s;
}

GuString
gu_format_string(GuPool* pool, const char* fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	GuString s = gu_format_string_v(fmt, args, pool);
	va_end(args);
	return s;
}

bool
gu_string_to_int(GuString s, int *res)
{
	bool neg = false;
	if (*s == '-') {
		neg = true;
		s++;
	}

	if (*s == 0)
		return false;

	int n = 0;
	for (; *s; s++) {
		if (*s < '0' || *s > '9')
			return false;

		n = n * 10 + (*s - '0');
	}

	*res = neg ? -n : n;
	return true;
}

bool
gu_string_to_double(GuString s, double *res)
{
	bool neg = false;
	bool dec = false;
	double exp = 1;

	if (*s == '-') {
		neg = true;
		s++;
	}

	if (*s == 0)
		return false;

	double d = 0;
	for (; *s; s++) {
		if (*s == '.') {
			if (dec) return false;

			dec = true;
			continue;
		}

		if (*s < '0' || *s > '9')
			return false;

		if (dec) exp = exp * 10;

		d = d * 10 + (*s - '0');
	}

	*res = (neg ? -d : d) / exp;
	return true;
}

bool
gu_string_is_prefix(GuString s1, GuString s2)
{
	size_t len1 = strlen(s1);
	size_t len2 = strlen(s2);

	if (len1 > len2)
		return false;

	for (size_t len = len1; len > 0; len--) {
		if (*s1 != *s2)
			return false;

		s1++;
		s2++;
	}

	return true;
}

GuHash
gu_string_hash(GuHash h, GuString s)
{
	return gu_hash_bytes(h, (uint8_t*)s, strlen(s));
}

static bool
gu_string_eq_fn(GuEquality* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, (GuString) p2) == 0;
}

GuEquality gu_string_equality[1] = { { gu_string_eq_fn } };

static int
gu_string_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, (GuString) p2);
}

GuOrder gu_string_order[1] = { { gu_string_cmp_fn } };

static GuHash
gu_string_hasher_hash(GuHasher* self, const void* p)
{
	(void) self;
	return gu_string_hash(0, (GuString) p);
}

GuHasher gu_string_hasher[1] = {
	{
		.eq = { gu_string_eq_fn },
		.hash = gu_string_hasher_hash
	}
};
