#include <pgf/pgf.h>
#include <pgf/data.h>

#include <gu/dump.h>
#include <gu/file.h>
#include <gu/utf8.h>

GU_DECLARE_TYPE(PgfAbstr, struct);

int main(void) {
	GuPool* pool = gu_new_pool();
	GuExn* err = gu_exn(NULL, type, pool);
	GuIn* in = gu_file_in(stdin, pool);
	PgfPGF* pgf = pgf_read(in, pool, err);
	int status = 0;
	if (!gu_ok(err)) {
		fprintf(stderr, "Reading PGF failed\n");
		status = 1;
		goto fail_read;
	}
	GuOut* out = gu_file_out(stdout, pool);
	GuWriter* wtr = gu_new_utf8_writer(out, pool);
    pgf_print(pgf, wtr, err);
	gu_writer_flush(wtr, err);
fail_read:
	gu_pool_free(pool);
	return status;
}

