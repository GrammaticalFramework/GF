--# -path=.:prelude

concrete CalculatorC of Calculator = open Prelude in {

  flags lexer=codevars ; unlexer=code ;

  lincat 
    Prog, Var = SS ; 
    Exp = TermPrec ;

  lin
    PEmpty = ss [] ;
    PDecl exp prog = ss ("int" ++ prog.$0 ++ "=" ++ exp.s ++ ";" ++ prog.s) ;
    PAss vr exp prog = ss (vr.s ++ "=" ++ exp.s ++ ";" ++ prog.s) ;

    EPlus  = infixl 0 "+" ;
    EMinus = infixl 0 "-" ;
    ETimes = infixl 1 "*" ;

    EInt i = constant i.s ;
    EVar x = constant x.s ;

  oper
    Prec : PType = Predef.Ints 2 ;
    TermPrec : Type = {s : Str ; p : Prec} ;

    usePrec : TermPrec -> Prec -> Str = \x,p ->
      case <<x.p,p> : Prec * Prec> of {
        <1,1> | <1,0> | <0,0> => x.s ;
        <1,_> | <0,_>         => "(" ++ x.s ++ ")" ;
        _ => x.s
        } ;

    mkPrec : Prec -> Str -> TermPrec = \p,s -> 
      {s = s ; p = p} ;

    constant : Str -> TermPrec = mkPrec 2 ;

    infixl : Prec -> Str -> (_,_ : TermPrec) -> TermPrec = \p,f,x,y ->
      mkPrec p (usePrec x p ++ f ++ usePrec y (nextPrec p)) ;

    nextPrec : Prec -> Prec = \p -> case <p : Prec> of {
      2 => 2 ; 
      n => Predef.plus n 1
      } ;

}
