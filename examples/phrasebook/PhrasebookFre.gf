--# -path=.:present

concrete PhrasebookFre of Phrasebook = 
  GreetingsFre,
  FoodFre
  ** open 
    SyntaxFre,
    ParadigmsFre,
    ResFre, ---- for Num to Utt 
    Prelude in {

lincat 
  Phrase = Utt ;

lin
  PNumeral n = mkPhrase (ss ((mkCard <n : Numeral>).s ! masculine)) ; ----
  PGreeting g = mkPhrase g ;
  PSentence s = s ;

oper 
  mkPhrase : SS -> Utt = \s -> lin Utt s ;

}
