resource ResImper = open Prelude, Precedence in {

  oper
    PrecExp   : Type = {s : PrecTerm} ;
    continue  : Str -> SS -> SS = \s -> infixSS ";" (ss s); 
    statement : Str -> SS       = \s -> postfixSS ";" (ss s); 
    ex        : PrecExp -> Str = \exp -> exp.s ! p0 ;
    infixL    : Prec -> Str -> PrecExp -> PrecExp -> PrecExp =
        \p,h,x,y -> {s = mkInfixL h p x.s y.s} ;
    infixN    : Prec -> Str -> PrecExp -> PrecExp -> PrecExp =
        \p,h,x,y -> {s = mkInfix h p x.s y.s} ;

    constant  : Str -> PrecExp = \c -> {s = mkConst c} ;

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

-- for JVM
    Instr  : Type = {s, s3 : Str} ; -- code, labels
    instr  : Str -> Instr = \s -> statement s ** {s3 = []} ; ----
    instrc : Str -> Instr -> Instr = \s,i -> statement (s ++ i.s) ** {s3 = i.s3} ; ----
    binop  : Str -> SS -> SS -> SS = \op, x, y ->
      ss (x.s ++ y.s ++ op ++ ";") ;

}