#include <gu/write.h>


size_t
gu_utf32_write(const GuUCS* src, size_t len, GuWriter* wtr, GuExn* err)
{
	return gu_utf32_out_utf8(src, len, &wtr->out_, err);
}


void
gu_vprintf(const char* fmt, va_list args, GuWriter* wtr, GuExn* err)
{
	GuPool* tmp_pool = gu_local_pool();
	char* str = gu_vasprintf(fmt, args, tmp_pool);
	gu_puts(str, wtr, err);
	gu_pool_free(tmp_pool);
}

void
gu_printf(GuWriter* wtr, GuExn* err, const char* fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	gu_vprintf(fmt, args, wtr, err);
	va_end(args);
}


GuWriter*
gu_new_utf8_writer(GuOut* utf8_out, GuPool* pool)
{
	GuOutStream* stream = gu_out_proxy_stream(utf8_out, pool);
	GuWriter* wtr = gu_new(GuWriter, pool);
	wtr->out_ = gu_init_out(stream);
	return wtr;
}

extern inline void
gu_ucs_write(GuUCS ucs, GuWriter* wtr, GuExn* err);

extern inline void
gu_writer_flush(GuWriter* wtr, GuExn* err);

extern inline void
gu_putc(char c, GuWriter* wtr, GuExn* err);

extern inline void
gu_puts(const char* str, GuWriter* wtr, GuExn* err);

extern inline size_t
gu_utf8_write(const uint8_t* src, size_t sz, GuWriter* wtr, GuExn* err);

