concrete ZeroGer of Zero = {
  lincat
    S, NP, VP = Str ;
    V2 = {v,p : Str} ;
  lin
    Pred np vp = np ++ vp ;
    Compl v2 np = v2.v ++ np ++ v2.p ;
    John = "Johann" ;
    Mary = "Maria" ;
    Love = {v = "hat" ; p = "lieb"} ;
}

--.

-- illustrates: discontinuous constituents
-- contrived, since we also have "liebt"
--
-- > p -lang=ZeroEng "John loves Mary" | aw -view=open -format=png

