int mx () {
  return 5000000 ;
} ;

int main () {
  int lo ; int hi ;
  lo = 1 ;
  hi = lo ;
  printf("%d",lo) ;
  {
    while (hi < mx()) {
      printf("%d",hi) ;
      hi = lo + hi ;
      lo = hi - lo ;
      }
  }
  return ;
} ;
