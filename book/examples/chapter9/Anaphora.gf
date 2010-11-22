abstract Anaphora = TestSemantics - [she_NP] ** {

cat
  Proof Prop ;

fun
  IfS : (A : S) -> (Proof (iS A) -> S) -> S ;

  AnaNP : (A : CN) -> (a : Ind) -> Proof (iCN A a) -> NP ;

  pe : (B : Ind -> Prop) -> Proof (Exist B) -> Ind ;
  qe : (B : Ind -> Prop) -> (c : Proof (Exist B)) -> Proof (B (pe B c)) ;

  pc : (A,B : Prop) -> Proof (And A B) -> Proof A ;
  qc : (A,B : Prop) -> Proof (And A B) -> Proof B ;

}
