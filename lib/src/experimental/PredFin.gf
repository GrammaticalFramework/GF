concrete PredFin of Pred = 
  CatFin [Ant,NP,Utt,IP,IAdv,Conj] ** 
    PredFunctor 
     - [StartVPC, ContVPC 
----        ,AgentPassUseV, ComplVA, ComplVN, ComplVV,SlashV2A,SlashV2V,SlashV2N
       ]
    with 
      (PredInterface = PredInstanceFin) 

  ** {

lin 
  StartVPC, ContVPC
----  , AgentPassUseV, ComplVA, ComplVN, ComplVV,SlashV2A,SlashV2V,SlashV2N
    = variants {} ; ---- just to make it compile as instance of Pred
} 
