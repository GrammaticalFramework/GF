--# -path=.:../abstract:../prelude:../common

--1 Greek Lexical Paradigms
--
-- Hans Leiß, using Aarne Ranta's files for Latin as starting point  2011, 2012
-- 
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 

resource ParadigmsGrc = open 
  Prelude, 
  ResGrc, -- TODO: suppress later, when the inflections are moved to Morpho
  (M = MorphoGrc),
  (Ph = PhonoGrc),
  CatGrc
  in {

  flags 
    optimize=noexpand ;

--2 Parameters 

  oper
-- To abstract over gender and number names, we define the following.
--  Gender : Type ; 

    masculine : Gender ;
    feminine  : Gender ;
    neuter    : Gender ;

--  Number : Type ; 

    singular : Number ; 
    plural   : Number ;
    dual     : Number ;

-- VType : Type
    depMed : VType ;
    depPass : VType ;

--2 Nouns

    mkN = overload {
      mkN : (logos : Str) -> N 
        = \n -> lin N (noun n) ;

      mkN : Gender -> N -> N = \g,n -> lin N {s = n.s ; g=g } ;
    
      mkN : (va'latta, vala'tths : Str) -> N 
        = \x,y -> lin N (noun2 x y) ;
      mkN : (valatta, valatths, valattai : Str) -> N 
        = \x,y,z -> lin N (case x of { _ + ("a"|"h")    => noun3A x y z }) ;

      mkN : (a'mpelos, ampe'loy : Str) -> Gender -> N 
        = \x,y,g -> lin N (case x of { _ + ("os" | "os*") 
                                           => (case g of { 
                                                Masc|Fem => noun3O x y g ; 
                                                       _ => noun3  x y g }) ;
                                       _ + "on" => noun3O x y g ; 
                                       _  => noun3 x y g }) ; 
      mkN : (path'r, patro's, pate'ra : Str) -> Gender -> N 
        = \x,y,z,g -> lin N (noun3r3 x y z g) ;
    } ;

    mkN2  : N -> Prep -> N2 ;              -- relational nouns

--3 Proper names 
--
--  To inherit the inflection from nouns, proper names are built from nouns and a fixed number.

    mkPN = overload { 
      mkPN : Noun -> Number -> PN = 
        \n,num -> lin PN {s = n.s!num ; n=num ; g=n.g } ;
      mkPN : Str -> Gender -> PN = 
        \diogenhs,g -> lin PN (pn3s diogenhs g) ;
      mkPN : (_,_,_,_,_5:Str) -> Gender -> PN = 
        \nom,gen,dat,acc,voc,g -> 
        lin PN {s = table Case [nom ; gen ; dat ; acc ; voc] ; 
                n = Sg ; g = g} ;
    } ;

--2 Adjectives

-- Status: preliminary
--  - Adjective inflection is done by building three nouns; 
--  - no special accentuation rules are built in, 
--  - comparative and superlative: incorrect stems, wrong accents

    mkA = overload {
      -- for adjectives with accent on the ending, or triple-ended ones without accent shift, 
      -- provide SgNomMasc:
      mkA : (agavo's : Str) -> A     
        = \x -> lin A (mkAdjective (case x of { 
                                      y + ("w's*"|"w's") => adj3 x (y + "o'tos*") ;
                                      _ => adjAO x })) ; 
      -- for adjectives with accent not on the ending, provide SgNomMasc and SgGenFem:
      mkA : (di'kaios, dikai'as : Str) -> A 
        = \x,y -> lin A (mkAdjective (case y of { _ + ("os*"|"os") => adj3 x y ;
                                                  _ + ("nto's*"|"nto's") => adj3 x y ;
                                                  _                => adj2AO x y })) ;
    } ;

    mkA2  : A -> Prep -> A2 ;              -- relational adjectives

--2 Adverbs TODO 

-- Many adverbs are derived from adjectives by replacing the Masc.Sg.Gen-ending 
-- "w~n" | "wn" by "w~s" | "wn". These forms can be found as A.adv. 
-- Adverbs derived from adjectives inflect for Degree, others don't.

   mkAdV : Str -> AdV = \x -> lin AdV (ss x) ;

--2 Prepositions

-- A preposition is formed from a string and a case.

    mkPrep : Str -> Case -> Prep = \s,c -> lin Prep {s = canonize s ; c = c} ;
  
-- Often just a case with the empty string is enough:

    accPrep, datPrep, genPrep : Prep ;

--2 Verbs

    mkV = overload {
      -- for regular verbs whose aspect/tempus stems can be derived 
      mkV : (paideyw : Str) -> V = 
            \v -> case v of { _ + "w"          => lin V (M.mkVerbW1 v) ;
                              _ + ("mi"|"mi'") => lin V (M.mkVerbMi1 v) ;
                              _ + "omai"       => lin V (M.mkVerbDep v DepMed) -- default dep.
                            } ;
      mkV : (paideyomai : Str) -> (vt : VType) -> V = 
            \v,vt -> case v of { _ + "omai" => lin V (M.mkVerbDep v vt) ;
                                 _ => Predef.error ("verb does not end in -omai") } ;

      -- for intransitive verbs having no medium and passiv:
      mkV : (_,_,_,v4 : Str) -> V =  -- TODO
        \piptw,pesoymai,epeson,peptwka -> 
        lin V { act = M.mkActW piptw pesoymai epeson peptwka ;
                med, pass = table { vf => Predef.nonExist } ;
                vadj1, vadj2 = { s = table { af => Predef.nonExist } ;
                                 adv = Predef.nonExist } ;
                vtype = VFull } ;

      -- for verbs whose aspect/tempus stems must be provided by:
      --  ActPres, ActFut,  ActAor,   ActPerf,   MedPerf,    PassAor,    VAdj          
      --  paideyw  paideysw epaideysa pepaideyka pepaideymai epaideyvhn  paideytos
      --   lei'pw  lei'psw  le'lipa   le'loipa   le'leipmai  lelei'fvhn  leipt'os
      mkV : (_,_,_,_,_,_,v7 : Str) -> V = 
            \leipw,leipsw,elipsa,leloipa,leleipmai,leleifvhn,leiptos ->
            case leipw of { 
               _ + "w"    => lin V (M.mkVerbW7 leipw leipsw elipsa leloipa 
                                               leleipmai leleifvhn leiptos) ;
               _ + "nymi" => lin V (M.mkVerbNyMi7 leipw leipsw elipsa leloipa 
                                               leleipmai leleifvhn leiptos) ;
               _          => lin V (M.mkVerbRedupMi leipw leipsw elipsa leloipa 
                                               leleipmai leleifvhn leiptos)
            } ;
    } ;

    -- Verbs with prepositional (and other) prefix reduplicate and augment after
    -- the prefix, and assimilate prefix and main verb:

    -- (It's faster if we do elision by indicating where the prefix ends)
    prefixV : Str -> V -> V = \sy'n, v -> lin V      -- BR 85 
      (let                                           -- TODO: admit u@diphthong; else?
          syn = M.dA sy'n ;                          
          nC : Str -> Str -> Str = Ph.nasalConsonant ;
          elision : (Str * Str) -> Str = \str -> case str of { 
             <x + "r" + i@("i'"|"i"|"o'"|"o"), u@#Ph.vowel + #Ph.aspirate + y>
                               => x + "r" + i + u + y ; -- don't elide in peri|pro
             <x + ("a'"|"a"|"o'"|"o"|"i'"|"i"), u@#Ph.vowel + #Ph.aspirate + y>
                               => x + u + y ;           -- elide vowel of prefix, and aspirate
             <x + c@#Ph.consonant, u@#Ph.vowel + #Ph.aspirate + y>
                               => x + c + u + y ;
             _ => nC str.p1 str.p2
            } ;
          assim : Str -> Str -> Str = \str1,str2 -> elision <str1,str2> ;
      in 
       { act  = table { form => assim syn (v.act!form) } ;  -- syn + (part ++ einai) TODO
         med  = table { Fin (VPerf VConj) n p => syn ++ v.med ! (Fin (VPerf VConj) n p) ;
                        Fin (VPerf VOpt)  n p => syn ++ v.med ! (Fin (VPerf VOpt ) n p) ;
                        form => assim syn (v.med ! form) } ;
         pass = table { Fin (VPerf VConj) n p => syn ++ v.pass ! (Fin (VPerf VConj) n p) ;
                        Fin (VPerf VOpt)  n p => syn ++ v.pass ! (Fin (VPerf VOpt ) n p) ;
                        form => assim syn (v.pass ! form) } ;
         imp  = table { form => assim syn (v.imp ! form) } ;
         part = table { Act => \\t => { s = \\aform => assim syn ((v.part ! Act ! t).s ! aform) ;  
                                        adv = assim syn (v.part ! Act ! t).adv } ;
                        dia => \\t => { s = \\aform => assim syn ((v.part ! dia ! t).s ! aform) ; -- guessed
                                        adv = assim syn (v.part ! dia ! t).adv } 
           } ;
         vadj1 = { s = \\aform => assim syn (v.vadj1.s ! aform) ;
                  adv = assim syn v.vadj1.adv } ;                  
         vadj2 = { s = \\aform => assim syn (v.vadj2.s ! aform) ;
                  adv = assim syn v.vadj2.adv } ;                  
         vtype = v.vtype ;
       }) ;

--3 Two-place verbs

   mkV2 = overload {

-- Two-place regular verbs with direct object (accusative, transitive verbs).

       mkV2 : Str -> V2 = strV2 ;       
       mkV2 : V -> V2   = dirV2 ;         -- add a direct object

-- Two-place verbs with a prepositional or nominal complement

       mkV2 : V -> Prep -> V2 = prepV2 ;  -- preposition for complement
       mkV2 : V -> Case -> V2 = caseV2 ;  -- just case for complement
   } ;

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be just a case.

    mkV3     : V -> Prep -> Prep -> V3 ;  

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

--  mkV0  : V -> V0 ; --%
   mkVS  : V -> VS ;
   mkV2S : V -> Prep -> V2S ;
   mkVV  : V -> VV ;
   mkV2V : V -> Prep -> V2V ;
--   mkVA  : V -> VA ;
   mkV2A : V -> Prep -> V2A ;
--   mkVQ  : V -> VQ ;
   mkV2Q : V -> Prep -> V2Q ;

--   mkAS  : A -> AS ; --%
--   mkA2S : A -> Prep -> A2S ; --%
--   mkAV  : A -> AV ; --%
--   mkA2V : A -> Prep -> A2V ; --%

-- Notice: categories $AS, A2S, AV, A2V$ are just $A$, 
-- and the second argument is given as an adverb. Likewise 
-- $V0$ is just $V$.

--  V0 : Type ; --%
--  AS, A2S, AV, A2V : Type ; --%


--3 Adverbs

  mkAdv = overload {

    mkAdv : Str -> Adv        = \str  -> lin Adv { s = str } ;
    mkAdv : Prep -> NP -> Adv = \p,np -> lin Adv { s = p.s ++ np.s ! p.c } ;
    mkAdv : A -> Adv          = \a    -> lin Adv { s = a.adv ! Posit } ;
  } ;

-- LexiconGrc should not use the short forms below.

    masculine = Masc ;
    feminine  = Fem ;
    neuter    = Neutr ;

    singular = Sg ;
    plural   = Pl ;
    dual     = Dl ;

    genitive = Gen ;
    dative   = Dat ;
    accusative = Acc ;

    depMed = DepMed ;
    depPass = DepPass ;

-- Definitions of the operations: ===================================================

    mkN2  : N -> Prep -> N2 = \n,p -> lin N2 (n ** {c2 = p ; obj = \\r => []}) ;
    mkN3  : N -> Prep -> Prep -> N3 = \n,p,q -> lin N3 (n ** {c2 = p ; c3 = q}) ;

    mkA2  : A -> Prep -> A2 = \a,p -> lin A2 (a ** {c2 = p}) ;

    prepV2 : V -> Prep -> V2 = \v,c -> lin V2 (v ** {c2 = c}) ;
    dirV2 : V -> V2 = \v -> prepV2 v accPrep ;
    datV2 : V -> V2 = \v -> prepV2 v datPrep ;
    strV2 : Str -> V2 = \s -> dirV2 (mkV s) ; 

    caseV2 : V -> Case -> V2 = \v,c -> prepV2 v (mkPrep [] c) ;

    mkV3 : V -> Prep -> Prep -> V3 = \v,c,d -> lin V3 (v ** {c2 = c; c3 = d}) ;
    dirV3 : V -> Prep -> V3 = \v,d -> lin V3 (v ** {c2 = accPrep; c3 = d}) ;

    mkVS : V -> VS = \v -> lin VS (v ** {s = v.act ! (Fin (VPres VConj) Sg P3)}) ; -- prelim, TEST
    mkV2S = \v,p -> lin V2S (prepV2 v p ** {isAux = False});
    mkV2V = \v,p -> lin V2V (prepV2 v p ** {isAux = False});
    mkV2Q = \v,p -> lin V2Q (prepV2 v p ** {isAux = False});
    mkVV : V -> VV = \v -> lin VV v ; -- ?? 
    mkV2A v p = lin V2A (prepV2 v p ** {isAux = False}) ;

    accPrep = mkPrep [] accusative; -- just dative case
    genPrep = mkPrep [] genitive ;  -- just genitive case
    datPrep = mkPrep [] dative ;    -- just dative case
 
}
