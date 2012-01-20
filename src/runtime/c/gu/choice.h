#ifndef GU_CHOICE_H_
#define GU_CHOICE_H_

#include <gu/mem.h>

typedef struct GuChoice GuChoice;

typedef struct GuChoiceMark GuChoiceMark;

GuChoice*
gu_new_choice(GuPool* pool);

int
gu_choice_next(GuChoice* ch, int n_choices);

GuChoiceMark
gu_choice_mark(GuChoice* ch);

void
gu_choice_reset(GuChoice* ch, GuChoiceMark mark);

bool
gu_choice_advance(GuChoice* ch);


// private

struct GuChoiceMark {
	size_t path_idx;
};






#endif // GU_CHOICE_H_
