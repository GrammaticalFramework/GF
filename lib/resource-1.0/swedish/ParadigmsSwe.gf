--# -path=.:../scandinavian:../common:../abstract:../../prelude

--1 Swedish Lexical Paradigms
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
-- The main difference with $MorphoSwe.gf$ is that the types
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

resource ParadigmsSwe = 
  open 
    (Predef=Predef), 
    Prelude, 
    CommonScand, 
    ResSwe, 
    MorphoSwe, 
    CatSwe in {

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender : Type ; 

  utrum     : Gender ;
  neutrum   : Gender ;

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

-- Worst case: give all four forms. The gender is computed from the
-- last letter of the second form (if "n", then $utrum$, otherwise $neutrum$).

  mkN  : (apa,apan,apor,aporna : Str) -> N ;

-- The regular function takes the singular indefinite form and the gender,
-- and computes the other forms by a heuristic. 
-- If in doubt, use the $cc$ command to test!

  regN : Str -> Gender -> N ;

-- In practice the worst case is often just: give singular and plural indefinite.

  mk2N : (nyckel,nycklar : Str) -> N ;

-- This heuristic takes just the plural definite form and infers the others.
-- It does not work if there are changes in the stem.

  mk1N : (bilarna : Str) -> N ;
  

--3 Compound nouns 
--
-- All the functions above work quite as well to form compound nouns,
-- such as "fotboll". 


--3 Relational nouns 
-- 
-- Relational nouns ("daughter of x") need a preposition. 

  mkN2 : N -> Preposition -> N2 ;

-- The most common preposition is "av", and the following is a
-- shortcut for regular, $nonhuman$ relational nouns with "av".

  regN2 : Str -> Gender -> N2 ;

-- Use the function $mkPreposition$ or see the section on prepositions below to  
-- form other prepositions.
--
-- Three-place relational nouns ("the connection from x to y") need two prepositions.

  mkN3 : N -> Preposition -> Preposition -> N3 ;


--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "the old town hall of"). However, $N2$ and
-- $N3$ are purely lexical categories. But you can use the $AdvCN$
-- and $PrepNP$ constructions to build phrases like this.

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

-- Adjectives may need as many as seven forms. 

  mkA : (liten, litet, lilla, sma, mindre, minst, minsta : Str) -> A ;

-- The regular pattern works for many adjectives, e.g. those ending
-- with "ig".

  regA : Str -> A ;

-- Just the comparison forms can be irregular.

  irregA : (tung,tyngre,tyngst : Str) -> A ;

-- Sometimes just the positive forms are irregular.

  mk3A : (galen,galet,galna : Str) -> A ;
  mk2A : (bred,brett        : Str) -> A ;


--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Preposition -> A2 ;


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
-- The worst case needs five forms.

  mkV : (supa,super,sup,söp,supit,supen : Str) -> V ;

-- The 'regular verb' function is inspired by Lexin. It uses the
-- present tense indicative form. The value is the first conjugation if the
-- argument ends with "ar" ("tala" - "talar" - "talade" - "talat"),
-- the second with "er" ("leka" - "leker" - "lekte" - "lekt", with the
-- variations like "gräva", "vända", "tyda", "hyra"), and 
-- the third in other cases ("bo" - "bor" - "bodde" - "bott").

  regV : (talar : Str) -> V ;

-- The almost regular verb function needs the infinitive and the preteritum.
-- It is not really more powerful than the new implementation of
-- $regV$ based on the indicative form.

  mk2V : (leka,lekte : Str) -> V ;

-- There is an extensive list of irregular verbs in the module $IrregularSwe$.
-- In practice, it is enough to give three forms, as in school books.

  irregV : (dricka, drack, druckit : Str) -> V ;


--3 Verbs with a particle.
--
-- The particle, such as in "passa på", is given as a string.

  partV  : V -> Str -> V ;

--3 Deponent verbs.
--
-- Some words are used in passive forms only, e.g. "hoppas", some as
-- reflexive e.g. "ångra sig".

  depV  : V -> V ;
  reflV : V -> V ;

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

  mkV3     : V -> Preposition -> Preposition -> V3 ; -- tala med om
  dirV3    : V -> Preposition -> V3 ;                -- ge _ till
  dirdirV3 : V -> V3 ;                               -- ge _ _

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

-- Notice: categories $V2S, V2V, V2A, V2Q$ are in v 1.0 treated
-- just as synonyms of $V2$, and the second argument is given
-- as an adverb. Likewise $AS, A2S, AV, A2V$ are just $A$.
-- $V0$ is just $V$.

  V0, V2S, V2V, V2A, V2Q : Type ;
  AS, A2S, AV, A2V : Type ;


--2 Definitions of the paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.

  Gender = ResSwe.Gender ; 
  Number = CommonScand.Number ;
  Case = CommonScand.Case ;
  utrum = Utr ; 
  neutrum = Neutr ;
  singular = Sg ;
  plural = Pl ;
  nominative = Nom ;
  genitive = Gen ;

  mkN = \apa,apan,apor,aporna ->  {
    s = nounForms apa apan apor aporna ;
    g = case last apan of {
      "n" => Utr ;
      _ => Neutr
      }
    } ** {lock_N = <>} ;

  regN bil g = case g of {
    Utr => case last bil of {
      "a" => decl1Noun bil ;
      _   => decl2Noun bil
      } ;
    Neutr => case last bil of {
      "e" => decl4Noun bil ;
      _   => decl5Noun bil
      }
    } ** {lock_N = <>} ;

  mk1N bilarna = case bilarna of {
    ap  + "orna" => decl1Noun (ap + "a") ;
    bil + "arna" => decl2Noun bil ;
    rad + "erna" => decl3Noun rad ;
    rik +  "ena" => decl4Noun (rik + "e") ;
    husen        => decl5Noun (Predef.tk 2 husen)
    } ;

  mk2N bil bilar = 
   ifTok N bil bilar (decl5Noun bil) (
     case Predef.dp 2 bilar of {
       "or" => case bil of {
          _ + "a"  => decl1Noun bil ; -- apa, apor
          _ + "o"  => mkN bil (bil + "n")  bilar (bilar + "na") ; -- ko,kor
          _        => mkN bil (bil + "en") bilar (bilar + "na")   -- ros,rosor
          } ;
       "ar" => decl2Noun bil ;
       "er" => decl3gNoun bil bilar ;                   -- fot, fötter
       "en" => decl4Noun bil ;                             -- rike, riken
       _    => mkN bil (bil + "et") bilar (bilar + "n") -- centrum, centra 
      }) ;

-- School declensions.

  decl1Noun : Str -> N = \apa -> 
    let ap = init apa in
    mkN apa (apa + "n") (ap + "or") (ap + "orna") ;

  decl2Noun : Str -> N = \bil ->
    let 
      bb : Str * Str = case bil of {
        br   + ("o" | "u" | "ö" | "å") => <bil + "ar",    bil  + "n"> ;
        pojk + "e"                     => <pojk + "ar",    bil  + "n"> ;
        hi + "mme" + l@("l" | "r")     => <hi + "m" + l + "ar",hi + "m" + l + "en"> ;
        nyck + "e" + l@("l" | "r")     => <nyck + l + "ar",bil  + "n"> ;
        sock + "e" + "n"               => <sock + "nar",   sock + "nen"> ;
        _                              => <bil + "ar",     bil  + "en">
        } ;
    in mkN bil bb.p2 bb.p1 (bb.p1 + "na") ;

  decl3Noun : Str -> N = \sak ->
    case last sak of {
      "e" => mkN sak (sak + "n") (sak +"r") (sak + "rna") ;
      "y" | "å" | "é" | "y" => mkN sak (sak + "n") (sak +"er") (sak + "erna") ;
      _ => mkN sak (sak + "en") (sak + "er") (sak + "erna")
      } ;
  decl3gNoun : Str -> Str -> N = \sak,saker ->
    case last sak of {
      "e" => mkN sak (sak + "n") saker (saker + "na") ;
      "y" | "å" | "é" | "y" => mkN sak (sak + "n") saker (saker + "na") ;
      _ => mkN sak (sak + "en") saker (saker + "na")
      } ;

  decl4Noun : Str -> N = \rike ->
    mkN rike (rike + "t") (rike + "n") (rike + "na") ;

  decl5Noun : Str -> N = \lik ->
    case Predef.dp 3 lik of {
      "are" => mkN lik (lik + "n") lik (init lik + "na") ; -- kikare 
      _ => mkN lik (lik + "et") lik (lik + "en")
      } ;


  mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;
  regN2 n g = mkN2 (regN n g) (mkPreposition "av") ;
  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;

  regPN n g = {s = \\c => mkCase c n ; g = g} ** {lock_PN = <>} ;
  nounPN n = {s = n.s ! singular ! Indef ; g = n.g ; lock_PN = <>} ;
  mkNP x y n g = 
    {s = table {NPPoss _ => y ; _ => x} ; a = agrP3 g n ; p = P3 ;
     lock_NP = <>} ;

  mkA a b c d e f g = mkAdjective a b c d e f g ** {lock_A = <>} ;
  regA fin = 
    let fint : Str = case fin of {
      ru  + "nd" => ru  + "nt" ; 
      se  + "dd" => se  + "tt" ; 
      pla + "tt" => pla + "tt" ; 
      gla + "d"  => gla + "tt" ;
      _          => fin + "t" 
    } 
    in
    mk3A fin fint (fin + "a") ** {lock_A = <>} ;
  irregA ung yngre yngst = 
    mkA ung (ung + "t") (ung + "a") (ung + "a") yngre yngst (yngst+"a") ;

  mk3A ljummen ljummet ljumma =
    mkAdjective 
      ljummen ljummet ljumma ljumma 
      (ljumma + "re") (ljumma + "st") (ljumma + "ste") ** {lock_A = <>} ;
  mk2A vid vitt = mk3A vid vitt (vid + "a") ;


  mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;

  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  mkPreposition p = p ;

  mkV = \finna,finner,finn,fann,funnit,funnen ->
    let 
      funn = ptPretForms funnen ;
      funnet = funn ! Strong SgNeutr ! Nom ;
      funna  = funn ! Strong Plg ! Nom 
    in
    mkVerb finna finner finn fann funnit funnen funnet funna **
    {vtype=VAct ; lock_V = <>} ;

  regV leker = case leker of {
    lek + "a"  => conj1 leker ; --- bw compat
    lek + "ar" => conj1 (lek + "a") ;
    lek + "er" => conj2 (lek + "a") ;
    bo  + "r"  => conj3 bo
    } ;

  mk2V leka lekte = case <leka,lekte> of {
    <_, _ + "ade"> => conj1 leka ;  
    <_ + "a", _>   => conj2 leka ;
    _ => conj3 leka
    } ;

-- school conjugations

  conj1 : Str -> V = \tala ->
    mkV tala (tala + "r") tala (tala +"de") (tala +"t") (tala +"d") ;

  conj2 : Str -> V = \leka ->
    let lek = init leka in
    case last lek of {
      "l" | "m" | "n" | "v" | "g" => 
        let gom = case <lek : Tok> of {
          _ + "mm" => init lek ;
          _ => lek
          }
        in mkV leka (lek + "er") gom (gom +"de") (gom +"t") (gom +"d") ;
      "r" =>
        mkV leka lek lek (lek +"de") (lek +"t") (lek +"d") ;
      _ => case leka of {
        _ + "nd" => 
          mkV leka (lek + "er") lek (lek +"e") (init lek +"t") lek ;
        _ => 
          mkV leka (lek + "er") lek (lek +"te") (lek +"t") (lek +"t")
        } 
      } ;

  conj3 : Str -> V = \bo ->
    mkV bo (bo + "r") bo (bo +"dde") (bo +"tt") (bo +"dd") ;

  irregV = \sälja, sålde, sålt -> 
    let
      säljer = case last sälja of {
        "a" => conj2 sälja ;
        _   => conj3 sälja
        } ;
      såld = case Predef.dp 2 sålt of {
        "it" => Predef.tk 2 sålt + "en" ;
        "tt" => Predef.tk 2 sålt + "dd" ;
        _ => init sålt + "d"
        }
    in 
    mkV sälja (säljer.s ! VF (VPres Act)) (säljer.s ! (VF (VImper Act))) sålde sålt såld
     ** {s1 = [] ; lock_V = <>} ;

  partV v p = {s = \\f => v.s ! f ++ p ; vtype = v.vtype ; lock_V = <>} ;
  depV v = {s = v.s ; vtype = VPass ; lock_V = <>} ;
  reflV v = {s = v.s ; vtype = VRefl ; lock_V = <>} ;

  mkV2 v p = v ** {c2 = p ; lock_V2 = <>} ;
  dirV2 v = mkV2 v [] ;

  mkV3 v p q = v ** {c2 = p ; c3 = q ; lock_V3 = <>} ;
  dirV3 v p = mkV3 v [] p ;
  dirdirV3 v = dirV3 v [] ;

  mkV0  v = v ** {lock_V0 = <>} ;
  mkVS  v = v ** {lock_VS = <>} ;
  mkVV  v = v ** {c2 = "att" ; lock_VV = <>} ;
  mkVQ  v = v ** {lock_VQ = <>} ;

  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p = mkV2 v p ** {lock_V2A = <>} ;

  V0 : Type = V ;
  V2S, V2V, V2Q, V2A : Type = V2 ;
  AS, A2S, AV : Type = A ;
  A2V : Type = A2 ;

  mkV2S v p = mkV2 v p ** {lock_V2 = <>} ;
  mkV2V v p t = mkV2 v p ** {s3 = t ; lock_V2 = <>} ;
  mkV2Q v p = mkV2 v p ** {lock_V2 = <>} ;

  mkAS  v = v ** {lock_A = <>} ;
  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
  mkAV  v = v ** {lock_A = <>} ;
  mkA2V v p = mkA2 v p ** {lock_A = <>} ;

} ;
