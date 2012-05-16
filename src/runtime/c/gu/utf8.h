#ifndef GU_UTF8_H_
#define GU_UTF8_H_

#include <gu/in.h>
#include <gu/out.h>
#include <gu/ucs.h>

inline GuUCS
gu_in_utf8(GuIn* in, GuExn* err)
{
	int i = gu_in_peek_u8(in);
	if (i >= 0 && i < 0x80) {
		gu_in_consume(in, 1);
		return (GuUCS) i;
	}
	extern GuUCS gu_in_utf8_(GuIn* in, GuExn* err);
	return gu_in_utf8_(in, err);
}


inline char
gu_in_utf8_char(GuIn* in, GuExn* err)
{
#ifdef CHAR_ASCII
	int i = gu_in_peek_u8(in);
	if (i >= 0 && i < 0x80) {
		gu_in_consume(in, 1);
		return (char) i;
	}
#endif
	extern char gu_in_utf8_char_(GuIn* in, GuExn* err);
	return gu_in_utf8_char_(in, err);
}

void
gu_out_utf8_long_(GuUCS ucs, GuOut* out, GuExn* err);

inline void
gu_out_utf8(GuUCS ucs, GuOut* out, GuExn* err)
{
	gu_require(gu_ucs_valid(ucs));
	if (GU_LIKELY(ucs < 0x80)) {
		gu_out_u8(out, ucs, err);
	} else {
		gu_out_utf8_long_(ucs, out, err);
	}
}

size_t
gu_utf32_out_utf8(const GuUCS* src, size_t len, GuOut* out, GuExn* err);

GuUCS
gu_utf8_decode(const uint8_t** utf8);

inline void 
gu_str_out_utf8(const char* str, GuOut* out, GuExn* err)
{
#ifdef CHAR_ASCII
	gu_out_bytes(out, (const uint8_t*) str, strlen(str), err);
#else
	extern void 
		gu_str_out_utf8_(const char* str, GuOut* out, GuExn* err);
	gu_str_out_utf8_(str, out, err);
#endif
}

#endif // GU_UTF8_H_
