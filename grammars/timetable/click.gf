cat
  Request ;
  Place ;
  Position ;

fun
  GoTo : Place -> Request ;
  GoFromTo : Place -> Place -> Request ;

  Named : String -> Place ;
  Pointed : Position -> Place ;

  Pos : Int -> Int -> Position ;

lincat
  Request, Place = {s,s2 : Str} ;

lin
  GoTo x = {
    s = ["I want to go to"] ++ x.s ; 
    s2 = x.s2
    } ;
  GoFromTo x y = {
    s = ["I want to go from"] ++ x.s ++ "to" ++ y.s ; 
    s2 = x.s2 ++ "," ++ y.s2
    } ;

  Named c = {
    s = c.s ;
    s2 = []
    } ;
  Pointed p = {
    s = "here" ;
    s2 = p.s
    } ;
  Pos x y = {s = "(" ++ x.s ++ "," ++ y.s ++ ")"} ;
