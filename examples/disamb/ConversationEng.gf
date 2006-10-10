--# -path=.:prelude

concrete ConversationEng of Conversation = open Prelude in {

  lincat 
    Q, NP, A = {s : Str} ;
    Gender, Number, Politeness = {s : Str} ;

  lin
    PredA np a = ss ("are" ++ np.s ++ a.s) ;

    GMasc = ss (optStr "man") ;
    GFem  = ss (optStr "woman") ;
    NSg   = ss (optStr "one") ;
    NPl   = ss (optStr "many") ;
    PFamiliar = ss (optStr "friend") ;
    PPolite   = ss (optStr "respected") ;

    You n p g = ss ("you" ++ n.s ++ p.s ++ g.s) ;

    Ready = ss "ready" ;

}
