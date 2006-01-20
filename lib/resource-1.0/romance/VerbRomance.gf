incomplete concrete VerbRomance of Verb = 
  CatRomance ** open CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    ComplV2 v np = insertObject v.c2 np (predV v) ;

    ComplV3 v np np2 = insertObject v.c3 np2 (insertObject v.c2 np (predV v)) ;

{-
    ComplVV v vp = insertObj (\\a => v.c2 ++ infVP vp a) (predV v) ;
    ComplVS v s  = insertObj (\\_ => conjThat ++ s.s ! Sub) (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;

    ComplVA  v ap = 
      insertObj (\\a => ap.s ! agrAdj a.gn DIndef) (predV v) ;
    ComplV2A v np ap = 
      insertAdv
        (ap.s ! agrAdj np.a.gn DIndef)
        (insertObj (\\_ => v.c2 ++ np.s ! accusative) (predV v)) ;
-}

    UseComp comp = insertComplement comp.s (predV copula) ;

    CompAP ap = {s = \\ag => ap.s ! AF ag.g ag.n} ;
    CompNP np = {s = \\_  => np.s ! Ton Acc} ;
    CompAdv a = {s = \\_  => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdv adv.s vp ;

{-
    ReflV2 v = insertObj (\\a => v.c2 ++ reflPron a) (predV v) ;

    PassV2 v = 
      insertObj 
        (\\a => v.s ! VI (VPtPret (agrAdj a.gn DIndef) Nom)) 
        (predV verbBecome) ;

    UseVS, UseVQ = \vv -> {s = vv.s ; c2 = [] ; vtype = vv.vtype} ;
-}

}
