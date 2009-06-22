--# -path=.:../../prelude

--1 A Simple English Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsEng$, which
-- gives a higher-level access to this module.

resource MorphoEng = open Prelude, (Predef=Predef), ResEng in {

  flags optimize=all ;

--2 Determiners

  oper 

  mkDeterminer : Number -> Str -> {s : Str ; sp : Case => Str; n : Number} = \n,s ->
    {s = s; 
     sp = regGenitiveS s ;
     n = n} ;

--2 Pronouns


  mkPron : (i,me,my,mine : Str) -> Number -> Person -> Gender -> 
    {s : Case => Str ; sp : Case => Str ; a : Agr} =
     \i,me,my,mine,n,p,g -> {
     s = table {
       Nom => i ;
       Acc => me ;
       Gen => my
       } ;
     a = toAgr n p g ;
     sp = regGenitiveS mine
   } ;

} ;

