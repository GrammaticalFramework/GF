--# -path=.:present

concrete PhrasebookIta of Phrasebook = 
  GreetingsIta,
  WordsIta
  ** open 
    SyntaxIta,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}

