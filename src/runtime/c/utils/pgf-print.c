#include <pgf/pgf.h>
#include <pgf/data.h>

#include <gu/file.h>
#include <gu/utf8.h>

#include <locale.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
	// Set the character locale, so we can produce proper output.
	setlocale(LC_CTYPE, "");

	if (argc != 2) {
		fprintf(stderr, "usage: %s pgf\n", argv[0]);
		return EXIT_FAILURE;
	}
	char* filename = argv[1];

	GuPool* pool = gu_new_pool();
	GuExn* err = gu_exn(pool);
	PgfPGF* pgf = pgf_read(filename, pool, err);
	int status = 0;
	if (!gu_ok(err)) {
		fprintf(stderr, "Reading PGF failed\n");
		status = 1;
		goto fail_read;
	}
	GuOut* out = gu_file_out(stdout, pool);
    pgf_print(pgf, out, err);
	gu_out_flush(out, err);
fail_read:
	gu_pool_free(pool);
	return status;
}

