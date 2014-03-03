concrete PredChi of Pred = 
  CatChi [NP,Utt,IP,IAdv,IComp,Conj,RP,RS,Imp] ** 
    PredFunctor
    with 
      (PredInterface = PredInstanceChi) ** open TenseX in {

lincat Ant = {s : Str ; a : Anteriority} ;

}
