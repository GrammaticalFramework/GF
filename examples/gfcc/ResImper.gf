resource ResImper = open Predef in {

  -- precedence

  param PAssoc = PN | PL | PR ;

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

    constant : Str -> PrecExp = mkPrec 4 PN ;

    infixN : Prec -> Str -> (_,_ : PrecExp) -> PrecExp = \p,f,x,y ->
      mkPrec p PN (usePrec x (nextPrec p) ++ f ++ usePrec y (nextPrec p)) ;
    infixL : Prec -> Str -> (_,_ : PrecExp) -> PrecExp = \p,f,x,y ->
      mkPrec p PL (usePrec x p ++ f ++ usePrec y (nextPrec p)) ;
    infixR : Prec -> Str -> (_,_ : PrecExp) -> PrecExp = \p,f,x,y ->
      mkPrec p PR (usePrec x (nextPrec p) ++ f ++ usePrec y p) ;

    nextPrec : Prec -> Prec = \p -> case <p : Prec> of {
      4 => 4 ; 
      n => Predef.plus n 1
      } ;

  -- string operations

    SS  : Type = {s : Str} ;
    ss  : Str -> SS = \s -> {s = s} ;
    cc2 : (_,_ : SS) -> SS = \x,y -> ss (x.s ++ y.s) ;

    paren : Str -> Str = \str -> "(" ++ str ++ ")" ;

    continues : Str -> SS -> SS = \s,t -> ss (s ++ ";" ++ t.s) ; 
    continue  : Str -> SS -> SS = \s,t -> ss (s ++ t.s) ;
    statement : Str -> SS       = \s   -> ss (s ++ ";"); 

  -- taking cases of list size

  param
    Size = Zero | One | More ;
  oper
    nextSize : Size -> Size = \n -> case n of {
      Zero => One ;
      _    => More
      } ;
    separator : Str -> Size -> Str = \t,n -> case n of {
      Zero => [] ;
     _ => t
     } ;

  -- operations for JVM

    Instr  : Type = {s,s2,s3 : Str} ; -- code, variables, labels
    instr  : Str -> Instr = \s -> 
      statement s ** {s2,s3 = []} ;
    instrc : Str -> Instr -> Instr = \s,i -> 
      ss (s ++ ";" ++ i.s) ** {s2 = i.s2 ; s3 = i.s3} ;
    instrl : Str -> Instr -> Instr = \s,i -> 
      ss (s ++ ";" ++ i.s) ** {s2 = i.s2 ; s3 = "L" ++ i.s3} ;
    instrb : Str -> Str -> Instr -> Instr = \v,s,i -> 
      ss (s ++ ";" ++ i.s) ** {s2 = v ++ i.s2 ; s3 = i.s3} ;
    binop  : Str -> SS -> SS -> SS = \op, x, y ->
      ss (x.s ++ y.s ++ op ++ ";") ;
    binopt : Str -> SS -> SS -> SS -> SS = \op, t ->
      binop (t.s ++ op) ;
}
