--# -path=.:present

concrete PhrasebookCat of Phrasebook = 
  GreetingsCat,
  WordsIta
  ** open 
    SyntaxCat,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}

