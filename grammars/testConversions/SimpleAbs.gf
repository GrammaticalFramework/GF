
abstract SimpleAbs = {

cat 
S; VP; NP; V; N; D; 

fun 
cyclic  : S -> S;
mkS     : NP -> V -> S;
mkVP    : V -> NP -> VP;
mkNP1   : D -> N -> NP;
mkNP2   : N -> NP;

robin   : NP;
dog     : N;
child   : N;
love    : V;
hate    : V;
one     : D;
all     : D;

}


