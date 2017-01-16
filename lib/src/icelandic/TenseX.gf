concrete TenseX of Tense = CommonX ** open (R = ParamX) in {

  lin
    TTAnt t a = {s = t.s ++ a.s ; t = t.t ; a = a.a} ;

    PPos  = {s = []} ** {p = R.Pos} ;
    PNeg  = {s = []} ** {p = R.Neg} ;
    TPres = {s = []} ** {t = R.Pres} ;
    TPast = {s = []} ** {t = R.Past} ;   --# notpresent
    TFut  = {s = []} ** {t = R.Fut} ;    --# notpresent
    TCond = {s = []} ** {t = R.Cond} ;   --# notpresent
    ASimul = {s = []} ** {a = R.Simul} ;
    AAnter = {s = []} ** {a = R.Anter} ; --# notpresent
}
