--# -path=.:../abstract:../../prelude:../common

--1 Latin Lexical Paradigms
--
-- Aarne Ranta 2008
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 

resource ParadigmsLat = open 
  (Predef=Predef), 
  Prelude, 
  ResLat,
  CatLat
  in {

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  masculine : Gender ;
  feminine  : Gender ;
  neuter    : Gender ;

  mkN = overload {
    mkN : (verbum : Str) -> N 
      = \n -> noun n ** {lock_N = <>} ;
    mkN : (verbum, verbi : Str) -> Gender -> N 
      = \x,y,z -> noun_ngg x y z ** {lock_N = <>} ;
  } ;
  

  mkV = overload {
    mkV : (tacere : Str) -> V
      = \v -> verb v ** {lock_V = <>} ; 
    mkV : (iacio,ieci,iactus,iacere : Str) -> V
      = \v,x,y,z -> verb_pppi v x y z ** {lock_V = <>} ; 
  } ;

  mkV2 = overload {
    mkV2 : (amare : Str) -> V2
      = \v -> verb v ** {c = {s = [] ; c = Acc} ; lock_V2 = <>} ; 
    mkV2 : (facere : V) -> V2
      = \v -> v ** {c = {s = [] ; c = Acc} ; lock_V2 = <>} ; 
    } ;
--.
  masculine = Masc ;
  feminine = Fem ;
  neuter = Neutr ;

}
