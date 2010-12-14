concrete PhraseIna of Phrase = CatIna ** open Prelude, ResIna in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! OQuest};
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! Sg} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl} ;

    UttIP ip = {s = ip.s ! Nom} ; -- ??? Dat, Abl also... 
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! Nom} ;
    UttVP vp = {s = infVP vp} ;
    UttAdv adv = adv ;

    UttCN n = {s = n.s ! Sg} ;
    UttCard n = {s = n.s} ;
    UttAP ap = {s = ap.s ! agrP3 Sg} ;
    UttInterj i = i ;

    NoPConj = {s = []} ;
    PConjConj conj = ss conj.s2 ;
    
    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! Nom} ;

}
