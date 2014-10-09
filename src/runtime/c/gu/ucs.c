#include <gu/ucs.h>
#include <gu/assert.h>

bool
gu_char_is_valid(char c)
{
	if (c < 0) {
		return false;
	} else if (c < 64) {
		return UINT64_C(0xffffffef00003f81) & (UINT64_C(1) << c);
	}
#if CHAR_MAX > 127 // Let's avoid spurious warnings
	else if (c > 127) {
		return false;
	}
#endif	
	return UINT64_C(0x7ffffffefffffffe) & (UINT64_C(1) << (c - 64));
}

char
gu_ucs_char(GuUCS uc, GuExn* err)
{
	if (0 <= uc && uc <= 127) {
		char c = (char) uc;
		if (gu_char_is_valid(c)) {
			return c;
		}
	}
	gu_raise(err, GuUCSExn);
	return 0;
}

size_t
gu_str_to_ucs(const char* cbuf, size_t len, GuUCS* ubuf, GuExn* err)
{
	size_t n = 0;
	while (n < len) {
		char c = cbuf[n];
		if (!gu_char_is_valid(c)) {
			gu_raise(err, GuUCSExn);
			return n;
		}
		ubuf[n] = gu_char_ucs(c);
		n++;
	}
	return n;
}

size_t
gu_ucs_to_str(const GuUCS* ubuf, size_t len, char* cbuf, GuExn* err)
{
	size_t n = 0;
	while (n < len) {
		char c = gu_ucs_char(ubuf[n], err);
		if (!gu_ok(err)) {
			break;
		}
		cbuf[n] = c;
		n++;
	}
	return n;
}


extern inline bool
gu_ucs_valid(GuUCS ucs);

GuUCS
gu_char_ucs(char c)
{
	gu_require(gu_char_is_valid(c));
	GuUCS u = (GuUCS) c;
	gu_ensure(u < 0x80);
	return u;
}
