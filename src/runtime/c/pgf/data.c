#include "data.h"
#include <gu/type.h>
#include <gu/variant.h>
#include <gu/assert.h>
#include <math.h>

bool 
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

GU_DEFINE_TYPE(PgfCId, typedef, gu_type(GuString));

#define gu_type__PgfCIdMap gu_type__GuStringMap
typedef GuType_GuStringMap GuType_PgfCIdMap;
#define GU_TYPE_INIT_PgfCIdMap GU_TYPE_INIT_GuStringMap

GU_DEFINE_TYPE(PgfCCat, abstract);

GU_DEFINE_TYPE(PgfCncCat, abstract);

GU_DEFINE_TYPE(PgfDummyVariant, GuVariant);

static int
pgf_flag_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, ((PgfFlag*) p2)->name);
}

GuOrder pgf_flag_order[1] = { { pgf_flag_cmp_fn } };


GU_DEFINE_TYPE(PgfProductionSeq, abstract);
GU_DEFINE_TYPE(PgfProductionBuf, abstract);

static prob_t inf_prob = INFINITY;

GU_DEFINE_TYPE(prob_t, GuFloating, _);

GU_DEFINE_TYPE(PgfMetaChildMap, GuMap,
		       gu_type(PgfAbsCat), NULL,
		       gu_type(prob_t), &inf_prob);

GU_DEFINE_TYPE(PgfAbsCat, abstract);

static int
pgf_abscat_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, ((PgfAbsCat*) p2)->name);
}

GuOrder pgf_abscat_order[1] = { { pgf_abscat_cmp_fn } };

static int
pgf_absfun_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, ((PgfAbsFun*) p2)->name);
}

GuOrder pgf_absfun_order[1] = { { pgf_absfun_cmp_fn } };


static GuString empty_string = "";

GU_DEFINE_TYPE(
	PgfPrintNames, PgfCIdMap, gu_type(GuString), &empty_string);

static int
pgf_concr_cmp_fn(GuOrder* self, const void* p1, const void* p2)
{
	(void) self;
	return strcmp((GuString) p1, ((PgfConcr*) p2)->name);
}

GuOrder pgf_concr_order[1] = { { pgf_concr_cmp_fn } };
