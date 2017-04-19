#include "data.h"
#include <gu/variant.h>
#include <gu/assert.h>
#include <math.h>

PGF_INTERNAL bool 
pgf_tokens_equal(PgfTokens* t1, PgfTokens* t2)
{
	size_t len1 = gu_seq_length(t1);
	size_t len2 = gu_seq_length(t2);
	if (len1 != len2) {
		return false;
	}
	for (size_t i = 0; i < len1; i++) {
		GuString s1 = gu_seq_get(t1, PgfToken, i);
		GuString s2 = gu_seq_get(t2, PgfToken, i);
		if (strcmp(s1, s2) != 0) {
			return false;
		}
	}
	return true;
}

static int
pgf_flag_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, ((PgfFlag*) p2)->name);
}

PGF_INTERNAL GuOrder pgf_flag_order[1] = { { pgf_flag_cmp_fn } };

static int
pgf_abscat_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, ((PgfAbsCat*) p2)->name);
}

PGF_INTERNAL GuOrder pgf_abscat_order[1] = { { pgf_abscat_cmp_fn } };

static int
pgf_absfun_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, ((PgfAbsFun*) p2)->name);
}

PGF_INTERNAL GuOrder pgf_absfun_order[1] = { { pgf_absfun_cmp_fn } };

static int
pgf_concr_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, ((PgfConcr*) p2)->name);
}

PGF_INTERNAL GuOrder pgf_concr_order[1] = { { pgf_concr_cmp_fn } };
