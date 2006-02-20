concrete IdiomEng of Idiom = CatEng ** open Prelude, ResEng in {

  flags optimize=all_subs ;

  lin
    ExistNP np = 
      mkClause "there" (agrP3 Sg) (insertObj (\\_ => np.s ! Acc) (predAux auxBe)) ;
    ImpersVP vp = mkClause "it" (agrP3 Sg) vp ;
--    ProgrVP  : VP -> VP ;  -- sleeping

}

