
 concrete ZeroHeb of Zero = {
    flags coding=utf8 ;
  lincat
    S = Str ;
    NP = {s : Str ; g : Gender} ;
    VP, V2 = Gender => Str ;
  lin
    Pred np vp = np.s ++ vp ! np.g ;
    Compl v2 np = table {g => v2 ! g ++ "את" ++ np.s} ;
    John = {s = "ג׳ון" ; g = Masc} ;
    Mary = {s = "מרי" ; g = Fem} ;
    Love = table {Masc => "אוהב" ; Fem => "אוהבת"} ;
  param
    Gender = Masc | Fem ;
 }

--.
-- illustrates: transliteration, inherent features, agreement
-- > gr | l -to_hebrew
-- > ut -hebrew
-- > rf -file=ZeroHeb.gf | ps -env=quotes -to_hebrew
-- > dc amac aw -format=png -view=open ?0
-- > gr | %amac
