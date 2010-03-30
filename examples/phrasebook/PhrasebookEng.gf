--# -path=.:present

concrete PhrasebookEng of Phrasebook = 
  GreetingsEng,
  WordsEng ** open 
    (R = Roles),
    SyntaxEng,
    Prelude in {

lin
  PGreeting p g = mkText (lin Text g) (lin Text (ss p.s)) ;

}
