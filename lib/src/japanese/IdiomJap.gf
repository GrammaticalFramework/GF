concrete IdiomJap of Idiom = CatJap ** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin

    ImpersCl vp = case vp.compar of {
      More => {
        s = table {
          Wa => \\st,t,p => vp.prepositive ! st ++ "これは" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.verb ! Inanim ! st ! t ! p ; 
          Ga => \\st,t,p => vp.prepositive ! st ++ "これのほうが" ++ vp.obj ! st ++  
                            vp.prep ++ vp.verb ! Inanim ! st ! t ! p  
          } ;
        te = table {
          Wa => \\st => vp.prepositive ! st ++ "これは" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.te ! Inanim ! st ;
          Ga => \\st => vp.prepositive ! st ++ "これのほうが" ++ vp.obj ! st ++  
                        vp.prep ++ vp.te ! Inanim ! st
          } ; 
        ba = table {
          Wa => \\st => vp.prepositive ! st ++ "これは" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.ba ! Inanim ! st ;
          Ga => \\st => vp.prepositive ! st ++ "これのほうが" ++ vp.obj ! st ++  
                        vp.prep ++ vp.ba ! Inanim ! st
          } ;
        subj = table {
          Wa => \\st => vp.prepositive ! st ++ "これは" ;
          Ga => \\st => vp.prepositive ! st ++ "これのほうが" 
          } ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! Inanim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! Inanim ! st ;
        pred_ba = \\st => vp.obj ! st ++ vp.prep ++ vp.ba ! Inanim ! st ;
        changePolar = False
        } ;
      Less => {
        s = \\part,st,t,p => vp.prepositive ! st ++ "これより" ++ vp.obj ! st ++ 
                             vp.prep ++ vp.verb ! Inanim ! st ! t ! p ;
        te = \\part,st => vp.prepositive ! st ++ "これより" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! Inanim ! st ; 
        ba = \\part,st => vp.prepositive ! st ++ "これより" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.ba ! Inanim ! st ;
        subj = \\part,st => vp.prepositive ! st ++ "これより" ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! Inanim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! Inanim ! st ;
        pred_ba = \\st => vp.obj ! st ++ vp.prep ++ vp.ba ! Inanim ! st ;
        changePolar = False
        } ;
      NoCompar => {
        s = table {
          Wa => \\st,t,p => vp.prepositive ! st ++ "これは" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.verb ! Inanim ! st ! t ! p ;
          Ga => \\st,t,p => vp.prepositive ! st ++ "これが" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.verb ! Inanim ! st ! t ! p  
          } ;
        te = table {
          Wa => \\st => vp.prepositive ! st ++ "これは" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.te ! Inanim ! st ;
          Ga => \\st => vp.prepositive ! st ++ "これが" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.te ! Inanim ! st
          } ; 
        ba = table {
          Wa => \\st => vp.prepositive ! st ++ "これは" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.ba ! Inanim ! st ;
          Ga => \\st => vp.prepositive ! st ++ "これが" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.ba ! Inanim ! st
          } ;
        subj = table {
          Wa => \\st => vp.prepositive ! st ++ "これは" ;
          Ga => \\st => vp.prepositive ! st ++ "これが" 
          } ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! Inanim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! Inanim ! st ;
        pred_ba = \\st => vp.obj ! st ++ vp.prep ++ vp.ba ! Inanim ! st ;
        changePolar = False
        }
      } ;
    
    GenericCl  vp = case vp.compar of {
      More => {
        s = table {
          Wa => \\st,t,p => vp.prepositive ! st ++ "誰か" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.verb ! Anim ! st ! t ! p ; 
          Ga => \\st,t,p => vp.prepositive ! st ++ "誰かのほうが" ++ vp.obj ! st ++  
                            vp.prep ++ vp.verb ! Anim ! st ! t ! p  
          } ;
        te = table {
          Wa => \\st => vp.prepositive ! st ++ "誰か" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.te ! Anim ! st ;
          Ga => \\st => vp.prepositive ! st ++ "誰かのほうが" ++ vp.obj ! st ++  
                        vp.prep ++ vp.te ! Anim ! st
          } ; 
        ba = table {
          Wa => \\st => vp.prepositive ! st ++ "誰か" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.ba ! Anim ! st ;
          Ga => \\st => vp.prepositive ! st ++ "誰かのほうが" ++ vp.obj ! st ++  
                        vp.prep ++ vp.ba ! Anim ! st
          } ;
        subj = table {
          Wa => \\st => vp.prepositive ! st ++ "誰か" ;
          Ga => \\st => vp.prepositive ! st ++ "誰かのほうが" 
          } ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! Anim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! Anim ! st ;
        pred_ba = \\st => vp.obj ! st ++ vp.prep ++ vp.ba ! Anim ! st ;
        changePolar = False
        } ;
      Less => {
        s = \\part,st,t,p => vp.prepositive ! st ++ "誰かより" ++ vp.obj ! st ++ 
                             vp.prep ++ vp.verb ! Anim ! st ! t ! p ;
        te = \\part,st => vp.prepositive ! st ++ "誰かより" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! Anim ! st ; 
        ba = \\part,st => vp.prepositive ! st ++ "誰かより" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.ba ! Anim ! st ;
        subj = \\part,st => vp.prepositive ! st ++ "誰かより" ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! Anim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! Anim ! st ;
        pred_ba = \\st => vp.obj ! st ++ vp.prep ++ vp.ba ! Anim ! st ;
        changePolar = False
        } ;
      NoCompar => {
        s = \\part,st,t,p => vp.prepositive ! st ++ "誰か" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.verb ! Anim ! st ! t ! p ;
        te = \\part,st => vp.prepositive ! st ++ "誰か" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.te ! Anim ! st ;
        ba = \\part,st => vp.prepositive ! st ++ "誰か" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.ba ! Anim ! st ;
        subj = \\part,st => vp.prepositive ! st ++ "誰か" ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! Anim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! Anim ! st ;
        pred_ba = \\st => vp.obj ! st ++ vp.prep ++ vp.ba ! Anim ! st ;
        changePolar = False
        }
      } ;

    CleftNP np rs = {
      s = \\part,st,t,p => np.prepositive ! st ++ rs.subj ! Ga ! st ++ 
                           rs.pred ! np.anim ! Plain ++ "のは" ++ np.s ! st ++ 
                           mkCopula.s ! st ! t ! p ;
      te = \\part,st => np.prepositive ! st ++ rs.subj ! Ga ! st ++ 
                        rs.pred ! np.anim ! Plain ++ "のは" ++ np.s ! st ++ "だって" ;
      ba = \\part,st => np.prepositive ! st ++ rs.subj ! Ga ! st ++ 
                      rs.pred ! np.anim ! Plain ++ "のは" ++ np.s ! st ++ "であれば" ;
      subj = \\part,st => np.prepositive ! st ++ rs.subj ! Ga ! st ++ 
                          rs.pred ! np.anim ! Plain ++ "のは" ;
      pred = \\st,t,p => np.s ! st ++ mkCopula.s ! st ! t ! p ;
      pred_te = \\st =>  np.s ! st ++ "だって" ;
      pred_ba = \\st =>  np.s ! st ++ "であれば" ;
      changePolar = np.changePolar
      } ;
    
    CleftAdv adv s = {
      s = \\part,st,t,p => s.subj ! Ga ! st ++ s.pred ! Plain ++ "のは" ++ adv.s ! st ++ 
                           mkCopula.s ! st ! t ! p ;
      te = \\part,st => s.subj ! Ga ! st ++ s.pred ! Plain ++ "のは" ++ adv.s ! st ++ 
                        "だって" ;
      ba = \\part,st => s.subj ! Ga ! st ++ s.pred ! Plain ++ "のは" ++ adv.s ! st ++ 
                          "であれば" ;
      subj = \\part,st => s.subj ! Ga ! st ++ s.pred ! Plain ++ "のは" ;
      pred = \\st,t,p => adv.s ! st ++ mkCopula.s ! st ! t ! p ;
      pred_te = \\st =>  adv.s ! st ++ "だって" ;
      pred_ba = \\st =>  adv.s ! st ++ "であれば" ;
      changePolar = False
      } ;
    
    ExistNP np = case np.needPart of {
      True => {
         s = table {
          Wa => \\st,t,p => np.prepositive ! st ++ np.s ! st ++ "は" ++ 
                            mkExistV.verb ! np.anim ! st ! t ! p ;
          Ga => \\st,t,p => np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                            mkExistV.verb ! np.anim ! st ! t ! p
          } ;
        te = table {
          Wa => \\st => np.prepositive ! st ++ np.s ! st ++ "は" ++ mkExistV.te ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ np.s ! st ++ "が" ++ mkExistV.te ! np.anim ! st
          } ;
        ba = table {
          Wa => \\st => np.prepositive ! st ++ np.s ! st ++ "は" ++ mkExistV.ba ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ np.s ! st ++ "が" ++ mkExistV.ba ! np.anim ! st
          } ;
        subj = table {
          Wa => \\st => np.prepositive ! st ++ np.s ! st ++ "は" ;
          Ga => \\st => np.prepositive ! st ++ np.s ! st ++ "が" 
          } ;
        pred = \\st,t,p => mkExistV.verb ! np.anim ! st ! t ! p ;
        pred_te = \\st => mkExistV.te ! np.anim ! st ;
        pred_ba = \\st => mkExistV.ba ! np.anim ! st ;
        changePolar = np.changePolar
        } ;
      False => {
        s = \\part,st,t,p => np.prepositive ! st ++ np.s ! st ++ 
                             mkExistV.verb ! np.anim ! st ! t ! p ;
        te = \\part,st => np.prepositive ! st ++ np.s ! st ++ mkExistV.te ! np.anim ! st ;
        ba = \\part,st => np.prepositive ! st ++ np.s ! st ++ mkExistV.ba ! np.anim ! st ;
        subj = \\part,st => np.prepositive ! st ++ np.s ! st ;
        pred = \\st,t,p => mkExistV.verb ! np.anim ! st ! t ! p ;
        pred_te = \\st => mkExistV.te ! np.anim ! st ;
        pred_ba = \\st => mkExistV.ba ! np.anim ! st ;
        changePolar = np.changePolar
        } 
      } ;

    ExistIP ip = {
      s = \\part,st,t,p => ip.s ! st ++ "が" ++ mkExistV.verb ! ip.anim ! st ! t ! p ;
      changePolar = False
      } ;
      
    ProgrVP vp = {
      verb = \\a,st,t,p => vp.te ! a ! st ++ (mkVerb "い" "い" "いる" "いった").s ! st ! t ! p ; 
      te = \\a,st => vp.te ! a ! st ++ "いて" ; 
      a_stem = \\a,st => vp.te ! a ! st ++ "い" ; 
      i_stem = \\a,st => vp.te ! a ! st ++ "い" ; 
      ba = \\a,st => vp.te ! a ! st ++ "いれば" ;
      prep = vp.prep ; 
      obj = vp.obj ; 
      prepositive = vp.prepositive ; 
      compar = vp.compar
      } ;

    ImpPl1 vp = {s = \\st => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                             vp.i_stem ! Anim ! st ++ "ましょう"} ;
                             
    ImpP3 np vp = {s = \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "に" ++ 
                               vp.obj ! st ++ vp.prep ++ vp.a_stem ! Anim ! st ++ "せて"} ;
}
