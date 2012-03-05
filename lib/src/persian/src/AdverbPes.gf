concrete AdverbPes of Adverb = CatPes ** open ResPes, Prelude in {

  flags coding = utf8;
  lin
 --   PositAdvAdj a = {s = a.s ! bEzafa  } ;
     PositAdvAdj a = {s = a.adv  } ;
    ComparAdvAdj cadv a np = {
      s = a.adv ++ cadv.p ++ cadv.s ++ np.s ! NPC bEzafa  ;  
      } ;
    ComparAdvAdjS cadv a s = {
      s =  a.adv  ++ cadv.p ++ cadv.s  ++  s.s;
      } ;

    PrepNP prep np = {s =  prep.s ++ np.s ! NPC bEzafa } ;

    AdAdv ada adv = { s =  ada.s ++ adv.s} ;

--    SubjS = cc2 ;
    SubjS sub snt = {s = sub.s  ++ "kh" ++ snt.s } ;
    AdnCAdv cadv = {s =  cadv.s ++ "Az"} ;

}
