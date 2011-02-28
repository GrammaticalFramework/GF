concrete AdverbEng of Adverb = CatEng ** open ResEng, Prelude in {

  lin
    PositAdvAdj a = {s = a.s ! AAdv} ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! AAdv ++ cadv.p ++ np.s ! npNom
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! AAdv ++ cadv.p ++ s.s
      } ;

    PrepNP prep np = {s = prep.s ++ np.s ! NPAcc} ;

    AdAdv = cc2 ;
    PositAdAAdj a = {s = a.s ! AAdv} ;

    SubjS = cc2 ;

    AdnCAdv cadv = {s = cadv.s ++ cadv.p} ;

}
