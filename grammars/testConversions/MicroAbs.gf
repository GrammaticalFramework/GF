
abstract MicroAbs = {

cat S; V; VV; W;

fun 
sv : V -> S;
vars : VV;
ww : W -> W;
svw : V -> W -> S;

supr : V -> V -> S;
supredup : S -> S -> S;
suplbl : V -> S;
reorder : V -> V -> V;
}
