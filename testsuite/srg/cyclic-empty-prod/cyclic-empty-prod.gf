cat S; E; 

fun s : S ;
fun es : E -> S -> S ;
fun e : E ;

lin s  = { s = "s" } ;
lin es e s = { s = e.s ++ s.s } ;
lin e = { s = [] } ;
