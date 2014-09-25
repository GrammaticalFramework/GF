concrete AdverbFin of Adverb = CatFin ** open ResFin, Prelude, StemFin in {
  flags coding=utf8 ;

  lin
    PositAdvAdj a = {s = a.s ! Posit ! sAAdv} ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! Posit ! sAAdv ++ cadv.p ++ np.s ! NPSep
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! Posit ! sAAdv ++ cadv.p ++ s.s
      } ;

    PrepNP prep np = {s = appCompl True Pos prep np} ;

    AdAdv = cc2 ;

    PositAdAAdj a = {s = sANGen (a.s ! Posit)} ; -- älyttömän

    SubjS = cc2 ;
----b    AdvSC s = s ;

    AdnCAdv cadv = {s = cadv.s ++ "kuin"} ;

}
