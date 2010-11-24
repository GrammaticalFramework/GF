--concrete VerbUrd of Verb = CatUrd ** open ResUrd in {
incomplete concrete VerbHindustani of Verb = CatHindustani ** open CommonHindustani, ResHindustani, StringsHindustani in {

  flags optimize=all_subs ;

  lin
    UseV  v = predV v   ;
    SlashV2a v = predV v ** {c2 = {s = v.c2.s ; c = VTrans}} ;
    Slash2V3 v np = 
      insertObjc (\\_ => np.s ! NPObj ++ v.c3 ) (predV v ** {c2 = {s = v.c2 ; c = VTrans}}) ;
    Slash3V3 v np = 
      insertObjc (\\_ => np.s ! NPC Obl ++ v.c2) (predV v ** {c2 = {s = v.c3 ; c = VTrans}}) ; 
    ComplVV v vp = insertTrans (insertVV (infVV v.isAux vp) (predV v) vp.embComp ) VTransPost;
    ComplVS v s  = insertTrans (insertObj2 (conjThat ++ s.s) (predV v)) VTransPost ;
    ComplVQ v q  = insertObj2 (conjThat ++ q.s ! QIndir) (predV v) ;
    ComplVA v ap = insertObj (\\a => ap.s ! giveNumber a ! giveGender a ! Dir ! Posit) (predV v) ;
    SlashV2V v vp = insertVV (infV2V v.isAux vp) (predV v) vp.embComp **{c2 = {s = sE ; c = VTransPost}} ;
    SlashV2S v s  = insertObjc2 (conjThat ++ s.s) (predV v ** {c2 = {s = kw ; c = VTransPost}}) ;
    SlashV2Q v q  = insertObjc2 (conjThat ++ q.s ! QIndir) (predV v ** {c2 = {s = sE ; c = VTransPost}}) ;
    SlashV2A v ap = insertObjc (\\a => ap.s ! giveNumber a ! giveGender a ! Dir ! Posit) (predV v ** {c2 = {s = kw ; c = VTransPost}}) ; ----
    ComplSlash vp np = insertObject np vp ;
    SlashVV vv vp = 
      insertEmbCompl (insertObj (\\a => infVP vv.isAux vp a) (predV vv)) vp.embComp **
        {c2 = vp.c2} ;
    SlashV2VNP vv np vp = 
      insertObjPre (\\_ =>  np.s ! NPObj  )
        (insertObjc (\\a => infVP vv.isAux vp a) (predVc vv)) **
          {c2 = vp.c2} ;
    UseComp comp = insertObj comp.s (predAux auxBe) ;

    AdvVP vp adv = insertObj (\\a => adv.s ! giveGender a) vp ;

    AdVVP adv vp = insertAdV adv.s vp ;
    ReflVP v = insertObjPre (\\_ =>  RefPron) v ;
    PassV2 v = predV v ; -- need to be fixed
    CompAP ap ={s = \\a => ap.s ! giveNumber a ! giveGender a ! Dir ! Posit } ;
    CompNP np = {s = \\_ => np.s ! NPObj} ;
    CompAdv adv = {s = \\a => adv.s ! giveGender a} ;


}
