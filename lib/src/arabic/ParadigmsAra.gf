--# -path=.:../abstract:../../prelude:../common

--1 Arabic Lexical Paradigms
--
-- Ali El Dada 2005--2006
--
-- This is an API to the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoAra.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
-- 
-- The following modules are presupposed:

resource ParadigmsAra = open 
  Predef, 
  Prelude, 
  MorphoAra,
  OrthoAra,(ResAra=ResAra),
  CatAra
  in {

  flags optimize = noexpand;  coding=utf8 ;

  oper
    
-- Prepositions are used in many-argument functions for rection.

  Preposition : Type ;

--2 Nouns

-- Overloaded operator for main cases

 mkN = overload {
   mkN : (sg : Str) -> N                                     -- non-human regular nouns
     = smartN ;
   mkN : Species -> N -> N
     = \p,n -> n ** {h = p} ;
   mkN : (sg,pl : Str) -> Gender -> Species -> N
     = \sg,pl -> mkFullN (reg sg pl) ;  
   mkN : NTable -> Gender -> Species -> N                             -- loan words, irregular
     = mkFullN ;
   mkN : (root,sgPatt,brokenPlPatt : Str) -> Gender -> Species -> N   -- broken plural
    = brkN ;
---   mkN : (root,sgPatt : Str) -> Gender -> Species -> N                -- sound feminine plural
---    = sdfN ;
   } ;

--This is used for loan words or anything that has untreated irregularities
--in the interdigitization process of its words
  mkFullN : NTable -> Gender -> Species -> N ;
  
--Takes a root string, a singular pattern string, a broken plural 
--pattern string, a gender, and species. Gives a noun.
  brkN : Str -> Str -> Str -> Gender -> Species -> N ;
  
--Takes a root string, a singular pattern string, a gender, 
--and species. Gives a noun whose plural is sound feminine.
  sdfN : Str -> Str -> Gender -> Species -> N ;
    
--takes a root string, a singular pattern string, a gender, 
--and species. Gives a noun whose plural is sound masculine
  sdmN : Str -> Str -> Gender -> Species -> N ; 


--3 Proper names

  mkPN = overload {
    mkPN : Str -> PN        -- Fem Hum if ends with ة, otherwise Masc Hum
     = smartPN ;
    mkPN : Str -> Gender -> Species -> PN
     = mkFullPN ;
    } ;

  mkFullPN : Str -> Gender -> Species -> PN ;



--3 Relational nouns 

  mkN2 : N -> Preposition -> N2 ;

  mkN3 : N -> Preposition -> Preposition -> N3 ;


--2 Adjectives

-- Overloaded operator for main cases

 mkA = overload {
   mkA : (root,patt : Str) -> A
    = sndA ;
   mkA : (root : Str) -> A                -- forms adjectives with positive form aFCal
    = clrA ;
   mkA : (posit,compar,plur : Str) -> A
    = degrA ;
   } ;


--Takes a root string and a pattern string
  sndA : (root,patt : Str) -> A ;
    
--Takes a root string only
  clrA : (root : Str) -> A ;  -- forms adjectives of type aFCal

--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Preposition -> A2 ;

--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal.

  mkAdv : Str -> Adv ;
  mkAdV : Str -> AdV ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;

--2 Prepositions
--
-- A preposition as used for rection in the lexicon, as well as to
-- build $PP$s in the resource API, just requires a string.

  mkPrep : Str -> Prep
    = \s -> lin Prep {s = mkPreposition s} ; -- preposition in the sense of RGL abstract syntax
    
  mkPreposition : Str -> Preposition ;  -- just a string, for internal use


--2 Verbs

-- Overloaded operations

  mkV = overload {
    mkV : (imperfect : Str) -> V
      = regV ;
    mkV : (root : Str) -> (perf,impf : Vowel) -> V  -- verb form I ; vowel = a|i|u
      = v1 ;
    mkV : (root : Str) -> VerbForm -> V             -- FormI .. FormVIII (no VII) ; default vowels a u for I
      = formV ;
    } ;

-- The verb in the imperfect tense gives the most information

  regV : Str -> V ;

--Verb Form I : fa`ala, fa`ila, fa`ula

  v1 : Str -> Vowel -> Vowel -> V ;
  
--Verb Form II : fa``ala
  
  v2 : Str -> V ;
  
--Verb Form III : faa`ala
  
  v3 : Str -> V ;
  
--Verb Form IV : 'af`ala
  
  v4 : Str -> V ;
  
--Verb Form V : tafa``ala 
  
  v5 : Str -> V ;
  
--Verb Form VI : tafaa`ala 
  
  v6 : Str -> V ;
  
--Verb Form VIII 'ifta`ala
  
  v8 : Str -> V ;

--3 Two-place verbs

-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). Notice that a particle comes from the $V$.

  mkV2  : V -> Preposition -> V2 ;

  dirV2 : V -> V2 ;

--3 Three-place verbs

-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Preposition -> Preposition -> V3 ; -- speak, with, about
  dirV3    : V -> Preposition -> V3 ;                -- give,_,to
  dirdirV3 : V -> V3 ;                               -- give,_,_

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ;
  mkVS  : V -> VS ;
  mkV2S : V -> Str -> V2S ;
--  mkVV  : V -> VV ;
  mkV2V : V -> Str -> Str -> V2V ;
  mkVA  : V -> VA ;
  mkV2A : V -> Str -> V2A ;
  mkVQ  : V -> VQ ;
  mkV2Q : V -> Str -> V2Q ;

  mkAS  : A -> AS ;
  mkA2S : A -> Str -> A2S ;
  mkAV  : A -> AV ;
  mkA2V : A -> Str -> A2V ;

-- Notice: categories $AS, A2S, AV, A2V$ are just $A$,
-- and the second argument is given
-- as an adverb. Likewise 
-- $V0$ is just $V$.

  V0 : Type ;
  AS, A2S, AV, A2V : Type ;


--.
--2 Definitions of paradigms

-- The definitions should not bother the user of the API. So they are
-- hidden from the document.

  regV : Str -> V = \wo ->
    let rau : Str * Vowel * Vowel = 
    case wo of {
      "يَ" + fc + "ُ" + l => <fc+l, a, u> ;
      "يَ" + fc + "ِ" + l => <fc+l, a, i> ;
      "يَ" + fc + "َ" + l => <fc+l, a, a> ;
      f@? + "َ" + c@? + "ِ" + l  => <f+c+l, i, a> ;
      _ => Predef.error ("regV not applicable to" ++ wo)
    }
    in v1 rau.p1 rau.p2 rau.p3 ;

  v1 = \rootStr,vPerf,vImpf -> 
    let { raw = v1' rootStr vPerf vImpf } in
    { s = \\vf => 
        case rootStr of {
          _ + "؟" + _ => rectifyHmz(raw.s ! vf);
          _ => raw.s ! vf 
        };
      lock_V = <>
    } ;
  
  va : Vowel = ResAra.a ;

  v1' : Str ->  Vowel -> Vowel -> Verb = 
    \rootStr,vPerf,vImpf ->
    let { root = mkRoot3 rootStr ;
          l = dp 2 rootStr } in --last rootStr
    case <l, root.c> of {
      <"ّ",_>     => v1geminate rootStr vPerf vImpf ;
      <"و"|"ي",_> => v1defective root vImpf ;
      <_,"و"|"ي"> => v1hollow root vImpf ;
      _		    => v1sound root vPerf vImpf 
    };
  
  v2 = 
    \rootStr ->
    let {
      root = mkRoot3 rootStr 
    } in {
      s = 
        case root.l of {
          "و"|"ي" => (v2defective root).s;
          _       => (v2sound root).s
        };
      lock_V = <>
    };              
  
  v3 = 
    \rootStr ->
    let {
      tbc = mkRoot3 rootStr ;
    } in {
      s = (v3sound tbc).s  ;
      lock_V = <>
    };
  
  v4 = 
    \rootStr ->
    let {
      root = mkRoot3 rootStr 
    } in {
      s = 
        case root.l of {
          "و"|"ي" => (v4defective root).s;
          _       => (v4sound root).s
        }; 
      lock_V = <>
    };
  
  
  v5 =
    \rootStr ->
    let { raw = v5' rootStr } in
    { s = \\vf =>
        case rootStr of {
          _ + "؟" + _ => rectifyHmz(raw.s ! vf);
          _ => raw.s ! vf
        };
      lock_V = <>
    };
  
  v5' : Str -> V = 
    \rootStr ->
    let {
      nfs = mkRoot3 rootStr ;
    } in {
      s = (v5sound nfs).s  ; lock_V = <>
    };
  
  v6 = 
    \rootStr ->
    let {
      fqm = mkRoot3 rootStr ;
    } in {
      s = (v6sound fqm).s  ;
      lock_V = <>
    };
  
  v8 = 
    \rootStr ->
    let {
      rbT = mkRoot3 rootStr ;
    } in {
      s = (v8sound rbT).s ;
      lock_V = <>
    };
  
  Preposition = Str ;
  
  mkFullN nsc gen spec =
    { s = nsc; --NTable
      g = gen; 
      h = spec;
      lock_N = <>
    };
  
  brkN' : Str -> Str -> Str -> Gender -> Species -> N =
    \root,sg,pl,gen,spec ->
    let { kitAb = mkWord sg root;
          kutub = mkWord pl root
    } in mkFullN (reg kitAb kutub) gen spec;
  
  brkN root sg pl gen spec =
    let { raw = brkN' root sg pl gen spec} in
    { s = \\n,d,c =>
        case root of {
          _ + "؟" + _ => rectifyHmz(raw.s ! n ! d ! c);
          _ => raw.s ! n ! d ! c
        };
      g = gen;
      h = spec ; lock_N = <>
    };
  
  sdfN =
    \root,sg,gen,spec ->
    let { kalima = mkWord sg root;
    } in mkFullN (sndf kalima) gen spec;
  
  sdmN =
    \root,sg,gen,spec ->
    let { mucallim = mkWord sg root;
    } in mkFullN (sndm mucallim) gen spec;

  mkFullPN = \str,gen,species -> 
    { s = \\c => str + indecl!c ;
      g = gen;
      h = species;
      lock_PN = <>
    };
    
  
  mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;
  
  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;
  
  mkPron : (_,_,_ : Str) -> PerGenNum -> NP = \ana,nI,I,pgn ->
    { s = 
        table {
          Nom => ana;
          Acc => nI;
          Gen => I
        };
      a = {pgn = pgn; isPron = True };
      lock_NP = <>
    };

  -- e.g. al-jamii3, 2a7ad
  regNP : Str -> Number -> NP = \word,n ->
    { s = \\c => word ++ vowel ! c ; ---- gives strange chars
      a = {pgn = Per3 Masc n; isPron = False };
      lock_NP = <>
    };

  -- e.g. hadha, dhaalika
  indeclNP : Str -> Number -> NP = \word,n ->
    { s = \\c => word ;
      a = {pgn = Per3 Masc n; isPron = False };
      lock_NP = <>
    };
  
  mkQuant7 : (_,_,_,_,_,_,_ : Str) -> State -> Quant =
    \hava,havihi,havAn,havayn,hAtAn,hAtayn,hA'ulA,det ->
    { s = \\n,s,g,c =>
        case <s,g,c,n> of {
          <_,Masc,_,Sg>  => hava;
          <_,Fem,_,Sg>   => havihi;
          <_,Masc,Nom,Dl>=> havAn;
          <_,Masc,_,Dl>  => havayn;
          <_,Fem,Nom,Dl> => hAtAn;
          <_,Fem,_,Dl>   => hAtayn;
          <Hum,_,_,Pl>   => hA'ulA;
          _              => havihi
        };
      d = Def;
      isPron = False;
      isNum = False;
      lock_Quant = <>
    };
  
  mkQuant3 : (_,_,_ : Str) -> State -> Quant =
    \dalika,tilka,ula'ika,det ->
    { s = \\n,s,g,c =>
        case <s,g,c,n> of {
          <_,Masc,_,Sg>  => dalika;
          <_,Fem,_,Sg>   => tilka;
          <Hum,_,_,_>   => ula'ika;
          _              => tilka
        };
      d = Def;
      isPron = False;
      isNum = False;
      lock_Quant = <>
    };

  degrA : (posit,compar,plur : Str) -> A
    = \posit,compar,plur -> lin A {s = clr posit compar plur} ;
  
  sndA root pat =
    let  raw = sndA' root pat in { 
      s = \\af =>
        case root of {
          _ + "؟" + _ => rectifyHmz(raw.s ! af);
        _ => raw.s ! af
        };
      lock_A = <>
    };
  
  sndA' : Str -> Str -> A =
    \root,pat ->
    let { kabIr = mkWord pat root;
          akbar = mkWord "أَفعَل" root
    } in {
      s = table {
        APosit g n d c => (positAdj kabIr) ! g ! n ! d ! c ;
        AComp d c => (indeclN akbar) ! d ! c
        };
      lock_A = <>
    };
  
  clrA root =
    let { eaHmar = mkWord "أَفعَل" root;
          HamrA' = mkWord "فَعلاء" root;
          Humr   = mkWord "فُعل" root
    } in {
      s = clr eaHmar HamrA' Humr;
      lock_A = <>
    };
  
  mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;
  
  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;
  
  mkPreposition p = p ;
  mkV2 v p = v ** {s = v.s ; c2 = p ; lock_V2 = <>} ;
  dirV2 v = mkV2 v [] ;
  
  mkV3 v p q = v ** {s = v.s ; c2 = p ; c3 = q ; lock_V3 = <>} ;
  dirV3 v p = mkV3 v [] p ;
  dirdirV3 v = dirV3 v [] ;

  mkVS  v = v ** {lock_VS = <>} ;
  mkVQ  v = v ** {lock_VQ = <>} ;

  V0 : Type = V ;
----  V2S, V2V, V2Q, V2A : Type = V2 ;
  AS, A2S, AV : Type = A ;
  A2V : Type = A2 ;

  mkV0  v = v ** {lock_V = <>} ;
  mkV2S v p = mkV2 v p ** {lock_V2S = <>} ;
  mkV2V v p t = mkV2 v p ** {s4 = t ; lock_V2V = <>} ;
  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p = mkV2 v p ** {lock_V2A = <>} ;
  mkV2Q v p = mkV2 v p ** {lock_V2Q = <>} ;

  mkAS  v = v ** {lock_A = <>} ;
  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
  mkAV  v = v ** {lock_A = <>} ;
  mkA2V v p = mkA2 v p ** {lock_A2 = <>} ;


smartN : Str -> N = \s -> case last s of {
  "ة" => mkFullN (sndf s) Fem NoHum ;
  _ => mkFullN (sndm s) Masc NoHum
  } ;

smartPN : Str -> PN = \s -> case last s of {
  "ة" => mkFullPN s Fem Hum ;
  _ => mkFullPN s Masc Hum
  } ;

formV : (root : Str) -> VerbForm -> V = \s,f -> case f of {
   FormI   => v1 s a u ;
   FormII  => v2 s ;
   FormIII => v3 s ;
   FormIV  => v4 s ;
   FormV   => v5 s ;
   FormVI  => v6 s ;
---   FormVII  => v7 s ;
   FormVIII => v8 s
   } ;

param VerbForm =
  FormI |  FormIII |  FormIII |  FormIV |  FormV |  FormVI | FormVIII  ;

} ;
