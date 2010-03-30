--# -path=.:present

concrete PhrasebookSwe of Phrasebook = 
  GreetingsSwe,
  WordsSwe ** open 
    SyntaxSwe,
    Prelude in {

lin
  PGreeting p g = mkText (lin Text (ss g.s)) (lin Text (ss p.s)) ;

}
