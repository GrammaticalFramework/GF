--# -path=.:prelude

concrete CalculatorE of Calculator = open Prelude in {

  flags lexer=codevar ; unlexer=unwords ;

  lincat 
    Prog, Exp, Var = SS ;

  lin
    PEmpty = ss [] ;
    PInit exp prog = ss ("initialize" ++ prog.$0 ++ "as" ++ exp.s ++ PAUSE ++ prog.s) ;
    PAss vr exp prog = ss ("redefine" ++ vr.s ++ "as" ++ exp.s ++ PAUSE ++ prog.s) ;

    EPlus  = infix "plus" ;
    EMinus = infix "minus" ;
    ETimes = infix "times" ;
    EDiv   = infix ["divided by"] ;

    EInt i = i ;
    EVar x = x ;

  oper
    infix : Str -> SS -> SS -> SS = \op,x,y -> 
      ss (x.s ++ op ++ y.s ++ PAUSE) ;
    PAUSE = "PAUSE" ;
}
