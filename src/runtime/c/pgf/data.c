#include "data.h"
#include <gu/type.h>
#include <gu/variant.h>
#include <gu/assert.h>
#include <math.h>

bool 
pgf_tokens_equal(PgfTokens t1, PgfTokens t2)
{
	size_t len1 = gu_seq_length(t1);
	size_t len2 = gu_seq_length(t2);
	if (len1 != len2) {
		return false;
	}
	for (size_t i = 0; i < len1; i++) {
		GuString s1 = gu_seq_get(t1, PgfToken, i);
		GuString s2 = gu_seq_get(t2, PgfToken, i);
		if (!gu_string_eq(s1, s2)) {
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

GU_DEFINE_TYPE(PgfFlags, GuStringMap, gu_type(PgfDummyVariant), &gu_null_variant);

GU_DEFINE_TYPE(PgfProductionSeq, GuSeq, gu_type(PgfDummyVariant));

GU_DEFINE_TYPE(PgfAbsFun, abstract);

static prob_t inf_prob = INFINITY;

GU_DEFINE_TYPE(prob_t, GuFloating, _);

GU_DEFINE_TYPE(PgfMetaChildMap, GuMap,
		       gu_type(PgfAbsCat), NULL,
		       gu_type(prob_t), &inf_prob);

GU_DEFINE_TYPE(PgfAbsCat, abstract);

GU_DEFINE_TYPE(
	PgfPrintNames, PgfCIdMap, gu_type(GuString), &gu_empty_string);

GU_DEFINE_TYPE(PgfConcr, abstract);
