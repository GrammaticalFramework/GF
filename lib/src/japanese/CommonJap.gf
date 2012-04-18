concrete CommonJap of Common = open ResJap, Prelude in { 

flags coding = utf8 ;

  lincat  

    Text, Phr, PConj, Interj, AdV, AdA = {s : Str} ;
    
    Utt = {s : Style => Str} ;
    
    Voc = {s : Style => Str ; please : Bool} ;
    
    SC = {s : Particle => Style => Str ; isVP : Bool} ;
    
    Adv = Adverb ;  -- {s : Style => Str ; prepositive : Bool ; compar : ComparSense} ;
    
    AdN = {s : Str ; postposition : Bool} ;
    
    IAdv = {s : Style => Str ; particle : Str} ;
    
    CAdv = {s : Str ; compar : ComparSense} ;
    
    Temp = {s : Str ; t : TTense ; a : Anteriority} ;
    Tense = {s : Str ; t : TTense} ;
    Pol = {s : Str ; b : Polarity} ;
    Ant = {s : Str ; a : Anteriority} ;

}