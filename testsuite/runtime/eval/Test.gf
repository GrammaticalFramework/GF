abstract Test = {

fun f : Int -> Int -> Int ;

fun g : Int -> Int ;
def g 1 = 2 ;

fun g2 : Int -> Int -> Int ;
def g2 1 x = x ;

fun g0 : Int -> Int -> Int ;
def g0 = g2 ;

fun g3 : Int -> (Int -> Int) ;
def g3 3 = g ;

fun const : Float -> String -> Float ;
def const x _ = x ;

cat Nat ;

data zero : Nat ;
     succ : Nat -> Nat ;
     err  : Nat ;

fun dec : Nat -> Nat ;
def dec zero     = zero ;
    dec (succ n) = n ;
    dec n        = err ; -- for fall through checking

fun plus : Nat -> Nat -> Nat ;
def plus err zero     = err ;
    plus m   err      = err ;
    plus m   zero     = m ;
    plus m   (succ n) = plus (succ m) n ;

fun dec2 : Int -> Nat -> Nat ;
def dec2 0 zero     = err ;
    dec2 _ (succ n) = n ;

}