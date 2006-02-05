concrete AdverbFin of Adverb = CatFin ** open ResFin, Prelude in {

  lin
    PositAdvAdj a = {s = a.s ! Posit ! AAdv} ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! Posit ! AAdv ++ "kuin" ++ np.s ! NPCase Nom
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! Posit ! AAdv ++ "kuin" ++ s.s
      } ;

    PrepNP prep np = {s = preOrPost prep.isPre prep.s (np.s ! prep.c)} ;

    AdAdv = cc2 ;

    SubjS = cc2 ;
    AdvSC s = s ; --- this rule give stack overflow in ordinary parsing

    AdnCAdv cadv = {s = cadv.s ++ "kuin"} ;

}
