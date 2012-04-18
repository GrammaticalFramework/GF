concrete RelativeJap of Relative = CatJap ** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin

    RelCl cl = {
      s = \\_,st,t,p => cl.s ! Ga ! st ! t ! p ;
      te = \\_,st => cl.te ! Ga ! st ;
      changePolar = cl.changePolar ;
      subj = cl.subj ;
      pred = \\_,st,t,p => cl.pred ! st ! t ! p ;
      pred_te = \\a,st => cl.pred_te ! st ;
      pred_tara = \\a,st => cl.pred_tara ! st ;
      missingSubj = False
      } ;
    
    RelVP rp vp = {
      s = \\a,st,t,p => vp.prepositive ! st ++ rp.s ! st ++ vp.obj ! st ++ 
                        vp.prep ++ vp.verb ! a ! Plain ! t ! p ++ rp.prep ;
      te = \\a,st => vp.prepositive ! st ++ rp.s ! st ++ vp.obj ! st ++ 
                      vp.prep ++ vp.te ! a ! st ++ rp.prep ;
      changePolar = False ;
      subj = \\part,st => vp.prepositive ! st ++ rp.s ! st ;
      pred = \\a,st,t,p => vp.obj ! st ++ vp.prep ++ vp.verb ! a ! st ! t ! p ++ rp.prep ;
      pred_te = \\a,st => vp.obj ! st ++ vp.prep ++ vp.te ! a ! st ++ rp.prep ;
      pred_tara = \\a,st => vp.obj ! st ++ vp.prep ++ vp.tara ! a ! st ++ rp.prep ;
      missingSubj = True
      } ;
    
    RelSlash rp clslash = {
      s = \\_,st,t,p => rp.s ! st ++ clslash.s ! st ! t ! p ++ rp.prep ;
      te = \\_,st => rp.s ! st ++ clslash.te ! st ;
      changePolar = clslash.changePolar ;
      subj = \\part,st => rp.s ! st ++ clslash.subj ! part ! st ;
      pred = \\_,st,t,p => clslash.pred ! st ! t ! p ++ rp.prep ;
      pred_te = \\a,st => clslash.pred_te ! st ++ rp.prep ;
      pred_tara = \\a,st => clslash.pred_tara ! st ++ rp.prep ;
      missingSubj = False
      } ;
    
    IdRP = {s = \\st => [] ; prep = []} ;
    
    FunRP prep np rp = {
      s = \\st => np.prepositive ! st ++ np.s ! st ; 
      prep = prep.relPrep
      } ;
}