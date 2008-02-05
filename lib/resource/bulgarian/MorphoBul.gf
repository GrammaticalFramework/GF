--# -path=.:../../prelude

--1 A Simple English Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsEng$, which
-- gives a higher-level access to this module.

resource MorphoBul = ResBul ** open Prelude, (Predef=Predef) in {

  flags optimize=all ;

oper
--2 Determiners

  mkDeterminerSg : Str -> Str -> Str -> {s : Gender => Str; n : Number; det : Dt} = \vseki,vsiaka,vsiako ->
    {s = table Gender [vseki;vsiaka;vsiako]; n = Sg; det = NDet} ;
  mkDeterminerPl : Str -> {s : Gender => Str ; n : Number; det : Dt} = \vsicki ->
    {s = \\_ => vsicki; n = Sg; det = NDet} ;

  mkQuant : Str -> Str -> Str -> Str -> {s : AForm => Str; det : Dt} = \tozi,tazi,towa,tezi -> {
    s = \\gn => case gn of {
                  ASg Masc _ => tozi ;
                  ASg Fem  _ => tazi ;
                  ASg Neut _ => towa ;
                  APl      _ => tezi ;
                  AFullDet   => tozi
                };
    det = NDet
    } ;

}