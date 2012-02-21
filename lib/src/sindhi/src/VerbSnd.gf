concrete VerbSnd of Verb = CatSnd ** open ResSnd in {

  flags coding = utf8;
  flags optimize=all_subs ;

  lin
    UseV  v = predV v   ;
    SlashV2a v = predV v ** {c2 = {s = v.c2.s ; c = VTrans}} ;
    Slash2V3 v np = 
      insertObjc (\\_ => np.s ! NPObj ++ v.c3 ) (predV v ** {c2 = {s = v.c2 ; c = VTrans}}) ;
   
    Slash3V3 v np = 
      insertObjc (\\_ => checkPron np v.c2) (predV v ** {c2 = {s = v.c3 ; c = VTrans}}) ; 
                                
    ComplVV v vp = insertTrans (insertVV (infVV v.isAux vp) (predV v) vp.embComp vp) vp.subj; 
    ComplVS v s  = insertTrans (insertObj2 (conjThat ++ s.s) (predV v)) VTransPost ;
    ComplVQ v q  = insertObj2 (conjThat ++ q.s ! QIndir) (predV v) ;
    ComplVA v ap = insertObj (\\a => ap.s ! giveNumber a ! giveGender a ! Dir ) (predV v) ;
    SlashV2V v vp = insertVV (infV2V v.isAux vp) (predV v) vp.embComp vp **{c2 = {s = "twN" ; c = VTransPost}} ; -- should creat a form at VP level which can be used in VP like 'swn da kyna' also check the c=VTransPost it is correct in case if second v is intrasitive, but not if trans like begged me to ead bread
    SlashV2S v s  = insertObjc2 (conjThat ++ s.s) (predV v ** {c2 = {s = "k'y" ; c = VTransPost}}) ;
    SlashV2Q v q  = insertObjc2 (conjThat ++ q.s ! QIndir) (predV v ** {c2 = {s = "k'an" ; c = VTransPost}}) ; -- chek for VTransPost, as in this case , case should be ergative but agrement should be default
    SlashV2A v ap = insertObjc (\\a => ap.s ! giveNumber a ! giveGender a ! Dir ) (predV v ** {c2 = {s = "k'y" ; c = VTransPost}}) ; ----
    ComplSlash vp np = insertObject np vp ;
    SlashVV vv vp = 
      insertEmbCompl (insertObj (\\a => infVP vv.isAux vp a) (predV vv)) vp.embComp **
        {c2 = vp.c2} ;
    SlashV2VNP vv np vp = 
      insertObjPre (\\_ =>  np.s ! NPObj  )
        (insertObjc (\\a => infVP vv.isAux vp a) (predVc vv)) **
          {c2 = vp.c2} ;
    UseComp comp = insertObj comp.s (predAux auxBe) ;

    AdvVP vp adv = insertObj (\\a => adv.s ! (fromAgr a).g) vp ;

    AdVVP adv vp = insertAdV adv.s vp ;
    ReflVP v = insertObjPre (\\_ =>  RefPron) v ;
    PassV2 v = predV v ; -- need to be fixed
    CompAP ap ={s = \\a => ap.s ! giveNumber a ! giveGender a ! Dir } ;
    CompNP np = {s = \\_ => np.s ! NPObj} ;
    CompAdv adv = {s = \\a => adv.s ! (fromAgr a).g } ;
    CompCN cn = {s = \\a => cn.s ! giveNumber a ! Dir} ;


}
