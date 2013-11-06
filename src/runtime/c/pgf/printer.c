#include <pgf/data.h>
#include <stdlib.h>

typedef struct {
	GuMapItor fn;
	GuOut* out;
} PgfPrintFn;

void
pgf_print_flag(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId flag = (PgfCId) key;
    PgfLiteral lit = *((PgfLiteral *) value);
    GuOut *out = clo->out;
    
    gu_puts("  flag ", out, err);
    gu_string_write(flag, out, err);
    gu_puts(" = ", out, err);
    pgf_print_literal(lit, out, err);
    gu_puts(";\n", out, err);
}

void
pgf_print_cat(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId name = (PgfCId) key;
    PgfAbsCat *cat  = *((PgfAbsCat **) value);
    GuOut *out = clo->out;

    gu_puts("  cat ", out, err);
    gu_string_write(name, out, err);

	PgfPrintContext* ctxt = NULL;
    size_t n_hypos = gu_seq_length(cat->context);
    for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo = gu_seq_index(cat->context, PgfHypo, i);
		gu_putc(' ', out, err);
		ctxt = pgf_print_hypo(hypo, ctxt, 4, out, err);
	}

	while (ctxt != NULL) {
		PgfPrintContext* next = ctxt->next;
		free(ctxt);
		ctxt = next;
	}

    gu_printf(out, err, " ;   -- %f\n", cat->prob);
}

void
pgf_print_absfun(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId name = (PgfCId) key;
    PgfAbsFun *fun = *((PgfAbsFun **) value);
    GuOut *out = clo->out;
    
    gu_puts((fun->defns == NULL) ? "  data " : "  fun ", out, err);
    gu_string_write(name, out, err);
    gu_puts(" : ", out, err);
    pgf_print_type(fun->type, NULL, 0, out, err);
    gu_printf(out, err, " ;   -- %f\n", fun->ep.prob);
}
static void
pgf_print_abstract(PgfAbstr* abstr, GuOut* out, GuExn* err)
{
	gu_puts("abstract ", out, err);
	gu_string_write(abstr->name, out, err);
	gu_puts(" {\n", out, err);
	
	PgfPrintFn clo1 = { { pgf_print_flag }, out };
	gu_map_iter(abstr->aflags, &clo1.fn, err);

	PgfPrintFn clo2 = { { pgf_print_cat }, out };
	gu_map_iter(abstr->cats, &clo2.fn, err);

	PgfPrintFn clo3 = { { pgf_print_absfun }, out };
	gu_map_iter(abstr->funs, &clo3.fn, err);
	
	gu_puts("}\n", out, err);
}

static void
pgf_print_productions(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    int fid = *((int *) key);
    PgfCCat* ccat = *((PgfCCat**) value);
    GuOut *out = clo->out;

	if (ccat->prods != NULL) {
		size_t n_prods = gu_seq_length(ccat->prods);
		for (size_t i = 0; i < n_prods; i++) {
			PgfProduction prod = gu_seq_get(ccat->prods, PgfProduction, i);
		
			gu_printf(out,err,"    C%d -> ",fid);

			GuVariantInfo i = gu_variant_open(prod);
			switch (i.tag) {
			case PGF_PRODUCTION_APPLY: {
				PgfProductionApply* papp = i.data;
				gu_printf(out,err,"F%d[",papp->fun->funid);
				size_t n_args = gu_seq_length(papp->args);
				for (size_t j = 0; j < n_args; j++) {
					if (j > 0)
						gu_putc(',',out,err);
                    
					PgfPArg arg = gu_seq_get(papp->args, PgfPArg, j);

					if (arg.hypos != NULL) {
						size_t n_hypos = gu_seq_length(arg.hypos);
						for (size_t k = 0; k < n_hypos; k++) {
							if (k > 0)
								gu_putc(' ',out,err);
							PgfCCat *hypo = gu_seq_get(arg.hypos, PgfCCat*, k);
							gu_printf(out,err,"C%d",hypo->fid);
						}
					}
            
					gu_printf(out,err,"C%d",arg.ccat->fid);
				}
				gu_printf(out,err,"]\n");
				break;
			}
			case PGF_PRODUCTION_COERCE: {
				PgfProductionCoerce* pcoerce = i.data;
				gu_printf(out,err,"_[C%d]\n",pcoerce->coerce->fid);
				break;
			}
			default:
				gu_impossible();
			}
		}
	}
}

static void
pgf_print_lindefs(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    int fid = *((int *) key);
    PgfCCat* ccat = *((PgfCCat**) value);
    GuOut *out = clo->out;
    
    if (ccat->lindefs != NULL) {
		gu_printf(out,err,"    C%d -> ",fid);
		
		size_t n_lindefs = gu_seq_length(ccat->lindefs);
		for (size_t i = 0; i < n_lindefs; i++) {
			if (i > 0) gu_putc(' ', out, err);
			
			PgfCncFun* fun = gu_seq_get(ccat->lindefs, PgfCncFun*, i);
			gu_printf(out,err,"F%d",fun->funid);
		}
		
		gu_putc('\n', out,err);
	}
}

static void
pgf_print_linrefs(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    int fid = *((int *) key);
    PgfCCat* ccat = *((PgfCCat**) value);
    GuOut *out = clo->out;
    
    if (ccat->linrefs != NULL) {
		gu_puts("    ",out,err);

		size_t n_linrefs = gu_seq_length(ccat->linrefs);
		for (size_t i = 0; i < n_linrefs; i++) {
			if (i > 0) gu_putc(' ', out, err);

			PgfCncFun* fun = gu_seq_get(ccat->linrefs, PgfCncFun*, i);
			gu_printf(out,err,"F%d",fun->funid);
		}

		gu_printf(out,err," -> C%d\n",fid);
	}
}

static void
pgf_print_cncfun(PgfCncFun *cncfun, PgfSequences* sequences, 
                 GuOut *out, GuExn *err)
{
	gu_printf(out,err,"    F%d := (", cncfun->funid);

	for (size_t i = 0; i < cncfun->n_lins; i++) {
		if (i > 0) gu_putc(',', out, err);

		PgfSequence* seq = cncfun->lins[i];
		gu_printf(out,err,"S%d", (seq - ((PgfSequence*) gu_seq_data(sequences))));
	}

	gu_puts(")", out, err);
	
	if (cncfun->absfun != NULL) {
		gu_puts(" [", out, err);
		gu_string_write(cncfun->absfun->name, out, err);
		gu_puts("]", out, err);
	}
	
	gu_puts("\n", out, err);
}

static void
pgf_print_token(PgfToken tok, GuOut *out, GuExn *err)
{
	gu_putc('"', out, err);
	gu_string_write(tok, out, err);
	gu_putc('"', out, err);
}

static void
pgf_print_symbols(PgfSymbols* syms, GuOut *out, GuExn *err);

void
pgf_print_symbol(PgfSymbol sym, GuOut *out, GuExn *err)
{
	switch (gu_variant_tag(sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(sym);
		gu_printf(out, err, "<%d,%d>", scat->d, scat->r);
		break;
	}
	case PGF_SYMBOL_KS: {
		PgfSymbolKS* sks = gu_variant_data(sym);
		pgf_print_token(sks->token, out, err);
		break;
	}
	case PGF_SYMBOL_KP: {
		PgfSymbolKP* skp = gu_variant_data(sym);

		gu_puts("pre {", out, err);
		pgf_print_symbols(skp->default_form, out, err);
		
		for (size_t i = 0; i < skp->n_forms; i++) {
			gu_puts("; ", out, err);
            pgf_print_symbols(skp->forms[i].form, out, err);
            gu_puts(" / ", out, err);
            
            size_t n_prefixes = gu_seq_length(skp->forms[i].prefixes);
            for (size_t j = 0; j < n_prefixes; j++) {
				if (j > 0) gu_putc(' ', out, err);
				
				GuString prefix = gu_seq_get(skp->forms[i].prefixes, GuString, j);
				gu_putc('"', out, err);
				gu_string_write(prefix, out, err);
				gu_putc('"', out, err);
			}
		}
		
		gu_puts("}", out, err);
		break;
	}
	case PGF_SYMBOL_LIT: {
		PgfSymbolLit *slit = gu_variant_data(sym);
		gu_printf(out, err, "{%d,%d}", slit->d, slit->r);
		break;
	}
	case PGF_SYMBOL_VAR: {
		PgfSymbolVar *svar = gu_variant_data(sym);
		gu_printf(out, err, "<%d,$%d>", svar->d, svar->r);
		break;
	}
	case PGF_SYMBOL_NE: {
		gu_puts("nonExist", out, err);
		break;
	}
	case PGF_SYMBOL_BIND: {
		gu_puts("BIND", out, err);
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_print_symbols(PgfSymbols* syms, GuOut *out, GuExn *err)
{
	int n_syms = gu_seq_length(syms);
	for (int i = 0; i < n_syms; i++) {
		if (i > 0) gu_putc(' ', out, err);
			
		PgfSymbol sym = gu_seq_get(syms, PgfSymbol, i);
		pgf_print_symbol(sym, out, err);
	}
}

static void
pgf_print_cnccat(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId name = (PgfCId) key;
    PgfCncCat* cnccat = *((PgfCncCat**) value);
    GuOut *out = clo->out;
    
    gu_puts("    ", out, err);
    gu_string_write(name, out, err);
    gu_puts(" :=\n", out, err);
    
    PgfCCat *start = gu_seq_get(cnccat->cats, PgfCCat*, 0);
    PgfCCat *end   = gu_seq_get(cnccat->cats, PgfCCat*, gu_seq_length(cnccat->cats)-1);
    
    gu_printf(out, err, "       range  [C%d..C%d]\n", start->fid, end->fid);
    
    gu_puts("       labels [", out, err);
    for (size_t i = 0; i < cnccat->n_lins; i++) {
		if (i > 0) {
			gu_puts("\n               ", out, err);
		}

		gu_string_write(cnccat->labels[i], out, err);
	}
    gu_puts("]\n", out, err);
}

static void
pgf_print_concrete(PgfCId cncname, PgfConcr* concr, 
                   GuOut* out, GuExn* err)
{
	gu_puts("concrete ", out, err);
	gu_string_write(cncname, out, err);
	gu_puts(" {\n", out, err);

	PgfPrintFn clo1 = { { pgf_print_flag }, out };
	gu_map_iter(concr->cflags, &clo1.fn, err);

	gu_puts("  productions\n", out, err);
	PgfPrintFn clo2 = { { pgf_print_productions }, out };
	gu_map_iter(concr->ccats, &clo2.fn, err);

	gu_puts("  lindefs\n", out, err);
	PgfPrintFn clo3 = { { pgf_print_lindefs }, out };
	gu_map_iter(concr->ccats, &clo3.fn, err);

	gu_puts("  linrefs\n", out, err);
	PgfPrintFn clo4 = { { pgf_print_linrefs }, out };
	gu_map_iter(concr->ccats, &clo4.fn, err);

	gu_puts("  lin\n", out, err);
	size_t n_funs = gu_seq_length(concr->cncfuns);
	for (size_t i = 0; i < n_funs; i++) {
		PgfCncFun* cncfun = gu_seq_get(concr->cncfuns, PgfCncFun*, i);
		pgf_print_cncfun(cncfun, concr->sequences, out, err);
	}

	gu_puts("  sequences\n", out, err);
	size_t n_seqs = gu_seq_length(concr->sequences);
	for (size_t i = 0; i < n_seqs; i++) {
		gu_printf(out,err,"    S%d := ", i);
		PgfSymbols* syms = gu_seq_index(concr->sequences, PgfSequence, i)->syms;
		pgf_print_symbols(syms, out, err);
		gu_putc('\n', out, err);
	}
	
	gu_puts("  categories\n", out, err);
	PgfPrintFn clo5 = { { pgf_print_cnccat }, out };
	gu_map_iter(concr->cnccats, &clo5.fn, err);
	
	gu_puts("}\n", out, err);
}

static void
pgf_print_concr_cb(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId cncname = (PgfCId) key;
    PgfConcr *concr = *((PgfConcr **) value);

	pgf_print_concrete(cncname, concr, clo->out, err);
}

void
pgf_print(PgfPGF* pgf, GuOut* out, GuExn* err)
{
	pgf_print_abstract(&pgf->abstract, out, err);
	
	PgfPrintFn clo = { { pgf_print_concr_cb }, out };
	gu_map_iter(pgf->concretes, &clo.fn, err);
}
