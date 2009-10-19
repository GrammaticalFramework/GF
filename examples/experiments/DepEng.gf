concrete DepEng of Dep = {

lincat 
  S, NP, V2, CN, AP, Adv, Prep, AdA = Str ;
  VP = Str * Str ;
lin
  Pred  x y = x ++ y.p1 ++ y.p2 ;
  Extr  x y = y.p2 ++ x ++ y.p1 ;
  Compl x y = <y,x> ;
  Mods  x y = x ++ y ;
  MMods x y z = x ++ y ++ z ;
  Prepm x y = y ++ x ;
  Prepp x y = y ++ x ;
   
  Economic = "economic" ;
  Financial = "financial" ;
  Little = "little" ;
  News = "news" ;
  Effect = "effect" ;
  Markets = "markets" ;
  Had = "had" ;
  On = "on" ;
  Very = "very" ;
}
