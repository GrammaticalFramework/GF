resource ResImper = open Predef in {

  -- precedence

  oper 
    Prec     : PType = Predef.Ints 4 ;
    PrecExp  : Type = {s : Prec => Str} ;
    ex       : PrecExp -> Str = \exp -> exp.s ! 0 ;
    constant : Str -> PrecExp = \c -> {s = \\_ => c} ;
    infixN : Prec -> Str -> PrecExp -> PrecExp -> PrecExp = \p,f,x,y ->
      {s = mkPrec (x.s ! (nextPrec ! p) ++ f ++ y.s ! (nextPrec ! p)) ! p} ;
    infixL : Prec -> Str -> PrecExp -> PrecExp -> PrecExp = \p,f,x,y ->
      {s = mkPrec (x.s ! p ++ f ++ y.s ! (nextPrec ! p)) ! p} ;

    nextPrec : Prec => Prec = table {
      4 => 4 ; 
      n => Predef.plus n 1
      } ;

    mkPrec : Str -> Prec => Prec => Str = \str -> 
      \\p,q => case Predef.lessInt p q of {
        Predef.PTrue => paren str ;
        _ => str
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
    binopt : Str -> SS -> SS -> SS -> SS = \op, x, y, t ->
      ss (x.s ++ y.s ++ t.s ++ op ++ ";") ;
}
