resource DatabaseEngRes = open Prelude in {
oper
  mkSent : SS -> SS -> SS1 Bool = \long, short -> 
    {s = table {b => if_then_else Str b long.s short.s}} ;

  mkSentPrel : Str -> SS -> SS1 Bool = \prel, matter -> 
    mkSent (ss (prel ++ matter.s)) matter ;

  mkSentSame : SS -> SS1 Bool = \s -> 
    mkSent s s ;
} ;
