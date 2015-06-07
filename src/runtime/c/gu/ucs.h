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

GuUCS
gu_char_ucs(char c);

char
gu_ucs_char(GuUCS uc, GuExn* err);

size_t
gu_str_to_ucs(const char* cbuf, size_t len, GuUCS* ubuf, GuExn* err);

size_t
gu_ucs_to_str(const GuUCS* ubuf, size_t len, char* cbuf, GuExn* err);

bool gu_ucs_is_upper(GuUCS c);
bool gu_ucs_is_digit(GuUCS c);
bool gu_ucs_is_alpha(GuUCS c);
bool gu_ucs_is_cntrl(GuUCS c);
bool gu_ucs_is_space(GuUCS c);
bool gu_ucs_is_print(GuUCS c);
bool gu_ucs_is_lower(GuUCS c);

bool gu_ucs_is_alnum(GuUCS c);

GuUCS gu_ucs_to_lower(GuUCS c);
GuUCS gu_ucs_to_upper(GuUCS c);
GuUCS gu_ucs_to_title(GuUCS c);

int gu_ucs_is_gencat(GuUCS wc);

#endif // GU_ISO10646_H_
