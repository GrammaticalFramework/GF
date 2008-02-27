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

  mkDeterminerSg : Str -> Str -> Str -> {s : DGender => Role => Str; n : Number; countable : Bool ; spec : Species} = \vseki,vsiaka,vsiako ->
    {s = \\g,_ => table DGender [vseki;vseki;vsiaka;vsiako] ! g; n = Sg; countable = False; spec = Indef} ;
  mkDeterminerPl : Str -> {s : DGender => Role => Str ; n : Number; countable : Bool ; spec : Species} = \vsicki ->
    {s = \\_,_ => vsicki; n = Pl; countable = False; spec = Indef} ;

  mkQuant : Str -> Str -> Str -> Str -> {s : AForm => Str; spec : Species} = \tozi,tazi,towa,tezi -> {
    s = \\aform => case aform of {
                     ASg Masc _    => tozi ;
                     ASgMascDefNom => tozi ;
                     ASg Fem  _    => tazi ;
                     ASg Neut _    => towa ;
                     APl      _    => tezi
                   };
    spec = Indef
    } ;

}