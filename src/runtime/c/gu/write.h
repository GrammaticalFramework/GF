#ifndef GU_WRITE_H_
#define GU_WRITE_H_

#include <gu/exn.h>
#include <gu/ucs.h>
#include <gu/out.h>
#include <gu/utf8.h>

typedef struct GuWriter GuWriter;

struct GuWriter {
	GuOut out_;
};

size_t
gu_utf32_write(const GuUCS* buf, size_t size, GuWriter* wtr, GuExn* err);

inline void
gu_writer_flush(GuWriter* wtr, GuExn* err)
{
	gu_out_flush(&wtr->out_, err);
}

inline void
gu_ucs_write(GuUCS ucs, GuWriter* wtr, GuExn* err)
{
	gu_out_utf8(ucs, &wtr->out_, err);
}

inline void
gu_putc(char c, GuWriter* wtr, GuExn* err)
{
	GuUCS ucs = gu_char_ucs(c);
	gu_out_u8(&wtr->out_, (uint8_t) ucs, err);
}

inline void
gu_puts(const char* str, GuWriter* wtr, GuExn* err)
{
	gu_str_out_utf8(str, &wtr->out_, err);
}

inline size_t
gu_utf8_write(const uint8_t* src, size_t sz, GuWriter* wtr, GuExn* err)
{
	return gu_out_bytes(&wtr->out_, src, sz, err);
}

void
gu_vprintf(const char* fmt, va_list args, GuWriter* wtr, GuExn* err);

void
gu_printf(GuWriter* wtr, GuExn* err, const char* fmt, ...);

//GuWriter
//gu_init_utf8_writer(GuOut* utf8_out);

GuWriter*
gu_new_utf8_writer(GuOut* utf8_out, GuPool* pool);

GuWriter*
gu_make_locale_writer(GuOut* locale_out, GuPool* pool);

#endif // GU_WRITE_H_
