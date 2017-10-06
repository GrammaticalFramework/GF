incomplete concrete PhraseScand of Phrase = 
  CatScand ** open CommonScand, ResScand, Prelude in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = {s = s.s ! Main} ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! Sg} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! Sg} ; --- works for adj but not for refl

    UttIP ip = {s = ip.s ! nominative} ; --- Acc also
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! nominative} ;
    UttVP vp = {s = infMark ++ infVP vp (agrP3 Utr Sg)} ;
    UttAdv adv = adv ;
    UttCN n = {s = n.s ! Sg ! DIndef ! Nom} ;
    UttAP n = {s = n.s ! Strong (GSg Utr)} ;
    UttCard n = {s = n.s ! neutrum} ;
    UttInterj i = i ;

    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s2} ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! nominative} ;

}
