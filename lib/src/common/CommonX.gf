concrete CommonX of Common = open (R = ParamX) in {

  lincat
    Text = {s : Str} ; --lock_Text : {}} ;
    Phr = {s : Str} ; --lock_Phr : {}} ;
    Utt = {s : Str} ; --lock_Utt : {}} ;
    Voc = {s : Str} ; --lock_Voc : {}} ;
    SC  = {s : Str} ; --lock_SC : {}} ;
    Adv = {s : Str} ; --lock_Adv : {}} ;
    AdV = {s : Str} ; --lock_AdV : {}} ;
    AdA = {s : Str} ; --lock_AdA : {}} ;
    AdN = {s : Str} ; --lock_AdN : {}} ;
    IAdv = {s : Str} ; --lock_IAdv : {}} ;
    CAdv = {s,p : Str} ; --lock_CAdv : {}} ;
    PConj = {s : Str} ; --lock_PConj : {}} ;

    Temp  = {s : Str ; t : R.Tense ; a : R.Anteriority} ;
    Tense = {s : Str ; t : R.Tense} ;
    Ant   = {s : Str ; a : R.Anteriority} ;
    Pol   = {s : Str ; p : R.Polarity} ;

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
