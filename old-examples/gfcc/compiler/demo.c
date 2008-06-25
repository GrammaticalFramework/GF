int fact (int n) {
  int f ;
  f = 1 ;
  while (1 < n) {
    f = n * f ;
    n = n - 1 ;
  }
  return f ;
} ;
