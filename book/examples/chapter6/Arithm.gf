abstract Arithm = {
  cat
    Prop ;                        -- proposition
    Nat ;                         -- natural number
  data
    Zero : Nat ;                  -- 0
    Succ : Nat -> Nat ;           -- the successor of x
  fun
    Even : Nat -> Prop ;          -- x is even
    And  : Prop -> Prop -> Prop ; -- A and B

  cat Less Nat Nat ; 
  data LessZ : (y : Nat) -> Less Zero (Succ y) ;
  data LessS : (x,y : Nat) -> Less x y -> Less (Succ x) (Succ y) ;

  cat Span ;
  data FromTo : (m,n : Nat) -> Less m n -> Span ;

  fun one : Nat ;
  def one = Succ Zero ;

  fun twice : Nat -> Nat ;
  def twice x = plus x x ;

  fun plus : Nat -> Nat -> Nat ;
  def 
    plus x Zero = x ;
    plus x (Succ y) = Succ (plus x y) ;

} 
