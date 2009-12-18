abstract MathText = Logic ** {

flags startcat = Book ;

cat
  Book ;
  Section ;
  [Section] {1} ;
  Paragraph ;
  [Paragraph] {1} ;
  Statement ;
  Declaration ;
  [Declaration] {0} ;
  Ident ;
  Proof ;
  Case ;
  [Case] {2} ;
  Number ;
 
fun
  MkBook : [Section] -> Book ;
  
  ParAxiom   : Ident -> Statement -> Section ;
  ParTheorem : Ident -> Statement -> Proof -> Section ;

  ParDefInd   : [Declaration] -> Ind -> Ind -> Section ;
  ParDefPred1 : [Declaration] -> Ind -> Pred1 -> Prop -> Section ;
  ParDefPred2 : [Declaration] -> Ind -> Pred2 -> Ind -> Prop -> Section ;

  StProp : [Declaration] -> Prop -> Statement ;

  DecVar  : [Var] -> Dom -> Declaration ;
  DecProp : Prop -> Declaration ;

  PrEnd  : Proof ;
  PrStep : Statement -> Proof -> Proof ;
  PrBy   : Ident -> Prop -> Proof -> Proof ;
  PrCase : Number -> [Case] -> Proof ;
  CProof : Ident -> Proof -> Case ;

  IdStr  : String -> Ident ;

  Two, Three, Four, Five : Number ;

}
