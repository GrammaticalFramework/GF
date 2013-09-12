#include "data.h"
#include "expr.h"
#include "literals.h"
#include "reader.h"
#include "jit.h"

#include <gu/defs.h>
#include <gu/map.h>
#include <gu/seq.h>
#include <gu/assert.h>
#include <gu/in.h>
#include <gu/bits.h>
#include <gu/exn.h>
#include <gu/utf8.h>
#include <math.h>
#include <stdio.h>

//
// PgfReader
// 

struct PgfReader {
	GuIn* in;
	GuExn* err;
	GuPool* opool;
	GuPool* tmp_pool;
	PgfJitState* jit_state;
};

typedef struct PgfReadTagExn PgfReadTagExn;

struct PgfReadTagExn {
	GuType* type;
	int tag;
};

static GU_DEFINE_TYPE(PgfReadTagExn, abstract, _);

static GU_DEFINE_TYPE(PgfReadExn, abstract, _);

static uint8_t
pgf_read_tag(PgfReader* rdr)
{
	return gu_in_u8(rdr->in, rdr->err);
}

static uint32_t
pgf_read_uint(PgfReader* rdr)
{
	uint32_t u = 0;
	int shift = 0;
	uint8_t b = 0;
	do {
		b = gu_in_u8(rdr->in, rdr->err);
		gu_return_on_exn(rdr->err, 0);
		u |= (b & ~0x80) << shift;
		shift += 7;
	} while (b & 0x80);
	return u;
}

static int32_t
pgf_read_int(PgfReader* rdr)
{
	uint32_t u = pgf_read_uint(rdr);
	return gu_decode_2c32(u, rdr->err);
}

static GuLength
pgf_read_len(PgfReader* rdr)
{
	int32_t len = pgf_read_int(rdr);
	// It's crucial that we return 0 on failure, so the
	// caller can proceed without checking for error
	// immediately.
	gu_return_on_exn(rdr->err, 0);
	if (len < 0) {
		GuExnData* err_data = gu_raise(rdr->err, PgfReadTagExn);
		if (err_data) {
			PgfReadTagExn* rtag = gu_new(PgfReadTagExn, err_data->pool);
			rtag->type = gu_type(GuLength);
			rtag->tag  = len;
			err_data->data = rtag;
		}

		return 0;
	}
	return (GuLength) len;
}

static PgfCId
pgf_read_cid(PgfReader* rdr)
{
	GuPool* tmp_pool = gu_new_pool();
	GuStringBuf* sbuf = gu_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	size_t len = pgf_read_len(rdr);
	for (size_t i = 0; i < len; i++) {
		// CIds are in latin-1
		GuUCS ucs = gu_in_u8(rdr->in, rdr->err);
		gu_out_utf8(ucs, out, rdr->err);
	}
	GuString str = gu_string_buf_freeze(sbuf, rdr->opool);
	gu_pool_free(tmp_pool);
	return str;
}

static GuString
pgf_read_string(PgfReader* rdr)
{	
	GuPool* tmp_pool = gu_new_pool();
	GuStringBuf* sbuf = gu_string_buf(tmp_pool);
	GuOut* out = gu_string_buf_out(sbuf);

	GuLength len = pgf_read_len(rdr);

	for (size_t i = 0; i < len; i++) {
		GuUCS ucs = gu_in_utf8(rdr->in, rdr->err);
		gu_out_utf8(ucs, out, rdr->err);
	}
	GuString str = gu_string_buf_freeze(sbuf, rdr->opool);
	gu_pool_free(tmp_pool);

	return str;
}

static void
pgf_read_tag_error(PgfReader* rdr)
{
	gu_impossible();
}

static PgfLiteral
pgf_read_literal(PgfReader* rdr)
{
	PgfLiteral lit = gu_null_variant;
	
	uint8_t tag = pgf_read_tag(rdr);
	switch (tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr *lit_str =
			gu_new_variant(PGF_LITERAL_STR,
						   PgfLiteralStr,
						   &lit, rdr->opool);
		lit_str->val = pgf_read_string(rdr);
		break;
	}
	case PGF_LITERAL_INT: {
		PgfLiteralInt *lit_int =
			gu_new_variant(PGF_LITERAL_INT,
						   PgfLiteralInt,
						   &lit, rdr->opool);
		lit_int->val = pgf_read_int(rdr);
		break;
	}
	case PGF_LITERAL_FLT: {
		PgfLiteralFlt *lit_flt =
			gu_new_variant(PGF_LITERAL_FLT,
						   PgfLiteralFlt,
						   &lit, rdr->opool);
		lit_flt->val = gu_in_f64be(rdr->in, rdr->err);
		break;
	}
	default:
		pgf_read_tag_error(rdr);
	}
	return lit;
}

static PgfFlags*
pgf_read_flags(PgfReader* rdr)
{
	PgfFlags* flags = gu_map_type_new(PgfFlags, rdr->opool);

	GuLength len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	for (size_t i = 0; i < len; i++) {
		PgfCId name = pgf_read_cid(rdr);
		gu_return_on_exn(rdr->err, NULL);

		PgfLiteral value = pgf_read_literal(rdr);
		gu_return_on_exn(rdr->err, NULL);
		
		gu_map_put(flags, &name, PgfLiteral, value);
	}

	return flags;
}

static PgfType*
pgf_read_type_(PgfReader* rdr);

static PgfExpr
pgf_read_expr_(PgfReader* rdr)
{
	PgfExpr expr = gu_null_variant;

	uint8_t tag = pgf_read_tag(rdr);
	switch (tag) {
	case PGF_EXPR_ABS:{
		PgfExprAbs *eabs =
			gu_new_variant(PGF_EXPR_ABS,
						   PgfExprAbs,
						   &expr, rdr->opool);

		eabs->bind_type = pgf_read_tag(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);

		eabs->id = pgf_read_cid(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);

		eabs->body = pgf_read_expr_(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp *eapp =
			gu_new_variant(PGF_EXPR_APP,
						   PgfExprApp,
						   &expr, rdr->opool);

		eapp->fun = pgf_read_expr_(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);

		eapp->arg = pgf_read_expr_(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit *elit =
			gu_new_variant(PGF_EXPR_LIT,
						   PgfExprLit,
						   &expr, rdr->opool);
		elit->lit = pgf_read_literal(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_EXPR_META: {
		PgfExprMeta *emeta =
			gu_new_variant(PGF_EXPR_META,
						   PgfExprMeta,
						   &expr, rdr->opool);
		emeta->id = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun *efun =
			gu_new_variant(PGF_EXPR_FUN,
						   PgfExprFun,
						   &expr, rdr->opool);
		efun->fun = pgf_read_cid(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_EXPR_VAR: {
		PgfExprVar *evar =
			gu_new_variant(PGF_EXPR_VAR,
						   PgfExprVar,
						   &expr, rdr->opool);
		evar->var = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped *etyped =
			gu_new_variant(PGF_EXPR_TYPED,
						   PgfExprTyped,
						   &expr, rdr->opool);
		etyped->expr = pgf_read_expr_(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		etyped->type = pgf_read_type_(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg *eimpl =
			gu_new_variant(PGF_EXPR_IMPL_ARG,
						   PgfExprImplArg,
						   &expr, rdr->opool);
		eimpl->expr = pgf_read_expr_(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	default:
		pgf_read_tag_error(rdr);
	}

	return expr;
}

static void
pgf_read_hypo(PgfReader* rdr, PgfHypo* hypo)
{
	hypo->bind_type = pgf_read_tag(rdr);
	gu_return_on_exn(rdr->err, );
	
	hypo->cid = pgf_read_cid(rdr);
	gu_return_on_exn(rdr->err, );
	
	hypo->type = pgf_read_type_(rdr);
	gu_return_on_exn(rdr->err, );
}

static PgfType*
pgf_read_type_(PgfReader* rdr)
{
	size_t n_hypos = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);
	GuSeq hypos = gu_new_seq(PgfHypo, n_hypos, rdr->opool);
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo = gu_seq_index(hypos, PgfHypo, i);
		pgf_read_hypo(rdr, hypo);
		gu_return_on_exn(rdr->err, NULL);
	}

	PgfCId cid = pgf_read_cid(rdr);
	gu_return_on_exn(rdr->err, NULL);

	size_t n_exprs = pgf_read_len(rdr);

	PgfType* type = gu_new_flex(rdr->opool, PgfType, exprs, n_exprs);
	type->hypos   = hypos;
	type->cid     = cid;
	type->n_exprs = n_exprs;

	for (size_t i = 0; i < type->n_exprs; i++) {
		type->exprs[i] = pgf_read_expr_(rdr);
		gu_return_on_exn(rdr->err, NULL);
	}

	return type;
}

static PgfPatt
pgf_read_patt(PgfReader* rdr)
{
	PgfPatt patt = gu_null_variant;

	uint8_t tag = pgf_read_tag(rdr);
	switch (tag) {
	case PGF_PATT_APP: {
		PgfPattApp *papp =
			gu_new_variant(PGF_PATT_APP,
						   PgfPattApp,
						   &patt, rdr->opool);
		papp->ctor = pgf_read_cid(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		
		papp->n_args = pgf_read_len(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		
		for (size_t i = 0; i < papp->n_args; i++) {
			papp->args[i] = pgf_read_patt(rdr);
			gu_return_on_exn(rdr->err, gu_null_variant);
		}
		break;
	}
	case PGF_PATT_VAR: {
		PgfPattVar *papp =
			gu_new_variant(PGF_PATT_VAR,
						   PgfPattVar,
						   &patt, rdr->opool);
		papp->var = pgf_read_cid(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_PATT_AS: {
		PgfPattAs *pas =
			gu_new_variant(PGF_PATT_AS,
						   PgfPattAs,
						   &patt, rdr->opool);
		pas->var = pgf_read_cid(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);

		pas->patt = pgf_read_patt(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_PATT_WILD: {
		PgfPattWild* pwild =
			gu_new_variant(PGF_PATT_WILD,
					   PgfPattWild,
					   &patt, rdr->opool);
		((void) pwild);
		break;
	}
	case PGF_PATT_LIT: {
		PgfPattLit *plit =
			gu_new_variant(PGF_PATT_LIT,
						   PgfPattLit,
						   &patt, rdr->opool);
		plit->lit = pgf_read_literal(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_PATT_IMPL_ARG: {
		PgfPattImplArg *pimpl =
			gu_new_variant(PGF_PATT_IMPL_ARG,
						   PgfPattImplArg,
						   &patt, rdr->opool);
		pimpl->patt = pgf_read_patt(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_PATT_TILDE: {
		PgfPattTilde *ptilde =
			gu_new_variant(PGF_PATT_TILDE,
						   PgfPattTilde,
						   &patt, rdr->opool);
		ptilde->expr = pgf_read_expr_(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	default:
		pgf_read_tag_error(rdr);
	}

	return patt;
}

static PgfAbsFun*
pgf_read_absfun(PgfReader* rdr)
{
	PgfAbsFun* absfun = gu_new(PgfAbsFun, rdr->opool);

	absfun->name = pgf_read_cid(rdr);
	gu_return_on_exn(rdr->err, NULL);

	absfun->type = pgf_read_type_(rdr);
	gu_return_on_exn(rdr->err, NULL);

	absfun->arity = pgf_read_int(rdr);

	uint8_t tag = pgf_read_tag(rdr);
	gu_return_on_exn(rdr->err, NULL);
	switch (tag) {
	case 0:
		absfun->defns = gu_null_seq;
		break;
	case 1: {
        GuLength length = pgf_read_len(rdr);
        gu_return_on_exn(rdr->err, NULL);

        absfun->defns = gu_new_seq(PgfEquation*, length, rdr->opool);
        PgfEquation** data = gu_seq_data(absfun->defns);
        for (size_t i = 0; i < length; i++) {
            GuLength n_patts = pgf_read_len(rdr);
            gu_return_on_exn(rdr->err, NULL);

            PgfEquation *equ =
                gu_malloc(rdr->opool, 
                          sizeof(PgfEquation)+sizeof(PgfPatt)*n_patts);
            equ->n_patts = n_patts;
            for (GuLength j = 0; j < n_patts; j++) {
                equ->patts[j] = pgf_read_patt(rdr);
                gu_return_on_exn(rdr->err, NULL);
            }
            equ->body = pgf_read_expr_(rdr);
            gu_return_on_exn(rdr->err, NULL);

            data[i] = equ;
        }
		break;
    }
	default:
		pgf_read_tag_error(rdr);
		break;
	}

	absfun->ep.prob = - log(gu_in_f64be(rdr->in, rdr->err));

	PgfExprFun* expr_fun =
		gu_new_variant(PGF_EXPR_FUN,
					   PgfExprFun,
					   &absfun->ep.expr, rdr->opool);
	expr_fun->fun = absfun->name;

	return absfun;
}
					    
static PgfCIdMap*
pgf_read_absfuns(PgfReader* rdr)
{
	GuMapType* map_type = (GuMapType*)
		GU_TYPE_LIT(GuStringMap, _,
			 		gu_ptr_type(PgfAbsFun),
					&gu_null_struct);
	PgfCIdMap* absfuns = gu_map_type_make(map_type, rdr->opool);

	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	for (size_t i = 0; i < len; i++) {
		PgfAbsFun* absfun = pgf_read_absfun(rdr);
		gu_return_on_exn(rdr->err, NULL);
		
		gu_map_put(absfuns, &absfun->name, PgfAbsFun*, absfun);
	}

	return absfuns;
}

static PgfAbsCat*
pgf_read_abscat(PgfReader* rdr, PgfAbstr* abstr, PgfCIdMap* abscats)
{
	PgfAbsCat* abscat = gu_new(PgfAbsCat, rdr->opool);

	abscat->name = pgf_read_cid(rdr);
	gu_return_on_exn(rdr->err, NULL);

	size_t n_hypos = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);
	abscat->context = gu_new_seq(PgfHypo, n_hypos, rdr->opool);
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo = gu_seq_index(abscat->context, PgfHypo, i);
		pgf_read_hypo(rdr, hypo);
		gu_return_on_exn(rdr->err, NULL);
	}

	abscat->meta_prob = INFINITY;
	abscat->meta_token_prob = INFINITY;
    abscat->meta_child_probs = NULL;

    GuBuf* functions = gu_new_buf(PgfAbsFun*, rdr->tmp_pool);

	size_t n_functions = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	for (size_t i = 0; i < n_functions; i++) {
		gu_in_f64be(rdr->in, rdr->err);  // ignore
		gu_return_on_exn(rdr->err, NULL);

		PgfCId name = pgf_read_cid(rdr);
		gu_return_on_exn(rdr->err, NULL);
		
		PgfAbsFun* absfun =
			gu_map_get(abstr->funs, &name, PgfAbsFun*);
		gu_buf_push(functions, PgfAbsFun*, absfun);
	}

	pgf_jit_predicate(rdr->jit_state, abscats, abscat, functions);

	return abscat;
}

static PgfCIdMap*
pgf_read_abscats(PgfReader* rdr, PgfAbstr* abstr)
{
	GuMapType* map_type = (GuMapType*)
		GU_TYPE_LIT(GuStringMap, _,
			 		gu_ptr_type(PgfAbsCat),
					&gu_null_struct);
	PgfCIdMap* abscats = gu_map_type_make(map_type, rdr->opool);
	
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	for (size_t i = 0; i < len; i++) {
		PgfAbsCat* abscat = pgf_read_abscat(rdr, abstr, abscats);
		gu_return_on_exn(rdr->err, NULL);

		gu_map_put(abscats, &abscat->name, PgfAbsCat*, abscat);
	}

	return abscats;
}

static void
pgf_read_abstract(PgfReader* rdr, PgfAbstr* abstract)
{
	abstract->name = pgf_read_cid(rdr);
	gu_return_on_exn(rdr->err, );

	abstract->aflags = pgf_read_flags(rdr);
	gu_return_on_exn(rdr->err, );
	
	abstract->funs = pgf_read_absfuns(rdr);
	gu_return_on_exn(rdr->err, );
	
	abstract->cats = pgf_read_abscats(rdr, abstract);
	gu_return_on_exn(rdr->err, );
}

static PgfCIdMap*
pgf_read_printnames(PgfReader* rdr)
{
	GuMapType* map_type = (GuMapType*)
		GU_TYPE_LIT(GuStringMap, _,
			 		gu_type(GuString),
					&gu_empty_string);
	PgfCIdMap* printnames = gu_map_type_make(map_type, rdr->opool);

	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	for (size_t i = 0; i < len; i++) {
		PgfCId name = pgf_read_cid(rdr);
		gu_return_on_exn(rdr->err, NULL);

		GuString printname = pgf_read_string(rdr);
		gu_return_on_exn(rdr->err, NULL);

		gu_map_put(printnames, &name, GuString, printname);
	}

	return printnames;
}

static PgfTokens
pgf_read_tokens(PgfReader* rdr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, gu_null_seq);

	PgfTokens tokens = gu_new_seq(PgfToken, len, rdr->opool);
	for (size_t i = 0; i < len; i++) {
		PgfToken token = pgf_read_string(rdr);
		gu_return_on_exn(rdr->err, gu_null_seq);

		gu_seq_set(tokens, PgfToken, i, token);
	}

	return tokens;
}

static void
pgf_read_alternative(PgfReader* rdr, PgfAlternative* alt)
{
	alt->form = pgf_read_tokens(rdr);
	gu_return_on_exn(rdr->err,);

	size_t n_prefixes = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err,);

	alt->prefixes = gu_new_list(GuStringL, rdr->opool, n_prefixes);
	for (size_t i = 0; i < n_prefixes; i++) {
		GuString prefix = pgf_read_string(rdr);
		gu_return_on_exn(rdr->err,);
		
		gu_list_index(alt->prefixes, i) = prefix;
	}
}

static PgfSymbol
pgf_read_symbol(PgfReader* rdr)
{
	PgfSymbol sym = gu_null_variant;

	uint8_t tag = pgf_read_tag(rdr);
	switch (tag) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat *sym_cat =
			gu_new_variant(PGF_SYMBOL_CAT,
						   PgfSymbolCat,
						   &sym, rdr->opool);

		sym_cat->d = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);

		sym_cat->r = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_SYMBOL_LIT: {
		PgfSymbolLit *sym_lit =
			gu_new_variant(PGF_SYMBOL_LIT,
						   PgfSymbolLit,
						   &sym, rdr->opool);

		sym_lit->d = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);

		sym_lit->r = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_SYMBOL_VAR: {
		PgfSymbolVar *sym_var =
			gu_new_variant(PGF_SYMBOL_VAR,
						   PgfSymbolVar,
						   &sym, rdr->opool);

		sym_var->d = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);

		sym_var->r = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_SYMBOL_KS: {
		PgfSymbolKS *sym_ks =
			gu_new_variant(PGF_SYMBOL_KS,
						   PgfSymbolKS,
						   &sym, rdr->opool);
		sym_ks->tokens = pgf_read_tokens(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_SYMBOL_KP: {
		PgfTokens default_form = pgf_read_tokens(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);
		
		size_t n_forms = pgf_read_len(rdr);
		gu_return_on_exn(rdr->err, gu_null_variant);

		PgfSymbolKP *sym_kp =
			gu_new_flex_variant(PGF_SYMBOL_KP,
						   PgfSymbolKP, forms, n_forms,
						   &sym, rdr->opool);
		sym_kp->default_form = default_form;
		sym_kp->n_forms = n_forms;

		for (size_t i = 0; i < sym_kp->n_forms; i++) {
			pgf_read_alternative(rdr, &sym_kp->forms[i]);
			gu_return_on_exn(rdr->err, gu_null_variant);
		}
		break;
	}
	case PGF_SYMBOL_NE: {
		gu_new_variant(PGF_SYMBOL_NE,
		               PgfSymbolNE,
		               &sym, rdr->opool);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	default:
		pgf_read_tag_error(rdr);
	}

	return sym;
}

static PgfSequence
pgf_read_sequence(PgfReader* rdr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, gu_null_seq);

	PgfSequence seq = gu_new_seq(PgfSymbol, len, rdr->opool);

	for (size_t i = 0; i < len; i++) {
		PgfSymbol sym = pgf_read_symbol(rdr);
		gu_return_on_exn(rdr->err, gu_null_seq);
		gu_seq_set(seq, PgfSymbol, i, sym);
	}

	return seq;
}

static PgfSequences*
pgf_read_sequences(PgfReader* rdr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);
	
	PgfSequences* seqs = gu_new_list(PgfSequences, rdr->opool, len);

	for (size_t i = 0; i < len; i++) {
		PgfSequence seq = pgf_read_sequence(rdr);
		gu_return_on_exn(rdr->err, NULL);
		gu_list_index(seqs, i) = seq;
	}

	return seqs;
}

static PgfCncFun*
pgf_read_cncfun(PgfReader* rdr, PgfAbstr* abstr, PgfConcr* concr, int funid)
{
	PgfCId name = pgf_read_cid(rdr);
	gu_return_on_exn(rdr->err, NULL);

	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfAbsFun* absfun =
		gu_map_get(abstr->funs, &name, PgfAbsFun*);

	PgfCncFun* cncfun = gu_new_flex(rdr->opool, PgfCncFun, lins, len);
	cncfun->absfun = absfun;
	cncfun->ep = (absfun == NULL) ? NULL : &absfun->ep;
	cncfun->funid = funid;
	cncfun->n_lins = len;

	for (size_t i = 0; i < len; i++) {
		int seqid = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, NULL);

		if (seqid < 0 || seqid >= gu_list_length(concr->sequences)) {
			gu_raise(rdr->err, PgfReadExn);
			return NULL;
		}
		
		cncfun->lins[i] = gu_list_elems(concr->sequences)[seqid];
	}

	return cncfun;
}

static PgfCncFuns*
pgf_read_cncfuns(PgfReader* rdr, PgfAbstr* abstr, PgfConcr* concr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfCncFuns* cncfuns = gu_new_list(PgfCncFuns, rdr->opool, len);

	for (size_t funid = 0; funid < len; funid++) {
		PgfCncFun* cncfun = pgf_read_cncfun(rdr, abstr, concr, funid);
		gu_return_on_exn(rdr->err, NULL);

		gu_list_index(cncfuns, funid) = cncfun;
	}

	return cncfuns;
}

static PgfCCat*
pgf_read_fid(PgfReader* rdr, PgfConcr* concr)
{
	int fid = pgf_read_int(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfCCat* ccat = gu_map_get(concr->ccats, &fid, PgfCCat*);
	if (!ccat) {
        ccat = gu_new(PgfCCat, rdr->opool);
        ccat->cnccat = NULL;
        ccat->lindefs = NULL;
        ccat->n_synprods = 0;
        ccat->prods = gu_null_seq;
        ccat->viterbi_prob = 0;
        ccat->fid = fid;
        ccat->conts = NULL;
        ccat->answers = NULL;

        gu_map_put(concr->ccats, &fid, PgfCCat*, ccat);
	}

    return ccat;
}

static PgfCncFun*
pgf_read_funid(PgfReader* rdr, PgfConcr* concr)
{
	int32_t funid = pgf_read_int(rdr);
	gu_return_on_exn(rdr->err, NULL);

	if (funid < 0 || funid >= gu_list_length(concr->cncfuns)) {
		gu_raise(rdr->err, PgfReadExn);
		return NULL;
	}

	return gu_list_elems(concr->cncfuns)[funid];
}

static void
pgf_read_lindefs(PgfReader* rdr, PgfConcr* concr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );

	for (size_t i = 0; i < len; i++) {
		PgfCCat* ccat = pgf_read_fid(rdr, concr);
		
		size_t n_funs = pgf_read_len(rdr);
		gu_return_on_exn(rdr->err, );
		
		ccat->lindefs = gu_new_list(PgfCncFuns, rdr->opool, n_funs);
		for (size_t j = 0; j < n_funs; j++) {
			PgfCncFun* fun = pgf_read_funid(rdr, concr);
			gu_list_index(ccat->lindefs, j) = fun;
		}
	}
}

static void
pgf_read_parg(PgfReader* rdr, PgfConcr* concr, PgfPArg* parg)
{
	size_t n_hoas = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );

	parg->hypos = gu_new_list(PgfCCats, rdr->opool, n_hoas);
	for (size_t i = 0; i < n_hoas; i++) {
		gu_list_index(parg->hypos, i) = pgf_read_fid(rdr, concr);
		gu_return_on_exn(rdr->err, );
	}
	
	parg->ccat = pgf_read_fid(rdr, concr);
	gu_return_on_exn(rdr->err, );
}

static PgfPArgs
pgf_read_pargs(PgfReader* rdr, PgfConcr* concr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, gu_null_seq);

	PgfPArgs pargs = gu_new_seq(PgfPArg, len, rdr->opool);
	for (size_t i = 0; i < len; i++) {
		PgfPArg* parg = gu_seq_index(pargs, PgfPArg, i);
		pgf_read_parg(rdr, concr, parg);
	}

	return pargs;
}

static void
pgf_read_production(PgfReader* rdr, PgfConcr* concr, 
                    PgfCCat* ccat, size_t* top, size_t* bot)
{
	PgfProduction prod = gu_null_variant;

	uint8_t tag = pgf_read_tag(rdr);
	switch (tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply *papp =
			gu_new_variant(PGF_PRODUCTION_APPLY,
						   PgfProductionApply,
						   &prod, rdr->opool);

		papp->fun = pgf_read_funid(rdr, concr);
		gu_return_on_exn(rdr->err, );

		papp->args = pgf_read_pargs(rdr, concr);
		gu_return_on_exn(rdr->err, );

		if (gu_seq_length(papp->args) > 0)
			gu_seq_set(ccat->prods, PgfProduction, (*top)++, prod);
		else
			gu_seq_set(ccat->prods, PgfProduction, (*bot)--, prod);
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce *pcoerce =
			gu_new_variant(PGF_PRODUCTION_COERCE,
						   PgfProductionCoerce,
						   &prod, rdr->opool);

		pcoerce->coerce = pgf_read_fid(rdr, concr);
		gu_return_on_exn(rdr->err, );

		gu_seq_set(ccat->prods, PgfProduction, (*top)++, prod);
		break;
	}
	default:
		pgf_read_tag_error(rdr);
	}
}

static void
pgf_read_ccats(PgfReader* rdr, PgfConcr* concr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );

	for (size_t i = 0; i < len; i++) {
		PgfCCat* ccat = pgf_read_fid(rdr, concr);

		GuLength n_prods = pgf_read_len(rdr);
		gu_return_on_exn(rdr->err,);

		ccat->prods = gu_new_seq(PgfProduction, n_prods, rdr->opool);

		size_t top = 0;
		size_t bot = n_prods-1;
		for (size_t i = 0; i < n_prods; i++) {
			pgf_read_production(rdr, concr, ccat, &top, &bot);
			gu_return_on_exn(rdr->err, );
		}

		ccat->n_synprods = top;
	}
}

static PgfCncCat*
pgf_read_cnccat(PgfReader* rdr, PgfAbstr* abstr, PgfConcr* concr, PgfCId name)
{
	int first = pgf_read_int(rdr);
	int last = pgf_read_int(rdr);
	int n_lins = pgf_read_len(rdr);
	
	PgfCncCat* cnccat =
		gu_malloc(rdr->opool, sizeof(PgfCncCat)+n_lins*sizeof(GuString));

	cnccat->abscat = 
		gu_map_get(abstr->cats, &name, PgfAbsCat*);
	gu_assert(cnccat->abscat != NULL);

	int len = last + 1 - first;
	cnccat->cats = gu_new_list(PgfCCats, rdr->opool, len);
	
	for (int i = 0; i < len; i++) {
		int fid = first + i;
		PgfCCat* ccat = gu_map_get(concr->ccats, &fid, PgfCCat*);
        if (!ccat) {
            ccat = gu_new(PgfCCat, rdr->opool);
            ccat->cnccat = NULL;
            ccat->lindefs = NULL;
            ccat->n_synprods = 0;
            ccat->prods = gu_null_seq;
            ccat->viterbi_prob = 0;
            ccat->fid = fid;
            ccat->conts = NULL;
            ccat->answers = NULL;

            gu_map_put(concr->ccats, &fid, PgfCCat*, ccat);
        }
		gu_list_index(cnccat->cats, i) = ccat;

        ccat->cnccat = cnccat;
	}

	cnccat->n_lins = n_lins;
	for (size_t i = 0; i < cnccat->n_lins; i++) {
		cnccat->labels[i] = pgf_read_string(rdr);
	}

	return cnccat;
}

static PgfCIdMap*
pgf_read_cnccats(PgfReader* rdr, PgfAbstr* abstr, PgfConcr* concr)
{
	GuMapType* map_type = (GuMapType*)
		GU_TYPE_LIT(GuStringMap, _,
			 		gu_ptr_type(PgfCncCat),
					&gu_null_struct);
	PgfCIdMap* cnccats = gu_map_type_make(map_type, rdr->opool);

	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	for (size_t i = 0; i < len; i++) {
		PgfCId name = pgf_read_cid(rdr);
		gu_return_on_exn(rdr->err, NULL);

		PgfCncCat* cnccat =
			pgf_read_cnccat(rdr, abstr, concr, name);
		gu_return_on_exn(rdr->err, NULL);
		
		gu_map_put(cnccats, &name, PgfCncCat*, cnccat);
	}

	return cnccats;
}

typedef struct {
	GuMapItor fn;
	PgfReader* rdr;
} PgfIndexFn;

static PgfCncCat*
pgf_ccat_set_cnccat(PgfCCat* ccat)
{
	if (!ccat->cnccat) {
		size_t n_prods = gu_seq_length(ccat->prods);
		for (size_t i = 0; i < n_prods; i++) {
			PgfProduction prod = 
				gu_seq_get(ccat->prods, PgfProduction, i);
			GuVariantInfo i = gu_variant_open(prod);
			switch (i.tag) {
			case PGF_PRODUCTION_COERCE: {
				PgfProductionCoerce* pcoerce = i.data;
				PgfCncCat* cnccat = 
					pgf_ccat_set_cnccat(pcoerce->coerce);
				if (!ccat->cnccat) {
					ccat->cnccat = cnccat;
				} else if (ccat->cnccat != cnccat) {
					// XXX: real error
					gu_impossible();
				}
 				break;
			}
			case PGF_PRODUCTION_APPLY:
				// Shouldn't happen with current PGF.
				// XXX: real error
				gu_impossible();
				break;
			default:
				gu_impossible();
			}
		}
	}
	return ccat->cnccat;
}

extern float
pgf_ccat_set_viterbi_prob(PgfCCat* ccat);

static void
pgf_read_ccat_cb(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	(void) (key && err);
	PgfCCat* ccat = *((PgfCCat**) value);

	pgf_ccat_set_cnccat(ccat);
//	pgf_ccat_set_viterbi_prob(ccat);
}

void
pgf_parser_index(PgfConcr* concr, GuPool *pool);

void
pgf_lzr_index(PgfConcr* concr, GuPool *pool);

static PgfConcr*
pgf_read_concrete(PgfReader* rdr, PgfAbstr* abstr)
{
	PgfConcr* concr = gu_new(PgfConcr, rdr->opool);

	concr->name = 
		pgf_read_cid(rdr);
	gu_return_on_exn(rdr->err, NULL);

	concr->cflags = 
		pgf_read_flags(rdr);
	gu_return_on_exn(rdr->err, NULL);
	
	concr->printnames = 
		pgf_read_printnames(rdr);
	gu_return_on_exn(rdr->err, NULL);
	
	concr->sequences = 
		pgf_read_sequences(rdr);
	gu_return_on_exn(rdr->err, NULL);
	
	concr->cncfuns =
		pgf_read_cncfuns(rdr, abstr, concr);
	gu_return_on_exn(rdr->err, NULL);

	concr->ccats =
		gu_new_int_map(PgfCCat*, &gu_null_struct, rdr->opool);
	concr->fun_indices = gu_map_type_new(PgfCncFunOverloadMap, rdr->opool);
	concr->coerce_idx  = gu_map_type_new(PgfCncOverloadMap, rdr->opool);
	concr->epsilon_idx = gu_map_type_new(PgfProductionIdx, rdr->opool);
	concr->leftcorner_cat_idx = gu_map_type_new(PgfLeftcornerCatIdx,rdr->opool);
	concr->leftcorner_tok_idx = gu_map_type_new(PgfLeftcornerTokIdx,rdr->opool);
	pgf_read_lindefs(rdr, concr);
	pgf_read_ccats(rdr, concr);
	concr->cnccats = pgf_read_cnccats(rdr, abstr, concr);
	concr->callbacks = pgf_new_callbacks_map(concr, rdr->opool); 
	concr->total_cats = pgf_read_int(rdr);

	PgfIndexFn clo1 = { { pgf_read_ccat_cb }, rdr };
	gu_map_iter(concr->ccats, &clo1.fn, NULL);

	pgf_parser_index(concr, rdr->opool);
	pgf_lzr_index(concr, rdr->opool);

	return concr;
}

static PgfCIdMap*
pgf_read_concretes(PgfReader* rdr, PgfAbstr* abstr)
{
	GuMapType* map_type = (GuMapType*)
		GU_TYPE_LIT(GuStringMap, _,
			 		gu_ptr_type(PgfConcr),
					&gu_null_struct);
	PgfCIdMap* concretes = gu_map_type_make(map_type, rdr->opool);

	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	for (size_t i = 0; i < len; i++) {
		PgfConcr* concr = pgf_read_concrete(rdr, abstr);
		gu_return_on_exn(rdr->err, NULL);
		
		gu_map_put(concretes, &concr->name, PgfConcr*, concr);
	}

	return concretes;
}

PgfPGF*
pgf_read_pgf(PgfReader* rdr) {
	PgfPGF* pgf = gu_new(PgfPGF, rdr->opool);
	
	pgf->major_version = gu_in_u16be(rdr->in, rdr->err);
	gu_return_on_exn(rdr->err, NULL);

	pgf->minor_version = gu_in_u16be(rdr->in, rdr->err);
	gu_return_on_exn(rdr->err, NULL);

	pgf->gflags = pgf_read_flags(rdr);
	gu_return_on_exn(rdr->err, NULL);
		
	pgf_read_abstract(rdr, &pgf->abstract);
	gu_return_on_exn(rdr->err, NULL);
	
	pgf->concretes = pgf_read_concretes(rdr, &pgf->abstract);
	gu_return_on_exn(rdr->err, NULL);

	return pgf;
}

PgfReader*
pgf_new_reader(GuIn* in, GuPool* opool, GuPool* tmp_pool, GuExn* err)
{
	PgfReader* rdr = gu_new(PgfReader, tmp_pool);
	rdr->opool = opool;
	rdr->tmp_pool = tmp_pool;
	rdr->err = err;
	rdr->in = in;
	rdr->jit_state = pgf_jit_init(tmp_pool, rdr->opool);
	return rdr;
}

void
pgf_reader_done(PgfReader* rdr, PgfPGF* pgf)
{
	pgf_jit_done(rdr->jit_state, &pgf->abstract);
}
