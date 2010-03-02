resource ResImperEng = open Predef, Prelude in {

  oper
    indef = pre {"a" ; 
                  "an" / strs {"a" ; "e" ; "i" ; "o" ; "A" ; "E" ; "I" ; "O" }} ;

    constant : Str -> SS  = ss ;
    prefix   : Str -> SS -> SS -> SS = \f,x,y -> 
      ss ("the" ++ f ++ "of" ++ x.s ++ "and" ++ y.s) ;
    comparison : Str -> SS -> SS -> SS = \f,x,y -> 
      ss (x.s ++ "is" ++ f ++ "than" ++ y.s) ;
    continues : Str -> SS -> SS = \s,t -> ss (s ++ "." ++ t.s) ; 
    continue  : Str -> SS -> SS = \s,t -> ss (s ++        t.s) ; 
    statement : Str -> SS       = \s   -> ss (s ++ "."); 

}
