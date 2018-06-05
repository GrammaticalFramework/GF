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
  ResDut,
  CatDut
  in 
{
--2 Parameters 

-- To abstract over gender names, we define the following identifiers.

oper
  masculine : Gender ; --%
  feminine  : Gender ; --%
  neuter    : Gender ; --%
  utrum     : Gender ; --%

  de  : Gender ; -- non-neutrum
  het : Gender ; -- neutrum

  nominative : Case ; -- nominative of nouns
  genitive : Case ;   -- genitive of nouns
  
--2 Nouns

  mkN : overload {
    mkN : (bank : Str) -> N ;   -- de bank-banken, with some predictable exceptions
    mkN : (bit : Str) -> Gender -> N ; -- if gender is not predictable
    mkN : (gat, gaten : Str) -> Gender -> N ; -- worst-case for nouns
    mkN : (werk, plaats : N) -> N ; -- compound werkplaats
    mkN : (station, hal : N) -> Case -> N ; -- compound stationshal
  } ;

-- Relational nouns need a preposition. The most common is "van".

  mkN2 : overload {
    mkN2 : N -> N2 ;        -- relational noun with preposition van
    mkN2 : N -> Prep -> N2  -- other preposition than van
    } ;   


---- Use the function $mkPrep$ or see the section on prepositions below to  
---- form other prepositions.
---- Some prepositions are moreover constructed in [StructuralDut StructuralDut.html].
----
---- Three-place relational nouns ("die Verbindung von x nach y") need two prepositions.
--
  mkN3 : N -> Prep -> Prep -> N3 ; -- e.g. afstand + van + naar

--3 Proper names and noun phrases

  mkPN : overload {
    mkPN : Str -> PN ; -- proper name
    mkPN : N -> PN ; -- proper name from noun
    } ;


--2 Adjectives

  mkA : overload {
    mkA : (vers : Str) -> A ; -- regular adjective
    mkA : (tweed,tweede : Str) -> A ; -- with deviant second form
    mkA : (goed,goede,goeds,beter,best : Str) -> A ; -- irregular adjective
    } ;


-- Invariable adjective are a special case. 

  invarA : Str -> A ;            -- adjective with just one form


---- Two-place adjectives are formed by adding a preposition to an adjective.

  mkA2 : A -> Prep -> A2 ;  -- e.g. getrouwd + met

--2 Adverbs

-- Adverbs are formed from strings.

  mkAdv : Str -> Adv ;



--2 Prepositions

-- A preposition is formed from a string.

  mkPrep : Str -> Prep ;

  
---- A couple of common prepositions (always with the dative).
--
  van_Prep : Prep ;
  te_Prep  : Prep ;

--
--2 Verbs

  mkV : overload {
    mkV : (aaien : Str) -> V ;  -- regular verb
    mkV : (aaien,aait : Str) -> V ;  -- regular verb with third person sg pres (giving stem)
    mkV : (breken,brak,gebroken : Str) -> V ; -- theme of irregular verb
    mkV : (breken,brak,braken,gebroken : Str) -> V ; -- also past plural irregular
    mkV : (aai,aait,aaien,aaide,aaide,aaiden,geaaid : Str) -> V ; -- almost worst-case verb, Sg2=Sg3
    mkV : (aai,aait,aait,aaien,aaide,aaide,aaiden,geaaid : Str) -> V ; -- worst-case verb

-- To add a movable suffix e.g. "auf(fassen)".

    mkV : Str -> V -> V -- add movable suffix, e.g. af + stappen
    } ;

-- To remove the past participle prefix "ge", e.g. for the verbs
-- prefixed by "be-, ver-".

  no_geV : V -> V ;  -- no participle "ge", e.g. "vertrekken"

-- To add a fixed prefix such as "be-, ver-"; this implies $no_geV$.

  fixprefixV : Str -> V -> V ; -- add prefix such as "be"; implies no_ge

  zijnV  : V -> V ; -- force zijn as auxiliary (default hebben)

  reflV  : V -> V ; -- reflexive verb e.g. zich afvragen


--
--
--3 Three-place verbs

-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3 : overload {
    mkV3 : V -> V3 ;                  -- geven,(accusative),(dative)
    mkV3 : V -> Prep -> V3 ;          -- sturen,(accusative),naar
    mkV3 : V -> Prep -> Prep -> V3 ;  -- praten, met, over
    } ;


----3 Other complement patterns
----
---- Verbs and adjectives can take complements such as sentences,
---- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ; --%
  mkVS  : V -> VS ;
  mkVV  : V -> VV ;  -- with "te"
  auxVV : V -> VV ;  -- without "te"

  mkV2V : overload {
    mkV2V : V -> Prep -> V2V ;
    mkV2V : V -> V2V ;
    } ;
  auxV2V : overload { -- without "te"
    auxV2V : V -> V2V ;
    auxV2V : V -> Prep -> V2V ;
    } ;
  mkV2S : overload {
    mkV2S : V -> Prep -> V2S ;
    mkV2S : V -> V2S ;
    } ;
  mkV2A : overload {
    mkV2A : V -> Prep -> V2A ;
    mkV2A : V -> V2A ;
    } ;
  mkV2Q : overload {
    mkV2Q : V -> Prep -> V2Q ;
    mkV2Q : V -> V2Q ;
    } ;

  mkVA  : V -> VA ;
  mkVQ  : V -> VQ ;

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


--.

  mkOrd : A -> Ord = \a -> lin Ord {s = a.s ! Posit} ;

  mkN = overload {
    mkN : (bank : Str) -> N 
    = \a -> lin N (regNoun a) ;
    mkN : (bit : Str) -> Gender -> N 
    = \a,b -> lin N (regNounG a b) ;
    mkN : (bit : Str) -> Gender -> Gender -> N 
    = \a,g1,g2 -> lin N (regNounG a g1) | lin N (regNounG a g2) ; -- there are many nouns with variant genders
    mkN : (gat,gaten : Str) -> Gender -> N 
    = \a,b,c -> lin N (mkNoun a b c) ;
   mkN : (werk,plaats : N) -> N
    = \werk,plaats -> lin N {s = \\n => werk.s ! NF Sg Nom + plaats.s ! n ; g = plaats.g} ;
   mkN : (werk,plaats : N) -> Case -> N
    = \werk,plaats,c -> lin N {s = \\n => werk.s ! NF Sg c + plaats.s ! n ; g = plaats.g} ;
  } ;

  mkN2 = overload {
    mkN2 : N -> N2 
    = \n -> lin N2 (n ** {c2 = van_Prep}) ; 
    mkN2 : N -> Prep -> N2 
    = \n,p -> lin N2 (n ** {c2 = p}) ; 
    } ;   
  mkN3 n p q = lin N3 (n ** {c2 = p ; c3 = q}) ;

  mkPN = overload {
    mkPN : Str -> PN = \s -> lin PN {s = \\_ => s} ;
    mkPN : N -> PN = \n -> lin PN {s = \\_ => n.s ! NF Sg Nom} ;
    } ;

  masculine = Utr ;
  feminine  = Utr ;
  het,neuter = Neutr ;
  de,utrum = Utr ;
  nominative = Nom ;
  genitive = Gen ;

  mkA = overload {
    mkA : (vers : Str) -> A = \a -> lin A (regAdjective a) ;
    mkA : (vers,verse : Str) -> A = \a,b -> lin A (reg2Adjective a b) ;
    mkA : (goed,goede,goeds,beter,best : Str) -> A = \a,b,c,d,e -> lin A (mkAdjective a b c d e) ;
    } ;

  mkPrep s = lin Prep { s, mergeForm = s ; mergesWithPrep = True } ;

  nomergePrep : Str -> Prep = \s -> lin Prep (noMerge ** ss s); 

  van_Prep = mkPrep "van" ;
  te_Prep = mkPrep "te" ;

  mkV = overload {
    mkV : (aaien : Str) -> V = 
      \s -> lin V (v2vv (regVerb s)) ;
    mkV : (aaien, aait : Str) -> V = 
      \s,t -> lin V (v2vv (smartVerb s (init t))) ;
    mkV : (breken,brak,gebroken : Str) -> V = 
      \a,b,c -> lin V (v2vv (irregVerb a b c)) ;
    mkV : (breken,brak,braken,gebroken : Str) -> V = 
      \a,b,c,d -> lin V (v2vv (irregVerb2 a b c d)) ;
    mkV : (aai,aait,aaien,aaide,aaiden,geaaid : Str) -> V =
      \a,b,c,d,f,g -> lin V (v2vv (mkVerb a b c d d f g)) ;
    mkV : (aai,aait,aait,aaien,aaide,aaide,aaiden,geaaid : Str) -> V =
      \a,b2,b3,c,d2,d3,f,g -> lin V (v2vv (mkVerb8 a b2 b3 c d2 d3 f g)) ;
    mkV : Str -> V -> V = \v,s ->lin V (prefixV v s) ;
    mkV : V -> Str -> V = \s,v ->lin V (prefixV v s) ; ---- the same, in order matching Wiktionary-generated lexicon
    } ;
  zijnV v = lin V (v2vvAux v VZijn) ;
  reflV v = lin V {s = v.s ; aux = v.aux ; particle = v.particle ; prefix = v.prefix ; vtype = VRefl} ;

  partV = overload {
    partV : Str -> V -> V = \leuk,vinden ->
      vinden ** {particle = leuk} ;
    partV : V -> Str -> V = \vinden,leuk ->
      vinden ** {particle = leuk} ;
  } ;

  no_geV v = let vs = v.s in {
    s = table {
      VPerf x => Predef.drop 2 (vs ! VPerf x) ;
      p => vs ! p
      } ;
    prefix = v.prefix ; lock_V = v.lock_V ; particle = v.particle ; aux = v.aux ; vtype = v.vtype
    } ;

  fixprefixV s v = let vs = v.s in {
    s = table {
      VPerf x => s + Predef.drop 2 (vs ! VPerf x) ;
      p => s + vs ! p
      } ;
    prefix = v.prefix ; lock_V = v.lock_V ; aux = v.aux ; particle = v.particle ; vtype = v.vtype
    } ;

  zijn_V : V = lin V ResDut.zijn_V ;
  hebben_V : V = lin V ResDut.hebben_V ;

  mkV2 = overload {
    mkV2 : Str -> V2 = \s -> lin V2 (v2vv (regVerb s) ** {c2 = <noPrep,False>}) ;
    mkV2 : V -> V2 = \s -> lin V2 (s ** {c2 = <noPrep,False>}) ;
    mkV2 : V -> Prep -> V2  = \s,p -> lin V2 (s ** {c2 = <p,True>}) ;
    } ;


--3 Two-place verbs

  mkV2 : overload {
    mkV2 : Str -> V2 ;
    mkV2 : V -> V2 ;
    mkV2 : V -> Prep -> V2 ;
    } ;
  mkV3 = overload {
    mkV3 : V -> Prep -> Prep -> V3 = mkmaxV3 ;
    mkV3 : V -> Prep -> V3 = \v,p -> mkmaxV3 v noPrep p ;
    mkV3 : V -> V3 = \v -> mkmaxV3 v noPrep noPrep ;
    } ;
  mkmaxV3 : V -> Prep -> Prep -> V3 = \v,c,d -> lin V3 (v ** {c2 = <c,True> ; c3 = <d,True>}) ;

  invarA = \s -> lin A {s = \\_,_ => s} ; ---- comparison

  mkA2 = \a,p -> lin A2 (a ** {c2 = p}) ;

  mkAdv s = {s = s ; lock_Adv = <>} ;

  noPrep = nomergePrep [] ;

  prepV2 : V -> Prep -> V2 ;
  prepV2 v c = lin V2 (v ** {c2 = <c,True>}) ; --if it has prep, needed for word order (place of negation)

  noprepV2 : V -> V2 ;
  noprepV2 v = lin V2 (v ** {c2 = <noPrep,False>}) ; 
--  dirV2 v = prepV2 v (mkPrep [] accusative) ;
--  datV2 v = prepV2 v (mkPrep [] dative) ;
--
--
  mkVS v = lin VS v ;
  mkVQ v = lin VQ v ;
  mkVV v = lin VV (v ** {isAux = False}) ;
  auxVV v = lin VV (v ** {isAux = True}) ;

  V0 : Type = V ;
--  AS, A2S, AV : Type = A ;
--  A2V : Type = A2 ;

  mkV0 v = v ;

  mkV2V = overload {
    mkV2V : V -> Prep -> V2V = \v,p -> lin V2V (prepV2 v p ** {isAux = False}) ;
    mkV2V : V -> V2V = \v -> lin V2V (noprepV2 v ** {isAux = False}) ;
    } ;
  auxV2V = overload {
    auxV2V : V -> Prep -> V2V = \v,p -> lin V2V (prepV2 v p ** {isAux = True}) ;
    auxV2V : V -> V2V = \v -> lin V2V (noprepV2 v ** {isAux = True}) ;
    } ;
  mkV2S = overload {
    mkV2S : V -> Prep -> V2S = \v,p -> lin V2S (prepV2 v p) ;
    mkV2S : V -> V2S = \v -> lin V2S (noprepV2 v) ;
    } ;
  mkV2A = overload {
    mkV2A : V -> Prep -> V2A = \v,p -> lin V2A (prepV2 v p) ;
    mkV2A : V -> V2A = \v -> lin V2A (noprepV2 v) ; 
    } ;
  mkV2Q = overload {
    mkV2Q : V -> Prep -> V2Q = \v,p -> lin V2Q (prepV2 v p) ;
    mkV2Q : V -> V2Q = \v -> lin V2Q (noprepV2 v) ;
    } ;


  mkVA  v   = lin VA v ;
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
