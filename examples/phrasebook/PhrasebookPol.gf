--# -path=.:present

concrete PhrasebookPol of Phrasebook = 
  GreetingsPol,
  WordsPol ** open 
    SyntaxPol,
    Prelude in {

flags 
  language = pl_PL ; optimize =values ; coding =utf8 ; 
      


lin
  PGreeting g = lin Text g ;

}
