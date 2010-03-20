--# -path=.:present

concrete PhrasebookRon of Phrasebook = 
  GreetingsRon,
  FoodRon
  ** open 
    SyntaxRon,
    ResRon, ---- for Num to Utt 
    Prelude in {

lincat 
  Phrase = Utt ;

lin
  PNumeral n = mkPhrase (ss ((mkCard <n : Numeral>).sp ! Masc)) ; ----
  PGreeting g = mkPhrase g ;
  PSentence s = s ;

oper 
  mkPhrase : SS -> Utt = \s -> lin Utt s ;

}
