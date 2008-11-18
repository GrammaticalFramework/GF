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

  mkQuant : Str -> Str -> {s : Bool => Number => Str; sp : Bool => Number => Case => Str } = \sg,pl -> mkQuant4 sg pl sg pl ;

  mkQuant4 : Str -> Str -> Str -> Str -> {s : Bool => Number => Str; sp : Bool => Number => Case => Str } = \sg,pl,sg',pl' -> {
    s = \\_  => table { Sg => sg ; Pl => pl } ;
    sp = \\_ => table { Sg => regGenitiveS sg' ; Pl => regGenitiveS pl' }
    } ;

  regGenitiveS : Str -> Case => Str = \s -> 
    table { Gen => genitiveS s; _ => s } ;

  genitiveS : Str -> Str = \dog ->
    case last dog of {
        "s" => dog + "'" ;
        _   => dog + "'s"
        };

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

