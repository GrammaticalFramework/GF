#include <gu/seq.h>
#include <gu/file.h>
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
#define JIT_CODE_WINDOW 1280

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

	PgfPageFinalizer* fin = 
		gu_new(PgfPageFinalizer, rdr->opool);
	fin->fin.fn = pgf_jit_finalize_page;
	fin->page = page;
	gu_pool_finally(rdr->opool, &fin->fin);
	
	rdr->jit_state->buf = page;
	jit_set_ip(rdr->jit_state->buf);
}

PgfJitState*
pgf_new_jit(PgfReader* rdr)
{
	PgfJitState* state = gu_new(PgfJitState, rdr->tmp_pool);
	state->call_patches  = gu_new_buf(PgfCallPatch,  rdr->tmp_pool);
	state->segment_patches = gu_new_buf(PgfSegmentPatch, rdr->tmp_pool);
	state->buf = NULL;
	state->save_ip_ptr = NULL;
	return state;
}

static void
pgf_jit_make_space(PgfReader* rdr)
{
	size_t page_size = getpagesize();
	if (rdr->jit_state->buf == NULL) {
		pgf_jit_alloc_page(rdr);
	} else {
		assert (rdr->jit_state->save_ip_ptr + JIT_CODE_WINDOW > jit_get_ip().ptr);

		if (jit_get_ip().ptr + JIT_CODE_WINDOW > ((char*) rdr->jit_state->buf) + page_size) {
			jit_flush_code(rdr->jit_state->buf, jit_get_ip().ptr);
			pgf_jit_alloc_page(rdr);
		}
	}

	rdr->jit_state->save_ip_ptr = jit_get_ip().ptr;
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

	pgf_jit_make_space(rdr);

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
		pgf_jit_make_space(rdr);

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
					pgf_jit_make_space(rdr);

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
pgf_jit_compile_slide(PgfReader* rdr, int es_arg, size_t a, size_t b)
{
	if (a == b) {
		jit_prepare(2);
		jit_movi_i(JIT_V1, a);
		jit_pusharg_p(JIT_V1);
		jit_getarg_p(JIT_V1, es_arg);
		jit_ldxi_p(JIT_V1, JIT_V1, offsetof(PgfEvalState,stack));
		jit_pusharg_p(JIT_V1);
		jit_finish(gu_buf_trim_n);
	} else {
		jit_prepare(3);
		jit_movi_i(JIT_V1, b);
		jit_pusharg_p(JIT_V1);
		jit_movi_i(JIT_V1, a);
		jit_pusharg_p(JIT_V1);
		jit_getarg_p(JIT_V1, es_arg);
		jit_pusharg_p(JIT_V1);
		jit_finish(pgf_evaluate_slide);
	}
}

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

	pgf_jit_make_space(rdr);

	absfun->function = jit_get_ip().ptr;

	size_t n_segments = pgf_read_len(rdr);
	gu_return_on_exn(rdr->err, );

	gu_buf_flush(rdr->jit_state->segment_patches);

	int es_arg = 0;
	int closure_arg = 0;

	for (size_t segment = 0; segment < n_segments; segment++) {
		size_t n_instrs = pgf_read_len(rdr);
		gu_return_on_exn(rdr->err, );
		
		size_t curr_offset = 0;

		size_t n_patches = gu_buf_length(rdr->jit_state->segment_patches);
		if (n_patches > 0) {
			PgfSegmentPatch* patch = 
				gu_buf_index(rdr->jit_state->segment_patches, PgfSegmentPatch, n_patches-1);
			if (patch->segment == segment) {
				if (patch->is_abs)
					jit_patch_movi(patch->ref,jit_get_ip().ptr);
				else
					jit_patch(patch->ref);
				gu_buf_trim_n(rdr->jit_state->segment_patches, 1);
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
			uint8_t opcode = tag >> 3;
			uint8_t mod    = tag & 0x07;
			switch (opcode) {
			case PGF_INSTR_ENTER: {
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "ENTER\n");
#endif

				jit_prolog(2);
				es_arg = jit_arg_p();
				closure_arg = jit_arg_p();
				break;
			}
			case PGF_INSTR_CASE: {
				PgfCId id  = pgf_read_cid(rdr, rdr->opool);
				int target = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "CASE        %s %03d\n", id, target);
#endif
				jit_insn *jump= 
					jit_bnei_i(jit_forward(), JIT_V0, (int) jit_forward());

				PgfSegmentPatch label_patch;
				label_patch.segment = target;
				label_patch.ref     = jump;
				label_patch.is_abs  = false;
				gu_buf_push(rdr->jit_state->segment_patches, PgfSegmentPatch, label_patch);

				PgfCallPatch call_patch;
				call_patch.cid = id;
				call_patch.ref = jump-6;
				gu_buf_push(rdr->jit_state->call_patches, PgfCallPatch, call_patch);

				jit_prepare(2);
				jit_pusharg_p(JIT_V1);
				jit_getarg_p(JIT_V2, es_arg);
				jit_pusharg_p(JIT_V2);
				jit_finish(pgf_evaluate_save_variables);
				break;
			}
			case PGF_INSTR_CASE_LIT: {
				switch (mod) {
				case 0: {
					int n      = pgf_read_int(rdr);
					int target = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "CASE_LIT    %d %03d\n", n, target);
#endif
					break;
				}
				case 1: {
					GuString s = pgf_read_string(rdr);
					int target = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "CASE_LIT    %s %03d\n", s, target);
#endif
					break;
				}
				case 2: {
					double d   = pgf_read_double(rdr);
					int target = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "CASE_LIT    %f %03d\n", d, target);
#endif
					break;
				}
				default:
					gu_impossible();
				}
				break;
			}
			case PGF_INSTR_ALLOC: {
				size_t size = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "ALLOC       %d\n", size);
#endif
				jit_prepare(2);
				jit_movi_ui(JIT_V0, size*sizeof(void*));
				jit_pusharg_ui(JIT_V0);
				jit_getarg_p(JIT_V0, es_arg);
				jit_ldxi_p(JIT_V0, JIT_V0, offsetof(PgfEvalState,pool));
				jit_pusharg_p(JIT_V0);
				jit_finish(gu_malloc);
				jit_retval_p(JIT_V1);
				
				curr_offset = 0;
				break;
			}
			case PGF_INSTR_PUT_CONSTR: {
				PgfCId id = pgf_read_cid(rdr, rdr->tmp_pool);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "PUT_CONSTR  %s\n", id);
#endif

				jit_movi_p(JIT_V0, pgf_evaluate_value);
				jit_stxi_p(curr_offset*sizeof(void*), JIT_V1, JIT_V0);
				curr_offset++;
				
				PgfCallPatch patch;
				patch.cid = id;
				patch.ref = jit_movi_p(JIT_V0, jit_forward());
				jit_stxi_p(curr_offset*sizeof(void*), JIT_V1, JIT_V0);
				curr_offset++;

				gu_buf_push(rdr->jit_state->call_patches, PgfCallPatch, patch);
				break;
			}
			case PGF_INSTR_PUT_FUN: {
				PgfCId id = pgf_read_cid(rdr, rdr->tmp_pool);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "PUT_FUN     %s\n", id);
#endif
				
				PgfCallPatch patch;
				patch.cid = id;
				patch.ref = jit_movi_p(JIT_V0, jit_forward());
				jit_ldxi_p(JIT_V0, JIT_V0, offsetof(PgfAbsFun,function));
				jit_stxi_p(curr_offset*sizeof(void*), JIT_V1, JIT_V0);
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
				patch.ref     = jit_movi_p(JIT_V0, jit_forward());
				patch.is_abs  = true;
				jit_stxi_p(curr_offset*sizeof(void*), JIT_V1, JIT_V0);
				curr_offset++;
				
				gu_buf_push(rdr->jit_state->segment_patches, PgfSegmentPatch, patch);
				break;
			}
			case PGF_INSTR_PUT_LIT: {
				switch (mod) {
				case 0: {
					size_t n = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUT_LIT     %d\n", n);
#endif
					break;
				}
				case 1: {
					GuString s = pgf_read_string(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUT_LIT     \"%s\"\n", s);
#endif
					break;
				}
				case 2: {
					double d = pgf_read_double(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUT_LIT     %f\n", d);
#endif
					break;
				}
				default:
					gu_impossible();
				}
				break;
			}
			case PGF_INSTR_SET: {
				switch (mod) {
				case 0: {
					size_t offset = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "SET         hp(%d)\n", offset);
#endif
					jit_addi_p(JIT_V0, JIT_V1, offset*sizeof(void*));
					break;
				}
				case 1: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "SET         stk(%d)\n", index);
#endif

					jit_getarg_p(JIT_V0, es_arg);
					jit_ldxi_p(JIT_V0, JIT_V0, offsetof(PgfEvalState,stack));
					jit_prepare(1);
					jit_pusharg_p(JIT_V0);
					jit_finish(gu_buf_last);
					jit_ldxi_p(JIT_V0, JIT_RET, -index*sizeof(PgfClosure*));
					break;
				}
				case 2: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "SET         env(%d)\n", index);
#endif

					jit_getarg_p(JIT_V0, closure_arg);
					jit_ldxi_p(JIT_V0, JIT_V0, sizeof(PgfClosure)+index*sizeof(PgfClosure*));
					break;
				}
				default:
					gu_impossible();
				}
				
				jit_stxi_p(curr_offset*sizeof(void*), JIT_V1, JIT_V0);
				curr_offset++;
				break;
			}
			case PGF_INSTR_SET_PAD: {
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "SET_PAD\n");
#endif
                jit_movi_p(JIT_V0, NULL);
				jit_stxi_p(curr_offset*sizeof(void*), JIT_V1, JIT_V0);
				curr_offset++;
				break;
			}
			case PGF_INSTR_PUSH: {
				jit_getarg_p(JIT_V0, es_arg);
				jit_ldxi_p(JIT_V0, JIT_V0, offsetof(PgfEvalState,stack));
				jit_prepare(1);
				jit_pusharg_p(JIT_V0);
				jit_finish(gu_buf_extend);

				switch (mod) {
				case 0: {
					size_t offset = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUSH        hp(%d)\n", offset);
#endif

					if (offset == 0) {
						jit_str_p(JIT_RET, JIT_V1);
					} else {
						jit_addi_p(JIT_V0, JIT_V1, offset*sizeof(void*));
						jit_str_p(JIT_RET, JIT_V0);
					}
					break;
				}
				case 1: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUSH        stk(%d)\n", index);
#endif

					jit_ldxi_p(JIT_V0, JIT_RET, -(index+1)*sizeof(PgfClosure*));
					jit_str_p(JIT_RET, JIT_V0);
					break;
				}
				case 2: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "PUSH        env(%d)\n", index);
#endif

					jit_getarg_p(JIT_V0, closure_arg);				
					jit_ldxi_p(JIT_V0, JIT_V0, sizeof(PgfClosure)+index*sizeof(PgfClosure*));
					jit_str_p(JIT_RET, JIT_V0);
					break;
				}
				default:
					gu_impossible();
				}
				break;
			}
			case PGF_INSTR_EVAL: {
				switch (mod & 0x3) {
				case 0: {
					size_t offset = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "EVAL        hp(%d)", offset);
#endif

					jit_addi_p(JIT_V0, JIT_V1, offset*sizeof(void*));
					break;
				}
				case 1: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "EVAL        stk(%d)", index);
#endif

					jit_getarg_p(JIT_V0, es_arg);
					jit_ldxi_p(JIT_V0, JIT_V0, offsetof(PgfEvalState,stack));
					jit_prepare(1);
					jit_pusharg_p(JIT_V0);
					jit_finish(gu_buf_last);
					jit_ldxi_p(JIT_V0, JIT_RET, -index*sizeof(PgfClosure*));
					break;
				}
				case 2: {
					size_t index = pgf_read_int(rdr);
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "EVAL        env(%d)", index);
#endif
					break;
				}
				default:
					gu_impossible();
				}

				switch (mod >> 2) {
				case 0: {
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "\n");
#endif

					jit_prepare(2);
					jit_pusharg_p(JIT_V0);
					jit_getarg_p(JIT_V2, es_arg);
					jit_pusharg_p(JIT_V2);
					jit_ldr_p(JIT_V0, JIT_V0);
					jit_finishr(JIT_V0);
					jit_retval_p(JIT_V1);
					jit_ldxi_p(JIT_V0, JIT_V1, offsetof(PgfValue, absfun));
					break;
				}
				case 1: {
					size_t a = pgf_read_int(rdr);
					size_t b = pgf_read_int(rdr);

#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, " tail(%d,%d)\n", a, b);
#endif

					pgf_jit_compile_slide(rdr, es_arg, a, b);
				    jit_setarg_p(JIT_V0, closure_arg);
					jit_ldr_p(JIT_RET, JIT_V0);
					jit_tail_finishr(JIT_RET);
					break;
				}
				default:
					gu_impossible();
				}
				break;
			}
			case PGF_INSTR_CALL: {
				PgfCId id = pgf_read_cid(rdr, rdr->tmp_pool);
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "CALL        %s", id);
#endif
				
				switch (mod >> 2) {
				case 0: {
#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, "\n");
#endif

					jit_getarg_p(JIT_V0, es_arg);
					jit_getarg_p(JIT_V1, closure_arg);
					jit_prepare(2);
					jit_pusharg_p(JIT_V1);
					jit_pusharg_p(JIT_V0);

					PgfCallPatch patch;
					patch.cid = id;
					patch.ref = jit_movi_p(JIT_V0, jit_forward());
					gu_buf_push(rdr->jit_state->call_patches, PgfCallPatch, patch);			
					jit_ldxi_p(JIT_V0, JIT_V0, offsetof(PgfAbsFun,function));

					jit_finishr(JIT_V0);
					jit_retval_p(JIT_V1);
					break;
				}
				case 1: {
					size_t a = pgf_read_int(rdr);
					size_t b = pgf_read_int(rdr);

#ifdef PGF_JIT_DEBUG
					gu_printf(out, err, " tail(%d,%d)\n", a, b);
#endif

					pgf_jit_compile_slide(rdr, es_arg, a, b);

					PgfCallPatch patch;
					patch.cid = id;
					patch.ref = jit_movi_p(JIT_V0, jit_forward());
					gu_buf_push(rdr->jit_state->call_patches, PgfCallPatch, patch);			
					jit_ldxi_p(JIT_RET, JIT_V0, offsetof(PgfAbsFun,function));
					jit_tail_finishr(JIT_RET);
					break;
				}
				default:
					gu_impossible();
				}
				break;
			}
			case PGF_INSTR_FAIL:
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "FAIL\n");
#endif
				break;
			case PGF_INSTR_UPDATE: {
#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "UPDATE\n");
#endif

				jit_getarg_p(JIT_V0, closure_arg);
				jit_movi_p(JIT_V2, pgf_evaluate_indirection);
				jit_stxi_p(0, JIT_V0, JIT_V2);
				jit_stxi_p(sizeof(PgfClosure), JIT_V0, JIT_V1);
				break;
			}
			case PGF_INSTR_RET: {
				size_t count = pgf_read_int(rdr);

#ifdef PGF_JIT_DEBUG
				gu_printf(out, err, "RET         %d\n", count);
#endif

				if (count > 0) {
					jit_prepare(2);
					jit_movi_ui(JIT_V0, count);
					jit_pusharg_p(JIT_V0);
					jit_getarg_p(JIT_V0, es_arg);
					jit_ldxi_p(JIT_V0, JIT_V0, offsetof(PgfEvalState,stack));
					jit_pusharg_p(JIT_V0);
					jit_finish(gu_buf_trim_n);
				}

				jit_movr_p(JIT_RET, JIT_V1);
				jit_ret();
				break;
			}
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
		if (arg != NULL)
			jit_patch_calli(patch->ref,(jit_insn*) arg->predicate);
		else {
			PgfAbsFun* con =
				gu_map_get(abstr->funs, patch->cid, PgfAbsFun*);
			if (con != NULL)
				jit_patch_movi(patch->ref,con);
			else {
				gu_impossible();
			}
		}
	}
	
	jit_flush_code(rdr->jit_state->buf, jit_get_ip().ptr);
}
