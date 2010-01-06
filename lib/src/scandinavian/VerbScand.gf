incomplete concrete VerbScand of Verb = CatScand ** open CommonScand, ResScand in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {n3 = \\_ => [] ; c2 = v.c2} ;

    Slash2V3 v np = 
      insertObj (\\_ => v.c2.s ++ np.s ! accusative) (predV v) ** 
        {n3 = \\_ => [] ; c2 = v.c3} ;  -- to preserve the order of args
    Slash3V3 v np = predV v ** {
      n3 = \\_ => v.c3.s ++ np.s ! accusative ; 
      c2 = v.c2
      } ;

    ComplVV v vp = insertObj (\\a => v.c2.s ++ infVP vp a) (predV v) ;
    ComplVS v s  = insertObj (\\_ => conjThat ++ s.s ! Sub) (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;
    ComplVA  v ap = insertObj (\\a => ap.s ! agrAdjNP a DIndef) (predV v) ;

    SlashV2V v vp = predV v ** {
      n3 = \\a => v.c3.s ++ infVP vp a ; 
      c2 = v.c2
      } ;
    SlashV2S v s = predV v ** {
      n3 = \\_ => conjThat ++ s.s ! Sub ;
      c2 = v.c2
      } ; 
    SlashV2Q v q = predV v ** {
      n3 = \\_ => q.s ! QIndir ;
      c2 = v.c2
      } ;
    SlashV2A v ap = predV v ** {
      n3 = \\a => ap.s ! agrAdjNP a DIndef ;
      c2 = v.c2
      } ; 

    ComplSlash vp np = 
       insertObj 
         (\\_ => vp.c2.s ++ np.s ! accusative ++ vp.n3 ! np.a) vp ;

    SlashVV v vp = 
      insertObj (\\a => v.c2.s ++ infVP vp a) (predV v) ** {n3 = vp.n3 ; c2 = vp.c2} ;

    SlashV2VNP v np vp = 
      insertObj 
        (\\a => v.c2.s ++ np.s ! accusative ++ v.c3.s ++ infVP vp a) (predV v) 
        ** {n3 = vp.n3 ; c2 = v.c2} ;

    UseComp comp = insertObj 
      (\\a => comp.s ! agrAdjNP a DIndef) (predV verbBe) ;

    CompAP ap = ap ;
    CompNP np = {s = \\_ => np.s ! accusative} ;
    CompAdv a = {s = \\_ => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdV adv.s vp ;


    ReflVP vp = insertObj (\\a => vp.c2.s ++ reflPron a ++ vp.n3 ! a) vp ;

    PassV2 v = 
      insertObj 
        (\\a => v.s ! VI (VPtPret (agrAdjNP a DIndef) Nom)) 
        (predV verbBecome) ;

}
