--# -path=.:present

concrete PhrasebookFre of Phrasebook = 
  GreetingsFre,
  WordsFre
  ** open 
    SyntaxFre,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;
  
}
