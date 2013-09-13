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

inline void
gu_out_utf8(GuUCS ucs, GuOut* out, GuExn* err)
{
	gu_require(gu_ucs_valid(ucs));
	if (GU_LIKELY(ucs < 0x80)) {
		gu_out_u8(out, ucs, err);
	} else {
		extern void gu_out_utf8_(GuUCS ucs, GuOut* out, GuExn* err);
		gu_out_utf8_(ucs, out, err);
	}
}

GuUCS
gu_utf8_decode(const uint8_t** utf8);

#endif // GU_UTF8_H_
