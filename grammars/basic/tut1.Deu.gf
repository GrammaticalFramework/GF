include tut1.Abs.gf ;

param Ord = dir  | indir  | sub  ;
lincat S = {s : Ord => Str} ;
lincat NP = {s : Str} ;
lincat A1 = {s : Str} ;
lincat CN = {s : Str} ;
lin PredA1 Q F = {s = table {
   {dir} => Q.s ++ "ist" ++ F.s ; 
   {indir} => "ist" ++ Q.s ++ F.s ; 
   {sub} => Q.s ++ F.s ++ "ist"}} ;
lin CondS A B = {s = table {
   {dir} => "wenn" ++ (A.s ! sub) ++ "dann" ++ B.s ! indir ; 
   {indir} => (B.s ! indir) ++ "wenn" ++ A.s ! sub ; 
   {sub} => (B.s ! sub) ++ "wenn" ++ A.s ! sub}} ;
lin DisjA1 F G =
  {s = F.s ++ "oder" ++ G.s} ;
lin Every A =
  {s = "jede" ++ A.s} ;
lin ModA1 A F =
  {s = F.s ++ A.s} ;
lin Number  =
  {s = "Zahl"} ;
lin Even  =
  {s = "gerade"} ;
lin Odd  =
  {s = "ungerade"} ;
lin Prime  =
  {s = "unteilbar"} ;
lin Zero  =
  {s = "Null"} ;

