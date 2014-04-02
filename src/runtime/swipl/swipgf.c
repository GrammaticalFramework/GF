#include <SWI-Prolog.h>
#include <pgf/pgf.h>

typedef struct {
	GuPool* pool;
	PgfPGF* pgf;
} PlPGF;

static PL_blob_t pgf_blob = {
	PL_BLOB_MAGIC,
	PL_BLOB_UNIQUE,
	"PGF",
	NULL,
	NULL,
	NULL,
	NULL
};

static foreign_t
pl_readPGF(term_t a1, term_t a2)
{
	char *fpath;

	if (!PL_get_atom_chars(a1, &fpath) )
		PL_fail;
		
	PlPGF pl_pgf;
	pl_pgf.pool = gu_new_pool();

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	// Read the PGF grammar.
	pl_pgf.pgf = pgf_read(fpath, pl_pgf.pool, err);
	if (!gu_ok(err)) {
		int res;
		if (gu_exn_caught(err) == gu_type(GuErrno)) {
			errno = *((GuErrno*) gu_exn_caught_data(err));
			res = PL_existence_error("source_sink", a1);
		} else {
			res = PL_raise_exception(a1);
		}
		gu_pool_free(pl_pgf.pool);
		gu_pool_free(tmp_pool);
		return res;
	}

	gu_pool_free(tmp_pool);

	if (!PL_unify_blob(a2, &pl_pgf, sizeof(pl_pgf), &pgf_blob)) {
		gu_pool_free(pl_pgf.pool);
		PL_fail;
	}

	PL_succeed;
}

static foreign_t
pl_language(term_t a1, term_t a2, term_t a3, control_t handle)
{
	switch (PL_foreign_control(handle)) {
	case PL_FIRST_CALL:
        //ctxt = malloc(sizeof(struct context));
        PL_retry_address(NULL/*ctxt*/);
    case PL_REDO:
        //ctxt = PL_foreign_context_address(handle);
        PL_retry_address(NULL/*ctxt*/);
    case PL_PRUNED:
        //ctxt = PL_foreign_context_address(handle);
        //free(ctxt);
        PL_succeed;
	}
	PL_succeed;
}

install_t
install_swipgf()
{ PL_register_foreign("readPGF", 2, pl_readPGF, 0);
  PL_register_foreign("language", 3, pl_language, PL_FA_NONDETERMINISTIC);
}
