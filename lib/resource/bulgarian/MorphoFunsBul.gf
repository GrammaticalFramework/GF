--# -path=.:../abstract:../../prelude:../common

resource MorphoFunsBul = open
  Prelude, 
  CatBul,
  MorphoBul
  in {

oper
--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal (e.g. "always").

  mkAdv : Str -> Adv = \x -> ss x ** {lock_Adv = <>} ;
  mkAdV : Str -> AdV = \x -> ss x ** {lock_AdV = <>} ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA = \x -> ss x ** {lock_AdA = <>} ;


--2 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Prep -> A2 ;
  mkA2 a p = a ** {c2 = p.s ; lock_A2 = <>} ;


--2 Verbs
--

  reflV : V -> Case -> V ;
  reflV v c = {s = v.s; vtype = VMedial  c; lock_V=<>} ;

  phrasalV : V -> Case -> V ;
  phrasalV v c = {s = v.s; vtype = VPhrasal c; lock_V=<>} ;


--3 Two-place verbs
--

  prepV2 : V -> Prep -> V2 ;
  prepV2 v p = {s = v.s; c2 = p; vtype = v.vtype; lock_V2 = <>} ;
  
  dirV2 : V -> V2 ;
  dirV2 v = prepV2 v noPrep ;


--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Prep -> Prep -> V3 ;   -- speak, with, about
  mkV3 v p q = {s = v.s; s1 = v.s1; c2 = p; c3 = q; vtype = v.vtype; lock_V3 = <>} ;
  
  dirV3    : V -> Prep -> V3 ;           -- give,_,to
  dirV3 v p = mkV3 v noPrep p ;
  
  dirdirV3 : V -> V3 ;                   -- give,_,_
  dirdirV3 v = dirV3 v noPrep ;


--3 Other verbs
--

  mkVS  : V -> VS ;
  mkVS  v = v ** {lock_VS = <>} ;
  
  mkVV : V -> VV ;
  mkVV  v = v ** {lock_VV = <>} ;
  
  mkVA : V -> VA ;
  mkVA  v = v ** {lock_VA = <>} ;

  
--2 Prepositions
--
-- A preposition as used for rection in the lexicon, as well as to
-- build $PP$s in the resource API, just requires a string.

  mkPrep : Str -> Case -> Prep = \p,c -> {s = p; c = c; lock_Prep = <>} ;
  noPrep : Prep = mkPrep [] Acc ;
  

--2 Proper Names
--
  mkPN : Str -> Gender -> PN ;
  mkPN s g = {s = s; g = g ; lock_PN = <>} ;


--2 IAdv
--

  mkIAdv : Str -> IAdv ;
  mkIAdv s = {s1 = s; s2 = s + "то"; lock_IAdv = <>} ;
}