-- a grammar with an indirect cycle

cat S; G;

fun f : S ;
fun fg : G -> S ;
fun gf : S -> G ;

lin f  = { s = "f" } ;
lin fg x = x;
lin gf x = x;
