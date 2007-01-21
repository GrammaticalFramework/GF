concrete PhraseTha of Phrase = CatTha ** open Prelude, ResTha in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p} ; --- add politeness here?

    UttIP ip = ip ;
    UttIAdv iadv = iadv ;
    UttNP np = np ;
    UttVP vp = {s = vp.s ! Pos} ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = conj ;

    NoVoc = {s = []} ;
    VocNP np = {s = np.s} ; ---- ??

}
