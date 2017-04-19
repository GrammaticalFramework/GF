#include <gu/defs.h>
#include <gu/assert.h>

static const uint32_t gu_prime_wheel_mask = 0UL
	| 1 << 1
	| 1 << 7
	| 1 << 11
	| 1 << 13
	| 1 << 17
	| 1 << 19
	| 1 << 23
	| 1 << 29;

static bool
gu_prime_wheel(int i)
{
	gu_assert(i >= 0 && i < 30);
	return !!(gu_prime_wheel_mask & (1 << i));
}

static const uint32_t gu_small_prime_mask = 0UL
	| 1 << 2
	| 1 << 3 
	| 1 << 5
	| 1 << 7
	| 1 << 11
	| 1 << 13
	| 1 << 17
	| 1 << 19
	| 1 << 23
	| 1 << 29
	| 1U << 31;

static bool
gu_is_wheel_prime(int u)
{
	gu_assert(u > 30 && u % 2 != 0 && u % 3 != 0 && u % 5 != 0);
	int d = 0;
	int i = 7;
	goto start;
	while (d * d <= u) {
		for (i = 1; i <= 29; i+=2) {
		start:
			if (gu_prime_wheel(i) && u % (d + i) == 0) {
				return false;
			}
		}
		d += 30;
	}
	return true;
}

GU_INTERNAL int
gu_prime_inf(int i)
{
	if (i < 2) {
		return 0;
	} else if (i < 32) {
		while (!(gu_small_prime_mask & (1 << i))) {
			i--;
		}
		return i;
	}

	int d = (i - 1) | 1;
	int r = d % 30;

	while (!gu_prime_wheel(r) || !gu_is_wheel_prime(d)) {
		d -= 2;
		r -= 2;
		if (r < 0) {
			r += 30;
		} 
	}
	return d;
}

GU_INTERNAL int
gu_prime_sup(int i)
{
	if (i <= 2) {
		return 2;
	} else if (i < 32) {
		while (!(gu_small_prime_mask & (1 << i))) {
			i++;
		}
		return i;
	}

	int d = i | 1;
	int r = d % 30;

	while (!gu_prime_wheel(r) || !gu_is_wheel_prime(d)) {
		d += 2;
		r += 2;
		if (r > 30) {
			r -= 30;
		}
	}
	return d;
}

GU_INTERNAL bool
gu_is_prime(int i)
{
	if (i < 2) {
		return false;
	} else if (i < 30) {
		return !!(gu_small_prime_mask & (1 << i));
	} else if (!gu_prime_wheel(i % 30)) {
		return false;
	} else {
		return gu_is_wheel_prime(i);
	}
}

GU_INTERNAL bool
gu_is_twin_prime(int i)
{
	return gu_is_prime(i) && gu_is_prime(i - 2);
}

GU_INTERNAL int
gu_twin_prime_inf(int i)
{
	while (true) {
		i = gu_prime_inf(i);
		if (i == 0) {
			return 0;
		} else if (gu_is_prime(i - 2)) {
			return i;
		}
		i = i - 4;
	}
	return i;
}

GU_INTERNAL int
gu_twin_prime_sup(int i)
{
	if (i <= 5) {
		return 5;
	}
	i = i - 2;
	while (true) {
		i = gu_prime_sup(i);
		if (gu_is_prime(i + 2)) {
			return i + 2;
		}
		i = i + 4;
	}
	return i;
}

