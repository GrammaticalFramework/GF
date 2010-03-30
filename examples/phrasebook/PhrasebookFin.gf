--# -path=.:present

concrete PhrasebookFin of Phrasebook = 
  GreetingsFin,
  WordsFin ** open 
    SyntaxFin,
    Prelude in {

lin
  PGreeting p g = mkText (lin Text (ss g.s)) (lin Text (ss p.s)) ;

}
