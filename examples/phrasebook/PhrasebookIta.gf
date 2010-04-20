--# -path=.:present

concrete PhrasebookIta of Phrasebook = 
  GreetingsIta,
  WordsIta
  ** open 
    SyntaxIta,
    Prelude in {

flags language = it_IT ;

lin
  PGreeting g = lin Text (ss g.s) ;

}

