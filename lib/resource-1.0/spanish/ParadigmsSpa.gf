--# -path=.:../romance:../common:../abstract:../../prelude

--1 Spanish Lexical Paradigms
--
-- Aarne Ranta 2004 - 2006
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoSpa.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$. For
-- verbs, there is a fairly complete list of irregular verbs in
-- [``IrregSpa`` ../../spanish/IrregSpa.gf].

resource ParadigmsSpa = 
  open 
    (Predef=Predef), 
    Prelude, 
    CommonRomance, 
    ResSpa, 
    MorphoSpa, 
    BeschSpa,
    CatSpa in {

  flags optimize=all ;

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender : Type ; 

  masculine : Gender ;
  feminine  : Gender ;

-- To abstract over number names, we define the following.

  Number : Type ; 

  singular : Number ;
  plural   : Number ;

-- Prepositions used in many-argument functions are either strings
-- (including the 'accusative' empty string) or strings that
-- amalgamate with the following word (the 'genitive' "de" and the
-- 'dative' "a").

  accusative : Prep ;
  genitive   : Prep ;
  dative     : Prep ;

  mkPrep : Str -> Prep ;


--2 Nouns

  mkN : overload {

-- The regular function takes the singular form and the gender,
-- and computes the plural and the gender by a heuristic. 
-- The heuristic says that the gender is feminine for nouns
-- ending with "a" or "z", and masculine for all other words.
-- Nouns ending with "a", "o", "e" have the plural with "s",
-- those ending with "z" have "ces" in plural; all other nouns
-- have "es" as plural ending. The accent is not dealt with.

    mkN : (luz : Str) -> N ;

-- A different gender can be forced.

    mkN : Str -> Gender -> N ;

-- The worst case has two forms (singular + plural) and the gender.

    mkN : (baston,bastones : Str) -> Gender -> N 
    } ;


--3 Compound nouns 
--
-- Some nouns are ones where the first part is inflected as a noun but
-- the second part is not inflected. e.g. "número de teléfono". 
-- They could be formed in syntax, but we give a shortcut here since
-- they are frequent in lexica.

  compN : N -> Str -> N ;


--3 Relational nouns 
-- 
-- Relational nouns ("fille de x") need a case and a preposition. 

  mkN2 : N -> Prep -> N2 ;

-- The most common cases are the genitive "de" and the dative "a", 
-- with the empty preposition.

  deN2 : N -> N2 ;
  aN2  : N -> N2 ;

-- Three-place relational nouns ("la connessione di x a y") need two prepositions.

  mkN3 : N -> Prep -> Prep -> N3 ;


--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "the old town hall of"). However, $N2$ and
-- $N3$ are purely lexical categories. But you can use the $AdvCN$
-- and $PrepNP$ constructions to build phrases like this.

-- 
--3 Proper names and noun phrases
--
-- Proper names need a string and a gender.
-- The default gender is feminine for names ending with "a", otherwise masculine.

  mkPN : overload {
    mkPN : (Anna : Str) -> PN ;
    mkPN : (Pilar : Str) -> Gender -> PN
    } ;


--2 Adjectives

  mkA : overload {

-- For regular adjectives, all forms are derived from the
-- masculine singular. The types of adjectives that are recognized are
-- "alto", "fuerte", "util". Comparison is formed by "mas".

    mkA : (util : Str) -> A ;

-- One-place adjectives compared with "mas" need five forms in the worst
-- case (masc and fem singular, masc plural, adverbial).

    mkA : (solo,sola,solos,solas,solamente : Str) -> A ;

-- In the worst case, two separate adjectives are given: 
-- the positive ("bueno"), and the comparative ("mejor"). 

    mkA : (bueno : A) -> (mejor : A) -> A
    } ;

-- The functions above create postfix adjectives. To switch
-- them to prefix ones (i.e. ones placed before the noun in
-- modification, as in "buen vino"), the following function is
-- provided.

  prefixA : A -> A ;


--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Prep -> A2 ;



--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. 

  mkAdv : Str -> Adv ;

-- Some appear next to the verb (e.g. "siempre").

  mkAdV : Str -> AdV ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;


--2 Verbs

  mkV : overload {

-- Regular verbs are ones inflected like "cortar", "deber", or "vivir".
-- The regular verb function is the first conjugation ("ar") recognizes
-- the variations corresponding to the patterns
-- "actuar, cazar, guiar, pagar, sacar". The module $BeschSpa$ gives
-- the complete set of "Bescherelle" conjugations.

    mkV : (pagar : Str) -> V ;

-- Verbs with vowel alternatition in the stem - easiest to give with
-- two forms, e.g. "mostrar"/"muestro".

    mkV : (mostrar,muestro : Str) -> V ;

-- Most irreguler verbs are found in $IrregSpa$. If this is not enough,
-- the module $BeschSpa$ gives all the patterns of the "Bescherelle"
-- book. To use them in the category $V$, wrap them with the function

    mkV : Verbum -> V 
    } ;

-- To form reflexive verbs:

  reflV : V -> V ;

-- Verbs with a deviant passive participle: just give the participle
-- in masculine singular form as second argument.

  special_ppV : V -> Str -> V ; 



--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). 

  mkV2 : overload {
    mkV2 : Str -> V2 ;
    mkV2 : V -> V2 ;  
    mkV2 : V -> Prep -> V2
    } ;


-- You can reuse a $V2$ verb in $V$.

  v2V : V2 -> V ;

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Prep -> Prep -> V3 ;   -- hablar, a, di
  dirV3    : V -> Prep -> V3 ;           -- dar,(accusative),a
  dirdirV3 : V -> V3 ;                   -- dar,(dative),(accusative)

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ;
  mkVS  : V -> VS ;
  mkV2S : V -> Prep -> V2S ;
  mkVV  : V -> VV ;  -- plain infinitive: "quiero hablar"
  deVV  : V -> VV ;  -- "terminar de hablar"
  aVV   : V -> VV ;  -- "aprender a hablar"
  mkV2V : V -> Prep -> Prep -> V2V ;
  mkVA  : V -> VA ;
  mkV2A : V -> Prep -> Prep -> V2A ;
  mkVQ  : V -> VQ ;
  mkV2Q : V -> Prep -> V2Q ;

  mkAS  : A -> AS ;
  mkA2S : A -> Prep -> A2S ;
  mkAV  : A -> Prep -> AV ;
  mkA2V : A -> Prep -> Prep -> A2V ;

-- Notice: categories $V2S, V2V, V2Q$ are in v 1.0 treated
-- just as synonyms of $V2$, and the second argument is given
-- as an adverb. Likewise $AS, A2S, AV, A2V$ are just $A$.
-- $V0$ is just $V$.

  V0, V2S, V2V, V2Q : Type ;
  AS, A2S, AV, A2V  : Type ;


--.
--2 The definitions of the paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.

  Gender = MorphoSpa.Gender ; 
  Number = MorphoSpa.Number ;
  masculine = Masc ;
  feminine = Fem ;
  singular = Sg ;
  plural = Pl ;

  accusative = complAcc ** {lock_Prep = <>} ;
  genitive = complGen ** {lock_Prep = <>} ;
  dative = complDat ** {lock_Prep = <>} ;
  mkPrep p = {s = p ; c = Acc ; isDir = False ; lock_Prep = <>} ;


  mk2N x y g = mkNounIrreg x y g ** {lock_N = <>} ;
  regN x = mkNomReg x ** {lock_N = <>} ;
  compN x y = {s = \\n => x.s ! n ++ y ; g = x.g ; lock_N = <>} ;
  femN x = {s = x.s ; g = feminine ; lock_N = <>} ;
  mascN x = {s = x.s ; g = masculine ; lock_N = <>} ;

  mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;
  deN2 n = mkN2 n genitive ;
  aN2 n = mkN2 n dative ;
  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;

  mk2PN x g = {s = x ; g = g} ** {lock_PN = <>} ;
  regPN x = mk2PN x g where {
    g = case last x of {
      "a" => feminine ;
      _ => masculine
      }
    } ;

  makeNP x g n = {s = (pn2np (mk2PN x g)).s; a = agrP3 g n ; hasClit = False} ** {lock_NP = <>} ;

  mk5A a b c d e = 
   compADeg {s = \\_ => (mkAdj a b c d e).s ; isPre = False ; lock_A = <>} ;
  regA a = compADeg {s = \\_ => (mkAdjReg a).s ; isPre = False ; lock_A = <>} ;
  prefA a = {s = a.s ; isPre = True ; lock_A = <>} ;

  mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;

  mkADeg a b = 
   {s = table {Posit => a.s ! Posit ; _ => b.s ! Posit} ; 
    isPre = a.isPre ; lock_A = <>} ;
  compADeg a = 
    {s = table {Posit => a.s ! Posit ; _ => \\f => "más" ++ a.s ! Posit ! f} ; 
     isPre = a.isPre ;
     lock_A = <>} ;
  regADeg a = compADeg (regA a) ;

  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  regV x = -- cortar actuar cazar guiar pagar sacar
    let 
      ar = Predef.dp 2 x ;
      z  = Predef.dp 1 (Predef.tk 2 x) ;
      verb = case ar of {
        "ir" =>  vivir_7 x ;
        "er" =>  deber_6 x ;
        _ => case z of {
           "u" => actuar_9 x ;
           "z" => cazar_21 x ;
           "i" => guiar_43 x ;
           "g" => pagar_53 x ;
           "c" => sacar_72 x ;
           _   => cortar_5 x
            }
          }
    in verbBesch verb ** {vtyp = VHabere ; lock_V = <>} ;

  reflV v = {s = v.s ; vtyp = VRefl ; lock_V = <>} ;

  verboV ve = verbBesch ve ** {vtyp = VHabere ; lock_V = <>} ;

  reflVerboV : Verbum -> V = \ve -> reflV (verboV ve) ;

  special_ppV ve pa = {
    s = table {
      VPart g n => (adjSolo pa).s ! AF g n ;
      p => ve.s ! p
      } ;
    lock_V = <> ;
    vtyp = VHabere
    } ;

  regAltV x y = verboV (regAlternV x y) ;

  mk2V2 v p = {s = v.s ; vtyp = v.vtyp ; c2 = p ; lock_V2 = <>} ;
  dirV2 v = mk2V2 v accusative ;
  v2V v = v ** {lock_V = <>} ;

  mkV3 v p q = {s = v.s ; vtyp = v.vtyp ; 
    c2 = p ; c3 = q ; lock_V3 = <>} ;
  dirV3 v p = mkV3 v accusative p ;
  dirdirV3 v = dirV3 v dative ;

  V0 : Type = V ;
  V2S, V2V, V2Q : Type = V2 ;
  AS, AV : Type = A ;
  A2S, A2V : Type = A2 ;

  mkV0  v = v ** {lock_V0 = <>} ;
  mkVS  v = v ** {m = \\_ => Indic ; lock_VS = <>} ;  ---- more moods
  mkV2S v p = mk2V2 v p ** {mn,mp = Indic ; lock_V2S = <>} ;
  mkVV  v = v ** {c2 = complAcc ; lock_VV = <>} ;
  deVV  v = v ** {c2 = complGen ; lock_VV = <>} ;
  aVV  v = v ** {c2 = complDat ; lock_VV = <>} ;
  mkV2V v p t = mk2V2 v p ** {c3 = t.p1  ; s3 = p.p2 ; lock_V2V = <>} ;
  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p q = mkV3 v p q ** {lock_V2A = <>} ;
  mkVQ  v = v ** {lock_VQ = <>} ;
  mkV2Q v p = mk2V2 v p ** {lock_V2Q = <>} ;

  mkAS  v = v ** {lock_AS = <>} ; ---- more moods
  mkA2S v p = mkA2 v p ** {lock_A2S = <>} ;
  mkAV  v p = v ** {c = p.p1 ; s2 = p.p2 ; lock_AV = <>} ;
  mkA2V v p q = mkA2 v p ** {s3 = q.p2 ; c3 = q.p1 ; lock_A2V = <>} ;

---

  mkN = overload {
    mkN : (luz : Str) -> N = regN ;
    mkN : Str -> Gender -> N = \s,g -> {s = (regN s).s ; g = g ; lock_N = <>};
    mkN : (baston,bastones : Str) -> Gender -> N = mk2N
    } ;
  regN : Str -> N ;
  mk2N : (baston,bastones : Str) -> Gender -> N ;
  mascN : N -> N ;
  femN  : N -> N ;


  mkPN = overload {
    mkPN : (Anna : Str) -> PN = regPN ;
    mkPN : (Pilar : Str) -> Gender -> PN = mk2PN
    } ;
  mk2PN  : Str -> Gender -> PN ; -- Juan
  regPN : Str -> PN ;           -- feminine for "-a", otherwise masculine

-- To form a noun phrase that can also be plural,
-- you can use the worst-case function.

  makeNP : Str -> Gender -> Number -> NP ; 

  mkA = overload {
    mkA : (util : Str) -> A  = regA ;
    mkA : (solo,sola,solos,solas,solamente : Str) -> A = mk5A ;
    mkA : (bueno : A) -> (mejor : A) -> A = mkADeg ;
    } ;

  mk5A : (solo,sola,solos,solas, solamente : Str) -> A ;
  regA : Str -> A ;
  mkADeg : A -> A -> A ;
  compADeg : A -> A ;
  regADeg : Str -> A ;
  prefA : A -> A ;
  prefixA = prefA ;

  mkV = overload {
    mkV : (pagar : Str) -> V = regV ;
    mkV : (mostrar,muestro : Str) -> V = regAltV ;
    mkV : Verbum -> V = verboV
    } ;
  regV : Str -> V ;
  regAltV : (mostrar,muestro : Str) -> V ;
  verboV : Verbum -> V ;

  mkV2 = overload {
    mkV2 : Str -> V2 = \s -> dirV2 (regV s) ;
    mkV2 : V -> V2 = dirV2 ;  
    mkV2 : V -> Prep -> V2 = mk2V2
    } ;
  mk2V2  : V -> Prep -> V2 ;
  dirV2 : V -> V2 ;



} ;
