concrete IdiomJpn of Idiom = CatJpn ** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin

    ImpersCl vp = case vp.needSubject of {
      True => {
        s = table {
          Wa => \\st,t,p => vp.prepositive ! st ++ "これは" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.verb ! SomeoneElse ! Inanim ! st ! t ! p ;
          Ga => \\st,t,p => vp.prepositive ! st ++ "これが" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.verb ! SomeoneElse ! Inanim ! st ! t ! p  
          } ;
        te = table {
          Wa => \\st,p => vp.prepositive ! st ++ "これは" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! SomeoneElse ! Inanim ! st ! p ;
          Ga => \\st,p => vp.prepositive ! st ++ "これが" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! SomeoneElse ! Inanim ! st ! p
          } ; 
        ba = table {
          Wa => \\st,p => vp.prepositive ! st ++ "これは" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.ba ! SomeoneElse ! Inanim ! st ! p ;
          Ga => \\st,p => vp.prepositive ! st ++ "これが" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.ba ! SomeoneElse ! Inanim ! st ! p
          } ;
        subj = table {
          Wa => \\st => vp.prepositive ! st ++ "これは" ;
          Ga => \\st => vp.prepositive ! st ++ "これが" 
          } ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! SomeoneElse ! Inanim ! st ! t ! p ;
        pred_te = \\st,p => vp.obj ! st ++ vp.prep ++ vp.te ! SomeoneElse ! Inanim ! st ! p ;
        pred_ba = \\st,p => vp.obj ! st ++ vp.prep ++ vp.ba ! SomeoneElse ! Inanim ! st ! p ;
        changePolar = False
        } ;
      False => {
        s = \\part,st,t,p => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                             vp.verb ! SomeoneElse ! Inanim ! st ! t ! p ;
        te = \\part,st,p => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                            vp.te ! SomeoneElse ! Inanim ! st ! p ; 
        ba = \\part,st,p => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                            vp.ba ! SomeoneElse ! Inanim ! st ! p ;
        subj = \\part,st => vp.prepositive ! st ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! SomeoneElse ! Inanim ! st ! t ! p ;
        pred_te = \\st,p => vp.obj ! st ++ vp.prep ++ vp.te ! SomeoneElse ! Inanim ! st ! p ;
        pred_ba = \\st,p => vp.obj ! st ++ vp.prep ++ vp.ba ! SomeoneElse ! Inanim ! st ! p ;
        changePolar = False
        } 
      } ;
    
    GenericCl vp = {
      s = \\part,st,t,p => vp.prepositive ! st ++ "誰か" ++ vp.obj ! st ++   -- "dareka"
                           vp.prep ++ vp.verb ! SomeoneElse ! Anim ! st ! t ! p ;
      te = \\part,st,p => vp.prepositive ! st ++ "誰か" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! SomeoneElse ! Anim ! st ! p ;
      ba = \\part,st,p => vp.prepositive ! st ++ "誰か" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.ba ! SomeoneElse ! Anim ! st ! p ;
      subj = \\part,st => vp.prepositive ! st ++ "誰か" ;
      pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! SomeoneElse ! Anim ! st ! t ! p ;
      pred_te = \\st,p => vp.obj ! st ++ vp.prep ++ vp.te ! SomeoneElse ! Anim ! st ! p ;
      pred_ba = \\st,p => vp.obj ! st ++ vp.prep ++ vp.ba ! SomeoneElse ! Anim ! st ! p ;
      changePolar = False
      } ;

    CleftNP np rs = {
      s = \\part,st,t,p => np.prepositive ! st ++ rs.subj ! Ga ! st ++ 
                           rs.pred ! np.anim ! Plain ++ "のは" ++ np.s ! st ++ 
                           mkCopula.s ! st ! t ! p ;
      te = \\part,st,p => np.prepositive ! st ++ rs.subj ! Ga ! st ++ rs.pred ! np.anim ! Plain ++ 
                          "のは" ++ np.s ! st ++ mkCopula.te ! p ;
      ba = \\part,st,p => np.prepositive ! st ++ rs.subj ! Ga ! st ++ rs.pred ! np.anim ! Plain ++ 
                          "のは" ++ np.s ! st ++ mkCopula.ba ! p ;
      subj = \\part,st => np.prepositive ! st ++ rs.subj ! Ga ! st ++ 
                          rs.pred ! np.anim ! Plain ++ "のは" ;
      pred = \\st,t,p => np.s ! st ++ mkCopula.s ! st ! t ! p ;
      pred_te = \\st,p =>  np.s ! st ++ mkCopula.te ! p ;
      pred_ba = \\st,p =>  np.s ! st ++ mkCopula.ba ! p ;
      changePolar = np.changePolar
      } ;
    
    CleftAdv adv s = {
      s = \\part,st,t,p => s.subj ! Ga ! st ++ s.pred ! Plain ++ "のは" ++ adv.s ! st ++ 
                           mkCopula.s ! st ! t ! p ;
      te = \\part,st,p => s.subj ! Ga ! st ++ s.pred ! Plain ++ "のは" ++ adv.s ! st ++ 
                          mkCopula.te ! p ;
      ba = \\part,st,p => s.subj ! Ga ! st ++ s.pred ! Plain ++ "のは" ++ adv.s ! st ++ 
                          mkCopula.ba ! p ;
      subj = \\part,st => s.subj ! Ga ! st ++ s.pred ! Plain ++ "のは" ;
      pred = \\st,t,p => adv.s ! st ++ mkCopula.s ! st ! t ! p ;
      pred_te = \\st,p =>  adv.s ! st ++ mkCopula.te ! p ;
      pred_ba = \\st,p =>  adv.s ! st ++ mkCopula.ba ! p ;
      changePolar = False
      } ;
    
    ExistNP np = case np.needPart of {
      True => {
        s = \\part,st,t,p => np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                             mkExistV.verb ! SomeoneElse ! np.anim ! st ! t ! p ;
        te = \\part,st,p => np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                              mkExistV.te ! SomeoneElse ! np.anim ! st ! p ;
        ba = \\part,st,p => np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                              mkExistV.ba ! SomeoneElse ! np.anim ! st ! p ;
        subj = \\part,st => np.prepositive ! st ++ np.s ! st ++ "が" ;
        pred = \\st,t,p => mkExistV.verb ! SomeoneElse ! np.anim ! st ! t ! p ;
        pred_te = \\st,p => mkExistV.te ! SomeoneElse ! np.anim ! st ! p ;
        pred_ba = \\st,p => mkExistV.ba ! SomeoneElse ! np.anim ! st ! p ;
        changePolar = np.changePolar
        } ;
      False => {
        s = \\part,st,t,p => np.prepositive ! st ++ np.s ! st ++ 
                             mkExistV.verb ! SomeoneElse ! np.anim ! st ! t ! p ;
        te = \\part,st,p => np.prepositive ! st ++ np.s ! st ++ 
                            mkExistV.te ! SomeoneElse ! np.anim ! st ! p ;
        ba = \\part,st,p => np.prepositive ! st ++ np.s ! st ++ 
                            mkExistV.ba ! SomeoneElse ! np.anim ! st ! p ;
        subj = \\part,st => np.prepositive ! st ++ np.s ! st ;
        pred = \\st,t,p => mkExistV.verb ! SomeoneElse ! np.anim ! st ! t ! p ;
        pred_te = \\st,p => mkExistV.te ! SomeoneElse ! np.anim ! st ! p ;
        pred_ba = \\st,p => mkExistV.ba ! SomeoneElse ! np.anim ! st ! p ;
        changePolar = np.changePolar
        } 
      } ;

    ExistIP ip = {
      s = \\part,st,t,p => case ip.how8many of {
        True => ip.s_subj ! st ++ mkExistV.verb ! SomeoneElse ! ip.anim ! st ! t ! p ++ "か" ;
        False => ip.s_subj ! st ++ "が" ++ mkExistV.verb ! SomeoneElse ! ip.anim ! st ! t ! p 
                 ++ "か"
        } ;
      s_plain_pred = \\part,st,t,p => case ip.how8many of {
        True => ip.s_subj ! st ++ mkExistV.verb ! SomeoneElse ! ip.anim ! Plain ! t ! p ++ "か" ;
        False => ip.s_subj ! st ++ "が" ++ mkExistV.verb ! SomeoneElse ! ip.anim ! Plain ! t ! p 
                 ++ "か" 
        } ;
      changePolar = False
      } ;
      
    ProgrVP vp = {
      verb = \\sp,a,st,t,p => vp.te ! sp ! a ! st ! Pos ++ (mkVerb "いる" Gr2).s ! st ! t ! p ; 
      te = \\sp,a,st,p => vp.te ! sp ! a ! st ! Pos ++ mkExistV.te ! SomeoneElse ! Anim ! st ! p ; 
      a_stem = \\sp,a,st => vp.te ! sp ! a ! st ! Pos ++ "い" ; 
      i_stem = \\sp,a,st => vp.te ! sp ! a ! st ! Pos ++ "い" ; 
      ba = \\sp,a,st,p => vp.te ! sp ! a ! st ! Pos ++ mkExistV.ba ! SomeoneElse ! Anim ! st ! p ;
      prep = vp.prep ; 
      obj = vp.obj ; 
      prepositive = vp.prepositive ;
      needSubject = vp.needSubject
      } ;

    ImpPl1 vp = {s = \\part,st => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                             vp.i_stem ! SomeoneElse ! Anim ! st ++ "ましょう" ; type = NoImp} ;
                             
    ImpP3 np vp = {
      s = \\part => table {
        Resp =>  np.prepositive ! Resp ++ vp.prepositive ! Resp ++ np.s ! Resp ++ "を" ++ 
                 vp.obj ! Resp ++ vp.prep ++ vp.a_stem ! SomeoneElse ! Anim ! Resp ++ "せて" ; 
        Plain => np.prepositive ! Plain ++ vp.prepositive ! Plain ++ np.s ! Plain ++ "を" ++ 
                 vp.obj ! Plain ++ vp.prep ++ vp.a_stem ! SomeoneElse ! Anim ! Plain ++ "せなさい"
        } ;
      type = Imper
      } ;
}
