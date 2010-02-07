abstract lazy = {

cat Nat ;
data zero : Nat ;
     succ : Nat -> Nat ;

fun infinity : Nat ;
def infinity = succ infinity ;

fun min : Nat -> Nat -> Nat ;
def min zero     _        = zero ;
    min _        zero     = zero ;
    min (succ x) (succ y) = succ (min x y) ;

}