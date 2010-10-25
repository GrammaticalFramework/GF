abstract Hard = {

cat I ;
    F (I -> I) ;
    A (I -> I) I ;
    S ;

fun
  app : (f : I -> I) -> A f (f i) ;
  ex  : F (\x -> x) ;
  i   : I ;
  s   : (f : I -> I) -> A f i -> F f -> S ;

}
