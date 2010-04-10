--# -path=.:present

concrete PhrasebookBul of Phrasebook = 
  GreetingsBul,
  WordsBul ** open 
    SyntaxBul,
    Prelude in {

lin
  PGreeting g = lin Text g ;

}
