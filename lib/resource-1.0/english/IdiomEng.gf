concrete IdiomEng of Idiom = CatEng ** open Prelude, ResEng in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "it" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "one" (agrP3 Sg) vp ;

    ExistNP np = 
      mkClause "there" (agrP3 np.a.n) (insertObj (\\_ => np.s ! Acc) (predAux auxBe)) ;

    ExistIP ip = 
      mkQuestion (ss (ip.s ! Nom)) (mkClause "there" (agrP3 ip.n) (predAux auxBe)) ;

    ProgrVP vp = insertObj (\\a => vp.ad ++ vp.prp ++ vp.s2 ! a) (predAux auxBe) ;

}

