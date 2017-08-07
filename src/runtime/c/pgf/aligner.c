#include "data.h"
#include "linearizer.h"
#include "pgf.h"
#include <gu/utf8.h>

typedef struct {
	PgfLinFuncs* funcs;
	GuBuf* parent_stack;
	GuBuf* parent_current;
	GuBuf* phrases;
	PgfAlignmentPhrase* last_phrase;
	GuStringBuf* sbuf;
	size_t n_matches;
	GuExn* err;
	bool bind;
	PgfCapitState capit;
	GuPool* out_pool;
	GuPool* tmp_pool;
} PgfAlignerLin;

static void
pgf_aligner_flush_phrase(PgfAlignerLin* alin)
{
	size_t n_fids = gu_buf_length(alin->parent_current);

	if (alin->n_matches == n_fids &&
		alin->n_matches == alin->last_phrase->n_fids) {
		// if the current compound word has the same parents
		// as the last one then we just combine them with a space

		alin->last_phrase->phrase =
				gu_format_string(alin->out_pool, "%s %s", 
								 alin->last_phrase->phrase,
								 gu_string_buf_freeze(alin->sbuf, alin->tmp_pool));
	} else {
		// push the current word to the buffer of words
		
		PgfAlignmentPhrase* phrase = 
			gu_new_flex(alin->out_pool, PgfAlignmentPhrase, fids, n_fids);
		phrase->phrase = gu_string_buf_freeze(alin->sbuf, alin->out_pool);
		phrase->n_fids = n_fids;
		for (size_t i = 0; i < n_fids; i++) {
			phrase->fids[i] = gu_buf_get(alin->parent_current, int, i);
		}
		gu_buf_push(alin->phrases, PgfAlignmentPhrase*, phrase);
		
		alin->last_phrase = phrase;
	}

	alin->n_matches = 0;
}

static void
pgf_aligner_push_parent(PgfAlignerLin* alin, int fid)
{
	gu_buf_push(alin->parent_current, int, fid);

	if (alin->last_phrase != NULL) {
		for (size_t i = 0; i < alin->last_phrase->n_fids; i++) {
			if (fid == alin->last_phrase->fids[i]) {
				alin->n_matches++;
				break;
			}
		}
	}
}

static void
pgf_aligner_lzn_symbol_token(PgfLinFuncs** funcs, PgfToken tok)
{
	PgfAlignerLin* alin = gu_container(funcs, PgfAlignerLin, funcs);
	if (!gu_ok(alin->err)) {
		return;
	}

	// get the tree node id that generates this token
	size_t n_parents = gu_buf_length(alin->parent_stack);
	int fid = gu_buf_get(alin->parent_stack, int, n_parents-1);

	// how many nodes so far are involved in the current compound word
	size_t n_fids = gu_buf_length(alin->parent_current);

	if (alin->bind) {
		// here we glue tokens

		alin->bind = false;

		bool found = false;
		for (size_t i = 0; i < n_fids; i++) {
			int current_fid = gu_buf_get(alin->parent_current, int, i);
			if (fid == current_fid) {
				found = true;
				break;
			}
		}

		// add the tree node id to the list of parents if it has not
		// been added already.
		if (!found) {
			pgf_aligner_push_parent(alin, fid);
		}
	} else {
		// here we start a new (compound) word

		pgf_aligner_flush_phrase(alin);
		gu_string_buf_flush(alin->sbuf);
		gu_buf_flush(alin->parent_current);

		pgf_aligner_push_parent(alin, fid);
		
		if (alin->capit == PGF_CAPIT_NEXT)
			alin->capit = PGF_CAPIT_NONE;
	}

	GuOut* out = gu_string_buf_out(alin->sbuf);

	switch (alin->capit) {
	case PGF_CAPIT_NONE:
		gu_string_write(tok, out, alin->err);
		break;
	case PGF_CAPIT_FIRST: {
		GuUCS c = gu_utf8_decode((const uint8_t**) &tok);
		c = gu_ucs_to_upper(c);
		gu_out_utf8(c, out, alin->err);
		gu_string_write(tok, out, alin->err);
		alin->capit = PGF_CAPIT_NONE;
		break;
	}	
	case PGF_CAPIT_ALL:
		alin->capit = PGF_CAPIT_NEXT;
		// continue
	case PGF_CAPIT_NEXT: {
		const uint8_t* p = (uint8_t*) tok;
		while (*p) {
			GuUCS c = gu_utf8_decode(&p);
			c = gu_ucs_to_upper(c);
			gu_out_utf8(c, out, alin->err);
		}
		break;
	}
	}
}

static void
pgf_aligner_lzn_begin_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfAlignerLin* alin = gu_container(funcs, PgfAlignerLin, funcs);
	gu_buf_push(alin->parent_stack, int, fid);
}

static void
pgf_aligner_lzn_end_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfAlignerLin* alin = gu_container(funcs, PgfAlignerLin, funcs);
	gu_buf_pop(alin->parent_stack, int);
}
	
static void
pgf_aligner_lzn_symbol_ne(PgfLinFuncs** funcs)
{
	PgfAlignerLin* alin = gu_container(funcs, PgfAlignerLin, funcs);
	gu_raise(alin->err, PgalinNonExist);
}

static void
pgf_aligner_lzn_symbol_bind(PgfLinFuncs** funcs)
{
	PgfAlignerLin* alin = gu_container(funcs, PgfAlignerLin, funcs);
	alin->bind = true;
}

static void
pgf_aligner_lzn_symbol_capit(PgfLinFuncs** funcs, PgfCapitState capit)
{
	PgfAlignerLin* alin = gu_container(funcs, PgfAlignerLin, funcs);
	alin->capit = capit;
}

static void
pgf_aligner_lzn_symbol_meta(PgfLinFuncs** funcs, PgfMetaId id)
{
	pgf_aligner_lzn_symbol_token(funcs, "?");
}

static PgfLinFuncs pgf_file_lin_funcs = {
	.symbol_token = pgf_aligner_lzn_symbol_token,
	.begin_phrase = pgf_aligner_lzn_begin_phrase,
	.end_phrase   = pgf_aligner_lzn_end_phrase,
	.symbol_ne    = pgf_aligner_lzn_symbol_ne,
	.symbol_bind  = pgf_aligner_lzn_symbol_bind,
	.symbol_capit = pgf_aligner_lzn_symbol_capit,
	.symbol_meta  = pgf_aligner_lzn_symbol_meta
};

GuSeq*
pgf_align_words(PgfConcr* concr, PgfExpr expr,
                GuExn* err, GuPool* pool)
{
	GuPool* tmp_pool = gu_local_pool();
	
	GuEnum* cts =
		pgf_lzr_concretize(concr, expr, err, tmp_pool);
	if (!gu_ok(err)) {
		gu_pool_free(tmp_pool);
		return NULL;
	}

	GuBuf* phrases = gu_new_buf(PgfAlignmentPhrase*, pool);

	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (!gu_variant_is_null(ctree)) {
		ctree = pgf_lzr_wrap_linref(ctree, tmp_pool);
		
		PgfAlignerLin alin = {
			.funcs = &pgf_file_lin_funcs,
			.parent_stack = gu_new_buf(int, tmp_pool),
			.parent_current = gu_new_buf(int, tmp_pool),
			.phrases = phrases,
			.last_phrase = NULL,
			.sbuf = gu_new_string_buf(tmp_pool),
			.n_matches = 0,
			.err = err,
			.bind = true,
			.capit = PGF_CAPIT_NONE,
			.out_pool = pool,
			.tmp_pool = tmp_pool
		};
		gu_buf_push(alin.parent_stack, int, -1);

		pgf_lzr_linearize(concr, ctree, 0, &alin.funcs, tmp_pool);
		if (!gu_ok(err)) {
			gu_pool_free(tmp_pool);
			return NULL;
		}

		pgf_aligner_flush_phrase(&alin);
	}

	gu_pool_free(tmp_pool);
	return gu_buf_data_seq(phrases);
}
