concrete PredFin of Pred = 
  CatFin [Ant,NP,Utt,IP,IAdv,Conj] ** 
--    PredFunctor [NP,Pol,Tense,Ant,Arg,  PPos, TPres, ASimul, aNone,
--                 PrV,PrVP,PrCl,PrS,UseV,PredVP,UseCl]
-- - [StartVPC, ContVPC, ---- need generalization
--                   AgentPassUseV,AgentPastPartAP]     ---- moreover slow

    PredFunctor - 
      [StartVPC, ContVPC, AgentPassUseV, ComplVA, ComplVN, ComplVV,SlashV2A,SlashV2V,SlashV2N]
      with 
      (PredInterface = PredInstanceFin) 

  ** {

lin 
  StartVPC, ContVPC, AgentPassUseV, ComplVA, ComplVN, ComplVV,SlashV2A,SlashV2V,SlashV2N
    = variants {} ; ---- just to make it compile as instance of Pred
} 
