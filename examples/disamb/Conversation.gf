abstract Conversation = {

  cat 
    Q ; NP ; A ;
    Gender ; Number ; Politeness ;

  fun
    PredA : NP -> A -> Q ;

    GMasc, GFem : Gender ;
    NSg, NPl : Number ;
    PFamiliar, PPolite : Politeness ;

    You : Number -> Politeness ->  Gender -> NP ;

    Ready : A ;

}
