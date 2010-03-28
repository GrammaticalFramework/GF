--# -path=.:present

concrete PhrasebookFre of Phrasebook = 
  GreetingsFre,
  WordsFre
  ** open 
    (R = Roles),
    SyntaxFre,
    ParadigmsFre,
    Prelude in {

lincat 
  Gender = {s : Str ; g : R.Gender} ;
  Politeness = {s : Str ; p : R.Politeness} ;

lin
  PSentence s = mkText s | lin Text (mkUtt s) ;  -- optional .
  PQuestion s = mkText s | lin Text (mkUtt s) ;  -- optional ?
  PGreeting g = lin Text (ss (g.s ! R.Polite ! R.Male ! R.Male)) ;
----  PGreeting p s h g = mkPhrase (g.s ! p.p ! s.g ! h.g ++ p.s ++ s.s ++ h.s) ;

  Male = {s = [] ; g = R.Male} ;
  Female = {s = [] ; g = R.Female} ;
  Polite = {s = [] ; p = R.Polite} ;
  Familiar = {s = [] ; p = R.Familiar} ;
  
}
