--# -path=.:present

concrete PhrasebookSwe of Phrasebook = 
  GreetingsSwe,
  WordsSwe ** open 
    SyntaxSwe,
    Prelude in {
flags  
  language = sv_SE ;
lin
  PGreeting g = lin Text (ss g.s) ;

}
