#include <gu/choice.h>
#include <gu/seq.h>
#include <gu/assert.h>
#include <gu/log.h>

struct GuChoice {
	GuBuf* path;
	size_t path_idx;
};

GuChoice*
gu_new_choice(GuPool* pool)
{
	GuChoice* ch = gu_new(GuChoice, pool);
	ch->path = gu_new_buf(uint8_t, pool);
	ch->path_idx = 0;
	return ch;
}

GuChoiceMark
gu_choice_mark(GuChoice* ch)
{
	gu_assert(ch->path_idx <= gu_buf_length(ch->path));
	gu_debug("%p@%d: mark", ch, ch->path_idx);
	return (GuChoiceMark){ch->path_idx};
}

void
gu_choice_reset(GuChoice* ch, GuChoiceMark mark)
{
	gu_assert(ch->path_idx <= gu_buf_length(ch->path));
	gu_debug("%p@%d: reset %d", ch, ch->path_idx, mark.path_idx);
	gu_require(mark.path_idx <= ch->path_idx );
	ch->path_idx = mark.path_idx;
}

int
gu_choice_next(GuChoice* ch, int n_choices)
{
	gu_assert(n_choices >= 0);
	gu_require(n_choices <= UINT8_MAX);
	gu_assert(ch->path_idx <= gu_buf_length(ch->path));
	if (n_choices == 0) {
		return -1;
	}
	int i = 0;
	if (gu_buf_length(ch->path) > ch->path_idx) {
		i = (int) gu_buf_get(ch->path, uint8_t, ch->path_idx);
		gu_assert(i <= n_choices);
	} else {
		gu_buf_push(ch->path, uint8_t, n_choices);
		i = n_choices;
	}
	int ret = (i == 0) ? -1 : n_choices - i;
	gu_debug("%p@%d: %d", ch, ch->path_idx, ret);
	ch->path_idx++;
	return ret;
}

bool
gu_choice_advance(GuChoice* ch)
{
	gu_assert(ch->path_idx <= gu_buf_length(ch->path));
	
	while (gu_buf_length(ch->path) > ch->path_idx) {
		uint8_t last = gu_buf_pop(ch->path, uint8_t);
		if (last > 1) {
			gu_buf_push(ch->path, uint8_t, last-1);
			return true;
		}
	}
	return false;
}
