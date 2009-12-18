abstract Logic = Symbols ** {

-- flags startcat = Prop ;

cat
  Prop ; Atom ; Ind ; Dom ; Var ; [Prop] {2} ; [Var] {1} ;
fun
  And, Or : [Prop] -> Prop ;
  If, Iff : Prop -> Prop -> Prop ;
  Not : Prop -> Prop ;
  All, Exist : [Var] -> Dom -> Prop -> Prop ;
  PAtom : Atom -> Prop ;
  NAtom : Atom -> Prop ;
  MkVar : String -> Var ;

  PExp : Exp -> Prop ;
  IExp : Exp -> Ind ;

cat
  Pred1 ; Pred2 ;
fun 
  PredPred1 : Pred1 -> Ind -> Atom ; 
  PredPred2 : Pred2 -> Ind -> Ind -> Atom ; 
}
