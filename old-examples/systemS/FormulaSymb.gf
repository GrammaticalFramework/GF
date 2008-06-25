--# -path=.:prelude

concrete FormulaSymb of Formula = open Precedence in {

  lincat
    Formula, Term = PrecExp ;

  lin
    And = infixL 3 "&" ;
    Or  = infixL 2 "v" ;
    If  = infixR 1 "->" ;
    Not = prefixR 4 "~" ;
    Abs = constant "_|_" ;

----    All P = mkPrec 4 PR (paren ("All" ++ P.$0) ++ usePrec P 4) ;
----    Exist P = mkPrec 4 PR (paren ("Ex" ++ P.$0) ++ usePrec P 4) ;

    A = constant "A" ;
    B = constant "B" ;
    C = constant "C" ;

}