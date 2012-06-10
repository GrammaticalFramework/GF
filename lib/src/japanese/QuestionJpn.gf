concrete QuestionJpn of Question = CatJpn
** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin
  
    QuestCl cl = {
      s = \\part,st,t,p => cl.s ! part ! st ! t ! p ++ "か" ;
      s_plain_pred = \\part,st,t,p => cl.subj ! part ! st ++ cl.pred ! Plain ! t ! p ++ "か" ;
      changePolar = cl.changePolar
      } ;

    QuestVP ip vp = {
      s = \\part,st,t,p => case ip.how8many of {
        True => ip.s_subj ! st ++ vp.obj ! st ++ vp.prep ++ 
                vp.verb ! SomeoneElse ! ip.anim ! st ! t ! p ++ "か" ;
        False => ip.s_subj ! st ++ "が" ++ vp.obj ! st ++ vp.prep ++ 
                 vp.verb ! SomeoneElse ! ip.anim ! st ! t ! p ++ "か" 
        } ;
      s_plain_pred = \\part,st,t,p => case ip.how8many of {
        True => ip.s_subj ! st ++ vp.obj ! st ++ vp.prep ++ 
                vp.verb ! SomeoneElse ! ip.anim ! Plain ! t ! p ++ "か" ;
        False => ip.s_subj ! st ++ "が" ++ vp.obj ! st ++ vp.prep ++ 
                 vp.verb ! SomeoneElse ! ip.anim ! Plain ! t ! p ++ "か" 
        } ;
      changePolar = False
      } ;
                   
    QuestSlash ip clslash = {
      s = \\part,st,t,p => clslash.subj ! part ! st ++ ip.s_obj ! st ++ clslash.pred ! st ! t ! p 
                           ++ "か" ;
      s_plain_pred = \\part,st,t,p => clslash.subj ! part ! st ++ ip.s_obj ! st ++ 
                                      clslash.pred ! Plain ! t ! p ++ "か" ;
      changePolar = False
      } ;
    
    QuestIAdv iadv cl = {
      s = \\part,st,t,p => cl.subj ! part ! st ++ iadv.s ! st ++ iadv.particle ++
                           cl.pred ! st ! t ! p ++ "か" ;
      s_plain_pred = \\part,st,t,p => cl.subj ! part ! st ++ iadv.s ! st ++ iadv.particle ++
                                      cl.pred ! Plain ! t ! p ++ "か" ;
      changePolar = cl.changePolar
      } ;

    QuestIComp icomp np = {
      s = table {
        Wa => \\st,t,p => case <np.needPart, icomp.wh8re> of {
          <True, True> => np.prepositive ! st ++ np.s ! st ++ "は" ++ icomp.s ! st ++ "に" ++
                          mkExistV.verb ! SomeoneElse ! np.anim ! st ! t ! p ++ "か" ;
          <False, True> => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ "に" ++
                           mkExistV.verb ! SomeoneElse ! np.anim ! st ! t ! p ++ "か" ;
          <True, False> => np.prepositive ! st ++ np.s ! st ++ "は" ++ icomp.s ! st ++ 
                           mkCopula.s ! st ! t ! p ++ "か" ;
          <False, False> => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ 
                            mkCopula.s ! st ! t ! p ++ "か" 
          } ;
        Ga => \\st,t,p => case <np.needPart, icomp.wh8re> of {
          <True, True> => np.prepositive ! st ++ np.s ! st ++ "が" ++ icomp.s ! st ++ "に" ++
                          mkExistV.verb ! SomeoneElse ! np.anim ! st ! t ! p ++ "か" ;
          <False, True> => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ "に" ++
                           mkExistV.verb ! SomeoneElse ! np.anim ! st ! t ! p ++ "か" ;
          <True, False> => np.prepositive ! st ++ np.s ! st ++ "が" ++ icomp.s ! st ++ 
                           mkCopula.s ! st ! t ! p ++ "か" ;
          <False, False> => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ 
                            mkCopula.s ! st ! t ! p ++ "か" 
          } 
        } ;
      s_plain_pred = table {
        Wa => \\st,t,p => case <np.needPart, icomp.wh8re> of {
          <True, True> => np.prepositive ! st ++ np.s ! st ++ "は" ++ icomp.s ! st ++ "に" ++
                          mkExistV.verb ! SomeoneElse ! np.anim ! Plain ! t ! p ++ "か" ;
          <False, True> => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ "に" ++
                           mkExistV.verb ! SomeoneElse ! np.anim ! Plain ! t ! p ++ "か" ;
          <True, False> => np.prepositive ! st ++ np.s ! st ++ "は" ++ icomp.s ! st ++ 
                           mkCopula.s ! Plain ! t ! p ++ "か" ;
          <False, False> => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ 
                            mkCopula.s ! Plain ! t ! p ++ "か" 
          } ;
        Ga => \\st,t,p => case <np.needPart, icomp.wh8re> of {
          <True, True> => np.prepositive ! st ++ np.s ! st ++ "が" ++ icomp.s ! st ++ "に" ++
                          mkExistV.verb ! SomeoneElse ! np.anim ! Plain ! t ! p ++ "か" ;
          <False, True> => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ "に" ++
                           mkExistV.verb ! SomeoneElse ! np.anim ! Plain ! t ! p ++ "か" ;
          <True, False> => np.prepositive ! st ++ np.s ! st ++ "が" ++ icomp.s ! st ++ 
                           mkCopula.s ! Plain ! t ! p ++ "か" ;
          <False, False> => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ 
                            mkCopula.s ! Plain ! t ! p ++ "か" 
          } 
        } ;
      changePolar = np.changePolar
      } ;

    IdetCN idet cn = {
      s_subj = \\st => case idet.how8many of {
        True => cn.prepositive ! st ++ cn.object ! st ++ cn.s ! idet.n ! st ++ "が" ++ idet.s ;
        False => cn.prepositive ! st ++ cn.object ! st ++ idet.s ++ cn.s ! idet.n ! st 
        } ;
      s_obj = \\st => case idet.how8many of {
        True => cn.prepositive ! st ++ cn.object ! st ++ idet.s ++ "の" ++ cn.s ! idet.n ! st ;
        False => cn.prepositive ! st ++ cn.object ! st ++ idet.s ++ cn.s ! idet.n ! st 
        } ;
      anim = cn.anim ;
      how8many = idet.how8many
      } ;
    
    IdetIP idet = {
      s_subj, s_obj = \\st => case idet.inclCard of {
        True => idet.s ++ "つ" ;
        False => idet.s
        } ;
      anim = Inanim ; -- can be Anim, depending on the context 
      how8many = False -- "how many" alone behaves as other IPs
      } ;

    AdvIP ip adv = {
      s_subj = \\st => adv.s ! st ++ ip.s_subj ! st ;
      s_obj = \\st => adv.s ! st ++ ip.s_obj ! st ;
      anim = ip.anim ;
      how8many = ip.how8many
      } ;
    
    IdetQuant iquant num = {
      s = iquant.s ++ num.s ; 
      n = num.n ; 
      how8many = False ;
      inclCard = num.inclCard
      } ;

    PrepIP prep ip = {s = \\st => ip.s_obj ! st ++ prep.s ; particle = "" ; wh8re = False} ;

    AdvIAdv iadv adv = {s = \\st => adv.s ! st ++ iadv.s ! st ; 
                        particle = iadv.particle ; wh8re = iadv.wh8re} ;
    
    CompIAdv iadv = {s = iadv.s ; wh8re = iadv.wh8re} ;
    
    CompIP ip = {s = ip.s_obj ; wh8re = False} ;
    
  lincat
    
    QVP = {s : Animateness => Style => TTense => Polarity => Str ; prepositive : Style => Str} ;
    
  lin
          
    ComplSlashIP vpslash ip = {
      s = \\a,st,t,p => vpslash.obj ! st ++ ip.s_obj ! st ++ vpslash.prep ++ 
                        vpslash.s ! SomeoneElse ! st ! t ! p ;
      prepositive = vpslash.prepositive
      } ;
    
    AdvQVP vp iadv = {
      s = \\a,st,t,p => iadv.s ! st ++ iadv.particle ++ vp.obj ! st ++ vp.prep ++ 
                        vp.verb ! SomeoneElse ! a ! st ! t ! p ;
      prepositive = vp.prepositive
      } ;
    
    AddAdvQVP qvp iadv = {
      s = \\a,st,t,p => iadv.s ! st ++ iadv.particle ++ qvp.s ! a ! st ! t ! p ;
      prepositive = qvp.prepositive
      } ;
    
    QuestQVP ip qvp = {
      s = \\part,st,t,p => case ip.how8many of {
        True => qvp.prepositive ! st ++ ip.s_subj ! st ++ qvp.s ! ip.anim ! st ! t ! p ++ "か" ;
        False => qvp.prepositive ! st ++ ip.s_subj ! st ++ "が" ++ qvp.s ! ip.anim ! st ! t ! p 
                 ++ "か"
        } ;
      s_plain_pred = \\part,st,t,p => case ip.how8many of {
        True => qvp.prepositive ! st ++ ip.s_subj ! st ++ qvp.s ! ip.anim ! Plain ! t ! p ++ "か" ;
        False => qvp.prepositive ! st ++ ip.s_subj ! st ++ "が" ++ qvp.s ! ip.anim ! Plain ! t ! p 
                 ++ "か"
        } ;
      changePolar = False
      } ;
}
