--# -path=.:present

concrete PhrasebookRon of Phrasebook = 
  GreetingsRon,
  WordsRon
  ** open 
    SyntaxRon,
    ResRon, ---- for Num to Utt 
    Prelude in {

lincat 
  Phrase = Text ;

lin
  PNumeral n = mkPhrase (ss ((mkCard <n : Numeral>).sp ! Masc)) ; ----
  PGreeting g = mkPhrase g ;
  PSentence s = mkText s ;
  PQuestion s = mkText s ;

oper 
  mkPhrase : SS -> Utt = \s -> lin Utt s ;

}
