concrete AdverbDut of Adverb = CatDut ** open ResDut, Prelude in {


  lin
    PositAdvAdj a = {s = a.s ! Posit ! APred} ;

--    ComparAdvAdj cadv a np = {
--      s = cadv.s ++ a.s ! Posit ! APred ++ cadv.p ++ np.s ! Nom
--      } ;
--    ComparAdvAdjS cadv a s = {
--      s = cadv.s ++ a.s ! Posit ! APred ++ cadv.p ++ s.s ! Sub
--      } ;

    PrepNP prep np = {s = appPrep prep.s np.s} ;

    AdAdv = cc2 ;

    SubjS subj s = {s = subj.s ++ s.s ! Sub} ;

--    AdnCAdv cadv = {s = cadv.s ++ conjThan} ;
--
}
