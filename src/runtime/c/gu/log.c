#include <gu/defs.h>
#include <gu/log.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

static int gu_log_depth = 0;

static bool
gu_log_match(const char* pat, size_t patlen, const char* str)
{
	if (patlen > 0 && pat[patlen-1] == '*') {
		return strncmp(pat, str, patlen-1) == 0;
	} else if (strlen(str) == patlen) {
		return strncmp(pat, str, patlen) == 0;
	} 
	return false;
}

static bool
gu_log_enabled(const char* func, const char* file)
{
	const char* cfg = getenv("GU_LOG");
	if (cfg == NULL) {
		return false;
	}
	const char* p = cfg;
	while (true) {
		size_t len = strcspn(p, ",");
		if (gu_log_match(p, len, func)) {
			return true;
		}
		if (gu_log_match(p, len, file)) {
			return true;
		}
		if (p[len] == '\0') {
			break;
		}
		p = &p[len + 1];
	} 
	return false;
}


void
gu_log_full_v(GuLogKind kind, const char* func, const char* file, int line,
	      const char* fmt, va_list args)
{
	(void) (kind && line);
	if (!gu_log_enabled(func, file)) {
		return;
	}
	if (kind == GU_LOG_KIND_EXIT) {
		gu_log_depth--;
	}
	if (fmt) {
		int indent = gu_min(32 + gu_log_depth, 48);
		fprintf(stderr, "%-*s: ", indent, func);
		vfprintf(stderr, fmt, args);
		fputc('\n', stderr);
		fflush(stderr);
	}
	if (kind == GU_LOG_KIND_ENTER) {
		gu_log_depth++;
	}
}

void
gu_log_full(GuLogKind kind, const char* func, const char* file, int line,
	    const char* fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	gu_log_full_v(kind, func, file, line, fmt, args);
	va_end(args);
}

