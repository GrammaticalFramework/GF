concrete VerbEng of Verb = CatEng ** open ResEng in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predVc v ;
    Slash2V3 v np = 
      insertObjc (\\_ => v.c2 ++ np.s ! Acc) (predV v ** {c2 = v.c3}) ;
    Slash3V3 v np = 
      insertObjc (\\_ => v.c3 ++ np.s ! Acc) (predVc v) ; ----

    ComplVV v vp = insertObj (\\a => infVP v.isAux vp a) (predVV v) ;
    ComplVS v s  = insertObj (\\_ => conjThat ++ s.s) (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;
    ComplVA v ap = insertObj (ap.s) (predV v) ;

    SlashV2V v vp = insertObjc (\\a => infVP v.isAux vp a) (predVc v) ;
    SlashV2S v s  = insertObjc (\\_ => conjThat ++ s.s) (predVc v) ;
    SlashV2Q v q  = insertObjc (\\_ => q.s ! QIndir) (predVc v) ;
    SlashV2A v ap = insertObjc (\\a => ap.s ! a) (predVc v) ; ----

    ComplSlash vp np = insertObjPre (\\_ => vp.c2 ++ np.s ! Acc) vp ;

    SlashVV vv vp = 
      insertObj (\\a => infVP vv.isAux vp a) (predVV vv) **
        {c2 = vp.c2} ;
    SlashV2VNP vv np vp = 
      insertObjPre (\\_ => v.c2 ++ np.s ! Acc)
        (insertObjc (\\a => infVP vv.isAux vp a) (predVc vv)) **
          {c2 = vp.c2} ;

    UseComp comp = insertObj comp.s (predAux auxBe) ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    AdVVP adv vp = insertAdV adv.s vp ;

    ReflVP v = insertObjPre (\\a => v.c2 ++ reflPron ! a) v ;

    PassV2 v = insertObj (\\_ => v.s ! VPPart) (predAux auxBe) ;

---b    UseVS, UseVQ = \vv -> {s = vv.s ; c2 = [] ; isRefl = vv.isRefl} ; -- no "to"

    CompAP ap = ap ;
    CompNP np = {s = \\_ => np.s ! Acc} ;
    CompAdv a = {s = \\_ => a.s} ;

}
