--# -path=.:prelude

concrete CalculatorC of Calculator = open Prelude, Formal in {

  flags lexer=codevars ; unlexer=code ;

  lincat 
    Prog, Var = SS ; 
    Exp = TermPrec ;

  lin
    PEmpty = ss [] ;
    PDecl exp prog = ss ("int" ++ prog.$0 ++ "=" ++ top exp ++ ";" ++ prog.s) ;
    PAss vr exp prog = ss (vr.s ++ "=" ++ top exp ++ ";" ++ prog.s) ;

    EPlus  = infixl 0 "+" ;
    EMinus = infixl 0 "-" ;
    ETimes = infixl 1 "*" ;
    EDiv   = infixl 1 "/" ;

    EInt i = constant i.s ;
    EVar x = constant x.s ;

}
