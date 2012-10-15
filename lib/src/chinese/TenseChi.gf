concrete TenseChi of Tense = 
  CatChi [Tense,Temp], TenseX [Ant,Pol,AAnter,ASimul,PNeg,PPos] ** open ResChi in {

  lin
    TTAnt t a = {s = t.s ++ a.s ; t = t.t} ;

    ---- ??
    TPres = {s = [] ; t = APlain} ;
    TPast = {s = [] ; t = APerf} ;   
    TFut  = {s = [] ; t = ADurProg} ;   
    TCond = {s = [] ; t = ADurStat} ;

}
