concrete PaleolithicIta of Paleolithic = {
lincat 
  S, NP, VP, CN, A, V, TV = {s : Str} ; 
lin
  PredVP np vp  = {s = np.s ++ vp.s} ;
  UseV   v      = v ;
  ComplTV tv np = {s = tv.s ++ np.s} ;
  UseA   a   = {s = "è" ++ a.s} ;
  This  cn   = {s = "questo" ++ cn.s} ; 
  That  cn   = {s = "quello" ++ cn.s} ; 
  Def   cn   = {s = "il" ++ cn.s} ;
  Indef cn   = {s = "un" ++ cn.s} ; 
  ModA  a cn = {s = cn.s ++ a.s} ;
  Boy    = {s = "ragazzo"} ;
  Louse  = {s = "pidocchio"} ;
  Snake  = {s = "serpente"} ;
  Worm   = {s = "verme"} ;
  Green  = {s = "verde"} ;
  Rotten = {s = "marcio"} ;
  Thick  = {s = "grosso"} ;
  Warm   = {s = "caldo"} ;
  Laugh  = {s = "ride"} ;
  Sleep  = {s = "dorme"} ;
  Swim   = {s = "nuota"} ;
  Eat    = {s = "mangia"} ;
  Kill   = {s = "uccide"} ; 
  Wash   = {s = "lava"} ;
}
