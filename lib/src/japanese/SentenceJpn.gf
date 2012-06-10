concrete SentenceJpn of Sentence = CatJpn
** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin
      
    PredVP np vp = case np.needPart of {
      True => {
        s = table {
          Wa => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                            vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p ;
          Ga => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" ++ 
                            vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p
          } ;
        te = table {
          Wa => \\st,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                          vp.obj ! st ++ vp.prep ++ vp.te ! np.meaning ! np.anim ! st ! p ;
          Ga => \\st,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" ++ 
                          vp.obj ! st ++ vp.prep ++ vp.te ! np.meaning ! np.anim ! st ! p
          } ; 
        ba = table {
          Wa => \\st,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                          vp.obj ! st ++ vp.prep ++ vp.ba ! np.meaning ! np.anim ! st ! p ;
          Ga => \\st,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" ++ 
                          vp.obj ! st ++ vp.prep ++ vp.ba ! np.meaning ! np.anim ! st ! p
          } ;
        subj = table {
          Wa => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ;
          Ga => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" 
          } ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p ;
        pred_te = \\st,p => vp.obj ! st ++ vp.prep ++ vp.te ! np.meaning ! np.anim ! st ! p ;
        pred_ba = \\st,p => vp.obj ! st ++ vp.prep ++ vp.ba ! np.meaning ! np.anim ! st ! p ;
        changePolar = np.changePolar
        } ;
      False => {
        s = table {
          Wa => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                            vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p ;
          Ga => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                            vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p
          } ; 
        te = table {
          Wa => \\st,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! np.meaning ! np.anim ! st ! p ;
          Ga => \\st,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! np.meaning ! np.anim ! st ! p
          } ;
        ba = table {
          Wa => \\st,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ vp.obj ! st ++ 
                          vp.prep ++ vp.ba ! np.meaning ! np.anim ! st ! p ;
          Ga => \\st,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ vp.obj ! st ++ 
                          vp.prep ++ vp.ba ! np.meaning ! np.anim ! st ! p
          } ;
        subj = \\part,st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p ;
        pred_te = \\st,p => vp.obj ! st ++ vp.prep ++ vp.te ! np.meaning ! np.anim ! st ! p ;
        pred_ba = \\st,p => vp.obj ! st ++ vp.prep ++ vp.ba ! np.meaning ! np.anim ! st ! p ;
        changePolar = np.changePolar
        } 
      } ;
    
    PredSCVP sc vp = case sc.isVP of {
      True => {
        s = table {
          Wa => \\st,t,p => sc.s ! Wa ! st ++ "ことは" ++ vp.obj ! st ++ vp.prep ++ 
                            vp.verb ! SomeoneElse ! Inanim ! st ! t ! p ;
          Ga => \\st,t,p => sc.s ! Ga ! st ++ "ことが" ++ vp.obj ! st ++ vp.prep ++ 
                            vp.verb ! SomeoneElse ! Inanim ! st ! t ! p  
          } ;
        te = table {
          Wa => \\st,p => sc.s ! Wa ! st ++ "ことは" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! SomeoneElse ! Inanim ! st ! p ;
          Ga => \\st,p => sc.s ! Ga ! st ++ "ことが" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! SomeoneElse ! Inanim ! st ! p
          } ; 
        ba = table {
          Wa => \\st,p => sc.s ! Wa ! st ++ "ことは" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.ba ! SomeoneElse ! Inanim ! st ! p ;
          Ga => \\st,p => sc.s ! Ga ! st ++ "ことが" ++ vp.obj ! st ++ 
                          vp.prep ++ vp.ba ! SomeoneElse ! Inanim ! st ! p
          } ;
        subj = table {
          Wa => \\st => sc.s ! Wa ! st ++ "ことは" ;
          Ga => \\st => sc.s ! Ga ! st ++ "ことが"
          } ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! SomeoneElse ! Inanim ! st ! t ! p ;
        pred_te = \\st,p => vp.obj ! st ++ vp.prep ++ vp.te ! SomeoneElse ! Inanim ! st ! p ;
        pred_ba = \\st,p => vp.obj ! st ++ vp.prep ++ vp.ba ! SomeoneElse ! Inanim ! st ! p ;
        changePolar = False
        } ;
      False => {
        s = \\part,st,t,p => sc.s ! part ! st ++ "ことが" ++ vp.obj ! st ++ vp.prep ++ 
                             vp.verb ! SomeoneElse ! Inanim ! st ! t ! p ;
        te = \\part,st,p => sc.s ! part ! st ++ "ことが" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.te ! SomeoneElse ! Inanim ! st ! p ;
        ba = \\part,st,p => sc.s ! part ! st ++ "ことが" ++ vp.obj ! st ++ 
                            vp.prep ++ vp.ba ! SomeoneElse ! Inanim ! st ! p ;
        subj = \\part,st => sc.s ! part ! st ++ "ことが" ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! SomeoneElse ! Inanim ! st ! t ! p ;
        pred_te = \\st,p => vp.obj ! st ++ vp.prep ++ vp.te ! SomeoneElse ! Inanim ! st ! p ;
        pred_ba = \\st,p => vp.obj ! st ++ vp.prep ++ vp.ba ! SomeoneElse ! Inanim ! st ! p ;
        changePolar = False
        } 
      } ;

    SlashVP np vpslash = {
      s = \\st,t,p => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                      vpslash.obj ! st ++ vpslash.s ! np.meaning ! Plain ! t ! p ;
      te = \\st,p => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                   vpslash.obj ! st ++ vpslash.te ! np.meaning ! p ;
      ba = \\st,p => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                   vpslash.obj ! st ++ vpslash.ba ! np.meaning ! p ;
      subj = table {
        Wa => \\st => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "は" ;
        Ga => \\st => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "が"
        } ;
      pred = \\st,t,p => vpslash.obj ! st ++ vpslash.prep ++ vpslash.s ! np.meaning ! st ! t ! p ;
      pred_te = \\st,p => vpslash.obj ! st ++ vpslash.prep ++ vpslash.te ! np.meaning ! p ;
      pred_ba = \\st,p => vpslash.obj ! st ++ vpslash.prep ++ vpslash.ba ! np.meaning ! p ;
      changePolar = np.changePolar
      } ;
               
    AdvSlash clslash adv = {
      s = \\st,t,p => adv.s ! st ++ clslash.s ! st ! t ! p ;
      te = \\st,p => adv.s ! st ++ clslash.te ! st ! p ;
      ba = \\st,p => adv.s ! st ++ clslash.ba ! st ! p ;
      subj = \\part,st => adv.s ! st ++ clslash.subj ! part ! st ;
      pred = clslash.pred ;
      pred_te = clslash.pred_te ;
      pred_ba = clslash.pred_ba ;
      changePolar = clslash.changePolar
      } ;
          
    SlashPrep cl prep = {
      s = \\st,t,p => cl.s ! Ga ! st ! t ! p ++ prep.null ;
      te = \\st,p => cl.te ! Ga ! st ! p ++ prep.null ;
      ba = \\st,p => cl.ba ! Ga ! st ! p ++ prep.null ;
      subj = cl.subj ;
      pred = \\st,t,p => cl.pred ! st ! t ! p ++ prep.null ;
      pred_te = \\st,p => cl.pred_te ! st ! p ++ prep.null ;
      pred_ba = \\st,p => cl.pred_ba ! st ! p ++ prep.null ;
      changePolar = cl.changePolar
      } ;

    SlashVS np vs sslash = {
      s = \\st,t,p => np.prepositive ! st ++ np.s ! st ++ "が" ++ sslash.s ! st ++ 
                      vs.prep ++ vs.s ! Plain ! t ! p ;
      te = \\st,p => np.prepositive ! st ++ np.s ! st ++ "が" ++ sslash.s ! st ++ vs.prep ++ 
                     vs.te ! p ;
      ba = \\st,p => np.prepositive ! st ++ np.s ! st ++ "が" ++ sslash.s ! st ++ 
                     vs.prep ++ vs.ba ! p ;
      subj = table {
        Wa => \\st => np.prepositive ! st ++ np.s ! st ++ "は" ;
        Ga => \\st => np.prepositive ! st ++ np.s ! st ++ "が"
        } ;
      pred = \\st,t,p => sslash.s ! st ++ vs.prep ++ vs.s ! st ! t ! p ;
      pred_te = \\st,p => sslash.s ! st ++ vs.prep ++ vs.te ! p ;
      pred_ba = \\st,p => sslash.s ! st ++ vs.prep ++ vs.ba ! p ;
      changePolar = np.changePolar
      } ;
    
    ImpVP vp = {
      s = table {
        Resp => table {
          Pos => vp.prepositive ! Resp ++ vp.obj ! Resp ++ vp.prep ++ 
                 vp.te ! SomeoneElse ! Anim ! Resp ! Pos ;
          Neg => vp.prepositive ! Resp ++ vp.obj ! Resp ++ vp.prep ++ 
                 vp.verb ! SomeoneElse ! Anim ! Plain ! TPres ! Neg ++ "で" 
          } ;
        Plain => table {
          Pos => vp.prepositive ! Plain ++ vp.obj ! Plain ++ vp.prep ++ 
                 vp.i_stem ! SomeoneElse ! Anim ! Plain ++ "なさい" ;
          Neg => vp.prepositive ! Plain ++ vp.obj ! Plain ++ vp.prep ++ 
                 vp.verb ! SomeoneElse ! Anim ! Plain ! TPres ! Pos ++ "な" 
          }
        }
      } ;
    
    EmbedS sent = {s = \\part,st => sent.subj ! part ! st ++ sent.pred ! Plain ; isVP = False} ;
    
    EmbedQS qs = {s = \\part,st => qs.s ! part ! Plain ; isVP = False} ;
    
    EmbedVP vp = {s = \\part,st => vp.verb ! SomeoneElse ! Inanim ! Plain ! TPres ! Pos ; 
                  isVP = True} ;
    
    UseCl t p cl = {
      s = \\part,st => case t.a of {
        Simul => case cl.changePolar of {
          False => t.s ++ p.s ++ cl.s ! part ! st ! t.t ! p.b ; 
          True => t.s ++ p.s ++ cl.s ! part ! st ! t.t ! Neg
          } ;
        Anter => case t.t of {
          TPres => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.s ! part ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ cl.s ! part ! st ! TPast ! Neg
            } ;
          TPast => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.s ! part ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ cl.s ! part ! st ! TPast ! Neg
            } ;
          TFut => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.s ! part ! st ! TPres ! p.b ;
            True => t.s ++ p.s ++ cl.s ! part ! st ! TPres ! Neg
            } 
          }
        } ;
      te = \\part,st => t.s ++ p.s ++ cl.te ! part ! st ! p.b ;
      ba = \\part,st => t.s ++ p.s ++ cl.ba ! part ! st ! p.b ;
      subj = cl.subj ;
      pred = \\st => case t.a of {
        Simul => case cl.changePolar of {
          False => t.s ++ p.s ++ cl.pred ! st ! t.t ! p.b ; 
          True => t.s ++ p.s ++ cl.pred ! st ! t.t ! Neg
          } ;
        Anter => case t.t of {
          TPres => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.pred ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ cl.pred ! st ! TPast ! Neg
            } ;
          TPast => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.pred ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ cl.pred ! st ! TPast ! Neg
            } ;
          TFut => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.pred ! st ! TPres ! p.b ;
            True => t.s ++ p.s ++ cl.pred ! st ! TPres ! Neg
            } 
          }
        } ;
      pred_te = \\st => cl.pred_te ! st ! p.b ;
      pred_ba = \\st => cl.pred_ba ! st ! p.b 
      } ; 
    
    UseQCl t p cl = {
      s = \\part,st => case t.a of {
        Simul => case cl.changePolar of {
          False => t.s ++ p.s ++ cl.s ! part ! st ! t.t ! p.b ;
          True => t.s ++ p.s ++ cl.s ! part ! st ! t.t ! Neg
          } ;
        Anter => case t.t of {
          TPres => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.s ! part ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ cl.s ! part ! st ! TPast ! Neg
            } ;
          TPast => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.s ! part ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ cl.s ! part ! st ! TPast ! Neg
            } ;
          TFut => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.s ! part ! st ! TPres ! p.b ;
            True => t.s ++ p.s ++ cl.s ! part ! st ! TPres ! Neg
            }
          } 
        } ;
      s_plain_pred = \\part,st => case t.a of {
        Simul => case cl.changePolar of {
          False => t.s ++ p.s ++ cl.s_plain_pred ! part ! st ! t.t ! p.b ;
          True => t.s ++ p.s ++ cl.s_plain_pred ! part ! st ! t.t ! Neg
          } ;
        Anter => case t.t of {
          TPres => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.s_plain_pred ! part ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ cl.s_plain_pred ! part ! st ! TPast ! Neg
            } ;
          TPast => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.s_plain_pred ! part ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ cl.s_plain_pred ! part ! st ! TPast ! Neg
            } ;
          TFut => case cl.changePolar of {
            False => t.s ++ p.s ++ cl.s_plain_pred ! part ! st ! TPres ! p.b ;
            True => t.s ++ p.s ++ cl.s_plain_pred ! part ! st ! TPres ! Neg
            }
          } 
        }
      } ;
          
    UseRCl t p rcl = {
      s = \\a,st => case t.a of {
        Simul => case rcl.changePolar of {
          False => t.s ++ p.s ++ rcl.s ! a ! st ! t.t ! p.b ; 
          True => t.s ++ p.s ++ rcl.s ! a ! st ! t.t ! Neg
          } ;
        Anter => case t.t of {
          TPres => case rcl.changePolar of {
            False => t.s ++ p.s ++ rcl.s ! a ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ rcl.s ! a ! st ! TPast ! Neg
            } ;
          TPast => case rcl.changePolar of {
            False => t.s ++ p.s ++ rcl.s ! a ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ rcl.s ! a ! st ! TPast ! Neg
            } ;
          TFut => case rcl.changePolar of {
            False => t.s ++ p.s ++ rcl.s ! a ! st ! TPres ! p.b ;
            True => t.s ++ p.s ++ rcl.s ! a ! st ! TPres ! Neg
            } 
          }
        } ;
      te = \\a,st => t.s ++ p.s ++ rcl.te ! a ! st ! p.b ;
      subj = rcl.subj ;
      pred = \\a,st => case t.a of {
        Simul => case rcl.changePolar of {
          False => t.s ++ p.s ++ rcl.pred ! a ! st ! t.t ! p.b ; 
          True => t.s ++ p.s ++ rcl.pred ! a ! st ! t.t ! Neg
          } ;
        Anter => case t.t of {
          TPres => case rcl.changePolar of {
            False => t.s ++ p.s ++ rcl.pred ! a ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ rcl.pred ! a ! st ! TPast ! Neg
            } ;
          TPast => case rcl.changePolar of {
            False => t.s ++ p.s ++ rcl.pred ! a ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ rcl.pred ! a ! st ! TPast ! Neg
            } ;
          TFut => case rcl.changePolar of {
            False => t.s ++ p.s ++ rcl.pred ! a ! st ! TPres ! p.b ;
            True => t.s ++ p.s ++ rcl.pred ! a ! st ! TPres ! Neg
            } 
          }
        } ;
      pred_te = \\a,st => t.s ++ p.s ++ rcl.pred_te ! a ! st ! p.b ;
      pred_ba = \\a,st => t.s ++ p.s ++ rcl.pred_ba ! a ! st ! p.b ;
      missingSubj = rcl.missingSubj
      } ; 
              
    UseSlash t p clslash = {
      s = \\st => case t.a of {
        Simul => case clslash.changePolar of {
          False => t.s ++ p.s ++ clslash.s ! st ! t.t ! p.b ; 
          True => t.s ++ p.s ++ clslash.s ! st ! t.t ! Neg
          } ;
        Anter => case t.t of {
          TPres => case clslash.changePolar of {
            False => t.s ++ p.s ++ clslash.s ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ clslash.s ! st ! TPast ! Neg
            } ;
          TPast => case clslash.changePolar of {
            False => t.s ++ p.s ++ clslash.s ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ clslash.s ! st ! TPast ! Neg
            } ;
          TFut => case clslash.changePolar of {
            False => t.s ++ p.s ++ clslash.s ! st ! TPres ! p.b ;
            True => t.s ++ p.s ++ clslash.s ! st ! TPres ! Neg
            } 
          }
        } ;
      te = \\st => clslash.te ! st ! p.b
      } ;
    
    AdvS adv s = {
      s = \\part,st => adv.s ! st ++ s.s ! part ! st ;
      te = \\part,st => adv.s ! st ++ s.te ! part ! st ;
      ba = \\part,st => adv.s ! st ++ s.ba ! part ! st ;
      subj = \\part,st => adv.s ! st ++ s.subj ! part ! st ;
      pred = s.pred ;
      pred_te = s.pred_te ;
      pred_ba = s.pred_ba
      } ;
    
    ExtAdvS adv s = {
      s = \\part,st => adv.s ! st ++ "、" ++ s.s ! part ! st ;
      te = \\part,st => adv.s ! st ++ "、" ++ s.te ! part ! st ;
      ba = \\part,st => adv.s ! st ++ "、" ++ s.ba ! part ! st ;
      subj = \\part,st => adv.s ! st ++ "、" ++ s.subj ! part ! st ;
      pred = s.pred ;
      pred_te = s.pred_te ;
      pred_ba = s.pred_ba
      } ;
      
    SSubjS s1 subj s2 = case subj.type of {
      If => {
        s = \\part,st => s1.ba ! part ! st ++ subj.s ++ s2.s ! Ga ! st ;
        te = \\part,st => s1.ba ! part ! st ++ subj.s ++ s2.te ! Ga ! st ;
        ba = \\part,st => s1.ba ! part ! st ++ subj.s ++ s2.ba ! Ga ! st ;
        subj = \\part,st => s1.ba ! part ! st ++ subj.s ++ s2.subj ! Ga ! st ;
        pred = s2.pred ;
        pred_te = s2.pred_te ;
        pred_ba = s2.pred_ba 
        } ;
      That => {
        s = \\part,st => s1.subj ! part ! st ++ s2.subj ! Ga ! st ++ s2.pred ! Plain ++ 
                         subj.s ++ s1.pred ! st ; 
        te = \\part,st => s1.subj ! part ! st ++ s2.subj ! Ga ! st ++ s2.pred ! Plain ++ 
                          subj.s ++ s1.pred_te ! st ; 
        ba = \\part,st => s1.subj ! part ! st ++ s2.subj ! Ga ! st ++ s2.pred ! Plain ++ 
                          subj.s ++ s1.pred_ba ! st ; 
        subj = \\part,st => s1.subj ! part ! st ;
        pred = \\st => s2.subj ! Ga ! st ++ s2.pred ! Plain ++ subj.s ++ s1.pred ! st ;
        pred_te = \\st => s2.subj ! Ga ! st ++ s2.pred ! Plain ++ subj.s ++ s1.pred_te ! st ;
        pred_ba = \\st => s2.subj ! Ga ! st ++ s2.pred ! Plain ++ subj.s ++ s1.pred_ba ! st
        } ;
      OtherSubj => {
        s = \\part,st => s1.s ! part ! Plain ++ subj.s ++ s2.s ! Ga ! st ;
        te = \\part,st => s1.s ! part ! Plain ++ subj.s ++ s2.te ! Ga ! st ;
        ba = \\part,st => s1.s ! part ! Plain ++ subj.s ++ s2.ba ! Ga ! st ;
        subj = \\part,st => s1.s ! part ! Plain ++ subj.s ++ s2.subj ! Ga ! st ;
        pred = s2.pred ;
        pred_te = s2.pred_te ;
        pred_ba = s2.pred_ba
        } 
      } ;
          
    RelS sent rs = case rs.missingSubj of {
      True => {
        s = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                         "ことが" ++ rs.pred ! Inanim ! st ;
        te = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                          "ことが" ++ rs.pred_te ! Inanim ! st ;
        ba = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                            "ことが" ++ rs.pred_ba ! Inanim ! st ;
        subj = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++
                            "ことが" ;
        pred = \\st => rs.pred ! Inanim ! st ;
        pred_te = \\st => rs.pred_te ! Inanim ! st ;
        pred_ba = \\st => rs.pred_ba ! Inanim ! st
        } ;
      False => {
        s = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                         "ことを" ++ rs.pred ! Inanim ! st ;
        te = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                          "ことを" ++ rs.pred_te ! Inanim ! st ;
        ba = \\part,st => rs.subj ! Wa ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                          "ことを" ++ rs.pred_ba ! Inanim ! st ;
        subj = \\part,st => rs.subj ! part ! st ;
        pred = \\st => sent.subj ! Ga ! st ++ sent.pred ! Plain ++ "ことを" ++ 
                       rs.pred ! Inanim ! st ;
        pred_te = \\st => sent.subj ! Ga ! st ++ sent.pred ! Plain ++ "ことを" ++ 
                          rs.pred_te ! Inanim ! st ;
        pred_ba = \\st => sent.subj ! Ga ! st ++ sent.pred ! Plain ++ "ことを" ++ 
                          rs.pred_ba ! Inanim ! st
        }
      } ;
}
