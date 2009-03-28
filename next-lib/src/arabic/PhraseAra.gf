concrete PhraseAra of Phrase = CatAra ** open 
  ParamX, 
  Prelude, 
  ResAra in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ! Masc ++ voc.s} ;--FIXME

    UttS s = {s = \\g => s.s} ; ---- OK? AR

    UttIAdv s = {s = \\g => s.s} ; ---- OK? AR

    UttQS qs = {s = \\g => qs.s ! QDir} ;
    UttImpSg pol imp = {s = \\g => imp.s ! pol.p ! g ! ResAra.Sg} ;
--    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl} ;
--
    UttIP ip = {s = \\_ => ip.s} ; ---- AR
--    UttIAdv iadv = iadv ;
    UttNP np = {s = \\_ => np.s ! Nom} ;
--    UttVP vp = {s = infVP False vp (agrP3 Sg)} ;
    UttAdv adv = {s = \\_ => adv.s} ;
--
    NoPConj = {s = []} ;
--    PConjConj conj = conj ;
--
    NoVoc = {s = []} ;
--    VocNP np = {s = "،" ++ np.s ! Nom} ;
--
}
