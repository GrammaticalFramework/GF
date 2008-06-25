int fact (int n) {
  int f ;
  f = 1 ;
  {
  while (1 < n) {
    f = n * f ;
    n = n - 1 ;
  }
  }
  return f ;
} ;

int factr (int n) {
  int f ;
  {
  if (n < 2) {
    f = 1 ;
    }
  else {
    f = n * factr (n-1) ;
  }
  }
  return f ;
} ;

int main () {
  int n ;
  n = 1 ;
  {
    while (n < 11) {
      printf("%d",fact(n)) ;
      printf("%d",factr(n)) ; 
      n = n+1 ;
    }
  }
  return ;
} ;

