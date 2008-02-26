--# -path=.:../abstract:../../prelude:../common

--1 Bulgarian Lexical Paradigms
--
-- Krasimir Angelov 2008
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoBul.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.

resource ParadigmsBul = VerbParadigmsBul, AdjParadigmsBul ** open
  (Predef=Predef), 
  Prelude, 
  MorphoBul,
  CatBul
  in {

oper
--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Prep -> A2 ;

--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal (e.g. "always").

  mkAdv : Str -> Adv ;
  mkAdV : Str -> AdV ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;

--2 Prepositions
--
-- A preposition as used for rection in the lexicon, as well as to
-- build $PP$s in the resource API, just requires a string.

  mkPrep : Str -> Case -> Prep ;
  noPrep : Prep ;

  mkA2 a p = a ** {c2 = p.s ; lock_A2 = <>} ;

--2 Verbs
--

  reflV  : V -> Case -> V ;
  phrasalV : V -> Case -> V ;

--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). Notice that a particle comes from the $V$.

  reflV    v c = {s = v.s; vtype = VMedial  c; lock_V=<>} ;
  phrasalV v c = {s = v.s; vtype = VPhrasal c; lock_V=<>} ;

  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  prepV2 : V -> Prep -> V2 ;
  dirV2 : V -> V2 ;

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Prep -> Prep -> V3 ;   -- speak, with, about
  dirV3    : V -> Prep -> V3 ;           -- give,_,to
  dirdirV3 : V -> V3 ;                   -- give,_,_

  mkVS  : V -> VS ;
  
  mkPN : Str -> Gender -> PN ;

  mkIAdv : Str -> IAdv ;
  
  
  mkPrep p c = {s = p; c = c; lock_Prep = <>} ;
  noPrep = mkPrep [] Acc ;

  prepV2 v p = {s = v.s; c2 = p; vtype = v.vtype; lock_V2 = <>} ;
  dirV2 v = prepV2 v noPrep ;

  mkV3 v p q = {s = v.s; s1 = v.s1; c2 = p; c3 = q; vtype = v.vtype; lock_V3 = <>} ;
  dirV3 v p = mkV3 v noPrep p ;
  dirdirV3 v = dirV3 v noPrep ;
  
  mkVS  v = v ** {lock_VS = <>} ;
  
  mkPN s g = {s = s; g = g ; lock_PN = <>} ;

  mkIAdv s = {s1 = s; s2 = s + "то"; lock_IAdv = <>} ;
}