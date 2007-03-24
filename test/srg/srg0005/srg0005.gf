cat S; X; E; 

fun s : S ;
fun es : E -> S -> S ;
fun sx : S -> X -> S ;
fun x : X ;
fun e : E ;

lin s  = { s = "s" } ;
lin es e s = { s = e.s ++ s.s } ;
lin sx s x = { s = s.s ++ x.s } ;
lin x = { s = "x" } ;
lin e = { s = "e" } ;
