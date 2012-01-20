#include <gu/assert.h>
#include <gu/utf8.h>
#include <guconfig.h>

GuUCS
gu_utf8_decode(const uint8_t** src_inout)
{
	const uint8_t* src = *src_inout;
	uint8_t c = src[0];
	if (c < 0x80) {
		*src_inout = src + 1;
		return (GuUCS) c;
	}
	size_t len = (c < 0xe0 ? 1 :
		      c < 0xf0 ? 2 :
		      3);
	uint32_t mask = 0x07071f7f;
	uint32_t u = c & (mask >> (len * 8));
	for (size_t i = 1; i <= len; i++) {
		c = src[i];
		u = u << 6 | (c & 0x3f);
	}
	*src_inout = &src[len + 1];
	return (GuUCS) u;
}

GuUCS
gu_in_utf8_(GuIn* in, GuExn* err)
{
	uint8_t c = gu_in_u8(in, err);
	if (!gu_ok(err)) {
		return 0;
	}
	int len = (c < 0x80 ? 0 : 
		   c < 0xc2 ? -1 :
		   c < 0xe0 ? 1 :
		   c < 0xf0 ? 2 :
		   c < 0xf5 ? 3 :
		   -1);
	if (len < 0) {
	 	goto fail;
	} else if (len == 0) {
		return c;
	}
	static const uint8_t mask[4] = { 0x7f, 0x1f, 0x0f, 0x07 };
	uint32_t u = c & mask[len];
	uint8_t buf[3];
	// If reading the extra bytes causes EOF, it is an encoding
	// error, not a legitimate end of character stream.
	GuExn* tmp_err = gu_exn(err, GuEOF, NULL);
	gu_in_bytes(in, buf, len, tmp_err);
	if (tmp_err->caught) {
		goto fail;
	}
	if (!gu_ok(err)) {
		return 0;
	}
	for (int i = 0; i < len; i++) {
		c = buf[i];
		if ((c & 0xc0) != 0x80) {
			goto fail;
		}
		u = u << 6 | (c & 0x3f);
	}
	GuUCS ucs = (GuUCS) u;
	if (!gu_ucs_valid(ucs)) {
		goto fail;
	}
	return ucs;

fail:
	gu_raise(err, GuUCSExn);
	return 0;
}


size_t
gu_advance_utf8(GuUCS ucs, uint8_t* buf)
{
	gu_require(gu_ucs_valid(ucs));
	if (ucs < 0x80) {
		buf[0] = (uint8_t) ucs;
		return 1;
	} else if (ucs < 0x800) {
		buf[0] = 0xc0 | (ucs >> 6);
		buf[1] = 0x80 | (ucs & 0x3f);
		return 2;
	} else if (ucs < 0x10000) {
		buf[0] = 0xe0 | (ucs >> 12);
		buf[1] = 0x80 | ((ucs >> 6) & 0x3f);
		buf[2] = 0x80 | (ucs & 0x3f);
		return 3;
	} else {
		buf[0] = 0xf0 | (ucs >> 18);
		buf[1] = 0x80 | ((ucs >> 12) & 0x3f);
		buf[2] = 0x80 | ((ucs >> 6) & 0x3f);
		buf[3] = 0x80 | (ucs & 0x3f);
		return 4;
	}
}

char
gu_in_utf8_char_(GuIn* in, GuExn* err)
{
	return gu_ucs_char(gu_in_utf8(in, err), err);
}

void
gu_out_utf8_long_(GuUCS ucs, GuOut* out, GuExn* err)
{
	uint8_t buf[4];
	size_t sz = gu_advance_utf8(ucs, buf);
	switch (sz) {
	case 2:
		gu_out_bytes(out, buf, 2, err);
		break;
	case 3:
		gu_out_bytes(out, buf, 3, err);
		break;
	case 4:
		gu_out_bytes(out, buf, 4, err);
		break;
	default:
		gu_impossible();
	}
}

extern inline void
gu_out_utf8(GuUCS ucs, GuOut* out, GuExn* err);

static size_t 
gu_utf32_out_utf8_buffered_(const GuUCS* src, size_t len, GuOut* out, 
			    GuExn* err)
{
	size_t src_i = 0;
	while (src_i < len) {
		size_t dst_sz;
		uint8_t* dst = gu_out_begin_span(out, len - src_i, &dst_sz, err);
		if (!gu_ok(err)) {
			return src_i;
		}
		if (!dst) {
			gu_out_utf8(src[src_i], out, err);
			if (!gu_ok(err)) {
				return src_i;
			}
			src_i++;
			break;
		} 
		size_t dst_i = 0;
		while (true) {
			size_t safe = (dst_sz - dst_i) / 4;
			size_t end = GU_MIN(len, src_i + safe);
			if (end == src_i) {
				break;
			}
			do {
				GuUCS ucs = src[src_i++];
				dst_i += gu_advance_utf8(ucs, &dst[dst_i]);
			} while (src_i < end);
		} 
		gu_out_end_span(out, dst_i);
	}
	return src_i;
}

size_t
gu_utf32_out_utf8(const GuUCS* src, size_t len, GuOut* out, GuExn* err)
{
	if (gu_out_is_buffered(out)) {
		return gu_utf32_out_utf8_buffered_(src, len, out, err);
	} 
	for (size_t i = 0; i < len; i++) {
		gu_out_utf8(src[i], out, err);
		if (!gu_ok(err)) {
			return i;
		}
	}
	return len;

}

#ifndef GU_CHAR_ASCII

void gu_str_out_utf8_(const char* str, GuOut* out, GuExn* err)
{
	size_t len = strlen(str);
	size_t sz = 0;
	uint8_t* buf = gu_out_begin_span(out, len, &sz, err);
	if (!gu_ok(err)) {
		return;
	}
	if (buf != NULL && sz < len) {
		gu_out_end_span(out, 0);
		buf = NULL;
	}
	GuPool* tmp_pool = buf ? NULL : gu_local_pool();
	buf = buf ? buf : gu_new_n(uint8_t, len, tmp_pool);
	for (size_t i = 0; i < len; i++) {
		GuUCS ucs = gu_char_ucs(str[i]);
		buf[i] = (uint8_t) ucs;
	}
	if (tmp_pool) {
		gu_out_bytes(out, buf, len, err);
		gu_pool_free(tmp_pool);
	} else {
		gu_out_end_span(out, len);
	}
}

#endif

extern inline void 
gu_str_out_utf8(const char* str, GuOut* out, GuExn* err);

extern inline GuUCS
gu_in_utf8(GuIn* in, GuExn* err);

extern inline char
gu_in_utf8_char(GuIn* in, GuExn* err);
