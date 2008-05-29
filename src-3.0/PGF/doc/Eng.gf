concrete Eng of Ex = {
  lincat
    S  = {s : Str} ;
    NP = {s : Str ; n : Num} ;
    VP = {s : Num => Str} ;
  param
    Num = Sg | Pl ;
  lin
    Pred np vp = {s = np.s ++ vp.s ! np.n} ;
    She = {s = "she" ; n = Sg} ;
    They = {s = "they" ; n = Pl} ;
    Sleep = {s = table {Sg => "sleeps" ; Pl => "sleep"}} ;
}
