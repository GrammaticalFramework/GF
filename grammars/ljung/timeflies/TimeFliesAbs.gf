
abstract TimeFliesAbs = {

cat
S; VP; NP; PP; V; N; D; P; 

fun 
s1 : NP -> VP -> S;
vp1 : V -> VP;
vp2 : V -> NP -> VP;
vp3 : VP -> PP -> VP;
np1 : N -> NP;
np2 : D -> N -> NP;
np3 : NP -> PP -> NP;
pp1 : P -> NP -> PP;

flyV : V;
timeV : V;
likeV : V;
flyN : N;
timeN : N;
arrowN : N;
anD : D;
timeD : D;
likeP : P;
}

