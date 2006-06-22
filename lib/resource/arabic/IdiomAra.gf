concrete IdiomAra of Idiom = CatAra ** open Prelude, ResAra in {
--
--  flags optimize=all_subs ;
--
--  lin
--    ExistNP np = 
--      mkClause "تهري" (agrP3 np.a.n) (insertObj (\\_ => np.s ! Acc) (predAux auxBe)) ;
--    ImpersCl vp = mkClause "ِت" (agrP3 Sg) vp ;
--    GenericCl vp = mkClause "ْني" (agrP3 Sg) vp ;
--
--    ProgrVP vp = insertObj (\\a => vp.ad ++ vp.prp ++ vp.s2 ! a) (predAux auxBe) ;
--
}

