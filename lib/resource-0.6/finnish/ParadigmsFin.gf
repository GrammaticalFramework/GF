--1 Finnish Lexical Paradigms
--
-- Aarne Ranta 2003
--
-- This is an API to the user of the resource grammar 
-- for adding lexical items. It give shortcuts for forming
-- expressions of basic categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoFin.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, not
-- stems, as string arguments of the paradigms, not stems.
--
-- This is the path to read the grammar from the same directory.
--# -path=.:../abstract:../../prelude
--
-- The following modules are presupposed:

resource ParadigmsFin = open Prelude, SyntaxFin, ResourceFin in {

--2 Parameters 
--
-- To abstract over gender, number, and (some) case names, 
-- we define the following identifiers.

oper
  Gender   : Type;

  human    : Gender ;
  nonhuman : Gender ;

  Number   : Type;

  singular : Number ;
  plural   : Number ;

  Case     : Type ;
  nominative : Case ; 
  genitive   : Case ; 
  partitive  : Case ; 
  inessive   : Case ; 
  elative    : Case ; 
  illative   : Case ; 
  adessive   : Case ; 
  ablative   : Case ; 
  allative   : Case ;

--2 Nouns

-- Worst case: give ten forms and the semantic gender.
-- In practice just a couple of forms are needed, to define the different
-- stems, vowel alternation, and vowel harmony.

oper
  mkN : 
    (talo,talon,talona,taloa,taloon,taloina,taloissa,talojen,taloja,taloihin 
          : Str) -> Gender -> N ;

-- Nouns with partitive "a"/"ä" are a large group. 
-- To determine for grade and vowel alternation, three forms are usually needed:
-- singular nominative and genitive, and plural partitive.
-- Examples: "talo", "kukko", "huippu", "koira", "kukka", "syylä", "särki"...

  nKukko : (kukko,kukon,kukkoja : Str) -> N ;

-- For convenience, we define 1-argument paradigms as producing the
-- nonhuman gender; the following function changes this:

  humanN : N -> N ;

-- A special case are nouns with no alternations: 
-- the vowel harmony is inferred from the last letter,
-- which must be one of "o", "u", "ö", "y".

  nTalo : (talo : Str) -> N ;

-- Another special case are nouns where the last two consonants
-- undergo regular weak-grade alternation:
-- "kukko - kukon", "rutto - ruton", "hyppy - hypyn", "sampo - sammon",
-- "kunto - kunnon", "sisältö - sisällön", .

  nLukko : (lukko : Str) -> N ;

-- "arpi - arven", "sappi - sapen", "kampi - kammen";"sylki - syljen"

  nArpi  : (arpi : Str) -> N ;
  nSylki : (sylki : Str) -> N ;

-- Foreign words ending in consonants are actually similar to words like
-- "malli"/"mallin"/"malleja", with the exception that the "i" is not attached
-- to the singular nominative. Examples: "linux", "savett", "screen".
-- The singular partitive form is used to get the vowel harmony. (N.B. more than 
-- 1-syllabic words ending in "n" would have variant plural genitive and 
-- partitive forms, like "sultanien"/"sultaneiden", which are not covered.)

  nLinux : (linuxia : Str) -> N ;

-- Nouns of at least 3 syllables ending with "a" or "ä", like "peruna", "tavara",
-- "rytinä".

  nPeruna : (peruna : Str) -> N ;

-- The following paradigm covers both nouns ending in an aspirated "e", such as
-- "rae", "perhe", "savuke", and also many ones ending in a consonant
-- ("rengas", "kätkyt"). The singular nominative and essive are given.

  nRae : (rae, rakeena : Str) -> N ;

-- The following covers nouns with partitive "ta"/"tä", such as
-- "susi", "vesi", "pieni". To get all stems and the vowel harmony, it takes
-- the singular nominative, genitive, and essive.

  nSusi : (susi,suden,sutta : Str) -> N ;

-- Nouns ending with a long vowel, such as "puu", "pää", "pii", "leikkuu",
-- are inflected according to the following.

  nPuu : (puu : Str) -> N ;

-- One-syllable diphthong nouns, such as "suo", "tie", "työ", are inflected by
-- the following.

  nSuo : (suo : Str) -> N ;

-- Many adjectives but also nouns have the nominative ending "nen" which in other
-- cases becomes "s": "nainen", "ihminen", "keltainen". 
-- To capture the vowel harmony, we use the partitive form as the argument.

  nNainen : (naista : Str) -> N ;

-- The following covers some nouns ending with a consonant, e.g.
-- "tilaus", "kaulin", "paimen", "laidun".

  nTilaus : (tilaus,tilauksena : Str) -> N ;

-- Special case:

  nKulaus : (kulaus : Str) -> N ;

-- The following covers nouns like "nauris" and adjectives like "kallis", "tyyris".
-- The partitive form is taken to get the vowel harmony.

  nNauris : (naurista : Str) -> N ;

-- Separately-written compound nouns, like "sambal oelek", "Urho Kekkonen",
-- have only their last part inflected.

  nComp : Str -> N -> N ;

-- Nouns used as functions need a case, of which by far the commonest is
-- the genitive.

  mkFun : N -> Case -> Fun ;
  fGen  : N -> Fun ;

-- Proper names can be formed by using declensions for nouns.
-- The plural forms are filtered away by the compiler.

  mkPN  : N -> PN ;


--2 Adjectives

-- Non-comparison one-place adjectives are just like nouns.

  mkAdj1 : N -> Adj1 ;

-- Two-place adjectives need a case for the second argument.

  mkAdj2 : N -> Case -> Adj2 ;

-- Comparison adjectives have three forms. The comparative and the superlative
-- are always inflected in the same way, so the nominative of them is actually
-- enough (except for the superlative "paras" of "hyvä").

  mkAdjDeg : (kiva : N) -> (kivempaa,kivinta : Str) -> AdjDeg ;


--2 Verbs
--
-- The fragment only has present tense so far, but in all persons.
-- The worst case needs five forms, as shown in the following.

  mkV   : (tulla,tulen,tulee,tulevat,tulkaa,tullaan : Str) -> V ;

-- A simple special case is the one with just one stem and no grade alternation.
-- It covers e.g. "sanoa", "valua", "kysyä".

  vValua : (valua : Str) -> V ;

-- With two forms, the following function covers a variety of verbs, such as
-- "ottaa", "käyttää", "löytää", "huoltaa", "hiihtää", "siirtää".

  vKattaa : (kattaa, katan : Str) -> V ;

-- When grade alternation is not present, just a one-form special case is needed
-- ("poistaa", "ryystää").

  vOstaa : (ostaa : Str) -> V ;

-- The following covers 
-- "juosta", "piestä", "nousta", "rangaista", "kävellä", "surra", "panna".

  vNousta : (nousta, nousen : Str) -> V ;

-- This is for one-syllable diphthong verbs like "juoda", "syödä".

  vTuoda : (tuoda : Str) -> V ;

-- The verbs "be" and the negative auxiliary are special.

  vOlla : V ;
  vEi   : V ;

-- Two-place verbs need a case, and can have a pre- or postposition.
-- At least one of the latter is empty, $[]$.

  mkTV : V -> Case -> (prep,postp : Str) -> TV ;

-- If both are empty, the following special function can be used.

  tvCase : V -> Case -> TV ;

-- Verbs with a direct (accusative) object
-- are special, since their complement case is finally decided in syntax.

  tvDir : V -> TV ;

-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.
  Gender = SyntaxFin.Gender ;
  Case = SyntaxFin.Case ;
  Number = SyntaxFin.Number ;

  singular = Sg ;
  plural = Pl ;

  human = Human ; 
  nonhuman = NonHuman ;

  nominative = Nom ;
  genitive = Gen ;
  partitive = Part ;
  inessive = Iness ;
  elative = Elat ;
  illative = Illat ;
  adessive = Adess ;
  ablative = Ablat ;
  allative = Allat ;

  mkN = \a,b,c,d,e,f,g,h,i,j,k -> 
    mkNoun a b c d e f g h i j ** {g = k ; lock_N = <>} ;

  nKukko = \a,b,c -> sKukko a b c ** {g = nonhuman ; lock_N = <>} ;

  humanN = \n -> {s = n.s ; lock_N = n.lock_N ; g = human} ;

  nLukko = \a -> sLukko a ** {g = nonhuman ; lock_N = <>} ;
  nTalo = \a -> sTalo a ** {g = nonhuman ; lock_N = <>} ;
  nArpi = \a -> sArpi a ** {g = nonhuman ; lock_N = <>} ;
  nSylki = \a -> sSylki a ** {g = nonhuman ; lock_N = <>} ;
  nLinux = \a -> sLinux a ** {g = nonhuman ; lock_N = <>} ;
  nPeruna = \a -> sPeruna a ** {g = nonhuman ; lock_N = <>} ;
  nRae = \a,b -> sRae a b ** {g = nonhuman ; lock_N = <>} ;
  nSusi = \a,b,c -> sSusi a b c ** {g = nonhuman ; lock_N = <>} ;
  nPuu = \a -> sPuu a ** {g = nonhuman ; lock_N = <>} ;
  nSuo = \a -> sSuo a ** {g = nonhuman ; lock_N = <>} ;
  nNainen = \a -> sNainen a ** {g = nonhuman ; lock_N = <>} ;
  nTilaus = \a,b -> sTilaus a b ** {g = nonhuman ; lock_N = <>} ;
  nKulaus = \a -> nTilaus a (init a + "ksen" + getHarmony (last
  (init a))) ;
  nNauris = \a -> sNauris a ** {g = nonhuman ; lock_N = <>} ;


  nComp = \s,n -> {s = \\c => s ++ n.s ! c ; g = n.g ; lock_N = <>} ;
  mkFun = \n,c -> n2n n ** {c = NPCase c ; lock_Fun = <>} ;
  fGen = \n -> mkFun n genitive ;
  mkPN n = mkProperName n ** {lock_PN = <>} ;

  mkAdj1 = \x -> noun2adj x ** {lock_Adj1 = <>} ;
  mkAdj2 = \x,c -> mkAdj1 x ** {c = NPCase c ; lock_Adj2 = <>} ;
  mkAdjDeg x y z = regAdjDegr x y z ** {lock_AdjDeg = <>} ;

  mkV a b c d e f = mkVerb a b c d e f ** {lock_V = <>} ;
  vValua v = vSanoa v ** {lock_V = <>} ;
  vKattaa v u = vOttaa v u ** {lock_V = <>} ;
  vOstaa v = vPoistaa v ** {lock_V = <>} ;
  vNousta v u = vJuosta v u ** {lock_V = <>} ;
  vTuoda v = vJuoda v ** {lock_V = <>} ;
  vOlla = verbOlla ** {lock_V = <>} ;
  vEi = verbEi ** {lock_V = <>} ;

  mkTV = \v,c,p,o -> v ** {s3 = p ; s4 = o ; c = c ; lock_TV = <>} ;
  tvCase = \v,c -> mkTV v c [] [] ; 
  tvDir v = mkTransVerbDir v ** {lock_TV = <>} ;
} ;
