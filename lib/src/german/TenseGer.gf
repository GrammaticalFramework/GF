concrete TenseGer of Tense = 
  CatGer [Tense,Temp], TenseX [Ant,Pol,AAnter,ASimul,PNeg,PPos] ** open ResGer in {

  lin
    TTAnt t a = {s = t.s ++ a.s ; t = t.t ; a = a.a ; m = t.m} ;

    TPres = {s = [] ; t = Pres ; m = MIndic} ;
    TPast = {s = [] ; t = Past ; m = MIndic} ;   --# notpresent
    TFut  = {s = [] ; t = Fut  ; m = MIndic} ;   --# notpresent
    TCond = {s = [] ; t = Cond ; m = MIndic} ;   --# notpresent

}
