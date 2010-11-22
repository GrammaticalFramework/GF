abstract Logic = {
flags startcat = Stm ;
cat
  Stm ;        -- top-level statement 
  Prop ;       -- proposition 
  Atom ;       -- atomic formula
  Ind ;        -- individual term 
  Dom ;        -- domain expression
  Var ;        -- variable
  [Prop] {2} ; -- list of propositions, 2 or more
  [Var] {1} ;  -- list of variables, 1 or more
fun
  SProp : Prop -> Stm ;
  And, Or : [Prop] -> Prop ;
  If  : Prop -> Prop -> Prop ;
  Not : Prop -> Prop ;
  PAtom : Atom -> Prop ;
  All, Exist : [Var] -> Dom -> Prop -> Prop ;
  IVar : Var -> Ind ;
  VString : String -> Var ;
}
