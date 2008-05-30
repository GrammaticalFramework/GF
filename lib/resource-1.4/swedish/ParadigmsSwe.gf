--# -path=.:../scandinavian:../common:../abstract:../../prelude

--1 Swedish Lexical Paradigms
--
-- Aarne Ranta 2001 - 2006
--
-- This is an API for the user of the resource grammar 
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
-- separate module [``IrregSwe`` ../../swedish/IrregSwe],
-- which covers many irregular verbs.


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

-- Prepositions used in many-argument functions can be constructed from strings.

  mkPrep : Str -> Prep ;
  noPrep : Prep ;         -- empty string


--2 Nouns

-- The following overloaded paradigm takes care of all noun formation.

  mkN : overload {

-- The one-argument case takes the singular indefinite form and computes 
-- the other forms and the gender by a simple heuristic. The heuristic is currently 
-- to treat all words ending with "a" like "apa-apor", with "e" like "rike-riken",
-- and otherwise like "bil-bilar".

    mkN : (apa : Str) -> N ;

-- The case with a string and gender makes it possible to treat 
-- "lik" (neutrum) and "pojke" (utrum).

    mkN : (lik : Str) -> Gender -> N ; 

-- Giving two forms - the singular and plural indefinite - is sufficient for
-- most nouns. The paradigm deals correctly with the vowel contractions in 
-- "nyckel - nycklar" such as "pojke - pojkar".

    mkN : (nyckel,nycklar : Str) -> N ; 

-- In the worst case, four forms are needed.

    mkN : (museum,museet,museer,museerna : Str) -> N
  } ;

-- All the functions above work quite as well to form *compound nouns*,
-- such as "fotboll". 



--3 Relational nouns 
-- 
-- Relational nouns ("kung av x") are nouns with a preposition. 
-- As a special case, we provide regular nouns (formed with one-argument $mkN$)
-- with the preposition "av". 

  mkN2 : overload {
    mkN2 : Str -> N2 ;
    mkN2 : N -> Prep -> N2
  } ;

-- Three-place relational nouns ("förbindelse från x till y") 
-- need two prepositions.

  mkN3 : N -> Prep -> Prep -> N3 ;


--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "den före detta maken till"). However, $N2$ and
-- $N3$ are purely lexical categories. But you can use the $AdvCN$
-- and $PrepNP$ constructions to build phrases like this.

-- 
--3 Proper names and noun phrases
--
-- Proper names, with a regular genitive, are formed from strings and
-- have the default gender utrum. 

  mkPN : overload {
    mkPN : Str -> PN ;
    mkPN : Str -> Gender -> PN ;

-- In the worst case, the genitive form is irregular.

    mkPN : (jesus,jesu : Str) -> Gender -> PN
    } ;


--2 Adjectives

-- Adjectives need one to seven forms. 

  mkA : overload {

-- Most adjectives are formed simply by adding endings to a stem.

    mkA : (billig : Str) -> A ;

-- Some adjectives have a deviant neuter form. The following pattern
-- also recognizes the neuter formation "galen-galet" and forms the
-- proper plural and comparison forms "galna-galnare-galnast".

    mkA : (bred,brett : Str) -> A ;

-- Umlaut in comparison forms is 

    mkA : (tung,tyngre,tyngst : Str) -> A ;

-- A few adjectives need 5 forms.
    mkA : (god,gott,goda,battre,bast : Str) -> A ;

-- Hardly any other adjective than "liten" needs the full 7 forms.
 
    mkA : (liten,litet,lilla,sma,mindre,minst,minsta : Str) -> A
    } ;

-- Comparison forms may be compound ("mera svensk" - "mest svensk");
-- this behaviour can be forced on any adjective.

  compoundA : A -> A ;




--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Prep -> A2 ;


--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal in subordinate position
-- (e.g. "alltid").

  mkAdv : Str -> Adv ;  -- här
  mkAdV : Str -> AdV ;  -- alltid

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;

--2 Verbs
--
-- All verbs can be defined by the overloaded paradigm $mkV$.

  mkV : overload {

-- The 'regular verb' (= one-place) case is inspired by Lexin. It uses the
-- present tense indicative form. The value is the first conjugation if the
-- argument ends with "ar" ("tala" - "talar" - "talade" - "talat"),
-- the second with "er" ("leka" - "leker" - "lekte" - "lekt", with the
-- variations like in "gräva", "vända", "tyda", "hyra"), and 
-- the third in other cases ("bo" - "bor" - "bodde" - "bott").
-- It is also possible to give the infinite form to it; they are treated
-- as if they were implicitly suffixed by "r". Moreover, deponent verbs
-- are recognized from the final "s" ("hoppas").

    mkV : (stämmer : Str) -> V ;

-- Most irregular verbs need just the conventional three forms.

    mkV : (dricka,drack,druckit : Str) -> V ;

-- In the worst case, six forms are given.

    mkV : (gå,går,gå,gick,gått,gången : Str) -> V ;

-- Particle verbs, such as "passa på", are formed by adding a string to a verb.

    mkV : V -> Str -> V
    } ;


--3 Deponent verbs.
--
-- Some words are used in passive forms only, e.g. "hoppas", some as
-- reflexive e.g. "ångra sig". Regular deponent verbs are also
-- handled by $mkV$ and recognized from the ending "s".

  depV  : V -> V ;
  reflV : V -> V ;


--3 Two-place verbs
--
-- Two-place verbs need a preposition, which default to the 'empty preposition'
-- i.e. direct object. (transitive verbs). The simplest case is a regular
-- verb (as in $mkV$) with a direct object.
-- Notice that, if a particle is needed, it comes from the $V$.

  mkV2 : overload {
    mkV2 : Str -> V2 ;
    mkV2 : V   -> V2 ;
    mkV2 : V   -> Prep -> V2
    } ;


--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent. The simplest case is a regular
-- verb (as in $mkV$) with no prepositions.

  mkV3 : overload {
    mkV3 : Str -> V3 ;
    mkV3 : V   -> V3 ;
    mkV3 : V   -> Prep -> V3 ;
    mkV3 : V   -> Prep -> Prep -> V3
    } ;

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

-- Notice: categories $AS, A2S, AV, A2V$ are just $A$.
-- $V0$ is just $V$.

  V0 : Type ;
  AS, A2S, AV, A2V : Type ;

--.
--2 Definitions of the paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.

  Gender = ResSwe.Gender ; 
  Number = CommonScand.Number ;
  Case = CommonScand.Case ;
  utrum = Utr ; 
  neutrum = Neutr ;
  singular = Sg ;
  plural = Pl ;
  nominative = Nom ;
  genitive = Gen ;

  mkPrep p = {s = p ; lock_Prep = <>} ;
  noPrep = mkPrep [] ;

  mkN = overload {
    mkN : (apa : Str) -> N = regN ;
    mkN : Str -> Gender -> N = regGenN ; 
    mkN : (nyckel, nycklar : Str) -> N = mk2N ; 
    mkN : (museum,museet,museer,museerna : Str) -> N = mk4N
  } ;

  mk4N : (museum,museet,museer,museerna : Str) -> N = \apa,apan,apor,aporna ->  {
    s = nounForms apa apan apor aporna ;
    g = case last apan of {
      "n" => Utr ;
      _ => Neutr
      }
    } ** {lock_N = <>} ;

  regN : Str -> N = \bil -> regGenN bil g where {
    g = case <bil : Str> of {
      _ + "e" => Neutr ;
      _       => Utr
      }
    } ;

  regGenN : Str -> Gender -> N = \bil, g -> case g of {
    Utr => case last bil of {
      "a" => decl1Noun bil ;
      _   => decl2Noun bil
      } ;
    Neutr => case last bil of {
      "e" => decl4Noun bil ;
      _   => decl5Noun bil
      }
    } ** {lock_N = <>} ;

  mk1N : Str -> N = \bilarna -> case bilarna of {
    ap  + "orna" => decl1Noun (ap + "a") ;
    bil + "arna" => decl2Noun bil ;
    rad + "erna" => decl3Noun rad ;
    rik +  "ena" => decl4Noun (rik + "e") ;
    husen        => decl5Noun (Predef.tk 2 husen)
    } ;

  mk2N : Str -> Str -> N = \bil,bilar -> 
   ifTok N bil bilar (decl5Noun bil) (
     case Predef.dp 2 bilar of {
       "or" => case bil of {
          _ + "a"  => decl1Noun bil ; -- apa, apor
          _ + "o"  => mk4N bil (bil + "n")  bilar (bilar + "na") ; -- ko,kor
          _        => mk4N bil (bil + "en") bilar (bilar + "na")   -- ros,rosor
          } ;
       "ar" => decl2Noun bil ;
       "er" => case bil of {
         _ + "or" => mk4N bil (bil + "n") bilar (bilar + "na") ; -- motor,motorn
         _   => decl3gNoun bil bilar                      -- fot, fötter
         } ;
       "en" => decl4Noun bil ;                             -- rike, riken
       _    => mk4N bil (bil + "et") bilar (bilar + "n") -- centrum, centra 
      }) ;

-- School declensions.

  decl1Noun : Str -> N = \apa -> 
    let ap = init apa in
    mk4N apa (apa + "n") (ap + "or") (ap + "orna") ;

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
    in mk4N bil bb.p2 bb.p1 (bb.p1 + "na") ;

  decl3Noun : Str -> N = \sak ->
    case last sak of {
      "e" => mk4N sak (sak + "n") (sak +"r") (sak + "rna") ;
      "y" | "å" | "é" | "y" => mk4N sak (sak + "n") (sak +"er") (sak + "erna") ;
      _ => mk4N sak (sak + "en") (sak + "er") (sak + "erna")
      } ;
  decl3gNoun : Str -> Str -> N = \sak,saker ->
    case last sak of {
      "e" => mk4N sak (sak + "n") saker (saker + "na") ;
      "y" | "å" | "é" | "y" => mk4N sak (sak + "n") saker (saker + "na") ;
      _ => mk4N sak (sak + "en") saker (saker + "na")
      } ;

  decl4Noun : Str -> N = \rike ->
    mk4N rike (rike + "t") (rike + "n") (rike + "na") ;

  decl5Noun : Str -> N = \lik ->
    case Predef.dp 3 lik of {
      "are" => mk4N lik (lik + "n") lik (init lik + "na") ; -- kikare 
      _ => mk4N lik (lik + "et") lik (lik + "en")
      } ;

  mkN2 = overload {
    mkN2 : Str -> N2 = \s -> mmkN2 (regN s) (mkPrep "av") ;
    mkN2 : N -> Prep -> N2 = mmkN2 
  } ;

  mmkN2 : N -> Prep -> N2 ;
  regN2 : Str -> Gender -> N2 ;


  mmkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p.s} ;
  regN2 n g = mmkN2 (regGenN n g) (mkPrep "av") ;
  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p.s ; c3 = q.s} ;

  mkPN = overload {
    mkPN : Str -> PN = regPN ;
    mkPN : Str -> Gender -> PN = regGenPN ;
    mkPN : (jesus,jesu : Str) -> Gender -> PN = \jesus,jesu,g -> 
      {s = table {Nom => jesus ; Gen => jesu} ; g = g ; lock_PN = <>} ;
    } ;

  regPN n = regGenPN n utrum ;
  regGenPN n g = {s = \\c => mkCase c n ; g = g} ** {lock_PN = <>} ;
  nounPN n = {s = n.s ! singular ! Indef ; g = n.g ; lock_PN = <>} ;
  makeNP x y n g = 
    {s = table {NPPoss _ => y ; _ => x} ; a = agrP3 g n ; p = P3 ;
     lock_NP = <>} ;

  mkA = overload {
    mkA : (billig : Str) -> A = regA ;
    mkA : (bred,brett : Str) -> A = mk2A ;
    mkA : (tung,tyngre,tyngst : Str) -> A = irregA ;
    mkA : (god,gott,goda,battre,bast : Str) -> A = 
      \liten,litet,lilla,mindre,minst -> 
        mk7A liten litet lilla lilla mindre minst (minst + "a") ;
    mkA : (liten,litet,lilla,sma,mindre,minst,minsta : Str) -> A = mk7A
    } ;


  regA : Str -> A ;
  mk2A :  (bred,brett : Str) -> A ;
  irregA : (tung,tyngre,tyngst : Str) -> A ;
  mk7A : (liten,litet,lilla,sma,mindre,minst,minsta : Str) -> A ;

  mk7A a b c d e f g = mkAdjective a b c d e f g ** {isComp = False ; lock_A = <>} ;
  regA fin = 
    let fint : Str = case fin of {
      ru  + "nd" => ru  + "nt" ; 
      se  + "dd" => se  + "tt" ; 
      pla + "tt" => pla + "tt" ; 
      gla + "d"  => gla + "tt" ;
      _          => fin + "t" 
    } 
    in
    mk3A fin fint (fin + "a") ;
  irregA ung yngre yngst = 
    mk7A ung (ung + "t") (ung + "a") (ung + "a") yngre yngst (yngst+"a") ;

  mk3A ljummen ljummet ljumma =
    mk7A
      ljummen ljummet ljumma ljumma 
      (ljumma + "re") (ljumma + "st") (ljumma + "ste") ;
  mk2A vid vitt = case <vid,vitt> of {
    <gal + "en", _ + "et"> => mk3A vid vitt (gal + "na") ;
    _ => mk3A vid vitt (vid + "a")
    } ;

  compoundA adj = {s = adj.s ; isComp = True ; lock_A = <>} ;

  mkA2 a p = a ** {c2 = p.s ; lock_A2 = <>} ;

  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  mkV = overload {
    mkV : (stämmer : Str) -> V = regV ;
    mkV : (dricka,drack,druckit : Str) -> V = irregV ;
    mkV : (supa,super,sup,söp,supit,supen : Str) -> V = mk6V ;
    mkV : V -> Str -> V = partV
    } ;

  mk6V = \finna,finner,finn,fann,funnit,funnen ->
    let 
      funn = ptPretForms funnen ;
      funnet = funn ! Strong SgNeutr ! Nom ;
      funna  = funn ! Strong Plg ! Nom 
    in
    mkVerb finna finner finn fann funnit funnen funnet funna **
    {part = [] ; vtype=VAct ; lock_V = <>} ;

  regV leker = case leker of {
    lek + "a"  => conj1 leker ; --- bw compat
    lek + "ar" => conj1 (lek + "a") ;
    lek + "er" => conj2 (lek + "a") ;
    bo  + "r"  => conj3 bo ;
    ret + "as" => depV (conj1 (ret + "a")) ; 
    n + ("os" | "ys" | "ås" | "ös") => depV (conj3 (init leker)) ;
    ret + "s"  => depV (conj2 (ret + "a")) ;
    _          => conj3 leker
    } ;

  mk2V leka lekte = case <leka,lekte> of {
    <_, _ + "ade"> => conj1 leka ;  
    <_ + "a", _>   => conj2 leka ;
    _ => conj3 leka
    } ;

-- school conjugations

  conj1 : Str -> V = \tala ->
    mk6V tala (tala + "r") tala (tala +"de") (tala +"t") (tala +"d") ;

  conj2 : Str -> V = \leka ->
    let lek = init leka in
    case last lek of {
      "l" | "m" | "n" | "v" | "g" => 
        let gom = case <lek : Tok> of {
          _ + "mm" => init lek ;
          _ => lek
          }
        in mk6V leka (lek + "er") gom (gom +"de") (gom +"t") (gom +"d") ;
      "r" =>
        mk6V leka lek lek (lek +"de") (lek +"t") (lek +"d") ;
      _ => case lek of {
        _ + "nd" => 
          mk6V leka (lek + "er") lek (lek +"e") (init lek +"t") lek ;
        _ => 
          mk6V leka (lek + "er") lek (lek +"te") (lek +"t") (lek +"t")
        } 
      } ;

  conj3 : Str -> V = \bo ->
    mk6V bo (bo + "r") bo (bo +"dde") (bo +"tt") (bo +"dd") ;

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
    mk6V sälja (säljer.s ! VF (VPres Act)) (säljer.s ! (VF (VImper Act))) sålde sålt såld
     ** {s1 = [] ; lock_V = <>} ;

  partV v p = {s = v.s ; part = p ; vtype = v.vtype ; lock_V = <>} ;
  depV v = {s = v.s ; part = v.part ; vtype = VPass ; lock_V = <>} ;
  reflV v = {s = v.s ; part = v.part ; vtype = VRefl ; lock_V = <>} ;

  mkV2 = overload {
    mkV2 : (läser : Str) -> V2 = \v -> dirV2 (regV v) ;
    mkV2 : V -> V2 = dirV2 ;
    mkV2 : V -> Prep -> V2 = mmkV2
    } ;


  mmkV2 v p = v ** {c2 = p.s ; lock_V2 = <>} ;
  dirV2 v = mmkV2 v noPrep ;

  mkV3 = overload {
    mkV3 : Str -> V3 = \v -> dirdirV3 (regV v) ;
    mkV3 : V   -> V3 = dirdirV3 ;
    mkV3 : V   -> Prep -> V3 = dirV3 ;
    mkV3 : V   -> Prep -> Prep -> V3 = mmkV3
    } ;

  mmkV3     : V -> Prep -> Prep -> V3 ; -- tala, med, om
  dirV3    : V -> Prep -> V3 ;         -- ge, (acc),till
  dirdirV3 : V -> V3 ;                 -- ge, (dat), (acc)


  mmkV3 v p q = v ** {c2 = p.s ; c3 = q.s ; lock_V3 = <>} ;
  dirV3 v p = mmkV3 v noPrep p ;
  dirdirV3 v = dirV3 v noPrep ;

  mkV0  v = v ** {lock_V0 = <>} ;
  mkVS  v = v ** {lock_VS = <>} ;
  mkVV  v = v ** {c2 = "att" ; lock_VV = <>} ;
  mkVQ  v = v ** {lock_VQ = <>} ;

  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p = mmkV2 v p ** {lock_V2A = <>} ;

  V0 : Type = V ;
--  V2S, V2V, V2Q : Type = V2 ;
  AS, A2S, AV : Type = A ;
  A2V : Type = A2 ;

  mkV2S v p = mmkV2 v p ** {lock_V2S = <>} ;
  mkV2V v p t = mmkV2 v p ** {c3 = "att" ; lock_V2V = <>} ;
  mkV2Q v p = mmkV2 v p ** {lock_V2Q = <>} ;

  mkAS  v = v ** {lock_A = <>} ;
  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
  mkAV  v = v ** {lock_A = <>} ;
  mkA2V v p = mkA2 v p ** {lock_A = <>} ;

----------Obsolete

-- To form a noun phrase that can also be plural and have an irregular
-- genitive, you can use the worst-case function.

  makeNP : Str -> Str -> Number -> Gender -> NP ; 

    

  regGenPN : Str -> Gender -> PN ;
  regPN    : Str -> PN ;            -- utrum

-- Sometimes you can reuse a common noun as a proper name, e.g. "Bank".

  nounPN : N -> PN ;

-- Sometimes just the positive forms are irregular.

  mk3A : (galen,galet,galna : Str) -> A ;

  mk6V : (supa,super,sup,söp,supit,supen : Str) -> V ;
  regV : (talar : Str) -> V ;
  mk2V : (leka,lekte : Str) -> V ;
  irregV : (dricka, drack, druckit : Str) -> V ;

  partV : V -> Str -> V ;

  mmkV2  : V -> Prep -> V2 ;

  dirV2 : V -> V2 ;


} ;
