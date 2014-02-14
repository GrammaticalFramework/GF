concrete PredEng of Pred = 
  CatEng [Ant,NP,Utt,IP,IAdv,IComp,Conj,RP,RS] ** 
    PredFunctor - [QuestIComp]  ---- IComp has no parameters in Eng
  with 
      (PredInterface = PredInstanceEng) 

  ** open PredInstanceEng in {

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

}
