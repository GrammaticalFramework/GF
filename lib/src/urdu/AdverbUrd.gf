concrete AdverbUrd of Adverb = CatUrd ** open ResUrd, Prelude in {

  lin
    PositAdvAdj a = {s = a.s ! Sg ! Masc ! Obl ! Posit} ;
    ComparAdvAdj cadv a np = {
      s = np.s ! NPObj  ++ cadv.p ++ cadv.s ++ a.s ! Sg ! Masc ! Obl ! Posit;  
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.p ++ cadv.s ++ a.s ! Sg ! Masc ! Obl ! Posit  ++  s.s;
      } ;

    PrepNP prep np = {s = np.s ! NPObj ++ prep.s } ;

    AdAdv ada adv = { s = ada.s ++ adv.s} ;

    SubjS = cc2 ;

    AdnCAdv cadv = {s = "sE" ++ cadv.s} ;

}
