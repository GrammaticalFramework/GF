#ifndef GU_STRING_H_
#define GU_STRING_H_

#include <gu/bits.h>
#include <gu/in.h>
#include <gu/out.h>

typedef const char* GuString;

GU_API_DECL GuString
gu_string_copy(GuString string, GuPool* pool);

GU_API_DECL void
gu_string_write(GuString string, GuOut* out, GuExn* err);

GU_API_DECL GuString
gu_string_read(size_t len, GuPool* pool, GuIn* in, GuExn* err);

GU_API_DECL GuString
gu_string_read_latin1(size_t len, GuPool* pool, GuIn* in, GuExn* err);

GU_API_DECL GuIn*
gu_string_in(GuString string, GuPool* pool);

typedef struct GuStringBuf GuStringBuf;

GU_API_DECL GuStringBuf*
gu_new_string_buf(GuPool* pool);

GU_API_DECL GuOut*
gu_string_buf_out(GuStringBuf* sb);

GU_API_DECL GuString
gu_string_buf_freeze(GuStringBuf* sb, GuPool* pool);

GU_API_DECL char*
gu_string_buf_data(GuStringBuf* sb);

GU_API_DECL size_t
gu_string_buf_length(GuStringBuf* sb);

GU_API_DECL void
gu_string_buf_flush(GuStringBuf* sb);

GU_API_DECL GuString
gu_format_string_v(const char* fmt, va_list args, GuPool* pool);

GU_API_DECL GuString
gu_format_string(GuPool* pool, const char* fmt, ...);

GU_API_DECL bool
gu_string_to_int(GuString s, int *res);

GU_API_DECL bool
gu_string_to_double(GuString s, double *res);

GU_API_DECL void
gu_double_to_string(double val, GuOut* out, GuExn* err);

GU_API_DECL bool
gu_string_is_prefix(GuString s1, GuString s2);

#endif // GU_STRING_H_

#if defined(GU_FUN_H_) && !defined(GU_STRING_H_FUN_)
#define GU_STRING_H_FUN_
GU_API_DECL extern GuEquality gu_string_equality[1];

GU_API_DECL extern GuOrder gu_string_order[1];
#endif

#if defined(GU_HASH_H_) && !defined(GU_STRING_H_HASH_)
#define GU_STRING_H_HASH_

GU_API_DECL GuHash
gu_string_hash(GuHash h, GuString s);

GU_API_DECL extern GuHasher gu_string_hasher[1];
#endif

#if defined(GU_SEQ_H_) && !defined(GU_STRING_H_SEQ_)
#define GU_STRING_H_SEQ_

typedef GuSeq GuStrings;
#endif


#if defined(GU_MAP_H_) && !defined(GU_STRING_H_MAP_)
#define GU_STRING_H_MAP_

typedef GuMap GuStringMap;

#define gu_new_string_map(VAL_T, DEFAULT, POOL)				\
	gu_new_map(GuString, gu_string_hasher, VAL_T, (DEFAULT), (POOL))

#endif

