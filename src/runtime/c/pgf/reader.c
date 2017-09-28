#include "data.h"
#include "expr.h"
#include "reasoner.h"
#include "reader.h"

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
#include <stdlib.h>
#if defined(__MINGW32__) || defined(_MSC_VER)
#include <malloc.h>
#endif

//
// PgfReader
// 

typedef struct PgfReadTagExn PgfReadTagExn;

struct PgfReadTagExn {
	int tag;
};

PGF_INTERNAL uint8_t
pgf_read_tag(PgfReader* rdr)
{
	return gu_in_u8(rdr->in, rdr->err);
}

PGF_INTERNAL uint32_t
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

PGF_INTERNAL int32_t
pgf_read_int(PgfReader* rdr)
{
	uint32_t u = pgf_read_uint(rdr);
	return gu_decode_2c32(u, rdr->err);
}

PGF_INTERNAL size_t
pgf_read_len(PgfReader* rdr)
{
	int32_t len = pgf_read_int(rdr);
	// It's crucial that we return 0 on failure, so the
	// caller can proceed without checking for error
	// immediately.
	gu_return_on_exn(rdr->err, 0);
	if (GU_UNLIKELY(len < 0)) {
		GuExnData* err_data = gu_raise(rdr->err, PgfReadTagExn);
		if (err_data) {
			PgfReadTagExn* rtag = gu_new(PgfReadTagExn, err_data->pool);
			rtag->tag  = len;
			err_data->data = rtag;
		}

		return 0;
	}
	return len;
}

PGF_INTERNAL PgfCId
pgf_read_cid(PgfReader* rdr, GuPool* pool)
{
	size_t len = pgf_read_len(rdr);
	return gu_string_read_latin1(len, pool, rdr->in, rdr->err);
}

PGF_INTERNAL GuString
pgf_read_string(PgfReader* rdr)
{	
	size_t len = pgf_read_len(rdr);
	return gu_string_read(len, rdr->opool, rdr->in, rdr->err);
}

PGF_INTERNAL double
pgf_read_double(PgfReader* rdr)
{
	return gu_in_f64be(rdr->in, rdr->err);
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
		size_t len = pgf_read_len(rdr);
		uint8_t* buf = alloca(len*6+1);
		uint8_t* p   = buf;
		for (size_t i = 0; i < len; i++) {
			gu_in_utf8_buf(&p, rdr->in, rdr->err);
			gu_return_on_exn(rdr->err, gu_null_variant);
		}
		*p++ = 0;

		PgfLiteralStr *lit_str =
			gu_new_flex_variant(PGF_LITERAL_STR,
						        PgfLiteralStr,
						        val, p-buf,
						        &lit, rdr->opool);
		strcpy((char*) lit_str->val, (char*) buf);
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
		lit_flt->val = pgf_read_double(rdr);
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
	size_t n_flags = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfFlags* flags = gu_new_seq(PgfFlag, n_flags, rdr->opool);
	for (size_t i = 0; i < n_flags; i++) {
		PgfFlag* flag = gu_seq_index(flags, PgfFlag, i);

		flag->name = pgf_read_cid(rdr, rdr->opool);
		gu_return_on_exn(rdr->err, NULL);

		flag->value = pgf_read_literal(rdr);
		gu_return_on_exn(rdr->err, NULL);
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

		eabs->id = pgf_read_cid(rdr, rdr->opool);
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
		size_t len = pgf_read_len(rdr);

		PgfExprFun *efun =
			gu_new_flex_variant(PGF_EXPR_FUN,
						        PgfExprFun,
						        fun, len+1,
						        &expr, rdr->opool);
		gu_in_bytes(rdr->in, (uint8_t*)efun->fun, len, rdr->err);
		efun->fun[len] = 0;
		
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
	
	hypo->cid = pgf_read_cid(rdr, rdr->opool);
	gu_return_on_exn(rdr->err, );
	
	hypo->type = pgf_read_type_(rdr);
	gu_return_on_exn(rdr->err, );
}

static PgfType*
pgf_read_type_(PgfReader* rdr)
{
	size_t n_hypos = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);
	GuSeq* hypos = gu_new_seq(PgfHypo, n_hypos, rdr->opool);
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo = gu_seq_index(hypos, PgfHypo, i);
		pgf_read_hypo(rdr, hypo);
		gu_return_on_exn(rdr->err, NULL);
	}

	PgfCId cid = pgf_read_cid(rdr, rdr->opool);
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
		papp->ctor = pgf_read_cid(rdr, rdr->opool);
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
		papp->var = pgf_read_cid(rdr, rdr->opool);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_PATT_AS: {
		PgfPattAs *pas =
			gu_new_variant(PGF_PATT_AS,
						   PgfPattAs,
						   &patt, rdr->opool);
		pas->var = pgf_read_cid(rdr, rdr->opool);
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
pgf_read_absfun(PgfReader* rdr, PgfAbstr* abstr, PgfAbsFun* absfun)
{
	size_t len = pgf_read_len(rdr);

	PgfExprFun *efun =
		gu_new_flex_variant(PGF_EXPR_FUN,
							PgfExprFun,
							fun, len+1,
							&absfun->ep.expr, rdr->opool);
	gu_in_bytes(rdr->in, (uint8_t*)efun->fun, len, rdr->err);
	efun->fun[len] = 0;
	absfun->name = efun->fun;

	gu_return_on_exn(rdr->err, NULL);

	absfun->type = pgf_read_type_(rdr);
	gu_return_on_exn(rdr->err, NULL);

	absfun->arity = pgf_read_int(rdr);

	uint8_t tag = pgf_read_tag(rdr);
	gu_return_on_exn(rdr->err, NULL);
	switch (tag) {
	case 0:
		absfun->defns = NULL;
		if (absfun->arity == 0) {
			absfun->closure.code = abstr->eval_gates->evaluate_value;
			absfun->closure.con  = &absfun->closure.code;
		} else {
			absfun->closure.code = NULL;
		}
		break;
	case 1: {
        size_t length = pgf_read_len(rdr);
        gu_return_on_exn(rdr->err, NULL);

        absfun->defns = gu_new_seq(PgfEquation*, length, rdr->opool);
        PgfEquation** data = gu_seq_data(absfun->defns);
        for (size_t i = 0; i < length; i++) {
            size_t n_patts = pgf_read_len(rdr);
            gu_return_on_exn(rdr->err, NULL);

            PgfEquation *equ =
                gu_malloc(rdr->opool, 
                          sizeof(PgfEquation)+sizeof(PgfPatt)*n_patts);
            equ->n_patts = n_patts;
            for (size_t j = 0; j < n_patts; j++) {
                equ->patts[j] = pgf_read_patt(rdr);
                gu_return_on_exn(rdr->err, NULL);
            }
            equ->body = pgf_read_expr_(rdr);
            gu_return_on_exn(rdr->err, NULL);

            data[i] = equ;
        }
        
       	// pgf_jit_function(rdr, abstr, absfun);
		break;
    }
	default:
		pgf_read_tag_error(rdr);
		break;
	}

	absfun->ep.prob = - log(pgf_read_double(rdr));

	return absfun;
}
					    
static PgfAbsFuns*
pgf_read_absfuns(PgfReader* rdr, PgfAbstr* abstr)
{
	size_t n_funs = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfAbsFuns* absfuns = gu_new_seq(PgfAbsFun, n_funs, rdr->opool);

	for (size_t i = 0; i < n_funs; i++) {
		PgfAbsFun* absfun = gu_seq_index(absfuns, PgfAbsFun, i);
		pgf_read_absfun(rdr, abstr, absfun);
		gu_return_on_exn(rdr->err, NULL);
	}

	return absfuns;
}

static PgfAbsCat*
pgf_read_abscat(PgfReader* rdr, PgfAbstr* abstr, PgfAbsCat* abscat)
{
	abscat->name = pgf_read_cid(rdr, rdr->opool);
	gu_return_on_exn(rdr->err, NULL);

	size_t n_hypos = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);
	abscat->context = gu_new_seq(PgfHypo, n_hypos, rdr->opool);
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo = gu_seq_index(abscat->context, PgfHypo, i);
		pgf_read_hypo(rdr, hypo);
		gu_return_on_exn(rdr->err, NULL);
	}

	pgf_jit_predicate(rdr, abstr, abscat);

	abscat->prob = - log(pgf_read_double(rdr));

	return abscat;
}

static PgfAbsCats*
pgf_read_abscats(PgfReader* rdr, PgfAbstr* abstr)
{
	size_t n_cats = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);
	
	PgfAbsCats* abscats = gu_new_seq(PgfAbsCat, n_cats, rdr->opool);

	for (size_t i = 0; i < n_cats; i++) {
		PgfAbsCat* abscat = gu_seq_index(abscats, PgfAbsCat, i);
		pgf_read_abscat(rdr, abstr, abscat);
		gu_return_on_exn(rdr->err, NULL);
	}

	return abscats;
}

static void
pgf_read_abstract(PgfReader* rdr, PgfAbstr* abstract)
{
	abstract->name = pgf_read_cid(rdr, rdr->opool);
	gu_return_on_exn(rdr->err, );

	abstract->aflags = pgf_read_flags(rdr);
	gu_return_on_exn(rdr->err, );

	abstract->eval_gates = pgf_jit_gates(rdr);
		
	abstract->funs = pgf_read_absfuns(rdr, abstract);
	gu_return_on_exn(rdr->err, );
	
	abstract->cats = pgf_read_abscats(rdr, abstract);
	gu_return_on_exn(rdr->err, );

	abstract->abs_lin_fun = gu_new(PgfAbsFun, rdr->opool);
	abstract->abs_lin_fun->name = "_";
	abstract->abs_lin_fun->type = gu_new(PgfType, rdr->opool);
	abstract->abs_lin_fun->type->hypos = NULL;
	abstract->abs_lin_fun->type->cid = "_";
	abstract->abs_lin_fun->type->n_exprs = 0;
	abstract->abs_lin_fun->arity = 0;
	abstract->abs_lin_fun->defns = NULL;
	abstract->abs_lin_fun->ep.prob = INFINITY;
	abstract->abs_lin_fun->ep.expr = gu_null_variant;
}

static PgfCIdMap*
pgf_read_printnames(PgfReader* rdr)
{
	PgfCIdMap* printnames = gu_new_string_map(GuString, &gu_null_struct, rdr->opool);

	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	for (size_t i = 0; i < len; i++) {
		PgfCId name = pgf_read_cid(rdr, rdr->opool);
		gu_return_on_exn(rdr->err, NULL);

		GuString printname = pgf_read_string(rdr);
		gu_return_on_exn(rdr->err, NULL);

		gu_map_put(printnames, name, GuString, printname);
	}

	return printnames;
}

static PgfSymbols*
pgf_read_symbols(PgfReader* rdr);

static void
pgf_read_alternative(PgfReader* rdr, PgfAlternative* alt)
{
	alt->form = pgf_read_symbols(rdr);
	gu_return_on_exn(rdr->err,);

	size_t n_prefixes = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err,);

	alt->prefixes = gu_new_seq(GuString, n_prefixes, rdr->opool);
	for (size_t i = 0; i < n_prefixes; i++) {
		GuString prefix = pgf_read_string(rdr);
		gu_return_on_exn(rdr->err,);
		
		gu_seq_set(alt->prefixes, GuString, i, prefix);
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
		size_t len = pgf_read_len(rdr);
		uint8_t* buf = alloca(len*6+1);
		uint8_t* p   = buf;
		for (size_t i = 0; i < len; i++) {
			gu_in_utf8_buf(&p, rdr->in, rdr->err);
			gu_return_on_exn(rdr->err, gu_null_variant);
		}
		*p++ = 0;

		PgfSymbolKS *sym_ks =
			gu_new_flex_variant(PGF_SYMBOL_KS,
						        PgfSymbolKS,
						        token, p-buf,
						        &sym, rdr->opool);
		strcpy((char*) sym_ks->token, (char*) buf);
		break;
	}
	case PGF_SYMBOL_KP: {
		PgfSymbols* default_form = pgf_read_symbols(rdr);
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
	case PGF_SYMBOL_BIND: {
		gu_new_variant(PGF_SYMBOL_BIND,
		               PgfSymbolBIND,
		               &sym, rdr->opool);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_SYMBOL_SOFT_BIND: {
		gu_new_variant(PGF_SYMBOL_SOFT_BIND,
		               PgfSymbolBIND,
		               &sym, rdr->opool);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_SYMBOL_SOFT_SPACE: {
		gu_new_variant(PGF_SYMBOL_SOFT_SPACE,
		               PgfSymbolBIND,
		               &sym, rdr->opool);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_SYMBOL_CAPIT: {
		gu_new_variant(PGF_SYMBOL_CAPIT,
		               PgfSymbolCAPIT,
		               &sym, rdr->opool);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	case PGF_SYMBOL_ALL_CAPIT: {
		gu_new_variant(PGF_SYMBOL_ALL_CAPIT,
		               PgfSymbolCAPIT,
		               &sym, rdr->opool);
		gu_return_on_exn(rdr->err, gu_null_variant);
		break;
	}
	default:
		pgf_read_tag_error(rdr);
	}

	return sym;
}

static PgfSymbols*
pgf_read_symbols(PgfReader* rdr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfSymbols* syms = gu_new_seq(PgfSymbol, len, rdr->opool);

	for (size_t i = 0; i < len; i++) {
		PgfSymbol sym = pgf_read_symbol(rdr);
		gu_return_on_exn(rdr->err, NULL);
		gu_seq_set(syms, PgfSymbol, i, sym);
	}

	return syms;
}

static PgfSequences*
pgf_read_sequences(PgfReader* rdr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);
	
	PgfSequences* seqs = gu_new_seq(PgfSequence, len, rdr->opool);

	for (size_t i = 0; i < len; i++) {
		PgfSymbols* syms = pgf_read_symbols(rdr);
		gu_return_on_exn(rdr->err, NULL);

		gu_seq_index(seqs, PgfSequence, i)->syms = syms;
		gu_seq_index(seqs, PgfSequence, i)->idx  = NULL;
	}

	return seqs;
}

static PgfCncFun*
pgf_read_cncfun(PgfReader* rdr, PgfAbstr* abstr, PgfConcr* concr, int funid)
{
	PgfCId name = pgf_read_cid(rdr, rdr->tmp_pool);
	gu_return_on_exn(rdr->err, NULL);

	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfAbsFun* absfun =
		gu_seq_binsearch(abstr->funs, pgf_absfun_order, PgfAbsFun, name);

	PgfCncFun* cncfun = gu_new_flex(rdr->opool, PgfCncFun, lins, len);
	cncfun->absfun = absfun;
	cncfun->ep = (absfun == NULL) ? NULL : &absfun->ep;
	cncfun->funid = funid;
	cncfun->n_lins = len;

	for (size_t i = 0; i < len; i++) {
		size_t seqid = pgf_read_int(rdr);
		gu_return_on_exn(rdr->err, NULL);

		if (seqid >= gu_seq_length(concr->sequences)) {
			gu_raise(rdr->err, PgfReadExn);
			return NULL;
		}
		
		cncfun->lins[i] = gu_seq_index(concr->sequences, PgfSequence, seqid);
	}

	return cncfun;
}

static PgfCncFuns*
pgf_read_cncfuns(PgfReader* rdr, PgfAbstr* abstr, PgfConcr* concr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfCncFuns* cncfuns = gu_new_seq(PgfCncFun*, len, rdr->opool);

	for (size_t funid = 0; funid < len; funid++) {
		PgfCncFun* cncfun = pgf_read_cncfun(rdr, abstr, concr, funid);
		gu_return_on_exn(rdr->err, NULL);

		gu_seq_set(cncfuns, PgfCncFun*, funid, cncfun);
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
        ccat->linrefs = NULL;
        ccat->n_synprods = 0;
        ccat->prods = NULL;
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
	size_t funid = pgf_read_int(rdr);
	gu_return_on_exn(rdr->err, NULL);

	if (funid >= gu_seq_length(concr->cncfuns)) {
		gu_raise(rdr->err, PgfReadExn);
		return NULL;
	}

	return gu_seq_get(concr->cncfuns, PgfCncFun*, funid);
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
		
		ccat->lindefs = gu_new_seq(PgfCncFun*, n_funs, rdr->opool);
		for (size_t j = 0; j < n_funs; j++) {
			PgfCncFun* fun = pgf_read_funid(rdr, concr);
			fun->absfun = concr->abstr->abs_lin_fun;
			gu_seq_set(ccat->lindefs, PgfCncFun*, j, fun);
		}
	}
}

static void
pgf_read_linrefs(PgfReader* rdr, PgfConcr* concr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );

	for (size_t i = 0; i < len; i++) {
		PgfCCat* ccat = pgf_read_fid(rdr, concr);
		
		size_t n_funs = pgf_read_len(rdr);
		gu_return_on_exn(rdr->err, );

		ccat->linrefs = gu_new_seq(PgfCncFun*, n_funs, rdr->opool);
		for (size_t j = 0; j < n_funs; j++) {
			PgfCncFun* fun = pgf_read_funid(rdr, concr);
			fun->absfun = concr->abstr->abs_lin_fun;
			gu_seq_set(ccat->linrefs, PgfCncFun*, j, fun);
		}
	}
}

static void
pgf_read_parg(PgfReader* rdr, PgfConcr* concr, PgfPArg* parg)
{
	size_t n_hoas = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );

	parg->hypos = gu_new_seq(PgfCCat*, n_hoas, rdr->opool);
	for (size_t i = 0; i < n_hoas; i++) {
		gu_seq_set(parg->hypos, PgfCCat*, i, pgf_read_fid(rdr, concr));
		gu_return_on_exn(rdr->err, );
	}
	
	parg->ccat = pgf_read_fid(rdr, concr);
	gu_return_on_exn(rdr->err, );
}

static PgfPArgs*
pgf_read_pargs(PgfReader* rdr, PgfConcr* concr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfPArgs* pargs = gu_new_seq(PgfPArg, len, rdr->opool);
	for (size_t i = 0; i < len; i++) {
		PgfPArg* parg = gu_seq_index(pargs, PgfPArg, i);
		pgf_read_parg(rdr, concr, parg);
	}

	return pargs;
}

PGF_API bool
pgf_production_is_lexical(PgfProductionApply *papp, 
                          GuBuf* non_lexical_buf, GuPool* pool)
{
	if (gu_seq_length(papp->args) > 0)
		return false;

	for (size_t lin_idx = 0; lin_idx < papp->fun->n_lins; lin_idx++) {
		PgfSequence* seq = papp->fun->lins[lin_idx];
		
		if (seq->idx == NULL) {
			size_t n_syms = gu_seq_length(seq->syms);
			for (size_t i = 0; i < n_syms; i++) {
				PgfSymbol sym = gu_seq_get(seq->syms, PgfSymbol, i);
				GuVariantInfo inf = gu_variant_open(sym);
				if (inf.tag == PGF_SYMBOL_KP ||
					inf.tag == PGF_SYMBOL_BIND ||
					inf.tag == PGF_SYMBOL_NE ||
					inf.tag == PGF_SYMBOL_SOFT_BIND ||
					inf.tag == PGF_SYMBOL_SOFT_SPACE ||
					inf.tag == PGF_SYMBOL_CAPIT ||
					inf.tag == PGF_SYMBOL_ALL_CAPIT) {
					seq->idx = non_lexical_buf;
					return false;
				}
			}

			seq->idx = gu_new_buf(PgfProductionIdxEntry, pool);
		} if (seq->idx == non_lexical_buf) {
			return false;
		}
	}

	return true;
}

static void
pgf_read_production(PgfReader* rdr, PgfConcr* concr, 
                    PgfCCat* ccat, size_t* top, size_t* bot)
{
	PgfProduction prod = gu_null_variant;
	bool is_lexical = false;

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

		is_lexical = pgf_production_is_lexical(papp, rdr->non_lexical_buf, rdr->opool);
		if (!is_lexical)
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

	pgf_parser_index(concr, ccat, prod, is_lexical, rdr->opool);
	pgf_lzr_index(concr, ccat, prod, is_lexical, rdr->opool);
}

static void
pgf_read_ccats(PgfReader* rdr, PgfConcr* concr)
{
	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );

	for (size_t i = 0; i < len; i++) {
		PgfCCat* ccat = pgf_read_fid(rdr, concr);

		size_t n_prods = pgf_read_len(rdr);
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
		gu_seq_binsearch(abstr->cats, pgf_abscat_order, PgfAbsCat, name);
	if (cnccat->abscat == NULL) {
		fprintf(stderr, "Abstract category %s is missing\n", name);
		gu_assert(cnccat->abscat != NULL);
	}

	int len = last + 1 - first;
	cnccat->cats = gu_new_seq(PgfCCat*, len, rdr->opool);

	for (int i = 0; i < len; i++) {
		int fid = first + i;
		PgfCCat* ccat = gu_map_get(concr->ccats, &fid, PgfCCat*);
        if (!ccat) {
            ccat = gu_new(PgfCCat, rdr->opool);
            ccat->cnccat = NULL;
            ccat->lindefs = NULL;
            ccat->linrefs = NULL;
            ccat->n_synprods = 0;
            ccat->prods = NULL;
            ccat->viterbi_prob = 0;
            ccat->fid = fid;
            ccat->conts = NULL;
            ccat->answers = NULL;

            gu_map_put(concr->ccats, &fid, PgfCCat*, ccat);
        }
		gu_seq_set(cnccat->cats, PgfCCat*, i, ccat);

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
	PgfCIdMap* cnccats = gu_new_string_map(PgfCncCat, &gu_null_struct, rdr->opool);

	size_t len = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	for (size_t i = 0; i < len; i++) {
		PgfCId name = pgf_read_cid(rdr, rdr->opool);
		gu_return_on_exn(rdr->err, NULL);

		PgfCncCat* cnccat =
			pgf_read_cnccat(rdr, abstr, concr, name);
		gu_return_on_exn(rdr->err, NULL);
		
		gu_map_put(cnccats, name, PgfCncCat*, cnccat);
	}

	return cnccats;
}

static void
pgf_ccat_set_cnccat(PgfCCat* ccat, PgfProduction prod)
{
	GuVariantInfo i = gu_variant_open(prod);
	switch (i.tag) {
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce* pcoerce = i.data;
		PgfCncCat* cnccat = pcoerce->coerce->cnccat;
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

extern prob_t
pgf_ccat_set_viterbi_prob(PgfCCat* ccat);

static void
pgf_read_ccat_cb(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	(void) (fn && key && err);
    PgfCCat* ccat = *((PgfCCat**) value);

	if (ccat->prods == NULL)
		return;

	size_t n_prods = gu_seq_length(ccat->prods);
	for (size_t i = 0; i < n_prods; i++) {
		PgfProduction prod = 
			gu_seq_get(ccat->prods, PgfProduction, i);
			
		if (!ccat->cnccat) {
			pgf_ccat_set_cnccat(ccat, prod);
		}
	}

//	pgf_ccat_set_viterbi_prob(ccat);
}

static void
pgf_read_concrete_content(PgfReader* rdr, PgfConcr* concr)
{
	concr->printnames =
		pgf_read_printnames(rdr);
	gu_return_on_exn(rdr->err,);

	concr->sequences =
		pgf_read_sequences(rdr);
	gu_return_on_exn(rdr->err,);

	concr->cncfuns =
		pgf_read_cncfuns(rdr, concr->abstr, concr);
	gu_return_on_exn(rdr->err,);

	concr->ccats =
		gu_new_int_map(PgfCCat*, &gu_null_struct, rdr->opool);
	concr->fun_indices = gu_new_string_map(PgfCncOverloadMap*, &gu_null_struct, rdr->opool);
	concr->coerce_idx  = gu_new_addr_map(PgfCCat*, GuBuf*, &gu_null_struct, rdr->opool);
	pgf_read_lindefs(rdr, concr);
	pgf_read_linrefs(rdr, concr);
	pgf_read_ccats(rdr, concr);
	concr->cnccats = pgf_read_cnccats(rdr, concr->abstr, concr);
	concr->total_cats = pgf_read_int(rdr);

	GuMapItor clo1 = { pgf_read_ccat_cb };
	gu_map_iter(concr->ccats, &clo1, NULL);
}

static void
pgf_read_concrete_init_header(PgfConcr* concr)
{
	concr->printnames = NULL;
	concr->sequences  = NULL;
	concr->cncfuns = NULL;
	concr->ccats = NULL;
	concr->fun_indices = NULL;
	concr->coerce_idx = NULL;
	concr->cnccats = NULL;
	concr->total_cats = 0;
}

static void
gu_concr_fini(GuFinalizer* fin)
{
	PgfConcr* concr = gu_container(fin, PgfConcr, fin);
	
	if (concr->pool != NULL) {
		pgf_read_concrete_init_header(concr);
		gu_pool_free(concr->pool);
		concr->pool = NULL;
	}
}

static PgfConcr*
pgf_read_concrete(PgfReader* rdr, PgfAbstr* abstr, PgfConcr* concr, bool with_content)
{
	concr->name = 
		pgf_read_cid(rdr, rdr->opool);
	gu_return_on_exn(rdr->err, NULL);

	concr->abstr = abstr;

	concr->cflags =
		pgf_read_flags(rdr);
	gu_return_on_exn(rdr->err, NULL);

	concr->pool = NULL;

	if (with_content) {
		pgf_read_concrete_content(rdr, concr);
		
		concr->fin.fn = NULL;
	} else {
		pgf_read_concrete_init_header(concr);

		concr->fin.fn = gu_concr_fini;
		gu_pool_finally(rdr->opool, &concr->fin);
	}
	gu_return_on_exn(rdr->err, NULL);

	return concr;
}

PGF_API void
pgf_concrete_load(PgfConcr* concr, GuIn* in, GuExn* err)
{
	if (concr->fin.fn == NULL || concr->pool != NULL)
		return;    // already loaded

	GuPool* pool = gu_new_pool();
	GuPool* tmp_pool = gu_local_pool();

	PgfReader* rdr = pgf_new_reader(in, pool, tmp_pool, err);

	PgfCId name =
		pgf_read_cid(rdr, rdr->tmp_pool);
	gu_return_on_exn(rdr->err, );

	if (strcmp(name, concr->name) != 0) {
		GuExnData* err_data = gu_raise(rdr->err, PgfExn);
		if (err_data) {
			err_data->data = "This file contains different concrete syntax";
			gu_pool_free(tmp_pool);
			gu_pool_free(pool);
			return;
		}
	}

	concr->pool = pool;

	pgf_read_flags(rdr);
	if (gu_exn_is_raised(rdr->err)) 
		goto end;

	pgf_read_concrete_content(rdr, concr);
	if (gu_exn_is_raised(rdr->err)) 
		goto end;

end:
	gu_pool_free(tmp_pool);
}

PGF_API void
pgf_concrete_unload(PgfConcr* concr)
{
	if (concr->fin.fn == NULL)
		return;

	gu_concr_fini(&concr->fin);
}

static PgfConcrs*
pgf_read_concretes(PgfReader* rdr, PgfAbstr* abstr, bool with_content)
{
	size_t n_concrs = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, NULL);

	PgfConcrs* concretes = gu_new_seq(PgfConcr, n_concrs, rdr->opool);

	for (size_t i = 0; i < n_concrs; i++) {
		PgfConcr* concr = gu_seq_index(concretes, PgfConcr, i);
		pgf_read_concrete(rdr, abstr, concr, with_content);
		gu_return_on_exn(rdr->err, NULL);
	}

	return concretes;
}

PGF_INTERNAL PgfPGF*
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

	bool with_content =
		(gu_seq_binsearch(pgf->gflags, pgf_flag_order, PgfFlag, "split") == NULL);
	pgf->concretes = pgf_read_concretes(rdr, &pgf->abstract, with_content);
	gu_return_on_exn(rdr->err, NULL);

	pgf->pool = rdr->opool;

	return pgf;
}

PGF_INTERNAL PgfReader*
pgf_new_reader(GuIn* in, GuPool* opool, GuPool* tmp_pool, GuExn* err)
{
	PgfReader* rdr = gu_new(PgfReader, tmp_pool);
	rdr->opool = opool;
	rdr->tmp_pool = tmp_pool;
	rdr->err = err;
	rdr->in = in;
	rdr->non_lexical_buf = gu_new_buf(PgfProductionIdxEntry, opool);
	rdr->jit_state = pgf_new_jit(rdr);
	return rdr;
}

PGF_INTERNAL void
pgf_reader_done(PgfReader* rdr, PgfPGF* pgf)
{
	if (pgf == NULL)
		return;

	pgf_jit_done(rdr, &pgf->abstract);
}
