abstract Math = {

flags startcat = Section ;

cat 
  Section ; Label ; Context ; Typ ; Obj ; Prop ; Proof ; Var ;

fun
  SDefObj  : Label -> Context -> Obj  -> Typ -> Obj  -> Section ;
  SDefProp : Label -> Context -> Prop -> Prop -> Section ;
  SAxiom   : Label -> Context -> Prop -> Section ;
  STheorem : Label -> Context -> Prop -> Proof -> Section ;

  CEmpty : Context ;
  CObj   : Var -> Typ -> Context -> Context ;
  CProp  : Prop -> Context -> Context ;

  OVar : Var -> Obj ;

  LNone : Label ;
  LString : String -> Label ;
  VString : String -> Var ;

  PLink : Proof ;

-- lexicon

  Set  : Typ ;
  Nat  : Typ ;
  Zero : Obj ;
  Succ : Obj -> Obj ;
  One  : Obj ;
  Two  : Obj ;
  Even : Obj -> Prop ;
  Odd  : Obj -> Prop ;
  Prime : Obj -> Prop ;
  Divisible : Obj -> Obj -> Prop ;
  
}
