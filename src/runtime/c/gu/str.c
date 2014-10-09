#include <gu/assert.h>
#include <gu/str.h>
#include <string.h>
#include <wchar.h>
#include <stdio.h>
#include <stdlib.h>

const char gu_empty_str[] = "";
const char* const gu_null_str = NULL;

char* 
gu_new_str(size_t size, GuPool* pool)
{
	char* str = gu_new_n(char, size + 1, pool);
	memset(str, '\0', size + 1);
	return str;
}

char*
gu_strdup(const char* cstr, GuPool* pool)
{
	int len = strlen(cstr);
	char* str = gu_new_str(len, pool);
	memcpy(str, cstr, len);
	return str;
}

bool
gu_str_eq(GuStr s1, GuStr s2)
{
	return (strcmp(s1, s2)) == 0;
}

static bool
gu_str_is_equal(GuEquality* self, const void* p1, const void* p2)
{
	(void) self;
	const GuStr* sp1 = p1;
	const GuStr* sp2 = p2;
	return gu_str_eq(*sp1, *sp2);
}

static GuHash
gu_str_hasher_hash(GuHasher* self, const void* p)
{
	(void) self;
	GuHash h = 0;
	const GuStr* sp = p;
	for (const char* s = *sp; *s != '\0'; s++) {
		h = 101 * h + (unsigned char) *s;
	}
	return h;
}

GuHasher gu_str_hasher[1] = {
	{
		.eq = { .is_equal = gu_str_is_equal },
		.hash = gu_str_hasher_hash
	}
};

char* 
gu_vasprintf(const char* fmt, va_list args, GuPool* pool)
{
	va_list args2;
	va_copy(args2, args);
	int len = vsnprintf(NULL, 0, fmt, args2);
	gu_assert_msg(len >= 0, "Invalid format string: \"%s\"", fmt);
	va_end(args2);
	char* str = gu_new_str(len, pool);
	vsnprintf(str, len + 1, fmt, args);
	return str;
}

char* 
gu_asprintf(GuPool* pool, const char* fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	char* str = gu_vasprintf(fmt, args, pool);
	va_end(args);
	return str;
}
