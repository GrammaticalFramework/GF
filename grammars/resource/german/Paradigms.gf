--1 German Lexical Paradigms
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
-- The main difference with $morpho.Deu.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms as string
-- arguments of the paradigms, not stems.
--
-- The following modules are presupposed:

resource Paradigms = open (Predef=Predef), Prelude, (Morpho=Morpho), Syntax, Deutsch in {


--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  masculine : Gender ;
  feminine  : Gender ;
  neuter    : Gender ;

-- To abstract over case names, we define the following.

  nominative : Case ;
  accusative : Case ;
  dative     : Case ;
  genitive   : Case ;

-- To abstract over number names, we define the following.

  singular : Number ;
  plural   : Number ;


--2 Nouns

-- Worst case: give all four singular forms, two plural forms (others + dative),
-- and the gender.

  mkN  : (_,_,_,_,_,_ : Str) -> Gender -> N ; 
                                 -- mann, mann, manne, mannes, männer, männern

-- Often it is enough with singular and plural nominatives, and singular
-- genitive. The plural dative
-- is computed by the heuristic that it is the same as the nominative this
-- ends with "n" or "s", otherwise "n" is added.

  nGen : Str -> Str -> Str ->  Gender -> N ; -- punkt,punktes,punkt
  
-- Here are some common patterns. Singular nominative or two nominatives are needed.
-- Two forms are needed in case of Umlaut, which would be complicated to define.
-- For the same reason, we have separate patterns for multisyllable stems.
-- 
-- The weak masculine pattern $nSoldat$ avoids duplicating the final "e".

  nRaum   : (_,_ : Str) -> N ;    -- Raum, (Raumes,) Räume (masc)
  nTisch  : Str -> N ;            -- Tisch, (Tisches, Tische) (masc)
  nVater  : (_,_ : Str) -> N ;    -- Vater, (Vaters,) Väter (masc)
  nFehler : Str -> N ;            -- Fehler, (fehlers, Fehler) (masc)
  nSoldat : Str -> N ;            -- Soldat (, Soldaten) ; Kunde (, Kunden) (masc)

-- Neuter patterns. 

  nBuch   : (_,_ : Str) -> N ;    -- Buch, (Buches, Bücher) (neut)
  nMesser : Str -> N ;            -- Messer, (Messers, Messer) (neut)
  nAuto   : Str -> N ;            -- Auto, (Autos, Autos) (neut)

-- Feminine patterns. Duplicated "e" is avoided in $nFrau$.

  nHand   : (_,_ : Str) -> N ;    -- Hand, Hände; Mutter, Mütter (fem)
  nFrau   : Str -> N ;            -- Frau (, Frauen) ; Wiese (, Wiesen) (fem)


-- Nouns used as functions need a preposition. The most common is "von".

  mkFun  : N -> Preposition -> Case -> Fun ;
  funVon : N -> Fun ;

-- Proper names, with their possibly
-- irregular genitive. The regular genitive is  "s", omitted after "s".

  mkPN  : (karolus, karoli : Str) -> PN ; -- karolus, karoli
  pnReg : (Johann : Str) -> PN ;          -- Johann, Johanns ; Johannes, Johannes

-- On the top level, it is maybe $CN$ that is used rather than $N$, and
-- $NP$ rather than $PN$.

  mkCN  : N -> CN ;
  mkNP  : (karolus,karoli : Str) -> NP ;

  npReg : Str -> NP ;   -- Johann, Johanns

-- In some cases, you may want to make a complex $CN$ into a function.

  mkFunCN  : CN -> Preposition -> Case -> Fun ;
  funVonCN : CN -> Fun ;


--2 Adjectives

-- Non-comparison one-place adjectives need two forms in the worst case:
-- the one in predication and the one before the ending "e".

  mkAdj1 : (teuer,teur : Str) -> Adj1 ;

-- Invariable adjective are a special case.

  adjInvar : Str -> Adj1 ;          -- prima

-- The following heuristic recognizes the the end of the word, and builds
-- the second form depending on if it is "e", "er", or something else.
-- N.B. a contraction is made with "er", which works for "teuer" but not
-- for "bitter".

  adjGen : Str -> Adj1 ;            -- gut; teuer; böse

-- Two-place adjectives need a preposition and a case as extra arguments.

  mkAdj2 : Adj1 -> Str -> Case -> Adj2 ;  -- teilbar, durch, acc

-- Comparison adjectives may need three adjective, corresponding to the
-- three comparison forms. 

  mkAdjDeg : (gut,besser,best : Adj1) -> AdjDeg ;

-- In many cases, each of these adjectives is itself regular. Then we only
-- need three strings. Notice that contraction with "er" is not performed
-- ("bessere", not "bessre").

  aDeg3 : (gut,besser,best : Str) -> AdjDeg ;

-- In the completely regular case, the comparison forms are constructed by
-- the endings "er" and "st".

  aReg : Str -> AdjDeg ;    -- billig, billiger, billigst

-- The past participle of a verb can be used as an adjective.

  aPastPart : V -> Adj1 ;   -- gefangen

-- On top level, there are adjectival phrases. The most common case is
-- just to use a one-place adjective. The variation in $adjGen$ is taken
-- into account.

  apReg : Str -> AP ;


--2 Verbs
--
-- The fragment only has present tense so far, but in all persons.
-- It also has the infinitive and the past participles.
-- The worst case macro needs four forms: : the infinitive and 
-- the third person singular (where Umlaut may occur), the singular imperative,
-- and the past participle.
-- 
-- The function recognizes if the stem ends with "s" or "t" and performs the
-- appropriate contractions.

  mkV : (_,_,_,_ : Str) -> V ;   -- geben, gibt, gib, gegeben

-- Regular verbs are those where no Umlaut occurs.

  vReg  : Str -> V ;         -- kommen

-- The verbs 'be' and 'have' are special.

  vSein  : V ;
  vHaben : V ;

-- Verbs with a detachable particle, with regular ones as a special case.

  vPart    :  (_,_,_,_,_ : Str) -> V ;     -- sehen, sieht, sieh, gesehen, aus
  vPartReg :  (_,_     : Str) -> V ;       -- bringen, um

-- Two-place verbs, and the special case with direct object. Notice that
-- a particle can be included in a $V$.

  mkTV     : V   -> Str -> Case -> TV ;  -- hören, zu, dative

  tvReg    : Str -> Str -> Case -> TV ;  -- hören, zu, dative
  tvDir    : V -> TV ;                   -- umbringen
  tvDirReg : Str -> TV ;                 -- lieben

-- Three-place verbs require two prepositions and cases.

  mkV3 : V -> Str -> Case -> Str -> Case -> TV ;  -- geben,[],dative,[],accusative


--2 Adverbials
--
-- Adverbials for modifying verbs, adjectives, and sentences can be formed 
-- from strings.

  mkAdV : Str -> AdV ;
  mkAdA : Str -> AdA ;
  mkAdS : Str -> AdS ;

-- Prepositional phrases are another productive form of adverbials.

  mkPP : Case -> Str -> NP -> AdV ;

-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.


  masculine = Masc ;
  feminine  = Fem ;
  neuter = Neut ;
  nominative = Nom ;
  accusative = Acc ;
  dative = Dat ;
  genitive = Gen ;
  -- singular defined in Types
  -- plural defined in Types

  mkN = mkNoun ;

  nGen = \punkt, punktes, punkte, g -> let {
      e   = Predef.dp 1 punkte ; 
      eqy = ifTok (Gender -> N) e ;
      noN = mkNoun4 punkt punktes punkte punkte
    } in
    eqy "n" noN (
    eqy "s" noN (
            mkNoun4 punkt punktes punkte (punkte+"n"))) g ;

  nRaum = \raum, räume -> nGen raum (raum + "es") räume masculine ;
  nTisch = \tisch -> 
    mkNoun4 tisch (tisch + "es") (tisch + "e") (tisch +"en") masculine ;
  nVater = \vater, väter -> nGen vater (vater + "s") väter masculine ;
  nFehler = \fehler -> nVater fehler fehler ;

  nSoldat = \soldat -> let {
     e = Predef.dp 1 soldat ; 
     soldaten = ifTok Tok e "e" (soldat + "n") (soldat + "en")
    } in
    mkN soldat soldaten soldaten soldaten soldaten soldaten masculine ;

  nBuch = \buch, bücher -> nGen buch (buch + "es") bücher neuter ;
  nMesser = \messer -> nGen messer (messer + "s") messer neuter ;
  nAuto = \auto -> let {autos = auto + "s"} in 
          mkNoun4 auto autos autos autos neuter ;

  nHand = \hand, hände -> nGen hand hand hände feminine ;

  nFrau = \frau -> let {
     e = Predef.dp 1 frau ; 
     frauen = ifTok Tok e "e" (frau + "n") (frau + "en")
    } in
    mkN frau frau frau frau frauen frauen feminine ;

  mkFun = \n -> mkFunCN (n2n n) ;
  funVon = \n -> funVonCN (n2n n) ;

  mkPN = \karolus, karoli -> {s = table {Gen => karoli ; _ => karolus}} ;
  pnReg = \horst -> 
    mkPN horst (ifTok Tok (Predef.dp 1 horst) "s" horst (horst + "s")) ;

  mkCN = UseN ;
  mkNP = \x,y -> UsePN (mkPN x y) ;
  npReg = \s -> UsePN (pnReg s) ;

  mkFunCN = mkFunC ;
  funVonCN = funVonC ;

  mkAdj1 = mkAdjective ;
  adjInvar = Morpho.adjInvar ;
  adjGen = Morpho.adjGen ;
  mkAdj2 = \a,p,c -> a ** {s2 = p ; c = c} ;

  mkAdjDeg = mkAdjComp ;
  aDeg3 = adjCompReg3 ;
  aReg = adjCompReg ;
  aPastPart = \v -> {s = table AForm {a => v.s ! VPart a}} ; 
  apReg = \s -> AdjP1 (adjGen s) ;

  mkV = \sehen, sieht, sieh, gesehen -> 
    mkVerbSimple (mkVerbum sehen sieht sieh gesehen) ;
  vReg = \s -> mkVerbSimple (regVerb s) ;
  vSein = verbSein ;
  vHaben = verbHaben ;
  vPart = \sehen, sieht, sieh, gesehen, aus -> 
    mkVerb (mkVerbum sehen sieht sieh gesehen) aus ;
  vPartReg = \sehen, aus -> mkVerb (regVerb sehen) aus ;

  mkTV = mkTransVerb ;
  tvReg = \hören, zu, dat -> mkTV (vReg hören) zu dat ;
  tvDir = \v -> mkTV v [] accusative ;
  tvDirReg = \v -> tvReg v [] accusative ; 
  mkV3 = mkDitransVerb ;

  mkAdV = ss ;
  mkPP = prepPhrase ;
  mkAdA = ss ;
  mkAdS = ss ;
} ;
