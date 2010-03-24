--# -path=.:present

concrete PhrasebookDisambEng of Phrasebook = 
  PhrasebookEng - [PGreeting, Polite, Familiar, Male, Female] ** open 
    (R = Roles),
    Prelude in {

lin
  PGreeting p s h g = mkPhrase 
    (g.s ++ p.s ++ "(by" ++ s.s ++ ")" ++ "(to" ++ h.s ++ ")") ;

  Male = {s = "a man" ; g = R.Male} ;
  Female = {s = "a woman" ; g = R.Female} ;
  Polite = {s = "(polite)" ; p = R.Polite} ;
  Familiar = {s = "(familiar)" ; p = R.Familiar} ;

--oper 
--  mkPhrase : Str -> Utt = \s -> lin Utt (ss s) ;

}
