--# -path=.:present

concrete PhrasebookNor of Phrasebook = 
  GreetingsNor,
  WordsNor ** open 
    SyntaxNor,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}
