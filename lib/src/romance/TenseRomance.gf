incomplete concrete TenseRomance of Tense = 
  CatRomance [Tense,Temp], TenseX [Ant,Pol,AAnter,ASimul,PNeg,PPos] ** 
    open ResRomance, CommonRomance in {

  lin
    TTAnt t a = {s = a.s ++ t.s ; a = a.a ; t = t.t} ;
    TPres = {s = []} ** {t = RPres} ;
    TPast = {s = []} ** {t = RPast} ;   --# notpresent
    TFut  = {s = []} ** {t = RFut} ;    --# notpresent
    TCond = {s = []} ** {t = RCond} ;   --# notpresent

}
