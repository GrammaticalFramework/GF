
abstract SimpleAbs = {

cat 
S; VP; NP; V; N; D; P; PP; 

fun 
-- cyclic  : S -> S;
mkS     : NP -> VP -> S;
mkVP    : V -> NP -> VP;
mkNP1   : D -> N -> NP;
mkNP2   : N -> NP;
mkNP3   : NP -> PP -> NP;
mkPP    : NP -> P -> PP;

robin   : NP;
dog     : N;
child   : N;
love    : V;
hate    : V;
one     : D;
all     : D;
inside  : P;

}


