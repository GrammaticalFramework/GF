#include <gu/out.h>
#include <gu/seq.h>
#include <gu/fun.h>
#include <gu/assert.h>
#include <stdlib.h>
#if defined(__MINGW32__) || defined(_MSC_VER)
#include <malloc.h>
#endif

static void
gu_buf_fini(GuFinalizer* fin)
{
	GuBuf* buf = gu_container(fin, GuBuf, fin);
	if (buf->avail_len > 0)
		gu_mem_buf_free(buf->seq);
}

GuBuf*
gu_make_buf(size_t elem_size, GuPool* pool)
{
	GuBuf* buf = gu_new(GuBuf, pool);
	buf->seq = gu_empty_seq();
	buf->elem_size = elem_size;
	buf->avail_len = 0;
	buf->fin.fn = gu_buf_fini;
	gu_pool_finally(pool, &buf->fin);
	return buf;
}

extern size_t
gu_buf_length(GuBuf* buf);

extern size_t
gu_buf_avail(GuBuf* buf);

extern void*
gu_buf_data(GuBuf* buf);

extern GuSeq*
gu_buf_data_seq(GuBuf* buf);

extern void*
gu_buf_extend(GuBuf* buf);

extern const void*
gu_buf_trim(GuBuf* buf);

extern void
gu_buf_flush(GuBuf* buf);

static GuSeq gu_empty_seq_ = {0};

GuSeq*
gu_empty_seq() {
	return &gu_empty_seq_;
}

GuSeq*
gu_make_seq(size_t elem_size, size_t length, GuPool* pool)
{
	GuSeq* seq = gu_malloc(pool, sizeof(GuSeq) + elem_size * length);
	seq->len = length;
	return seq;
}

extern size_t
gu_seq_length(GuSeq* seq);

extern void*
gu_seq_data(GuSeq* seq);

GuSeq*
gu_alloc_seq_(size_t elem_size, size_t length)
{
	if (length == 0)
		return gu_empty_seq();

	size_t real_size;
	GuSeq* seq = gu_mem_buf_alloc(sizeof(GuSeq) + elem_size * length, &real_size);
	seq->len = (real_size - sizeof(GuSeq)) / elem_size;
	return seq;
}

GuSeq*
gu_realloc_seq_(GuSeq* seq, size_t elem_size, size_t length)
{
	size_t real_size;
	GuSeq* new_seq = (seq == NULL || seq == gu_empty_seq()) ?
	   gu_mem_buf_alloc(sizeof(GuSeq) + elem_size * length, &real_size) :
	   gu_mem_buf_realloc(seq, sizeof(GuSeq) + elem_size * length, &real_size);
	new_seq->len = (real_size - sizeof(GuSeq)) / elem_size;
	return new_seq;
}

void
gu_seq_free(GuSeq* seq)
{
	if (seq == NULL || seq == gu_empty_seq())
		return;
	gu_mem_buf_free(seq);
}

void
gu_buf_require(GuBuf* buf, size_t req_len)
{
	if (req_len <= buf->avail_len) {
		return;
	}

	size_t req_size = sizeof(GuSeq) + buf->elem_size * req_len;
	size_t real_size;
	
	if (buf->seq == NULL || buf->seq == gu_empty_seq())  {
		buf->seq = gu_mem_buf_alloc(req_size, &real_size);
		buf->seq->len = 0;
	} else {
		buf->seq = gu_mem_buf_realloc(buf->seq, req_size, &real_size);
	}

	buf->avail_len = (real_size - sizeof(GuSeq)) / buf->elem_size;
}

void*
gu_buf_extend_n(GuBuf* buf, size_t n_elems)
{
	size_t len = gu_buf_length(buf);
	size_t new_len = len + n_elems;
	gu_buf_require(buf, new_len);
	buf->seq->len = new_len;
	return &buf->seq->data[buf->elem_size * len];
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
	buf->seq->len = new_len;
	return &buf->seq->data[buf->elem_size * new_len];
}

void
gu_buf_pop_n(GuBuf* buf, size_t n_elems, void* data_out)
{
	const void* p = gu_buf_trim_n(buf, n_elems);
	memcpy(data_out, p, buf->elem_size * n_elems);
}

GuSeq*
gu_buf_freeze(GuBuf* buf, GuPool* pool)
{
	size_t len = gu_buf_length(buf);
	GuSeq* seq = gu_make_seq(buf->elem_size, len, pool);
	void* bufdata = gu_buf_data(buf);
	void* seqdata = gu_seq_data(seq);
	memcpy(seqdata, bufdata, buf->elem_size * len);
	return seq;
}

void*
gu_buf_insert(GuBuf* buf, size_t index)
{
	size_t len = buf->seq->len;
	gu_buf_require(buf, len + 1);

	uint8_t* target =
		buf->seq->data + buf->elem_size * index;
	memmove(target+buf->elem_size, target, (len-index)*buf->elem_size);

	buf->seq->len++;
	return target;
}

static void
gu_quick_sort(GuBuf *buf, GuOrder *order, int left, int right)
{
	int l_hold = left;
	int r_hold = right;

	void* pivot = alloca(buf->elem_size);
	memcpy(pivot,
	       &buf->seq->data[buf->elem_size * left],
	       buf->elem_size);
	while (left < right) {

		while ((order->compare(order, &buf->seq->data[buf->elem_size * right], pivot) >= 0) && (left < right))
			right--;

		if (left != right) {
			memcpy(&buf->seq->data[buf->elem_size * left],
			       &buf->seq->data[buf->elem_size * right],
			       buf->elem_size);
			left++;
		}

		while ((order->compare(order, &buf->seq->data[buf->elem_size * left], pivot) <= 0) && (left < right))
			left++;

		if (left != right) {
			memcpy(&buf->seq->data[buf->elem_size * right],
			       &buf->seq->data[buf->elem_size * left],
			       buf->elem_size);
			right--;
		}
	}
	
	memcpy(&buf->seq->data[buf->elem_size * left],
	       pivot,
           buf->elem_size);
	int index = left;
	left  = l_hold;
	right = r_hold;

	if (left < index)
		gu_quick_sort(buf, order, left, index-1);

	if (right > index)
		gu_quick_sort(buf, order, index+1, right);
}

void
gu_buf_sort(GuBuf *buf, GuOrder *order)
{
	gu_quick_sort(buf, order, 0, gu_buf_length(buf) - 1);
}

void*
gu_seq_binsearch_(GuSeq *seq, GuOrder *order, size_t elem_size, const void *key)
{
	int i = 0;
	int j = seq->len-1;
	
	while (i <= j) {
		int k = (i+j) / 2;
		uint8_t* elem_p = &seq->data[elem_size * k];
		int cmp = order->compare(order, key, elem_p);

		if (cmp < 0) {
			j = k-1;
		} else if (cmp > 0) {
			i = k+1;
		} else {
			return elem_p;
		}
	}

	return NULL;
}

bool
gu_seq_binsearch_index_(GuSeq *seq, GuOrder *order, size_t elem_size,
                        const void *key, size_t *pindex)
{
	size_t i = 0;
	size_t j = seq->len-1;
	
	while (i <= j) {
		size_t k = (i+j) / 2;
		uint8_t* elem_p = &seq->data[elem_size * k];
		int cmp = order->compare(order, key, elem_p);
	
		if (cmp < 0) {
			j = k-1;
		} else if (cmp > 0) {
			i = k+1;
		} else {
			*pindex = k;
			return true;
		}
	}

	*pindex = j;
	return false;
}

static void
gu_heap_siftdown(GuBuf *buf, GuOrder *order, 
                 const void *value, int startpos, int pos)
{
	while (pos > startpos) {
		int parentpos = (pos - 1) >> 1;
        void *parent = &buf->seq->data[buf->elem_size * parentpos];
        
		if (order->compare(order, value, parent) >= 0)
			break;

		memcpy(&buf->seq->data[buf->elem_size * pos], parent, buf->elem_size);
		pos = parentpos;
	}

	memcpy(&buf->seq->data[buf->elem_size * pos], value, buf->elem_size);
}

static void
gu_heap_siftup(GuBuf *buf, GuOrder *order,
               const void *value, int pos)
{
	int startpos = pos;
	int endpos = gu_buf_length(buf);

	int childpos = 2*pos + 1;
	while (childpos < endpos) {
		int rightpos = childpos + 1;
		if (rightpos < endpos &&
		    order->compare(order, 
			               &buf->seq->data[buf->elem_size * childpos],
			               &buf->seq->data[buf->elem_size * rightpos]) >= 0) {
			childpos = rightpos;
		}

		memcpy(&buf->seq->data[buf->elem_size * pos], 
		       &buf->seq->data[buf->elem_size * childpos], buf->elem_size);
		pos = childpos;
		childpos = 2*pos + 1;
   }
   
   gu_heap_siftdown(buf, order, value, startpos, pos);
}

void
gu_buf_heap_push(GuBuf *buf, GuOrder *order, void *value)
{
	gu_buf_extend(buf);
	gu_heap_siftdown(buf, order, value, 0, gu_buf_length(buf)-1);
}

void
gu_buf_heap_pop(GuBuf *buf, GuOrder *order, void* data_out)
{
	const void* last = gu_buf_trim(buf); // raises an error if empty

	if (gu_buf_length(buf) > 0) {
		memcpy(data_out, buf->seq->data, buf->elem_size);
		gu_heap_siftup(buf, order, last, 0);
	} else {
		memcpy(data_out, last, buf->elem_size);
	}
}

void
gu_buf_heap_replace(GuBuf *buf, GuOrder *order, void *value, void *data_out)
{
	gu_require(gu_buf_length(buf) > 0);

	memcpy(data_out, buf->seq->data, buf->elem_size);
	gu_heap_siftup(buf, order, value, 0);
}

void
gu_buf_heapify(GuBuf *buf, GuOrder *order)
{
	size_t middle = gu_buf_length(buf) / 2;
	void *value = alloca(buf->elem_size);
	
	for (size_t i = 0; i < middle; i++) {
		memcpy(value, &buf->seq->data[buf->elem_size * i], buf->elem_size);
		gu_heap_siftup(buf, order, value, i);
	}
}
