include tut1.Abs.gf ;

lincat S = {s : Str} ;
lincat NP = {s : Str} ;
lincat A1 = {s : Str} ;
lincat CN = {s : Str} ;
lin PredA1 Q F =
  {s = Q.s ++ "è" ++ F.s} ;
lin CondS A B =
  {s = "se" ++ A.s ++ "allora" ++ B.s} ;
lin DisjA1 F G =
  {s = F.s ++ "o" ++ G.s} ;
lin Every A =
  {s = "ogni" ++ A.s} ;
lin ModA1 A F =
  {s = A.s ++ F.s} ;
lin Number  =
  {s = "numero"} ;
lin Even  =
  {s = "pari"} ;
lin Odd  =
  {s = "dispari"} ;
lin Prime  =
  {s = "primo"} ;
lin Zero  =
  {s = "zero"} ;
