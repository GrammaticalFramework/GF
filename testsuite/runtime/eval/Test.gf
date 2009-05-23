abstract Test = {

fun f : Int -> Int -> Int ;

fun g : Int -> Int ;
def g 1 = 2 ;

fun g2 : Int -> Int -> Int ;
def g2 1 x = x ;

fun g0 : Int -> Int -> Int ;
def g0 = g2 ;

fun const : Int -> Int -> Int ;
def const x _ = x ;

cat Nat ;

data zero : Nat ;
     succ : Nat -> Nat ;
     err  : Nat ;

fun dec : Nat -> Nat ;
def dec zero     = zero ;
    dec (succ n) = n ;
    dec n        = err ; -- for fall through checking

}