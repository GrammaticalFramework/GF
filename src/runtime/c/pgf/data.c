#include "data.h"
#include "expr.h"
#include <gu/type.h>
#include <gu/variant.h>
#include <gu/assert.h>

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



GU_DEFINE_TYPE(PgfTokens, GuSeq, gu_type(GuString));

GU_DEFINE_TYPE(PgfCId, typedef, gu_type(GuString));

GU_DEFINE_TYPE(GuStringL, GuList, gu_type(GuString));


#define gu_type__PgfCIdMap gu_type__GuStringMap
typedef GuType_GuStringMap GuType_PgfCIdMap;
#define GU_TYPE_INIT_PgfCIdMap GU_TYPE_INIT_GuStringMap

GU_DEFINE_TYPE(PgfCCat, struct,
	       GU_MEMBER_S(PgfCCat, cnccat, PgfCncCat),
           GU_MEMBER_P(PgfCCat, lindefs, PgfFunIds),
	       GU_MEMBER(PgfCCat, prods, PgfProductionSeq));

GU_DEFINE_TYPE(PgfCCatId, shared, gu_type(PgfCCat));

GU_DEFINE_TYPE(PgfCCatIds, GuList, gu_type(PgfCCatId));

GU_DEFINE_TYPE(PgfCCatSeq, GuSeq, gu_type(PgfCCatId));

GU_DEFINE_TYPE(PgfAlternative, struct,
	       GU_MEMBER(PgfAlternative, form, PgfTokens),
	       GU_MEMBER_P(PgfAlternative, prefixes, GuStringL));


GU_DEFINE_TYPE(
	PgfSymbol, GuVariant,
	GU_CONSTRUCTOR_S(
		PGF_SYMBOL_CAT, PgfSymbolCat,
		GU_MEMBER(PgfSymbolCat, d, int),
		GU_MEMBER(PgfSymbolCat, r, int)),
	GU_CONSTRUCTOR_S(
		PGF_SYMBOL_LIT, PgfSymbolLit,
		GU_MEMBER(PgfSymbolLit, d, int),
		GU_MEMBER(PgfSymbolLit, r, int)),
	GU_CONSTRUCTOR_S(
		PGF_SYMBOL_VAR, PgfSymbolVar,
		GU_MEMBER(PgfSymbolVar, d, int),
		GU_MEMBER(PgfSymbolVar, r, int)),
	GU_CONSTRUCTOR_S(
		PGF_SYMBOL_KS, PgfSymbolKS,
		GU_MEMBER(PgfSymbolKS, tokens, PgfTokens)),
	GU_CONSTRUCTOR_S(
		PGF_SYMBOL_KP, PgfSymbolKP,
		GU_MEMBER(PgfSymbolKP, default_form, PgfTokens),
		GU_MEMBER(PgfSymbolKP, n_forms, GuLength),
		GU_FLEX_MEMBER(PgfSymbolKP, forms, PgfAlternative)));

GU_DEFINE_TYPE(
	PgfCncCat, struct,
	GU_MEMBER(PgfCncCat, abscat, PgfCat),
	GU_MEMBER_P(PgfCncCat, cats, PgfCCatIds),
	GU_MEMBER(PgfCncCat, n_lins, size_t),
	GU_FLEX_MEMBER(PgfCncCat, labels, GuString));

// GU_DEFINE_TYPE(PgfSequence, GuList, gu_ptr_type(PgfSymbol));
// GU_DEFINE_TYPE(PgfSequence, GuList, gu_type(PgfSymbol));
GU_DEFINE_TYPE(PgfSequence, GuSeq, gu_type(PgfSymbol));

GU_DEFINE_TYPE(PgfFlags, GuStringMap, gu_type(PgfLiteral), &gu_null_variant);

typedef PgfFlags* PgfFlagsP;

GU_DEFINE_TYPE(PgfFlagsP, pointer, gu_type(PgfFlags));

GU_DEFINE_TYPE(PgfSequences, GuList, gu_type(PgfSequence));

GU_DEFINE_TYPE(PgfSeqId, typedef, gu_type(PgfSequence));

GU_DEFINE_TYPE(
	PgfCncFun, struct,
	GU_MEMBER(PgfCncFun, name, PgfCId),
	GU_MEMBER(PgfCncFun, n_lins, GuLength),
	GU_FLEX_MEMBER(PgfCncFun, lins, PgfSeqId));

GU_DEFINE_TYPE(PgfCncFuns, GuList, 
	       GU_TYPE_LIT(referenced, _, gu_ptr_type(PgfCncFun)));

GU_DEFINE_TYPE(PgfFunId, shared, gu_type(PgfCncFun));

GU_DEFINE_TYPE(PgfFunIds, GuList, gu_type(PgfFunId));

GU_DEFINE_TYPE(
	PgfPArg, struct,
	GU_MEMBER_P(PgfPArg, hypos, PgfCCatIds),
	GU_MEMBER(PgfPArg, ccat, PgfCCatId));

GU_DEFINE_TYPE(PgfPArgs, GuSeq, gu_type(PgfPArg));

GU_DEFINE_TYPE(
	PgfProduction, GuVariant,
	GU_CONSTRUCTOR_S(
		PGF_PRODUCTION_APPLY, PgfProductionApply,
		GU_MEMBER(PgfProductionApply, fun, PgfFunId),
		GU_MEMBER(PgfProductionApply, args, PgfPArgs)),
	GU_CONSTRUCTOR_S(
		PGF_PRODUCTION_COERCE, PgfProductionCoerce,
		GU_MEMBER(PgfProductionCoerce, coerce, PgfCCatId)),
	GU_CONSTRUCTOR_S(
		PGF_PRODUCTION_EXTERN, PgfProductionExtern,
		GU_MEMBER(PgfProductionExtern, fun, PgfFunId),
		GU_MEMBER(PgfProductionExtern, args, PgfPArgs),
		GU_MEMBER(PgfProductionExtern, callback, PgfLiteralCallback)));

GU_DEFINE_TYPE(PgfProductions, GuList, gu_type(PgfProduction));
GU_DEFINE_TYPE(PgfProductionSeq, GuSeq, gu_type(PgfProduction));

GU_DEFINE_TYPE(
	PgfPatt, GuVariant, 
	GU_CONSTRUCTOR_S(
		PGF_PATT_APP, PgfPattApp,
		GU_MEMBER(PgfPattApp, ctor, PgfCId),
		GU_MEMBER(PgfPattApp, n_args, GuLength),
		GU_FLEX_MEMBER(PgfPattApp, args, PgfPatt)),
	GU_CONSTRUCTOR_S(
		PGF_PATT_VAR, PgfPattVar,
		GU_MEMBER(PgfPattVar, var, PgfCId)),
	GU_CONSTRUCTOR_S(
		PGF_PATT_AS, PgfPattAs,
		GU_MEMBER(PgfPattAs, var, PgfCId),
		GU_MEMBER(PgfPattAs, patt, PgfPatt)),
	GU_CONSTRUCTOR(
		PGF_PATT_WILD, void),
	GU_CONSTRUCTOR_S(
		PGF_PATT_LIT, PgfPattLit,
		GU_MEMBER(PgfPattLit, lit, PgfLiteral)),
	GU_CONSTRUCTOR_S(
		PGF_PATT_IMPL_ARG, PgfPattImplArg,
		GU_MEMBER(PgfPattImplArg, patt, PgfPatt)),
	GU_CONSTRUCTOR_S(
		PGF_PATT_TILDE, PgfPattTilde,
		GU_MEMBER(PgfPattTilde, expr, PgfExpr)));

GU_DEFINE_TYPE(
	PgfEquation, struct, 
	GU_MEMBER(PgfEquation, body, PgfExpr),
	GU_MEMBER(PgfEquation, n_patts, GuLength),
	GU_FLEX_MEMBER(PgfEquation, patts, PgfPatt));

// Distinct type so we can give it special treatment in the reader
GU_DEFINE_TYPE(PgfEquationsM, GuSeq, gu_type(PgfEquation));

GU_DEFINE_TYPE(PgfExprProb, struct,
	GU_MEMBER(PgfExprProb, prob, double),
    GU_MEMBER(PgfExprProb, expr, PgfExpr));

GU_DEFINE_TYPE(
	PgfFunDecl, struct, 
	GU_MEMBER_P(PgfFunDecl, type, PgfType),
	GU_MEMBER(PgfFunDecl, arity, int),
	GU_MEMBER(PgfFunDecl, defns, PgfEquationsM),
	GU_MEMBER(PgfFunDecl, ep, PgfExprProb));

GU_DEFINE_TYPE(
	PgfCatFun, struct,
	GU_MEMBER(PgfCatFun, prob, double),
	GU_MEMBER(PgfCatFun, fun, PgfCId));

GU_DEFINE_TYPE(
	PgfCat, struct, 
	GU_MEMBER(PgfCat, context, PgfHypos),
	GU_MEMBER(PgfCat, n_functions, GuLength),
	GU_FLEX_MEMBER(PgfCat, functions, PgfCatFun));


GU_DEFINE_TYPE(
	PgfAbstr, struct, 
	GU_MEMBER(PgfAbstr, aflags, PgfFlagsP),
	GU_MEMBER_V(PgfAbstr, funs,
		    GU_TYPE_LIT(pointer, PgfCIdMap*,
				GU_TYPE_LIT(PgfCIdMap, _,
					    gu_ptr_type(PgfFunDecl),
					    &gu_null_struct))),
	GU_MEMBER_V(PgfAbstr, cats,
		    GU_TYPE_LIT(pointer, PgfCIdMap*,
				GU_TYPE_LIT(PgfCIdMap, _,
					    gu_ptr_type(PgfCat),
					    &gu_null_struct))));

GU_DEFINE_TYPE(
	PgfPrintNames, PgfCIdMap, gu_type(GuString), NULL);

GU_DEFINE_TYPE(
	PgfConcr, struct, 
	GU_MEMBER(PgfConcr, cflags, PgfFlagsP),
    GU_MEMBER_P(PgfConcr, ccats, GuMap),
    GU_MEMBER_P(PgfConcr, cncfuns, PgfCncFuns),
    GU_MEMBER_P(PgfConcr, sequences, PgfSequences),	
	GU_MEMBER_P(PgfConcr, printnames, PgfPrintNames),
	GU_MEMBER_V(PgfConcr, cnccats,
		    GU_TYPE_LIT(pointer, PgfCIdMap*,
				GU_TYPE_LIT(PgfCIdMap, _, 
					    gu_ptr_type(PgfCncCat),
					    &gu_null_struct))));

GU_DEFINE_TYPE(
	PgfPGF, struct, 
	GU_MEMBER(PgfPGF, major_version, uint16_t),
	GU_MEMBER(PgfPGF, minor_version, uint16_t),
	GU_MEMBER(PgfPGF, gflags, PgfFlagsP),
	GU_MEMBER(PgfPGF, absname, PgfCId),
	GU_MEMBER(PgfPGF, abstract, PgfAbstr),
	GU_MEMBER_V(PgfPGF, concretes,
		    GU_TYPE_LIT(pointer, PgfCIdMap*,
				GU_TYPE_LIT(PgfCIdMap, _,
					    gu_ptr_type(PgfConcr),
					    &gu_null_struct))));

