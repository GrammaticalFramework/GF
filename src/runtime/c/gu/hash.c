#include <gu/hash.h>

GU_API GuHash
gu_hash_bytes(GuHash h, const uint8_t* buf, size_t len)
{
	for (size_t n = 0; n < len; n++) {
		h = gu_hash_byte(h, buf[n]);
	}
	return h;
}

static bool
gu_int_eq_fn(GuEquality* self, const void* p1, const void* p2)
{
	(void) self;
	const int* ip1 = p1;
	const int* ip2 = p2;
	return *ip1 == *ip2;
}

static GuHash
gu_int_hash_fn(GuHasher* self, const void* p)
{
	(void) self;
	return (GuHash) *(const int*) p;
}

GU_API GuHasher gu_int_hasher[1] = {
	{
		{ gu_int_eq_fn },
		gu_int_hash_fn
	}
};

static bool
gu_addr_eq_fn(GuEquality* self, const void* p1, const void* p2)
{
	(void) self;
	return (p1 == p2);
}

static GuHash
gu_addr_hash_fn(GuHasher* self, const void* p)
{
	(void) self;
	return (GuHash) (uintptr_t) p;
}

GU_API GuHasher gu_addr_hasher[1] = {
	{
		{ gu_addr_eq_fn },
		gu_addr_hash_fn
	}
};

static bool
gu_word_eq_fn(GuEquality* self, const void* p1, const void* p2)
{
	(void) self;
	const GuWord* wp1 = p1;
	const GuWord* wp2 = p2;
	return (*wp1 == *wp2);
}

static GuHash
gu_word_hash_fn(GuHasher* self, const void* p)
{
	(void) self;
	return (GuHash) (uintptr_t) p;
}

GU_API GuHasher gu_word_hasher[1] = {
	{
		{ gu_word_eq_fn },
		gu_word_hash_fn
	}
};
