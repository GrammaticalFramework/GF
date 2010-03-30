--# -path=.:present

concrete PhrasebookFin of Phrasebook = 
  GreetingsFin,
  WordsFin ** open 
    SyntaxFin,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}
