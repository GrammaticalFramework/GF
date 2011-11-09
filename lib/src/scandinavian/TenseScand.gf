incomplete concrete TenseScand of Tense = 
  CatScand [Tense,Temp], TenseX [Ant,Pol,AAnter,ASimul,PNeg,PPos] ** 
    open ResScand, CommonScand in {

  lin

    TTAnt t a = {s = a.s ++ t.s ; a = a.a ; t = t.t} ;
    TPres = {s = []} ** {t = SPres} ;
    TPast = {s = []} ** {t = SPast} ;   --# notpresent
    TFut  = {s = []} ** {t = SFut} ;    --# notpresent
    TCond = {s = []} ** {t = SCond} ;   --# notpresent

param 
 STense =
      SPres
    | SPast   --# notpresent
    | SFut    --# notpresent
    | SFutKommer   --# notpresent
    | SCond   --# notpresent
    ;

}
