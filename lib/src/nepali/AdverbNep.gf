concrete AdverbNep of Adverb = CatNep ** open ResNep, Prelude, Predef in {

  flags coding = utf8;
  
  lin
    PositAdvAdj a = {s = a.s ! Sg ! Masc ++ "गरी" } ;
    
    ComparAdvAdj cadv a np = {
      s = np.s ! NPObj  ++ cadv.p ++ cadv.s ++ a.s ! Sg ! Masc ;  
      } ;

    ComparAdvAdjS cadv a s = {
      s =  cadv.p ++ cadv.s ++ a.s ! Sg ! Masc   ++  s.s;
      } ;

    PrepNP prep np = {s = np.s ! NPObj ++ prep.s } ;

    AdAdv ada adv = { s = ada.s ++ adv.s} ;

    SubjS sub snt = {s = sub.s ++ snt.s } ;
    
    AdnCAdv cadv = {s = cadv.p ++ cadv.s } ;

}
