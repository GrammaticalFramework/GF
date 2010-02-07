concrete VerbUrd of Verb = CatUrd ** open ResUrd in {

  flags optimize=all_subs ;

  lin
    UseV  v = predV v   ;
    SlashV2a v = predV v ** {c2 = v.c2} ;
    Slash2V3 v np = 
      insertObjc (\\_ => np.s ! NPObj ++ v.c3 ) (predV v ** {c2 = {s = v.c2 ; c = VTrans}}) ;
    Slash3V3 v np = 
      insertObjc (\\_ => np.s ! NPC Obl ++ v.c2) (predV v ** {c2 = {s = v.c3 ; c = VTrans}}) ; 
	  
    ComplVV v vp = insertObj (\\a => infVP v.isAux vp a) (predV v) ;
    ComplVS v s  = insertObj (\\_ => conjThat ++ s.s) (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;
    ComplVA v ap = insertObj (\\a => ap.s ! giveNumber a ! giveGender a ! Dir ! Posit) (predV v) ;
    SlashV2V v vp = insertObjc (\\a => infVP v.isAux vp a) (predVc v) ;
    SlashV2S v s  = insertObjc (\\_ => conjThat ++ s.s) (predV v ** {c2 = {s = "" ; c = VTrans}}) ;
    SlashV2Q v q  = insertObjc (\\_ => conjThat ++ q.s ! QIndir) (predV v ** {c2 = {s = "" ; c = VTrans}}) ;
    SlashV2A v ap = insertObjc (\\a => ap.s ! giveNumber a ! giveGender a ! Dir ! Posit) (predV v ** {c2 = {s = "kw" ; c = VTrans}}) ; ----
    ComplSlash vp np = insertObject np vp ;
    SlashVV vv vp = 
      insertObj (\\a => infVP vv.isAux vp a) (predV vv) **
        {c2 = vp.c2} ;
    SlashV2VNP vv np vp = 
      insertObjPre (\\_ =>  np.s ! NPObj  )
        (insertObjc (\\a => infVP vv.isAux vp a) (predVc vv)) **
          {c2 = vp.c2} ;
    UseComp comp = insertObj comp.s (predAux auxBe) ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    AdVVP adv vp = insertAdV adv.s vp ;
--    ReflVP v = insertObjPre (\\a => v.c2 ++ reflPron ! a) v ;
--    PassV2 v = insertObj (\\_ => v.s ! VPPart) (predAux auxBe) ;

    CompAP ap ={s = \\a => ap.s ! giveNumber a ! giveGender a ! Dir ! Posit } ;
    CompNP np = {s = \\_ => np.s ! NPObj} ;
    CompAdv a = {s = \\_ => a.s} ;


}
