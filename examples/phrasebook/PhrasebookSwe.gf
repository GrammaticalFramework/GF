--# -path=.:present

concrete PhrasebookSwe of Phrasebook = 
  GreetingsSwe,
  WordsSwe ** open 
    SyntaxSwe,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}
