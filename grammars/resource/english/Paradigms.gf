--# -path=.:../abstract:../../prelude

--1 English Lexical Paradigms
--
-- Aarne Ranta 2003
--
-- This is an API to the user of the resource grammar 
-- for adding lexical items. It give shortcuts for forming
-- expressions of basic categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $resource.Abs.gf$. 
--
-- The main difference with $MorphoEng.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms as string
-- arguments of the paradigms, not stems.
--
-- The following modules are presupposed:

resource Paradigms = open (Predef=Predef), Prelude, Syntax, English in {

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  human    : Gender ;
  nonhuman : Gender ;

-- To abstract over number names, we define the following.

  singular : Number ;
  plural   : Number ;


--2 Nouns

-- Worst case: give all four forms and the semantic gender.
-- In practice the worst case is just: give singular and plural nominative.

oper
  mkN  : (man,men,man's,men's : Str) -> Gender -> N ;
  nMan : (man,men : Str) -> Gender -> N ;

-- Regular nouns, nouns ending with "s", "y", or "o", and nouns with the same
-- plural form as the singular.

  nReg   : Str -> Gender -> N ;   -- dog, dogs
  nKiss  : Str -> Gender -> N ;   -- kiss, kisses
  nFly   : Str -> Gender -> N ;   -- fly, flies
  nHero  : Str -> Gender -> N ;   -- hero, heroes (= nKiss !)
  nSheep : Str -> Gender -> N ;   -- sheep, sheep
  
-- These use general heuristics, that recognizes the last letter. *N.B* it 
-- does not get right with "boy", "rush", since it only looks at one letter.

  nHuman    : Str -> N ;  -- gambler/actress/nanny
  nNonhuman : Str -> N ;  -- dog/kiss/fly

-- Nouns used as functions need a preposition. The most common is "of".

  mkFun : N -> Preposition -> Fun ;

  funHuman    : Str -> Fun ;  -- the father/mistress/daddy of 
  funNonhuman : Str -> Fun ;  -- the successor/address/copy of 

-- Proper names, with their regular genitive.

  pnReg : (John : Str) -> PN ;          -- John, John's

-- The most common cases on the top level havee shortcuts.
-- The regular "y"/"s" variation is taken into account in $CN$.

  cnNonhuman : Str -> CN ;
  cnHuman    : Str -> CN ;
  npReg      : Str -> NP ;

-- In some cases, you may want to make a complex $CN$ into a function.

  mkFunCN  : CN -> Preposition -> Fun ;
  funOfCN : CN -> Fun ;

--2 Adjectives

-- Non-comparison one-place adjectives just have one form.

  mkAdj1 : (even : Str) -> Adj1 ;
 
-- Two-place adjectives need a preposition as second argument.

  mkAdj2 : (divisible, by : Str) -> Adj2 ;

-- Comparison adjectives have three forms. The common irregular
-- cases are ones ending with "y" and a consonant that is duplicated.

  mkAdjDeg : (good,better,best : Str) -> AdjDeg ;

  aReg        : (long  : Str) -> AdjDeg ;      -- long, longer, longest
  aHappy      : (happy : Str) -> AdjDeg ;      -- happy, happier, happiest
  aFat        : (fat   : Str) -> AdjDeg ;      -- fat, fatter, fattest
  aRidiculous : (ridiculous : Str) -> AdjDeg ; -- -/more/most ridiculous

-- On top level, there are adjectival phrases. The most common case is
-- just to use a one-place adjective.

  apReg : Str -> AP ;


--2 Verbs
--
-- The fragment now has all verb forms, except the gerund/present participle.
-- Except for "be", the worst case needs four forms: the infinitive and
-- the third person singular present, the past indicative, and the past participle.

  mkV   : (go, goes, went, gone : Str) -> V ;

  vReg  : (walk : Str) -> V ;  -- walk, walks
  vKiss : (kiss : Str) -> V ;  -- kiss, kisses
  vFly  : (fly  : Str) -> V ;  -- fly, flies
  vGo   : (go   : Str) -> V ;  -- go, goes (= vKiss !)

-- This generic function recognizes the special cases where the last
-- character is "y", "s", or "z". It is not right for "finish" and "convey".

  vGen : Str -> V ; -- walk/kiss/fly

-- The verbs "be" and "have" are special.

  vBe   : V ;
  vHave : V ;

-- Verbs with a particle.

  vPart    : (go, goes, went, gone, up : Str) -> V ;
  vPartReg : (get,      up : Str) -> V ;    

-- Two-place verbs, and the special case with direct object.
-- Notice that a particle can already be included in $V$.

  mkTV  : V -> Str -> TV ;              -- look for, kill

  tvGen    : (look, for : Str) -> TV ;  -- look for, talk about
  tvDir    : V                 -> TV ;  -- switch off
  tvGenDir : (kill      : Str) -> TV ;  -- kill

-- Regular two-place verbs with a particle.

  tvPartReg : Str -> Str -> Str -> TV ; -- get, along, with

-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.

  human = Hum ; 
  nonhuman = NoHum ;
  -- singular defined in types.Eng
  -- plural defined in types.Eng

  nominative = Nom ;

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

  mkFun = \n,p -> n ** {lock_Fun = <> ; s2 = p} ;
  funNonhuman = \s -> mkFun (nNonhuman s) "of" ;
  funHuman = \s -> mkFun (nHuman s) "of" ;

  pnReg n = nameReg n ** {lock_PN = <>} ;

  cnNonhuman = \s -> UseN (nGen s nonhuman) ;
  cnHuman = \s -> UseN (nGen s human) ;
  npReg = \s -> UsePN (pnReg s) ;  

  mkFunCN = \n,p -> n ** {lock_Fun = <> ; s2 = p} ;
  funOfCN = \n -> mkFunCN n "of" ;

  addGenN : (Str -> CommonNoun) -> Str -> Gender -> N = \f -> 
    \s,g -> f s ** {g = g ; lock_N = <>} ;

  mkAdj1 a = simpleAdj a ** {lock_Adj1 = <>} ;
  mkAdj2 = \s,p -> simpleAdj s ** {s2 = p} ** {lock_Adj2 = <>} ;
  mkAdjDeg a b c = mkAdjDegr a b c ** {lock_AdjDeg = <>} ;
  aReg a = adjDegrReg a ** {lock_AdjDeg = <>} ;
  aHappy = \happy -> adjDegrY (Predef.tk 1 happy) ** {lock_AdjDeg = <>} ;
  aFat = \fat -> let {fatt = fat + Predef.dp 1 fat} in 
         mkAdjDeg fat (fatt + "er") (fatt + "est") ;
  aRidiculous a = adjDegrLong a ** {lock_AdjDeg = <>} ;
  apReg = \s -> AdjP1 (mkAdj1 s) ;

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
    verbPart (regVerbP3 get) up  ** {lock_V = <>} ;

  mkTV = \v,p -> v ** {lock_TV = <> ; s3 = p} ;
  tvPartReg = \get, along, to -> mkTV (vPartReg get along) to ;

  vBe = verbBe  ** {s1 = [] ; lock_V = <>} ;
  vHave = verbP3Have  ** {s1 = [] ; lock_V = <>} ;

  tvGen = \s,p -> mkTV (vGen s) p ;
  tvDir = \v -> mkTV v [] ;
  tvGenDir = \s -> tvDir (vGen s) ;

} ;
