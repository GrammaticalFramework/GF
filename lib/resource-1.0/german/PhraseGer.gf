concrete PhraseGer of Phrase = CatGer ** open Prelude, ResGer in {

  flags optimize=all_subs ;

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = {s = s.s ! Main} ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! Sg} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl} ;

    UttIP ip = {s = ip.s ! Nom} ; --- Acc also
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! Acc} ;
    UttVP vp = 
      let 
        vpi = vp.s ! agrP3 Sg ! VPInfinit Simul --- agr 
      in
      ss (vp.n2 ! agrP3 Sg ++ vp.a2 ++ vpi.fin ++ infPart False ++ vpi.inf) ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = conj ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! Nom} ;

}
