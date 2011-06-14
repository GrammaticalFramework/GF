concrete VerbNep of Verb = CatNep ** open ResNep in {

  flags coding = utf8;
  flags optimize=all_subs ;

  lin
    UseV  v = predV v   ;

    SlashV2a v = predV v ** {c2 = {s = v.c2.s ; c = VTrans}} ;
    
    -- use of these two functions
    Slash2V3 v np = 
      insertObjc (\\_ => np.s ! NPObj ++ v.c3 ) (predV v ** {c2 = {s = v.c2 ; c = VTrans}}) ; -- NEEDS CHECKING

    Slash3V3 v np = 
      insertObjc (\\_ => np.s ! NPC Nom ++ v.c3) (predV v ** {c2 = {s = v.c2 ; c = VTrans}}) ; 

                                
    ComplVV v vp = insertTrans (insertVV (infVV vp) (predV v) vp.embComp vp) vp.subj ;   
    
    ComplVS v s  = insertTrans (insertObj2 (conjThat ++ s.s) (predV v)) VTransPost ;
   
    ComplVQ v q  = insertObj2 (conjThat ++ q.s ! QIndir) (predV v) ;

    -- Need check for 'bhayo' inflection (past)
    -- cc -all PredVP (MassNP (UseN cat_N)) (ComplVA become_VA (PositA red_A)) 
    ComplVA v ap = insertObj (\\a => ap.s ! giveNumber a ! giveGender a) (predV v) ;
    
    --cc -table PredVP (MassNP (UseN cat_N)) (ComplSlash (SlashV2V beg_V2V (UseV sleep_V)) (MassNP (UseN dog_N))) 
    SlashV2V v vp = insertVV (infV2V vp) (predV v) vp.embComp vp ** {c2 = {s = v.c1 ; c = VTrans}} ; -- should creat a form at VP level which can be used in VP like 'swn da kyna' also check the c=VTransPost it is correct in case if second v is intrasitive, but not if trans like begged me to ead bread
    
    SlashV2S v s  = insertObjc2 (conjThat ++ s.s) (predV v ** {c2 = {s = "लाई" ; c = VTransPost}}) ;
    
    SlashV2Q v q  = insertObjc2 (conjThat ++ q.s ! QIndir) (predV v ** {c2 = {s = "सँग" ; c = VTransPost}}) ; -- chek for VTransPost, as in this case , case should be ergative but agrement should be default
    
    -- cc -table PredVP (MassNP (UseN cat_N)) (ComplSlash (SlashV2A paint_V2A (PositA red_A)) (MassNP (UseN dog_N)))
    SlashV2A v ap = insertObjc (\\a => ap.s ! giveNumber a ! giveGender a  ) (predV v ** {c2 = {s = v.c2.s ; c = VTrans}}) ; 
    
    ComplSlash vp np = insertObject np vp ;
    
    SlashVV vv vp = 
      insertEmbCompl (insertObj (infVP vv.isAux vp).s (predV vv)) vp.embComp **
        {c2 = vp.c2} ;
    
    SlashV2VNP vv np vp = 
      insertObjPre (\\_ => np.s ! NPObj  )
        (insertObjc (infVP vv.isAux vp).s (predVc vv)) **
          {c2 = vp.c2} ;
    
    -- cc -table PredVP (MassNP (UseN cat_N)) (UseComp (CompAdv there_Adv))
    UseComp comp = insertObj comp.s (predAux auxBe) ;
    
    -- cc -table PredVP (MassNP (UseN cat_N)) (AdvVP (UseV sleep_V) there_Adv)
    AdvVP vp adv = insertObj (\\_ => adv.s ) vp ;
    
    -- cc -table PredVP (MassNP (UseN cat_N)) (AdVVP always_AdV (UseV sleep_V)) 
    AdVVP adv vp = insertAdV adv.s vp ;
    
    -- cc -table PredVP (MassNP (UseN cat_N)) (ReflVP (SlashV2a eat_V2))
    ReflVP v = insertObjPre (\\_ => reflPron) v ;
    
    PassV2 v = predV v ; -- need to be fixed
    
    CompAP ap = {s = \\a => ap.s ! giveNumber a ! giveGender a } ;
    
    CompNP np = {s = \\_ => np.s ! NPObj} ;
    CompCN cn = {s = \\a => cn.s ! giveNumber a ! Nom} ;
    
    -- cc -table PredVP (MassNP (UseN cat_N)) (UseComp (CompAdv there_Adv)) 
    CompAdv adv = {s = \\a => adv.s } ;
    

}
