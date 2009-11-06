concrete PhraseDut of Phrase = CatDut ** open Prelude, ResDut in 
{


  flags optimize=all_subs ;

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = {s = s.s ! Main} ;
    UttQS qs = {s = qs.s ! QDir} ;
--    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg False} ;
--    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Pl False} ;
--    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg True} ;
--
--    UttIP ip = {s = ip.s ! Nom} ; --- Acc also
--    UttIAdv iadv = iadv ;
--    UttNP np = {s = np.s ! Nom} ;
--    UttVP vp = {s = useInfVP True vp} ;  -- without zu
--    UttAdv adv = adv ;
--
    NoPConj = {s = []} ;
--    PConjConj conj = ss (conj.s2) ;
--
    NoVoc = {s = []} ;
--    VocNP np = {s = "," ++ np.s ! Nom} ;
--
--}

}
