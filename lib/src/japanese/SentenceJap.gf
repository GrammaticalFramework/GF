concrete SentenceJap of Sentence = CatJap
** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin
      
    PredVP np vp = case vp.compar of {
      More => {
        s = table {
          Wa => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                            vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p ; 
          Ga => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                            "のほうが" ++ vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p  
          } ;
        te = table {
          Wa => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                        vp.obj ! st ++ vp.prep ++ vp.te ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "のほうが" ++ 
                        vp.obj ! st ++ vp.prep ++ vp.te ! np.anim ! st
          } ; 
        tara = table {
          Wa => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                        vp.obj ! st ++ vp.prep ++ vp.tara ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "のほうが" ++ 
                        vp.obj ! st ++ vp.prep ++ vp.tara ! np.anim ! st
          } ;
        subj = table {
          Wa => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ;
          Ga => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "のほうが" 
          } ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! np.anim ! st ;
        pred_tara = \\st => vp.obj ! st ++ vp.prep ++ vp.tara ! np.anim ! st ;
        changePolar = np.changePolar
        } ;
      Less => {
        s = \\part,st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                             "より" ++ vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p ;
        te = \\part,st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "より" 
                               ++ vp.obj ! st ++ vp.prep ++ vp.te ! np.anim ! st ; 
        tara = \\part,st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                               "より" ++ vp.obj ! st ++ vp.prep ++ vp.tara ! np.anim ! st ;
        subj = \\part,st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "より" ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! np.anim ! st ;
        pred_tara = \\st => vp.obj ! st ++ vp.prep ++ vp.tara ! np.anim ! st ;
        changePolar = np.changePolar
        } ;
      NoCompar => case np.needPart of {
        True => {
          s = table {
            Wa => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                              vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p ;
            Ga => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" ++ 
                              vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p  
            } ;
          te = table {
            Wa => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                          vp.obj ! st ++ vp.prep ++ vp.te ! np.anim ! st ;
            Ga => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" ++ 
                          vp.obj ! st ++ vp.prep ++ vp.te ! np.anim ! st
            } ; 
          tara = table {
            Wa => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                          vp.obj ! st ++ vp.prep ++ vp.tara ! np.anim ! st ;
            Ga => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" ++ 
                          vp.obj ! st ++ vp.prep ++ vp.tara ! np.anim ! st
            } ;
          subj = table {
            Wa => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ;
            Ga => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" 
            } ;
          pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p ;
          pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! np.anim ! st ;
          pred_tara = \\st => vp.obj ! st ++ vp.prep ++ vp.tara ! np.anim ! st ;
          changePolar = np.changePolar
          } ;
        False => {
          s = table {
            Wa => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                              vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p ;
            Ga => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                              vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p
            } ; 
          te = table {
            Wa => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! np.anim ! st ;
            Ga => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ vp.obj ! st ++ 
                          vp.prep ++ vp.te ! np.anim ! st 
            } ;
          tara = table {
            Wa => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ vp.obj ! st ++ 
                          vp.prep ++ vp.tara ! np.anim ! st ;
            Ga => \\st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ vp.obj ! st ++ 
                          vp.prep ++ vp.tara ! np.anim ! st
            } ;
          subj = \\part,st => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ;
          pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! np.anim ! st ! t ! p ;
          pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! np.anim ! st ;
          pred_tara = \\st => vp.obj ! st ++ vp.prep ++ vp.tara ! np.anim ! st ;
          changePolar = np.changePolar
          }
        }
      } ;
    
    PredSCVP sc vp = case sc.isVP of {
      True => {
        s = table {
          Wa => \\st,t,p => sc.s ! Wa ! st ++ "ことは" ++ vp.obj ! st ++ vp.prep ++ 
                            vp.verb ! Inanim ! st ! t ! p ;
          Ga => \\st,t,p => sc.s ! Ga ! st ++ "ことが" ++ vp.obj ! st ++ vp.prep ++ 
                            vp.verb ! Inanim ! st ! t ! p  
          } ;
        te = table {
          Wa => \\st => sc.s ! Wa ! st ++ "ことは" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.te ! Inanim ! st ;
          Ga => \\st => sc.s ! Ga ! st ++ "ことが" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.te ! Inanim ! st
          } ; 
        tara = table {
          Wa => \\st => sc.s ! Wa ! st ++ "ことは" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.tara ! Inanim ! st ;
          Ga => \\st => sc.s ! Ga ! st ++ "ことが" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.tara ! Inanim ! st
          } ;
        subj = table {
          Wa => \\st => sc.s ! Wa ! st ++ "ことは" ;
          Ga => \\st => sc.s ! Ga ! st ++ "ことが"
          } ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! Inanim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! Inanim ! st ;
        pred_tara = \\st => vp.obj ! st ++ vp.prep ++ vp.tara ! Inanim ! st ;
        changePolar = False
        } ;
      False => {
        s = table {
          Wa => \\st,t,p => sc.s ! Wa ! st ++ "ことが" ++ vp.obj ! st ++ vp.prep ++ 
                            vp.verb ! Inanim ! st ! t ! p ;
          Ga => \\st,t,p => sc.s ! Ga ! st ++ "ことが" ++ vp.obj ! st ++ vp.prep ++ 
                            vp.verb ! Inanim ! st ! t ! p  
          } ;
        te = table {
          Wa => \\st => sc.s ! Wa ! st ++ "ことが" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.te ! Inanim ! st ;
          Ga => \\st => sc.s ! Ga ! st ++ "ことが" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.te ! Inanim ! st
          } ; 
        tara = table {
          Wa => \\st => sc.s ! Wa ! st ++ "ことが" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.tara ! Inanim ! st ;
          Ga => \\st => sc.s ! Ga ! st ++ "ことが" ++ vp.obj ! st ++ 
                        vp.prep ++ vp.tara ! Inanim ! st
          } ;
        subj = table {
          Wa => \\st => sc.s ! Wa ! st ++ "ことが" ;
          Ga => \\st => sc.s ! Ga ! st ++ "ことが"
          } ;
        pred = \\st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! Inanim ! st ! t ! p ;
        pred_te = \\st => vp.obj ! st ++ vp.prep ++ vp.te ! Inanim ! st ;
        pred_tara = \\st => vp.obj ! st ++ vp.prep ++ vp.tara ! Inanim ! st ;
        changePolar = False
        } 
      } ;

    SlashVP np vpslash = {
      s = \\st,t,p => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                      vpslash.obj ! st ++ vpslash.prep ++ vpslash.s ! Plain ! t ! p ;
      te = \\st => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                   vpslash.obj ! st ++ vpslash.prep ++ vpslash.te ;
      tara = \\st => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "が" ++ 
                   vpslash.obj ! st ++ vpslash.prep ++ vpslash.tara ;
      subj = table {
        Wa => \\st => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "は" ;
        Ga => \\st => vpslash.prepositive ! st ++ np.prepositive ! st ++ np.s ! st ++ "が"
        } ;
      pred = \\st,t,p => vpslash.obj ! st ++ vpslash.prep ++ vpslash.s ! st ! t ! p ;
      pred_te = \\st => vpslash.obj ! st ++ vpslash.prep ++ vpslash.te ;
      pred_tara = \\st => vpslash.obj ! st ++ vpslash.tara ;
      changePolar = np.changePolar
      } ;
               
    AdvSlash clslash adv = {
      s = \\st,t,p => adv.s ! st ++ clslash.s ! st ! t ! p ;
      te = \\st => adv.s ! st ++ clslash.te ! st ;
      tara = \\st => adv.s ! st ++ clslash.tara ! st ;
      subj = \\part,st => adv.s ! st ++ clslash.subj ! part ! st ;
      pred = clslash.pred ;
      pred_te = clslash.pred_te ;
      pred_tara = clslash.pred_tara ;
      changePolar = clslash.changePolar
      } ;
          
    SlashPrep cl prep = {
      s = \\st,t,p => cl.s ! Ga ! st ! t ! p ++ prep.relPrep ;
      te = \\st => cl.te ! Ga ! st ++ prep.relPrep ;
      tara = \\st => cl.tara ! Ga ! st ++ prep.relPrep ;
      subj = cl.subj ;
      pred = \\st,t,p => cl.pred ! st ! t ! p ++ prep.relPrep ;
      pred_te = \\st => cl.pred_te ! st ++ prep.relPrep ;
      pred_tara = \\st => cl.pred_tara ! st ++ prep.relPrep ;
      changePolar = cl.changePolar
      } ;

    SlashVS np vs sslash = {
      s = \\st,t,p => np.prepositive ! st ++ np.s ! st ++ "が" ++ sslash.s ! st ++ 
                      vs.prep ++ vs.s ! Plain ! t ! p ;
      te = \\st => np.prepositive ! st ++ np.s ! st ++ "が" ++ sslash.s ! st ++ vs.prep ++ vs.te ;
      tara = \\st => np.prepositive ! st ++ np.s ! st ++ "が" ++ sslash.s ! st ++ 
                     vs.prep ++ vs.tara ;
      subj = table {
        Wa => \\st => np.prepositive ! st ++ np.s ! st ++ "は" ;
        Ga => \\st => np.prepositive ! st ++ np.s ! st ++ "が"
        } ;
      pred = \\st,t,p => sslash.s ! st ++ vs.prep ++ vs.s ! st ! t ! p ;
      pred_te = \\st => sslash.s ! st ++ vs.prep ++ vs.te ;
      pred_tara = \\st => sslash.s ! st ++ vs.prep ++ vs.tara ;
      changePolar = np.changePolar
      } ;
    
    ImpVP vp = {
      s = table {
        Resp => table {
          Pos => vp.prepositive ! Resp ++ vp.obj ! Resp ++ vp.prep ++ 
                 vp.te ! Anim ! Resp ;
          Neg => vp.prepositive ! Resp ++ vp.obj ! Resp ++ vp.prep ++ 
                 vp.verb ! Anim ! Plain ! TPres ! Neg ++ "で" 
          } ;
        Plain => table {
          Pos => vp.prepositive ! Plain ++ vp.obj ! Plain ++ vp.prep ++ 
                 vp.i_stem ! Anim ! Plain ++ "なさい" ;
          Neg => vp.prepositive ! Plain ++ vp.obj ! Plain ++ vp.prep ++ 
                 vp.verb ! Anim ! Plain ! TPres ! Pos ++ "な" 
          }
        }
      } ;
    
    EmbedS sent = {s = \\part,st => sent.subj ! part ! st ++ sent.pred ! Plain ; isVP = False} ;
    
    EmbedQS qs = {s = \\part,st => qs.s ! part ! Plain ; isVP = False} ;
    
    EmbedVP vp = {s = \\part,st => vp.verb ! Inanim ! Plain ! TPres ! Pos ; isVP = True} ;
    
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
      te = \\part,st => t.s ++ p.s ++ cl.te ! part ! st ;
      tara = \\part,st => t.s ++ p.s ++ cl.tara ! part ! st ;
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
        }
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
      te = \\a,st => rcl.te ! a ! st ;
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
      pred_te = \\a,st => t.s ++ p.s ++ rcl.pred_te ! a ! st ;
      pred_tara = \\a,st => t.s ++ p.s ++ rcl.pred_tara ! a ! st ;
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
      te = \\st => clslash.te ! st
      } ;
    
    AdvS adv s = {
      s = \\part,st => adv.s ! st ++ s.s ! part ! st ;
      te = \\part,st => adv.s ! st ++ s.te ! part ! st ;
      tara = \\part,st => adv.s ! st ++ s.tara ! part ! st ;
      subj = \\part,st => adv.s ! st ++ s.subj ! part ! st ;
      pred = s.pred
      } ;
    
    ExtAdvS adv s = {
      s = \\part,st => adv.s ! st ++ "," ++ s.s ! part ! st ;
      te = \\part,st => adv.s ! st ++ "," ++ s.te ! part ! st ;
      tara = \\part,st => adv.s ! st ++ "," ++ s.tara ! part ! st ;
      subj = \\part,st => adv.s ! st ++ "," ++ s.subj ! part ! st ;
      pred = s.pred
      } ;
      
    SSubjS s1 subj s2 = case subj.when of {
      True => {
        s = \\part,st => s1.tara ! part ! st ++ subj.s ++ s2.s ! Ga ! st ;
        te = \\part,st => s1.tara ! part ! st ++ subj.s ++ s2.te ! Ga ! st ;
        tara = \\part,st => s1.tara ! part ! st ++ subj.s ++ s2.tara ! Ga ! st ;
        subj = \\part,st => s1.tara ! part ! st ++ subj.s ++ s2.subj ! Ga ! st ;
        pred = s2.pred
        } ;
      False => {
        s = \\part,st => s1.s ! part ! Plain ++ subj.s ++ s2.s ! Ga ! st ;
        te = \\part,st => s1.s ! part ! Plain ++ subj.s ++ s2.te ! Ga ! st ;
        tara = \\part,st => s1.s ! part ! Plain ++ subj.s ++ s2.tara ! Ga ! st ;
        subj = \\part,st => s1.s ! part ! Plain ++ subj.s ++ s2.subj ! Ga ! st ;
        pred = s2.pred
        } 
      } ;
          
    RelS sent rs = case rs.missingSubj of {
      True => {
        s = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                         "ことが" ++ rs.pred ! Inanim ! st ;
        te = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                          "ことが" ++ rs.pred_te ! Inanim ! st ;
        tara = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                            "ことが" ++ rs.pred_tara ! Inanim ! st ;
        subj = \\part,st => rs.subj ! part ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++
                            "ことが" ;
        pred = \\st => rs.pred ! Inanim ! st
        } ;
      False => {
        s = table {
          Wa => \\st => rs.subj ! Wa ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                        "ことを" ++ rs.pred ! Inanim ! st ;
          Ga => \\st => rs.subj ! Ga ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                        "ことを" ++ rs.pred ! Inanim ! st 
          } ;
        te = table {
          Wa => \\st => rs.subj ! Wa ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                        "ことを" ++ rs.pred_te ! Inanim ! st ;
          Ga => \\st => rs.subj ! Ga ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                        "ことを" ++ rs.pred_te ! Inanim ! st 
          } ;
        tara = table {
          Wa => \\st => rs.subj ! Wa ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                        "ことを" ++ rs.pred_tara ! Inanim ! st ;
          Ga => \\st => rs.subj ! Ga ! st ++ sent.subj ! Ga ! st ++ sent.pred ! Plain ++ 
                        "ことを" ++ rs.pred_tara ! Inanim ! st 
          } ;
        subj = \\part,st => rs.subj ! part ! st ;
        pred = \\st => sent.subj ! Ga ! st ++ sent.pred ! Plain ++ "ことを" ++ 
                       rs.pred ! Inanim ! st ;
        }
      } ;
}
