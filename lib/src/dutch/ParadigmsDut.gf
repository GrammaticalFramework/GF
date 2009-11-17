--# -path=.:../common:../abstract:../../prelude

--1 Dutch Lexical Paradigms
--
-- Aarne Ranta 2009
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- cases, from the most regular (with just one argument) to the worst. 
-- The name of this function is $mkC$.
-- 
-- There is also a module [``IrregDut`` IrregDut.gf] 
-- which covers irregular verbs.


resource ParadigmsDut = open 
  (Predef=Predef), 
  Prelude, 
  MorphoDut,
  CatDut
  in 
{
--2 Parameters 

-- To abstract over gender names, we define the following identifiers.

oper
  masculine : Gender ;
  feminine  : Gender ;
  neuter    : Gender ;
  utrum     : Gender ;

  de,het : Gender ;

  masculine = Utr ;
  feminine  = Utr ;
  het,neuter = Neutr ;
  de,utrum = Utr ;

  
--2 Nouns

  mkN : overload {
    mkN : (muis : Str) -> N ;
    mkN : (bit : Str) -> Gender -> N ;
    mkN : (gat,gaten : Str) -> Gender -> N ;
  } ;
  mkN = overload {
    mkN : (muis : Str) -> N = \a -> lin N (regNoun a) ;
    mkN : (bit : Str) -> Gender -> N = \a,b -> lin N (regNounG a b) ;
    mkN : (gat,gaten : Str) -> Gender -> N = \a,b,c -> lin N (mkNoun a b c) ;
  } ;

-- Relational nouns need a preposition. The most common is "van".

  mkN2 : overload {
    mkN2 : N -> N2 ; 
    mkN2 : N -> Prep -> N2
    } ;   

  mkN2 = overload {
    mkN2 : N -> N2 = \n -> lin N2 (n ** {c2 = "van"}) ; 
    mkN2 : N -> Prep -> N2 = \n,p -> lin N2 (n ** {c2 = p.s}) ; 
    } ;   

---- Use the function $mkPrep$ or see the section on prepositions below to  
---- form other prepositions.
---- Some prepositions are moreover constructed in [StructuralDut StructuralDut.html].
----
---- Three-place relational nouns ("die Verbindung von x nach y") need two prepositions.
--
  mkN3 : N -> Prep -> Prep -> N3 ;
  mkN3 n p q = lin N3 (n ** {c2 = p.s ; c3 = q.s}) ; 

--3 Proper names and noun phrases

  mkPN : overload {
    mkPN : Str -> PN ;
    } ;

  mkPN = overload {
    mkPN : Str -> PN = \s -> lin PN {s = \\_ => s} ;
    } ;


--2 Adjectives

  mkA : overload {
    mkA : (vers : Str) -> A ;
    mkA : (goed,goede,goeds,beter,best : Str) -> A ;
    } ;

  mkA = overload {
    mkA : (vers : Str) -> A = \a -> lin A (regAdjective a) ;
    mkA : (goed,goede,goeds,beter,best : Str) -> A = \a,b,c,d,e -> lin A (mkAdjective a b c d e) ;
    } ;

---- Invariable adjective are a special case. 
--
--  invarA : Str -> A ;            -- prima
--
---- Two-place adjectives are formed by adding a preposition to an adjective.

  mkA2 : A -> Prep -> A2 ;

--2 Adverbs

-- Adverbs are formed from strings.

  mkAdv : Str -> Adv ;



--2 Prepositions

-- A preposition is formed from a string.

  mkPrep : Str -> Prep ;
  mkPrep s = lin Prep (ss s) ;
  
---- A couple of common prepositions (always with the dative).
--
  van_Prep : Prep ;
  van_Prep = mkPrep "van" ;
  te_Prep  : Prep ;
  te_Prep = mkPrep "te" ;
--
--2 Verbs

  mkV : overload {
    mkV : (aaien : Str) -> V ;
    mkV : (breken,brak,gebroken : Str) -> V ;
    mkV : (breken,brak,braken,gebroken : Str) -> V ;
    mkV : (aai,aait,aaien,aaide,aaide,aaiden,geaaid : Str) -> V ;

-- To add a movable suffix e.g. "auf(fassen)".

    mkV : Str -> V -> V
    } ;

  mkV = overload {
    mkV : (aaien : Str) -> V = 
      \s -> lin V (v2vv (regVerb s)) ;
    mkV : (breken,brak,gebroken : Str) -> V = 
      \a,b,c -> lin V (v2vv (irregVerb a b c)) ;
    mkV : (breken,brak,braken,gebroken : Str) -> V = 
      \a,b,c,d -> lin V (v2vv (irregVerb2 a b c d)) ;
    mkV : (aai,aait,aaien,aaide,aaiden,geaaid : Str) -> V =
      \a,b,c,d,f,g -> lin V (v2vv (mkVerb a b c d d f g)) ;
    mkV : Str -> V -> V = \v,s ->lin V (prefixV v s) ;
    } ;

  zijnV  : V -> V ;
  zijnV v = lin V (v2vvAux v VZijn) ;

  reflV  : V -> V ;
  reflV v = lin V {s = v.s ; aux = v.aux ; prefix = v.prefix ; vtype = VRefl} ;

--3 Two-place verbs

  mkV2 : overload {
    mkV2 : Str -> V2 ;
    mkV2 : V -> V2 ;
    mkV2 : V -> Prep -> V2 ;
    } ;

  mkV2 = overload {
    mkV2 : Str -> V2 = \s -> lin V2 (v2vv (regVerb s) ** {c2 = []}) ;
    mkV2 : V -> V2 = \s -> lin V2 (s ** {c2 = []}) ;
    mkV2 : V -> Prep -> V2  = \s,p -> lin V2 (s ** {c2 = p.s}) ;
    } ;


--
--
--3 Three-place verbs

-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3 : overload {
    mkV3 : V -> V3 ;                  -- give,accusative,dative
    mkV3 : V -> Prep -> V3 ;          -- senden,(accusative),nach
    mkV3 : V -> Prep -> Prep -> V3 ;  -- sprechen, mit, über
    } ;

  mkV3 = overload {
    mkV3 : V -> Prep -> Prep -> V3 = mkmaxV3 ;
    mkV3 : V -> Prep -> V3 = \v,p -> mkmaxV3 v (mkPrep []) p ; 
    mkV3 : V -> V3 = \v -> mkmaxV3 v (mkPrep []) (mkPrep []) ; 
    } ;
  mkmaxV3 : V -> Prep -> Prep -> V3 = \v,c,d -> lin V3 (v ** {c2 = c.s ; c3 = d.s}) ;

----3 Other complement patterns
----
---- Verbs and adjectives can take complements such as sentences,
---- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ;
  mkVS  : V -> VS ;
  mkV2S : V -> Prep -> V2S ;
  mkVV  : V -> VV ;
  mkV2V : V -> Prep -> V2V ;
  mkVA  : V -> VA ;
  mkV2A : V -> Prep -> V2A ;
  mkVQ  : V -> VQ ;
  mkV2Q : V -> Prep -> V2Q ;
--
--  mkAS  : A -> AS ;
--  mkA2S : A -> Prep -> A2S ;
--  mkAV  : A -> AV ;
--  mkA2V : A -> Prep -> A2V ;
--
---- Notice: categories $AS, A2S, AV, A2V$ are just $A$, 
---- and the second argument is given as an adverb. Likewise 
---- $V0$ is just $V$.
--
--  V0 : Type ;
--  AS, A2S, AV, A2V : Type ;
--
--
----.
----2 Definitions of paradigms
----
---- The definitions should not bother the user of the API. So they are
---- hidden from the document.
--
--
--
--  Gender = MorphoDut.Gender ;
--  Case = MorphoDut.Case ;
--  Number = MorphoDut.Number ;
--  masculine = Masc ;
--  feminine  = Fem ;
--  neuter = Neutr ;
--  nominative = Nom ;
--  accusative = Acc ;
--  dative = Dat ;
--  genitive = Gen ;
--  singular = Sg ;
--  plural = Pl ;
--
--  mk6N a b c d e f g = MorphoDut.mkN a b c d e f g ** {lock_N = <>} ;
--
--  regN : Str -> N = \hund -> case hund of {
--    _ + "e" => mk6N hund hund hund hund (hund + "n") (hund + "n") Fem ;
--    _ + ("ion" | "ung") => mk6N hund hund hund hund (hund + "en") (hund + "en") Fem ;
--    _ + ("er" | "en" | "el") => mk6N hund hund hund (genitS hund) hund (pluralN hund) Masc ; 
--    _  => mk6N hund hund hund (genitS hund) (hund + "e") (pluralN hund) Masc
--    } ;
--
--  reg2N : (x1,x2 : Str) -> Gender -> N = \hund,hunde,g -> 
--    let
--      hunds = genitS hund ;
--      hundE = dativE hund ;
--      hunden = pluralN hunde
--    in
--    case <hund,hunde,g> of {                                        -- Duden p. 223
--      <_,_ + ("e" | "er"), Masc | Neutr> =>                         -- I,IV 
--        mk6N hund hund hundE hunds hunde hunden g ;
--      <_ + ("el"|"er"|"en"),_ + ("el"|"er"|"en"), Masc | Neutr> =>  -- II
--        mk6N hund hund hund hunds hunde hunden g ;
--      <_,_ + "s", Masc | Neutr> =>                                  -- V 
--        mk6N hund hund hund (hund + "s") hunde hunde g ;
--      <_,_ + "en", Masc> =>                                         -- VI 
--        mk6N hund hunde hunde hunde hunde hunde g ;
--      <_,_ + ("e" | "er"), Fem> =>                                  -- VII,VIII 
--        mk6N hund hund hund hund hunde hunden g ;
--      <_,_ + ("n" | "s"), Fem> =>                                   -- IX,X 
--        mk6N hund hund hund hund hunde hunde g ;
--      _ => {s = (regN hund).s ; g = g ; lock_N = <>}
--    } ;
--   
--  mkN2 = overload {
--    mkN2 : Str -> N2 = \s -> vonN2 (regN s) ;
--    mkN2 : N ->   N2 = vonN2 ;
--    mkN2 : N -> Prep -> N2 = mmkN2
--    } ;   
--
--
--  mmkN2  : N -> Prep -> N2 = \n,p -> n ** {c2 = p ; lock_N2 = <>} ;
--  vonN2 : N -> N2 = \n -> n ** {c2 = {s = "von" ; c = dative} ; lock_N2 = <>} ;
--
--  mkN3 = \n,p,q -> n ** {c2 = p ; c3 = q ; lock_N3 = <>} ;
--
--  mk2PN = \karolus, karoli -> 
--    {s = table {Gen => karoli ; _ => karolus} ; lock_PN = <>} ;
--  regPN = \horst -> 
--    mk2PN horst (ifTok Tok (Predef.dp 1 horst) "s" horst (horst + "s")) ;
--
--  mkPN = overload {
--    mkPN : Str -> PN = regPN ;
--    mkPN : (nom,gen : Str) -> PN = mk2PN ;
--    mkPN : (nom,acc,dat,gen : Str) -> PN = \nom,acc,dat,gen ->
--      {s = table {Nom => nom ; Acc => acc ; Dat => dat ; Gen => gen} ; lock_PN = <>} 
--    } ;
--
--  mk2PN  : (karolus, karoli : Str) -> PN ; -- karolus, karoli
--  regPN : (Johann : Str) -> PN ;  
--    -- Johann, Johanns ; Johannes, Johannes
--
--
--  mk3A : (gut,besser,beste : Str) -> A = \a,b,c ->
--    let aa : Str = case a of {
--      teu + "er" => teu + "r" ;
--      mud + "e" => mud ;
--      _ => a
--    } in 
--    MorphoDut.mkA a aa b (init c) ** {lock_A = <>} ;
--  mk4A : (gut,gute,besser,beste : Str) -> A = \a,aa,b,c ->
--    MorphoDut.mkA a aa b (init c) ** {lock_A = <>} ;
--
--  regA : Str -> A = \a -> case a of {
--    teu + "er" => mk3A a (teu + "rer") (teu + "reste") ;
--    _ + "e"    => mk3A a (a + "r") (a + "ste") ;
--    _          => mk3A a (a + "er") (a + "este")
--    } ;
--
--  invarA = \s -> {s = \\_,_ => s ; lock_A = <>} ; ---- comparison
--
  mkA2 = \a,p -> lin A2 (a ** {c2 = p.s}) ;

  mkAdv s = {s = s ; lock_Adv = <>} ;
--
--  mkPrep s c = {s = s ; c = c ; lock_Prep = <>} ;
  noPrep = mkPrep [] ;
--  datPrep = mkPrep [] dative ;
--  genPrep = mkPrep [] genitive ;
--  von_Prep = mkPrep "von" dative ;
--  zu_Prep = mkPrep "zu" dative ;
--
--  mk6V geben gibt gib gab gaebe gegeben = 
--    let
--      geb   = stemVerb geben ;
--      gebe  = geb + "e" ;
--      gibst = verbST (init gibt) ;
--      gebt  = verbT geb ;
--      gabst = verbST gab ;
--      gaben = pluralN gab ;
--      gabt  = verbT gab
--    in 
--    MorphoDut.mkV 
--      geben gebe gibst gibt gebt gib gab gabst gaben gabt gaebe gegeben
--      [] VHaben ** {lock_V = <>} ;
--
--  regV fragen = 
--    let
--      frag    = stemVerb fragen ;
--      fragt   = verbT frag ;
--      fragte  = fragt + "e" ;
--      gefragt = "ge" + fragt ;
--    in
--    mk6V fragen fragt (frag + "e") fragte fragte gefragt ;
--
--  irregV singen singt sang saenge gesungen = 
--    let
--      sing = stemVerb singen ;
--    in
--    mk6V singen singt sing sang saenge gesungen ;
--
--  prefixV p v = MorphoDut.prefixV p v ** {lock_V = v.lock_V} ;
--
--  habenV v = 
--    {s = v.s ; prefix = v.prefix ; lock_V = v.lock_V ; aux = VHaben ; vtype = v.vtype} ;
--  seinV v = 
--    {s = v.s ; prefix = v.prefix ; lock_V = v.lock_V ; aux = VSein ; vtype = v.vtype} ;
--  reflV v c = 
--    {s = v.s ; prefix = v.prefix ; lock_V = v.lock_V ; aux = VHaben ; vtype = VRefl c} ;
--
--  no_geV v = let vs = v.s in {
--    s = table {
--      p@(VPastPart _) => Predef.drop 2 (vs ! p) ;
--      p => vs ! p
--      } ;
--    prefix = v.prefix ; lock_V = v.lock_V ; aux = v.aux ; vtype = v.vtype
--    } ;
--
--  haben_V = MorphoDut.haben_V ** {lock_V = <>} ;
--  sein_V = MorphoDut.sein_V ** {lock_V = <>} ;
--  werden_V = MorphoDut.werden_V ** {lock_V = <>} ;
--
  prepV2  : V -> Prep -> V2 ;
  prepV2 v c = lin V2 (v ** {c2 = c.s}) ;
--  dirV2 v = prepV2 v (mkPrep [] accusative) ;
--  datV2 v = prepV2 v (mkPrep [] dative) ;
--
--
  mkVS v = lin VS v ;
  mkVQ v = lin VQ v ;
  mkVV v = lin VV (v ** {isAux = False}) ;

  V0 : Type = V ;
--  AS, A2S, AV : Type = A ;
--  A2V : Type = A2 ;

  mkV0 v = v ;
  mkV2S v p = lin V2S (prepV2 v p) ;
  mkV2V v p = lin V2V (prepV2 v p ** {isAux = False}) ;
  mkVA  v   = lin VA v ;
  mkV2A v p = lin V2A (prepV2 v p) ;
  mkV2Q v p = lin V2Q (prepV2 v p) ;
--
--  mkAS  v = v ** {lock_A = <>} ;
--  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
--  mkAV  v = v ** {lock_A = <>} ;
--  mkA2V v p = mkA2 v p ** {lock_A2 = <>} ;
--
---- pre-overload API and overload definitions
--
--  regN : Str -> N ;
--  reg2N : (x1,x2 : Str) -> Gender -> N ;
--  mk6N : (x1,_,_,_,_,x6 : Str) -> Gender -> N ; 
--
--  mkN = overload {
--    mkN : Str -> N = regN ;
--    mkN : (x1,x2 : Str) -> Gender -> N = reg2N ;
--    mkN : (x1,_,_,_,_,x6 : Str) -> Gender -> N = mk6N
--    };
--
--
--
--  regA : Str -> A ;
--  mk3A : (gut,besser,beste : Str) -> A ;
--
--  mkA = overload {
--    mkA : Str -> A = regA ;
--    mkA : (gut,besser,beste : Str) -> A = mk3A ;
--    mkA : (gut,gute,besser,beste : Str) -> A = mk4A
--    };
--
--
--
--  regV : Str -> V ;
--  irregV : (x1,_,_,_,x5 : Str) -> V ;
--  mk6V : (x1,_,_,_,_,x6 : Str) -> V ;
--
--  prefixV : Str -> V -> V ;
--
--  mkV = overload {
--    mkV : Str -> V = regV ;
--    mkV : (x1,_,_,_,x5 : Str) -> V = irregV ;
--    mkV : (x1,_,_,_,_,x6 : Str) -> V = mk6V ;
--    mkV : Str -> V -> V = prefixV
--    };
--


--  dirV2 : V -> V2 ;
--
--  datV2 : V -> V2 ;
--
--  mkV2 = overload {
--    mkV2 : Str -> V2 = \s -> dirV2 (regV s) ;
--    mkV2 : V -> V2 = dirV2 ;
--    mkV2 : V -> Prep -> V2 = prepV2;
--    mkV2 : V -> Case -> V2 = \v,c -> prepV2 v (mkPrep [] c)
--    } ;
--
--}

}
