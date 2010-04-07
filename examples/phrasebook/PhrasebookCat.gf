--# -path=.:present

concrete PhrasebookCat of Phrasebook = 
  GreetingsCat,
  WordsCat
  ** open 
    SyntaxCat,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}

