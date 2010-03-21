abstract Nat = {

cat Nat ;

data zero : Nat ;
     succ : Nat -> Nat ;

cat NE (i,j : Nat) ;
cat LT (i,j : Nat) ;
cat Plus Nat Nat Nat ;

data zNE : (i,j : Nat) -> NE i j -> NE (succ i) (succ j) ;
     lNE : (j : Nat) -> NE zero (succ j) ;
     rNE : (j : Nat) -> NE (succ j) zero ;

     zLT : (n : Nat) -> LT zero (succ n) ;
     sLT : (m,n : Nat) -> LT m n -> LT (succ m) (succ n) ;

     zP : (n : Nat) -> Plus zero n n ;
     sP : (m,n,s : Nat) -> Plus m n s -> Plus (succ m) n (succ s) ;

}