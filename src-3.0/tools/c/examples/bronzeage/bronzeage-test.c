#include "Bronzeage.h"

#include "BronzeageEng.h"

#include <unistd.h>

int main() {
  Tree *tree = 
	  mk_PhrPos(
	    mk_SentV(
	      mk_lie_V(),
	      mk_NumCN(
	        mk_two_Num(),
	        mk_UseN(mk_wife_N())
	      )
            )
	  );

  int i;

  for (i = 0; i < 1000; i++) {
	  Term *term;
	  term = BronzeageEng_lin(tree);
	  term_print(stdout, term);
	  fputs("\n", stdout);
  }

  tree_free(tree);

  return 0;
}
