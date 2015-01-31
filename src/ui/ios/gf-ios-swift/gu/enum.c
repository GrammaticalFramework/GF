#include <gu/enum.h>

void
gu_enum_next(GuEnum* en, void* to, GuPool* pool)
{
//    printf("%p", *((void**)to));
	en->next(en, to, pool);
//    void*p = *((void**)to);
//    printf("%f, %p, %p\n", *((float*)p), *(void**)(((float*)p)+1), p);
}
