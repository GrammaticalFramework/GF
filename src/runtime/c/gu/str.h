#ifndef GU_STR_H_
#define GU_STR_H_

#include <gu/mem.h>
#include <gu/hash.h>

extern const char gu_empty_str[];
extern const char* const gu_null_str;

typedef const char* GuStr;

char* gu_new_str(size_t size, GuPool* pool);

char* gu_strdup(const char* str, GuPool* pool);

bool
gu_str_eq(GuStr s1, GuStr s2);

extern GuHasher gu_str_hasher[1];

char* gu_vasprintf(const char* fmt, va_list args, GuPool* pool);

char* gu_asprintf(GuPool* pool, const char* fmt, ...);

#endif // GU_STR_H_
