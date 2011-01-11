abstract Nat = {
  cat
    Prop ;                        -- proposition
    Nat ;                         -- natural number
  data
    Zero : Nat ;                  -- 0
    Succ : Nat -> Nat ;           -- the successor of x
  fun
    Even : Nat -> Prop ;          -- x is even
    And  : Prop -> Prop -> Prop ; -- A and B

  fun one : Nat ;
  def one = Succ Zero ;

  fun twice : Nat -> Nat ;
  def twice x = plus x x ;

  fun plus : Nat -> Nat -> Nat ;
  def 
    plus x Zero = x ;
    plus x (Succ y) = Succ (plus x y) ;
}
