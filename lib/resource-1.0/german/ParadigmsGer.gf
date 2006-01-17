--# -path=.:../common:../abstract:../../prelude
--
--1 German Lexical Paradigms
--
-- Aarne Ranta & Harald Hammarström 2003--2006
--
-- This is an API to the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoGer.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
-- However, this function should only seldom be needed: we have a
-- separate module $IrregularGer$, which covers all irregularly inflected
-- words.

resource ParadigmsGer = open 
  (Predef=Predef), 
  Prelude, 
  MorphoGer,
  CatGer
  in {

--2 Parameters 

-- To abstract over gender names, we define the following identifiers.

oper
  Gender    : Type ; 

  masculine : Gender ;
  feminine  : Gender ;
  neuter    : Gender ;

-- To abstract over case names, we define the following.

  Case       : Type ; 

  nominative : Case ;
  accusative : Case ;
  dative     : Case ;
  genitive   : Case ;

-- To abstract over number names, we define the following.

  Number    : Type ; 

  singular  : Number ;
  plural    : Number ;


--2 Nouns

-- Worst case: give all four singular forms, two plural forms (others + dative),
-- and the gender.

  mkN : (x1,_,_,_,_,x6 : Str) -> Gender -> N ; 
                                 -- mann, mann, manne, mannes, männer, männern

-- The regular heuristics recognizes some suffixes, from which it
-- guesses the gender and the declension: "e, ung, ion" give the
-- feminine with plural ending "-n, -en", and the rest are masculines
-- with the plural "-e" (without Umlaut).

  regN : Str -> N ;

-- The 'almost regular' case is much like the information given in an ordinary
-- dictionary. It takes the singular and plural nominative and the
-- gender, and infers the other forms from these.

  reg2N : (x1,x2 : Str) -> Gender -> N ;

-- Relational nouns need a preposition. The most common is "von" with
-- the dative. Some prepositions are constructed in [StructuralGer StructuralGer.html].

  mkN2  : N -> Prep -> N2 ;
  vonN2 : N -> N2 ;

-- Use the function $mkPrep$ or see the section on prepositions below to  
-- form other prepositions.
--
-- Three-place relational nouns ("die Verbindung von x nach y") need two prepositions.

  mkN3 : N -> Prep -> Prep -> N3 ;


--3 Proper names and noun phrases
--
-- Proper names, with a regular genitive, are formed as follows
-- The regular genitive is  "s", omitted after "s".

  mkPN  : (karolus, karoli : Str) -> PN ; -- karolus, karoli
  regPN : (Johann : Str) -> PN ;          -- Johann, Johanns ; Johannes, Johannes


--2 Adjectives

-- Adjectives need four forms: two for the positive and one for the other degrees.

  mkA : (x1,_,_,x4 : Str) -> A ; -- gut,gut,besser,best 

-- The regular adjective formation works for most cases, and includes
-- variations such as "teuer - teurer", "böse - böser".

  regA : Str -> A ;

-- Invariable adjective are a special case. 

  invarA : Str -> A ;            -- prima

-- Two-place adjectives are formed by adding a preposition to an adjective.

  mkA2 : A -> Prep -> A2 ;

--2 Prepositions

-- A preposition is formed from a string and a case.

  mkPrep : Str -> Case -> Prep ;
  
-- Often just a case with the empty string is enough.

  accPrep : Prep ;
  datPrep : Prep ;
  genPrep : Prep ;

-- A couple of common prepositions (always with the dative).

  von_Prep : Prep ;
  zu_Prep  : Prep ;

--2 Verbs

-- The worst-case constructor needs six forms:
-- - Infinitive, 
-- - 3p sg pres. indicative, 
-- - 2p sg imperative, 
-- - 1/3p sg imperfect indicative, 
-- - 1/3p sg imperfect subjunctive (because this uncommon form can have umlaut)
-- - the perfect participle 
--
--
  mkV : (x1,_,_,_,_,x6 : Str) -> V ;   -- geben, gibt, gib, gab, gäbe, gegeben

-- Weak verbs are sometimes called regular verbs.
  
  regV : Str -> V ;                    -- führen

-- Irregular verbs use Ablaut and, in the worst cases, also Umlaut.

  irregV : (x1,_,_,_,x5 : Str) -> V ; -- sehen, sieht, sah, sähe, gesehen

-- To remove the past participle prefix "ge", e.g. for the verbs
-- prefixed by "be-, ver-".

  no_geV : V -> V ;

-- To add a movable suffix e.g. "auf(fassen)".

  prefixV : Str -> V -> V ;

-- To change the auxiliary from "haben" (default) to "sein" and
-- vice-versa.

  seinV  : V -> V ;
  habenV : V -> V ;

-- Reflexive verbs can take reflexive pronouns of different cases.

  reflV  : V -> Case -> V ;


--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object
-- (accusative, transitive verbs). There is also a case for dative objects.

  mkV2  : V -> Prep -> V2 ;

  dirV2 : V -> V2 ;
  datV2 : V -> V2 ;

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Prep -> Prep -> V3 ;  -- speak, with, about
  dirV3    : V -> Prep -> V3 ;                -- give,_,to
  accdatV3 : V -> V3 ;                               -- give,_,_

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

-- Notice: categories $V2S, V2V, V2A, V2Q$ are in v 1.0 treated
-- just as synonyms of $V2$, and the second argument is given
-- as an adverb. Likewise $AS, A2S, AV, A2V$ are just $A$.
-- $V0$ is just $V$.

  V0, V2S, V2V, V2A, V2Q : Type ;
  AS, A2S, AV, A2V : Type ;


--2 Definitions of paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.

--.

  Gender = MorphoGer.Gender ;
  Case = MorphoGer.Case ;
  Number = MorphoGer.Number ;
  masculine = Masc ;
  feminine  = Fem ;
  neuter = Neutr ;
  nominative = Nom ;
  accusative = Acc ;
  dative = Dat ;
  genitive = Gen ;
  singular = Sg ;
  plural = Pl ;

  mkN a b c d e f g = MorphoGer.mkN a b c d e f g ** {lock_N = <>} ;

  regN : Str -> N = \hund -> case hund of {
    _ + "e" => mkN hund hund hund hund (hund + "n") (hund + "n") Fem ;
    _ + ("ion" | "ung") => mkN hund hund hund hund (hund + "en") (hund + "en") Fem ;
    _                   => mkN hund hund hund (genitS hund) (hund + "e") (hund + "en") Masc
    } ;

  reg2N : (x1,x2 : Str) -> Gender -> N = \hund,hunde,g -> 
    let
      hunds = genitS hund ;
      hundE = dativE hund ;
      hunden = pluralN hunde
    in
    case <hund,hunde,g> of {                                        -- Duden p. 223
      <_,_ + ("e" | "er"), Masc | Neutr> =>                         -- I,IV 
        mkN hund hund hundE hunds hunde hunden g ;
      <_ + ("el"|"er"|"en"),_ + ("el"|"er"|"en"), Masc | Neutr> =>  -- II
        mkN hund hund hund hunds hunde hunden g ;
      <_,_ + "s", Masc | Neutr> =>                                  -- V 
        mkN hund hund hund (hund + "s") hunde hunde g ;
      <_,_ + "en", Masc> =>                                         -- VI 
        mkN hund hunde hunde hunde hunde hunde g ;
      <_,_ + ("e" | "er"), Fem> =>                                  -- VII,VIII 
        mkN hund hund hund hund hunde hunden g ;
      <_,_ + ("n" | "s"), Fem> =>                                   -- IX,X 
        mkN hund hund hund hund hunde hunde g ;
      _ => regN hund
    } ;
   
  mkN2  : N -> Prep -> N2 = \n,p -> n ** {c2 = p ; lock_N2 = <>} ;
  vonN2 : N -> N2 = \n -> n ** {c2 = {s = "von" ; c = dative} ; lock_N2 = <>} ;

  mkN3 = \n,p,q -> n ** {c2 = p ; c3 = q ; lock_N3 = <>} ;

  mkPN = \karolus, karoli -> 
    {s = table {Gen => karoli ; _ => karolus} ; lock_PN = <>} ;
  regPN = \horst -> 
    mkPN horst (ifTok Tok (Predef.dp 1 horst) "s" horst (horst + "s")) ;

  mkA : (x1,_,_,x4 : Str) -> A = \a,b,c,d -> 
    MorphoGer.mkA a b c d ** {lock_A = <>} ;

  regA : Str -> A = \a -> case a of {
    teu + "er" => mkA a (teu + "re") (teu + "rer") (teu + "rest") ;
    _ + "e"    => mkA a a (a + "r") (a + "st") ;
    _          => mkA a a (a + "er") (a + "est")
    } ;

  invarA = \s -> {s = \\_,_ => s ; lock_A = <>} ; ---- comparison

  mkA2 = \a,p -> a ** {c2 = p ; lock_A2 = <>} ;

  mkPrep s c = {s = s ; c = c ; lock_Prep = <>} ;
  accPrep = mkPrep [] accusative ;
  datPrep = mkPrep [] dative ;
  genPrep = mkPrep [] genitive ;
  von_Prep = mkPrep "von" dative ;
  zu_Prep = mkPrep "zu" dative ;

  mkV geben gibt gib gab gaebe gegeben = 
    let
      geb   = stemVerb geben ;
      gebe  = geb + "e" ;
      gibst = verbST (init gibt) ;
      gebt  = verbT geb ;
      gabst = verbST gab ;
      gaben = pluralN gab ;
      gabt  = verbT gab
    in 
    MorphoGer.mkV 
      geben gebe gibst gibt gebt gib gab gabst gaben gabt gaebe gegeben
      [] VHaben ** {lock_V = <>} ;

  regV fragen = 
    let
      frag    = stemVerb fragen ;
      fragt   = verbT frag ;
      fragte  = fragt + "e" ;
      gefragt = "ge" + fragt ;
    in
    mkV fragen fragt (frag + "e") fragte fragte gefragt ;

  irregV singen singt sang saenge gesungen = 
    let
      sing = stemVerb singen ;
    in
    mkV singen singt sing sang saenge gesungen ;

  prefixV p v = 
    {s = v.s ; prefix = p ; lock_V = v.lock_V ; aux = v.aux ; vtype = v.vtype} ;
  habenV v = 
    {s = v.s ; prefix = v.prefix ; lock_V = v.lock_V ; aux = VHaben ; vtype = v.vtype} ;
  seinV v = 
    {s = v.s ; prefix = v.prefix ; lock_V = v.lock_V ; aux = VSein ; vtype = v.vtype} ;
  reflV v c = 
    {s = v.s ; prefix = v.prefix ; lock_V = v.lock_V ; aux = VHaben ; vtype = VRefl c} ;

  no_geV v = let vs = v.s in {
    s = table {
      p@(VPastPart _) => Predef.drop 2 (vs ! p) ;
      p => vs ! p
      } ;
    prefix = v.prefix ; lock_V = v.lock_V ; aux = v.aux ; vtype = v.vtype
    } ;

  mkV2 v c   = v ** {c2 = c ; lock_V2 = <>} ;
  dirV2 v = mkV2 v (mkPrep [] accusative) ;
  datV2 v = mkV2 v (mkPrep [] dative) ;

  mkV3 v c d = v ** {c2 = c ; c3 = d ; lock_V3 = <>} ;
  dirV3 v p = mkV3 v (mkPrep [] accusative) p ;
  accdatV3 v = dirV3 v (mkPrep [] dative) ; 

  mkVS v = v ** {lock_VS = <>} ;
  mkVQ v = v ** {lock_VQ = <>} ;
  mkVV v = v ** {isAux = False ; lock_VV = <>} ;

  V0 : Type = V ;
  V2S, V2V, V2Q, V2A : Type = V2 ;
  AS, A2S, AV : Type = A ;
  A2V : Type = A2 ;

  mkV0  v = v ** {lock_V = <>} ;
  mkV2S v p = mkV2 v p ** {lock_V2 = <>} ;
  mkV2V v p t = mkV2 v p ** {s4 = t ; lock_V2 = <>} ;
  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p = mkV2 v p ** {lock_V2A = <>} ;
  mkV2Q v p = mkV2 v p ** {lock_V2 = <>} ;

  mkAS  v = v ** {lock_A = <>} ;
  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
  mkAV  v = v ** {lock_A = <>} ;
  mkA2V v p = mkA2 v p ** {lock_A2 = <>} ;

} ;
