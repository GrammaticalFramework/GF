abstract Nat = {

cat Nat ;

data zero : Nat ;
     succ : Nat -> Nat ;

cat NE (i,j : Nat) ;

data zNE : (i,j : Nat) -> NE i j -> NE (succ i) (succ j) ;
     lNE : (j : Nat) -> NE zero (succ j) ;
     rNE : (j : Nat) -> NE (succ j) zero ;

fun plus : Nat -> Nat -> Nat ;
def plus zero     n = n ;
    plus (succ m) n = succ (plus m n) ;

}