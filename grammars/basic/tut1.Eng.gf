include tut1.Abs.gf ;

lincat 
S = {s : Str} ; NP = {s : Str} ; A1 = {s : Str} ; CN = {s : Str} ;

lin PredA1 Q F = 
  {s = Q.s ++ "is" ++ F.s} ;
lin CondS A B =
  {s = "if" ++ A.s ++ "then" ++ B.s} ;
lin DisjA1 F G =
  {s = F.s ++ "or" ++ G.s} ;
lin Every A =
  {s = "every" ++ A.s} ;
lin ModA1 A F =
  {s = F.s ++ A.s} ;
lin Number  =
  {s = "number"} ;
lin Even  =
  {s = "even"} ;
lin Odd  =
  {s = "odd"} ;
lin Prime  =
  {s = "prime"} ;
lin Zero  =
  {s = "zero"} ;

