--# -path=.:present

concrete PhrasebookRon of Phrasebook = 
  GreetingsRon,
  WordsRon
  ** open 
    SyntaxRon,
    Prelude in {

lin
  PGreeting p g = mkText (lin Text (ss g.s)) (lin Text (ss p.s)) ;

}
