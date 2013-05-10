concrete CommonGre of Common = open (R = ParamX), ResGre in { 

flags coding = utf8 ;

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
    CAdv = {s ,s2: Str; p : Str} ** {c:Case};
    PConj = {s : Str} ; 
    Interj = {s : Str} ;
    
    
    Temp = {s : Str ;  t : TTense ; a : R.Anteriority ;m : Mood  }  ;
    Tense = {s : Str ; t : TTense ; m : Mood } ;
    Ant   = {s : Str ; a : R.Anteriority} ;
    Pol   = {s : Str ; p : R.Polarity} ;
    

  

    }