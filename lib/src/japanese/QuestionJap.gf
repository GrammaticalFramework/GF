concrete QuestionJap of Question = CatJap
** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin
  
    QuestCl cl = {   -- ending "ka" is added at the utterance level
      s = cl.s ;
      changePolar = cl.changePolar
      } ;

    QuestVP ip vp = {
      s = \\part,st,t,p => case ip.how8many of {
        True => ip.s ! st ++ vp.obj ! st ++ vp.prep ++ vp.verb ! ip.anim ! st ! t ! p ;
        False => ip.s ! st ++ "が" ++ vp.obj ! st ++ vp.prep ++ vp.verb ! ip.anim ! st ! t ! p 
        } ;
      changePolar = False
      } ;
                   
    QuestSlash ip clslash = {
      s = \\part,st,t,p => clslash.subj ! part ! st ++ ip.s ! st ++ clslash.pred ! st ! t ! p ;
      changePolar = False
      } ;
    
    QuestIAdv iadv cl = {
      s = \\part,st,t,p => cl.subj ! part ! st ++ iadv.s ! st ++ iadv.particle ++
                           cl.pred ! st ! t ! p ;
      changePolar = cl.changePolar
      } ;

    QuestIComp icomp np = {
      s = table {
        Wa => \\st,t,p => case np.needPart of {
          True => np.prepositive ! st ++ np.s ! st ++ "わ" ++ icomp.s ! st ++ 
                  mkCopula.s ! st ! t ! p ;
          False => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ mkCopula.s ! st ! t ! p 
          } ;
        Ga => \\st,t,p => case np.needPart of {
          True => np.prepositive ! st ++ np.s ! st ++ "が" ++ icomp.s ! st ++ 
                  mkCopula.s ! st ! t ! p ;
          False => np.prepositive ! st ++ np.s ! st ++ icomp.s ! st ++ mkCopula.s ! st ! t ! p 
          } 
        } ;
      changePolar = np.changePolar
      } ;

    IdetCN idet cn = {
      s = \\st => case idet.how8many of {
        True => cn.prepositive ! st ++ cn.object ! st ++ cn.s ! idet.n ! st ++ "が" ++ idet.s ;
        False => cn.prepositive ! st ++ cn.object ! st ++ idet.s ++ cn.s ! idet.n ! st 
        } ;
      anim = cn.anim ;
      how8many = idet.how8many
      } ;
    
    IdetIP idet = {
      s = \\st => case idet.inclCard of {
        True => idet.s ++ "つ" ;
        False => idet.s
        } ;
      anim = Inanim ; -- can be Anim, depending on the context 
      how8many = False -- "how many" alone behaves as other IPs
      } ;

    AdvIP ip adv = {
      s = \\st => adv.s ! st ++ ip.s ! st ;
      anim = ip.anim ;
      how8many = ip.how8many
      } ;
    
    IdetQuant iquant num = {
      s = iquant.s ++ num.s ; 
      n = num.n ; 
      how8many = False ;
      inclCard = num.inclCard
      } ;

    PrepIP prep ip = {s = \\st => ip.s ! st ++ prep.s ; particle = ""} ;

    AdvIAdv iadv adv = {s = \\st => adv.s ! st ++ iadv.s ! st ; particle = iadv.particle} ;
    
    CompIAdv iadv = {s = iadv.s} ;
    
    CompIP ip = {s = ip.s} ;
    
  lincat
    
    QVP = {s : Animateness => Style => TTense => Polarity => Str ; prepositive : Style => Str} ;
    
  lin
          
    ComplSlashIP vpslash ip = {
      s = \\a,st,t,p => vpslash.obj ! st ++ ip.s ! st ++ vpslash.prep ++ vpslash.s ! st ! t ! p ;
      prepositive = vpslash.prepositive
      } ;
    
    AdvQVP vp iadv = {
      s = \\a,st,t,p => iadv.s ! st ++ iadv.particle ++ vp.obj ! st ++ vp.prep ++ 
                        vp.verb ! a ! st ! t ! p ;
      prepositive = vp.prepositive
      } ;
    
    AddAdvQVP qvp iadv = {
      s = \\a,st,t,p => iadv.s ! st ++ iadv.particle ++ qvp.s ! a ! st ! t ! p ;
      prepositive = qvp.prepositive
      } ;
    
    QuestQVP ip qvp = {
      s = \\part,st,t,p => qvp.prepositive ! st ++ ip.s ! st ++ "が" ++ 
                           qvp.s ! ip.anim ! st ! t ! p ;
      changePolar = False
      } ;
}
