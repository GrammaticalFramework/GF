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

}
