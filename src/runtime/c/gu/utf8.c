#include <gu/assert.h>
#include <gu/utf8.h>

GU_API GuUCS
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
	              c < 0xf8 ? 3 :
	              c < 0xfc ? 4 :
	                         5
	             );
	uint64_t mask = 0x0103070F1f7f;
	uint32_t u = c & (mask >> (len * 8));
	for (size_t i = 1; i <= len; i++) {
		c = src[i];
		u = u << 6 | (c & 0x3f);
	}
	*src_inout = &src[len + 1];
	return (GuUCS) u;
}

GU_API GuUCS
gu_in_utf8_(GuIn* in, GuExn* err)
{
	uint8_t c = gu_in_u8(in, err);
	if (!gu_ok(err)) {
		return 0;
	}
	if (c < 0x80) {
		return c;
	} 
	if (c < 0xc2) {
		goto fail;
	}
	int len = (c < 0xe0 ? 1 :
	           c < 0xf0 ? 2 :
	           c < 0xf8 ? 3 :
	           c < 0xfc ? 4 :
	                      5
	          );
	uint64_t mask = 0x0103070F1f7f;
	uint32_t u = c & (mask >> (len * 8));
	uint8_t buf[5];
	// If reading the extra bytes causes EOF, it is an encoding
	// error, not a legitimate end of character stream.
	gu_in_bytes(in, buf, len, err);
	if (gu_exn_caught(err, GuEOF)) {
		gu_exn_clear(err);
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

extern inline GuUCS
gu_in_utf8(GuIn* in, GuExn* err);

GU_API void
gu_in_utf8_buf(uint8_t** buf, GuIn* in, GuExn* err)
{
	uint8_t* p = *buf;

	uint8_t c = gu_in_u8(in, err);
	if (!gu_ok(err)) {
		return;
	}
	*(p++) = c;

	if (c < 0x80) {
		*buf = p;
		return;
	}
	if (c < 0xc2) {
		goto fail;
	}

	int len = (c < 0xe0 ? 1 :
		       c < 0xf0 ? 2 :
		       c < 0xf8 ? 3 :
		       c < 0xfc ? 4 :
		                  5
		       );
	// If reading the extra bytes causes EOF, it is an encoding
	// error, not a legitimate end of character stream.
	gu_in_bytes(in, p, len, err);
	if (gu_exn_caught(err, GuEOF)) {
		gu_exn_clear(err);
		goto fail;
	}
	if (!gu_ok(err)) {
		return;
	}
	*buf = p+len;
	return;

fail:
	gu_raise(err, GuUCSExn);
	return;
}

GU_API void
gu_utf8_encode(GuUCS ucs, uint8_t** buf)
{
	gu_require(gu_ucs_valid(ucs));
	uint8_t* p = *buf;
	if (ucs < 0x80) {
		p[0] = (uint8_t) ucs;
		*buf = p+1;
	} else if (ucs < 0x800) {
		p[0] = 0xc0 | (ucs >> 6);
		p[1] = 0x80 | (ucs & 0x3f);
		*buf = p+2;
	} else if (ucs < 0x10000) {
		p[0] = 0xe0 | (ucs >> 12);
		p[1] = 0x80 | ((ucs >> 6) & 0x3f);
		p[2] = 0x80 | (ucs & 0x3f);
		*buf = p+3;
	} else if (ucs < 0x200000) {
		p[0] = 0xf0 | (ucs >> 18);
		p[1] = 0x80 | ((ucs >> 12) & 0x3f);
		p[2] = 0x80 | ((ucs >> 6) & 0x3f);
		p[3] = 0x80 | (ucs & 0x3f);
		*buf = p+4;
	} else if (ucs < 0x4000000) {
		p[0] = 0xf8 | (ucs >> 24);
		p[1] = 0x80 | ((ucs >> 18) & 0x3f);
		p[2] = 0x80 | ((ucs >> 12) & 0x3f);
		p[3] = 0x80 | ((ucs >>  6) & 0x3f);
		p[4] = 0x80 | (ucs & 0x3f);
		*buf = p+5;
	} else {
		p[0] = 0xfc | (ucs >> 30);
		p[1] = 0x80 | ((ucs >> 24) & 0x3f);
		p[2] = 0x80 | ((ucs >> 18) & 0x3f);
		p[3] = 0x80 | ((ucs >> 12) & 0x3f);
		p[4] = 0x80 | ((ucs >> 6) & 0x3f);
		p[5] = 0x80 | (ucs & 0x3f);
		*buf = p+6;
	}
}

GU_API void
gu_out_utf8_(GuUCS ucs, GuOut* out, GuExn* err)
{
	uint8_t buf[6];
	uint8_t* p = buf;
	gu_utf8_encode(ucs, &p);
	gu_out_bytes(out, buf, p-buf, err);
}

extern inline void
gu_out_utf8(GuUCS ucs, GuOut* out, GuExn* err);
