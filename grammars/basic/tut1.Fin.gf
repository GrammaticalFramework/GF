include tut1.Abs.gf ;

lincat S = {s : Str} ;
lincat NP = {s : Str} ;
lincat A1 = {s : Str} ;
lincat CN = {s : Str} ;
lin PredA1 Q F =
  {s = Q.s ++ "on" ++ F.s} ;
lin CondS A B =
  {s = "jos" ++ A.s ++ "niin" ++ B.s} ;
lin DisjA1 F G =
  {s = F.s ++ "tai" ++ G.s} ;
lin Every A =
  {s = A.s ++ "kuin" ++ A.s} ;
lin ModA1 A F =
  {s = F.s ++ A.s} ;
lin Number  =
  {s = "luku"} ;
lin Even  =
  {s = "parillinen"} ;
lin Odd  =
  {s = "pariton"} ;
lin Prime  =
  {s = "jaoton"} ;
lin Zero  =
  {s = "nolla"} ;
