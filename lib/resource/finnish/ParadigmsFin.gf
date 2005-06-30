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

--  flags optimize=values ;
  flags optimize=noexpand ;

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
  translative : Case ; 
  inessive   : Case ; 
  elative    : Case ; 
  illative   : Case ; 
  adessive   : Case ; 
  ablative   : Case ; 
  allative   : Case ;

  PPosition  : Type ;
  prepP  : Case -> Str -> PPosition ;
  postpP : Case -> Str -> PPosition ;
  caseP  : Case ->        PPosition ;
  accusative : PPosition ;

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

-- The almost-regular heuristics analyse two or three forms.

  reg2N : (savi,savia : Str) -> N ;
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
  genN2  : N -> N2 ;

  mkN3 : N -> Case -> Case -> N3 ;

-- Proper names can be formed by using declensions for nouns.
-- The plural forms are filtered away by the compiler.

  mkPN  : N -> PN ;


--2 Adjectives

-- Non-comparison one-place adjectives are just like nouns.

  mkA : N -> A ;

-- Two-place adjectives need a case for the second argument.

  mkA2 : A -> Case -> A2 ;

-- Comparison adjectives have three forms. The comparative and the superlative
-- are always inflected in the same way, so the nominative of them is actually
-- enough (except for the superlative "paras" of "hyvä").

  mkADeg : (kiva : N) -> (kivempaa,kivinta : Str) -> ADeg ;

-- Without $optimize=noexpand$, this function would expands to enormous size.

  regADeg : (suuri : Str) -> ADeg ;

--2 Verbs
--
-- The fragment only has present tense so far, but in all persons.
-- The worst case needs twelve forms, as shown in the following.

  mkV   : (tulla,tulee,tulen,tulevat,tulkaa,tullaan,
           tuli,tulin,tulisi,tullut,tultu,tullun : Str) -> V ;
  regV  : (soutaa : Str) -> V ;
  reg2V : (soutaa,souti : Str) -> V ;
  reg3V : (soutaa,soudan,souti : Str) -> V ;

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

-- All the patterns above have $nominative$ as subject case.
-- If another case is wanted, use the following.

  caseV : Case -> V -> V ;

-- The verbs "be" and the negative auxiliary are special.

  vOlla : V ;
  vEi   : V ;

-- Two-place verbs need a case, and can have a pre- or postposition.
-- At least one of the latter is empty, $[]$.

  mkV2 : V -> PPosition -> V2 ;

-- If both are empty, the following special function can be used.

  caseV2 : V -> Case -> V2 ;

-- Verbs with a direct (accusative) object
-- are special, since their complement case is finally decided in syntax.

  dirV2 : V -> V2 ;

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> PPosition -> PPosition -> V3 ;    -- speak, with, about
  dirV3    : V -> Case      -> V3 ;                 -- give,_,to
  dirdirV3 : V              -> V3 ;                 -- acc, allat

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V  -> V0 ;
  mkVS  : V  -> VS ;
  mkV2S : V2 -> V2S ;
  mkVV  : V  -> VV ;
  mkV2V : V2 -> V2V ;
  mkVA  : V  -> Case -> VA ;
  mkV2A : V2 -> Case -> V2A ;
  mkVQ  : V  -> VQ ;
  mkV2Q : V2 -> V2Q ;

  mkAS  : A  -> AS ;
  mkA2S : A2 -> A2S ;
  mkAV  : A  -> AV ;
  mkA2V : A2 -> A2V ;


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
  translative = Transl ;
  inessive = Iness ;
  elative = Elat ;
  illative = Illat ;
  adessive = Adess ;
  ablative = Ablat ;
  allative = Allat ;

  PPosition : Type = {c : ComplCase ; s3 : Str ; p : Bool} ;
  prepP  : Case -> Str -> PPosition = 
    \c,p -> {c = CCase c ; s3 = p ; p = True} ;
  postpP : Case -> Str -> PPosition =
    \c,p -> {c = CCase c ; s3 = p ; p = False} ;
  caseP : Case -> PPosition =
    \c -> {c = CCase c ; s3 = [] ; p = True} ;
  accusative =  {c = CAcc ; s3 = [] ; p = True} ;

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
    "as" | "äs" => sRae vesi (strongGrade ves + (a + "n" + a)) ;
    "ar" | "är" => sRae vesi (strongGrade ves + ("ren" + a)) ;
  _ => case i of {
    "n"         => sLiitin vesi ;
    "s"         => sTilaus vesi (ves + ("ksen" + a)) ;
    "i" =>         sBaari (vesi + a) ;
    "e" =>         sRae vesi (strongGrade (ves + "e") + "en" + a) ;
    "a" | "o" | "u" | "y" | "ä" | "ö" => sLukko vesi ;
    _ =>             sLinux (vesi + "i" + a)
  }
  }
  }  ** {g = NonHuman ; lock_N = <>} ;

reg2N : (savi,savia : Str) -> N = \savi,savia -> 
  let
    savit = regN savi ;
    ia = Predef.dp 2 savia ;
    i  = init ia ;
    a  = last ia ;
    o  = last savi ;
    savin = weakGrade savi + "n" ;
  in
  case <o,ia> of {
    <"i","ia">              => sArpi  savi ;
    <"i","iä">              => sSylki savi ;
    <"i","ta"> | <"i","tä"> => sTohtori (savi + a) ;
    <"o","ta"> | <"ö","tä"> => sRadio savi ;  
    <"a","ta"> | <"ä","tä"> => sPeruna savi ;  
    <"a","ia"> | <"a","ja"> => sKukko savi savin savia ;
    _ => savit
    }  ** {g = NonHuman ; lock_N = <>} ;

reg3N = \vesi,veden,vesiä -> 
  let
    vesit = reg2N vesi vesiä ;
    si = Predef.dp 2 vesi ;
    i  = last si ;
    a  = last vesiä ;
    s  = last (Predef.tk 2 vesiä)
  in 
  case si of {
    "us" | "ys" =>
       ifTok CommonNoun (Predef.dp 3 veden) "den" 
         (sRakkaus vesi)
         (sTilaus vesi (veden + a)) ;
    "li" | "ni" | "ri" => sSusi vesi veden (Predef.tk 1 vesi + ("en" + a)) ; 
    "si" => sSusi vesi veden (Predef.tk 2 vesi + ("ten" + a)) ; 
    _ => case i of {
      "a" | "o" | "u" | "y" | "ä" | "ö" => sKukko vesi veden vesiä ;
      "i" => sKorpi vesi veden (init veden + "n" + a) ;
      _ => vesit
      }
    } ** {g = NonHuman ; lock_N = <>} ;

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
  mkN3 = \n,c,e -> n2n n ** {c = NPCase c ; c2 = NPCase e ; lock_N3 = <>} ;
  genN2 = \n -> mkN2 n genitive ;
  mkPN n = mkProperName n ** {lock_PN = <>} ;

  mkA = \x -> noun2adj x ** {lock_A = <>} ;
  mkA2 = \x,c -> x ** {c = CCase c ; lock_A2 = <>} ;
  mkADeg x kivempi kivin = 
    let
      a = last (x.s ! ((NCase Sg Part))) ; ---- gives "kivinta"
      kivempaa = init kivempi + a + a ;
      kivinta = kivin + "t" + a 
    in
    regAdjDegr x kivempaa kivinta ** {lock_ADeg = <>} ;

  regADeg suuri =
    let suur = regN suuri in
    mkADeg 
      suur 
      (init (suur.s ! NCase Sg Gen) + "mpi")
      (init (suur.s ! NCase Pl Ess)) ;

  mkV a b c d e f g h i j k l = mkVerb a b c d e f g h i j k l ** 
    {sc = Nom ; lock_V = <>} ;

regV soutaa = 
  let
    taa = Predef.dp 3 soutaa ;
    ta  = init taa ;
    aa  = Predef.dp 2 taa ;
    juo = Predef.tk 2 soutaa ;
    souda = weakGrade (init soutaa) ;
    soudan = juo + "en" ;
    o  = Predef.dp 1 juo ;
    a = last aa ;
    u = ifTok Str a "a" "u" "y" ;
    joi = Predef.tk 2 juo + (o + "i")
  in case ta of {
    "st" | "nn" | "rr" | "ll" => vJuosta soutaa soudan (juo +   o+u+"t") (juo + "t"+u) ;
      _ => case aa of {
    "aa" | "ää" => vOttaa soutaa (souda + "n") ;
    "da" | "dä" => vJuoda soutaa joi ;
    "ta" | "tä" => vOsata soutaa ;
    _ => vHukkua soutaa souda
    }} ** {sc = Nom ; lock_V = <>} ;

reg2V : (soutaa,souti : Str) -> V = \soutaa,souti ->
  let
    soudat = regV soutaa ;
    soudan = weakGrade (init soutaa) + "n" ;
    soudin = weakGrade souti + "n" ;
    souden = init souti + "en" ;
    juo = Predef.tk 2 soutaa ;
    o  = Predef.dp 1 juo ;
    u = ifTok Str (last soutaa) "a" "u" "y" ;
    aa  = Predef.dp 2 soutaa ;
    taa = Predef.dp 3 soutaa ;
    ta  = Predef.tk 1 taa ;
  in 
  case aa of {
    "aa" | "ää" => vHuoltaa soutaa soudan souti soudin ;
     _ => case ta of {
    "at" | "ät" => vPalkata soutaa souti ;
    "st"        => vJuosta soutaa souden (juo +   o+u+"t") (juo + "t"+u) ;
    _ => soudat
    }} ** {sc = Nom ; lock_V = <>} ;

reg3V soutaa soudan souti = 
  let
    taa   = Predef.dp 3 soutaa ;
    ta    = init taa ;
    aa    = Predef.dp 2 taa ;
    souda = init soudan ;
    juo = Predef.tk 2 soutaa ;
    o  = last juo ;
    a = last aa ;
    u = ifTok Str a "a" "u" "y" ;
    soudin = weakGrade souti + "n" ;
    soudat = reg2V soutaa souti ;
  in case ta of {
    "ll" => vJuosta soutaa soudan (juo +   o+u+"t") (juo + "t"+u) ;
      _ => case aa of {
    "aa" | "ää" => vHuoltaa soutaa soudan souti soudin ;
    "da" | "dä" => vJuoda soutaa souti ;
    _ => soudat
    }} ** {sc = Nom ; lock_V = <>} ;

  vValua v = vSanoa v ** {sc = Nom ; lock_V = <>} ;
  vKattaa v u = vOttaa v u ** {sc = Nom ; lock_V = <>} ;
  vOstaa v = vPoistaa v ** {sc = Nom ; lock_V = <>} ;
  vNousta v u = vJuosta v u [] [] ** {sc = Nom ; lock_V = <>} ; -----
  vTuoda v = vJuoda v [] ** {sc = Nom ; lock_V = <>} ; -----
  caseV c v = {s = v.s ; sc = c ; lock_V = <>} ;

  vOlla = verbOlla ** {sc = Nom ; lock_V = <>} ;
  vEi = verbEi ** {sc = Nom ; lock_V = <>} ;


  vHuoltaa : (_,_,_,_ : Str) -> Verb = \ottaa,otan,otti,otin -> 
    SyntaxFin.vHuoltaa ottaa otan otti otin  ** {sc = Nom ; lock_V = <>} ;
  mkV2 = \v,c -> v ** {s3 = c.s3 ; p = c.p ; c = c.c ; lock_V2 = <>} ;
  caseV2 = \v,c -> mkV2 v (caseP c) ; 
  dirV2 v = mkTransVerbDir v ** {lock_V2 = <>} ;

  mkAdv : Str -> Adv = \s -> {s = s ; lock_Adv = <>} ;


  mkV3 v p q = v ** 
    {s3 = p.s3 ; p = p.p ; c = p.c ; s5 = q.s3 ; p2 = q.p ; c2 = q.c ;
    lock_V3 = <>} ; 
  dirV3 v p = mkV3 v accusative (caseP p) ;
  dirdirV3 v = dirV3 v allative ;

  mkV0  v = v ** {lock_V0 = <>} ;
  mkVS  v = v ** {lock_VS = <>} ;
  mkV2S v = v ** {lock_V2S = <>} ;
--  mkVV  v = v ** {lock_VV = <>} ;
  mkV2V v = v ** {lock_V2V = <>} ;
  mkVA  v c = v ** {c = c ; lock_VA = <>} ;
  mkV2A v c = v ** {c2 = c ; lock_V2A = <>} ;
  mkVQ  v = v ** {lock_VQ = <>} ;
  mkV2Q v = v ** {lock_V2Q = <>} ;

  mkAS  v = v ** {lock_AS = <>} ;
  mkA2S v = v ** {lock_A2S = <>} ;
  mkAV  v = v ** {lock_AV = <>} ;
  mkA2V v = v ** {lock_A2V = <>} ;

--  inf_illative
--  infinitive


--  V3     = TransVerb ** {s5, s6 : Str ; c2 : ComplCase} ;
--           Verb ** {s3, s4 : Str ; c : ComplCase} ;
--  mkN3 n c1 c2
-- {c : NPForm} ;
--  N3     = Function ** {c2 : NPForm} ;

} ;

