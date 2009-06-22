--# -path=.:../scandinavian:../common:../abstract:../../prelude

--1 Danish Lexical Paradigms
--
-- Aarne Ranta 2005 - 2006
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoDan.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
-- However, this function should only seldom be needed: we have a
-- separate module [``IrregDan`` ../../danish/IrregDan.gf], 
-- which haves a list of irregular verbs.

resource ParadigmsDan = 
  open 
    (Predef=Predef), 
    Prelude, 
    CommonScand, 
    ResDan, 
    MorphoDan, 
    CatDan in {

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender : Type ; 

  utrum   : Gender ;
  neutrum : Gender ;

-- To abstract over number names, we define the following.

  Number : Type ; 

  singular : Number ;
  plural   : Number ;

-- To abstract over case names, we define the following.

  Case : Type ;

  nominative : Case ;
  genitive   : Case ;

-- Prepositions used in many-argument functions are just strings.

  mkPrep : Str -> Prep ;
  noPrep : Prep ;         -- empty string

--2 Nouns

  mkN : overload {

-- The regular function takes the singular indefinite form
-- and computes the other forms and the gender by a heuristic.
-- The heuristic is that all nouns are $utrum$ with the
-- plural ending "er" or "r".

    mkN : (bil : Str) -> N ;

-- Giving gender manually makes the heuristic more reliable.

    mkN : (hus : Str) -> Gender -> N ;

-- This function takes the singular indefinite and definite forms; the
-- gender is computed from the definite form.

    mkN : (bil,bilen : Str) -> N ;

-- This function takes the singular indefinite and definite and the plural
-- indefinite

    mkN : (bil,bilen,biler : Str) -> N ;

-- Worst case: give all four forms. The gender is computed from the
-- last letter of the second form (if "n", then $utrum$, otherwise $neutrum$).

    mkN : (dreng,drengen,drenge,drengene : Str) -> N ;
  } ;




--3 Compound nouns 
--
-- All the functions above work quite as well to form compound nouns,
-- such as "fodbold". 


--3 Relational nouns 
-- 
-- Relational nouns ("datter til x") need a preposition. 

  mkN2 : N -> Prep -> N2 ;

-- The most common preposition is "af", and the following is a
-- shortcut for regular relational nouns with "af".

  regN2 : Str -> Gender -> N2 ;

-- Use the function $mkPrep$ or see the section on prepositions below to  
-- form other prepositions.
--
-- Three-place relational nouns ("forbindelse fra x til y") 
-- need two prepositions.

  mkN3 : N -> Prep -> Prep -> N3 ;


--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "tidligere kone til"). However, $N2$ and
-- $N3$ are purely lexical categories. But you can use the $AdvCN$
-- and $PrepNP$ constructions to build phrases like this.

-- 
--3 Proper names and noun phrases
--
-- Proper names, with a regular genitive, are formed as follows

  mkPN : overload {
    mkPN : Str -> PN ;       -- utrum
    mkPN : Str -> Gender -> PN ;  
    mkPN : N -> PN ;
    } ;


--2 Adjectives

-- The regular pattern works for many adjectives, e.g. those ending
-- with "ig". Two, five, or at worst five forms are sometimes needed.

  mkA : overload {
    mkA : (fin : Str) -> A ;
    mkA : (fin,fint : Str) -> A ;
    mkA : (galen,galet,galne : Str) -> A ;
    mkA : (stor,stort,store,storre,storst : Str) -> A ;

-- If comparison is formed by "mer", "mest", as in general for
-- long adjective, the following pattern is used:

    mkA : A -> A ; -- -/mer/mest norsk
  } ;

--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Prep -> A2 ;



--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be close to the verb like the negation
-- "ikke" (e.g. "altid").

  mkAdv : Str -> Adv ;
  mkAdV : Str -> AdV ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;


--2 Verbs
--

  mkV : overload {

-- The 'regular verb' function is the first conjugation.

    mkV : (snakke : Str) -> V ;

-- The almost regular verb function needs the infinitive and the preteritum.

    mkV : (leve,levde : Str) -> V ;

-- There is an extensive list of irregular verbs in the module $IrregDan$.
-- In practice, it is enough to give three forms, as in school books.

    mkV : (drikke, drakk, drukket  : Str) -> V ;

-- The worst case needs six forms.

    mkV : (spise,spiser,spises,spiste,spist,spis : Str) -> V ;


--3 Verbs with a particle.
--
-- The particle, such as in "lukke op", is given as a string.

    mkV : V -> Str -> V ;
  } ;



--3 Verbs with 'være' as auxiliary
--
-- By default, the auxiliary is "have". This function changes it to "være".

  vaereV : V -> V ;




--3 Deponent verbs
--
-- Some words are used in passive forms only, e.g. "undres", some as
-- reflexive e.g. "forestille sig".

  depV  : V -> V ;
  reflV : V -> V ;


--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). Notice that, if a particle is needed, it comes from the $V$.

  mkV2 : overload {
    mkV2 : Str -> V2 ;
    mkV2 : V -> V2 ;
    mkV2 : V -> Prep -> V2 ;
  } ;


--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Prep -> Prep -> V3 ;  -- snakke, med, om
  dirV3    : V -> Prep -> V3 ;          -- give,_,til
  dirdirV3 : V -> V3 ;                  -- give,_,_

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

-- Notice: categories $AS, A2S, AV, A2V$ are just $A$, 
-- and the second argument is given as an adverb..
-- $V0$ is just $V$.

  V0 : Type ;
  AS, A2S, AV, A2V : Type ;

--.

--2 Definitions of the paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.


  Gender = MorphoDan.Gender ; 
  Number = MorphoDan.Number ;
  Case = MorphoDan.Case ;
  utrum = Utr ; 
  neutrum = Neutr ;
  singular = Sg ;
  plural = Pl ;
  nominative = Nom ;
  genitive = Gen ;

  Preposition : Type = Str ; -- obsolete

  mkPreposition : Str -> Prep ; -- obsolete
  mkPreposition = mkPrep ;

  mkPrep p = {s = p ; lock_Prep = <>} ;
  noPrep = mkPrep [] ;

  mk4N x y z u = mkSubstantive x y z u ** {g = extNGen y ; lock_N = <>} ;

  regN x = regGenN x Utr ;

  regGenN x g = case last x of {
    "e" => case g of {
       Utr        => mk4N x (x      + "n") (x + "r") (x + "rne") ;
       Neutr      => mk4N x (x      + "t") (x + "r") (init x + "ene")
       } ;
    _ => case g of {
       Utr        => mk4N x (x      + "en") (x + "er") (x + "erne") ;
       Neutr      => mk4N x (x      + "et") (x + "")   (x + "ene")
       }
    } ;


   mk2N x y = case last y of {
     "n" => mk3N x y (init y + "r") ;
     _   => mk3N x y x
     } ;

   mk3N x y z = let u = ifTok Str x z "ene" "ne" in mk4N x y z (z + u) ;

  mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = mkComplement  p.s} ;
  regN2 n g = mkN2 (regGenN n g) (mkPreposition "av") ;
  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = mkComplement  p.s ; c3 = mkComplement  q.s} ;

  mk2PN n g = {s = \\c => mkCase c n ; g = g} ** {lock_PN = <>} ;
  regPN n = mk2PN n utrum ;
  nounPN n = {s = n.s ! singular ! Indef ; g = n.g ; lock_PN = <>} ;

-- To form a noun phrase that can also be plural and have an irregular
-- genitive, you can use the worst-case function.

  makeNP : Str -> Str -> Number -> Gender -> NP ; 
  makeNP x y n g = 
    {s = table {NPPoss _ => x ; _ => y} ; a = agrP3 g n ;
     lock_NP = <>} ;

  mk3A = mk3ADeg ;
  mk2A a b = mk3A a b (a + "e") ;
  regA a = (regADeg a) **  {lock_A = <>} ;

  mkA2 a p = a ** {c2 = mkComplement  p.s ; lock_A2 = <>} ;

  mkADeg a b c d e = mkAdject a b c d e ** {isComp = False ; lock_A = <>} ;

  regADeg a = case Predef.dp 2 a of {
    "sk" => aRask a ;
    _ => case last a of {
    "t" => aAbstrakt a ;
    _ => aRod a
    }}  ** {isComp = False ; lock_A = <>} ;

  irregADeg a b c = mkAdject a (a + "t") (a + "e") b c ** 
    {isComp = False ; lock_A = <>} ;
  mk3ADeg a b c = mkAdject a b c (c + "re") (c + "st") ** 
    {isComp = False ; lock_A = <>} ;
  mk2ADeg a b = mkAdject a b (a + "e") (a + "ere") (a + "est") ** 
    {isComp = False ; lock_A = <>} ;

  compoundA adj = {s = adj.s ; isComp = True ; lock_A = <>} ;

  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  mk6V a b c d e f = mkVerb6 a b c d e f ** 
    {part = [] ; vtype = VAct ; lock_V = <> ; isVaere = False} ;

  regV a = case last a of {
    "e" => vHusk (init a) ;
    _ => vBo a
    } ** {part = [] ; vtype = VAct ; isVaere = False ; lock_V = <>} ;

  mk2V a b = regVerb a b ** 
    {part = [] ; vtype = VAct ; isVaere = False ; lock_V = <>} ;

  irregV =
    \drikke,drakk,drukket ->
    let
      drikk = case last drikke of {
        "e" => init drikke ;
        _ => drikke
        } ;
      drikker = case last (init drikke) of {
        "r" => init drikke ;
        _   => drikke + "r"
        }
    in 
    mk6V drikke drikker (drikke + "s") drakk drukket (mkImper drikk) ; 

  vaereV v = {
    s = v.s ;
    part = [] ;
    vtype = v.vtype ; 
    isVaere = True ; 
    lock_V = <>
    } ;

  partV v p = {
    s = v.s ;
    part = p ; 
    vtype = v.vtype ; 
    isVaere = v.isVaere ; 
    lock_V = <>
    } ;

  depV v = {
    s = v.s ; part = v.part ; vtype = VPass ; isVaere = False ; lock_V = <>
    } ;
  reflV v = {
    s = v.s ; part = v.part ; vtype = VRefl ; isVaere = False ; lock_V = <>
    } ;

  mk2V2 v p = v ** {c2 = mkComplement  p.s ; lock_V2 = <>} ;
  dirV2 v = mk2V2 v (mkPrep []) ;

  mkV3 v p q = v ** {c2 = mkComplement  p.s ; c3 = mkComplement  q.s ; lock_V3 = <>} ;
  dirV3 v p = mkV3 v noPrep p ;
  dirdirV3 v = dirV3 v noPrep ;

  mkV0  v = v ** {lock_V0 = <>} ;
  mkVS  v = v ** {lock_VS = <>} ;
  mkV2S v p = mk2V2 v p ** {lock_V2S = <>} ;
  mkVV  v = v ** {c2 = mkComplement "at" ; lock_VV = <>} ;
  mkV2V v p t = mk2V2 v p ** {c3 = mkComplement  "at" ; lock_V2V = <>} ;
  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p = mk2V2 v p ** {lock_V2A = <>} ;
  mkVQ  v = v ** {lock_VQ = <>} ;
  mkV2Q v p = mk2V2 v p ** {lock_V2Q = <>} ;

  mkAS  v = v ** {lock_A = <>} ;
  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
  mkAV  v = v ** {lock_A = <>} ;
  mkA2V v p = mkA2 v p ** {lock_A = <>} ;

  V0 : Type = V ;
  AS, A2S, AV : Type = A ;
  A2V : Type = A2 ;

---------------

  mkN = overload {
    mkN : Str -> N = regN ;
    mkN : Str -> Gender -> N = regGenN ;
    mkN : (bil,bilen : Str) -> N = mk2N ;
    mkN : (bil,bilen,biler : Str) -> N = mk3N ;
    mkN : (dreng,drengen,drenge,drengene : Str) -> N = mk4N ;
  } ;


  regN : Str -> N ;
  regGenN : Str -> Gender -> N ;
  mk2N : (bil,bilen : Str) -> N ;
  mk3N : (bil,bilen,biler : Str) -> N ;
  mk4N  : (dreng,drengen,drenge,drengene : Str) -> N ;

  mkPN = overload {
    mkPN : Str -> PN = regPN ;       -- masculine
    mkPN : Str -> Gender -> PN = mk2PN ;  
    mkPN : N -> PN = nounPN ;
    } ;

  regPN    : Str -> PN ;            -- utrum
  mk2PN : Str -> Gender -> PN ;  
  nounPN : N -> PN ;

  mkA = overload {
    mkA : (fin : Str) -> A = regADeg ;
    mkA : (fin,fint : Str) -> A = mk2ADeg ;
    mkA : (galen,galet,galne : Str) -> A = mk3ADeg ;
    mkA : (stor,stort,store,storre,storst : Str) -> A = mkADeg ;
    mkA : A -> A = compoundA ; -- -/mer/mest norsk
  } ;

  mk3A : (galen,galet,galne : Str) -> A ;
  regA : Str -> A ;
  mk2A : (stor,stort : Str) -> A ;
  mkADeg : (stor,stort,store,storre,storst : Str) -> A ;
  regADeg : Str -> A ;
  irregADeg : (tung,tyngre,tyngst : Str) -> A ;
  mk3ADeg : (galen,galet,galne : Str) -> A ;
  mk2ADeg : (bred,bredt        : Str) -> A ;
  compoundA : A -> A ; -- -/mer/mest norsk

  mkV = overload {
    mkV : (snakke : Str) -> V = regV ;
    mkV : (leve,levde : Str) -> V = mk2V ;
    mkV : (drikke, drakk, drukket  : Str) -> V = irregV ;
    mkV : (spise,spiser,spises,spiste,spist,spis : Str) -> V = mk6V ;
    mkV : V -> Str -> V = partV ;
  } ;


  regV : (snakke : Str) -> V ;
  mk2V : (leve,levde : Str) -> V ;
  irregV : (drikke, drakk, drukket  : Str) -> V ;
  mk6V : (spise,spiser,spises,spiste,spist,spis : Str) -> V ;
  partV  : V -> Str -> V ;

  mkV2 = overload {
    mkV2 : Str -> V2 = \s -> dirV2 (regV s) ;
    mkV2 : V -> V2 = dirV2 ;
    mkV2 : V -> Prep -> V2 = mk2V2 ;
  } ;

  mk2V2  : V -> Prep -> V2 ;
  dirV2 : V -> V2 ;

} ;
