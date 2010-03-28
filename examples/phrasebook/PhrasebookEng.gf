--# -path=.:present

concrete PhrasebookEng of Phrasebook = 
  GreetingsEng,
  WordsEng ** open 
    (R = Roles),
    SyntaxEng,
    Prelude in {

lin
  PSentence s = mkText s | lin Text (mkUtt s) ;  -- optional .
  PQuestion s = mkText s | lin Text (mkUtt s) ;  -- optional ?
  PGreeting g = lin Text (ss g.s) ;
----  PGreeting p s h g = mkPhrase (g.s ++ p.s ++ s.s ++ h.s) ;

  Male = {s = [] ; g = R.Male} ;
  Female = {s = [] ; g = R.Female} ;
  Polite = {s = [] ; p = R.Polite} ;
  Familiar = {s = [] ; p = R.Familiar} ;

}
