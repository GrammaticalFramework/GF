--# -path=.:present

concrete PhrasebookDut of Phrasebook = 
  GreetingsDut,
  WordsDut ** open 
    SyntaxDut,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}
