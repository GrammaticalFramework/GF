concrete CommonX of Common = open (R = ParamX) in {

  lincat
    Text, Phr = {s : Str} ;

    Tense = {s : Str ; t : R.Tense} ;
    Ant   = {s : Str ; a : R.Anteriority} ;
    Pol   = {s : Str ; p : R.Polarity} ;

  lin
    PPos  = {s = []} ** {p = R.Pos} ;
    PNeg  = {s = []} ** {p = R.Neg} ;
    TPres = {s = []} ** {t = R.Pres} ;
    TPast = {s = []} ** {t = R.Past} ;   --# notpresent
    TFut  = {s = []} ** {t = R.Fut} ;    --# notpresent
    TCond = {s = []} ** {t = R.Cond} ;   --# notpresent
    ASimul = {s = []} ** {a = R.Simul} ;
    AAnter = {s = []} ** {a = R.Anter} ; --# notpresent

}
