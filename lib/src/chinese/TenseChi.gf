concrete TenseChi of Tense = 
  CatChi [Tense,Temp,Ant], TenseX [Pol,PNeg,PPos] ** open ResChi in {

  lin
    TTAnt t a = {s = t.s ++ a.s ; t = case a.t of {APerf => APerf ; _ => t.t}} ;

    ---- ??
    TPres = {s = [] ; t = APlain} ;
    TPast = {s = [] ; t = APerf} ;   
    TFut  = {s = [] ; t = ADurProg} ;   
    TCond = {s = [] ; t = ADurStat} ;

    ASimul = {s = [] ; t = APlain} ;
    AAnter = {s = [] ; t = APerf} ;   

}
