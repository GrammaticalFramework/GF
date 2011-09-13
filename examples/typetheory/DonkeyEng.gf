concrete DonkeyEng of Donkey = TypesSymb ** open Prelude in {

lincat 
  S  = SS ; 
  CN = SS ** {g : Gender} ;
  NP = SS ;
  V2 = SS ;
  V  = SS ;

param Gender = Masc | Fem | Neutr ;

lin
  PredV2 _ _ F x y = ss (x.s ++ F.s ++ y.s) ;
  PredV _ F x = ss (x.s ++ F.s) ;
  If A B = ss ("if" ++ A.s ++ B.s) ;
  An A = ss ("a" ++ A.s) ;
  The A _ = ss ("the" ++ A.s) ;
  Pron A _ = ss (case A.g of {Masc => "he" ; Fem => "she" ; Neutr => "it"}) ;

  Man = {s = "man" ; g = Masc} ;
  Donkey = {s = "donkey" ; g = Neutr} ;
  Own = ss "owns" ;
  Beat = ss "beats" ;
  Walk = ss "walks" ;
  Talk = ss "talks" ;

-- for the lexicon

lin
  Man' = ss "man'" ;
  Donkey' = ss "donkey'" ;
  Own' = apply "own'" ;
  Beat' = apply "beat'" ;
  Walk' = apply "walk'" ;
  Talk' = apply "talk'" ;
}