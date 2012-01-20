#include <gu/read.h>

extern inline GuUCS
gu_read_ucs(GuReader* rdr, GuExn* err);

extern inline char
gu_getc(GuReader* rdr, GuExn* err);

GuReader*
gu_new_utf8_reader(GuIn* utf8_in, GuPool* pool)
{
	GuReader* rdr = gu_new(GuReader, pool);
	rdr->in_ = gu_init_in(gu_in_proxy_stream(utf8_in, pool));
	return rdr;
}
