--# -path=.:../../prelude

--1 A Simple English Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsEng$, which
-- gives a higher-level access to this module.

resource MorphoEng = ResEng ** open Prelude, (Predef=Predef) in {

  flags optimize=all ;

--2 Determiners

  oper 

  mkDeterminer : Number -> Str -> {s : Str ; sp : Case => Str; n : Number} = \n,s ->
    {s = s; 
     sp = regGenitiveS s ;
     n = n} ;

  mkQuant : Str -> Str -> {s : Bool => Number => Str; sp : Bool => Number => Case => Str } = \x,y -> {
    s = \\_  => table { Sg => x ; Pl => y } ;
    sp = \\_ => table { Sg => regGenitiveS x ; Pl => regGenitiveS y }
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

