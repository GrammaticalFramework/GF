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

resource ParadigmsEng = open (Predef=Predef), Prelude, SyntaxEng, ---- ResourceEng in {
  CategoriesEng, RulesEng in {
--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender : Type ; 

  human     : Gender ;
  nonhuman  : Gender ;
  masculine : Gender ;
  feminite  : Gender ;

-- To abstract over number names, we define the following.

  Number : Type ; 

  singular : Number ;
  plural   : Number ;

-- To abstract over case names, we define the following.

  Case : Type ;

  nominative : Case ;
  genitive   : Case ;

-- Prepositions used in many-argument functions are just strings.

  Preposition : Type = Str ;


--2 Nouns

-- Worst case: give all four forms and the semantic gender.

  mkN  : (man,men,man's,men's : Str) -> N ;

-- The regular function captures the variants for nouns ending with
-- "s","sh","x","z" or "y": "kiss - kisses", "flash - flashes"; 
-- "fly - flies" (but "toy - toys"),

  regN : Str -> N ;

-- In practice the worst case is just: give singular and plural nominative.

  mk2N : (man,men : Str) -> N ;

-- All nouns created by the previous functions are marked as
-- $nonhuman$. If you want a $human$ noun, wrap it with the following
-- function:

  genderN : Gender -> N -> N ;

--3 Compound nouns 
--
-- All the functions above work quite as well to form compound nouns,
-- such as "baby boom". 


--3 Relational nouns 
-- 
-- Relational nouns ("daughter of x") need a preposition. 

  mkN2 : N -> Preposition -> N2 ;

-- The most common preposition is "of", and the following is a
-- shortcut for regular, $nonhuman$ relational nouns with "of".

  regN2 : Str -> N2 ;

-- Use the function $mkPreposition$ or see the section on prepositions below to  
-- form other prepositions.
--
-- Three-place relational nouns ("the connection from x to y") need two prepositions.

  mkN3 : N -> Preposition -> Preposition -> N3 ;


--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "the old town hall of").

  cnN2 : CN -> Preposition -> N2 ;
  cnN3 : CN -> Preposition -> Preposition -> N3 ;

-- 
--3 Proper names and noun phrases
--
-- Proper names, with a regular genitive, are formed as follows

  regPN : Str -> Gender -> PN ;          -- John, John's

-- Sometimes you can reuse a common noun as a proper name, e.g. "Bank".

  nounPN : N -> PN ;

-- To form a noun phrase that can also be plural and have an irregular
-- genitive, you can use the worst-case function.

  mkNP : Str -> Str -> Number -> Gender -> NP ; 

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

  mkA2 : A -> Preposition -> A2 ;

-- Comparison adjectives may two more forms. 

  mkADeg : (good,better,best,well : Str) -> ADeg ;

-- The regular pattern recognizes two common variations: 
-- "-e" ("rude" - "ruder" - "rudest") and
-- "-y" ("happy - happier - happiest - happily")

  regADeg : Str -> ADeg ;      -- long, longer, longest

-- However, the duplication of the final consonant is nor predicted,
-- but a separate pattern is used:

  duplADeg : Str -> ADeg ;      -- fat, fatter, fattest

-- If comparison is formed by "more, "most", as in general for
-- long adjective, the following pattern is used:

  compoundADeg : A -> ADeg ; -- -/more/most ridiculous

-- From a given $ADeg$, it is possible to get back to $A$.

  adegA : ADeg -> A ;


--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal (e.g. "always").

  mkAdv : Str -> Adv ;
  mkAdV : Str -> AdV ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;

--2 Prepositions
--
-- A preposition is just a string.

  mkPreposition : Str -> Preposition ;

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

-- The following variant duplicates the last letter in the forms like
-- "rip - ripped - ripping".

  regDuplV : Str -> V ;

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

  mkV2  : V -> Preposition -> V2 ;

  dirV2 : V -> V2 ;

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Str -> Str -> V3 ;    -- speak, with, about
  dirV3    : V -> Str -> V3 ;           -- give,_,to
  dirdirV3 : V -> V3 ;                  -- give,_,_

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ;
  mkVS  : V -> VS ;
  mkV2S : V -> Str -> V2S ;
  mkVV  : V -> VV ;
  mkV2V : V -> Str -> Str -> V2V ;
  mkVA  : V -> VA ;
  mkV2A : V -> Str -> V2A ;
  mkVQ  : V -> VQ ;
  mkV2Q : V -> Str -> V2Q ;

  mkAS  : A -> AS ;
  mkA2S : A -> Str -> A2S ;
  mkAV  : A -> AV ;
  mkA2V : A -> Str -> A2V ;


--2 Definitions of paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.

  Gender = SyntaxEng.Gender ; 
  Number = SyntaxEng.Number ;
  Case = SyntaxEng.Case ;
  human = Masc ; 
  nonhuman = Neutr ;
  masculine = Masc ;
  feminine = Fem ;
  singular = Sg ;
  plural = Pl ;
  nominative = Nom ;
  genitive = Gen ;

  regN = \ray -> 
    let
      ra  = Predef.tk 1 ray ; 
      y   = Predef.dp 1 ray ; 
      r   = Predef.tk 2 ray ; 
      ay  = Predef.dp 2 ray ;
      rays =
        case y of {
          "y" => y2ie ray "s" ; 
          "s" => ray + "es" ;
          "z" => ray + "es" ;
          "x" => ray + "es" ;
          _ => case ay of {
            "sh" => ray + "es" ;
            "ch" => ray + "es" ;
            _    => ray + "s"
            }
         }
     in
       mk2N ray rays ;

  mk2N = \man,men -> 
    let mens = case last men of {
      "s" => men + "'" ;
      _   => men + "'s"
      }
    in
    mkN man men (man + "'s") mens ;

  mkN = \man,men,man's,men's -> 
    mkNoun man men man's men's ** {g = Neutr ; lock_N = <>} ;

  genderN g man = {s = man.s ; g = g ; lock_N = <>} ;

  mkN2 = \n,p -> UseN n ** {lock_N2 = <> ; s2 = p} ;
  regN2 n = mkN2 (regN n) (mkPreposition "of") ;
  mkN3 = \n,p,q -> UseN n ** {lock_N3 = <> ; s2 = p ; s3 = q} ;
  cnN2 = \n,p -> n ** {lock_N2 = <> ; s2 = p} ;
  cnN3 = \n,p,q -> n ** {lock_N3 = <> ; s2 = p ; s3 = q} ;

  regPN n g = nameReg n g ** {lock_PN = <>} ;
  nounPN n = {s = n.s ! singular ; g = n.g ; lock_PN = <>} ;
  mkNP x y n g = {s = table {GenP => x ; _ => y} ; a = toAgr n P3 g ;
  lock_NP = <>} ;

  mkA a b = mkAdjective a b ** {lock_A = <>} ;
  regA a = regAdjective a ** {lock_A = <>} ;

  mkA2 a p = a ** {s2 = p ; lock_A2 = <>} ;

  mkADeg a b c d = mkAdjDegrWorst a b c c d d ** {lock_ADeg = <>} ;

  regADeg happy = 
    let
      happ = init happy ;
      y    = last happy ;
      happie = case y of {
        "y" => happ + "ie" ;
        "e" => happy ;
        _   => happy + "e"
        } ;
      happily = case y of {
        "y" => happ + "ily" ;
        _   => happy + "ly"
        } ;
    in mkADeg happy happily (happie + "r") (happie + "st") ;

  duplADeg fat = mkADeg fat 
    (fat + "ly") (fat + last fat + "er") (fat + last fat + "est") ;
  compoundADeg a = let ad = (a.s ! AAdj) in 
    mkADeg ad (a.s ! AAdv) ("more" ++ ad) ("most" ++ ad) ;
  adegA a = {s = a.s ! Pos ; lock_A = <>} ;

  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  mkPreposition p = p ;

  mkV a b c d e = mkVerbP3worst a b c d e ** {s1 = [] ; lock_V = <>} ;

  regV cry = 
    let
      cr = init cry ;
      y  = last cry ;
      cries = (regN cry).s ! Pl ! Nom ; -- !
      crie  = init cries ;
      cried = case last crie of {
        "e" => crie + "d" ;
        _   => crie + "ed"
        } ;
      crying = case y of {
        "e" => cr + "ing" ;
        _   => cry + "ing"
        }
    in mkV cry cries cried cried crying ;

  regDuplV fit = 
    let fitt = fit + last fit in
    mkV fit (fit + "s") (fitt + "ed") (fitt + "ed") (fitt + "ing") ;

  irregV x y z = mkVerbIrreg x y z ** {s1 = [] ; lock_V = <>} ;

  irregDuplV fit y z = 
    let 
      fitting = (regDuplV fit).s ! PresPart
    in
    mkV fit (fit + "s") y z fitting ;

  partV v p = {s = v.s ; s1 = p ; lock_V = <>} ;

  mkV2 v p = v ** {s = v.s ; s1 = v.s1 ; s3 = p ; lock_V2 = <>} ;
  dirV2 v = mkV2 v [] ;

  mkV3 v p q = v ** {s = v.s ; s1 = v.s1 ; s3 = p ; s4 = q ; lock_V3 = <>} ;
  dirV3 v p = mkV3 v [] p ;
  dirdirV3 v = dirV3 v [] ;

  mkV0  v = v ** {lock_V0 = <>} ;
  mkVS  v = v ** {lock_VS = <>} ;
  mkV2S v p = mkV2 v p ** {lock_V2S = <>} ;
  mkVV  v = verb2aux v ** {isAux = False ; lock_VV = <>} ;
  mkV2V v p t = mkV2 v p ** {s4 = t ; lock_V2V = <>} ;
  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p = mkV2 v p ** {lock_V2A = <>} ;
  mkVQ  v = v ** {lock_VQ = <>} ;
  mkV2Q v p = mkV2 v p ** {lock_V2Q = <>} ;

  mkAS  v = v ** {lock_AS = <>} ;
  mkA2S v p = mkA2 v p ** {lock_A2S = <>} ;
  mkAV  v = v ** {lock_AV = <>} ;
  mkA2V v p = mkA2 v p ** {lock_A2V = <>} ;

} ;
