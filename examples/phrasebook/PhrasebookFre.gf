--# -path=.:present

concrete PhrasebookFre of Phrasebook = 
  GreetingsFre,
  WordsFre
  ** open 
    (R = Roles),
    SyntaxFre,
    ParadigmsFre,
    ResFre, ---- for Num to Utt 
    Prelude in {

lincat 
  Phrase = Text ;
  Gender = {s : Str ; g : R.Gender} ;
  Politeness = {s : Str ; p : R.Politeness} ;

lin
  PNumeral n = mkPhrase ((mkCard <n : Numeral>).s ! masculine) ; ----
  PSentence s = mkText s ;
  PQuestion s = mkText s ;

  PGreeting g = mkPhrase (g.s ! R.Polite ! R.Male ! R.Male) ;
----  PGreeting p s h g = mkPhrase (g.s ! p.p ! s.g ! h.g ++ p.s ++ s.s ++ h.s) ;

  Male = {s = [] ; g = R.Male} ;
  Female = {s = [] ; g = R.Female} ;
  Polite = {s = [] ; p = R.Polite} ;
  Familiar = {s = [] ; p = R.Familiar} ;
  
oper 
  mkPhrase : Str -> Utt = \s -> lin Utt (ss s) ;

}
