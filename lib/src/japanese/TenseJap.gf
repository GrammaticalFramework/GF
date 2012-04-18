concrete TenseJap of Tense = CatJap ** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin
  
    TTAnt t a = {
      s = t.s ++ a.s ; 
      t = t.t ;
      a = a.a
      } ;

    PPos  = {s = [] ; b = Pos} ;
    PNeg  = {s = [] ; b = Neg} ;

    TPres, TCond = {s = [] ; t = ResJap.TPres} ;
    TPast = {s = [] ; t = ResJap.TPast} ;
    TFut  = {s = [] ; t = ResJap.TFut} ;

    ASimul = {s = [] ; a = Simul} ;
    AAnter = {s = [] ; a = Anter} ;

}