#ifndef GU_SYSDEPS_H_
#define GU_SYSDEPS_H_

#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
# define GU_GNUC
#endif

#ifdef GU_GNUC
# define GU_ALIGNOF __alignof
# define GU_GNUC_ATTR(x) __attribute__(( x ))
# if defined(__OPTIMIZE_SIZE__)
#  define GU_OPTIMIZE_SIZE
# elif defined(__OPTIMIZE__)
#  define GU_OPTIMIZE_SPEED
# endif
#else
# define GU_GNUC_ATTR(x)
#endif

#ifdef S_SPLINT_S
# define GU_SPLINT(x) %{ x %}
#else
# define GU_SPLINT(x)
#endif


#endif // GU_SYSDEPS_H_
