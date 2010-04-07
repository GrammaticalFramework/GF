--# -path=.:present

concrete PhrasebookGer of Phrasebook = 
  GreetingsGer,
  WordsGer ** open 
    SyntaxGer,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}
