concrete MapEng of Map = {
lincat
  Query        = {s : Str} ;
  Input, Place = {s : Str ; p : Str} ;
  Click        = {p : Str} ;
lin
  GoFromTo x y = {
    s = "I want to go from" ++ x.s ++ "to" ++ y.s ; 
    p = x.p ++ y.p
    } ;
  ThisPlace c = {
    s = "this place" ; 
    p = c.p
    } ;
  QueryInput i = {s = i.s ++ ";" ++ i.p} ;
  ClickCoord x y = {p = "(" ++ x.s ++ "," ++ y.s ++ ")"} ;
}
