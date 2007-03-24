cat S; E; 

fun es : E -> S ;
fun sx : S -> S ;
fun e : E ;

lin es e = { s = e.s } ;
lin sx s = { s = s.s ++ "x" } ;
lin e = { s = "e" } ;
