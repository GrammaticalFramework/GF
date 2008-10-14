abstract Nat = {

cat Nat ;

data 
  Zero : Nat ;
  Succ : Nat -> Nat ;
  
fun one : Nat ;
def one = Succ Zero ;

fun plus : Nat -> Nat -> Nat ;
def plus x Zero = x ;
def plus x (Succ y) = Succ (plus x y) ;

fun twice : Nat -> Nat ;
def twice x = plus x x ;

fun times : Nat -> Nat -> Nat ;
def times x Zero = Zero ;
def times x (Succ y) = plus (times x y) x ;

fun four : Nat ;
def four = twice (twice one) ;

fun exp : Nat -> Nat ;
def exp Zero = one ;
def exp (Succ x) = twice (exp x) ;
}
