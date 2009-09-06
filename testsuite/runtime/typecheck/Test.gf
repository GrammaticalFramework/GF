abstract Test = {

cat Nat ;
data zero : Nat ;
     succ : Nat -> Nat ;

fun plus : Nat -> Nat -> Nat ;
def plus zero     n = n ;
    plus (succ m) n = plus m (succ n) ;

cat Vector Nat ;
fun vector : (n : Nat) -> Vector n ;

fun append : (m,n : Nat) -> Vector m -> Vector n -> Vector (plus m n) ;
fun diff   : (m,n : Nat) -> Vector (plus m n) -> Vector m -> Vector n ;

cat Morph (Nat -> Nat) ;
fun mkMorph : (f : Nat -> Nat) -> Morph f ;
fun mkMorph2 : (f : Nat -> Nat) -> Vector (f zero) -> Morph f ;
fun idMorph : Morph (\x -> x) -> Nat ;

fun f0 : (n : Nat)        -> ((m : Nat) -> Vector n)     -> Int ;
fun f1 : (n : Nat -> Nat) -> ((m : Nat) -> Vector (n m)) -> Int ;

fun cmpVector : (n : Nat) -> Vector n -> Vector n -> Int ;

fun g : ((n : Nat) -> Vector n) -> Int ;

cat U (n,m : Nat) ;
fun u0 : (n : Nat) -> U n n ;
fun u1 : (n : Nat) -> U n (succ n) ;
fun h  : (n : Nat) -> U n n -> Int ;

-- fun u2 : (n : Nat) -> U (plus n zero) zero ;
-- fun h2 : (f : Nat -> Nat) -> ((n : Nat) -> U (f n) (f zero)) -> Int ;

}