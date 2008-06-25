--# -path=.:prelude

concrete CalculatorP of Calculator = open Prelude in {

  flags lexer=codevars ; unlexer=code ;

  lincat 
    Prog, Var = SS ; 
    Exp = SS ;

  lin
    PEmpty = ss [] ;
    PDecl exp prog = ss ("int" ++ prog.$0 ++ "=" ++ exp.s ++ ";" ++ prog.s) ;
    PAss vr exp prog = ss (vr.s ++ "=" ++ exp.s ++ ";" ++ prog.s) ;

    EPlus  = infix "+" ;
    EMinus = infix "-" ;
    ETimes = infix "*" ;
    EDiv   = infix "/" ;

    EInt i = i ;
    EVar x = x ;

  oper
    infix : Str -> SS -> SS -> SS = \f,x,y -> 
      ss ("(" ++ x.s ++ f ++ y.s ++ ")") ;
}
