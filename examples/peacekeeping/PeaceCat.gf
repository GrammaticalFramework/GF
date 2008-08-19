abstract PeaceCat = {

  cat
    N; A; V; V2; V3; Pron;
    IP; IAdv;
    Adv; NP; CN; Imp; Det; Num;
    MassN ;
    Phrase ;
    PhraseWritten ;
    PhraseSpoken ;
    Sent ; 
    Quest ; 
    MassCN ; 

  fun 
    Written : Phrase -> PhraseWritten ;
    Spoken : Phrase -> PhraseSpoken ;

}