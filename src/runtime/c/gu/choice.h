#ifndef GU_CHOICE_H_
#define GU_CHOICE_H_

#include <gu/mem.h>

typedef struct GuChoice GuChoice;

typedef struct GuChoiceMark GuChoiceMark;

GU_API_DECL GuChoice*
gu_new_choice(GuPool* pool);

GU_API_DECL int
gu_choice_next(GuChoice* ch, int n_choices);

GU_API_DECL GuChoiceMark
gu_choice_mark(GuChoice* ch);

GU_API_DECL void
gu_choice_reset(GuChoice* ch, GuChoiceMark mark);

GU_API_DECL bool
gu_choice_advance(GuChoice* ch);


// private

struct GuChoiceMark {
	size_t path_idx;
};






#endif // GU_CHOICE_H_
