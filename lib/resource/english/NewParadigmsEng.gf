--# -path=.:../abstract:../../prelude

--1 English Lexical Paradigms UNDER RECONSTRUCTION!
--
-- Aarne Ranta 2003
--
-- This is an API to the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoEng.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
-- However, this function should only seldom be needed: we have a
-- separate module $IrregularEng$, which covers all irregularly inflected
-- words.
-- 
-- The following modules are presupposed:

resource ParadigmsEng = open (Predef=Predef), Prelude, SyntaxEng, ResourceEng in {

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender : Type ; 

  human    : Gender ;
  nonhuman : Gender ;

-- To abstract over number names, we define the following.
  Number : Type ; 

  singular : Number ;
  plural   : Number ;

-- To abstract over case names, we define the following.
  Case : Type ;

  nominative : Case ;
  genitive   : Case ;


--2 Nouns

-- The regular function captures the variants for nouns ending with
-- "s","sh","x","z" or "y": "kiss - kisses", "flash - flashes"; 
-- "fly - flies" (but "toy - toys"),

  regN : Str -> N ;

-- Worst case: give all four forms and the semantic gender.

  mkN  : (man,men,man's,men's : Str) -> N ;

-- In practice the worst case is just: give singular and plural nominative.

  manN : (man,men : Str) -> N ;

-- All nouns created by the previous functions are marked as
-- $nonhuman$. If you want a $human$ noun, wrap it with the following
-- function:

  humanN : N -> N ;

--3 Compound nouns 
--
-- All the functions above work quite as well to form compound nouns,
-- such as "baby boom". 


--3 Relational nouns 
-- 
-- Relational nouns ("daughter of x") need a preposition. 

  mkN2 : N -> Prep -> N2 ;

-- The most common preposition is "of", and the following is a
-- shortcut for regulat, $nonhuman$ relational nouns with "of".

  regN2 : Str -> N2 ;

-- Use the function $mkPrep$ or see the section on prepositions below to  
-- form other prepositions.
--
-- Three-place relational nouns ("the connection from x to y") need two prepositions.

  mkN3 : N -> Prep -> Prep -> N3 ;

--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "the old town hall of").

  cnN2 : CN -> Prep -> N2 ;
  cnN3 : CN -> Prep -> Prep -> N3 ;

-- 
--3 Proper names
--
-- Proper names, with a regular genitive, are formed as follows

  pnReg : Str -> PN ;          -- John, John's

--2 Adjectives

-- Non-comparison one-place adjectives need two forms: one for
-- the adjectival and one for the adverbial form ("free - freely")

  mkA : (free,freely : Str) -> A ;

-- For regular adjectives, the adverbial form is derived. This holds
-- even for cases with the variation "happy - happily".

  regA : Str -> A ;
 
--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Prep -> A2 ;

-- Comparison adjectives may two more forms. 

  mkADeg : (good,better,best,well : Str) -> ADeg ;

-- The regular pattern recognizes two common variations: 
-- "-e" ("rude" - "ruder" - "rudest") and
-- "-y" ("happy - happier - happiest - happily")

  regADeg : Str -> ADeg ;      -- long, longer, longest

-- However, the duplication of the final consonant is nor predicted,
-- but a separate pattern is used:

  fatADeg : Str -> ADeg ;      -- fat, fatter, fattest

-- If comparison is formed by "more, "most", as in general for
-- long adjective, the following pattern is used:

  compoundADeg : A -> ADeg ; -- -/more/most ridiculous

-- From a given $ADeg$, it is possible to get back to $A$.

  adegA : ADeg -> A ;


--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal (e.g. "always").

  mkAdv  : Str -> Adv ;
  preAdv : Str -> Adv ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;
  mkAdS : Str -> AdS ;

-- Prepositional phrases are another productive form of adverbials.

  mkPP : Prep -> NP -> Adv ;

--2 Prepositions
--
-- A preposition is just a string.

  mkPrep : Str -> Prep ;

--2 Verbs
--
-- Except for "be", the worst case needs five forms: the infinitive and
-- the third person singular present, the past indicative, and the
-- past and present participles.

  mkV : (go, goes, went, gone, going : Str) -> V ;

-- The regular verb function recognizes the special cases where the last
-- character is "y" ("cry - cries" but "buy - buys") or "s", "sh", "x", "z"
-- ("fix - fixes", etc).

  regV : Str -> V ;

-- There is an extensive list of irregular verbs in the module $IrregularEng$.
-- In practice, it is enough to give three forms, 
-- e.g. "drink - drank - drunk", with a variant indicating consonant
-- duplication in the present participle.

  irregV     : (drink, drank, drunk  : Str) -> V ;
  irregDuplV : (get,   got,   gotten : Str) -> V ;


--3 Verbs with a particle.
--
-- The particle, such as in "switch on", is given as a string.

  partV  : V -> Str -> V ;

--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). Notice that a particle comes from the $V$.

  mkV2  : V -> Prep -> V2 ;

  dirV2 : V -> V2 ;

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Str -> Str -> V3 ;    -- speak, with, about
  dirV3    : V -> Str -> V3 ;           -- give,_,to
  dirdirV3 : V -> V3 ;                  -- give,_,_

--2 Definitions of paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.

  Gender = SyntaxEng.Gender ; 
  Number = SyntaxEng.Number ;
  Case = SyntaxEng.Case ;
  human = Hum ; 
  nonhuman = NoHum ;
  singular = Sg ;
  plural = Pl ;

  nominative = Nom ;
  genitive = Nom ;

  mkN = \man,men,man's,men's,g -> 
    mkNoun man men man's men's ** {g = g ; lock_N = <>} ;
  nReg a g = addGenN nounReg a g ;
  nKiss n g = addGenN nounS n g ;
  nFly = \fly -> addGenN nounY (Predef.tk 1 fly) ;
  nMan = \man,men -> mkN man men (man + "'s") (men + "'s") ;
  nHero = nKiss ;
  nSheep = \sheep -> nMan sheep sheep ;

  nHuman = \s -> nGen s Hum ;
  nNonhuman = \s -> nGen s NoHum ;

  nGen : Str -> Gender -> N = \fly,g -> let {
      fl  = Predef.tk 1 fly ; 
      y   = Predef.dp 1 fly ; 
      eqy = ifTok (Str -> Gender -> N) y
    } in
    eqy "y" nFly  (
    eqy "s" nKiss (
    eqy "z" nKiss (
            nReg))) fly g ;

  mkN2 = \n,p -> n ** {lock_N2 = <> ; s2 = p} ;
  funNonhuman = \s -> mkN2 (nNonhuman s) "of" ;
  funHuman = \s -> mkN2 (nHuman s) "of" ;

  pnReg n = nameReg n ** {lock_PN = <>} ;

  cnNonhuman = \s -> UseN (nGen s nonhuman) ;
  cnHuman = \s -> UseN (nGen s human) ;
  npReg = \s -> UsePN (pnReg s) ;  

  mkN2CN = \n,p -> n ** {lock_N2 = <> ; s2 = p} ;
  funOfCN = \n -> mkN2CN n "of" ;

  addGenN : (Str -> CommonNoun) -> Str -> Gender -> N = \f -> 
    \s,g -> f s ** {g = g ; lock_N = <>} ;

  mkA a = regAdjective a ** {lock_A = <>} ;
  mkA2 = \s,p -> regAdjective s ** {s2 = p} ** {lock_A2 = <>} ;
  mkADeg a b c = adjDegrIrreg a b c ** {lock_ADeg = <>} ;
  aReg a = adjDegrReg a ** {lock_ADeg = <>} ;
  aFat = \fat -> let {fatt = fat + Predef.dp 1 fat} in 
         mkADeg fat (fatt + "er") (fatt + "est") ;
  aRidiculous a = adjDegrLong a ** {lock_ADeg = <>} ;
  apReg = \s -> UseA (mkA s) ;

  aGen : Str -> ADeg = \s -> case last s of {
    "y" => mkADeg s (init s + "ier") (init s + "iest") ;
    "e" => mkADeg s (s + "r") (s + "st") ;
    _   => aReg s
    } ;

  mkAdv a = advPost a ** {lock_Adv = <>} ;
  mkAdvPre a = advPre a ** {lock_Adv = <>} ;
  mkPP x y = prepPhrase x y ** {lock_Adv = <>} ;
  mkAdA a = ss a ** {lock_AdA = <>} ;
  mkAdS a = ss a ** {lock_AdS = <>} ;

  mkV = \go,goes,went,gone -> verbNoPart (mkVerbP3 go goes went gone) ** 
    {lock_V = <>} ;
  vReg = \walk -> mkV walk (walk + "s") (walk + "ed") (walk + "ed") ;
  vKiss = \kiss -> mkV kiss (kiss + "es") (kiss + "ed") (kiss + "ed") ;
  vFly = \cry -> let {cr = Predef.tk 1 cry} in 
                   mkV cry (cr + "ies") (cr + "ied") (cr + "ied") ;
  vGo = vKiss ;

  vGen = \fly -> let {
      fl  = Predef.tk 1 fly ; 
      y   = Predef.dp 1 fly ; 
      eqy = ifTok (Str -> V) y
    } in
    eqy "y" vFly  (
    eqy "s" vKiss (
    eqy "z" vKiss (
            vReg))) fly ;

  vPart = \go, goes, went, gone, up -> 
    verbPart (mkVerbP3 go goes went gone) up ** {lock_V = <>} ;
  vPartReg = \get, up -> 
    verbPart (vGen get) up  ** {lock_V = <>} ;

  mkV2 = \v,p -> v ** {lock_V2 = <> ; s3 = p} ;
  tvPartReg = \get, along, to -> mkV2 (vPartReg get along) to ;

  vBe = verbBe  ** {s1 = [] ; lock_V = <>} ;
  vHave = verbP3Have  ** {s1 = [] ; lock_V = <>} ;

  tvGen = \s,p -> mkV2 (vGen s) p ;
  tvDir = \v -> mkV2 v [] ;
  tvGenDir = \s -> tvDir (vGen s) ;

  mkV3 x y z = mkDitransVerb x y z ** {lock_V3 = <>} ;
  v3Dir x y = mkV3 x [] y ;
  v3DirDir x = v3Dir x [] ;

  -- these are used in the generated lexicon
  noun : Str -> N = nNonhuman ;

  verb2 : Str -> Str -> V2 = \v -> mkV2 (vGen v) ;
  verb3 : Str -> Str -> Str -> V3 = \v -> mkV3 (vGen v) ;

} ;
