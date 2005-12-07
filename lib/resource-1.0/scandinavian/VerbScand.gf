incomplete concrete VerbScand of Verb = CatScand ** open DiffScand, ResScand in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;
    ComplV2 v np = insertObj (\\_ => v.c2 ++ np.s ! accusative) (predV v) ;
    ComplV3 v np np2 = 
      insertObj (\\_ => v.c2 ++ np.s ! accusative ++ v.c3 ++ np2.s ! accusative) (predV v) ;

    ComplVV v vp = insertObj (\\a => v.c2 ++ infVP vp a) (predV v) ;
    ComplVS v s  = insertObj (\\_ => conjThat ++ s.s ! Sub) (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;

    ComplVA  v ap = 
      insertObj (\\a => ap.s ! agrAdj a.gn DIndef) (predV v) ;
    ComplV2A v np ap = 
      insertAdv
        (ap.s ! agrAdj np.a.gn DIndef)
        (insertObj (\\_ => v.c2 ++ np.s ! accusative) (predV v)) ;

    UseComp comp = insertObj (\\a => comp.s ! agrAdj a.gn DIndef) (predV verbBe) ;

    CompAP ap = ap ;
    CompNP np = {s = \\_ => np.s ! accusative} ;
    CompAdv a = {s = \\_ => a.s} ;

--- these give parser overflow
---    AdvVP vp adv = insertAdv adv.s vp ;
---    AdVVP adv vp = insertAdV adv.s vp ;

{-
    ReflV2 v = insertObj (\\a => v.c2 ++ reflPron ! a) (predV v) ;

    PassV2 v = {s = \\_ => v.s ! VPPart} ;
-}

    UseVV, UseVS, UseVQ = \vv -> {s = vv.s ; c2 = []} ;

    EmbedS  s  = {s = conjThat ++ s.s ! Sub} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = infVP vp (agrP3 utrum Sg)} ; --- agr

}
