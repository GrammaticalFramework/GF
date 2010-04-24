concrete ZeroDut of Zero = {
  lincat
    S, NP, VP = Str ;
    V2 = {v,p : Str} ;
  lin
    Pred np vp = np ++ vp ;
    Compl v2 np = v2.v ++ np ++ v2.p ;
    John = "Jan" ;
    Mary = "Marie" ;
    Love = {v = "heeft" ; p = "lief"} ;
}

--.

-- illustrates: discontinuous constituents
--
-- > p -lang=ZeroEng "John loves Mary" | aw -view=open -format=png

