abstract NQueens = Nat ** {

cat S ;
cat Matrix Nat ;
cat [Nat] ;
cat Vec (s,l : Nat) [Nat] ;
cat Sat Nat Nat [Nat] ;

data nqueens : (n : Nat) -> Matrix n -> S ;

data nilV  : ({s} : Nat) -> ({c} : [Nat]) -> Vec s zero c ;
     consV : ({l},j,k : Nat) -> 
                let s = succ (plus j k)
                in ({c} : [Nat]) -> Sat j (succ zero) c -> Vec s l (ConsNat j c) -> Vec s (succ l) c ;

     nilS : ({j,d} : Nat) -> Sat j d BaseNat ;
     consS : ({i,j,d} : Nat) -> ({c} : [Nat]) -> NE i j -> NE i (plus d j) -> NE (plus d i) j -> Sat j (succ d) c -> Sat j d (ConsNat i c) ;

     matrix : ({s} : Nat) -> Vec s s BaseNat -> Matrix s ;

}
