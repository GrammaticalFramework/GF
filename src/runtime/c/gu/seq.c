#include <gu/out.h>
#include <gu/seq.h>
#include <gu/fun.h>
#include <gu/assert.h>
#include <string.h>


struct GuBuf {
	uint8_t* data;
	size_t elem_size;
	size_t avail_len;
	GuFinalizer fin;
};

GuBuf*
gu_seq_buf(GuSeq seq)
{
	gu_require(gu_tagged_tag(seq.w_) == 0);
	return gu_word_ptr(seq.w_);
}

GuSeq
gu_buf_seq(GuBuf* buf)
{
	return (GuSeq) { .w_ = gu_ptr_word(buf) };
}

size_t
gu_buf_length(GuBuf* dyn)
{
	return (size_t)(((GuWord*)(void*)dyn)[-1] >> 1);
}

size_t
gu_buf_avail(GuBuf* buf)
{
	return buf->avail_len;
}


static void
gu_buf_set_length(GuBuf* dyn, size_t new_len)
{
	((GuWord*)(void*)dyn)[-1] = ((GuWord) new_len) << 1 | 0x1;
}

static void
gu_buf_fini(GuFinalizer* fin)
{
	GuBuf* buf = gu_container(fin, GuBuf, fin);
	gu_mem_buf_free(buf->data);
}

GuBuf*
gu_make_buf(size_t elem_size, GuPool* pool)
{
	GuBuf* buf = gu_new_prefixed(unsigned, GuBuf, pool);
	gu_buf_set_length(buf, 0);
	buf->elem_size = elem_size;
	buf->data = NULL;
	buf->avail_len = 0;
	buf->fin.fn = gu_buf_fini;
	gu_pool_finally(pool, &buf->fin);
	gu_buf_set_length(buf, 0);
	return buf;
}

static const GuWord gu_empty_seq[2] = {0, 0};

GuSeq
gu_make_seq(size_t elem_size, size_t length, GuPool* pool)
{
	size_t size = elem_size * length;
	if (0 < length && length <= GU_TAG_MAX) {
		void* buf = gu_malloc(pool, size);
		return (GuSeq) { gu_tagged(buf, length) };
	} else if (size == 0) {
		return (GuSeq) { gu_tagged((void*)&gu_empty_seq[1], 0) };
	} else {
		void* buf = gu_malloc_prefixed(pool,
					       gu_alignof(GuWord), 
					       sizeof(GuWord),
					       0, size);
		((GuWord*) buf)[-1] = ((GuWord) length) << 1;
		return (GuSeq) { gu_tagged(buf, 0) };
	}
}

static void
gu_buf_require(GuBuf* buf, size_t req_len)
{
	if (req_len <= buf->avail_len) {
		return;
	}
	size_t req_size = buf->elem_size * req_len;
	size_t real_size;
	buf->data = gu_mem_buf_realloc(buf->data, req_size,
				       &real_size);
	buf->avail_len = real_size / buf->elem_size;
}

void*
gu_buf_data(GuBuf* buf)
{
	return buf->data;
}

void*
gu_buf_extend_n(GuBuf* buf, size_t n_elems)
{
	size_t len = gu_buf_length(buf);
	size_t new_len = len + n_elems;
	gu_buf_require(buf, new_len);
	gu_buf_set_length(buf, new_len);
	return &buf->data[buf->elem_size * len];
}

void*
gu_buf_extend(GuBuf* buf)
{
	return gu_buf_extend_n(buf, 1);
}

void
gu_buf_push_n(GuBuf* buf, const void* data, size_t n_elems)
{
	
	void* p = gu_buf_extend_n(buf, n_elems);
	memcpy(p, data, buf->elem_size * n_elems);
}

const void*
gu_buf_trim_n(GuBuf* buf, size_t n_elems)
{
	gu_require(n_elems <= gu_buf_length(buf));
	size_t new_len = gu_buf_length(buf) - n_elems;
	gu_buf_set_length(buf, new_len);
	return &buf->data[buf->elem_size * new_len];
}

const void*
gu_buf_trim(GuBuf* buf)
{
	return gu_buf_trim_n(buf, 1);
}

void
gu_buf_pop_n(GuBuf* buf, size_t n_elems, void* data_out)
{
	const void* p = gu_buf_trim_n(buf, n_elems);
	memcpy(data_out, p, buf->elem_size * n_elems);
}

GuSeq
gu_buf_freeze(GuBuf* buf, GuPool* pool)
{
	size_t len = gu_buf_length(buf);
	GuSeq seq = gu_make_seq(buf->elem_size, len, pool);
	void* bufdata = gu_buf_data(buf);
	void* seqdata = gu_seq_data(seq);
	memcpy(seqdata, bufdata, buf->elem_size * len);
	return seq;
}

typedef struct GuBufOut GuBufOut;
struct GuBufOut
{
	GuOutStream stream;
	GuBuf* buf;
};

static size_t
gu_buf_out_output(GuOutStream* stream, const uint8_t* src, size_t sz,
		  GuExn* err)
{
	(void) err;
	GuBufOut* bout = gu_container(stream, GuBufOut, stream);
	GuBuf* buf = bout->buf;
	gu_assert(sz % buf->elem_size == 0);
	size_t len = sz / buf->elem_size;
	gu_buf_push_n(bout->buf, src, len);
	return len;
}

static uint8_t*
gu_buf_outbuf_begin(GuOutStream* stream, size_t req, size_t* sz_out, GuExn* err)
{
	(void) req;
	(void) err;
	GuBufOut* bout = gu_container(stream, GuBufOut, stream);
	GuBuf* buf = bout->buf;
	size_t esz = buf->elem_size;
	size_t len = gu_buf_length(buf);
	gu_buf_require(buf, len + (req + esz - 1) / esz);
	size_t avail = buf->avail_len;
	gu_assert(len < avail);
	*sz_out = esz * (avail - len);
	return &buf->data[len * esz];
}

static void
gu_buf_outbuf_end(GuOutStream* stream, size_t sz, GuExn* err)
{
	(void) err;
	GuBufOut* bout = gu_container(stream, GuBufOut, stream);
	GuBuf* buf = bout->buf;
	size_t len = gu_buf_length(buf);
	size_t elem_size = buf->elem_size;
	gu_require(sz % elem_size == 0);
	gu_require(sz < elem_size * (len - buf->avail_len));
	gu_buf_set_length(buf, len + (sz / elem_size));
}

GuOut*
gu_buf_out(GuBuf* buf, GuPool* pool)
{
	GuBufOut* bout = gu_new_i(pool, GuBufOut,
				  .stream.output = gu_buf_out_output,
				  .stream.begin_buf = gu_buf_outbuf_begin,
				  .stream.end_buf = gu_buf_outbuf_end,
				  .buf = buf);
	return gu_new_out(&bout->stream, pool);
}

const GuSeq
gu_null_seq = GU_NULL_SEQ;


#include <gu/type.h>

GU_DEFINE_KIND(GuSeq, GuOpaque);
GU_DEFINE_KIND(GuBuf, abstract);

GU_DEFINE_TYPE(GuChars, GuSeq, gu_type(char));
GU_DEFINE_TYPE(GuBytes, GuSeq, gu_type(uint8_t));

char*
gu_chars_str(GuChars chars, GuPool* pool)
{
	size_t len = gu_seq_length(chars);
	char* data = gu_seq_data(chars);
	char* str = gu_new_str(len, pool);
	memcpy(str, data, len);
	return str;
}
