resource ResImper = open Prelude, Precedence in {

  oper
    continue  : Str -> SS -> SS = \s -> infixSS ";" (ss s); 
    statement : Str -> SS       = \s -> postfixSS ";" (ss s); 
    ex       : {s : PrecTerm} -> Str = \exp -> exp.s ! p0 ;
    infixL   : 
      Prec -> Str -> {s : PrecTerm} -> {s : PrecTerm} -> {s : PrecTerm} =
        \p,h,x,y -> {s = mkInfixL h p x.s y.s} ;

    constant : Str -> {s : PrecTerm} = \c -> {s = mkConst c} ;

}