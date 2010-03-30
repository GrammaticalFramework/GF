--# -path=.:present

concrete PhrasebookIta of Phrasebook = 
  GreetingsIta,
  WordsIta
  ** open 
    (R = Roles),
    SyntaxIta,
    ParadigmsIta,
    Prelude in {

lin
  PGreeting p g = mkText (lin Text (ss (g.s ! p.p ! R.Male ! R.Male))) (lin Text (ss p.s)) ;

}

