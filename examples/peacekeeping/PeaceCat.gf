abstract PeaceCat = Cat ** {

  cat
    MassN ;
    Phrase ;
    PhraseWritten ;
    PhraseSpoken ;

  fun 
    Written : Phrase -> PhraseWritten ;
    Spoken : Phrase -> PhraseSpoken ;

}