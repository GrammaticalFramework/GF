-- A grammar with a cycle caused by an empty category.
cat S; E;

fun f : E -> S -> S;
fun g : S ;
fun e : E ;

lin f e s = { s = e.s ++ s.s } ;
lin g = { s = "s" } ;
lin e = { s = [] } ;