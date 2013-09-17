#include <gu/type.h>
#include <gu/out.h>
#include <gu/seq.h>
#include <gu/map.h>
#include <gu/string.h>
#include <gu/utf8.h>
#include <gu/assert.h>
#include <stdlib.h>

const GuString gu_empty_string = { 1 };

struct GuStringBuf {
	GuByteBuf* bbuf;
	GuOut* out;
};

GuStringBuf*
gu_string_buf(GuPool* pool)
{
	GuBuf* buf = gu_new_buf(uint8_t, pool);
	GuOut* out = gu_buf_out(buf, pool);
	GuStringBuf* sbuf = gu_new(GuStringBuf, pool);
	sbuf->bbuf = buf;
	sbuf->out = out;
	return sbuf;
}

GuOut*
gu_string_buf_out(GuStringBuf* sb)
{
	return sb->out;
}

static GuString
gu_utf8_string(const uint8_t* buf, size_t sz, GuPool* pool)
{
	if (sz < GU_MIN(sizeof(GuWord), 128)) {
		GuWord w = 0;
		for (size_t n = 0; n < sz; n++) {
			w = w << 8 | buf[n];
		}
		w = w << 8 | (sz << 1) | 1;
		return (GuString) { w };
	}
	uint8_t* p = NULL;
	if (sz < 256) {
		p = gu_malloc_aligned(pool, 1 + sz, 2);
		p[0] = (uint8_t) sz;
	} else {
		p =	gu_malloc_prefixed(pool, gu_alignof(size_t),
		                       sizeof(size_t), 1, 1 + sz);
		((size_t*) p)[-1] = sz;
		p[0] = 0;
	}
	memcpy(&p[1], buf, sz);
	return (GuString) { (GuWord) (void*) p };
}



GuString
gu_string_buf_freeze(GuStringBuf* sb, GuPool* pool)
{
	gu_out_flush(sb->out, NULL);
	uint8_t* data = gu_buf_data(sb->bbuf);
	size_t len = gu_buf_length(sb->bbuf);
	return gu_utf8_string(data, len, pool);
}

GuIn*
gu_string_in(GuString s, GuPool* pool)
{
	GuWord w = s.w_;
	uint8_t* buf = NULL;
	size_t len = 0;
	if (w & 1) {
		len = (w & 0xff) >> 1;
		buf = gu_new_n(uint8_t, len, pool);
		for (int i = len - 1; i >= 0; i--) {
			w >>= 8;
			buf[i] = w & 0xff;
		}
	} else {
		uint8_t* p = (void*) w;
		len = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		buf = &p[1];
	}
	return gu_data_in(buf, len, pool);
}

static bool
gu_string_is_long(GuString s) 
{
	return !(s.w_ & 1);
}

bool
gu_string_is_stable(GuString s)
{
	return !gu_string_is_long(s);
}

static size_t
gu_string_long_length(GuString s)
{
	gu_assert(gu_string_is_long(s));
	uint8_t* p = (void*) s.w_;
	uint8_t len = p[0];
	if (len > 0) {
		return len;
	}
	return ((size_t*) p)[-1];
}

size_t
gu_string_length(GuString s)
{
	if (gu_string_is_long(s)) {
		return gu_string_long_length(s);
	}
	return (s.w_ & 0xff) >> 1;
}

static uint8_t*
gu_string_long_data(GuString s)
{
	gu_require(gu_string_is_long(s));
	uint8_t* p = (void*) s.w_;
	return &p[1];
}

GuString
gu_string_copy(GuString string, GuPool* pool)
{
	if (gu_string_is_long(string)) {
		uint8_t* data = gu_string_long_data(string);
		size_t len = gu_string_long_length(string);
		return gu_utf8_string(data, len, pool);
	} else {
		return string;
	}
}


void
gu_string_write(GuString s, GuOut* out, GuExn* err)
{
	GuWord w = s.w_;
	uint8_t buf[sizeof(GuWord)];
	uint8_t* src;
	size_t sz;
	if (w & 1) {
		sz = (w & 0xff) >> 1;
		gu_assert(sz <= sizeof(GuWord));
		size_t i = sz;
		while (i > 0) {
			w >>= 8;
			buf[--i] = w & 0xff;
		}
		src = buf;
	} else {
		uint8_t* p = (void*) w;
		sz = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		src = &p[1];
	}
	gu_out_bytes(out, src, sz, err);
}

GuString
gu_string_read(size_t len, GuPool* pool, GuIn* in, GuExn* err)
{
	uint8_t* buf = alloca(len*4);
	uint8_t* p   = buf;
	for (size_t i = 0; i < len; i++) {
		gu_in_utf8_buf(&p, in, err);
	}
	return gu_utf8_string(buf, p-buf, pool);
}

GuString
gu_string_read_latin1(size_t len, GuPool* pool, GuIn* in, GuExn* err)
{
	if (len < GU_MIN(sizeof(GuWord), 128)) {
		GuWord w = 0;
		for (size_t n = 0; n < len; n++) {
			w = w << 8 | gu_in_u8(in, err);
		}
		w = w << 8 | (len << 1) | 1;
		return (GuString) { w };
	}
	uint8_t* p = NULL;
	if (len < 256) {
		p = gu_malloc_aligned(pool, 1 + len, 2);
		p[0] = (uint8_t) len;
	} else {
		p =	gu_malloc_prefixed(pool, gu_alignof(size_t),
		                       sizeof(size_t), 1, 1 + len);
		((size_t*) p)[-1] = len;
		p[0] = 0;
	}

	gu_in_bytes(in, &p[1], len, err);
	return (GuString) { (GuWord) (void*) p };
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

GuString
gu_str_string(const char* str, GuPool* pool)
{
	return gu_utf8_string((const uint8_t*) str, strlen(str), pool);
}

bool
gu_string_to_int(GuString s, int *res)
{
	GuWord w = s.w_;
	uint8_t buf[sizeof(GuWord)];
	char* src;
	size_t sz;
	if (w & 1) {
		sz = (w & 0xff) >> 1;
		gu_assert(sz <= sizeof(GuWord));
		size_t i = sz;
		while (i > 0) {
			w >>= 8;
			buf[--i] = w & 0xff;
		}
		src = (char*) buf;
	} else {
		uint8_t* p = (void*) w;
		sz = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		src = (char*) &p[1];
	}

	size_t i = 0;
	
	bool neg = false;

	if (src[i] == '-') {
		neg = true;
		i++;
	}

	if (i >= sz)
		return false;

	int n = 0;
	for (; i < sz; i++) {
		if (src[i] < '0' || src[i] > '9')
			return false;

		n = n * 10 + (src[i] - '0');
	}

	*res = neg ? -n : n;
	return true;
}

bool
gu_string_to_double(GuString s, double *res)
{
	GuWord w = s.w_;
	uint8_t buf[sizeof(GuWord)];
	char* src;
	size_t sz;
	if (w & 1) {
		sz = (w & 0xff) >> 1;
		gu_assert(sz <= sizeof(GuWord));
		size_t i = sz;
		while (i > 0) {
			w >>= 8;
			buf[--i] = w & 0xff;
		}
		src = (char*) buf;
	} else {
		uint8_t* p = (void*) w;
		sz = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		src = (char*) &p[1];
	}

	size_t i = 0;
	
	bool neg = false;
	bool dec = false;
	double exp = 1;

	if (src[i] == '-') {
		neg = true;
		i++;
	}

	if (i >= sz)
		return false;

	double d = 0;
	for (; i < sz; i++) {
		if (src[i] == '.') {
			if (dec) return false;

			dec = true;
			continue;
		}

		if (src[i] < '0' || src[i] > '9')
			return false;

		if (dec) exp = exp * 10;

		d = d * 10 + (src[i] - '0');
	}

	*res = (neg ? -d : d) / exp;
	return true;
}

bool
gu_string_is_prefix(GuString s1, GuString s2)
{
	GuWord w1 = s1.w_;
	uint8_t buf1[sizeof(GuWord)];
	size_t sz1;
	char* str1;
	if (w1 & 1) {
		sz1 = (w1 & 0xff) >> 1;
		gu_assert(sz1 <= sizeof(GuWord));
		size_t i = sz1;
		while (i > 0) {
			w1 >>= 8;
			buf1[--i] = w1 & 0xff;
		}
		str1 = (char*) buf1;
	} else {
		uint8_t* p = (void*) w1;
		sz1 = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		str1 = (char*) &p[1];
	}

	GuWord w2 = s2.w_;
	uint8_t buf2[sizeof(GuWord)];
	size_t sz2;
	char* str2;
	if (w2 & 1) {
		sz2 = (w2 & 0xff) >> 1;
		gu_assert(sz2 <= sizeof(GuWord));
		size_t i = sz2;
		while (i > 0) {
			w2 >>= 8;
			buf2[--i] = w2 & 0xff;
		}
		str2 = (char*) buf2;
	} else {
		uint8_t* p = (void*) w2;
		sz2 = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		str2 = (char*) &p[1];
	}

	
	if (sz1 > sz2)
		return false;

	for (size_t sz = sz1; sz--; sz > 0) {
		if (*str1 != *str2)
			return false;
			
		str1++;
		str2++;
	}

	return true;
}

GuHash
gu_string_hash(GuHash h, GuString s)
{
	if (s.w_ & 1) {
		return h*101 + s.w_;
	}
	size_t len = gu_string_length(s);
	uint8_t* data = gu_string_long_data(s);
	return gu_hash_bytes(h, data, len);
}

bool
gu_string_eq(GuString s1, GuString s2)
{
	if (s1.w_ == s2.w_) {
		return true;
	} else if (gu_string_is_long(s1) && gu_string_is_long(s2)) {
		size_t len1 = gu_string_long_length(s1);
		size_t len2 = gu_string_long_length(s2);
		if (len1 != len2) {
			return false;
		}
		uint8_t* data1 = gu_string_long_data(s1);
		uint8_t* data2 = gu_string_long_data(s2);
		return (memcmp(data1, data2, len1) == 0);
	}
	return false;

}

static bool
gu_string_eq_fn(GuEquality* self, const void* p1, const void* p2)
{
	(void) self;
	const GuString* sp1 = p1;
	const GuString* sp2 = p2;
	return gu_string_eq(*sp1, *sp2);
}

GuEquality gu_string_equality[1] = { { gu_string_eq_fn } };

int
gu_string_cmp(GuString s1, GuString s2)
{
	uint8_t buf1[sizeof(GuWord)];
	char* src1;
	size_t sz1;
	if (s1.w_ & 1) {
		sz1 = (s1.w_ & 0xff) >> 1;
		gu_assert(sz1 <= sizeof(GuWord));
		size_t i = sz1;
		while (i > 0) {
			s1.w_ >>= 8;
			buf1[--i] = s1.w_ & 0xff;
		}
		src1 = (char*) buf1;
	} else {
		uint8_t* p = (void*) s1.w_;
		sz1 = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		src1 = (char*) &p[1];
	}

	uint8_t buf2[sizeof(GuWord)];
	char* src2;
	size_t sz2;
	if (s2.w_ & 1) {
		sz2 = (s2.w_ & 0xff) >> 1;
		gu_assert(sz2 <= sizeof(GuWord));
		size_t i = sz2;
		while (i > 0) {
			s2.w_ >>= 8;
			buf2[--i] = s2.w_ & 0xff;
		}
		src2 = (char*) buf2;
	} else {
		uint8_t* p = (void*) s2.w_;
		sz2 = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		src2 = (char*) &p[1];
	}

	for (size_t i = 0; ; i++) {
		if (sz1 == i && i == sz2)
			break;
		
		if (sz1 <= i)
			return -1;
		if (i >= sz2)
			return 1;

		if (src1[i] > src2[i])
			return 1;
		else if (src1[i] < src2[i])
			return -1;
	}

	return 0;
}

static int
gu_string_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	const GuString* sp1 = p1;
	const GuString* sp2 = p2;
	return gu_string_cmp(*sp1, *sp2);
}

GuOrder gu_string_order[1] = { { gu_string_cmp_fn } };

static GuHash
gu_string_hasher_hash(GuHasher* self, const void* p)
{
	(void) self;
	const GuString* sp = p;
	return gu_string_hash(0, *sp);
}

GuHasher gu_string_hasher[1] = {
	{
		.eq = { gu_string_eq_fn },
		.hash = gu_string_hasher_hash
	}
};


GU_DEFINE_TYPE(GuString, GuOpaque, _);
GU_DEFINE_KIND(GuStringMap, GuMap);
