concrete VerbGer of Verb = CatGer ** open Prelude, ResGer in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;
    ComplV2 v np = 
      insertObj (\\_ => appPrep v.c2 np.s) (predV v) ;
    ComplV3 v np np2 =
      insertObj (\\_ => appPrep v.c2 np.s ++ appPrep v.c3 np2.s) (predV v) ;

    ComplVV v vp = 
      let 
        vpi = infVP v.isAux vp 
      in
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 (
            predVGen v.isAux v))) ;

    ComplVS v s = 
      insertExtrapos (conjThat ++ s.s ! Sub) (predV v) ;
    ComplVQ v q = 
      insertExtrapos (q.s ! QIndir) (predV v) ;

    ComplVA  v ap = insertObj (\\ _ => ap.s ! APred) (predV v) ;
    ComplV2A v np ap = 
      insertObj (\\_ => appPrep v.c2 np.s ++ ap.s ! APred) (predV v) ;

    UseComp comp = insertAdv (comp.s ! agrP3 Sg) (predV sein_V) ; -- agr not used
    -- we want to say "ich liebe sie nicht" but not "ich bin alt nicht"

    CompAP ap = {s = \\_ => ap.s ! APred} ;
    CompNP np = {s = \\_ => np.s ! Nom} ;
    CompAdv a = {s = \\_ => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdV adv.s vp ;

    ReflV2 v = insertObj (\\a => appPrep v.c2 (reflPron ! a)) (predV v) ;

    PassV2 v = insertObj (\\_ => v.s ! VPastPart APred) (predV werdenPass) ;

    UseVS, UseVQ = \v -> v ** {c2 = noPreposition Acc} ;

}
