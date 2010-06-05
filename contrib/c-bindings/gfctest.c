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

#include <stdio.h>
#include <stdlib.h>
#include "pgf.h"
#include "gf_lexing.h"

int main(int argc, char *argv[])
{
  gf_init(&argc, &argv);

  GF_PGF pgf = gf_readPGF("Query.pgf");
  GF_Language lang = gf_readLanguage("QueryEng");
  GF_Type cat = gf_startCat(pgf);
  char *lexed = gf_stringOp("lextext")("Is 2 prime");
  // char *lexed = "is 23 odd";
  GF_Tree *result = gf_parse(pgf, lang, cat, lexed);
  free(lexed);
  GF_Tree *p = result;
  if (*p) {
    do {
      char *str = gf_showExpr(*(p++));
      puts(str);
      free(str);
    } while (*p);
  } else
    puts("no match");
  gf_freeTrees(result);
  gf_freeType(cat);
  gf_freeLanguage(lang);
  gf_freePGF(pgf);

  gf_exit();
  return 0;
}
