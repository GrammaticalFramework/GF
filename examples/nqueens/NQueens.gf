abstract NQueens = Nat ** {

cat Matrix Nat ;
cat Constr ;
cat Vec (s,l : Nat) Constr ;
cat Sat Nat Nat Constr ;

data nilV  : (s : Nat) -> (c : Constr) -> Vec s zero c ;
     consV : (s,l,j : Nat) -> (c : Constr) -> LT j s -> Sat j (succ zero) c -> Vec s l (consC j c) -> Vec s (succ l) c ;

     nilC  : Constr ;
     consC : (j : Nat) -> Constr -> Constr ;

     nilS : (j,d : Nat) -> Sat j d nilC ;
     consS : (i,j,d : Nat) -> (c : Constr) -> NE i j -> NE i (plus d j) -> NE (plus d i) j -> Sat j (succ d) c -> Sat j d (consC i c) ;

     matrix : (s : Nat) -> Vec s s nilC -> Matrix s ;

}