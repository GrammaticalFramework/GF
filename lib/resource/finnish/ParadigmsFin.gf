--# -path=.:../abstract:../../prelude

--1 Finnish Lexical Paradigms
--
-- Aarne Ranta 2003-2005
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

resource ParadigmsFin = 
  open (Predef=Predef), Prelude, SyntaxFin, CategoriesFin in {

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

-- The regular noun heuristic takes just one form and analyses its suffixes.

  regN : (talo : Str) -> N ;

-- The almost-regular heuristic analyses three forms.

  reg3N : (vesi,veden,vesiä : Str) -> N ;

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

  mkN2 : N -> Case -> N2 ;
  fGen  : N -> N2 ;

-- Proper names can be formed by using declensions for nouns.
-- The plural forms are filtered away by the compiler.

  mkPN  : N -> PN ;


--2 Adjectives

-- Non-comparison one-place adjectives are just like nouns.

  mkA : N -> A ;

-- Two-place adjectives need a case for the second argument.

  mkA2 : N -> Case -> A2 ;

-- Comparison adjectives have three forms. The comparative and the superlative
-- are always inflected in the same way, so the nominative of them is actually
-- enough (except for the superlative "paras" of "hyvä").

  mkADeg : (kiva : N) -> (kivempaa,kivinta : Str) -> ADeg ;

--- Unfortunately, this function expands to enormous size.

----  regADeg : (suuri : Str) -> ADeg ;

--2 Verbs
--
-- The fragment only has present tense so far, but in all persons.
-- The worst case needs five forms, as shown in the following.

  mkV   : (tulla,tulee,tulen,tulevat,tulkaa,tullaan,
           tuli,tulin,tulisi,tullut,tultu,tullun : Str) -> V ;
  regV  : (soutaa : Str) -> V ;
  reg3V : (soutaa,soudan,soudin : Str) -> V ;


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

  mkV2 : V -> Case -> (prep,postp : Str) -> V2 ;

-- If both are empty, the following special function can be used.

  caseV2 : V -> Case -> V2 ;

-- Verbs with a direct (accusative) object
-- are special, since their complement case is finally decided in syntax.

  dirV2 : V -> V2 ;

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

regN = \vesi -> 
  let
    esi = Predef.dp 3 vesi ;   -- analysis: suffixes      
    si  = Predef.dp 2 esi ;
    i   = last si ;
    s   = init si ;
    a   = if_then_Str (pbool2bool (Predef.occurs "aou" vesi)) "a" "ä" ;
    ves = init vesi ;          -- synthesis: prefixes
    ve  = init ves ;
  in 
       case esi of {
    "uus" | "yys" => sRakkaus vesi ;
    "nen" =>       sNainen (Predef.tk 3 vesi + ("st" + a)) ;

  _ => case si of {
    "aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö" => sPuu vesi ;
    "ie" | "uo" | "yö" => sSuo vesi ;
    "ea" | "eä" => 
      mkNoun 
        vesi (vesi + "n") (vesi + "n"+a)  (vesi + a)  (vesi + a+"n")
        (ves + "in"+a) (ves + "iss"+a) (ves + "iden")  (ves + "it"+a)
        (ves + "isiin") ;
    "is"        => sNauris (vesi + ("t" + a)) ;
    "ut" | "yt" => sRae vesi (ves + ("en" + a)) ;
    "uus" | "yys" => sRakkaus vesi ;
    "us" | "ys"   => sTilaus vesi (ves + ("ksen" + a)) ;
  _ => case i of {
    "i" =>         sBaari (vesi + a) ;
    "e" =>         sRae vesi (ves + ("een" + a)) ;
----    "e" =>         sRae vesi (strongGrade ves + ("een" + a)) ;
    "a" | "o" | "u" | "y" | "ä" | "ö" => sLukko vesi ;
  _ =>             sLinux (vesi + "i" + a)
  }
  }
  }  ** {g = NonHuman ; lock_N = <>} ;

reg3N = \vesi,veden,vesiä -> 
  let
    esi = Predef.dp 3 vesi ;   -- analysis: suffixes      
    si  = Predef.dp 2 esi ;
    i   = last si ;
    s   = init si ;
    den = Predef.dp 3 veden ;
    d   = Predef.tk 2 den ; 
    esiä = Predef.dp 4 vesiä ;
    a   = last vesiä ;
    ves = init vesi ;          -- synthesis: prefixes
    ve  = init ves ;
    ved = Predef.tk 2 veden ;
    sRae_vesi = sRae vesi (veden + a) ;
  in 
       case si of {
    "aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö" => sPuu vesi ;
    "ie" | "uo" | "yö" => sSuo vesi ;
    "is" => sNauris (vesi + ("t" + a)) ;
    "ut" | "yt" => sRae vesi (ves + ("en" + a)) ;
    "us" | "ys" => 
      ifTok CommonNoun d "s" 
        (sTilaus vesi (veden + a))
        (sRakkaus vesi) ; 
  _ => case esi of {
    "nen" => sNainen (Predef.tk 3 vesi + ("st" + a)) ;
  _ => case esiä of {
    "oita" | "öitä" => sPeruna vesi ;
  _ => case den of {
    "een" => sRae_vesi ;
  _ => case i of {
    "a" | "ä" => sKukko vesi veden vesiä ;
    "i" => case (last (init vesiä)) of {
      "i" => case s of {
         "s" => sSusi vesi veden (ve + ("ten" + a)) ; 
         _   => sKorpi vesi veden (veden + a)
         } ;
      _ => sBaari (vesi + a)
      } ;
    "o" | "u" | "y" | "ö" => sKukko vesi veden vesiä ;
  _ => sLinux (vesi + "i" + a)
  }
  }
  }
  }
  }  ** {g = NonHuman ; lock_N = <>} ;

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
  mkN2 = \n,c -> n2n n ** {c = NPCase c ; lock_N2 = <>} ;
  fGen = \n -> mkN2 n genitive ;
  mkPN n = mkProperName n ** {lock_PN = <>} ;

  mkA = \x -> noun2adj x ** {lock_A = <>} ;
  mkA2 = \x,c -> mkA x ** {c = NPCase c ; lock_A2 = <>} ;
  mkADeg x kivempi kivin = 
    let
      a = last (x.s ! ((NCase Sg Part))) ; ---- gives "kivinta"
      kivempaa = init kivempi + a + a ;
      kivinta = kivin + "t" + a 
    in
    regAdjDegr x kivempaa kivinta ** {lock_ADeg = <>} ;

{- ----
  regADeg suuri =
    let suur = regN suuri in
    mkADeg 
      suur 
      (init (suur.s ! NCase Sg Gen) + "mpi")
      (init (suur.s ! NCase Pl Ess)) ;
-}

  mkV a b c d e f g h i j k l = mkVerb a b c d e f g h i j k l ** {lock_V = <>} ;

regV soutaa = 
  let
    taa = Predef.dp 3 soutaa ;
    ta  = init taa ;
    aa  = Predef.dp 2 taa ;
    soudan = Predef.tk 2 soutaa + "en" ;
    juo = Predef.tk 2 soutaa ;
    o  = Predef.dp 1 juo ;
    a = last aa ;
    u = ifTok Str a "a" "u" "y" ;
    joi = Predef.tk 2 juo + (o + "i")
  in case ta of {
    "ta" | "tä" => vPoistaa soutaa ;
    "st"        => vJuosta soutaa soudan (juo + "s"+u+"t") (juo + "t"+u) ;
    "nn" | "rr" | "ll" => vJuosta soutaa soudan (juo +   o+u+"t") (juo + "t"+u) ;
      _ => case aa of {
    "da" | "dä" => vJuoda soutaa joi ;
    "ta" | "tä" => vOsata soutaa ;
    _ => vSanoa soutaa
    }} ** {lock_V = <>} ;

reg3V soutaa soudan soudin = 
  let
    taa   = Predef.dp 3 soutaa ;
    ta    = init taa ;
    aa    = Predef.dp 2 taa ;
    souda = init soudan ;
    juo = Predef.tk 2 soutaa ;
    o  = last juo ;
    a = last aa ;
    u = ifTok Str a "a" "u" "y" ;
    joi = init soudin
  in case ta of {
    "ta" | "tä" => vOttaa soutaa soudan ;
    "st" => vJuosta soutaa soudan (juo + "s"+u+"t") (juo + "t"+u) ;
    "nn" | "rr" | "ll" => vJuosta soutaa soudan (juo +   o+u+"t") (juo + "t"+u) ;
      _ => case aa of {
    "da" | "dä" => vJuoda soutaa joi ;
    "ta" | "tä" => vOsata soutaa ;
    _ => vHukkua soudan souda
    }} ** {lock_V = <>} ;

  vValua v = vSanoa v ** {lock_V = <>} ;
  vKattaa v u = vOttaa v u ** {lock_V = <>} ;
  vOstaa v = vPoistaa v ** {lock_V = <>} ;
  vNousta v u = vJuosta v u [] [] ** {lock_V = <>} ; -----
  vTuoda v = vJuoda v [] ** {lock_V = <>} ; -----
  vOlla = verbOlla ** {lock_V = <>} ;
  vEi = verbEi ** {lock_V = <>} ;

  mkV2 = \v,c,p,o -> v ** {s3 = p ; s4 = o ; c = CCase c ; lock_V2 = <>} ;
  caseV2 = \v,c -> mkV2 v c [] [] ; 
  dirV2 v = mkTransVerbDir v ** {lock_V2 = <>} ;
} ;

