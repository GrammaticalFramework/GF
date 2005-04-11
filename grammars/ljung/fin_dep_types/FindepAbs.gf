
abstract FindepAbs = {

cat 
Num; Gen; Def; 
S; V; VP; 
D Num Gen Def; N Num Gen Def; NP Num Gen Def; 

fun 

Sg, Pl : Num;
Best, OBest : Def;
Utr, Neu : Gen;


s  : (n:Num) -> (g:Gen) -> (b:Def) -> NP n g b -> VP -> S;
np : (n:Num) -> (g:Gen) -> (b:Def) -> D n g b -> N n g b -> NP n g b;
vp : (n:Num) -> (g:Gen) -> (b:Def) -> V -> NP n g b -> VP;

npBest : (n:Num) -> (g:Gen)  -> N n g Best -> NP n g Best;
npPl   : (g:Gen) -> (b:Def) -> N Pl g b   -> NP Pl g b;

en  : D Sg Utr OBest;
ett : D Sg Neu OBest;
den : D Sg Utr Best;
det : D Sg Neu OBest;

alla : (g:Gen) -> D Pl g OBest;
de   : (g:Gen) -> D Pl g Best;

katt   : N Sg Utr OBest;
katten : N Sg Utr Best;
katter : N Pl Utr OBest;
katterna : N Pl Utr Best;

barn   : (n:Num) -> N n Neu OBest;
barnet : N Sg Neu Best;
barnen : N Pl Neu Best;

jagar : V;

}

