--# -path=.:present

concrete PhrasebookEng of Phrasebook = 
  GreetingsEng,
  FoodEng ** open 
    SyntaxEng,
    ResEng, ---- for Num to Utt 
    Prelude in {

lincat 
  Phrase = Utt ;

lin
  PNumeral n = 
    mkPhrase (ss ((SyntaxEng.mkCard <n : Numeral>).s ! Nom)) ; ----
  PGreeting g = mkPhrase g ;
  PSentence s = s ;


oper 
  mkPhrase : SS -> Utt = \s -> lin Utt s ;

}
