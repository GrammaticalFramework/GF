incomplete concrete VerbScand of Verb = CatScand ** open CommonScand, ResScand in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {c2 = v.c2} ;

    Slash2V3 v np = 
      insertObj (\\_ => v.c2 ++ np.s ! accusative) (predV v) ** {c2 = v.c3} ;
    Slash3V3 v np = 
      insertObj (\\_ => v.c3 ++ np.s ! accusative) (predV v) ** {c2 = v.c2} ;

    ComplVV v vp = insertObj (\\a => v.c2 ++ infVP vp a) (predV v) ;
    ComplVS v s  = insertObj (\\_ => conjThat ++ s.s ! Sub) (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;
    ComplVA  v ap = insertObj (\\a => ap.s ! agrAdj a.gn DIndef) (predV v) ;

    SlashV2V v vp = 
      insertObj (\\a => v.c3 ++ infVP vp a) (predV v) ** {c2 = v.c2} ;
    SlashV2S v s = 
      insertObj (\\_ => conjThat ++ s.s ! Sub) (predV v) ** {c2 = v.c2} ;
    SlashV2Q v q = 
      insertObj (\\_ => q.s ! QIndir) (predV v) ** {c2 = v.c2} ;
    SlashV2A v ap = 
      insertObj 
        (\\a => ap.s ! agrAdj a.gn DIndef) (predV v) ** {c2 = v.c2} ; ---- agr to obj

    ComplSlash vp np = insertObj (\\_ => vp.c2 ++ np.s ! accusative) vp ;

    SlashVV v vp = 
      insertObj (\\a => v.c2 ++ infVP vp a) (predV v) ** {c2 = vp.c2} ;
    SlashV2VNP v np vp = 
      insertObj 
        (\\a => vp.c2 ++ np.s ! accusative ++ v.c3 ++ infVP vp a) (predV v) 
        ** {c2 = v.c2} ;

    UseComp comp = insertObj (\\a => comp.s ! agrAdj a.gn DIndef) (predV verbBe) ;

    CompAP ap = ap ;
    CompNP np = {s = \\_ => np.s ! accusative} ;
    CompAdv a = {s = \\_ => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdV adv.s vp ;


    ReflVP vp = insertObj (\\a => vp.c2 ++ reflPron a) vp ;

    PassV2 v = 
      insertObj 
        (\\a => v.s ! VI (VPtPret (agrAdj a.gn DIndef) Nom)) 
        (predV verbBecome) ;

}
