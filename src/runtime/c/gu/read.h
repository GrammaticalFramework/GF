#ifndef GU_READ_H_
#define GU_READ_H_

#include <gu/in.h>
#include <gu/ucs.h>
#include <gu/utf8.h>

typedef struct GuReader GuReader;

struct GuReader {
	GuIn in_;
};

inline GuUCS
gu_read_ucs(GuReader* rdr, GuExn* err)
{
	return gu_in_utf8(&rdr->in_, err);
}

inline char
gu_getc(GuReader* rdr, GuExn* err)
{
	return gu_in_utf8_char(&rdr->in_, err);
}

GuReader*
gu_new_utf8_reader(GuIn* utf8_in, GuPool* pool);
/**< @todo Implement. */
   

#endif // GU_READ_H_
