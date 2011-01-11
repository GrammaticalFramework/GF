concrete CalculatorS of Calculator = open Prelude in {
  lin
    EPlus  = infix "plus" ;
    EMinus = infix "minus" ;
    ETimes = infix "times" ;
    EDiv   = infix ["divided by"] ;
    EInt i = i ;
  oper
    infix : Str -> SS -> SS -> SS = \op,x,y -> 
      ss (x.s ++ op ++ y.s ++ "PAUSE") ;
}
