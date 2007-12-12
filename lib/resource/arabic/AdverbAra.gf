concrete AdverbAra of Adverb = CatAra ** open ResAra, Prelude in {

  lin
    PositAdvAdj a = {s = a.s ! Masc ! Sg ! Indef ! Acc} ;
--    ComparAdvAdj cadv a np = {
--      s = cadv.s ++ a.s ! AAdv ++ "مِنْ" ++ np.s ! Gen
--      } ;
--    ComparAdvAdjS cadv a s = {
--      s = cadv.s ++ a.s ! AAdv ++ "تهَن" ++ s.s
--      } ;

    PrepNP prep np = {s = prep.s ++ np.s ! Gen} ;

--    AdAdv = cc2 ;
--
--    SubjS = cc2 ;
--    AdvSC s = s ; --- this rule give stack overflow in ordinary parsing
--
--    AdnCAdv cadv = {s = cadv.s ++ "تهَن"} ;
--
}
