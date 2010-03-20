--# -path=.:present

concrete PhrasebookFin of Phrasebook = 
  GreetingsFin,
  FoodFin ** open 
    SyntaxFin,
    ResFin, ---- for Num to Utt 
    Prelude in {

lincat 
  Phrase = Utt ;

lin
  PNumeral n = 
    mkPhrase (ss ((SyntaxFin.mkCard <n : Numeral>).s ! Sg ! Nom)) ; ----
  PGreeting g = mkPhrase g ;
  PSentence s = s ;


oper 
  mkPhrase : SS -> Utt = \s -> lin Utt s ;

}
