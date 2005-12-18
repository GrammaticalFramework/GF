concrete PaleolithicEng of Paleolithic = {
lincat 
  S, NP, VP, CN, A, V, TV = {s : Str} ; 
lin
  PredVP np vp  = {s = np.s ++ vp.s} ;
  UseV   v      = v ;
  ComplTV tv np = {s = tv.s ++ np.s} ;
  UseA   a   = {s = "is" ++ a.s} ;
  This  cn   = {s = "this" ++ cn.s} ; 
  That  cn   = {s = "that" ++ cn.s} ; 
  Def   cn   = {s = "the" ++ cn.s} ;
  Indef cn   = {s = "a" ++ cn.s} ; 
  ModA  a cn = {s = a.s ++ cn.s} ;
  Boy    = {s = "boy"} ;
  Louse  = {s = "louse"} ;
  Snake  = {s = "snake"} ;
  Worm   = {s = "worm"} ;
  Green  = {s = "green"} ;
  Rotten = {s = "rotten"} ;
  Thick  = {s = "thick"} ;
  Warm   = {s = "warm"} ;
  Laugh  = {s = "laughs"} ;
  Sleep  = {s = "sleeps"} ;
  Swim   = {s = "swims"} ;
  Eat    = {s = "eats"} ;
  Kill   = {s = "kills"} ; 
  Wash   = {s = "washes"} ;
}