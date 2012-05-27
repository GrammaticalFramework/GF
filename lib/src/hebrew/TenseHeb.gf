concrete TenseHeb of Tense = CatHeb [Tense,Temp], TenseX [Ant,Pol,AAnter,ASimul,PNeg,PPos] ** open ResHeb, Prelude in {
 
flags coding = utf8 ;

 lin
  
    TTAnt t a = {
      s = t.s ++ a.s ; 
      t = t.t ;
      a = a.a
      } ;

     TPres, TCond = {s = []} ** {t = Perf} ;
     TFut = {s = []} ** {t = Imperf } ;
     TPast = {s = []} ** {t = Part} ;
  
}
