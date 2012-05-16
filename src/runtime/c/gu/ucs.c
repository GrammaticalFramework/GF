#include <gu/ucs.h>
#include <gu/assert.h>
#include <config.h>

GU_DEFINE_TYPE(GuUCSExn, abstract, _);


#ifdef CHAR_ASCII

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

#else // defined(CHAR_ASCII)

static const char gu_ucs_ascii[128] =
	"\0\0\0\0\0\0\0\a\b\t\n\v\f\r\0\0"
	"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	" !\"#\0%&'()*+,-./0123456789:;<=>?"
	"\0ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_"
	"\0abcdefghijklmnopqrstuvwxyz{|}~\0";

const uint8_t gu_ucs_ascii_reverse_[CHAR_MAX] = {
	['\0'] = 0x00, ['\a'] = 0x07, ['\b'] = 0x08, ['\t'] = 0x09,
	['\n'] = 0x0a, ['\v'] = 0x0b, ['\f'] = 0x0c, ['\r'] = 0x0d,
	[' '] = 0x20, ['!'] = 0x21, ['"'] = 0x22, ['#'] = 0x23, ['%'] = 0x25,
	['&'] = 0x26, ['\''] = 0x27, ['('] = 0x28, [')'] = 0x29, ['*'] = 0x2a,
	['+'] = 0x2b, [','] = 0x2c, ['-'] = 0x2d, ['.'] = 0x2e, ['/'] = 0x2f,
	['0'] = 0x30, ['1'] = 0x31, ['2'] = 0x32, ['3'] = 0x33, ['4'] = 0x34,
	['5'] = 0x35, ['6'] = 0x36, ['7'] = 0x37, ['8'] = 0x38, ['9'] = 0x39,
	[':'] = 0x3a, [';'] = 0x3b, ['<'] = 0x3c, ['='] = 0x3d, ['>'] = 0x3e,
	['?'] = 0x3f, ['A'] = 0x41, ['B'] = 0x42, ['C'] = 0x43, ['D'] = 0x44,
	['E'] = 0x45, ['F'] = 0x46, ['G'] = 0x47, ['H'] = 0x48, ['I'] = 0x49,
	['J'] = 0x4a, ['K'] = 0x4b, ['L'] = 0x4c, ['M'] = 0x4d, ['N'] = 0x4e,
	['O'] = 0x4f, ['P'] = 0x50, ['Q'] = 0x51, ['R'] = 0x52, ['S'] = 0x53,
	['T'] = 0x54, ['U'] = 0x55, ['V'] = 0x56, ['W'] = 0x57, ['X'] = 0x58,
	['Y'] = 0x59, ['Z'] = 0x5a, ['['] = 0x5b, ['\\'] = 0x5c, [']'] = 0x5d,
	['^'] = 0x5e, ['_'] = 0x5f, ['a'] = 0x61, ['b'] = 0x62, ['c'] = 0x63,
	['d'] = 0x64, ['e'] = 0x65, ['f'] = 0x66, ['g'] = 0x67, ['h'] = 0x68,
	['i'] = 0x69, ['j'] = 0x6a, ['k'] = 0x6b, ['l'] = 0x6c, ['m'] = 0x6d,
	['n'] = 0x6e, ['o'] = 0x6f, ['p'] = 0x70, ['q'] = 0x71, ['r'] = 0x72,
	['s'] = 0x73, ['t'] = 0x74, ['u'] = 0x75, ['v'] = 0x76, ['w'] = 0x77,
	['x'] = 0x78, ['y'] = 0x79, ['z'] = 0x7a, ['{'] = 0x7b, ['|'] = 0x7c,
	['}'] = 0x7d, ['~'] = 0x7e
};


bool
gu_char_is_valid(char c)
{
	if (c > 0) {
		return (gu_ucs_ascii_reverse_[(int) c] > 0);
	}
	return (c == '\0');
}

char
gu_ucs_char(GuUCS uc, GuExn* err)
{
	if (uc == 0) {
		return '\0';
	} else if (0 < uc && uc <= 127) {
		char c = gu_ucs_ascii[uc];
		if (c != '\0') {
			return (unsigned char) c;
		}
	}
	gu_raise(err, GuUCSExn);
	return 0;
}

#endif

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

extern inline GuUCS
gu_char_ucs(char c);
