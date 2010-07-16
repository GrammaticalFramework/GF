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
#include "pygf.h"
//#include "gf_lexing.h"

PyGF pgf, lang, cat;

int main(int argc, char *argv[])
{
  int has_lang;
  gf_init(&argc, &argv);
  printf("Passed init\n");
  gf_readPGF(&pgf, "Query.pgf");
  printf("passed readPGF\n");
  if (!gf_readLanguage(&lang, "QueryEng"))
    return 1; 
  printf("passed readLanguage: %s\n", gf_showLanguage(&lang));
  gf_startCat(&pgf, &cat);
  printf("passed startcat: %s\n", gf_showType(&cat));
  // char *lexed = gf_stringOp("lextext")("Is 2 prime");
  char lexed[] = "is 23 odd";
  PyGF *result = gf_parse(&pgf, &lang, &cat, &lexed);
  int k;
  for (k = 0; result[k].sp ; k++) {
    char *str = gf_showExpr(&result[k]);
    puts(str);
    free(str);
    printf("next: 0x%x\n",result[k+1].sp);
  }
  /*  // free(lexed);
  PyGF *p = result;
  if (result[0]) {
    int k = 0;
    do {
      printf("tree %d\n",++k);
      char *str = gf_showExpr(*(p++));
      puts(str);
      free(str);
    } while (*p && k < 5);
  } else
    puts("no match");
    gf_freeTrees(result); */
  gf_freeType(&cat);
  gf_freeLanguage(&lang);
  gf_freePGF(&pgf);
  gf_exit();
  return 0;
}
