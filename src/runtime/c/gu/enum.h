#ifndef GU_ENUM_H_
#define GU_ENUM_H_

#include <gu/mem.h>

typedef struct GuEnum GuEnum;

struct GuEnum {
	void (*next)(GuEnum* self, void* to, GuPool* pool);
};

GU_API_DECL void
gu_enum_next(GuEnum* en, void* to, GuPool* pool);

#ifdef GU_GNUC

#define gu_next(ENUM, T, POOL)						\
	({								\
		T gu_next_tmp_;						\
		gu_enum_next((ENUM), &gu_next_tmp_, (POOL));		\
		gu_next_tmp_;						\
	})
#else
static inline void*
gu_enum_next_(GuEnum* en, void* to, GuPool* pool)
{
	gu_enum_next(en, to, pool);
	return to;
}
#define gu_next(ENUM, T, POOL)			\
	(*(T*)gu_enum_next_((ENUM), &(T){0}, (POOL)))

#endif

#endif /* GU_ENUM_H_ */
