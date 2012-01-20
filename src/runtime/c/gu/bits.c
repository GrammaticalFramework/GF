#include <gu/bits.h>

#include <limits.h>
#include <inttypes.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

unsigned gu_ceil2e(unsigned u)  
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

GU_DEFINE_TYPE(GuIntDecodeExn, abstract, _);

double 
gu_decode_double(uint64_t u)
{
	bool sign = u >> 63;
	unsigned rawexp = u >> 52 & 0x7ff;
	uint64_t mantissa = u & 0xfffffffffffff;
	double ret;

	if (rawexp == 0x7ff) {
		if (mantissa == 0) {
			ret = INFINITY;
		} else {
			// At least glibc supports specifying the
			// mantissa like this.
			int len = snprintf(NULL, 0, "0x%" PRIx64, mantissa);
			char buf[len + 1];
			snprintf(buf, len + 1, "0x%" PRIx64, mantissa);
			ret = nan(buf);
		}
	} else {
		uint64_t m = rawexp ? 1ULL << 52 | mantissa : mantissa << 1;
		ret = ldexp((double) m, rawexp - 1075);
	}
	return sign ? copysign(ret, -1.0) : ret;
}
