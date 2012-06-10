concrete RelativeJpn of Relative = CatJpn ** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin

    RelCl cl = {
      s = \\_,st,t,p => cl.s ! Ga ! st ! t ! p ;
      te = \\_ => cl.te ! Ga ;
      changePolar = cl.changePolar ;
      subj = cl.subj ;
      pred = \\_,st,t,p => cl.pred ! st ! t ! p ;
      pred_te = \\a => cl.pred_te ;
      pred_ba = \\a => cl.pred_ba ;
      missingSubj = False
      } ;
    
    RelVP rp vp = {
      s = \\a,st,t,p => vp.prepositive ! st ++ rp.s ! st ++ vp.obj ! st ++ 
                        vp.prep ++ vp.verb ! SomeoneElse ! a ! Plain ! t ! p ;
      te = \\a,st,p => vp.prepositive ! st ++ rp.s ! st ++ vp.obj ! st ++ 
                      vp.prep ++ vp.te ! SomeoneElse ! a ! st ! p ;
      changePolar = False ;
      subj = \\part,st => vp.prepositive ! st ++ rp.s ! st ;
      pred = \\a,st,t,p => vp.obj ! st ++ vp.prep ++ 
                           vp.verb ! SomeoneElse ! a ! st ! t ! p ;
      pred_te = \\a,st,p => vp.obj ! st ++ vp.prep ++ vp.te ! SomeoneElse ! a ! st ! p ;
      pred_ba = \\a,st,p => vp.obj ! st ++ vp.prep ++ vp.ba ! SomeoneElse ! a ! st ! p ;
      missingSubj = True
      } ;
    
    RelSlash rp clslash = {
      s = \\_,st,t,p => case rp.null of {
        True => rp.s ! st ++ clslash.s ! st ! t ! p ;
        False => clslash.subj ! Ga ! st ++ rp.s ! st ++ clslash.pred ! Plain ! t ! p 
        } ;
      te = \\_,st,p => case rp.null of {
        True => rp.s ! st ++ clslash.te ! st ! p ;
        False => clslash.subj ! Ga ! st ++ rp.s ! st ++ clslash.pred_te ! st ! p 
        } ;
      changePolar = clslash.changePolar ;
      subj = \\part,st => rp.s ! st ++ clslash.subj ! part ! st ;
      pred = \\_,st,t,p => clslash.pred ! st ! t ! p ;
      pred_te = \\a => clslash.pred_te ;
      pred_ba = \\a => clslash.pred_ba ;
      missingSubj = False
      } ;
    
    IdRP = {s = \\st => [] ; null = True} ;
    
    FunRP prep np rp = {s = \\st => np.prepositive ! st ++ np.s ! st ; null = False} ;
}
