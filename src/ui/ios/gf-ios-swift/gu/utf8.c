#include <gu/assert.h>
#include <gu/utf8.h>

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

static size_t
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


void
gu_out_utf8_(GuUCS ucs, GuOut* out, GuExn* err)
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

void
gu_in_utf8_buf(uint8_t** buf, GuIn* in, GuExn* err)
{
	uint8_t* p = *buf;

	uint8_t c = gu_in_u8(in, err);
	if (!gu_ok(err)) {
		return;
	}
	*(p++) = c;
	int len = (c < 0x80 ? 0 : 
		   c < 0xc2 ? -1 :
		   c < 0xe0 ? 1 :
		   c < 0xf0 ? 2 :
		   c < 0xf5 ? 3 :
		   -1);
	if (len < 0) {
	 	goto fail;
	} else if (len == 0) {
		*buf = p;
		return;
	}
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
