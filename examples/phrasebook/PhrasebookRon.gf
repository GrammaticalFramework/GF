--# -path=.:present

concrete PhrasebookRon of Phrasebook = 
  GreetingsRon,
  WordsRon
  ** open 
    SyntaxRon,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}
