--# -path=.:../abstract:../../prelude:../common

--1 Interlingua Lexical Paradigms
--
-- Aarne Ranta 2003--2005
-- JP Bernardy 2007
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoIna.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
-- However, this function should only seldom be needed: we have a
-- separate module [``IrregIna`` ../../english/IrregIna.gf], 
-- which covers irregular verbss.

resource ParadigmsIna = open 
  (Predef=Predef), 
  Prelude, 
  MorphoIna,
  CatIna
  in {
--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
--  Gender : Type ; 
-- There is no grammatical gender in interlingua.

---- To abstract over number names, we define the following.
--
--  Number : Type ; 
--
--  singular : Number ;
--  plural   : Number ;

-- To abstract over case names, we define the following.

  nominative : Case ;
  accusative : Case ;
  genitive   : Case ;
  dative     : Case ;
  ablative   : Case ;


-- Prepositions are used in many-argument functions for rection.
-- The resource category $Prep$ is used.



--2 Nouns
--

-- All nouns are regular, so one should use $regN$ to construct them.

--3 Relational nouns 
-- 
-- Relational nouns ("daughter of x") need a preposition. 

-- The most common preposition is "of", and the following is a
-- shortcut for regular relational nouns with "of".

  regN2 : Str -> N2 ;

--2 Adjectives

-- All adjectives are regular, so on should use $regA$ to construct them.

--3 Two-place adjectives

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
-- build $PP$s in the resource API, just requires a string and an expected case.

  mkPrep : Str -> Case -> Prep ;
  noPrep : Prep ;

--2 Verbs
--
-- Regular verbs should be constructed with $regV$. The 3 irregular verbs
-- esser, haber and vader are available separately.


---- Reflexive verbs.
---- By default, verbs are not reflexive; this function makes them that.
--
  reflV  : V -> V ;
  reflV v = {s = v.s ; part = v.part ; lock_V = v.lock_V ; isRefl = True} ;


--3 2 and many-place verbs


-- I decided to provide the following combinators for forming verbs with
-- complex grammar rules:

  prepV2 : Prep  -> V -> V2 ;
  prepV3 : Prep -> V2 -> V3 ;
  dirV2  : V -> V2 ;


  mkV0  : V -> V0 ;
  mkVS  : V -> VS ;
--  mkV2S : V -> Prep -> V2S ;
--  mkVV  : V -> VV ;
  mkV2V : Prep -> Prep -> V -> V2V ;
  mkVA  : V -> VA ;
  mkV2A : Prep -> Prep -> V -> V2A ;
  mkVQ  : V -> VQ ;
  mkV2Q : Prep -> V -> V2Q ;
  
  mkAS  : A -> AS ;
--  mkA2S : A -> Prep -> A2S ;
  mkAV  : A -> AV ;
  mkA2V : A -> Prep -> A2V ;
--
---- Notice: categories $V2S, V2V, V2Q$ are in v 1.0 treated
---- just as synonyms of $V2$, and the second argument is given
---- as an adverb. Likewise $AS, A2S, AV, A2V$ are just $A$.
---- $V0$ is just $V$.
--
  V0, V2S, V2V, V2Q : Type ;
  AS, A2S, AV, A2V : Type ;
--
----.
----2 Definitions of paradigms
----
---- The definitions should not bother the user of the API. So they are
---- hidden from the document.
  nominative = Nom ;
  accusative = Acc ;
  genitive = Gen ;
  dative = Dat ;
  ablative = Abl ;

  regN s = nounReg s ** {lock_N = <>};

  compN : N -> Str -> N;
  compN n s = {s = \\x => n.s ! x ++ s; lock_N = <>} ;


  prepN2 : Prep -> N -> N2;
  prepN3 : Prep -> N2 -> N3;  
  prepN2 = \p,n -> n ** {lock_N2 = <> ; p2 = p.s; c2 = p.c} ;
  prepN3 = \p,n -> n ** {lock_N3 = <> ; p3 = p.s; c3 = p.c} ;
  regN2 n = prepN2 (mkPrep [] genitive) (regN n) ** {lock_N2 = <>};

----3 Relational common noun phrases
----
---- In some cases, you may want to make a complex $CN$ into a
---- relational noun (e.g. "the old town hall of").
--
--  cnN2 : CN -> Prep -> N2 ;
--  cnN3 : CN -> Prep -> Prep -> N3 ;
--
---- This is obsolete.
--  cnN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p.s} ;
--  cnN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p.s ; c3 = q.s} ;
--
  regPN n = regGenPN n;
  regGenPN n = {s = n; lock_PN = <>} ;
--  nounPN n = {s = n.s ! singular ; g = n.g ; lock_PN = <>} ;
--
--  mk2A a b = mkAdjective a a a b ** {lock_A = <>} ;
  regA a = regAdjective a ** {lock_A = <>} ;

  mkA2 a p = a ** {c2 = casePrep p.s p.c ; lock_A2 = <>} ;



  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  mkPrep p c = ss p ** {c = c; lock_Prep = <>} ;
  noPrep = mkPrep [] accusative ;


  -- Verb-formation combinators.
    regV : Str -> V;
    regV s = mkVerb s ** {lock_V = <>};

    prepV2 p v = v ** {c2 = p.c; p2 = p.s ; lock_V2 = <>} ;
    prepV3 p v = v ** {c3 = p.c; p3 = p.s ; lock_V3 = <>} ;
    dirV2 = prepV2 noPrep ;

    mkVS  v = v ** {lock_VS = <>} ;
--  mkVV  v = {
--    s = table {VVF vf => v.s ! vf ; _ => variants {}} ; 
--    isAux = False ; lock_VV = <>
--    } ;
    mkVQ  v = v ** {lock_VQ = <>} ;
  
    V0 : Type = V ;
    V2S, V2V, V2Q : Type = V2 ;
    AS, A2S, AV : Type = A ;
    A2V : Type = A2 ;
--
    mkV0  v = v ** {lock_V = <>} ;
--  mkV2S v p = prepV2 v p ** {lock_V2 = <>} ;
    mkV2V p t v = prepV2 p v ** {s4 = t ; lock_V2 = <>} ;
    mkVA  v = v ** {lock_VA = <>} ;
    mkV2A p2 p3 v = (prepV3 p3 (prepV2 p2 v)) ** {lock_V2A = <>} ;
    mkV2Q p v = prepV2 p v ** {lock_V2 = <>} ;
    mkAS  v = v ** {lock_A = <>} ;
--  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
    mkAV  v = v ** {lock_A = <>} ;
    mkA2V v p = mkA2 v p ** {lock_A2 = <>} ;


-- pre-overload API and overload definitions
    regN : Str -> N ;
--  mk2N : (man,men : Str) -> N ;
--  genderN : Gender -> N -> N ;
--  compN : Str -> N -> N ;
--
--
--
--  mk2A : (free,freely : Str) -> A ;
    regA : Str -> A ;
--
--  mkA = overload {
--    mkA : Str -> A = regA ;
--    mkA : (fat,fatter : Str) -> A = \fat,fatter -> 
--      mkAdjective fat fatter (init fatter + "st") (fat + "ly") ** {lock_A = <>} ;
--    mkA : (good,better,best,well : Str) -> A = \a,b,c,d ->
--      mkAdjective a b c d  ** {lock_A = <>}
--    } ;
--
--  compoundA = compoundADeg ;
--
--
--  mk5V : (go, goes, went, gone, going : Str) -> V ;
--  regV : (cry : Str) -> V ;
--  reg2V : (stop, stopped : Str) -> V;
--  irregV : (drink, drank, drunk  : Str) -> V ;
--  irreg4V : (run, ran, run, running  : Str) -> V ;
--
--  -- Use reg2V instead
--  regDuplV : Str -> V ;
--  -- Use irreg4V instead
--  irregDuplV : (get,   got,   gotten : Str) -> V ;
--


------ obsolete
--
---- Comparison adjectives may two more forms. 
--
--  ADeg : Type ;
--
--  mkADeg : (good,better,best,well : Str) -> ADeg ;
--
---- The regular pattern recognizes two common variations: 
---- "-e" ("rude" - "ruder" - "rudest") and
---- "-y" ("happy - happier - happiest - happily")
--
--  regADeg : Str -> ADeg ;      -- long, longer, longest
--
---- However, the duplication of the final consonant is nor predicted,
---- but a separate pattern is used:
--
--  duplADeg : Str -> ADeg ;      -- fat, fatter, fattest
--
---- If comparison is formed by "more", "most", as in general for
---- long adjective, the following pattern is used:
--
--  compoundADeg : A -> ADeg ; -- -/more/most ridiculous
--
---- From a given $ADeg$, it is possible to get back to $A$.
--
--  adegA : ADeg -> A ;
--
--
  regPN    : Str -> PN ;          
  regGenPN : Str -> PN ;     -- John, John's
--
---- Sometimes you can reuse a common noun as a proper name, e.g. "Bank".
--
--  nounPN : N -> PN ;



} ;
