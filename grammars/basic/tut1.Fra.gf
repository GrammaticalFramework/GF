include tut1.Abs.gf ;

lincat S = {s : Str} ;
lincat NP = {s : Str} ;
lincat A1 = {s : Str} ;
lincat CN = {s : Str} ;
lin PredA1 Q F =
  {s = Q.s ++ "est" ++ F.s} ;
lin CondS A B =
  {s = "si" ++ A.s ++ "alors" ++ B.s} ;
lin DisjA1 F G =
  {s = F.s ++ "ou" ++ G.s} ;
lin Every A =
  {s = "tout" ++ A.s} ;
lin ModA1 A F =
  {s = A.s ++ F.s} ;
lin Number  =
  {s = "nombre"} ;
lin Even  =
  {s = "pair"} ;
lin Odd  =
  {s = "impair"} ;
lin Prime  =
  {s = "premier"} ;
lin Zero  =
  {s = "zéro"} ;
