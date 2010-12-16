--concrete PhraseUrd of Phrase = CatUrd ** open Prelude, ResUrd in {
incomplete concrete PhraseHindustani of Phrase = 
  CatHindustani ** open CommonHindustani, ResHindustani, Prelude in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Sg False} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Pl False} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Sg True} ;

    UttIP ip = {s = ip.s ! Dir} ; --- Acc also
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! NPC Dir} ;
    UttVP vp = {s = vp.ad ++ infVP False vp (agrP3 Masc Sg) ++ vp.embComp} ;
    UttAdv adv = {s = adv.s ! Masc} ;
	UttCN cn = {s = cn.s ! Sg ! Dir};
    UttCard n = n ;
    UttAP ap = {s = ap.s ! Sg ! Masc ! Dir ! Posit} ;

    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s2} ; ---

    NoVoc = {s = []} ;
    VocNP np = {s = np.s ! NPC Dir} ;

}
