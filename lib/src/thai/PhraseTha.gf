concrete PhraseTha of Phrase = CatTha ** open Prelude, ResTha in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++bIND++ utt.s ++bIND++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++bIND++ imp.s ! pol.p} ;
    UttImpPl pol imp = {s = pol.s ++bIND++ imp.s ! pol.p} ;
    UttImpPol pol imp = {s = pol.s ++bIND++ imp.s ! pol.p} ; --- add politeness here?

    UttIP ip = ip ;
    UttIAdv iadv = iadv ;
    UttNP np = np ;
    UttCN cn = cn ;
    UttAP ap = ap ;
    UttCard x = x ;
    UttVP vp = {s = vp.s ! Pos ++bIND++ vp.e} ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = ss conj.s2 ;

    NoVoc = {s = []} ;
    VocNP np = {s = np.s} ; ---- ??

}
