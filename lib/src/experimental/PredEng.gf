concrete PredEng of Pred = 
  CatEng [Ant,NP,Utt,IP,IAdv,IComp,Conj,RP,RS] ** 
    PredFunctor - [QuestIComp]  ---- IComp has no parameters in Eng
  with 
      (PredInterface = PredInstanceEng) 

  ** open PredInstanceEng, (R = ResEng) in {

lin
  QuestIComp a t p icomp np = 
    let vagr = (agr2vagr np.a) in
    initPrClause ** {
    v    = tenseCopula (a.s ++ t.s ++ p.s) t.t a.a p.p vagr ;
    subj = np.s ! subjCase ;
    foc = icomp.s ;
    focType = FocObj ;
    qforms = qformsCopula (a.s ++ t.s ++ p.s) t.t a.a p.p vagr ; 
    } ;

  NomVPNP vpi = {
    s = \\c => vpi.s ! R.VVPresPart ! defaultAgr ;
    a = defaultAgr
    } ;


  ByVP x vp vpi = vp ** {adv = "by" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr
  WhenVP x vp vpi = vp ** {adv = "when" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr
  BeforeVP x vp vpi = vp ** {adv = "before" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr
  AfterVP x vp vpi = vp ** {adv = "after" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr
  InOrderVP x vp vpi = vp ** {adv = "in order" ++ vpi.s ! R.VVInf ! defaultAgr} ; ---- agr
  WithoutVP x vp vpi = vp ** {adv = "without" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr

}
