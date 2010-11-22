abstract Logic = {
cat
  Prop ; Ind ; Dom ; Var ; [Prop] {2} ; [Var] {1} ;
fun
  And, Or : [Prop] -> Prop ;
  If : Prop -> Prop -> Prop ;
  Not : Prop -> Prop ;
  All, Exist : [Var] -> Dom -> Prop -> Prop ;
  IVar : Var -> Ind ;
  VString : String -> Var ;
}
