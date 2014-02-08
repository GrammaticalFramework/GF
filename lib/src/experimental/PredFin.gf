concrete PredFin of Pred = 
  CatFin [Ant,NP,Utt,IP,IAdv,Conj] ** 
    PredFunctor - [StartVPC, ContVPC, ---- need generalization
                   AgentPassUseV,AgentPastPartAP]     ---- moreover slow
      with 
      (PredInterface = PredInstanceFin) 

  ** {

lin StartVPC, ContVPC, AgentPassUseV, AgentPastPartAP = variants {} ; ---- just to make it compile as instance of Pred

} 
