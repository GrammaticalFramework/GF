#include <pgf/pgf.h>
#include <pgf/data.h>

#include <gu/dump.h>
#include <gu/file.h>
#include <gu/utf8.h>

#include <locale.h>
#include <stdlib.h>

GU_DECLARE_TYPE(PgfAbstr, struct);

int main(int argc, char* argv[]) {
	// Set the character locale, so we can produce proper output.
	setlocale(LC_CTYPE, "");

	if (argc != 1) {
		fprintf(stderr, "usage: %s pgf\n", argv[0]);
		return EXIT_FAILURE;
	}
	char* filename = argv[1];

	GuPool* pool = gu_new_pool();
	GuExn* err = gu_exn(NULL, type, pool);
	PgfPGF* pgf = pgf_read(filename, pool, err);
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

