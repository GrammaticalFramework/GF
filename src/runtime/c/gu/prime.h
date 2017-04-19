#ifndef GU_PRIME_H_
#define GU_PRIME_H_

#include <gu/defs.h>

GU_INTERNAL_DECL bool gu_is_prime(int i);

GU_INTERNAL_DECL bool gu_is_twin_prime(int i);

GU_INTERNAL_DECL int gu_prime_inf(int i);
GU_INTERNAL_DECL int gu_twin_prime_inf(int i);

GU_INTERNAL_DECL int gu_prime_sup(int i);
GU_INTERNAL_DECL int gu_twin_prime_sup(int i);

#endif // GU_PRIME_H_
