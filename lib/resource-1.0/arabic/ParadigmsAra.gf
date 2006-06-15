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
-- However, this function should only seldom be needed: we have a
-- separate module $IrregularAra$, which covers all irregularly inflected
-- words.
-- 
-- The following modules are presupposed:

resource ParadigmsAra = open 
  Predef, 
  Prelude, 
  MorphoAra,
  OrthoAra,
  CatAra
  in {

  flags optimize = noexpand;

  oper
    
    --lexical paradigms for nouns
    
    mkN : NTable -> Gender -> Species -> N = 
      \nsc,gen,spec ->
      { s = nsc; 
        g = gen; 
        h = spec;
        lock_N = <>
      };
    
    --takes a root string, a singular pattern string, a broken plural 
    --pattern string, a gender, and species. Gives a noun
    regN : Str -> Str -> Str -> Gender -> Species -> N =
      \root,sg,pl,gen,spec ->
      let { raw = regN' root sg pl gen spec} in
      { s = \\n,d,c =>
          case root of {
            _ + "؟" + _ => rectifyHmz(raw.s ! n ! d ! c);
            _ => raw.s ! n ! d ! c
          };
        g = gen;
        h = spec
      };
    
    regN' : Str -> Str -> Str -> Gender -> Species -> N =
      \root,sg,pl,gen,spec ->
      let { kitAb = mkWord sg root;
            kutub = mkWord pl root
      } in mkN (reg kitAb kutub) gen spec;
    
    --takes a root string, a singular pattern string, a gender, 
    --and species. Gives a noun whose plural is sound feminine
    sdfN : Str -> Str -> Gender -> Species -> N =
      \root,sg,gen,spec ->
      let { kalima = mkWord sg root;
      } in mkN (sndf kalima) gen spec;
    
    
    --takes a root string, a singular pattern string, a gender, 
    --and species. Gives a noun whose plural is sound masculine
    sdmN : Str -> Str -> Gender -> Species -> N =
      \root,sg,gen,spec ->
      let { mucallim = mkWord sg root;
      } in mkN (sndm mucallim) gen spec;
    
    --    mkN3 : N -> Str -> Str -> N3 = 
    --      \n,p,q -> n ** {c2 = p ; c3 = q; lock_N3 = <>} ;
    
    --lexical paradigms for adjectives
    
    --takes a root string and a pattern string
    regA : Str -> Str -> A =
      \root,pat ->
      let { raw = regA' root pat } in
      { s = \\g,n,d,c =>
          case root of {
            _ + "؟" + _ => rectifyHmz(raw.s ! g ! n ! d ! c);
            _ => raw.s ! g ! n ! d ! c
          };
        lock_A = <>
      };
    
    regA' : Str -> Str -> A =
      \root,pat ->
      let { kabIr = mkWord pat root
      } in {
        s = adj kabIr;
      };
    
  --takes a root string only
  clrA : Str -> A =
    \root ->
    let { eaHmar = mkWord "أَفعَل" root;
          HamrA' = mkWord "فَعلاء" root;
          Humr   = mkWord "فُعل" root
    } in {
      s = clr eaHmar HamrA' Humr;
      lock_A = <>
    };
  
  --lexical paradigms for verbs
  
  v1 : Str -> Vowel -> Vowel -> V = 
    \rootStr,vPerf,vImpf -> 
    let { raw = v1' rootStr vPerf vImpf } in
    { s = \\vf => 
        case rootStr of {
          _ + "؟" + _ => rectifyHmz(raw.s ! vf);
          _ => raw.s ! vf 
        };
      lock_V = <>
    } ;
  
    
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
    
    
    --Verb Form II : faccala

    v2 : Str -> V = 
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
    
    --Verb Form III : fAcala
    
    v3 : Str -> V = 
      \rootStr ->
      let {
        tbc = mkRoot3 rootStr ;
      } in {
        s = (v3sound tbc).s  ;
        lock_V = <>
      };
    
    --Verb Form IV : >afcala

    v4 : Str -> V = 
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
    
    --Verb Form V : tafaccala 

    v5 : Str -> V =
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
        s = (v5sound nfs).s  ;
      };
    
    --Verb Form VI : tafaacala 

    v6 : Str -> V = 
      \rootStr ->
      let {
        fqm = mkRoot3 rootStr ;
      } in {
        s = (v6sound fqm).s  ;
        lock_V = <>
      };
    
    --Verb Form VIII <iftacala

    v8 : Str -> V = 
      \rootStr ->
      let {
        rbT = mkRoot3 rootStr ;
      } in {
        s = (v8sound rbT).s ;
        lock_V = <>
      };


---- Prepositions are used in many-argument functions for rection.
--
  Preposition : Type ;


--2 Nouns

-- Use the function $mkPreposition$ or see the section on prepositions below to  
-- form other prepositions.
--
--3 Relational nouns 
-- 
-- Relational nouns ("دَُغهتر ْف خ") need a preposition. 

  mkN2 : N -> Preposition -> N2 ;

-- Three-place relational nouns ("تهي عْنّعتِْن فرْم خ تْ ي") need two prepositions.

  mkN3 : N -> Preposition -> Preposition -> N3 ;


----3 Relational common noun phrases
----
---- In some cases, you may want to make a complex $CN$ into a
---- relational noun (e.g. "تهي ْلد تْون هَلّ ْف").
--
--  cnN2 : CN -> Preposition -> N2 ;
--  cnN3 : CN -> Preposition -> Preposition -> N3 ;
--
-- 
--3 Proper names and noun phrases
--
-- Proper names, with a regular genitive, are formed as follows

  mkPN : Str -> Gender -> PN ;   

---- Sometimes you can reuse a common noun as a proper name, e.g. "َنك".
--
--  nounPN : N -> PN ;
--
---- To form a noun phrase that can also be plural and have an irregular
---- genitive, you can use the worst-case function.
--
--  mkNP : Str -> Str -> Number -> Gender -> NP ; 
--
----2 Adjectives
-- 
--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Preposition -> A2 ;

---- Comparison adjectives may two more forms. 
--
--  ADeg : Type ;
--
--  mkADeg : (good,better,best,well : Str) -> ADeg ;
--
---- The regular pattern recognizes two common variations: 
---- "ي" ("رُدي" - "رُدر" - "رُدست") and
---- "ي" ("هَةّي  هَةِّر  هَةِّست  هَةِّلي")
--
--  regADeg : Str -> ADeg ;      -- long, longer, longest
--
---- However, the duplication of the final consonant is nor predicted,
---- but a separate pattern is used:
--
--  duplADeg : Str -> ADeg ;      -- fat, fatter, fattest
--
---- If comparison is formed by "مْري، "most", as in general for
---- long adjective, the following pattern is used:
--
--  compoundADeg : A -> ADeg ; -- -/more/most ridiculous
--
---- From a given $ADeg$, it is possible to get back to $A$.
--
--  adegA : ADeg -> A ;
--
--
--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal (e.g. "َلوَيس").

  mkAdv : Str -> Adv ;
  mkAdV : Str -> AdV ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;

--2 Prepositions
--
-- A preposition as used for rection in the lexicon, as well as to
-- build $PP$s in the resource API, just requires a string.

  mkPreposition : Str -> Preposition ;
  mkPrep        : Str -> Prep ;

-- (These two functions are synonyms.)

--2 Verbs
--
----3 Verbs with a particle.
----
---- The particle, such as in "سوِتعه ْن", is given as a string.
--
--  partV  : V -> Str -> V ;
--
----3 Reflexive verbs
----
---- By default, verbs are not reflexive; this function makes them that.
--
--  reflV  : V -> V ;
--
----3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). Notice that a particle comes from the $V$.

  mkV2  : V -> Preposition -> V2 ;

  dirV2 : V -> V2 ;

--3 Three-place verbs
--
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

--
----2 Definitions of paradigms
----
---- The definitions should not bother the user of the API. So they are
---- hidden from the document.
----.
--
--  Gender = MorphoAra.Gender ; 
--  Number = MorphoAra.Number ;
--  Case = MorphoAra.Case ;
--  human = Masc ; 
--  nonhuman = Neutr ;
--  masculine = Masc ;
--  feminine = Fem ;
--  singular = Sg ;
--  plural = Pl ;
--  nominative = Nom ;
--  genitive = Gen ;
--
  Preposition = Str ;

  mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;
--  regN2 n = mkN2 (regN n) (mkPreposition "ْف") ;
  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;
--  cnN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;
--  cnN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;
--
--  mkPN n g = nameReg n g ** {lock_PN = <>} ;
--  nounPN n = {s = n.s ! singular ; g = n.g ; lock_PN = <>} ;
    mkNP : (_,_,_ : Str) -> PerGenNum -> NP = \ana,nI,I,pgn ->
      { s = 
          table {
            Nom => ana;
            Acc => nI;
            Gen => I
          };
        a = {pgn = pgn; isPron = True };
        lock_NP = <>
      };

--  mkNP x y n g = {s = table {Gen => x ; _ => y} ; a = agrP3 n ;
--  lock_NP = <>} ;
--
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
        lock_Quant = <>
      };


--  mkA a b = mkAdjective a a a b ** {lock_A = <>} ;
--  regA a = regAdjective a ** {lock_A = <>} ;
--
  mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;
--
--  ADeg = A ; ----
--
--  mkADeg a b c d = mkAdjective a b c d ** {lock_A = <>} ;
--

--  duplADeg fat = 
--    mkADeg fat 
--    (fat + last fat + "ر") (fat + last fat + "ست") (fat + "لي") ;
--
--  compoundADeg a =
--    let ad = (a.s ! AAdj Posit) 
--    in mkADeg ad ("مْري" ++ ad) ("مْست" ++ ad) (a.s ! AAdv) ;
--
--  adegA a = a ;
--
  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  mkPreposition p = p ;
--  mkPrep p = ss p ** {lock_Prep = <>} ;
--
--  mkV a b c d e = mkVerb a b c d e ** {s1 = [] ; lock_V = <>} ;
--
--
--  partV v p = verbPart v p ** {lock_V = <>} ;
--  reflV v = {s = v.s ; part = v.part ; lock_V = v.lock_V ; isRefl = True} ;
--
  mkV2 v p = v ** {s = v.s ; c2 = p ; lock_V2 = <>} ;
  dirV2 v = mkV2 v [] ;
  
  mkV3 v p q = v ** {s = v.s ; c2 = p ; c3 = q ; lock_V3 = <>} ;
  dirV3 v p = mkV3 v [] p ;
  dirdirV3 v = dirV3 v [] ;

  mkVS  v = v ** {lock_VS = <>} ;
--  mkVV  v = {
--    s = table {VVF vf => v.s ! vf ; _ => variants {}} ; 
--    isAux = False ; lock_VV = <>
--    } ;
  mkVQ  v = v ** {lock_VQ = <>} ;

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
