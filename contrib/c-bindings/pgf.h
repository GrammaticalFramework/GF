/* GF C Bindings
   Copyright (C) 2008-2009 Kevin Kofler

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, see <http://www.gnu.org/licenses/>.
*/

#include "HsFFI.h"

#ifdef __GLASGOW_HASKELL__
#include "PGFFFI_stub.h"

extern void __stginit_PGFFFI ( void );
#endif

static inline void gf_init(int *argc, char ***argv)
{
  hs_init(argc, argv);
#ifdef __GLASGOW_HASKELL__
  hs_add_root(__stginit_PGFFFI);
#endif
}

static inline void gf_exit(void)
{
  hs_exit();
}

typedef HsStablePtr GF_PGF;
typedef HsStablePtr GF_CId;
typedef HsStablePtr GF_Language;
typedef HsStablePtr GF_Type;
typedef HsStablePtr GF_Tree;
typedef HsStablePtr GF_Expr;

static inline void gf_freeCIds(GF_CId *p)
{
  GF_CId *q = p;
  while (*q)
    gf_freeCId(*(q++));
  free(p);
}

static inline void gf_freeLanguages(GF_Language *p)
{
  GF_Language *q = p;
  while (*q)
    gf_freeLanguage(*(q++));
  free(p);
}

static inline void gf_freeTrees(GF_Tree *p)
{
  GF_Type *q = p;
  while (*q)
    gf_freeTree(*(q++));
  free(p);
}
