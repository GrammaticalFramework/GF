concrete PhraseChi of Phrase = CatChi ** open Prelude, ResChi in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = qs ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p} ; --- add politeness here?

    UttIP ip = ip ;
    UttIAdv iadv = iadv ;
    UttNP np = np ;
    UttCN cn = cn ;
    UttAP ap = ap ;
    UttCard x = x ;
    UttVP vp = ss (infVP vp) ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = ss (conj.s ! CSent).s2 ;

    NoVoc = {s = []} ;
    VocNP np = {s = np.s} ; ---- ??

}
