--# -path=.:present

concrete PhrasebookSwe of Phrasebook = 
  GreetingsSwe,
  WordsSwe ** open 
    SyntaxSwe,
    Prelude in {

lin
  PSentence s = mkText s | lin Text (mkUtt s) ;  -- optional .
  PQuestion s = mkText s | lin Text (mkUtt s) ;  -- optional ?
  PGreeting g = mkPhrase g ;

}
