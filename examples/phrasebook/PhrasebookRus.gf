--# -path=.:present

concrete PhrasebookRus of Phrasebook = 
  GreetingsRus,
  WordsRus ** open 
    SyntaxRus,
    Prelude in {

lin
  PGreeting g = lin Text g ;

}
