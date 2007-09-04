--# -path=.:prelude

concrete CalculatorC of Calculator = open Predef,Prelude in {

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

  oper
    Prec : PType = Ints 2 ;
    TermPrec : Type = {s : Str ; p : Prec} ;

    lessPrec : Prec -> Prec -> Bool = \p,q ->
      case <<p,q> : Prec * Prec> of {
        <1,1> | <1,0> | <0,0> => False ;
        <1,_> | <0,_>         => True ;
        _ => False
        } ;

    usePrec : TermPrec -> Prec -> Str = \x,p ->
      case lessPrec x.p p of {
        True => paren x.s ;
        False => noparen x.s
      } ;

    paren : Str -> Str = \s -> "(" ++ s ++ ")" ;
    noparen : Str -> Str = \s -> variants {s ; "(" ++ s ++ ")"} ;

    top : TermPrec -> Str = \t -> usePrec t 0 ;

    mkPrec : Prec -> Str -> TermPrec = \p,s -> 
      {s = s ; p = p} ;

    constant : Str -> TermPrec = mkPrec 2 ;

    infixl : Prec -> Str -> (_,_ : TermPrec) -> TermPrec = \p,f,x,y ->
      mkPrec p (usePrec x p ++ f ++ usePrec y (nextPrec p)) ;

    nextPrec : Prec -> Prec = \p -> case <p : Prec> of {
      2 => 2 ; 
      n => plus n 1
      } ;

}
