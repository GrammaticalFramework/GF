--# -path=.:present

concrete PhrasebookEng of Phrasebook = 
  GreetingsEng,
  WordsEng ** open 
    SyntaxEng,
    Prelude in {

lin
  PGreeting g = lin Text g ;

}
