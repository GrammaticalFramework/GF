--# -path=.:present:alltenses

concrete PhrasebookDan of Phrasebook = 
  GreetingsDan,
  WordsDan ** open 
    SyntaxDan,
    Prelude in {

lin
  PGreeting g = lin Text (ss g.s) ;

}
