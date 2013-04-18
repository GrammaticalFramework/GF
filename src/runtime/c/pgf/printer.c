#include <pgf/data.h>

typedef struct {
	GuMapItor fn;
	GuWriter* wtr;
} PgfPrintFn;

void
pgf_print_flag(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId flag = *((PgfCId *) key);
    PgfLiteral lit = *((PgfLiteral *) value);
    GuWriter *wtr = clo->wtr;
    
    gu_puts("  flag ", wtr, err);
    gu_string_write(flag, wtr, err);
    gu_puts(" = ", wtr, err);
    pgf_print_literal(lit, wtr, err);
    gu_puts(";\n", wtr, err);
}

void
pgf_print_cat(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId name = *((PgfCId *) key);
    PgfAbsCat *cat  = *((PgfAbsCat **) value);
    GuWriter *wtr = clo->wtr;

    gu_puts("  cat ", wtr, err);
    gu_string_write(name, wtr, err);

    size_t n_hypos = gu_seq_length(cat->context);
    for (size_t i = 0; i < n_hypos; i++) {
		PgfHypo* hypo = gu_seq_get(cat->context, PgfHypo*, i);
		gu_putc(' ', wtr, err);
		pgf_print_hypo(hypo, 4, wtr, err);
	}

    gu_printf(wtr, err, " ;   -- %f\n",cat->meta_prob);
}

void
pgf_print_absfun(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId name = *((PgfCId *) key);
    PgfAbsFun *fun = *((PgfAbsFun **) value);
    GuWriter *wtr = clo->wtr;
    
    gu_puts(gu_seq_is_null(fun->defns) ? "  data " : "  fun ", wtr, err);
    gu_string_write(name, wtr, err);
    gu_puts(" : ", wtr, err);
    pgf_print_type(fun->type, 0, wtr, err);
    gu_printf(wtr, err, " ;   -- %f\n", fun->ep.prob);
}
static void
pgf_print_abstract(PgfAbstr* abstr, GuWriter* wtr, GuExn* err)
{
	gu_puts("abstract ", wtr, err);
	gu_string_write(abstr->name, wtr, err);
	gu_puts(" {\n", wtr, err);
	
	PgfPrintFn clo1 = { { pgf_print_flag }, wtr };
	gu_map_iter(abstr->aflags, &clo1.fn, err);

	PgfPrintFn clo2 = { { pgf_print_cat }, wtr };
	gu_map_iter(abstr->cats, &clo2.fn, err);

	PgfPrintFn clo3 = { { pgf_print_absfun }, wtr };
	gu_map_iter(abstr->funs, &clo3.fn, err);
	
	gu_puts("}\n", wtr, err);
}

static void
pgf_print_productions(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    int fid = *((int *) key);
    PgfCCat* ccat = *((PgfCCat**) value);
    GuWriter *wtr = clo->wtr;

	if (!gu_seq_is_null(ccat->prods)) {
		size_t n_prods = gu_seq_length(ccat->prods);
		for (size_t i = 0; i < n_prods; i++) {
			PgfProduction prod = gu_seq_get(ccat->prods, PgfProduction, i);
		
			gu_printf(wtr,err,"    C%d -> ",fid);

			GuVariantInfo i = gu_variant_open(prod);
			switch (i.tag) {
			case PGF_PRODUCTION_APPLY: {
				PgfProductionApply* papp = i.data;
				gu_printf(wtr,err,"F%d[",papp->fun->funid);
				size_t n_args = gu_seq_length(papp->args);
				for (size_t j = 0; j < n_args; j++) {
					if (j > 0)
						gu_putc(',',wtr,err);
                    
					PgfPArg arg = gu_seq_get(papp->args, PgfPArg, j);

					if (arg.hypos != NULL) {
						size_t n_hypos = gu_list_length(arg.hypos);
						for (size_t k = 0; k < n_hypos; k++) {
							if (k > 0)
								gu_putc(' ',wtr,err);
							PgfCCat *hypo = gu_list_index(arg.hypos, k);
							gu_printf(wtr,err,"C%d",hypo->fid);
						}
					}
            
					gu_printf(wtr,err,"C%d",arg.ccat->fid);
				}
				gu_printf(wtr,err,"]\n");
				break;
			}
			case PGF_PRODUCTION_COERCE: {
				PgfProductionCoerce* pcoerce = i.data;
				gu_printf(wtr,err,"_[C%d]\n",pcoerce->coerce->fid);
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
    GuWriter *wtr = clo->wtr;
    
    if (ccat->lindefs != NULL) {
		gu_printf(wtr,err,"    C%d -> ",fid);
		
		size_t n_lindefs = gu_list_length(ccat->lindefs);
		for (size_t i = 0; i < n_lindefs; i++) {
			if (i > 0) gu_putc(' ', wtr, err);
			
			PgfCncFun* fun = gu_list_index(ccat->lindefs, i);
			gu_printf(wtr,err,"F%d",fun->funid);
		}
		
		gu_putc('\n', wtr,err);
	}
}

static void
pgf_print_cncfun(PgfCncFun *cncfun, PgfSequences *sequences, 
					GuWriter *wtr, GuExn *err)
{
	gu_printf(wtr,err,"    F%d := (", cncfun->funid);
	
	size_t n_seqs = gu_list_length(sequences);
	
	for (size_t i = 0; i < cncfun->n_lins; i++) {
		if (i > 0) gu_putc(',', wtr, err);
		PgfSequence seq = cncfun->lins[i];

		for (size_t seqid = 0; seqid < n_seqs; seqid++) {
			if (gu_seq_data(gu_list_index(sequences, seqid)) == gu_seq_data(seq)) {
				gu_printf(wtr,err,"S%d", seqid);
				break;
			}
		}
	}
	
	gu_puts(") [", wtr, err);
	gu_string_write(cncfun->absfun->name, wtr, err);
	gu_puts("]\n", wtr, err);
}

static void
pgf_print_tokens(PgfTokens tokens, GuWriter *wtr, GuExn *err)
{
	gu_putc('"', wtr, err);
	size_t n_toks = gu_seq_length(tokens);
	for (size_t i = 0; i < n_toks; i++) {
		if (i > 0) gu_putc(' ', wtr, err);
			
		PgfToken tok = gu_seq_get(tokens, PgfToken, i);
		gu_string_write(tok, wtr, err);
	}
	gu_putc('"', wtr, err);
}

void
pgf_print_symbol(PgfSymbol sym, GuWriter *wtr, GuExn *err)
{
	switch (gu_variant_tag(sym)) {
	case PGF_SYMBOL_CAT: {
		PgfSymbolCat* scat = gu_variant_data(sym);
		gu_printf(wtr, err, "<%d,%d>", scat->d, scat->r);
		break;
	}
	case PGF_SYMBOL_KS: {
		PgfSymbolKS* sks = gu_variant_data(sym);
		pgf_print_tokens(sks->tokens, wtr, err);
		break;
	}
	case PGF_SYMBOL_KP: {
		PgfSymbolKP* skp = gu_variant_data(sym);

		gu_puts("pre {", wtr, err);
		pgf_print_tokens(skp->default_form, wtr, err);
		
		for (size_t i = 0; i < skp->n_forms; i++) {
			gu_puts("; ", wtr, err);
            pgf_print_tokens(skp->forms[i].form, wtr, err);
            gu_puts(" / ", wtr, err);
            
            size_t n_prefixes = gu_list_length(skp->forms[i].prefixes);
            for (size_t j = 0; j < n_prefixes; j++) {
				if (j > 0) gu_putc(' ', wtr, err);
				
				GuString prefix = gu_list_index(skp->forms[i].prefixes, j);
				gu_putc('"', wtr, err);
				gu_string_write(prefix, wtr, err);
				gu_putc('"', wtr, err);
			}
		}
		
		gu_puts("}", wtr, err);
		break;
	}
	case PGF_SYMBOL_LIT: {
		PgfSymbolLit *slit = gu_variant_data(sym);
		gu_printf(wtr, err, "{%d,%d}", slit->d, slit->r);
		break;
	}
	case PGF_SYMBOL_VAR: {
		PgfSymbolVar *svar = gu_variant_data(sym);
		gu_printf(wtr, err, "<%d,$%d>", svar->d, svar->r);
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_print_sequence(size_t seqid, PgfSequence seq, GuWriter *wtr, GuExn *err)
{
	gu_printf(wtr,err,"    S%d := ", seqid);

	int n_syms = gu_seq_length(seq);
	for (int i = 0; i < n_syms; i++) {
		if (i > 0) gu_putc(' ', wtr, err);
			
		PgfSymbol sym = gu_seq_get(seq, PgfSymbol, i);
		pgf_print_symbol(sym, wtr, err);
	}

	gu_putc('\n', wtr, err);
}

static void
pgf_print_cnccat(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId name = *((PgfCId *) key);
    PgfCncCat* cnccat = *((PgfCncCat**) value);
    GuWriter *wtr = clo->wtr;
    
    gu_puts("    ", wtr, err);
    gu_string_write(name, wtr, err);
    gu_puts(" :=\n", wtr, err);
    
    PgfCCat *start = gu_list_index(cnccat->cats, 0);
    PgfCCat *end   = gu_list_index(cnccat->cats, gu_list_length(cnccat->cats)-1);
    
    gu_printf(wtr, err, "       range  [C%d..C%d]\n", start->fid, end->fid);
    
    gu_puts("       labels [", wtr, err);
    for (size_t i = 0; i < cnccat->n_lins; i++) {
		if (i > 0) {
			gu_puts("\n               ", wtr, err);
		}

		gu_string_write(cnccat->labels[i], wtr, err);
	}
    gu_puts("]\n", wtr, err);
}

static void
pgf_print_concrete(PgfCId cncname, PgfConcr* concr, 
                   GuWriter* wtr, GuExn* err)
{
	gu_puts("concrete ", wtr, err);
	gu_string_write(cncname, wtr, err);
	gu_puts(" {\n", wtr, err);

	PgfPrintFn clo1 = { { pgf_print_flag }, wtr };
	gu_map_iter(concr->cflags, &clo1.fn, err);

	gu_puts("  productions\n", wtr, err);
	PgfPrintFn clo2 = { { pgf_print_productions }, wtr };
	gu_map_iter(concr->ccats, &clo2.fn, err);

	gu_puts("  lindefs\n", wtr, err);
	PgfPrintFn clo3 = { { pgf_print_lindefs }, wtr };
	gu_map_iter(concr->ccats, &clo3.fn, err);

	gu_puts("  lin\n", wtr, err);
	size_t n_funs = gu_list_length(concr->cncfuns);
	for (size_t i = 0; i < n_funs; i++) {
		PgfCncFun* cncfun = gu_list_index(concr->cncfuns, i);
		pgf_print_cncfun(cncfun, concr->sequences, wtr, err);
	}

	gu_puts("  sequences\n", wtr, err);
	size_t n_seqs = gu_list_length(concr->sequences);
	for (size_t i = 0; i < n_seqs; i++) {
		PgfSequence seq = gu_list_index(concr->sequences, i);
		pgf_print_sequence(i, seq, wtr, err);
	}
	
	gu_puts("  categories\n", wtr, err);
	PgfPrintFn clo4 = { { pgf_print_cnccat }, wtr };
	gu_map_iter(concr->cnccats, &clo4.fn, err);
	
	gu_puts("}\n", wtr, err);
}

static void
pgf_print_concr_cb(GuMapItor* fn, const void* key, void* value,
			GuExn* err)
{
	PgfPrintFn* clo = (PgfPrintFn*) fn;
    PgfCId cncname = *((PgfCId *) key);
    PgfConcr *concr = *((PgfConcr **) value);

	pgf_print_concrete(cncname, concr, clo->wtr, err);
}

void
pgf_print(PgfPGF* pgf, GuWriter* wtr, GuExn* err)
{
	pgf_print_abstract(&pgf->abstract, wtr, err);
	
	PgfPrintFn clo = { { pgf_print_concr_cb }, wtr };
	gu_map_iter(pgf->concretes, &clo.fn, err);
}
