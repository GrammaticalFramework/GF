#include <gu/bits.h>

#include <limits.h>
#include <inttypes.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

GU_INTERNAL unsigned
gu_ceil2e(unsigned u)  
{
	u--;
	u |= u >> 1;
	u |= u >> 2;
	u |= u >> 4;
	u |= u >> 8;
#if UINT_MAX > UINT16_MAX
	u |= u >> 16;
#endif
#if UINT_MAX > UINT32_MAX
	u |= u >> 32;
#endif
	u++;
	return u;
}

GU_INTERNAL double
gu_decode_double(uint64_t u)
{
	bool sign = u >> 63;
	unsigned rawexp = u >> 52 & 0x7ff;
	uint64_t mantissa = u & 0xfffffffffffff;
	double ret;

	if (rawexp == 0x7ff) {
		ret = (mantissa == 0) ? INFINITY : NAN;
	} else {
		uint64_t m = rawexp ? 1ULL << 52 | mantissa : mantissa << 1;
		ret = ldexp((double) m, rawexp - 1075);
	}
	return sign ? copysign(ret, -1.0) : ret;
}
