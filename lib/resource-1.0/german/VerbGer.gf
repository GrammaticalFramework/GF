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
        compl : Agr => Str = \\a => 
          let 
             vpi = vp.s ! a ! VPInfinit Simul 
          in
          vp.n2 ! a ++  vp.a2 ++ vpi.fin ++ infPart v.isAux ++ vpi.inf 
      in
      insertObj compl (predVGen v.isAux v) ;

    ComplVS v s = 
      insertExtrapos (conjThat ++ s.s ! Sub) (predV v) ;
    ComplVQ v q = 
      insertExtrapos (q.s ! QIndir) (predV v) ;

    ComplVA  v ap = insertObj (\\ _ => ap.s ! APred) (predV v) ;
    ComplV2A v np ap = 
      insertObj (\\_ => appPrep v.c2 np.s ++ ap.s ! APred) (predV v) ;

    UseComp comp = insertObj comp.s (predV sein_V) ;

    CompAP ap = {s = \\_ => ap.s ! APred} ;
    CompNP np = {s = \\_ => np.s ! Nom} ;
    CompAdv a = {s = \\_ => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdV adv.s vp ;

    ReflV2 v = insertObj (\\a => appPrep v.c2 (reflPron ! a)) (predV v) ;

    PassV2 v = insertObj (\\_ => v.s ! VPastPart APred) (predV werdenPass) ;

    UseVS, UseVQ = \v -> v ** {c2 = noPreposition Acc} ;

}
