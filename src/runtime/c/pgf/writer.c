#include "data.h"
#include "expr.h"
#include "writer.h"

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
// PgfWriter
// 

struct PgfWriter {
	GuOut* out;
	GuExn* err;
};

PGF_INTERNAL void
pgf_write_tag(uint8_t tag, PgfWriter* wtr)
{
	gu_out_u8(wtr->out, tag, wtr->err);
}

PGF_INTERNAL void
pgf_write_uint(uint32_t val, PgfWriter* wtr)
{
	for (;;) {
		uint8_t b = val & 0x7F;
		val = val >> 7;
		if (val == 0) {
			gu_out_u8(wtr->out, b, wtr->err);
			break;
		} else {
			gu_out_u8(wtr->out, b | 0x80, wtr->err);
			gu_return_on_exn(wtr->err, );
		}
	}
}

PGF_INTERNAL void
pgf_write_int(int32_t val, PgfWriter* wtr)
{
	pgf_write_uint((uint32_t) val, wtr);
}

PGF_INTERNAL void
pgf_write_len(size_t len, PgfWriter* wtr)
{
	pgf_write_int(len, wtr);
}

PGF_INTERNAL void
pgf_write_cid(PgfCId id, PgfWriter* wtr)
{
	size_t len = strlen(id);
	pgf_write_len(len, wtr);
	gu_return_on_exn(wtr->err, );
	gu_out_bytes(wtr->out, (uint8_t*) id, len, wtr->err);
}

PGF_INTERNAL void
pgf_write_string(GuString val, PgfWriter* wtr)
{	
	size_t len = strlen(val);
	pgf_write_len(len, wtr);
	gu_return_on_exn(wtr->err, );
	gu_out_bytes(wtr->out, (uint8_t*) val, len, wtr->err);
}

PGF_INTERNAL void
pgf_write_double(double val, PgfWriter* wtr)
{
	gu_out_f64be(wtr->out, val, wtr->err);
}

static void
pgf_write_literal(PgfLiteral lit, PgfWriter* wtr)
{
	GuVariantInfo i = gu_variant_open(lit);
	pgf_write_tag(i.tag, wtr);
	gu_return_on_exn(wtr->err, );
	switch (i.tag) {
	case PGF_LITERAL_STR: {
		PgfLiteralStr *lstr = i.data;
		pgf_write_string(lstr->val, wtr);
		break;
	}
	case PGF_LITERAL_INT: {
		PgfLiteralInt *lint = i.data;
		pgf_write_int(lint->val, wtr);
		break;
	}
	case PGF_LITERAL_FLT: {
		PgfLiteralFlt *lflt = i.data;
		pgf_write_double(lflt->val, wtr);
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_write_flags(PgfFlags* flags, PgfWriter* wtr)
{
	size_t n_flags = gu_seq_length(flags);
	pgf_write_len(n_flags, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t i = 0; i < n_flags; i++) {
		PgfFlag* flag = gu_seq_index(flags, PgfFlag, i);

		pgf_write_cid(flag->name, wtr);
		gu_return_on_exn(wtr->err, );

		pgf_write_literal(flag->value, wtr);
		gu_return_on_exn(wtr->err, );
	}
}

static void
pgf_write_type_(PgfType* type, PgfWriter* wtr);

static void
pgf_write_expr_(PgfExpr expr, PgfWriter* wtr)
{
	GuVariantInfo i = gu_variant_open(expr);
	pgf_write_tag(i.tag, wtr);
	gu_return_on_exn(wtr->err, );
	switch (i.tag) {
	case PGF_EXPR_ABS:{
		PgfExprAbs *eabs = i.data;

		pgf_write_tag(eabs->bind_type, wtr);
		gu_return_on_exn(wtr->err, );

		pgf_write_cid(eabs->id, wtr);
		gu_return_on_exn(wtr->err, );

		pgf_write_expr_(eabs->body, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_EXPR_APP: {
		PgfExprApp *eapp = i.data;

		pgf_write_expr_(eapp->fun, wtr);
		gu_return_on_exn(wtr->err, );

		pgf_write_expr_(eapp->arg, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit *elit = i.data;
		pgf_write_literal(elit->lit, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_EXPR_META: {
		PgfExprMeta *emeta = i.data;
		pgf_write_int(emeta->id, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_EXPR_FUN: {
		PgfExprFun *efun = i.data;
		pgf_write_cid(efun->fun, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_EXPR_VAR: {
		PgfExprVar *evar = i.data;
		pgf_write_int(evar->var, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_EXPR_TYPED: {
		PgfExprTyped *etyped = i.data;
		pgf_write_expr_(etyped->expr, wtr);
		gu_return_on_exn(wtr->err, );
		pgf_write_type_(etyped->type, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_EXPR_IMPL_ARG: {
		PgfExprImplArg *eimpl = i.data;
		pgf_write_expr_(eimpl->expr, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_write_hypo(PgfHypo* hypo, PgfWriter* wtr)
{
	pgf_write_tag(hypo->bind_type, wtr);
	gu_return_on_exn(wtr->err, );
	
	pgf_write_cid(hypo->cid, wtr);
	gu_return_on_exn(wtr->err, );
	
	pgf_write_type_(hypo->type, wtr);
	gu_return_on_exn(wtr->err, );
}

static void
pgf_write_type_(PgfType* type, PgfWriter* wtr)
{
	size_t n_hypos = gu_seq_length(type->hypos);
	pgf_write_len(n_hypos, wtr);
	gu_return_on_exn(wtr->err, );
	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo = gu_seq_index(type->hypos, PgfHypo, i);
		pgf_write_hypo(hypo, wtr);
		gu_return_on_exn(wtr->err, );
	}

	pgf_write_cid(type->cid, wtr);
	gu_return_on_exn(wtr->err, );

	pgf_write_len(type->n_exprs, wtr);

	for (size_t i = 0; i < type->n_exprs; i++) {
		pgf_write_expr_(type->exprs[i], wtr);
		gu_return_on_exn(wtr->err, );
	}
}

static void
pgf_write_patt(PgfPatt patt, PgfWriter* wtr)
{
	GuVariantInfo i = gu_variant_open(patt);
	switch (i.tag) {
	case PGF_PATT_APP: {
		PgfPattApp *papp = i.data;
		pgf_write_cid(papp->ctor, wtr);
		gu_return_on_exn(wtr->err, );
		
		pgf_write_len(papp->n_args, wtr);
		gu_return_on_exn(wtr->err, );
		
		for (size_t i = 0; i < papp->n_args; i++) {
			pgf_write_patt(papp->args[i], wtr);
			gu_return_on_exn(wtr->err, );
		}
		break;
	}
	case PGF_PATT_VAR: {
		PgfPattVar *papp = i.data;
		pgf_write_cid(papp->var, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_PATT_AS: {
		PgfPattAs *pas = i.data;
		pgf_write_cid(pas->var, wtr);
		gu_return_on_exn(wtr->err, );

		pgf_write_patt(pas->patt, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_PATT_WILD: {
		PgfPattWild* pwild = i.data;
		((void) pwild);
		break;
	}
	case PGF_PATT_LIT: {
		PgfPattLit *plit = i.data;
		pgf_write_literal(plit->lit, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_PATT_IMPL_ARG: {
		PgfPattImplArg *pimpl = i.data;
		pgf_write_patt(pimpl->patt, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_PATT_TILDE: {
		PgfPattTilde *ptilde = i.data;
		pgf_write_expr_(ptilde->expr, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_write_absfun(PgfAbsFun* absfun, PgfWriter* wtr)
{
	pgf_write_cid(absfun->name,wtr);
	gu_return_on_exn(wtr->err, );

	pgf_write_type_(absfun->type, wtr);
	gu_return_on_exn(wtr->err, );

	pgf_write_int(absfun->arity, wtr);

	pgf_write_tag((absfun->defns == NULL) ? 0 : 1, wtr);
	gu_return_on_exn(wtr->err, );
	
	if (absfun->defns != NULL) {
        size_t length = gu_seq_length(absfun->defns);
        pgf_write_len(length, wtr);
        gu_return_on_exn(wtr->err, );

        PgfEquation** data = gu_seq_data(absfun->defns);
        for (size_t i = 0; i < length; i++) {
            PgfEquation *equ = data[i];

            pgf_write_len(equ->n_patts, wtr);
            gu_return_on_exn(wtr->err, );

            for (size_t j = 0; j < equ->n_patts; j++) {
                pgf_write_patt(equ->patts[j], wtr);
                gu_return_on_exn(wtr->err, );
            }
            pgf_write_expr_(equ->body, wtr);
            gu_return_on_exn(wtr->err, );
        }
    }

	pgf_write_double(exp(-absfun->ep.prob), wtr);
}

static void
pgf_write_absfuns(PgfAbsFuns* absfuns, PgfWriter* wtr)
{
	size_t n_funs = gu_seq_length(absfuns);
	pgf_write_len(n_funs, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t i = 0; i < n_funs; i++) {
		PgfAbsFun* absfun = gu_seq_index(absfuns, PgfAbsFun, i);
		pgf_write_absfun(absfun, wtr);
		gu_return_on_exn(wtr->err, );
	}
}

static void
pgf_write_abscat(PgfAbsCat* abscat, PgfWriter* wtr)
{
	pgf_write_cid(abscat->name, wtr);
	gu_return_on_exn(wtr->err, );

	size_t n_hypos = gu_seq_length(abscat->context);
	pgf_write_len(n_hypos, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo = gu_seq_index(abscat->context, PgfHypo, i);
		pgf_write_hypo(hypo, wtr);
		gu_return_on_exn(wtr->err, );
	}

	pgf_write_double(exp(-abscat->prob), wtr);
}

static void
pgf_write_abscats(PgfAbsCats* abscats, PgfWriter* wtr)
{
	size_t n_cats = gu_seq_length(abscats);
	pgf_write_len(n_cats, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t i = 0; i < n_cats; i++) {
		PgfAbsCat* abscat = gu_seq_index(abscats, PgfAbsCat, i);
		pgf_write_abscat(abscat, wtr);
		gu_return_on_exn(wtr->err, );
	}
}

static void
pgf_write_abstract(PgfAbstr* abstract, PgfWriter* wtr)
{
	pgf_write_cid(abstract->name, wtr);
	gu_return_on_exn(wtr->err, );

	pgf_write_flags(abstract->aflags, wtr);
	gu_return_on_exn(wtr->err, );

	pgf_write_absfuns(abstract->funs, wtr);
	gu_return_on_exn(wtr->err, );

	pgf_write_abscats(abstract->cats, wtr);
	gu_return_on_exn(wtr->err, );
}

typedef struct {
	GuMapItor itor;
	PgfWriter* wtr;
} PgfWriterIter;

static void
pgf_write_printname(GuMapItor* self, const void* key, void* value, GuExn *err)
{
	PgfWriterIter* itor = gu_container(self, PgfWriterIter, itor);
	PgfCId id     = key;
	GuString name = value;
	
	pgf_write_cid(id, itor->wtr);
	gu_return_on_exn(err, );

	pgf_write_string(name, itor->wtr);
	gu_return_on_exn(err, );
}

static void
pgf_write_printnames(PgfCIdMap* printnames, PgfWriter* wtr)
{
	pgf_write_len(gu_map_count(printnames), wtr);
	gu_return_on_exn(wtr->err, );

	PgfWriterIter itor;
	itor.itor.fn = pgf_write_printname;
	itor.wtr     = wtr;
	gu_map_iter(printnames, &itor.itor, wtr->err);
	gu_return_on_exn(wtr->err, );
}

static void
pgf_write_symbols(PgfSymbols*, PgfWriter* wtr);

static void
pgf_write_alternative(PgfAlternative* alt, PgfWriter* wtr)
{
	pgf_write_symbols(alt->form, wtr);
	gu_return_on_exn(wtr->err,);

	size_t n_prefixes = gu_seq_length(alt->prefixes);
	pgf_write_len(n_prefixes, wtr);
	gu_return_on_exn(wtr->err,);

	for (size_t i = 0; i < n_prefixes; i++) {
		GuString prefix = gu_seq_get(alt->prefixes, GuString, i);

		pgf_write_string(prefix, wtr);
		gu_return_on_exn(wtr->err,);
	}
}

static void
pgf_write_symbol(PgfSymbol sym, PgfWriter* wtr)
{
	GuVariantInfo i = gu_variant_open(sym);

	pgf_write_tag(i.tag, wtr);
	switch (i.tag) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat *sym_cat = i.data;

		pgf_write_int(sym_cat->d, wtr);
		gu_return_on_exn(wtr->err, );

		pgf_write_int(sym_cat->r, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_SYMBOL_LIT: {
		PgfSymbolLit *sym_lit = i.data;

		pgf_write_int(sym_lit->d, wtr);
		gu_return_on_exn(wtr->err, );

		pgf_write_int(sym_lit->r, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_SYMBOL_VAR: {
		PgfSymbolVar *sym_var = i.data;

		pgf_write_int(sym_var->d, wtr);
		gu_return_on_exn(wtr->err, );

		pgf_write_int(sym_var->r, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_SYMBOL_KS: {
		PgfSymbolKS *sym_ks = i.data;
		pgf_write_string(sym_ks->token, wtr);
		break;
	}
	case PGF_SYMBOL_KP: {
		PgfSymbolKP *sym_kp = i.data;
		pgf_write_symbols(sym_kp->default_form, wtr);
		gu_return_on_exn(wtr->err, );
		
		pgf_write_len(sym_kp->n_forms, wtr);
		gu_return_on_exn(wtr->err, );

		for (size_t i = 0; i < sym_kp->n_forms; i++) {
			pgf_write_alternative(&sym_kp->forms[i], wtr);
			gu_return_on_exn(wtr->err, );
		}
		break;
	}
	case PGF_SYMBOL_NE:
	case PGF_SYMBOL_BIND:
	case PGF_SYMBOL_SOFT_BIND:
	case PGF_SYMBOL_SOFT_SPACE:
	case PGF_SYMBOL_CAPIT:
	case PGF_SYMBOL_ALL_CAPIT: {
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_write_symbols(PgfSymbols* syms, PgfWriter* wtr)
{
	size_t len = gu_seq_length(syms);
	pgf_write_len(len, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t i = 0; i < len; i++) {
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, i);
		pgf_write_symbol(sym, wtr);
		gu_return_on_exn(wtr->err, );
	}
}

static void
pgf_write_sequences(PgfSequences* seqs, PgfWriter* wtr)
{
	size_t len = gu_seq_length(seqs);
	pgf_write_len(len, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t i = 0; i < len; i++) {
		PgfSymbols* syms = gu_seq_index(seqs, PgfSequence, i)->syms;
		pgf_write_symbols(syms, wtr);
		gu_return_on_exn(wtr->err, );
	}
}

static void
pgf_write_cncfun(PgfCncFun* cncfun, PgfConcr* concr, PgfWriter* wtr)
{
	pgf_write_cid(cncfun->absfun->name, wtr);
	gu_return_on_exn(wtr->err, );

	pgf_write_len(cncfun->n_lins, wtr);
	gu_return_on_exn(wtr->err, );

	PgfSequence* data = gu_seq_data(concr->sequences);
	for (size_t i = 0; i < cncfun->n_lins; i++) {
		size_t seq_id = (cncfun->lins[i] - data);

		pgf_write_int(seq_id, wtr);
		gu_return_on_exn(wtr->err, );
	}
}

static void
pgf_write_cncfuns(PgfCncFuns* cncfuns, PgfConcr* concr, PgfWriter* wtr)
{
	size_t len = gu_seq_length(cncfuns);
	pgf_write_len(len, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t funid = 0; funid < len; funid++) {
		PgfCncFun* cncfun = gu_seq_get(cncfuns, PgfCncFun*, funid);

		pgf_write_cncfun(cncfun, concr, wtr);
		gu_return_on_exn(wtr->err, );
	}
}

static void
pgf_write_fid(PgfCCat* ccat, PgfWriter* wtr)
{
	pgf_write_int(ccat->fid, wtr);
	gu_return_on_exn(wtr->err, );
}

static void
pgf_write_funid(PgfCncFun* cncfun, PgfWriter* wtr)
{
	pgf_write_int(cncfun->funid, wtr);
	gu_return_on_exn(wtr->err, );
}

typedef struct {
	GuMapItor itor;
	PgfWriter* wtr;
	bool   do_count;
	bool   do_defs;
	size_t count;
} PgfLinDefRefIter;

static void
pgf_write_ccat_lindefrefs(GuMapItor* self, const void* key, void* value, GuExn *err)
{
	PgfLinDefRefIter* itor = gu_container(self, PgfLinDefRefIter, itor);
	PgfCCat* ccat          = value;

	PgfCncFuns* funs = (itor->do_defs) ? ccat->lindefs : ccat->linrefs;
	if (funs != NULL) {
		if (itor->do_count) {
			itor->count++;
		} else {
			pgf_write_fid(ccat, itor->wtr);
			gu_return_on_exn(err, );
			
			size_t n_funs = gu_seq_length(funs);
			pgf_write_len(n_funs, itor->wtr);
			gu_return_on_exn(err, );
			
			for (size_t j = 0; j < n_funs; j++) {
				PgfCncFun* fun = gu_seq_get(funs, PgfCncFun*, j);
				pgf_write_funid(fun, itor->wtr);
			}
		}
	}
}

static void
pgf_write_lindefs(PgfWriter* wtr, PgfConcr* concr)
{
	PgfLinDefRefIter itor;
	itor.itor.fn = pgf_write_ccat_lindefrefs;
	itor.wtr     = wtr;
	itor.do_count= true;
	itor.do_defs = true;
	itor.count   = 0;
	gu_map_iter(concr->ccats, &itor.itor, wtr->err);

	pgf_write_len(itor.count, wtr);
	gu_return_on_exn(wtr->err, );

	itor.do_count = false;
	gu_map_iter(concr->ccats, &itor.itor, wtr->err);
	gu_return_on_exn(wtr->err, );
}

static void
pgf_write_linrefs(PgfWriter* wtr, PgfConcr* concr)
{
	PgfLinDefRefIter itor;
	itor.itor.fn = pgf_write_ccat_lindefrefs;
	itor.wtr     = wtr;
	itor.do_count= true;
	itor.do_defs = false;
	itor.count   = 0;
	gu_map_iter(concr->ccats, &itor.itor, wtr->err);

	pgf_write_len(itor.count, wtr);
	gu_return_on_exn(wtr->err, );

	itor.do_count = false;
	gu_map_iter(concr->ccats, &itor.itor, wtr->err);
	gu_return_on_exn(wtr->err, );
}

static void
pgf_write_parg(PgfPArg* parg, PgfWriter* wtr)
{
	size_t n_hoas = gu_seq_length(parg->hypos);
	pgf_write_len(n_hoas, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t i = 0; i < n_hoas; i++) {
		PgfCCat* ccat = gu_seq_get(parg->hypos, PgfCCat*, i);
		pgf_write_fid(ccat, wtr);
		gu_return_on_exn(wtr->err, );
	}

	pgf_write_fid(parg->ccat, wtr);
	gu_return_on_exn(wtr->err, );
}

static void
pgf_write_pargs(PgfPArgs* pargs, PgfWriter* wtr)
{
	size_t len = gu_seq_length(pargs);
	pgf_write_len(len, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t i = 0; i < len; i++) {
		PgfPArg* parg = gu_seq_index(pargs, PgfPArg, i);
		pgf_write_parg(parg, wtr);
	}
}

static void
pgf_write_production(PgfProduction prod, PgfWriter* wtr)
{
	GuVariantInfo i = gu_variant_open(prod);
	pgf_write_tag(i.tag, wtr);
	switch (i.tag) {
	case PGF_PRODUCTION_APPLY: {
		PgfProductionApply *papp = i.data;

		pgf_write_funid(papp->fun, wtr);
		gu_return_on_exn(wtr->err, );

		pgf_write_pargs(papp->args, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	case PGF_PRODUCTION_COERCE: {
		PgfProductionCoerce *pcoerce = i.data;

		pgf_write_fid(pcoerce->coerce, wtr);
		gu_return_on_exn(wtr->err, );
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_write_ccat(GuMapItor* self, const void* key, void* value, GuExn *err)
{
	PgfWriterIter* itor = gu_container(self, PgfWriterIter, itor);
	PgfCCat* ccat       = value;

	pgf_write_fid(ccat, itor->wtr);
	gu_return_on_exn(err, );

	size_t n_prods = gu_seq_length(ccat->prods);
	pgf_write_len(n_prods, itor->wtr);
	gu_return_on_exn(err, );

	for (size_t i = 0; i < n_prods; i++) {
		PgfProduction prod = gu_seq_get(ccat->prods, PgfProduction, i);
		pgf_write_production(prod, itor->wtr);
		gu_return_on_exn(err, );
	}
}

static void
pgf_write_ccats(GuMap* ccats, PgfWriter* wtr)
{
	pgf_write_len(gu_map_count(ccats), wtr);
	gu_return_on_exn(wtr->err, );

	PgfWriterIter itor;
	itor.itor.fn = pgf_write_ccat;
	itor.wtr     = wtr;
	gu_map_iter(ccats, &itor.itor, wtr->err);
}

static void
pgf_write_cnccat(PgfCncCat* cnccat, PgfWriter* wtr)
{
	size_t len = gu_seq_length(cnccat->cats);
	PgfCCat* first = gu_seq_get(cnccat->cats, PgfCCat*, 0);
	PgfCCat* last  = gu_seq_get(cnccat->cats, PgfCCat*, len-1);
	pgf_write_fid(first,wtr);
	pgf_write_fid(last,wtr);
	pgf_write_len(cnccat->n_lins, wtr);

	for (size_t i = 0; i < cnccat->n_lins; i++) {
		pgf_write_string(cnccat->labels[i], wtr);
	}
}

static void
pgf_write_cnccat_iter(GuMapItor* self, const void* key, void* value, GuExn *err)
{
	PgfWriterIter* itor = gu_container(self, PgfWriterIter, itor);
	PgfCncCat* cnccat   = value;

	pgf_write_cid(cnccat->abscat->name, itor->wtr);
	gu_return_on_exn(err, );

	pgf_write_cnccat(cnccat, itor->wtr);
}

static void
pgf_write_cnccats(PgfCIdMap* cnccats, PgfWriter* wtr)
{
	pgf_write_len(gu_map_count(cnccats), wtr);
	gu_return_on_exn(wtr->err, );
	
	PgfWriterIter itor;
	itor.itor.fn = pgf_write_cnccat_iter;
	itor.wtr     = wtr;
	gu_map_iter(cnccats, &itor.itor, wtr->err);
}

static void
pgf_write_concrete_content(PgfConcr* concr, PgfWriter* wtr)
{
	pgf_write_printnames(concr->printnames, wtr);
	gu_return_on_exn(wtr->err,);

	pgf_write_sequences(concr->sequences, wtr);
	gu_return_on_exn(wtr->err,);

	pgf_write_cncfuns(concr->cncfuns, concr, wtr);
	gu_return_on_exn(wtr->err,);

	pgf_write_lindefs(wtr, concr);
	pgf_write_linrefs(wtr, concr);
	pgf_write_ccats(concr->ccats, wtr);
	pgf_write_cnccats(concr->cnccats, wtr);
	pgf_write_int(concr->total_cats, wtr);
}

static void
pgf_write_concrete(PgfConcr* concr, PgfWriter* wtr, bool with_content)
{
	if (with_content &&
	    (concr->sequences == NULL || concr->cncfuns == NULL ||
		 concr->ccats == NULL || concr->cnccats == NULL)) {
			 // the syntax is not loaded so we must skip it.
			 return;
	}

	pgf_write_cid(concr->name, wtr);
	gu_return_on_exn(wtr->err, );

	pgf_write_flags(concr->cflags, wtr);
	gu_return_on_exn(wtr->err, );

	if (with_content) {
		pgf_write_concrete_content(concr, wtr);
	}
	gu_return_on_exn(wtr->err, );
}

PGF_API void
pgf_concrete_save(PgfConcr* concr, GuOut* out, GuExn* err)
{
	GuPool* pool = gu_new_pool();

	PgfWriter* wtr = pgf_new_writer(out, pool, err);

	pgf_write_concrete(concr, wtr, true);

	gu_pool_free(pool);
}

static void
pgf_write_concretes(PgfConcrs* concretes, PgfWriter* wtr, bool with_content)
{
	size_t n_concrs = gu_seq_length(concretes);
	pgf_write_len(n_concrs, wtr);
	gu_return_on_exn(wtr->err, );

	for (size_t i = 0; i < n_concrs; i++) {
		PgfConcr* concr = gu_seq_index(concretes, PgfConcr, i);
		pgf_write_concrete(concr, wtr, with_content);
		gu_return_on_exn(wtr->err, );
	}
}

PGF_INTERNAL void
pgf_write_pgf(PgfPGF* pgf, PgfWriter* wtr) {
	gu_out_u16be(wtr->out, pgf->major_version, wtr->err);
	gu_return_on_exn(wtr->err, );

	gu_out_u16be(wtr->out, pgf->minor_version, wtr->err);
	gu_return_on_exn(wtr->err, );

	pgf_write_flags(pgf->gflags, wtr);
	gu_return_on_exn(wtr->err, );

	pgf_write_abstract(&pgf->abstract, wtr);
	gu_return_on_exn(wtr->err, );

	bool with_content =
		(gu_seq_binsearch(pgf->gflags, pgf_flag_order, PgfFlag, "split") == NULL);
	pgf_write_concretes(pgf->concretes, wtr, with_content);
	gu_return_on_exn(wtr->err, );
}

PGF_INTERNAL PgfWriter*
pgf_new_writer(GuOut* out, GuPool* pool, GuExn* err)
{
	PgfWriter* wtr = gu_new(PgfWriter, pool);
	wtr->out = out;
	wtr->err = err;
	return wtr;
}

