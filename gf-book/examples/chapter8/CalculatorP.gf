concrete CalculatorP of Calculator = open Prelude in {

lincat 
  Exp = SS ;
lin
  EPlus  = infix "+" ;
  EMinus = infix "-" ;
  ETimes = infix "*" ;
  EDiv   = infix "/" ;
  EInt i = i ;
oper
  infix : Str -> SS -> SS -> SS = \f,x,y -> 
    ss ("(" ++ x.s ++ f ++ y.s ++ ")") ;
}
