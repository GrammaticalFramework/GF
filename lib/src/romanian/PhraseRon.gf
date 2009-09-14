 concrete PhraseRon of Phrase = 
  CatRon ** open ResRon, Prelude in {

  flags optimize = all_subs ;

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = {s = s.s ! Indic} ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp  = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg False ! Fem} ;
    UttImpPl pol imp  = {s = pol.s ++ imp.s ! pol.p ! ImpF Pl False ! Fem} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg True  ! Fem} ;

    UttIP ip = {s = ip.s ! No} ; 
    UttIAdv iadv = iadv ;
    UttNP np = {s = (np.s ! No).comp} ;
    UttVP vp = let a = agrP3 Masc Sg in 
          {s = "sã"  ++ (flattenSimpleClitics vp.nrClit vp.clAcc vp.clDat (vp.isRefl ! a)) ++ conjVP vp a ++vp.comp ! a ++ vp.ext ! Pos} ; 
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s2} ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ (np.s ! Vo).comp} ;

}
