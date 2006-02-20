concrete IdiomEng of Idiom = CatEng ** open Prelude, ResEng in {

  flags optimize=all_subs ;

  lin
    ExistNP np = 
      mkClause "there" (agrP3 np.a.n) (insertObj (\\_ => np.s ! Acc) (predAux auxBe)) ;
    ImpersCl vp = mkClause "it" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "one" (agrP3 Sg) vp ;

    ProgrVP vp = insertObj (\\a => vp.ad ++ vp.prp ++ vp.s2 ! a) (predAux auxBe) ;

}

