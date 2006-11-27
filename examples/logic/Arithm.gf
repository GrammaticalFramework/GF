abstract Arithm = Logic ** {

-- arithmetic
fun 
  Nat  : Dom ;
data
  Zero : Elem Nat ;
  Succ : Elem Nat -> Elem Nat ;
fun
  EqNat : (m,n : Elem Nat) -> Prop ;
  LtNat : (m,n : Elem Nat) -> Prop ;
  Div   : (m,n : Elem Nat) -> Prop ;
  Even  : Elem Nat -> Prop ;
  Odd   : Elem Nat -> Prop ;
  Prime : Elem Nat -> Prop ;

  one  : Elem Nat ;
  two  : Elem Nat ;
  sum  : (m,n : Elem Nat) -> Elem Nat ;
  prod : (m,n : Elem Nat) -> Elem Nat ;
data
  evax1 : Proof (Even Zero) ;
  evax2 : (n : Elem Nat) -> Proof (Even n) -> Proof (Odd (Succ n)) ;
  evax3 : (n : Elem Nat) -> Proof (Odd n)  -> Proof (Even (Succ n)) ;

  eqax1 : Proof (EqNat Zero Zero) ;
  eqax2 : (m,n : Elem Nat) -> Proof (EqNat m n) -> 
             Proof (EqNat (Succ m) (Succ n)) ;
fun
  IndNat : (C : Elem Nat -> Prop) -> 
             Proof (C Zero) -> 
             ((x : Elem Nat) -> Hypo (C x) -> Proof (C (Succ x))) -> 
                Proof (Univ Nat C) ;

def 
  one = Succ Zero ;
  two = Succ one ;
  sum m (Succ n) = Succ (sum m n) ;
  sum m Zero = m ;
  prod m (Succ n) = sum (prod m n) m ;
  prod m Zero = Zero ;
  LtNat m n = Exist Nat (\x -> EqNat n (sum m (Succ x))) ;
  Div m n = Exist Nat (\x -> EqNat m (prod x n)) ;
  Prime n = 
    Conj (LtNat one n) 
           (Univ Nat (\x -> Impl (Conj (LtNat one x) (Div n x)) (EqNat x n))) ;

fun ex1 : Text ;
def ex1 = 
  ThmWithProof 
    (Univ Nat (\x -> Disj (Even x) (Odd x))) 
    (IndNat 
       (\x -> Disj (Even x) (Odd x)) 
       (DisjIl (Even Zero) (Odd Zero) evax1) 
       (\x -> \h -> DisjE (Even x) (Odd x) (Disj (Even (Succ x)) (Odd (Succ x)))
         (Hypoth (Disj (Even x) (Odd x)) h) 
         (\a -> DisjIr (Even (Succ x)) (Odd (Succ x)) 
            (evax2 x (Hypoth (Even x) a))) 
         (\b -> DisjIl (Even (Succ x)) (Odd (Succ x)) 
            (evax3 x (Hypoth (Odd x) b))
         )
       )
     ) ;
} ;
