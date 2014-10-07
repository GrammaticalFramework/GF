#include <gu/seq.h>
#include <gu/file.h>
#include <gu/utf8.h>
#include <pgf/data.h>
#include <pgf/reasoner.h>
#include <pgf/evaluator.h>
#include <pgf/reader.h>
#include "lightning.h"

//#define PGF_JIT_DEBUG


struct PgfJitState {
	jit_state jit;
	jit_insn *buf;
	char *save_ip_ptr;
	GuBuf* call_patches;
	GuBuf* segment_patches;
	size_t n_closures;
};

#define _jit (rdr->jit_state->jit)

typedef struct {
	PgfCId cid;
	jit_insn *ref;
} PgfCallPatch;

typedef struct {
	size_t segment;
	jit_insn *ref;
	bool is_abs;
} PgfSegmentPatch;

// Between two calls to pgf_jit_make_space we are not allowed
// to emit more that JIT_CODE_WINDOW bytes. This is not quite
// safe but this is how GNU lightning is designed.
#define JIT_CODE_WINDOW 128

#define JIT_VHEAP  JIT_V0
#define JIT_VSTATE JIT_V1
#define JIT_VCLOS  JIT_V2

static void
pgf_jit_finalize_page(GuFinalizer* self)
{
	free(self);
}

static void
pgf_jit_alloc_page(PgfReader* rdr)
{
	void *page;

	size_t page_size = getpagesize();

#if defined(ANDROID)
	if ((page = memalign(page_size, page_size)) == NULL) {	
#elif defined(__MINGW32__)
	if ((page = malloc(page_size)) == NULL) {
#else
	if (posix_memalign(&page, page_size, page_size) != 0) {
#endif
		gu_fatal("Memory allocation failed");
	}

	GuFinalizer* fin = page;
	fin->fn = pgf_jit_finalize_page;
	gu_pool_finally(rdr->opool, fin);

	rdr->jit_state->buf = page;
	jit_set_ip(rdr->jit_state->buf+sizeof(GuFinalizer));
}

PgfJitState*
pgf_new_jit(PgfReader* rdr)
{
	PgfJitState* state = gu_new(PgfJitState, rdr->tmp_pool);
	memset(&state->jit, 0, sizeof(state->jit));
	state->call_patches  = gu_new_buf(PgfCallPatch,  rdr->tmp_pool);
	state->segment_patches = gu_new_buf(PgfSegmentPatch, rdr->tmp_pool);
	state->buf = NULL;
	state->save_ip_ptr = NULL;
	state->n_closures = 0;
	return state;
}

static void
pgf_jit_make_space(PgfReader* rdr, size_t space)
{
	size_t page_size = getpagesize();
	if (rdr->jit_state->buf == NULL) {
		pgf_jit_alloc_page(rdr);
	} else {
		assert (jit_get_ip().ptr < rdr->jit_state->save_ip_ptr);

		if (jit_get_ip().ptr + space > ((char*) rdr->jit_state->buf) + page_size) {
			jit_flush_code(rdr->jit_state->buf, jit_get_ip().ptr);
			pgf_jit_alloc_page(rdr);
		}
	}

	rdr->jit_state->save_ip_ptr = jit_get_ip().ptr + space;
}

static PgfAbsFun*
pgf_jit_read_absfun(PgfReader* rdr, PgfAbstr* abstr)
{
	gu_in_f64be(rdr->in, rdr->err);  // ignore
	gu_return_on_exn(rdr->err, NULL);

	PgfCId name = pgf_read_cid(rdr, rdr->tmp_pool);
	gu_return_on_exn(rdr->err, NULL);
	
	PgfAbsFun* absfun =
		gu_map_get(abstr->funs, name, PgfAbsFun*);
	assert(absfun != NULL);
	
	return absfun;
}

void
pgf_jit_predicate(PgfReader* rdr, PgfAbstr* abstr,
                  PgfAbsCat* abscat)
{
#ifdef PGF_JIT_DEBUG
	GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    
	gu_string_write(abscat->name, out, err);
	gu_puts(":\n", out, err);
	
	int label = 0;
#endif

	size_t n_funs = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

	abscat->predicate = (PgfPredicate) jit_get_ip().ptr;
	
	jit_prolog(2);

	PgfAbsFun* absfun = NULL;
	PgfAbsFun* next_absfun = NULL;

	if (n_funs > 0) {
		next_absfun = pgf_jit_read_absfun(rdr, abstr);

#ifdef PGF_JIT_DEBUG
		gu_puts("    TRY_FIRST ", out, err);
		gu_string_write(next_absfun->name, out, err);
		gu_puts("\n", out, err);
#endif

		int rs_arg = jit_arg_p();
		int parent_arg = jit_arg_p();
		jit_getarg_p(JIT_V1, rs_arg);
		jit_getarg_p(JIT_V2, parent_arg);

		// compile TRY_FIRST
		jit_prepare(3);
		jit_movi_p(JIT_V0,next_absfun);
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
		gu_string_write(next_absfun->name, out, err);
		gu_puts(":\n", out, err);
	}
#endif

	for (size_t i = 0; i < n_funs; i++) {
		pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

		absfun = next_absfun;
		absfun->predicate = (PgfPredicate) jit_get_ip().ptr;

		jit_prolog(2);
		int rs_arg = jit_arg_p();
		int st_arg = jit_arg_p();
		jit_getarg_p(JIT_V1, rs_arg);
		jit_getarg_p(JIT_V2, st_arg);

		size_t n_hypos = gu_seq_length(absfun->type->hypos);

		if (n_hypos > 0) {
			if (i+1 < n_funs) {
				next_absfun = pgf_jit_read_absfun(rdr, abstr); // i+1

#ifdef PGF_JIT_DEBUG
				gu_puts("    TRY_ELSE ", out, err);
				gu_string_write(next_absfun->name, out, err);
				gu_puts("\n", out, err);
#endif

				// compile TRY_ELSE
				jit_prepare(3);
				jit_movi_p(JIT_V0, next_absfun);
				jit_pusharg_p(JIT_V0);
				jit_pusharg_p(JIT_V2);
				jit_pusharg_p(JIT_V1);
				jit_finish(pgf_reasoner_try_else);
			}
				
			for (size_t i = 0; i < n_hypos; i++) {
				PgfHypo* hypo = gu_seq_index(absfun->type->hypos, PgfHypo, i);

				jit_insn *ref;
				
				// call the predicate for the category in hypo->type->cid
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

				PgfCallPatch patch;
				patch.cid = hypo->type->cid;
				patch.ref = jit_finish(jit_forward());
				gu_buf_push(rdr->jit_state->call_patches, PgfCallPatch, patch);

#ifdef PGF_JIT_DEBUG
				gu_puts("    RET\n", out, err);
				if (i+1 < n_hypos) {
					gu_printf(out, err, "L%d:\n", label++);
				}
#endif

				// compile RET
				jit_ret();

				if (i+1 < n_hypos) {
					pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

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
				next_absfun = pgf_jit_read_absfun(rdr, abstr); // i+1

#ifdef PGF_JIT_DEBUG
				gu_puts("    TRY_CONSTANT ", out, err);
				gu_string_write(next_absfun->name, out, err);
				gu_puts("\n", out, err);
#endif

				// compile TRY_CONSTANT
				jit_prepare(3);
				jit_movi_p(JIT_V0, next_absfun);
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
			gu_string_write(next_absfun->name, out, err);
			gu_puts(":\n", out, err);
		}
#endif
	}

#ifdef PGF_JIT_DEBUG
    gu_pool_free(tmp_pool);
#endif
}

static void
pgf_jit_finalize_defrules(GuFinalizer* self)
{
	PgfEvalGates* gates = gu_container(self, PgfEvalGates, fin);
	if (gates->defrules != NULL)
		gu_seq_free(gates->defrules);
}

PgfEvalGates*
pgf_jit_gates(PgfReader* rdr)
{
	PgfEvalGates* gates = gu_new(PgfEvalGates, rdr->opool);
	jit_insn* next;
	jit_insn* ref, *ref2;

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

	gates->evaluate_indirection	= jit_get_ip().ptr;
	jit_ldxi_p(JIT_VCLOS, JIT_VCLOS, offsetof(PgfIndirection,val));
	jit_ldr_p(JIT_R0, JIT_VCLOS);
	jit_jmpr(JIT_R0);

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

	gates->evaluate_value = jit_get_ip().ptr;
	jit_movr_p(JIT_VHEAP, JIT_VCLOS);
	jit_ldxi_p(JIT_RET, JIT_VHEAP, offsetof(PgfValue, absfun));
	jit_bare_ret(0);

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW*2);

	gates->evaluate_value_gen = jit_get_ip().ptr;
	jit_subr_p(JIT_R0, JIT_FP, JIT_SP);
	jit_subi_p(JIT_R0, JIT_R0, sizeof(void*));
	ref = jit_bnei_i(jit_forward(), JIT_R0, 0);
	jit_movr_p(JIT_VHEAP, JIT_VCLOS);
	jit_bare_ret(0);
	jit_patch(ref);
	jit_pushr_i(JIT_R0);
	jit_prepare(2);
	jit_addi_i(JIT_R0, JIT_R0, sizeof(PgfValueGen));
	jit_pusharg_ui(JIT_R0);
	jit_ldxi_p(JIT_R0, JIT_VSTATE, offsetof(PgfEvalState,pool));
	jit_pusharg_p(JIT_R0);
	jit_finish(gu_malloc);
	jit_retval(JIT_VHEAP);
	jit_popr_i(JIT_R0);
	jit_movi_p(JIT_R1, gates->evaluate_value_gen);
	jit_str_p(JIT_VHEAP, JIT_R1);
	jit_ldxi_p(JIT_R1, JIT_VCLOS, offsetof(PgfValueGen,level));
	jit_stxi_p(offsetof(PgfValueGen,level), JIT_VHEAP, JIT_R1);
	jit_ldxi_p(JIT_R1, JIT_VCLOS, offsetof(PgfValueGen,n_args));
	jit_addr_i(JIT_R1, JIT_R1, JIT_R0);
	jit_stxi_p(offsetof(PgfValueGen,n_args), JIT_VHEAP, JIT_R1);
	jit_movi_i(JIT_R1, offsetof(PgfValueGen,args));
	jit_ldxi_i(JIT_R2, JIT_VCLOS, offsetof(PgfValueGen,n_args));
	jit_addr_i(JIT_R2, JIT_R2, JIT_R1);
	jit_pushr_i(JIT_R0);
	next = jit_get_label();
	ref  = jit_bger_i(jit_forward(), JIT_R1, JIT_R2);
	jit_ldxr_i(JIT_R0, JIT_VCLOS, JIT_R1);
	jit_stxr_p(JIT_R1, JIT_VHEAP, JIT_R0);	
	jit_addi_i(JIT_R1, JIT_R1, sizeof(void*));
	jit_jmpi(next);
	jit_patch(ref);
	jit_popr_i(JIT_R0);
	jit_addr_i(JIT_R2, JIT_R2, JIT_R0);
	jit_popr_p(JIT_VCLOS);
	next = jit_get_label();
	ref  = jit_bger_i(jit_forward(), JIT_R1, JIT_R2);
	jit_popr_p(JIT_R0);
	jit_stxr_p(JIT_R1, JIT_VHEAP, JIT_R0);	
	jit_addi_i(JIT_R1, JIT_R1, sizeof(void*));
	jit_jmpi(next);
	jit_patch(ref);
	jit_jmpr(JIT_VCLOS);

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW*2);

	gates->evaluate_value_meta = jit_get_ip().ptr;
	jit_subr_p(JIT_R0, JIT_FP, JIT_SP);
	jit_subi_p(JIT_R0, JIT_R0, sizeof(void*));
	ref = jit_bnei_i(jit_forward(), JIT_R0, 0);
	jit_movr_p(JIT_VHEAP, JIT_VCLOS);
	jit_bare_ret(0);
	jit_patch(ref);
	jit_pushr_i(JIT_R0);
	jit_prepare(2);
	jit_addi_i(JIT_R0, JIT_R0, sizeof(PgfValueMeta));
	jit_pusharg_ui(JIT_R0);
	jit_ldxi_p(JIT_R0, JIT_VSTATE, offsetof(PgfEvalState,pool));
	jit_pusharg_p(JIT_R0);
	jit_finish(gu_malloc);
	jit_retval(JIT_VHEAP);
	jit_popr_i(JIT_R0);
	jit_movi_p(JIT_R1, gates->evaluate_value_meta);
	jit_str_p(JIT_VHEAP, JIT_R1);
	jit_ldxi_p(JIT_R1, JIT_VCLOS, offsetof(PgfValueMeta,id));
	jit_stxi_p(offsetof(PgfValueMeta,id), JIT_VHEAP, JIT_R1);
	jit_ldxi_p(JIT_R1, JIT_VCLOS, offsetof(PgfValueMeta,n_args));
	jit_addr_i(JIT_R1, JIT_R1, JIT_R0);
	jit_stxi_p(offsetof(PgfValueMeta,n_args), JIT_VHEAP, JIT_R1);
	jit_movi_i(JIT_R1, offsetof(PgfValueMeta,args));
	jit_ldxi_i(JIT_R2, JIT_VCLOS, offsetof(PgfValueMeta,n_args));
	jit_addr_i(JIT_R2, JIT_R2, JIT_R1);
	jit_pushr_i(JIT_R0);
	next = jit_get_label();
	ref  = jit_bger_i(jit_forward(), JIT_R1, JIT_R2);
	jit_ldxr_i(JIT_R0, JIT_VCLOS, JIT_R1);
	jit_stxr_p(JIT_R1, JIT_VHEAP, JIT_R0);	
	jit_addi_i(JIT_R1, JIT_R1, sizeof(PgfClosure*));
	jit_jmpi(next);
	jit_patch(ref);
	jit_popr_i(JIT_R0);
	jit_addr_i(JIT_R2, JIT_R2, JIT_R0);
	jit_popr_p(JIT_VCLOS);
	next = jit_get_label();
	ref  = jit_bger_i(jit_forward(), JIT_R1, JIT_R2);
	jit_popr_p(JIT_R0);
	jit_stxr_p(JIT_R1, JIT_VHEAP, JIT_R0);	
	jit_addi_i(JIT_R1, JIT_R1, sizeof(PgfClosure*));
	jit_jmpi(next);
	jit_patch(ref);
	jit_jmpr(JIT_VCLOS);

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

	gates->evaluate_value_lit = jit_get_ip().ptr;
	jit_movr_p(JIT_VHEAP, JIT_VCLOS);
	jit_prepare(1);
	jit_ldxi_p(JIT_R0, JIT_VHEAP, offsetof(PgfValueLit, lit));
	jit_pusharg_p(JIT_R0);
	jit_finish(gu_variant_data);
	jit_bare_ret(0);

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

	gates->enter = (void*) jit_get_ip().ptr;
	jit_prolog(2);
	int es_arg = jit_arg_p();
	int closure_arg = jit_arg_p();
	jit_getarg_p(JIT_VSTATE, es_arg);
	jit_getarg_p(JIT_VCLOS,  closure_arg);
	jit_ldr_p(JIT_R0, JIT_VCLOS);
	jit_callr(JIT_R0);
	jit_movr_p(JIT_RET, JIT_VHEAP);
	jit_ret();

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

	gates->evaluate_value_pap = jit_get_ip().ptr;
	jit_popr_p(JIT_VHEAP);
	jit_addi_p(JIT_R1, JIT_VCLOS, offsetof(PgfValuePAP,args));
	jit_ldxi_p(JIT_R2, JIT_VCLOS, offsetof(PgfValuePAP,n_args));
	jit_addr_p(JIT_R2, JIT_R2, JIT_R1);
	next = jit_get_label();
	ref  = jit_bger_i(jit_forward(), JIT_R1, JIT_R2);
	jit_ldr_p(JIT_R0, JIT_R1);
	jit_pushr_p(JIT_R0);
	jit_addi_p(JIT_R1, JIT_R1, sizeof(PgfClosure*));
	jit_jmpi(next);
	jit_patch(ref);
	jit_pushr_p(JIT_VHEAP);
	jit_ldxi_p(JIT_VCLOS, JIT_VCLOS, offsetof(PgfValuePAP,fun));
	jit_ldr_p(JIT_R0, JIT_VCLOS);
	jit_jmpr(JIT_R0);

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

	gates->update_closure = jit_get_ip().ptr;
	jit_popr_p(JIT_FP);
	jit_popr_p(JIT_VCLOS);
	jit_movi_p(JIT_R1, gates->evaluate_indirection);
	jit_str_p(JIT_VCLOS, JIT_R1);
	jit_stxi_p(offsetof(PgfIndirection, val), JIT_VCLOS, JIT_VHEAP);
	jit_bare_ret(0);

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW*2);

	gates->update_pap = jit_get_ip().ptr;
	jit_subi_p(JIT_R0, JIT_R0, sizeof(void*));
	jit_pushr_i(JIT_R0);
	jit_prepare(2);
	jit_addi_i(JIT_R0, JIT_R0, sizeof(PgfValuePAP));
	jit_pusharg_ui(JIT_R0);
	jit_ldxi_p(JIT_R0, JIT_VSTATE, offsetof(PgfEvalState,pool));
	jit_pusharg_p(JIT_R0);
	jit_finish(gu_malloc);
	jit_popr_i(JIT_R1);
	jit_movi_p(JIT_R2, gates->evaluate_value_pap);
	jit_str_p(JIT_RET, JIT_R2);
	jit_stxi_p(offsetof(PgfValuePAP,fun), JIT_RET, JIT_VCLOS);
	jit_stxi_p(offsetof(PgfValuePAP,n_args), JIT_RET, JIT_R1);
	jit_ldr_p(JIT_R2, JIT_SP);
	ref2 = jit_bnei_i(jit_forward(), JIT_R2, (int)gates->update_closure);
	jit_ldxi_p(JIT_VHEAP, JIT_FP, sizeof(void*));
	jit_movi_p(JIT_R2, gates->evaluate_indirection);
	jit_str_p(JIT_VHEAP, JIT_R2);
	jit_stxi_p(offsetof(PgfIndirection, val), JIT_VHEAP, JIT_RET);
	jit_ldr_p(JIT_R2, JIT_FP);
	jit_pushr_p(JIT_R2);
	jit_ldxi_p(JIT_R2, JIT_FP, 2*sizeof(void*));
	jit_pushr_p(JIT_R2);
	next = jit_get_label();
	ref  = jit_blei_i(jit_forward(), JIT_R1, 0);
	jit_ldxi_p(JIT_R2, JIT_FP, -sizeof(void*));
	jit_stxi_p(2*sizeof(void*), JIT_FP, JIT_R2);
	jit_stxi_p(offsetof(PgfValuePAP,args), JIT_RET, JIT_R2);
	jit_addi_i(JIT_RET, JIT_RET, sizeof(void*));
	jit_subi_i(JIT_FP, JIT_FP, sizeof(void*));
	jit_subi_i(JIT_R1, JIT_R1, sizeof(void*));
	jit_jmpi(next);
	jit_patch(ref);
	jit_popr_p(JIT_R0);
	jit_popr_p(JIT_FP);
	jit_addi_p(JIT_SP, JIT_SP, 4*sizeof(void*));
	jit_pushr_p(JIT_R0);
	jit_ldr_p(JIT_R0, JIT_VCLOS);
	jit_jmpr(JIT_R0);
	jit_patch(ref2);
	jit_movr_p(JIT_VHEAP, JIT_RET);
	jit_pushr_p(JIT_R1);
	next = jit_get_label();
	ref  = jit_blei_i(jit_forward(), JIT_R1, 0);
	jit_ldxi_p(JIT_R2, JIT_FP, -sizeof(void*));
	jit_stxi_p(offsetof(PgfValuePAP,args), JIT_RET, JIT_R2);
	jit_addi_i(JIT_RET, JIT_RET, sizeof(void*));
	jit_subi_i(JIT_FP, JIT_FP, sizeof(void*));
	jit_subi_i(JIT_R1, JIT_R1, sizeof(void*));
	jit_jmpi(next);
	jit_patch(ref);
	jit_popr_p(JIT_R1);
	jit_popr_p(JIT_R0);
	jit_addr_p(JIT_SP, JIT_SP, JIT_R1);
	jit_jmpr(JIT_R0);

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

	gates->evaluate_expr_thunk = jit_get_ip().ptr;
	jit_prepare(2);
	jit_pusharg_p(JIT_VCLOS);
	jit_pusharg_p(JIT_VSTATE);
	jit_finish(pgf_evaluate_expr_thunk);
	ref = jit_beqr_p(jit_forward(), JIT_VCLOS, JIT_RET);
	jit_pushr_p(JIT_VCLOS);
	jit_pushr_p(JIT_FP);
	jit_movi_p(JIT_R1, gates->update_closure);
	jit_pushr_p(JIT_R1);
	jit_retval(JIT_VCLOS);
	jit_patch(ref);
	jit_ldr_p(JIT_R0, JIT_VCLOS);
	jit_jmpr(JIT_R0);

	pgf_jit_make_space(rdr, JIT_CODE_WINDOW);

	gates->evaluate_value_lambda = jit_get_ip().ptr;
	jit_subr_p(JIT_R0, JIT_FP, JIT_SP);
	jit_blti_i(gates->update_pap, JIT_R0, 2*sizeof(PgfClosure*));
	jit_popr_p(JIT_R2);
	jit_popr_p(JIT_R1);
	jit_pushr_p(JIT_R2);
	jit_prepare(3);
	jit_pusharg_p(JIT_R1);
	jit_pusharg_p(JIT_VCLOS);
	jit_pusharg_p(JIT_VSTATE);
	jit_finish(pgf_evaluate_lambda_application);
	jit_retval(JIT_VCLOS);
	jit_ldr_p(JIT_R0, JIT_VCLOS);
	jit_jmpr(JIT_R0);

	gates->mk_const = jit_get_ip().ptr;
	jit_ldxi_p(JIT_R0, JIT_VHEAP, offsetof(PgfAbsFun,arity));
	jit_muli_i(JIT_R0, JIT_R0, sizeof(PgfClosure*));
	jit_pushr_i(JIT_R0);
	jit_prepare(2);
	jit_addi_i(JIT_R0, JIT_R0, sizeof(PgfValue));
	jit_pusharg_ui(JIT_R0);
	jit_ldxi_p(JIT_R0, JIT_VSTATE, offsetof(PgfEvalState,pool));
	jit_pusharg_p(JIT_R0);
	jit_finish(gu_malloc);
	jit_movi_p(JIT_R1, gates->evaluate_value);
	jit_str_p(JIT_RET, JIT_R1);
	jit_stxi_p(offsetof(PgfValue,absfun), JIT_RET, JIT_VHEAP);
	jit_movr_p(JIT_VHEAP, JIT_RET);
	jit_popr_i(JIT_R1);
	jit_popr_p(JIT_VCLOS);
	next = jit_get_label();
	ref  = jit_blei_i(jit_forward(), JIT_R1, 0);
	jit_popr_p(JIT_R2);
	jit_stxi_p(offsetof(PgfValue,args), JIT_RET, JIT_R2);
	jit_addi_i(JIT_RET, JIT_RET, sizeof(void*));
	jit_subi_i(JIT_R1, JIT_R1, sizeof(void*));
	jit_jmpi(next);
	jit_patch(ref);
	jit_jmpr(JIT_VCLOS);

	gates->fin.fn = pgf_jit_finalize_defrules;
	gates->defrules = NULL;
	gu_pool_finally(rdr->opool, &gates->fin);

	return gates;
}

#define PGF_DEFRULES_DELTA 20

void
pgf_jit_function(PgfReader* rdr, PgfAbstr* abstr,
                 PgfAbsFun* absfun)
{
#ifdef PGF_JIT_DEBUG
	GuPool* tmp_pool = gu_new_pool();
    GuOut* out = gu_file_out(stderr, tmp_pool);
    GuExn* err = gu_exn(NULL, type, tmp_pool);
    
	gu_string_write(absfun->name, out, err);
	gu_puts(":\n", out, err);
#endif

	if (rdr->jit_state->n_closures % PGF_DEFRULES_DELTA == 0) {
		abstr->eval_gates->defrules =
			gu_realloc_seq(abstr->eval_gates->defrules,
			               PgfFunction,
			               rdr->jit_state->n_closures + PGF_DEFRULES_DELTA);
	}
	absfun->closure_id = ++rdr->jit_state->n_closures;

	size_t n_segments = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );

	gu_buf_flush(rdr->jit_state->segment_patches);

	for (size_t segment = 0; segment < n_segments; segment++) {
		size_t n_instrs = pgf_read_len(rdr);
		gu_return_on_exn(rdr->err, );

		pgf_jit_make_space(rdr, (JIT_CODE_WINDOW/4)*n_instrs);

		if (segment == 0) {
			gu_seq_set(abstr->eval_gates->defrules,
			           PgfFunction,
			           absfun->closure_id-1,
			           jit_get_ip().ptr);
		}

		size_t curr_offset = 0;

		size_t n_patches = gu_buf_length(rdr->jit_state->segment_patches);
		for (size_t i = 0; i < n_patches; i++) {
			PgfSegmentPatch* patch = 
				gu_buf_index(rdr->jit_state->segment_patches, PgfSegmentPatch, i);
			if (patch->segment == segment) {
				if (patch->is_abs) {
					jit_patch_movi(patch->ref,jit_get_ip().ptr);
				} else {
					jit_patch(patch->ref);
				}
			}
		}

#ifdef PGF_JIT_DEBUG
		gu_printf(out, err, "%03d ", segment);
#endif

		for (size_t label = 0; label < n_instrs; label++) {
#ifdef PGF_JIT_DEBUG
			if (label > 0)
				gu_printf(out, err, "    ");
#endif

			uint8_t tag = pgf_read_tag(rdr);
			uint8_t opcode = tag >> 2;
			uint8_t mod    = tag & 0x03;
			switch (opcode) {
			case PGF_INSTR_CHECK_ARGS: {
				int n = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "CHECK_ARGS  %d\n", n);
#endif
				jit_subr_p(JIT_R0, JIT_FP, JIT_SP);
				jit_blti_i(abstr->eval_gates->update_pap, JIT_R0, (n+1)*sizeof(PgfClosure*));
				break;
			}
			case PGF_INSTR_CASE: {
				PgfCId id  = pgf_read_cid(rdr, rdr->tmp_pool);
				int n      = pgf_read_int(rdr);
				int target = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "CASE        %s %d %03d\n", id, n, target);
#endif
				jit_insn *jump =
					jit_bnei_i(jit_forward(), JIT_RET, (int) jit_forward());

				PgfSegmentPatch label_patch;
				label_patch.segment = target;
				label_patch.ref     = jump;
				label_patch.is_abs  = false;
				gu_buf_push(rdr->jit_state->segment_patches, PgfSegmentPatch, label_patch);

				PgfCallPatch call_patch;
				call_patch.cid = id;
				call_patch.ref = jump-6;
				gu_buf_push(rdr->jit_state->call_patches, PgfCallPatch, call_patch);

				for (int i = 0; i < n; i++) {
					jit_ldxi_p(JIT_R0, JIT_VHEAP, sizeof(PgfValue)+sizeof(PgfClosure*)*i);
					jit_pushr_p(JIT_R0);
				}
				break;
			}
			case PGF_INSTR_CASE_LIT: {
				int target = 0;
				jit_insn *jump = 0;

				switch (mod) {
				case 0: {
					int n  = pgf_read_int(rdr);
					target = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "CASE_LIT    %d %03d\n", n, target);
#endif
					jit_ldxi_p(JIT_R1, JIT_RET, offsetof(PgfLiteralInt,val));
					jump =
						jit_bnei_i(jit_forward(), JIT_R1, n);
					break;
				}
				case 1: {
					GuString s = pgf_read_string(rdr);
					target = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "CASE_LIT    %s %03d\n", s, target);
#endif
					jit_pushr_p(JIT_RET);
					jit_prepare(2);
					jit_pusharg_p(JIT_RET);
					jit_movi_p(JIT_R0, s);
					jit_pusharg_p(JIT_R0);
					jit_finish(strcmp);
					jit_retval(JIT_R1);
					jit_popr_p(JIT_RET);
					jump =
						jit_bnei_i(jit_forward(), JIT_R1, 0);
					break;
				}
				case 2: {
					double d   = pgf_read_double(rdr);
					target = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "CASE_LIT    %f %03d\n", d, target);
#endif
					jit_ldxi_d(JIT_FPR0, JIT_RET, offsetof(PgfLiteralFlt,val));
					jit_movi_d(JIT_FPR1, d);
					jump =
						jit_bner_d(jit_forward(), JIT_FPR0, JIT_FPR1);
					break;
				}
				default:
					gu_impossible();
				}

				PgfSegmentPatch label_patch;
				label_patch.segment = target;
				label_patch.ref     = jump;
				label_patch.is_abs  = false;
				gu_buf_push(rdr->jit_state->segment_patches, PgfSegmentPatch, label_patch);

				break;
			}
			case PGF_INSTR_ALLOC: {
				size_t size = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "ALLOC       %d\n", size);
#endif
				jit_prepare(2);
				jit_movi_ui(JIT_R0, size*sizeof(void*));
				jit_pusharg_ui(JIT_R0);
				jit_ldxi_p(JIT_R0, JIT_VSTATE, offsetof(PgfEvalState,pool));
				jit_pusharg_p(JIT_R0);
				jit_finish(gu_malloc);
				jit_retval_p(JIT_VHEAP);

				curr_offset = 0;
				break;
			}
			case PGF_INSTR_PUT_CONSTR: {
				PgfCId id = pgf_read_cid(rdr, rdr->tmp_pool);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "PUT_CONSTR  %s\n", id);
#endif

				jit_movi_p(JIT_R0, abstr->eval_gates->evaluate_value);
				jit_stxi_p(curr_offset*sizeof(void*), JIT_VHEAP, JIT_R0);
				curr_offset++;
				
				PgfCallPatch patch;
				patch.cid = id;
				patch.ref = jit_movi_p(JIT_R0, jit_forward());
				jit_stxi_p(curr_offset*sizeof(void*), JIT_VHEAP, JIT_R0);
				curr_offset++;

				gu_buf_push(rdr->jit_state->call_patches, PgfCallPatch, patch);
				break;
			}
			case PGF_INSTR_PUT_CLOSURE: {
				size_t target = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "PUT_CLOSURE %03d\n", target);
#endif

				PgfSegmentPatch patch;
				patch.segment = target;
				patch.ref     = jit_movi_p(JIT_R0, jit_forward());
				patch.is_abs  = true;
				jit_stxi_p(curr_offset*sizeof(void*), JIT_VHEAP, JIT_R0);
				curr_offset++;

				gu_buf_push(rdr->jit_state->segment_patches, PgfSegmentPatch, patch);
				break;
			}
			case PGF_INSTR_PUT_LIT: {
				jit_movi_p(JIT_R0, abstr->eval_gates->evaluate_value_lit);
				jit_stxi_p(curr_offset*sizeof(void*), JIT_VHEAP, JIT_R0);
				curr_offset++;

				PgfLiteral lit;
				switch (mod) {
				case 0: {
					PgfLiteralInt *lit_int =
						gu_new_variant(PGF_LITERAL_INT,
					                   PgfLiteralInt,
					                   &lit,
					                   rdr->opool);
					lit_int->val = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUT_LIT     %d\n", lit_int->val);
#endif
					break;
				}
				case 1: {
					GuLength len = pgf_read_len(rdr);
					uint8_t* buf = alloca(len*6+1);
					uint8_t* p   = buf;
					for (size_t i = 0; i < len; i++) {
						gu_in_utf8_buf(&p, rdr->in, rdr->err);
					}
					*p++ = 0;

					PgfLiteralStr *lit_str =
						gu_new_flex_variant(PGF_LITERAL_STR,
											PgfLiteralStr,
											val, p-buf,
											&lit, rdr->opool);
					strcpy((char*) lit_str->val, (char*) buf);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUT_LIT     \"%s\"\n", lit_str->val);
#endif
					break;
				}
				case 2: {
					PgfLiteralFlt *lit_flt =
						gu_new_variant(PGF_LITERAL_FLT,
					                   PgfLiteralFlt,
					                   &lit,
					                   rdr->opool);
					lit_flt->val = pgf_read_double(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUT_LIT     %f\n", lit_flt->val);
#endif
					break;
				}
				default:
					gu_impossible();
				}

				jit_movi_p(JIT_R0, lit);
				jit_stxi_p(curr_offset*sizeof(void*), JIT_VHEAP, JIT_R0);
				curr_offset++;
				break;
			}
			case PGF_INSTR_SET: {
				switch (mod) {
				case 0: {
					size_t offset = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "SET         hp(%d)\n", offset);
#endif
					jit_addi_p(JIT_R0, JIT_VHEAP, offset*sizeof(void*));
					break;
				}
				case 1: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "SET         stk(%d)\n", index);
#endif
					jit_ldxi_p(JIT_R0, JIT_SP, index*sizeof(PgfClosure*));
					break;
				}
				case 2: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "SET         env(%d)\n", index);
#endif
					jit_ldxi_p(JIT_R0, JIT_VCLOS, sizeof(PgfClosure)+index*sizeof(PgfClosure*));
					break;
				}
				default:
					gu_impossible();
				}
				
				jit_stxi_p(curr_offset*sizeof(void*), JIT_VHEAP, JIT_R0);
				curr_offset++;
				break;
			}
			case PGF_INSTR_SET_PAD: {
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "SET_PAD\n");
#endif
                jit_movi_p(JIT_R0, NULL);
				jit_stxi_p(curr_offset*sizeof(void*), JIT_VHEAP, JIT_R0);
				curr_offset++;
				break;
			}
			case PGF_INSTR_PUSH: {
				switch (mod) {
				case 0: {
					size_t offset = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUSH        hp(%d)\n", offset);
#endif

					if (offset == 0) {
						jit_pushr_p(JIT_VHEAP);
					} else {
						jit_addi_p(JIT_R0, JIT_VHEAP, offset*sizeof(void*));
						jit_pushr_p(JIT_R0);
					}
					break;
				}
				case 1: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUSH        stk(%d)\n", index);
#endif
					jit_ldxi_p(JIT_R0, JIT_SP, index*sizeof(PgfClosure*));
					jit_pushr_p(JIT_R0);
					break;
				}
				case 2: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUSH        env(%d)\n", index);
#endif
					jit_ldxi_p(JIT_R0, JIT_VCLOS, sizeof(PgfClosure)+index*sizeof(PgfClosure*));
					jit_pushr_p(JIT_R0);
					break;
				}
				default:
					gu_impossible();
				}
				break;
			}
			case PGF_INSTR_EVAL+0:
			case PGF_INSTR_EVAL+2:
				jit_movr_p(JIT_R2, JIT_VCLOS);
			case PGF_INSTR_EVAL+1: {
				switch (mod) {
				case 0: {
					size_t offset = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "EVAL        hp(%d)", offset);
#endif
					jit_addi_p(JIT_VCLOS, JIT_VHEAP, offset*sizeof(void*));
					break;
				}
				case 1: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "EVAL        stk(%d)", index);
#endif
					jit_ldxi_p(JIT_VCLOS, JIT_SP, index*sizeof(PgfClosure*));
					break;
				}
				case 2: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "EVAL        env(%d)", index);
#endif
					jit_ldxi_p(JIT_VCLOS, JIT_VCLOS, sizeof(PgfClosure)+index*sizeof(PgfClosure*));
					break;
				}
				case 3: {
					PgfCId id = pgf_read_cid(rdr, rdr->tmp_pool);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "EVAL        %s", id);
#endif
					PgfCallPatch patch;
					patch.cid = id;
					patch.ref = jit_addi_p(JIT_VCLOS, JIT_VSTATE, jit_forward());
					gu_buf_push(rdr->jit_state->call_patches, PgfCallPatch, patch);
					break;
				}
				default:
					gu_impossible();
				}

				jit_ldr_p(JIT_R0, JIT_VCLOS);

				switch (opcode - PGF_INSTR_EVAL) {
				case 0: {
#ifdef PGF_JIT_DEBUG
				    gu_printf(out, err, "\n");
#endif
					jit_pushr_p(JIT_R2);
					jit_pushr_p(JIT_FP);
					jit_movr_p(JIT_FP, JIT_SP);
					jit_callr(JIT_R0);
					jit_popr_p(JIT_FP);
					jit_popr_p(JIT_VCLOS);
					break;
				}
				case 1: {
					size_t a = pgf_read_int(rdr);
				    size_t b = pgf_read_int(rdr);
				    size_t c = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
				    gu_printf(out, err, " tail(%d,%d,%d)\n", a, b, c);
#endif

					jit_ldxi_p(JIT_R2, JIT_SP, sizeof(PgfClosure*)*(c-a-1));
					for (size_t i = 0; i < c-b; i++) {
						jit_ldxi_p(JIT_R1, JIT_SP, sizeof(PgfClosure*)*((c-b-1)-i));
						jit_stxi_p(sizeof(PgfClosure*)*((c-1)-i), JIT_SP, JIT_R1);
					}
					jit_addi_p(JIT_SP, JIT_SP, b*sizeof(PgfClosure*));
					jit_pushr_p(JIT_R2);
					jit_jmpr(JIT_R0);
					break;
				}
				case 2: {
				    size_t b = pgf_read_int(rdr);
				    size_t c = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
				    gu_printf(out, err, " update(%d,%d)\n", b, c);
#endif

					if (b >= 3) {
						jit_stxi_p(sizeof(PgfClosure*)*(c-3), JIT_SP, JIT_FP);
						jit_stxi_p(sizeof(PgfClosure*)*(c-2), JIT_SP, JIT_R2);
						for (size_t i = 0; i < c-b; i++) {
							jit_ldxi_p(JIT_R1, JIT_SP, sizeof(PgfClosure*)*((c-b-1)-i));
							jit_stxi_p(sizeof(PgfClosure*)*((c-4)-i), JIT_SP, JIT_R1);
						}
						jit_addi_p(JIT_SP, JIT_SP, (b-3)*sizeof(PgfClosure*));
					} else {
						jit_subi_p(JIT_SP, JIT_SP, (3-b)*sizeof(PgfClosure*));
						for (size_t i = 0; i < c-b; i++) {
							jit_ldxi_p(JIT_R1, JIT_SP, sizeof(PgfClosure*)*(i+(3-b)));
							jit_stxi_p(sizeof(PgfClosure*)*i, JIT_SP, JIT_R1);
						}
						jit_stxi_p(sizeof(PgfClosure*)*(c-b),   JIT_SP, JIT_FP);
						jit_stxi_p(sizeof(PgfClosure*)*(c-b+1), JIT_SP, JIT_R2);
					}

					jit_addi_p(JIT_FP, JIT_SP, sizeof(PgfClosure*)*(c-b));
					jit_movi_p(JIT_R1, abstr->eval_gates->update_closure);
					jit_pushr_p(JIT_R1);

					jit_jmpr(JIT_R0);
					break;
				}
				default:
					gu_impossible();
				}
				break;
			}
			case PGF_INSTR_DROP: {
				size_t n      = pgf_read_int(rdr);
				size_t target = pgf_read_int(rdr);

#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "DROP        %d %03d\n", n, target);
#endif
				
				if (n > 0)
					jit_addi_p(JIT_SP, JIT_SP, n*sizeof(PgfClosure*));
				
				jit_insn *jump =
					jit_jmpi(jit_forward());

				PgfSegmentPatch label_patch;
				label_patch.segment = target;
				label_patch.ref     = jump;
				label_patch.is_abs  = false;
				gu_buf_push(rdr->jit_state->segment_patches, PgfSegmentPatch, label_patch);

				break;
			}
			case PGF_INSTR_FAIL:
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "FAIL\n");
#endif
				jit_movi_p(JIT_VHEAP, absfun);
				jit_jmpi(abstr->eval_gates->mk_const);
				break;
			default:
				gu_impossible();
			}
		}
	}
}

void
pgf_jit_done(PgfReader* rdr, PgfAbstr* abstr)
{
	size_t n_patches = gu_buf_length(rdr->jit_state->call_patches);
	for (size_t i = 0; i < n_patches; i++) {
		PgfCallPatch* patch =
			gu_buf_index(rdr->jit_state->call_patches, PgfCallPatch, i);

		PgfAbsCat* arg =
			gu_map_get(abstr->cats, patch->cid, PgfAbsCat*);
		if (arg != NULL) {
			jit_patch_calli(patch->ref,(jit_insn*) arg->predicate);
		} else {
			PgfAbsFun* con =
				gu_map_get(abstr->funs, patch->cid, PgfAbsFun*);
			if (con == NULL)
				gu_impossible();
			else if (con->closure_id == 0) {
				jit_patch_movi(patch->ref,con);
			} else {
				size_t offset =
					offsetof(PgfEvalState,globals)+
					sizeof(PgfIndirection)*(con->closure_id-1);
				jit_patch_movi(patch->ref,offset);
			}
		}
	}
	
	jit_flush_code(rdr->jit_state->buf, jit_get_ip().ptr);
}
