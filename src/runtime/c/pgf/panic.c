#include "panic.h"
#include <stdio.h>

void __pgf_panic(char *msg) {
  printf("%s\n",msg);
  fflush(stdout);
  exit(1);
}
