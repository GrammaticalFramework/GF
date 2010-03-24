--# -path=.:present

concrete PhrasebookEng of Phrasebook = 
  GreetingsEng,
  FoodEng ** open 
    (R = Roles),
    SyntaxEng,
    ResEng, ---- for Num to Utt 
    Prelude in {

lincat 
  Phrase = Utt ;

lin
  PNumeral n = 
    mkPhrase ((SyntaxEng.mkCard <n : Numeral>).s ! Nom) ; ----
  PSentence s = s ;

  PGreeting g = mkPhrase g.s ;
----  PGreeting p s h g = mkPhrase (g.s ++ p.s ++ s.s ++ h.s) ;

  Male = {s = [] ; g = R.Male} ;
  Female = {s = [] ; g = R.Female} ;
  Polite = {s = [] ; p = R.Polite} ;
  Familiar = {s = [] ; p = R.Familiar} ;

oper 
  mkPhrase : Str -> Utt = \s -> lin Utt (ss s) ;

}
