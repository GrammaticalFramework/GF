--# -path=.:prelude

concrete CalculatorJ of Calculator = open Prelude in {

  flags lexer=codevars ; unlexer=code ;

  lincat 
    Prog, Exp, Var = SS ;

  lin
    PEmpty = ss [] ;
    PDecl exp prog = ss (exp.s ++ ";" ++ prog.s) ;
    PAss vr exp prog = ss (exp.s ++ ";" ++ "istore" ++ vr.s ++ ";" ++ prog.s) ;

    EPlus  = postfix "iadd" ;
    EMinus = postfix "isub" ;
    ETimes = postfix "imul" ;
    EDiv   = postfix "imul" ;

    EInt = prefixSS "iconst" ;
    EVar = prefixSS "iload" ;

  oper
    postfix : Str -> SS -> SS -> SS = \op,x,y -> ss (x.s ++ ";" ++ y.s ++ ";" ++ op) ;
}
