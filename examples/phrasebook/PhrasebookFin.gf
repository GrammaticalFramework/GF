--# -path=.:present

concrete PhrasebookFin of Phrasebook = 
  GreetingsFin,
  WordsFin ** open 
    SyntaxFin,
    ResFin, ---- for Num to Utt 
    Prelude in {

lincat 
  Phrase = Text ;

lin
  PNumeral n = 
    mkPhrase (ss ((SyntaxFin.mkCard <n : Numeral>).s ! Sg ! Nom)) ; ----
  PGreeting g = mkPhrase g ;
  PSentence s = mkText s ;
  PQuestion s = mkText s ;


oper 
  mkPhrase : SS -> Utt = \s -> lin Utt s ;

}
