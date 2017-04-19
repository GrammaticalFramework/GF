#include <gu/file.h>

typedef struct GuFileOutStream GuFileOutStream;

struct GuFileOutStream {
	GuOutStream stream;
	FILE* file;
};

static size_t
gu_file_output(GuOutStream* stream, const uint8_t* buf, size_t len, GuExn* err)
{
	GuFileOutStream* fos = gu_container(stream, GuFileOutStream, stream);
	errno = 0;
	size_t wrote = fwrite(buf, 1, len, fos->file);
	if (wrote < len) {
		if (ferror(fos->file)) {
			gu_raise_errno(err);
		}
	}
	return wrote;
}

static void
gu_file_flush(GuOutStream* stream, GuExn* err)
{
	GuFileOutStream* fos = gu_container(stream, GuFileOutStream, stream);
	errno = 0;
	if (fflush(fos->file) != 0) {
		gu_raise_errno(err);
	}
}

GU_API GuOut*
gu_file_out(FILE* file, GuPool* pool)
{
	GuFileOutStream* fos = gu_new(GuFileOutStream, pool);
	fos->stream.begin_buf = NULL;
	fos->stream.end_buf = NULL;
	fos->stream.output = gu_file_output;
	fos->stream.flush = gu_file_flush;
	fos->file = file;
	return gu_new_out(&fos->stream, pool);
}


typedef struct GuFileInStream GuFileInStream;

struct GuFileInStream {
	GuInStream stream;
	FILE* file;
};

static size_t 
gu_file_input(GuInStream* stream, uint8_t* buf, size_t sz, GuExn* err)
{
	GuFileInStream* fis = gu_container(stream, GuFileInStream, stream);
	errno = 0;
	size_t got = fread(buf, 1, sz, fis->file);
	if (got == 0) {
		if (ferror(fis->file)) {
			gu_raise_errno(err);
		}
	}
	return got;
}

GU_API GuIn*
gu_file_in(FILE* file, GuPool* pool)
{
	GuFileInStream* fis = gu_new(GuFileInStream, pool);
	fis->stream.begin_buffer = NULL;
	fis->stream.end_buffer = NULL;
	fis->stream.input = gu_file_input;
	fis->file = file;
	return gu_new_in(&fis->stream, pool);
}
