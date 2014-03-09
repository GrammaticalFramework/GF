concrete NDPredChi of NDPred = 
  CatChi [NP,Utt,IP,IAdv,IComp,Conj,RS,RP,Subj] ** 
    NDPredFunctor
     with 
      (PredInterface = PredInstanceChi),
      (Pred = PredChi) ** open PredChi in {

lincat Ant = PredChi.Ant ;

}
