concrete Swe of Ex = {
  lincat
    S  = {s : Str} ;
    NP = {s : Str} ;
    VP = {s : Str} ;
  param
    Num = Sg | Pl ;
  lin
    Pred np vp = {s = np.s ++ vp.s} ;
    She = {s = "hon"} ;
    They = {s = "de"} ;
    Sleep = {s = "sover"} ;
}
