#include <gu/seq.h>
#include <gu/file.h>
#include <pgf/data.h>
#include <pgf/jit.h>
#include <pgf/reasoner.h>
#include "lightning.h"

//#define PGF_JIT_DEBUG


struct PgfJitState {
	GuPool* tmp_pool;
	GuPool* pool;
	jit_state jit;
	jit_insn *buf;
	char *save_ip_ptr;
	GuBuf* patches;
};

#define _jit (state->jit)

typedef struct {
	PgfCId cid;
	jit_insn *ref;
} PgfCallPatch;

// Between two calls to pgf_jit_make_space we are not allowed
// to emit more that JIT_CODE_WINDOW bytes. This is not quite
// safe but this is how GNU lightning is designed.
#define JIT_CODE_WINDOW 128

typedef struct {
	GuFinalizer fin;
	void *page;
} PgfPageFinalizer;

static void
pgf_jit_finalize_page(GuFinalizer* self)
{
	PgfPageFinalizer* fin = gu_container(self, PgfPageFinalizer, fin);
	free(fin->page);
}

static void
pgf_jit_alloc_page(PgfJitState* state)
{
	void *page;

	size_t page_size = getpagesize();

#ifndef ANDROID
	if (posix_memalign(&page, page_size, page_size) != 0) {
#else
	if ((page = memalign(page_size, page_size)) == NULL) {
#endif
		gu_fatal("Memory allocation failed");
	}

	PgfPageFinalizer* fin = gu_new(PgfPageFinalizer, state->pool);
	fin->fin.fn = pgf_jit_finalize_page;
	fin->page = page;
	gu_pool_finally(state->pool, &fin->fin);
	
	state->buf = page;
	jit_set_ip(state->buf);
}

PgfJitState*
pgf_jit_init(GuPool* tmp_pool, GuPool* pool)
{
	PgfJitState* state = gu_new(PgfJitState, tmp_pool);
	state->tmp_pool = tmp_pool;
	state->pool = pool;
	state->patches = gu_new_buf(PgfCallPatch, tmp_pool);
	
	pgf_jit_alloc_page(state);
	state->save_ip_ptr = jit_get_ip().ptr;

	return state;
}

static void
pgf_jit_make_space(PgfJitState* state)
{
	assert (state->save_ip_ptr + JIT_CODE_WINDOW > jit_get_ip().ptr);

	size_t page_size = getpagesize();
	if (jit_get_ip().ptr + JIT_CODE_WINDOW > ((char*) state->buf) + page_size) {
		jit_flush_code(state->buf, jit_get_ip().ptr);
		pgf_jit_alloc_page(state);
	}
	
	state->save_ip_ptr = jit_get_ip().ptr;
}

void
pgf_jit_predicate(PgfJitState* state, PgfCIdMap* abscats, 
                  PgfAbsCat* abscat, GuBuf* functions)
{
#ifdef PGF_JIT_DEBUG
	GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    
	gu_string_write(abscat->name, out, err);
	gu_puts(":\n", out, err);
	
	int label = 0;
#endif

	size_t n_funs = gu_buf_length(functions);
	
	pgf_jit_make_space(state);

	abscat->predicate = (PgfPredicate) jit_get_ip().ptr;
	
	jit_prolog(2);

	if (n_funs > 0) {
		PgfAbsFun* absfun = 
			gu_buf_get(functions, PgfAbsFun*, 0);

#ifdef PGF_JIT_DEBUG
		gu_puts("    TRY_FIRST ", out, err);
		gu_string_write(absfun->name, out, err);
		gu_puts("\n", out, err);
#endif

		int rs_arg = jit_arg_p();
		int parent_arg = jit_arg_p();
		jit_getarg_p(JIT_V1, rs_arg);
		jit_getarg_p(JIT_V2, parent_arg);

		// compile TRY_FIRST
		jit_prepare(3);
		jit_movi_p(JIT_V0,absfun);
		jit_pusharg_p(JIT_V0);
		jit_pusharg_p(JIT_V2);
		jit_pusharg_p(JIT_V1);
		jit_finish(pgf_reasoner_try_first);
	}

#ifdef PGF_JIT_DEBUG
	gu_puts("    RET\n", out, err);
#endif
	// compile RET
	jit_ret();

#ifdef PGF_JIT_DEBUG
	if (n_funs > 0) {
		PgfAbsFun* absfun = 
			gu_buf_get(functions, PgfAbsFun*, 0);

		gu_string_write(absfun->name, out, err);
		gu_puts(":\n", out, err);
	}
#endif

	for (size_t i = 0; i < n_funs; i++) {
		PgfAbsFun* absfun = 
			gu_buf_get(functions, PgfAbsFun*, i);

		pgf_jit_make_space(state);

		absfun->predicate = (PgfPredicate) jit_get_ip().ptr;

		jit_prolog(2);
		int rs_arg = jit_arg_p();
		int st_arg = jit_arg_p();
		jit_getarg_p(JIT_V1, rs_arg);
		jit_getarg_p(JIT_V2, st_arg);

		size_t n_hypos = gu_seq_length(absfun->type->hypos);

		if (n_hypos > 0) {
			if (i+1 < n_funs) {
				PgfAbsFun* absfun = 
					gu_buf_get(functions, PgfAbsFun*, i+1);

#ifdef PGF_JIT_DEBUG
				gu_puts("    TRY_ELSE ", out, err);
				gu_string_write(absfun->name, out, err);
				gu_puts("\n", out, err);
#endif

				// compile TRY_ELSE
				jit_prepare(3);
				jit_movi_p(JIT_V0, absfun);
				jit_pusharg_p(JIT_V0);
				jit_pusharg_p(JIT_V2);
				jit_pusharg_p(JIT_V1);
				jit_finish(pgf_reasoner_try_else);
			}
				
			for (size_t i = 0; i < n_hypos; i++) {
				PgfHypo* hypo = gu_seq_index(absfun->type->hypos, PgfHypo, i);

				jit_insn *ref;
				
				// call the predicate for the category in hypo->type->cid
				PgfAbsCat* arg =
					gu_map_get(abscats, hypo->type->cid, PgfAbsCat*);

#ifdef PGF_JIT_DEBUG
				gu_puts("    CALL ", out, err);
				gu_string_write(hypo->type->cid, out, err);
				if (i+1 < n_hypos) {
					gu_printf(out, err, " L%d\n", label);
				} else {
					gu_printf(out, err, " COMPLETE\n");
				}
#endif

				// compile CALL
				ref = jit_movi_p(JIT_V0, jit_forward());
				jit_str_p(JIT_V2, JIT_V0);
				jit_prepare(2);
				jit_pusharg_p(JIT_V2);
				jit_pusharg_p(JIT_V1);
				if (arg != NULL) {
					jit_finish(arg->predicate);
				} else {
					PgfCallPatch patch;
					patch.cid = hypo->type->cid;
					patch.ref = jit_finish(jit_forward());
					gu_buf_push(state->patches, PgfCallPatch, patch);
				}

#ifdef PGF_JIT_DEBUG
				gu_puts("    RET\n", out, err);
				if (i+1 < n_hypos) {
					gu_printf(out, err, "L%d:\n", label++);
				}
#endif

				// compile RET
				jit_ret();

				if (i+1 < n_hypos) {
					pgf_jit_make_space(state);

					jit_patch_movi(ref,jit_get_label());
					
					jit_prolog(2);
					rs_arg = jit_arg_p();
					st_arg = jit_arg_p();
					jit_getarg_p(JIT_V1, rs_arg);
					jit_getarg_p(JIT_V2, st_arg);
				} else {
					jit_patch_movi(ref,pgf_reasoner_complete);
				}
			}
		} else {
			if (i+1 < n_funs) {
				PgfAbsFun* absfun = 
					gu_buf_get(functions, PgfAbsFun*, i+1);

#ifdef PGF_JIT_DEBUG
				gu_puts("    TRY_CONSTANT ", out, err);
				gu_string_write(absfun->name, out, err);
				gu_puts("\n", out, err);
#endif

				// compile TRY_CONSTANT
				jit_prepare(3);
				jit_movi_p(JIT_V0, absfun);
				jit_pusharg_p(JIT_V0);
				jit_pusharg_p(JIT_V2);
				jit_pusharg_p(JIT_V1);
				jit_finish(pgf_reasoner_try_constant);
			} else {
#ifdef PGF_JIT_DEBUG
				gu_puts("    COMPLETE\n", out, err);
#endif

				// compile COMPLETE
				jit_prepare(2);
				jit_pusharg_p(JIT_V2);
				jit_pusharg_p(JIT_V1);
				jit_finish(pgf_reasoner_complete);
			}

#ifdef PGF_JIT_DEBUG
			gu_puts("    RET\n", out, err);
#endif

			// compile RET
			jit_ret();
		}
		
#ifdef PGF_JIT_DEBUG
		if (i+1 < n_funs) {
			PgfAbsFun* absfun = 
				gu_buf_get(functions, PgfAbsFun*, i+1);

			gu_string_write(absfun->name, out, err);
			gu_puts(":\n", out, err);
		}
#endif
	}

#ifdef PGF_JIT_DEBUG
    gu_pool_free(tmp_pool);
#endif
}

void
pgf_jit_done(PgfJitState* state, PgfAbstr* abstr)
{
	size_t n_patches = gu_buf_length(state->patches);
	for (size_t i = 0; i < n_patches; i++) {
		PgfCallPatch* patch =
			gu_buf_index(state->patches, PgfCallPatch, i);
		PgfAbsCat* arg =
			gu_map_get(abstr->cats, patch->cid, PgfAbsCat*);
		gu_assert(arg != NULL);

		jit_patch_calli(patch->ref,(jit_insn*) arg->predicate);
	}
	
	jit_flush_code(state->buf, jit_get_ip().ptr);
}
