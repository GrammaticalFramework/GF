concrete PhraseFin of Phrase = CatFin ** open ResFin in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s} ;
    UttImpSg  pol imp = {s = pol.s ++ imp.s ! pol.p ! Sg} ;
    UttImpPl  pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl} ;

    UttIP ip = {s = ip.s ! NPCase Nom} ;
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! NPCase Nom} ;
    UttVP vp = {s = infVP (NPCase Nom) Pos (agrP3 Sg) vp} ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = conj ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! NPCase Nom} ;

}
