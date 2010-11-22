concrete CalculatorJ of Calculator = open Prelude in {
lincat 
  Exp = SS ;
lin
  EPlus  = postfix "iadd" ;
  EMinus = postfix "isub" ;
  ETimes = postfix "imul" ;
  EDiv   = postfix "idiv" ;
  EInt i = ss ("ldc" ++ i.s) ;
oper
  postfix : Str -> SS -> SS -> SS = \op,x,y -> 
    ss (x.s ++ ";" ++ y.s ++ ";" ++ op) ;
}
