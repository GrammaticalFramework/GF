abstract Arithm = Logic ** {

-- arithmetic
fun 
  Nat, Real  : Dom ;
  zero : Elem Nat ;
  succ : Elem Nat -> Elem Nat ;
  
  trunc : Elem Real -> Elem Nat ;

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

  evax1 : Proof (Even zero) ;
  evax2 : (n : Elem Nat) -> Proof (Even n) -> Proof (Odd (succ n)) ;
  evax3 : (n : Elem Nat) -> Proof (Odd n)  -> Proof (Even (succ n)) ;
  eqax1 : Proof (EqNat zero zero) ;
  eqax2 : (m,n : Elem Nat) -> Proof (EqNat m n) -> Proof (EqNat (succ m) (succ n)) ;

  IndNat : (C : Elem Nat -> Prop) -> 
             Proof (C zero) -> 
             ((x : Elem Nat) -> Proof (C x) -> Proof (C (succ x))) -> 
                Proof (Univ Nat C) ;

def 
  one = succ zero ;
  two = succ one ;
  sum m zero = m ;
  sum m (succ n) = succ (sum m n) ;
  prod m zero = zero ;
  prod m (succ n) = sum (prod m n) m ;
  LtNat m n = Exist Nat (\x -> EqNat n (sum m (succ x))) ;
  Div m n = Exist Nat (\x -> EqNat m (prod x n)) ;
  Prime n = Conj 
              (LtNat one n) 
              (Univ Nat (\x -> Impl (Conj (LtNat one x) (Div n x)) (EqNat x n))) ;

fun ex1 : Text ;
def ex1 = 
  ThmWithProof 
    (Univ Nat (\x -> Disj (Even x) (Odd x))) 
    (IndNat 
       (\x -> Disj (Even x) (Odd x)) 
       (DisjIl (Even zero) (Odd zero) evax1) 
       (\x -> \h -> DisjE (Even x) (Odd x) (Disj (Even (succ x)) (Odd (succ x))) 
         (Hypo (Disj (Even x) (Odd x)) h) 
         (\a -> DisjIr (Even (succ x)) (Odd (succ x)) 
            (evax2 x (Hypo (Even x) a))) 
         (\b -> DisjIl (Even (succ x)) (Odd (succ x)) 
            (evax3 x (Hypo (Odd x) b))
         )
       )
     ) ;
} ;
