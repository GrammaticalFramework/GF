incomplete concrete PhraseScand of Phrase = 
  CatScand, TenseX ** open DiffScand, ResScand, Prelude in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = {s = s.s ! Main} ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! Sg} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl} ;

    UttIP ip = {s = ip.s ! nominative} ; --- Acc also
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! accusative} ;
----    UttVP vp = {s = infMark ++ infVP vp (agrP3 Sg)} ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = conj ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! nominative} ;

}
