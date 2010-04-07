--# -path=.:present

concrete PhrasebookSpa of Phrasebook = 
  GreetingsSpa,
  WordsSpa
  ** open 
    SyntaxSpa,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}

