#ifndef GU_ASSERT_H_
#define GU_ASSERT_H_

#include <gu/defs.h>

typedef enum {
	GU_ASSERT_PRECOND,
	GU_ASSERT_ASSERTION,
	GU_ASSERT_POSTCOND,
	GU_ASSERT_NEVER
} GuAssertMode;

GU_API_DECL void
gu_abort_v_(GuAssertMode mode, 
	    const char* file, const char* func, int line,
	    const char* msg_fmt, va_list args);

GU_API_DECL void
gu_abort_(GuAssertMode mode, 
	  const char* file, const char* func, int line,
	  const char* msg_fmt, ...);

#ifndef NDEBUG
#define gu_assertion_(mode_, expr_, ...) \
	GU_BEGIN							\
	if (!(expr_)) {							\
		gu_abort_(mode_, __FILE__, __func__, __LINE__, __VA_ARGS__);	\
	}								\
	GU_END
#else
// this should prevent unused variable warnings when a variable is only used
// in an assertion
#define gu_assertion_(mode_, expr_, ...)	\
	GU_BEGIN				\
	(void) (sizeof (expr_));		\
	GU_END
#endif


#define gu_require(expr)				\
	gu_assertion_(GU_ASSERT_PRECOND, expr, "%s", #expr)

#define gu_assert_msg(expr, ...)				\
	gu_assertion_(GU_ASSERT_ASSERTION, expr, __VA_ARGS__)

#define gu_assert(expr)				\
	gu_assert_msg(expr, "%s", #expr)

#define gu_ensure(expr)						\
	gu_assertion_(GU_ASSERT_POSTCOND, expr, "%s", #expr)

#define gu_impossible_msg(...)			\
	gu_assertion_(GU_ASSERT_ASSERTION, false, __VA_ARGS__)

#define gu_impossible()				\
	gu_impossible_msg(NULL)

GU_API_DECL void
gu_fatal(const char* fmt, ...);

#endif /* GU_ASSERT_H_ */
