#include <gu/choice.h>
#include <gu/seq.h>
#include <gu/assert.h>

struct GuChoice {
	GuBuf* path;
	size_t path_idx;
};

GU_API GuChoice*
gu_new_choice(GuPool* pool)
{
	GuChoice* ch = gu_new(GuChoice, pool);
	ch->path = gu_new_buf(size_t, pool);
	ch->path_idx = 0;
	return ch;
}

GU_API GuChoiceMark
gu_choice_mark(GuChoice* ch)
{
	gu_assert(ch->path_idx <= gu_buf_length(ch->path));
	return (GuChoiceMark){ch->path_idx};
}

GU_API void
gu_choice_reset(GuChoice* ch, GuChoiceMark mark)
{
	gu_assert(ch->path_idx <= gu_buf_length(ch->path));
	gu_require(mark.path_idx <= ch->path_idx );
	ch->path_idx = mark.path_idx;
}

GU_API int
gu_choice_next(GuChoice* ch, int n_choices)
{
	gu_assert(n_choices >= 0);
	gu_assert(ch->path_idx <= gu_buf_length(ch->path));
	if (n_choices == 0) {
		return -1;
	}
	int i = 0;
	if (gu_buf_length(ch->path) > ch->path_idx) {
		i = (int) gu_buf_get(ch->path, size_t, ch->path_idx);
		gu_assert(i <= n_choices);
	} else {
		gu_buf_push(ch->path, size_t, n_choices);
		i = n_choices;
	}
	int ret = (i == 0) ? -1 : n_choices - i;
	ch->path_idx++;
	return ret;
}

GU_API bool
gu_choice_advance(GuChoice* ch)
{
	gu_assert(ch->path_idx <= gu_buf_length(ch->path));
	
	while (gu_buf_length(ch->path) > ch->path_idx) {
		size_t last = gu_buf_pop(ch->path, size_t);
		if (last > 1) {
			gu_buf_push(ch->path, size_t, last-1);
			return true;
		}
	}
	return false;
}
