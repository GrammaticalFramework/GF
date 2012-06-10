concrete TenseJpn of Tense = CatJpn ** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin
  
    TTAnt t a = {
      s = t.s ++ a.s ; 
      t = t.t ;
      a = a.a
      } ;

    PPos  = {s = [] ; b = Pos} ;
    PNeg  = {s = [] ; b = Neg} ;

    TPres, TCond = {s = [] ; t = ResJpn.TPres} ;
    TPast = {s = [] ; t = ResJpn.TPast} ;
    TFut  = {s = [] ; t = ResJpn.TFut} ;

    ASimul = {s = [] ; a = Simul} ;
    AAnter = {s = [] ; a = Anter} ;

}
