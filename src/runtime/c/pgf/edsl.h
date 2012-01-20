#ifndef PGF_EDSL_H_
#define PGF_EDSL_H_

#include <pgf/expr.h>

#define APP(f, a) \
	gu_new_variant_i(PGF_EDSL_POOL, PGF_EXPR_APP, PgfExprApp, f, a)
#define APP2(f, a1, a2) APP(APP(f, a1), a2)
#define APP3(f, a1, a2, a3) APP2(APP(f, a1), a2, a3)

#define VAR(s) \
	gu_new_variant_i(PGF_EDSL_POOL, PGF_EXPR_FUN, PgfExprFun, gu_cstring(#s))

#define APPV(s, a) APP(VAR(s), a)
#define APPV2(s, a1, a2) APP2(VAR(s), a1, a2)
#define APPV3(s, a1, a2, a3) APP3(VAR(s), a1, a2)



#endif // PGF_EDSL_H_
