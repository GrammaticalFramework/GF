concrete CommonJpn of Common = open ResJpn, Prelude in { 

flags coding = utf8 ;

  lincat  

    PConj, Interj, AdV, AdA = {s : Str} ;
    
    Phr, Text = {s : Str} ;
    
    Utt = {s : Particle => Style => Str ; type : UttType} ;
    
    Voc = {s : Style => Str ; type : VocType ; null : Str} ;
    
    SC = {s : Particle => Style => Str ; isVP : Bool} ;
    
    Adv = Adverb ;  -- {s : Style => Str ; prepositive : Bool ; compar : ComparSense} ;
    
    AdN = {s : Str ; postposition : Bool} ;
    
    IAdv = {s : Style => Str ; particle : Str ; wh8re : Bool} ;
    
    CAdv = {s : Str ; less : Bool ; s_adn : Str} ;
    
    Temp = {s : Str ; t : TTense ; a : Anteriority} ;
    Tense = {s : Str ; t : TTense} ;
    Pol = {s : Str ; b : Polarity} ;
    Ant = {s : Str ; a : Anteriority} ;
}
