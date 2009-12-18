concrete SymbolsX of Symbols = open Formal in {

lincat 
  Exp = TermPrec ; 

lin 
--  EInt i = constant i.s ;
  EVar x = constant x.s ;
  EIn = infixn 0 "\\in" ;
  EPlus = infixl 2 "+" ;
  ETimes = infixl 3 "*" ;
  EEq = infixn 0 "=" ;
  EGt = infixn 0 ">" ;
  ELt = infixn 0 "<" ;
}
