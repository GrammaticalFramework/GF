#ifndef GU_SEQ_H_
#define GU_SEQ_H_

#include <gu/mem.h>
#include <gu/bits.h>


typedef struct GuBuf GuBuf;

typedef GuOpaque() GuSeq;

GuSeq
gu_make_seq(size_t elem_size, size_t len, GuPool* pool);

#define gu_new_seq(T, N, POOL)			\
	gu_make_seq(sizeof(T), (N), (POOL))

static inline size_t
gu_seq_length(GuSeq seq)
{
	GuWord w = seq.w_;
	size_t tag = gu_tagged_tag(w);
	if (tag == 0) {
		GuWord* p = gu_tagged_ptr(w);
		return (size_t) (p[-1] >> 1);
	}
	return tag;
}

static inline void*
gu_seq_data(GuSeq seq)
{
	GuWord w = seq.w_;
	int tag = gu_tagged_tag(w);
	void* ptr = gu_tagged_ptr(w);
	if (tag == 0) {
		GuWord* p = ptr;
		if (p[-1] & 0x1) {
		 	return *(uint8_t**) ptr;
		}
	}
	return ptr;
}

static inline bool
gu_seq_is_null(GuSeq seq)
{
	return (gu_tagged_ptr(seq.w_)) == NULL;
}


#define gu_seq_index(SEQ, T, I)			\
	(&((T*)gu_seq_data(SEQ))[I])

#define gu_seq_get(SEQ, T, I)			\
	(*gu_seq_index(SEQ, T, I))

#define gu_seq_set(SEQ, T, I, V)			\
	GU_BEGIN				\
	(*gu_seq_index(SEQ, T, I) = (V));	\
	GU_END




GuBuf*
gu_seq_buf(GuSeq seq);

GuSeq
gu_buf_seq(GuBuf* buf);

GuBuf*
gu_make_buf(size_t elem_size, GuPool* pool);

#define gu_new_buf(T, POOL)			\
	gu_make_buf(sizeof(T), (POOL))

size_t
gu_buf_length(GuBuf* buf);

size_t
gu_buf_avail(GuBuf* buf);

void*
gu_buf_data(GuBuf* buf);

#define gu_buf_index(BUF, T, I)			\
	(&((T*)gu_buf_data(BUF))[I])

#define gu_buf_get(BUF, T, I)			\
	(*gu_buf_index(BUF, T, I))

#define gu_buf_set(BUF, T, I)			\
	GU_BEGIN				\
	(*gu_buf_index(BUF, T, I) = (V));	\
	GU_END

void
gu_buf_push_n(GuBuf* buf, const void* elems, size_t n_elems);

void*
gu_buf_extend_n(GuBuf* buf, size_t n_elems);

void*
gu_buf_extend(GuBuf* buf);

#define gu_buf_push(BUF, T, VAL)				\
	GU_BEGIN						\
	((*(T*)gu_buf_extend(BUF)) = (VAL));	\
	GU_END

void
gu_buf_pop_n(GuBuf* buf, size_t n_elems, void* data_out);

const void*
gu_buf_trim_n(GuBuf* buf, size_t n_elems);

const void*
gu_buf_trim(GuBuf* buf);

#define gu_buf_pop(BUF, T)			\
	(*(T*)gu_buf_trim(BUF))

void
gu_seq_resize_tail(GuSeq seq, ptrdiff_t change);

#if 0
void
gu_buf_resize_head(GuBuf* buf, ptrdiff_t change);

void
gu_buf_unshift(GuBuf* buf, const void* data, size_t size);

void
gu_buf_shift(GuBuf* buf, size_t size, void* data_out);
#endif

GuSeq
gu_buf_freeze(GuBuf* buf, GuPool* pool);

extern const GuSeq gu_null_seq;

#define GU_NULL_SEQ { .w_ = (GuWord)(void*)NULL }

typedef GuSeq GuChars;
typedef GuSeq GuBytes;
typedef GuBuf GuCharBuf;
typedef GuBuf GuByteBuf;

char*
gu_chars_str(GuChars chars, GuPool* pool);

#endif // GU_SEQ_H_

#if defined(GU_OUT_H_) && !defined(GU_SEQ_H_OUT_)
#define GU_SEQ_H_OUT_

GuOut*
gu_buf_out(GuBuf* buf, GuPool* pool);

#endif


#if defined(GU_TYPE_H_) && !defined(GU_SEQ_H_TYPE_)
#define GU_SEQ_H_TYPE_

extern GU_DECLARE_KIND(GuSeq);
extern GU_DECLARE_KIND(GuBuf);

struct GuSeqType {
	GuType_GuOpaque opaque_base;
	GuType* elem_type;
};

typedef const struct GuSeqType GuSeqType, GuType_GuSeq;

#define GU_TYPE_INIT_GuSeq(k_, t_, elem_type_) {	   \
	.opaque_base = GU_TYPE_INIT_GuOpaque(k_, t_, _), \
	.elem_type = elem_type_,		   	\
}

typedef struct GuBufType GuBufType, GuType_GuBuf;

struct GuBufType {
	GuType_abstract abstract_base;
	GuType* elem_type;
};

#define GU_TYPE_INIT_GuBuf(KIND, BUF_T, ELEM_T) { \
	.abstract_base = GU_TYPE_INIT_abstract(KIND, BUF_T, _), \
	.elem_type = ELEM_T \
}

extern GU_DECLARE_TYPE(GuChars, GuSeq);
extern GU_DECLARE_TYPE(GuBytes, GuSeq);

#endif 

