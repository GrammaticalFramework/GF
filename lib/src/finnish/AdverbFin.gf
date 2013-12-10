--# -coding=latin1
concrete AdverbFin of Adverb = CatFin ** open ResFin, Prelude, StemFin in {

  lin
    PositAdvAdj a = {s = a.s ! Posit ! sAAdv} ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! Posit ! sAAdv ++ cadv.p ++ np.s ! NPCase Nom
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
