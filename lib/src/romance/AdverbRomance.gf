incomplete concrete AdverbRomance of Adverb = 
  CatRomance ** open CommonRomance, ResRomance, Prelude in {

  lin
    PositAdvAdj a = {
      s = a.s ! Posit ! AA
      } ;
    
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! Posit ! AA ++ cadv.p ++ (np.s ! Nom).ton 
      } ;
    
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! Posit ! AA ++ cadv.p ++ s.s ! Conjunct --- ne
      } ;

    PrepNP prep np = {s = prep.s ++ (np.s ! prep.c).ton} ;

    AdAdv = cc2 ;

    PositAdAAdj a = {
      s = a.s ! Posit ! AA
      } ;

    SubjS subj s = {
      s = subj.s ++ s.s ! subj.m
      }  ;

    AdnCAdv cadv = {s = cadv.s ++ conjThan} ;

}
