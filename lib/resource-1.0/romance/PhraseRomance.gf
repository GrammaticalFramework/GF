incomplete concrete PhraseRomance of Phrase = 
  CatRomance, TenseX ** open CommonRomance, ResRomance, Prelude in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = {s = s.s ! Indic} ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! aagr Fem Sg} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! aagr Fem Pl} ;

    UttIP ip = {s = ip.s ! Nom} ; --- Acc also
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! Ton Nom} ;
----    UttVP vp = {s = infVP vp (agrP3 Utr Sg)} ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = conj ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! Ton Nom} ;

}
