concrete AdverbIna of Adverb = CatIna ** open ResIna, Prelude in {

  lin
    PositAdvAdj a = {s = a.s ! AAdv} ;
    PrepNP prep np = {s = prep.s ++ np.s ! Acc} ;

    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! AAdv ++ "que" ++ np.s ! Nom
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! AAdv ++ "que" ++ s.s
      } ;


    AdAdv = cc2 ;

    SubjS = cc2 ;

    AdnCAdv cadv = {s = cadv.s ++ "que"} ;

}
