concrete VerbGer of Verb = CatGer ** open ResGer in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;
    ComplV2 v np = 
      insertObj (\\_ => appPrep v.c2 np.s) (predV v) ;
    ComplV3 v np np2 =
      insertObj (\\_ => appPrep v.c2 np.s ++ appPrep v.c3 np2.s) (predV v) ;

    ComplVV v vp = 
      insertObj (\\a => v.part ++ (vp.s ! a ! VPInfinit Simul).inf) (predV v) ;
    ComplVS v s = 
      insertExtrapos (conjThat ++ s.s ! Sub) (predV v) ;

--    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;
--
--    ComplVA  v    ap = insertObj (ap.s) (predV v) ;
--    ComplV2A v np ap = 
--      insertObj (\\_ => v.c2 ++ np.s ! Acc ++ ap.s ! np.a) (predV v) ;
--

    UseComp comp = insertObj comp.s (predV sein_V) ;

    CompAP ap = {s = \\_ => ap.s ! APred} ;
    CompNP np = {s = \\_ => np.s ! Nom} ;
    CompAdv a = {s = \\_ => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
--    AdVVP adv vp = insertAdV adv.s vp ;
--
--    ReflV2 v = insertObj (\\a => v.c2 ++ reflPron ! a) (predV v) ;
--
--    PassV2 v = {s = \\_ => v.s ! VPPart} ;

    UseVV, UseVS, UseVQ = \v -> v ** {c2 = noPreposition Acc} ;

--    EmbedS  s  = {s = conjThat ++ s.s} ;
--    EmbedQS qs = {s = qs.s ! QIndir} ;
--    EmbedVP vp = {s = infVP vp (agrP3 Sg)} ; --- agr
--
}
