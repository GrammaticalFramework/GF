--# -path=.:present

concrete PhrasebookRon of Phrasebook = 
  GreetingsRon,
  WordsRon
  ** open 
    SyntaxRon,
    Prelude in {

lin
  PSentence s = mkText s | lin Text (mkUtt s) ;  -- optional .
  PQuestion s = mkText s | lin Text (mkUtt s) ;  -- optional ?
  PGreeting g = lin Text g ;

}
