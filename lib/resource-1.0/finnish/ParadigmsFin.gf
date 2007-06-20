--# -path=.:../abstract:../common:../../prelude

--1 Finnish Lexical Paradigms
--
-- Aarne Ranta 2003--2005
--
-- This is an API to the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoFin.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
-- However, this function should only seldom be needed.

resource ParadigmsFin = open 
  (Predef=Predef), 
  Prelude, 
  MorphoFin,
  CatFin
  in {

  flags optimize=noexpand ;

--2 Parameters 
--
-- To abstract over gender, number, and (some) case names, 
-- we define the following identifiers. The application programmer
-- should always use these constants instead of the constructors
-- defined in $ResFin$.

oper
  Number   : Type ;

  singular : Number ;
  plural   : Number ;

  Case        : Type ;
  nominative  : Case ; 
  genitive    : Case ; 
  partitive   : Case ; 
  translative : Case ; 
  inessive    : Case ; 
  elative     : Case ; 
  illative    : Case ; 
  adessive    : Case ; 
  ablative    : Case ; 
  allative    : Case ;

-- The following type is used for defining *rection*, i.e. complements
-- of many-place verbs and adjective. A complement can be defined by
-- just a case, or a pre/postposition and a case.

  prePrep     : Case -> Str -> Prep ;  -- ilman, partitive
  postPrep    : Case -> Str -> Prep ;  -- takana, genitive
  postGenPrep :         Str -> Prep ;  -- takana
  casePrep    : Case ->        Prep ;  -- adessive

--2 Nouns

-- The worst case gives ten forms.
-- In practice just a couple of forms are needed to define the different
-- stems, vowel alternation, and vowel harmony.

oper

-- The regular noun heuristic takes just one form (singular
-- nominative) and analyses it to pick the correct paradigm.
-- It does automatic grade alternation, and is hence not usable
-- for words like "auto" (whose genitive would become "audon").
--
-- If the one-argument paradigm does not give the correct result, one can try and give 
-- two or three forms. Most notably, the two-argument variant is used
-- for nouns like "kivi - kiviä", which would otherwise become like
-- "rivi - rivejä". Three arguments are used e.g. for 
-- "sydän - sydämen - sydämiä", which would otherwise become
-- "sydän - sytämen".

  mkN : overload {
    mkN : (talo : Str) -> N ;
    mkN : (savi,savia : Str) -> N ;
    mkN : (vesi,veden,vesiä : Str) -> N ;
    mkN : (talo,   talon,   talona, taloa, taloon,
           taloina,taloissa,talojen,taloja,taloihin : Str) -> N 
  } ;


-- Some nouns have an unexpected singular partitive, e.g. "meri", "lumi".

  sgpartN : (meri : N) -> (merta : Str) -> N ;
  nMeri   : (meri : Str) -> N ;

-- The rest of the noun paradigms are mostly covered by the three
-- heuristics.
--
-- Nouns with partitive "a","ä" are a large group. 
-- To determine for grade and vowel alternation, three forms are usually needed:
-- singular nominative and genitive, and plural partitive.
-- Examples: "talo", "kukko", "huippu", "koira", "kukka", "syylä", "särki"...

  nKukko : (kukko,kukon,kukkoja : Str) -> N ;

-- A special case:
-- the vowel harmony is inferred from the last letter,
-- which must be one of "o", "u", "ö", "y". Regular weak-grade alternation
-- is performed.

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
-- "malli"-"mallin"-"malleja", with the exception that the "i" is not attached
-- to the singular nominative. Examples: "linux", "savett", "screen".
-- The singular partitive form is used to get the vowel harmony. 
-- (N.B. more than 1-syllabic words ending in "n" would have variant 
-- plural genitive and partitive forms, like
-- "sultanien", "sultaneiden", which are not covered.)

  nLinux : (linuxia : Str) -> N ;

-- Nouns of at least 3 syllables ending with "a" or "ä", like "peruna", "tavara",
-- "rytinä".

  nPeruna : (peruna : Str) -> N ;

-- The following paradigm covers both nouns ending in an aspirated "e", such as
-- "rae", "perhe", "savuke", and also many ones ending in a consonant
-- ("rengas", "kätkyt"). The singular nominative and essive are given.

  nRae : (rae, rakeena : Str) -> N ;

-- The following covers nouns with partitive "ta","tä", such as
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

  compN : Str -> N -> N ;

-- Nouns used as functions need a case, of which the default is
-- the genitive.

  mkN2 = overload {
    mkN2 : N -> N2 = genN2 ;
    mkN2 : N -> Prep -> N2 = mmkN2
    } ;

  mkN3  : N -> Prep -> Prep -> N3 ;

-- Proper names can be formed by using declensions for nouns.
-- The plural forms are filtered away by the compiler.

  mkPN : overload {
    mkPN : Str -> PN ;
    mkPN : N -> PN
    } ;

--2 Adjectives

-- Non-comparison one-place adjectives are just like nouns.
-- The regular adjectives are based on $regN$ in the positive.
-- Comparison adjectives have three forms. 
-- The comparative and the superlative
-- are always inflected in the same way, so the nominative of them is actually
-- enough (except for the superlative "paras" of "hyvä").

  mkA : overload {
    mkA : Str -> A ;
    mkA : N -> A ;
    mkA : N -> (kivempaa,kivinta : Str) -> A
  } ;

-- Two-place adjectives need a case for the second argument.

  mkA2 : A -> Prep -> A2 ;



--2 Verbs
--
-- The grammar does not cover the potential mood and some nominal
-- forms. One way to see the coverage is to linearize a verb to
-- a table.
-- The worst case needs twelve forms, as shown in the following.


-- The following heuristics cover more and more verbs.

  mkV : overload {
    mkV : (soutaa : Str) -> V ;
    mkV : (soutaa,souti : Str) -> V ;
    mkV : (soutaa,soudan,souti : Str) -> V ;
    mkV : (tulla,tulee,tulen,tulevat,tulkaa,tullaan,
           tuli,tulin,tulisi,tullut,tultu,tullun : Str) -> V ;

-- The subject case of verbs is by default nominative. This function can change it.

    mkV : V -> Case -> V
  } ;


-- The rest of the paradigms are special cases mostly covered by the heuristics.
-- A simple special case is the one with just one stem and without grade alternation.

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

-- The verbs "be" is special.

  vOlla : V ;

--3 Two-place verbs
--
-- Two-place verbs need a case, and can have a pre- or postposition.

  mkV2 : V -> Prep -> V2 ;

-- If the complement needs just a case, the following special function can be used.

  caseV2 : V -> Case -> V2 ;

-- Verbs with a direct (accusative) object
-- are special, since their complement case is finally decided in syntax.
-- But this is taken care of in $VerbFin$.

  dirV2 : V -> V2 ;


--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Prep -> Prep -> V3 ;  -- puhua, allative, elative
  dirV3    : V -> Case -> V3 ;          -- siirtää, (accusative), illative
  dirdirV3 : V         -> V3 ;          -- antaa, (accusative), (allative)


--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ;
  mkVS  : V -> VS ;
  mkV2S : V -> Prep -> V2S ;
  mkVV  : V -> VV ;
  mkV2V : V -> Prep -> V2V ;
  mkVA  : V -> Prep -> VA ;
  mkV2A : V -> Prep -> Prep -> V2A ;
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
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.

  Case = MorphoFin.Case ;
  Number = MorphoFin.Number ;

  singular = Sg ;
  plural = Pl ;

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

  prePrep  : Case -> Str -> Prep = 
    \c,p -> {c = NPCase c ; s = p ; isPre = True ; lock_Prep = <>} ;
  postPrep : Case -> Str -> Prep =
    \c,p -> {c = NPCase c ; s = p ; isPre = False ; lock_Prep = <>} ;
  postGenPrep p = {
    c = NPCase genitive ; s = p ; isPre = False ; lock_Prep = <>} ;
  casePrep : Case -> Prep =
    \c -> {c = NPCase c ; s = [] ; isPre = True ; lock_Prep = <>} ;
  accPrep =  {c = NPAcc ; s = [] ; isPre = True ; lock_Prep = <>} ;

  mk10N= \a,b,c,d,e,f,g,h,i,j -> 
    mkNoun a b c d e f g h i j ** {lock_N = <>} ;

  mkN = overload {
    mkN : (talo : Str) -> N = regN ;
    mkN : (savi,savia : Str) -> N = reg2N ;
    mkN : (vesi,veden,vesiä : Str) -> N = reg3N ;
    mkN : (talo,   talon,   talona, taloa, taloon,
           taloina,taloissa,talojen,taloja,taloihin : Str) -> N = mk10N
  } ;

  regN = \vesi -> 
  let
    esi = Predef.dp 3 vesi ;   -- analysis: suffixes      
    a   = if_then_Str (pbool2bool (Predef.occurs "aou" vesi)) "a" "ä" ;
    ves = init vesi ;          -- synthesis: prefixes
    vet = strongGrade ves ;
    ve  = init ves ;
  in nhn (
       case esi of {
    "uus" | "yys" => sRakkaus vesi ;
    _ + "nen"           => sNainen (Predef.tk 3 vesi + ("st" + a)) ;
    _ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö") => sPuu vesi ;
    _ + ("ie" | "uo" | "yö") => sSuo vesi ;
    _ + ("ea" | "eä") => 
        mkSubst
          a
          vesi (vesi) (vesi) (vesi + a)  (vesi + a+"n")
          (ves + "i") (ves + "i") (ves + "iden")  (ves + "it"+a)
          (ves + "isiin") ;
    _ + "is"          => sNauris (vesi + ("t" + a)) ;
    _ + ("ut" | "yt") => sRae vesi (ves + ("en" + a)) ;
    _ + ("as" | "äs") => sRae vesi (vet + (a + "n" + a)) ;
    _ + ("ar" | "är") => sRae vesi (vet + ("ren" + a)) ;
    _ + "n"           => sLiitin vesi (vet + "men") ;
    _ + "s"           => sTilaus vesi (ves + ("ksen" + a)) ;
    _ + "i"           => sBaari (vesi + a) ;
    _ + "e"           => sRae vesi (strongGrade vesi + "en" + a) ;
    _ + ("a" | "o" | "u" | "y" | "ä" | "ö") => sLukko vesi ;
    _                 => sLinux (vesi + "i" + a)
  }
  ) **  {lock_N = <>} ;

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
    <"i","ia">              => nhn (sArpi  savi) ;
    <"i","iä">              => nhn (sSylki savi) ;
    <"o","ta"> | <"ö","tä"> => nhn (sRadio savi) ;  
    <"a","ta"> | <"ä","tä"> => nhn (sPeruna savi) ;  
    <"i","ta"> | <"i","tä"> => nhn (sTohtori (savi + a)) ; -- from 10 to 90 ms
--    <"a","ia"> | <"a","ja"> => nhn (sKukko savi savin savia) ; ---needless?
    _ => savit
    } 
    **  {lock_N = <>} ;

reg3N = \vesi,veden,vesiä -> 
  let
    si = Predef.dp 2 vesi ;
    a  = last vesiä
  in 
  case si of {
    "us" | "ys" =>
       nhn (case Predef.dp 3 veden of {
         "den" => sRakkaus vesi ;
         _     => sTilaus vesi (veden + a)
         }) ;
    "as" | "äs" => nhn (sRae vesi (veden + a)) ;
    "li" | "ni" | "ri" => nhn (sSusi vesi veden (init vesi + ("en" + a))) ; 
    "si"               => nhn (sSusi vesi veden (Predef.tk 2 vesi + ("ten" + a))) ; 
    "in" | "en" | "än" => nhn (sLiitin vesi veden) ;
    _ + ("a" | "o" | "u" | "y" | "ä" | "ö") => nhn (sKukko vesi veden vesiä) ;
    _  {- + "i" -} => nhn (sKorpi vesi veden (init veden + "n" + a))
    }
  ** {lock_N = <>} ;

  nKukko = \a,b,c -> nhn (sKukko a b c) ** {lock_N = <>} ;

  nLukko = \a -> nhn (sLukko a) ** {lock_N = <>} ;
  nTalo = \a -> nhn (sTalo a) ** {lock_N = <>} ;
  nArpi = \a -> nhn (sArpi a) ** {lock_N = <>} ;
  nSylki = \a -> nhn (sSylki a) ** {lock_N = <>} ;
  nLinux = \a -> nhn (sLinux a) ** {lock_N = <>} ;
  nPeruna = \a -> nhn (sPeruna a) ** {lock_N = <>} ;
  nRae = \a,b -> nhn (sRae a b) ** {lock_N = <>} ;
  nSusi = \a,b,c -> nhn (sSusi a b c) ** {lock_N = <>} ;
  nPuu = \a -> nhn (sPuu a) ** {lock_N = <>} ;
  nSuo = \a -> nhn (sSuo a) ** {lock_N = <>} ;
  nNainen = \a -> nhn (sNainen a) ** {lock_N = <>} ;
  nTilaus = \a,b -> nhn (sTilaus a b) ** {lock_N = <>} ;
  nKulaus = \a -> nTilaus a (init a + "ksen" + getHarmony (last
  (init a))) ;
  nNauris = \a -> nhn (sNauris a) ** {lock_N = <>} ;
  sgpartN noun part = {
    s = table { 
      NCase Sg Part => part ;
      c => noun.s ! c
      } ;
    g = noun.g ;
    lock_N = noun.lock_N
    } ;
  nMeri meri = 
    let a = vowelHarmony meri in
    sgpartN (reg2N meri (meri + a)) (init meri + "ta") ;

  compN = \s,n -> {s = \\c => s ++ n.s ! c ; g = n.g ; lock_N = <>} ;


  mkNP  : N -> Number -> CatFin.NP ; 
  mkNP noun num = {
    s = \\c => noun.s ! NCase num (npform2case num c) ; 
    a = agrP3 num ;
    isPron = False ;
    lock_NP = <>
    } ;

  mkPN = overload {
    mkPN : Str -> PN = regPN ;
    mkPN : N -> PN = mmkPN
    } ;

  mkA = overload {
    mkA : Str -> A = regA ;
    mkA : N -> A = mk1A ;
    mkA : N -> (kivempaa,kivinta : Str) -> A = mkADeg
  } ;

  mk1A = \x -> {s = \\_ => (noun2adj x).s ; lock_A = <>} ;
  mkA2 = \x,c -> x ** {c2 = c ; lock_A2 = <>} ;
  mkADeg x kivempi kivin = 
    let
      a = last (x.s ! ((NCase Sg Part))) ; ---- gives "kivinta"
      kivempaa = init kivempi + a + a ;
      kivinta = kivin + "t" + a 
    in
    regAdjective x kivempaa kivinta ** {lock_A = <>} ;

  regA suuri =
    let suur = regN suuri in
    mkADeg 
      suur 
      (init (suur.s ! NCase Sg Gen) + "mpi")
      (init (suur.s ! NCase Pl Ess)) ;

  regADeg = regA ; -- for bw compat

  mk12V a b c d e f g h i j k l = mkVerb a b c d e f g h i j k l ** 
    {sc = NPCase Nom ; lock_V = <>} ;

  mkV = overload {
    mkV  : (soutaa : Str) -> V = regV ;
    mkV : (soutaa,souti : Str) -> V = reg2V ;
    mkV : (soutaa,soudan,souti : Str) -> V = reg3V ;
    mkV : (tulla,tulee,tulen,tulevat,tulkaa,tullaan,
           tuli,tulin,tulisi,tullut,tultu,tullun : Str) -> V = mk12V ;
    mkV : V -> Case -> V = subjcaseV
  } ;

  regV soutaa = v2v (regVerbH soutaa) ** {sc = NPCase Nom ; lock_V = <>} ;

  reg2V : (soutaa,souti : Str) -> V = \soutaa,souti ->
    v2v (reg2VerbH soutaa souti) ** {sc = NPCase Nom ; lock_V = <>} ;

  reg3V soutaa soudan souti = 
    v2v (reg3VerbH soutaa soudan souti) ** {sc = NPCase Nom ; lock_V = <>} ;

  subjcaseV v c = {s = v.s ; sc = NPCase c ; lock_V = v.lock_V} ;

  vValua v = v2v (vSanoa v) ** {sc = NPCase Nom ; lock_V = <>} ;
  vKattaa v u = v2v (vOttaa v u) ** {sc = NPCase Nom ; lock_V = <>} ;
  vOstaa v = v2v (vPoistaa v) ** {sc = NPCase Nom ; lock_V = <>} ;
  vNousta v u = v2v (vJuosta v u [] []) ** {sc = NPCase Nom ; lock_V = <>} ; -----
  vTuoda v = v2v (vJuoda v []) ** {sc = NPCase Nom ; lock_V = <>} ; -----
  caseV c v = {s = v.s ; sc = NPCase c ; lock_V = <>} ;

  vOlla = verbOlla ** {sc = NPCase Nom ; lock_V = <>} ;

  vHuoltaa : (_,_,_,_ : Str) -> Verb = \ottaa,otan,otti,otin -> 
    v2v (MorphoFin.vHuoltaa ottaa otan otti otin)  ** {sc = NPCase Nom ; lock_V = <>} ;


  mkV2 = \v,c -> v ** {c2 = c ; lock_V2 = <>} ;
  caseV2 = \v,c -> mkV2 v (casePrep c) ; 
  dirV2 v = mkV2 v accPrep ;

  mkAdv : Str -> Adv = \s -> {s = s ; lock_Adv = <>} ;


  mkV3 v p q = v ** {c2 = p ; c3 = q ; lock_V3 = <>} ; 
  dirV3 v p = mkV3 v accPrep (casePrep p) ;
  dirdirV3 v = dirV3 v allative ;

  mkVS  v = v ** {lock_VS = <>} ;
  mkVV  v = v ** {lock_VV = <>} ;
  mkVQ  v = v ** {lock_VQ = <>} ;

  V0 : Type = V ;
  V2S, V2V, V2Q : Type = V2 ;
  AS, A2S, AV : Type = A ;
  A2V : Type = A2 ;

  mkV0  v = v ** {lock_V = <>} ;
  mkV2S v p = mkV2 v p ** {lock_V2 = <>} ;
  mkV2V v p = mkV2 v p ** {lock_V2 = <>} ;
  mkVA  v p = v ** {c2 = p ; lock_VA = <>} ;
  mkV2A v p q = v ** {c2 = p ; c3 = q ; lock_V2A = <>} ;
  mkV2Q v p = mkV2 v p ** {lock_V2 = <>} ;

  mkAS  v = v ** {lock_A = <>} ;
  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
  mkAV  v = v ** {lock_A = <>} ;
  mkA2V v p = mkA2 v p ** {lock_A2 = <>} ;


--- old stuff

  reg2N : (savi,savia : Str) -> N ;
  reg3N : (vesi,veden,vesiä : Str) -> N ;

  mk10N: (talo,   talon,   talona, taloa, taloon,
         taloina,taloissa,talojen,taloja,taloihin : Str) -> N ;

  regN : (talo : Str) -> N ;

  mmkN2 : N -> Prep -> N2 = \n,c -> n ** {c2 = c ; lock_N2 = <>} ;
  mkN3 = \n,c,e -> n ** {c2 = c ; c3 = e ; lock_N3 = <>} ;
  genN2 = \n -> mmkN2 n (casePrep genitive) ;
  regPN m = mmkPN (regN m) ;
  mmkPN : N -> PN = \n -> mkProperName n ** {lock_PN = <>} ;

  genN2 : N -> N2 ;


  mk1A : N -> A ;
  mkADeg : (kiva : N) -> (kivempaa,kivinta : Str) -> A ;
  regA : (punainen : Str) -> A ;

  mk12V   : (tulla,tulee,tulen,tulevat,tulkaa,tullaan,
           tuli,tulin,tulisi,tullut,tultu,tullun : Str) -> V ;

  regV  : (soutaa : Str) -> V ;
  reg2V : (soutaa,souti : Str) -> V ;
  reg3V : (soutaa,soudan,souti : Str) -> V ;

  subjcaseV : V -> Case -> V ;

  regPN : Str -> PN ;

} ;
