--# -path=.:present

concrete PhrasebookFre of Phrasebook = 
  GreetingsFre,
  WordsFre
  ** open 
    (R = Roles),
    SyntaxFre,
    Prelude in {

lin
  PGreeting p g = mkText (lin Text (ss (g.s ! p.p ! R.Male ! R.Male))) (lin Text (ss p.s)) ;
----  PGreeting p s h g = mkPhrase (g.s ! p.p ! s.g ! h.g ++ p.s ++ s.s ++ h.s) ;
  
}
