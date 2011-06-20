concrete VerbNep of Verb = CatNep ** open ResNep in {

  flags coding = utf8;
  flags optimize=all_subs ;

  lin
    UseV  v = predV v ;
    
    ComplVV v vp = insertTrans (insertVV (infVV vp) (predV v) vp.embComp vp) vp.subj ;       
    
    ComplVS v s  = insertTrans (insertObj2 (conjThat ++ s.s) (predV v)) VTransPost ;   
    
    ComplVQ v q  = insertObj2 (conjThat ++ q.s ! QIndir) (predV v) ;
    
    ComplVA v ap = insertObj (\\a => ap.s ! giveNumber a ! giveGender a) (predV v) ;
    
    
    
    SlashV2a v = predV v ** {c2 = {s = v.c2.s ; c = VTrans}} ;    
    -- use of these two functions
    Slash2V3 v np = 
      insertObjc (\\_ => np.s ! NPC Acc ++ v.c3 ) (predV v ** {c2 = {s = v.c2 ; c = VTrans}}) ; -- NEEDS CHECKING

    Slash3V3 v np = 
      insertObjc (\\_ => np.s ! NPC Acc ++ v.c3) (predV v ** {c2 = {s = v.c2 ; c = VTrans}}) ; 

                                
    -- Check for the use of 'Acc' case of noun instead of adding 'lai' and 'sanga' later
    SlashV2V v vp = insertVV (infV2V vp) (predV v) vp.embComp vp ** {c2 = {s = v.c1 ; c = VTrans}} ; 
    
    SlashV2S v s  = insertObjc2 (conjThat ++ s.s) (predV v ** {c2 = {s = "लाई" ; c = VTransPost}}) ;
    
    SlashV2Q v q  = insertObjc2 (conjThat ++ q.s ! QIndir) (predV v ** {c2 = {s = "सँग" ; c = VTransPost}}) ; 
      
    SlashV2A v ap = insertObjc (\\a => ap.s ! giveNumber a ! giveGender a  ) (predV v ** {c2 = {s = v.c2.s ; c = VTrans}}) ; 
    
    
    
    ComplSlash vp np = insertObject np vp ;
    
    
    SlashVV vv vp = 
      insertEmbCompl (insertObj (infVP vv.isAux vp).s (predV vv)) vp.embComp **
        {c2 = vp.c2} ;
    
    SlashV2VNP vv np vp = 
      insertObjPre (\\_ => np.s ! NPObj  )
        (insertObjc (infVP vv.isAux vp).s (predVc vv)) **
          {c2 = vp.c2} ;
    
    
    
    ReflVP v = insertObjPre (\\_ => reflPron) v ;
    UseComp comp = insertObj comp.s (predAux comp.t) ;
    
    
    PassV2 v = predV v ; -- need to be fixed
    
    
    AdvVP vp adv = insertObj (\\_ => adv.s ) vp ;

    AdVVP adv vp = insertAdV adv.s vp ;
    
    
    AdvVPSlash vp ad = insertObj (\\_ => ad.s ) vp ** {c2 = vp.c2} ; 
    AdVVPSlash ad vp = insertObj (\\_ => ad.s ) vp ** {c2 = vp.c2} ;    

    
    CompAP ap = {s = \\a => ap.s ! giveNumber a ! giveGender a ; t = NonLiving} ;
    
    CompNP np = {s = \\_ => np.s ! NPObj; t = np.t} ;
    
    CompAdv adv = {s = \\a => adv.s ; t = NonLiving} ;
    
    CompCN cn = {s = \\a => cn.s ! giveNumber a ! Nom ; t = cn.t} ;    
    
}
