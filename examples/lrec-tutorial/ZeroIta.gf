concrete ZeroIta of Zero = {
  lincat
    S, NP, VP, V2 = Str ;
  lin
    Pred np vp = np ++ vp ;
    Compl v2 np = v2 ++ np ;
    John = "Giovanni" ;
    Mary = "Maria" ;
    Love = "ama" ;
}

--.

-- > gr | l
-- > p -lang=ZeroEng "John loves Mary" | l -lang=ZeroIta

