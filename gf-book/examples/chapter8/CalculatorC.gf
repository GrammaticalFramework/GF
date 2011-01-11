concrete CalculatorC of Calculator = open Formal, Prelude in {
lincat 
  Exp = TermPrec ;
lin
  EPlus  = infixl 0 "+" ;
  EMinus = infixl 0 "-" ;
  ETimes = infixl 1 "*" ;
  EDiv   = infixl 1 "/" ;
  EInt i = constant i.s ;
}
