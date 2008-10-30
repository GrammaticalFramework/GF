concrete AdverbBul of Adverb = CatBul ** open ResBul, Prelude in {
  flags coding=cp1251 ;

  lin
    PositAdvAdj a = {s = a.adv} ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ "по" ++ "-" ++ a.s ! ASg Neut Indef ++ "от" ++ np.s ! RObj Acc
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ "по" ++ "-" ++ a.s ! ASg Neut Indef ++ "от" ++ "колкото" ++ s.s
      } ;

    PrepNP prep np = {s = prep.s ++ np.s ! RObj prep.c} ;

    AdAdv = cc2 ;

    SubjS = cc2 ;

    AdnCAdv cadv = {s = cadv.sn ++ "от"} ;
}
