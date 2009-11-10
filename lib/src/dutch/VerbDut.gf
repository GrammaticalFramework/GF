concrete VerbDut of Verb = CatDut ** open Prelude, ResDut in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    ComplVV v vp = 
      let 
        vpi = infVP v.isAux vp 
      in
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 (
            predVGen v.isAux {s = v.s ; aux = v.aux ; prefix = v.prefix ; vtype = v.vtype}))) ; ---- subtyp

--    ComplVS v s = 
--      insertExtrapos (conjThat ++ s.s ! Sub) (predV v) ;
--    ComplVQ v q = 
--      insertExtrapos (q.s ! QIndir) (predV v) ;
--    ComplVA  v ap = insertObj (\\ _ => ap.s ! APred) (predV v) ;
--
    SlashV2a v = predV {s = v.s ; aux = v.aux ; prefix = v.prefix ; vtype = v.vtype} ** {c2 = v.c2} ; 
--      
--    Slash2V3 v np =
--      insertObj (\\_ => appPrep v.c2 np.s) (predV v) ** {c2 = v.c3} ;
--    Slash3V3 v np =
--      insertObj (\\_ => appPrep v.c3 np.s) (predV v) ** {c2 = v.c2} ;
--
--    SlashV2S v s = 
--      insertExtrapos (conjThat ++ s.s ! Sub) (predV v) ** {c2 = v.c2} ;
--    SlashV2Q v q = 
--      insertExtrapos (q.s ! QIndir) (predV v) ** {c2 = v.c2} ;
--    SlashV2V v vp = 
--      let 
--        vpi = infVP False vp 
--      in
--      insertExtrapos vpi.p3 (
--        insertInf vpi.p2 (
--          insertObj vpi.p1 ((predV v)))) ** {c2 = v.c2} ;
--
--    SlashV2A v ap = 
--      insertObj (\\_ => ap.s ! APred) (predV v) ** {c2 = v.c2} ;
--
    ComplSlash vp np = insertObj (\\_ => appPrep vp.c2 np.s) vp ;
--
--    SlashVV v vp = 
--      let 
--        vpi = infVP v.isAux vp 
--      in
--      insertExtrapos vpi.p3 (
--        insertInf vpi.p2 (
--          insertObj vpi.p1 (
--            predVGen v.isAux v))) ** {c2 = vp.c2} ;
--
--    SlashV2VNP v np vp = 
--      let 
--        vpi = infVP False vp 
--      in
--      insertExtrapos vpi.p3 (
--        insertInf vpi.p2 (
--          insertObj vpi.p1 (
--            insertObj (\\_ => appPrep v.c2 np.s) (
--              predV v)))) ** {c2 = v.c2} ;
--
    UseComp comp = insertAdv (comp.s ! agrP3 Sg) (predV zijn_V) ; -- agr not used
    CompAP ap = {s = \\_ => ap.s ! APred} ;
--    CompNP np = {s = \\_ => np.s ! Nom} ;
    CompAdv a = {s = \\_ => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
--    AdVVP adv vp = insertAdV adv.s vp ;
--
--    ReflVP vp = insertObj (\\a => appPrep vp.c2 (reflPron ! a)) vp ;
--
--    PassV2 v = insertInf (v.s ! VPastPart APred) (predV werdenPass) ;
--
-----b    UseVS, UseVQ = \v -> v ** {c2 = noPreposition Acc} ;
--
--}

}
