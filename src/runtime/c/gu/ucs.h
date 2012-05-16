#ifndef GU_UCS_H_
#define GU_UCS_H_

#include <gu/defs.h>
#include <gu/exn.h>
#include <gu/assert.h>


#if defined(__STDC_ISO_10646__) && WCHAR_MAX >= 0x10FFFF
#include <wchar.h>
#define GU_UCS_WCHAR
typedef wchar_t GuUCS;
#else
typedef int32_t GuUCS;
#endif

#define GU_UCS_MAX ((GuUCS)(0x10FFFF))

bool
gu_char_is_valid(char c);

inline bool
gu_ucs_valid(GuUCS ucs)
{
	return ucs >= 0 && ucs <= GU_UCS_MAX;
}

inline GuUCS
gu_char_ucs(char c)
{
	gu_require(gu_char_is_valid(c));
#ifdef CHAR_ASCII
	GuUCS u = (GuUCS) c;
#else
	extern const uint8_t gu_ucs_ascii_reverse_[CHAR_MAX];
	GuUCS u = gu_ucs_ascii_reverse_[(unsigned char) c];
#endif
	gu_ensure(u < 0x80);
	return u;
}

char
gu_ucs_char(GuUCS uc, GuExn* err);

size_t
gu_str_to_ucs(const char* cbuf, size_t len, GuUCS* ubuf, GuExn* err);

size_t
gu_ucs_to_str(const GuUCS* ubuf, size_t len, char* cbuf, GuExn* err);

extern GU_DECLARE_TYPE(GuUCSExn, abstract);

#endif // GU_ISO10646_H_
