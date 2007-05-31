--# -path=.:../abstract:../../prelude:../common

--1 English Lexical Paradigms
--
-- Aarne Ranta 2003--2005
--
-- This is an API for the user of the resource grammar 
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
-- separate module [``IrregEng`` ../../english/IrregEng.gf], 
-- which covers irregular verbss.

resource ParadigmsEng = open 
  (Predef=Predef), 
  Prelude, 
  MorphoEng,
  CatEng
  in {
--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender : Type ; 

  human     : Gender ;
  nonhuman  : Gender ;
  masculine : Gender ;

-- To abstract over number names, we define the following.

  Number : Type ; 

  singular : Number ;
  plural   : Number ;

-- To abstract over case names, we define the following.

  Case : Type ;

  nominative : Case ;
  genitive   : Case ;

-- Prepositions are used in many-argument functions for rection.
-- The resource category $Prep$ is used.



--2 Nouns

-- Nouns are constructed by the function $mkN$, which takes a varying
-- number of arguments.

  mkN : overload {

-- Worst case: give all four forms.

    mkN : (man,men,man's,men's : Str) -> N ;

-- The regular function captures the variants for nouns ending with
-- "s","sh","x","z" or "y": "kiss - kisses", "flash - flashes"; 
-- "fly - flies" (but "toy - toys"),

    mkN : (flash : Str) -> N ;

-- In practice the worst case is just: give singular and plural nominative.

    mkN : (man,men : Str) -> N ;

-- All nouns created by the previous functions are marked as
-- $nonhuman$. If you want a $human$ noun, wrap it with the following
-- function:

    mkN : Gender -> N -> N ;

--3 Compound nouns 
--
-- A compound noun is an uninflected string attached to an inflected noun,
-- such as "baby boom", "chief executive officer".

    mkN : Str -> N -> N
  } ;


--3 Relational nouns 
-- 
-- Relational nouns ("daughter of x") need a preposition. 

  mkN2 : N -> Prep -> N2 ;

-- The most common preposition is "of", and the following is a
-- shortcut for regular relational nouns with "of".

  regN2 : Str -> N2 ;

-- Use the function $mkPrep$ or see the section on prepositions below to  
-- form other prepositions.
--
-- Three-place relational nouns ("the connection from x to y") need two prepositions.

  mkN3 : N -> Prep -> Prep -> N3 ;



--3 Proper names and noun phrases
--
-- Proper names, with a regular genitive, are formed as follows

  regPN    : Str -> PN ;          
  regGenPN : Str -> Gender -> PN ;     -- John, John's

-- Sometimes you can reuse a common noun as a proper name, e.g. "Bank".

  nounPN : N -> PN ;


--2 Adjectives

  mkA : overload {
-- For regular adjectives, the adverbial form is derived. This holds
-- even for cases with the variation "happy - happily".
    mkA : Str -> A ;
-- Non-comparison one-place adjectives need two forms: one for
-- the adjectival and one for the adverbial form ("free - freely")
    mkA : (free,freely : Str) -> A ;
  };


--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Prep -> A2 ;

-- Comparison adjectives may two more forms. 

  ADeg : Type ;

  mkADeg : (good,better,best,well : Str) -> ADeg ;

-- The regular pattern recognizes two common variations: 
-- "-e" ("rude" - "ruder" - "rudest") and
-- "-y" ("happy - happier - happiest - happily")

  regADeg : Str -> ADeg ;      -- long, longer, longest

-- However, the duplication of the final consonant is nor predicted,
-- but a separate pattern is used:

  duplADeg : Str -> ADeg ;      -- fat, fatter, fattest

-- If comparison is formed by "more", "most", as in general for
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
-- A preposition as used for rection in the lexicon, as well as to
-- build $PP$s in the resource API, just requires a string.

  mkPrep : Str -> Prep ;
  noPrep : Prep ;

-- (These two functions are synonyms.)

--2 Verbs
--

-- Verbs are constructed by the function $mkV$, which takes a varying
-- number of arguments.
  mkV : overload {
-- The regular verb function recognizes the special cases where the last
-- character is "y" ("cry - cries" but "buy - buys") or "s", "sh", "x", "z"
-- ("fix - fixes", etc).
    mkV : (cry : Str) -> V ;
-- Give the present and past forms for regular verbs where
-- the last letter is duplicated in some forms,
-- e.g. "rip - ripped - ripping".
    mkV : (stop, stopped : Str) -> V ;
-- There is an extensive list of irregular verbs in the module $IrregularEng$.
-- In practice, it is enough to give three forms, 
-- e.g. "drink - drank - drunk".
    mkV     : (drink, drank, drunk  : Str) -> V ;
-- Irregular verbs with duplicated consonant in the present participle.
    mkV     : (run, ran, run, running  : Str) -> V ;
-- Except for "be", the worst case needs five forms: the infinitive and
-- the third person singular present, the past indicative, and the
-- past and present participles.
    mkV : (go, goes, went, gone, going : Str) -> V
  };

-- Verbs with a particle.
-- The particle, such as in "switch on", is given as a string.
  partV  : V -> Str -> V ;
-- Reflexive verbs.
-- By default, verbs are not reflexive; this function makes them that.
  reflV  : V -> V ;

--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). Notice that a particle comes from the $V$.

  mkV2 : overload {
    mkV2  : V -> Prep -> V2 ; -- believe in
    mkV2  : V -> V2           -- kill
  };

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Prep -> Prep -> V3 ;   -- speak, with, about
  dirV3    : V -> Prep -> V3 ;           -- give,_,to
  dirdirV3 : V -> V3 ;                   -- give,_,_

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ;
  mkVS  : V -> VS ;
  mkV2S : V -> Prep -> V2S ;
  mkVV  : V -> VV ;
  mkV2V : V -> Prep -> Prep -> V2V ;
  mkVA  : V -> VA ;
  mkV2A : V -> Prep -> V2A ;
  mkVQ  : V -> VQ ;
  mkV2Q : V -> Prep -> V2Q ;

  mkAS  : A -> AS ;
  mkA2S : A -> Prep -> A2S ;
  mkAV  : A -> AV ;
  mkA2V : A -> Prep -> A2V ;

-- Notice: categories $V2S, V2V, V2Q$ are in v 1.0 treated
-- just as synonyms of $V2$, and the second argument is given
-- as an adverb. Likewise $AS, A2S, AV, A2V$ are just $A$.
-- $V0$ is just $V$.

  V0, V2S, V2V, V2Q : Type ;
  AS, A2S, AV, A2V : Type ;

--.
--2 Definitions of paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.

  Gender = MorphoEng.Gender ; 
  Number = MorphoEng.Number ;
  Case = MorphoEng.Case ;
  human = Masc ; 
  nonhuman = Neutr ;
  masculine = Masc ;
  feminine = Fem ;
  singular = Sg ;
  plural = Pl ;
  nominative = Nom ;
  genitive = Gen ;

  Preposition : Type = Str ; -- obsolete

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
    mk4N man men (man + "'s") mens ;

  mk4N = \man,men,man's,men's -> 
    mkNoun man man's men men's ** {g = Neutr ; lock_N = <>} ;

  genderN g man = {s = man.s ; g = g ; lock_N = <>} ;

  compoundN s n = {s = \\x,y => s ++ n.s ! x ! y ; g=n.g ; lock_N = <>} ;

  mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p.s} ;
  regN2 n = mkN2 (regN n) (mkPrep "of") ;
  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p.s ; c3 = q.s} ;

--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "the old town hall of").

  cnN2 : CN -> Prep -> N2 ;
  cnN3 : CN -> Prep -> Prep -> N3 ;

-- This is obsolete.
  cnN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p.s} ;
  cnN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p.s ; c3 = q.s} ;

  regPN n = regGenPN n human ;
  regGenPN n g = nameReg n g ** {lock_PN = <>} ;
  nounPN n = {s = n.s ! singular ; g = n.g ; lock_PN = <>} ;

  mk2A a b = mkAdjective a a a b ** {lock_A = <>} ;
  regA a = regAdjective a ** {lock_A = <>} ;

  mkA2 a p = a ** {c2 = p.s ; lock_A2 = <>} ;

  ADeg = A ; ----

  mkADeg a b c d = mkAdjective a b c d ** {lock_A = <>} ;

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
    in mkADeg happy (happie + "r") (happie + "st") happily ;

  duplADeg fat = 
    mkADeg fat 
    (fat + last fat + "er") (fat + last fat + "est") (fat + "ly") ;

  compoundADeg a =
    let ad = (a.s ! AAdj Posit) 
    in mkADeg ad ("more" ++ ad) ("most" ++ ad) (a.s ! AAdv) ;

  adegA a = a ;

  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  mkPrep p = ss p ** {lock_Prep = <>} ;
  noPrep = mkPrep [] ;

  mk5V a b c d e = mkVerb a b c d e ** {s1 = [] ; lock_V = <>} ;

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
        "e" => case last cr of {
           "e" => cry + "ing" ; 
           _ => cr + "ing" 
           } ;
        _   => cry + "ing"
        }
    in mk5V cry cries cried cried crying ;

  reg2V fit fitted =
   let fitt = Predef.tk 2 fitted ;
   in mk5V fit (fit + "s") (fitt + "ed") (fitt + "ed") (fitt + "ing") ;

  regDuplV fit = 
    case last fit of {
      ("a" | "e" | "i" | "o" | "u" | "y") => 
        Predef.error (["final duplication makes no sense for"] ++ fit) ;
      t =>
       let fitt = fit + t in
       mk5V fit (fit + "s") (fitt + "ed") (fitt + "ed") (fitt + "ing")
      } ;

  irregV x y z = let reg = (regV x).s in
    mk5V x (reg ! VPres) y z (reg ! VPresPart) ** {s1 = [] ; lock_V = <>} ;

  irreg4V x y z w = let reg = (regV x).s in
    mk5V x (reg ! VPres) y z w ** {s1 = [] ; lock_V = <>} ;

  irregDuplV fit y z = 
    let 
      fitting = (regDuplV fit).s ! VPresPart
    in
    mk5V fit (fit + "s") y z fitting ;

  partV v p = verbPart v p ** {lock_V = <>} ;
  reflV v = {s = v.s ; part = v.part ; lock_V = v.lock_V ; isRefl = True} ;

  prepV2 v p = v ** {s = v.s ; s1 = v.s1 ; c2 = p.s ; lock_V2 = <>} ;
  dirV2 v = prepV2 v noPrep ;

  mkV3 v p q = v ** {s = v.s ; s1 = v.s1 ; c2 = p.s ; c3 = q.s ; lock_V3 = <>} ;
  dirV3 v p = mkV3 v noPrep p ;
  dirdirV3 v = dirV3 v noPrep ;

  mkVS  v = v ** {lock_VS = <>} ;
  mkVV  v = {
    s = table {VVF vf => v.s ! vf ; _ => variants {}} ; 
    isAux = False ; lock_VV = <>
    } ;
  mkVQ  v = v ** {lock_VQ = <>} ;

  V0 : Type = V ;
  V2S, V2V, V2Q : Type = V2 ;
  AS, A2S, AV : Type = A ;
  A2V : Type = A2 ;

  mkV0  v = v ** {lock_V = <>} ;
  mkV2S v p = prepV2 v p ** {lock_V2 = <>} ;
  mkV2V v p t = prepV2 v p ** {s4 = t ; lock_V2 = <>} ;
  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p = prepV2 v p ** {lock_V2A = <>} ;
  mkV2Q v p = prepV2 v p ** {lock_V2 = <>} ;

  mkAS  v = v ** {lock_A = <>} ;
  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
  mkAV  v = v ** {lock_A = <>} ;
  mkA2V v p = mkA2 v p ** {lock_A2 = <>} ;


-- pre-overload API and overload definitions

  mk4N : (man,men,man's,men's : Str) -> N ;
  regN : Str -> N ;
  mk2N : (man,men : Str) -> N ;
  genderN : Gender -> N -> N ;
  compoundN : Str -> N -> N ;

  mkN = overload {
    mkN : (man,men,man's,men's : Str) -> N = mk4N ;
    mkN : Str -> N = regN ;
    mkN : (man,men : Str) -> N = mk2N ;
    mkN : Gender -> N -> N = genderN ;
    mkN : Str -> N -> N = compoundN
    } ;


  mk2A : (free,freely : Str) -> A ;
  regA : Str -> A ;

  mkA = overload {
    mkA : Str -> A = regA ;
    mkA : (free,freely : Str) -> A = mk2A
  };


  mk5V : (go, goes, went, gone, going : Str) -> V ;
  regV : (cry : Str) -> V ;
  reg2V : (stop, stopped : Str) -> V;
  irregV : (drink, drank, drunk  : Str) -> V ;
  irreg4V : (run, ran, run, running  : Str) -> V ;

  -- Use reg2V instead
  regDuplV : Str -> V ;
  -- Use irreg4V instead
  irregDuplV : (get,   got,   gotten : Str) -> V ;

  mkV = overload {
    mkV : (cry : Str) -> V = regV ;
    mkV : (stop, stopped : Str) -> V = reg2V ;
    mkV : (drink, drank, drunk  : Str) -> V = irregV ;
    mkV : (run, ran, run, running  : Str) -> V = irreg4V ;
    mkV : (go, goes, went, gone, going : Str) -> V = mk5V
  };

  prepV2 : V -> Prep -> V2 ;
  dirV2 : V -> V2 ;

  mkV2 = overload {
    mkV2  : V -> Prep -> V2 = prepV2;
    mkV2  : V -> V2 = dirV2
  }; 


} ;
