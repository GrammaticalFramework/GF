concrete ZeroHebTr of Zero = {
  lincat
    S = Str ;
    NP = {s : Str ; g : Gender} ;
    VP, V2 = Gender => Str ;
  lin
    Pred np vp = np.s ++ vp ! np.g ;
    Compl v2 np = table {g => v2 ! g ++ "At" ++ np.s} ;
    John = {s = "gg1wN" ; g = Masc} ;
    Mary = {s = "mry" ; g = Fem} ;
    love = table {Masc => "Awhb" ; Fem => "Awhbt"} ;
  param
    Gender = Masc | Fem ;
}

--.
-- illustrates: transliteration, inherent features, agreement
-- > gr | l -to_hebrew
-- > ut -hebrew
-- > rf -file=ZeroHeb.gf | ps -env=quotes -to_hebrew
