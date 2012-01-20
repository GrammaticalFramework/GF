#ifndef GU_LOG_H_
#define GU_LOG_H_

#include <stdarg.h>

typedef enum GuLogKind {
	GU_LOG_KIND_ENTER,
	GU_LOG_KIND_EXIT,
	GU_LOG_KIND_DEBUG,
	GU_LOG_KIND_ERROR
} GuLogKind;

void
gu_log_full(GuLogKind kind, const char* func, const char* file, int line,
	    const char* fmt, ...);


void
gu_log_full_v(GuLogKind kind, const char* func, const char* file, int line,
	      const char* fmt, va_list args);


#ifndef NDEBUG

#define gu_logv(kind_, fmt_, args_)					\
	gu_log_full_v(kind_, __func__, __FILE__, __LINE__, fmt_, args_)

#define gu_log(kind_, ...)			\
	gu_log_full(kind_, __func__, __FILE__, __LINE__, __VA_ARGS__)

#else

static inline void
gu_logv(GuLogKind kind, const char* fmt, va_list args)
{
	(void) kind;
	(void) fmt;
	(void) args;
}

static inline void
gu_log(GuLogKind kind, const char* fmt, ...)
{
	(void) kind;
	(void) fmt;
}

#endif




#define gu_enter(...)			\
	gu_log(GU_LOG_KIND_ENTER, __VA_ARGS__)

#define gu_exit(...)				\
	gu_log(GU_LOG_KIND_EXIT, __VA_ARGS__)

#define gu_debug(...)				\
	gu_log(GU_LOG_KIND_DEBUG, __VA_ARGS__)

#define gu_debugv(kind_, fmt_, args_) \
	gu_logv(GU_LOG_KIND_DEBUG, fmt_, args_)

#endif // GU_LOG_H_
