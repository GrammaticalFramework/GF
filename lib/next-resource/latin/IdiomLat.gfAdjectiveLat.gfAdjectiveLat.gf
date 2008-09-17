concrete IdiomLat of Idiom = CatLat ** open Prelude, ResLat in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "it" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "one" (agrP3 Sg) vp ;

    CleftNP np rs = mkClause "it" (agrP3 Sg) 
      (insertObj (\\_ => rs.s ! np.a)
        (insertObj (\\_ => np.s ! rs.c) (predAux auxBe))) ;

    CleftAdv ad s = mkClause "it" (agrP3 Sg) 
      (insertObj (\\_ => conjThat ++ s.s)
        (insertObj (\\_ => ad.s) (predAux auxBe))) ;

    ExistNP np = 
      mkClause "there" (agrP3 (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! Acc) (predAux auxBe)) ;

    ExistIP ip = 
      mkQuestion (ss (ip.s ! Nom)) 
        (mkClause "there" (agrP3 ip.n) (predAux auxBe)) ;

    ProgrVP vp = insertObj (\\a => vp.ad ++ vp.prp ++ vp.s2 ! a) (predAux auxBe) ;

    ImpPl1 vp = {s = "let's" ++ infVP True vp (AgP1 Pl)} ;

}

