abstract Nat = {

cat Nat ;
data zero : Nat ;
     succ : Nat -> Nat ;
     
oper plus : Nat -> Nat -> Nat ;
def  plus zero     y = y ;
     plus (succ x) y = succ (plus x y) ;

oper twice : Nat -> Nat = \x -> plus x x ;

}
