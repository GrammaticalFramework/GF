resource Precedence = open (Predef = Predef) in {

  param 
    PAssoc = PN | PL | PR ;

  oper 
    Prec    : PType = Predef.Ints 4 ;
    PrecExp : Type = {s : Str ; p : Prec ; a : PAssoc} ;

    mkPrec : Prec -> PAssoc -> Str -> PrecExp = \p,a,f -> 
      {s = f ; p = p ; a = a} ;

    usePrec : PrecExp -> Prec -> Str = \x,p ->
      case <<x.p,p> : Prec * Prec> of {
        <3,4> | <2,3> | <2,4> => paren x.s ;
        <1,1> | <1,0> | <0,0> => x.s ;
        <1,_> | <0,_>         => paren x.s ;
        _ => x.s
        } ;

    useTop : PrecExp -> Str = \e -> usePrec e 0 ;

    constant : Str -> PrecExp = mkPrec 4 PN ;

    infixN : Prec -> Str -> (_,_ : PrecExp) -> PrecExp = \p,f,x,y ->
      mkPrec p PN (usePrec x (nextPrec p) ++ f ++ usePrec y (nextPrec p)) ;
    infixL : Prec -> Str -> (_,_ : PrecExp) -> PrecExp = \p,f,x,y ->
      mkPrec p PL (usePrec x p ++ f ++ usePrec y (nextPrec p)) ;
    infixR : Prec -> Str -> (_,_ : PrecExp) -> PrecExp = \p,f,x,y ->
      mkPrec p PR (usePrec x (nextPrec p) ++ f ++ usePrec y p) ;

    prefixR : Prec -> Str -> PrecExp -> PrecExp = \p,f,x ->
      mkPrec p PR (f ++ usePrec x p) ;

    nextPrec : Prec -> Prec = \p -> case <p : Prec> of {
      4 => 4 ; 
      n => Predef.plus n 1
      } ;

    paren : Str -> Str = \s -> "(" ++ s ++ ")" ;

}
