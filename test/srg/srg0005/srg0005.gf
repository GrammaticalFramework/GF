cat S; E; 

fun f : E -> S ;
fun g : S -> S ;
fun e : E ;

lin f e = { s = e.s } ;
lin g s = { s = s.s ++ "x" } ;
lin e = { s = "e" } ;
