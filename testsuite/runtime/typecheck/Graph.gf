abstract Graph = {

cat
  Node ;
  Link (n,m : Node) ;
  Path (n,m : Node) ;
  Label ({n} : Node) ;  -- just to debug implicit arguments of categories

fun
  n1,n2,n3,n4,n5 : Node ;
  
  l12 : Link n1 n2 ;
  l23 : Link n2 n3 ;
  l34 : Link n3 n4 ;
  l35 : Link n3 n5 ;
  
  link : ({n,m} : Node) -> Link n m -> Path n m ;
  join : ({n,p,m} : Node) -> Link n p -> Path p m -> Path n m ;
}