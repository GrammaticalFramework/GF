incomplete concrete AdverbScand of Adverb = CatScand ** open CommonScand, ResScand, Prelude in {

  lin
    PositAdvAdj a = {
      s = a.s ! AAdv
      } ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! AAdv ++ cadv.p ++ np.s ! nominative
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! AAdv ++ cadv.p ++ s.s ! Sub
      } ;

    PrepNP prep np = {s = prep.s ++ np.s ! accusative} ;

    AdAdv = cc2 ;

    PositAdAAdj a = {
      s = a.s ! AAdv
      } ;

    SubjS subj s = {
      s = subj.s ++ s.s ! Sub
      }  ;

    AdnCAdv cadv = {s = cadv.s ++ conjThan} ;

}
