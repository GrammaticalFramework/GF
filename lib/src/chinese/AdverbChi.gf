concrete AdverbChi of Adverb = CatChi ** 
  open ResChi, Prelude in {

  lin
    PositAdvAdj a = {s = a.s ++ "地" ; advType = ATManner} ; ---- for all adjs?

    PrepNP prep np = ss (appPrep prep np.s) ** {advType = prep.advType} ; --- should depend on np too ? 

    ComparAdvAdj cadv a np = ss (a.s ++ cadv.s ++ cadv.p ++ np.s) ** {advType = ATManner} ;

    ComparAdvAdjS cadv a s = ss (a.s ++ cadv.s ++ cadv.p ++ s.s) ** {advType = ATManner} ;

    AdAdv adv ad = ss (ad.s ++ adv.s) ** {advType = ad.advType} ;

    SubjS subj s = ss (subj.prePart ++ s.s ++ subj.sufPart)  ** {advType = ATTime} ;

    AdnCAdv cadv = ss (cadv.s ++ conjThat) ** {advType = ATManner} ; -----

    PositAdAAdj a = {s = a.s} ; ----

}
