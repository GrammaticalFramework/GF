--# -path=.:present

concrete PhrasebookPol of Phrasebook = 
  GreetingsPol,
  WordsPol ** open 
    SyntaxPol,
    Prelude in {

lin
  PGreeting g = lin Text g ;

}
