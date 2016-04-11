concrete PhraseLat of Phrase = CatLat ** open Prelude, ResLat in {
  
  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;
    --
-- UttS : S -> Utt
    UttS s = { s = s.s };

--  UttQS : QS -> Utt
    UttQS qs = {s = qs.s ! QDir } ;

--    UttImpSg pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Sg False} ;
--    UttImpPl pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Pl False} ;
--    UttImpPol pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Sg True} ;
--
--    UttIP ip = {s = ip.s ! Nom} ; --- Acc also
--    UttIAdv iadv = iadv ;
--    UttNP np = {s = np.s ! Nom} ;
--    UttVP vp = {s = infVP False vp (agrP3 Sg)} ;
--    UttAdv adv = adv ;
--
    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s2} ; ---
--
    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! ResLat.Voc} ; ---- what is the compiler error here? AR 1/2/2014 -- answer: clash with the type name Voc 3/2
--
}
