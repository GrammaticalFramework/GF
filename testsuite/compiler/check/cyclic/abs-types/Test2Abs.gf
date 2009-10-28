abstract Test2Abs = {

cat
  A ;
  B A ;

fun f : (x : A) -> B (g x) ;
    g : (x : A) -> B (f x) ;

}