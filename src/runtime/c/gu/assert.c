#include <gu/assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>

static const char*
gu_assert_mode_descs[] = {
	[GU_ASSERT_PRECOND] = "precondition failed",
	[GU_ASSERT_POSTCOND] = "postcondition failed",
	[GU_ASSERT_ASSERTION] = "assertion failed",
	[GU_ASSERT_NEVER] = "control should not reach here",
};

GU_API void
gu_abort_v_(GuAssertMode mode,
	    const char* file, const char* func, int line,
	    const char* msg_fmt, va_list args)
{
	const char* desc = gu_assert_mode_descs[mode];
	(void) fprintf(stderr, "%s (%s:%d): %s\n", func, file, line, desc);
	if (msg_fmt != NULL) {
		(void) fputc('\t', stderr);
		(void) vfprintf(stderr, msg_fmt, args);
		(void) fputc('\n', stderr);
	}
	abort();
}

GU_API void
gu_abort_(GuAssertMode mode,
	  const char* file, const char* func, int line,
	  const char* msg_fmt, ...)
{
	va_list args;
	va_start(args, msg_fmt);
	gu_abort_v_(mode, file, func, line, msg_fmt, args);
	va_end(args);
}

GU_API void 
gu_fatal(const char* fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	fputs("Fatal error", stderr);
	if (fmt) {
		fputs(": ", stderr);
		(void) vfprintf(stderr, fmt, args);
	}
	fputc('\n', stderr);
	abort();
}
