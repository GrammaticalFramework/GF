--# -path=.:../../prelude

--1 A Simple Interlingua Resource Morphology
--
-- Aarne Ranta 2003--2005
-- JP Bernardy 2007
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsIna$, which
-- gives a higher-level access to this module.

resource MorphoIna = ResIna ** open Prelude, (Predef=Predef) in {

  flags optimize=all ;

--2 Nouns
--
-- For conciseness and abstraction, we define a worst-case macro for
-- noun inflection. It is used for defining special case that
-- only need one string as argument.

oper
    CommonNoun  : Type = {s : Number => Str};  -- nouns are inflected in number

    nounGen : Str -> Str -> CommonNoun = \mec,mecs -> 
      {s = table {Sg => mec;
		  Pl => mecs
	 };
      };

    nounReg : Str -> CommonNoun = \cas -> 
      let s = case last cas of {
	    "a" | "e" | "i" | "o" | "u" => "s" ;
	  "c" => "hes";
	  _ => "es" 
	    }
      in nounGen cas (cas + s) ;

--2 Determiners

    mkDeterminer : Number -> Str -> {s : Case => Str ; n : Number} = \n,s ->
      {s = \\c=>casePrep "" c ++ s ; n = n} ;

    mkIDeterminer : Number -> Str -> {s : Str ; n : Number} = \n,s ->
      {s = s ; n = n} ;

--2 Adjectives
--
-- To form the adjectival and the adverbial forms, 3 strings are needed
-- in the worst case. (bon, melior, optime)

  Adjective = {s : AForm => Str} ;

-- However, most adjectives can be inflected using the final character.

  regAdjective : Str -> Adjective = \clar -> 
    mkAdjective clar ("plus" ++ clar) ("le" ++ "plus" ++ clar) ; 

--3 Verbs

  -- defined in resina

} ;

