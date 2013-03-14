concrete AdverbFin of Adverb = CatFin ** open ResFin, Prelude, StemFin in {

  lin
    PositAdvAdj a = {s = a.s ! Posit ! SAAdv} ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! Posit ! SAAdv ++ cadv.p ++ np.s ! NPCase Nom
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! Posit ! SAAdv ++ cadv.p ++ s.s
      } ;

    PrepNP prep np = {s = preOrPost prep.isPre prep.s (np.s ! prep.c)} ;

    AdAdv = cc2 ;

    PositAdAAdj a = {s = glue (a.s ! Posit ! SAN 1) "n"} ; -- älyttömän

    SubjS = cc2 ;
----b    AdvSC s = s ;

    AdnCAdv cadv = {s = cadv.s ++ "kuin"} ;

}
