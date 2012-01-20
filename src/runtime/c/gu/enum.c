#include <gu/enum.h>

void
gu_enum_next(GuEnum* en, void* to, GuPool* pool)
{
	en->next(en, to, pool);
}
