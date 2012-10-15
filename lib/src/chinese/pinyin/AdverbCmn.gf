concrete AdverbCmn of Adverb = CatCmn ** 
  open ResCmn, Prelude in {

  lin
    PositAdvAdj a = {s = a.s ; advType = ATManner} ;

    PrepNP prep np = ss (appPrep prep np.s) ** {advType = ATPlace} ; --- should depend on prep, np ? or treat in ExtraCmn ?

    ComparAdvAdj cadv a np = ss (a.s ++ cadv.s ++ cadv.p ++ np.s) ** {advType = ATManner} ;

    ComparAdvAdjS cadv a s = ss (a.s ++ cadv.s ++ cadv.p ++ s.s) ** {advType = ATManner} ;

    AdAdv adv ad = ss (ad.s ++ adv.s) ** {advType = ad.advType} ;

    SubjS subj s = ss (subj.prePart ++ s.s ++ subj.sufPart)  ** {advType = ATManner} ;

    AdnCAdv cadv = ss (cadv.s ++ conjThat) ** {advType = ATManner} ; -----

}
