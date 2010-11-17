concrete CommonX of Common = open (R = ParamX) in {

  lincat
    Text = {s : Str} ; 
    Phr = {s : Str} ; 
    Utt = {s : Str} ; 
    Voc = {s : Str} ; 
    SC  = {s : Str} ; 
    Adv = {s : Str} ; 
    AdV = {s : Str} ; 
    AdA = {s : Str} ; 
    AdN = {s : Str} ; 
    IAdv = {s : Str} ; 
    CAdv = {s,p : Str} ; 
    PConj = {s : Str} ; 
    Interj = {s : Str} ; 

    Temp  = {s : Str ; t : R.Tense ; a : R.Anteriority} ;
    Tense = {s : Str ; t : R.Tense} ;
    Ant   = {s : Str ; a : R.Anteriority} ;
    Pol   = {s : Str ; p : R.Polarity} ;

}
