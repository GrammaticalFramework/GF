--# -coding=cp1251
concrete AdverbBul of Adverb = CatBul ** open ResBul, Prelude in {
  flags coding=cp1251 ;

  lin
    PositAdvAdj a = {s = a.adv} ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! ASg Neut Indef ++ cadv.p ++ np.s ! RObj CPrep
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! ASg Neut Indef ++ cadv.p ++ "колкото" ++ s.s
      } ;

    PrepNP prep np = {s = prep.s ++ np.s ! RObj prep.c} ;

    AdAdv = cc2 ;

    PositAdAAdj a = {s = a.adv} ;

    SubjS = cc2 ;

    AdnCAdv cadv = {s = cadv.s ++ cadv.p} ;

}
