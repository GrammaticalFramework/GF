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
    MorphoSpa, 
    BeschSpa,
    CatSpa in {

  flags optimize=all ;
    coding=utf8 ;

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

  accusative : Prep ; -- direct object
  genitive   : Prep ; -- preposition "de" and its contractions
  dative     : Prep ; -- preposition "a" and its contractions

  mkPrep : overload {
    mkPrep : Str -> Prep ; -- other preposition
    mkPrep : Str -> Prep -> Prep ; -- compound prepositions, e.g. "antes de", made as mkPrep "antes" genitive
  } ;


--2 Nouns

  mkN : overload {

-- The regular function takes the singular form and the gender,
-- and computes the plural and the gender by a heuristic. 
-- The heuristic says that the gender is feminine for nouns
-- ending with "a" or "z", and masculine for all other words.
-- Nouns ending with "a", "o", "e" have the plural with "s",
-- those ending with "z" have "ces" in plural; all other nouns
-- have "es" as plural ending. The accent is not dealt with.

    mkN : (luz : Str) -> N ; -- predictable; feminine for "-a"/"-z", otherwise masculine

-- A different gender can be forced.

    mkN : Str -> Gender -> N ; -- force gender

-- The worst case has two forms (singular + plural) and the gender.

    mkN : (baston,bastones : Str) -> Gender -> N ; -- worst case

    mkN : N -> Str -> N ; -- compound, e.g. "número" + "de teléfono"
    } ;


--3 Compound nouns 
--
-- Some nouns are ones where the first part is inflected as a noun but
-- the second part is not inflected. e.g. "número de teléfono". 
-- They could be formed in syntax, but we give a shortcut here since
-- they are frequent in lexica.

  compN : N -> Str -> N ; -- compound, e.g. "número" + "de teléfono"


--3 Relational nouns 
-- 
-- Relational nouns ("fille de x") need a case and a preposition. 

  mkN2 : N -> Prep -> N2 ; -- relational noun with preposition

-- The most common cases are the genitive "de" and the dative "a", 
-- with the empty preposition.

  deN2 : N -> N2 ; -- relational noun with preposition "de"
  aN2  : N -> N2 ; -- relational noun with preposition "a"

-- Three-place relational nouns ("la connessione di x a y") need two prepositions.

  mkN3 : N -> Prep -> Prep -> N3 ; -- prepositions for two complements


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
    mkPN : (Anna : Str) -> PN ; -- feminine for "-a"
    mkPN : (Pilar : Str) -> Gender -> PN ; -- force gender
    mkPN : N -> PN ;   -- gender from noun
    } ;


--2 Adjectives

  mkA : overload {

-- For regular adjectives, all forms are derived from the
-- masculine singular. The types of adjectives that are recognized are
-- "alto", "fuerte", "util". Comparison is formed by "mas".

    mkA : (util : Str) -> A ; -- predictable adjective

-- Some adjectives need the feminine form separately.

    mkA : (espanol,espanola : Str) -> A ;

-- One-place adjectives compared with "mas" need five forms in the worst
-- case (masc and fem singular, masc plural, adverbial).

    mkA : (solo,sola,solos,solas,solamente : Str) -> A ; -- worst-case

-- In the worst case, two separate adjectives are given: 
-- the positive ("bueno"), and the comparative ("mejor"). 

    mkA : (bueno : A) -> (mejor : A) -> A ; -- special comparison (default with "mas")

    mkA : (blanco : A) -> (hueso : Str) -> A -- noninflecting component after the adjective
    } ;

-- The functions above create postfix adjectives. To switch
-- them to prefix ones (i.e. ones placed before the noun in
-- modification, as in "buen vino"), the following function is
-- provided.

  prefixA : A -> A ; -- adjective before noun (default after noun)


--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Prep -> A2 ; -- e.g. "casado" + dative


--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. 

  mkAdv : Str -> Adv ;

-- Some appear next to the verb (e.g. "siempre").

  mkAdV : Str -> AdV ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;

  mkAdN : Str -> AdN ;
  

--2 Verbs

  mkV : overload {

-- Regular verbs are ones inflected like "cortar", "deber", or "vivir".
-- The regular verb function is the first conjugation ("ar") recognizes
-- the variations corresponding to the patterns
-- "actuar, cazar, guiar, pagar, sacar". The module $BeschSpa$ gives
-- the complete set of "Bescherelle" conjugations.

    mkV : (pagar : Str) -> V ; -- regular in "-ar", "-er", ".ir"

-- Verbs with vowel alternatition in the stem - easiest to give with
-- two forms, e.g. "mostrar"/"muestro".

    mkV : (mostrar,muestro : Str) -> V ; -- regular with vowel alternation

-- Most irreguler verbs are found in $IrregSpa$. If this is not enough,
-- the module $BeschSpa$ gives all the patterns of the "Bescherelle"
-- book. To use them in the category $V$, wrap them with the function

    mkV : Verbum -> V ; -- import verb constructed with BeschSpa

    mkV : V -> Str -> V ; -- particle verb
    } ;

-- To form reflexive verbs:

  reflV : V -> V ; -- reflexive verb

-- Verbs with a deviant passive participle: just give the participle
-- in masculine singular form as second argument.

  special_ppV : V -> Str -> V ; -- deviant past participle, e.g. abrir - abierto



--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). 

  mkV2 : overload {
    mkV2 : Str -> V2 ;  -- regular, direct object
    mkV2 : V -> V2 ;    -- direct object
    mkV2 : V -> Prep -> V2 -- other object
    } ;


-- You can reuse a $V2$ verb in $V$.

  v2V : V2 -> V ; --%

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3 : overload {
    mkV3 : V -> V3 ;                -- donner (+ accusative + dative)    
    mkV3 : V -> Prep -> V3 ;        -- placer (+ accusative) + dans
    mkV3 : V -> Prep -> Prep -> V3  -- parler + dative + genitive
    } ;
  dirV3    : V -> Prep -> V3 ;           -- e.g. dar,(accusative),a
  dirdirV3 : V -> V3 ;                   -- e.g. dar,(dative),(accusative)

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ; --%
  mkVS  : V -> VS ;

  mkVV  : V -> VV ;  -- plain infinitive: "quiero hablar"
  deVV  : V -> VV ;  -- "terminar de hablar"
  aVV   : V -> VV ;  -- "aprender a hablar"

  mkVA  : V -> VA ;

  mkVQ  : V -> VQ ;
  mkV2Q : V -> Prep -> V2Q ;
  mkV2S  : overload {
    mkV2S : V -> V2S ;
    mkV2S : V -> Prep -> V2S ;
    } ;
  mkV2V  : overload {
    mkV2V : V -> V2V ;
    mkV2V : V -> Prep -> Prep -> V2V ;
    } ;
  mkV2A : overload {
    mkV2A : V -> V2A ;
    mkV2A : V -> Prep -> Prep -> V2A ;
    } ;


  mkAS  : A -> AS ; --%
  mkA2S : A -> Prep -> A2S ; --%
  mkAV  : A -> Prep -> AV ; --%
  mkA2V : A -> Prep -> Prep -> A2V ; --%

-- Notice: categories $AS, A2S, AV, A2V$ are just $A$, 
-- and the second argument is given
-- as an adverb. Likewise 
-- $V0$ is just $V$.

  V0 : Type ; --%
  AS, A2S, AV, A2V  : Type ; --%


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

  mkPrep = overload {
    mkPrep : Str -> Prep = \p -> {s = p ; c = Acc ; isDir = False ; lock_Prep = <>} ;
    mkPrep : Str -> Prep -> Prep = \p,c -> {s = p ; c = c.c ; isDir = False ; lock_Prep = <>}
  } ;


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

  makeNP x g n = {s = (pn2np (mk2PN x g)).s; a = agrP3 g n ; hasClit = False ; isPol = False ; isNeg = False} ** {lock_NP = <>} ;

  mk5A a b c d e = 
   compADeg {s = \\_ => (mkAdj a b c d e).s ; isPre = False ; lock_A = <>} ;

  mk2A a b =
   compADeg {s = \\_ => (adjEspanol a b).s ; isPre = False ; lock_A = <>} ;

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
  mkAdN x = ss x ** {lock_AdN = <>} ;


  regV x = -- cortar actuar cazar guiar pagar sacar
    let 
      ar = Predef.dp 2 x ;
      z  = Predef.dp 1 (Predef.tk 2 x) ;
      verb = case ar of {
        "ir" =>  vivir_7 x ;
        "er" =>  deber_6 x ;
        "ar" => case z of {
           "u" => actuar_9 x ;
           "z" => cazar_21 x ;
           "i" => guiar_43 x ;
           "g" => pagar_53 x ;
           "c" => sacar_72 x ;
           _   => cortar_5 x
            } ;
         _ => Predef.error ("regular verb infinitive must end ar/ir/er, not satisfied by" ++ x)
         }
    in verbBesch verb ** {vtyp = VHabere ; p = [] ; lock_V = <>} ;

  reflV v = v ** {vtyp = VRefl} ;

  verboV ve = verbBesch ve ** {vtyp = VHabere ; p = [] ; lock_V = <>} ;

  reflVerboV : Verbum -> V = \ve -> reflV (verboV ve) ;

  special_ppV ve pa = {
    s = table {
      VPart g n => (adjSolo pa).s ! AF g n ;
      p => ve.s ! p
      } ;
    lock_V = <> ;
    p = ve.p ;
    vtyp = VHabere
    } ;

  regAltV x y = case x of {
    _ + "ar" => verboV (regAlternV x y) ;
    _  => verboV (regAlternVEr x y) 
    } ;

    

  mk2V2 v p = lin V2 (v ** {c2 = p}) ;
  dirV2 v = mk2V2 v accusative ;
  v2V v = lin V v ;

  mmkV3    : V -> Prep -> Prep -> V3 ;  -- parler, à, de
  mmkV3 v p q = v ** {c2 = p ; c3 = q ; lock_V3 = <>} ;
  dirV3 v p = mmkV3 v accusative p ;
  dirdirV3 v = mmkV3 v dative accusative ;

  mmkV2 : V -> Prep -> V2 ;
  mmkV2 v p = v ** {c2 = p ; lock_V2 = <>} ;

  mkV3 = overload {
    mkV3 : V -> V3 = dirdirV3 ;               -- donner,_,_
    mkV3 : V -> Prep -> V3 = dirV3 ;          -- placer,_,sur
    mkV3 : V -> Prep -> Prep -> V3 = mmkV3    -- parler, à, de
    } ;

  mkV2S = overload {
    mkV2S : V -> V2S = \v -> mmkV2 v dative ** {mn,mp = Indic ; lock_V2S = <>} ;
    mkV2S : V -> Prep -> V2S = \v,p -> mmkV2 v p ** {mn,mp = Indic ; lock_V2S = <>} ;
    } ;
  mkV2V = overload {
    mkV2V : V -> V2V                 = \v -> mmkV3 v accusative dative ** {lock_V2V = <>} ;
    mkV2V : V -> Prep -> Prep -> V2V = \v,p,q -> mmkV3 v p q ** {lock_V2V = <>} ;
    } ;

  mkV2A = overload {
    mkV2A : V -> V2A                 = \v -> mmkV3 v accusative dative ** {lock_V2A = <>} ;
    mkV2A : V -> Prep -> Prep -> V2A = \v,p,q -> mmkV3 v p q ** {lock_V2A = <>} ;
    } ;


  V0 : Type = V ;
  AS, AV : Type = A ;
  A2S, A2V : Type = A2 ;

  mkV0  v = v ** {lock_V0 = <>} ;
  mkVS  v = v ** {m = \\_ => Indic ; lock_VS = <>} ;  ---- more moods

  mkVV  v = v ** {c2 = complAcc ; lock_VV = <>} ;
  deVV  v = v ** {c2 = complGen ; lock_VV = <>} ;
  aVV  v = v ** {c2 = complDat ; lock_VV = <>} ;

  mkVA  v = v ** {lock_VA = <>} ;

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
    mkN : (baston,bastones : Str) -> Gender -> N = mk2N ;
    mkN : N -> Str -> N = compN ;
    } ;
  regN : Str -> N ;
  mk2N : (baston,bastones : Str) -> Gender -> N ;
  mascN : N -> N ;
  femN  : N -> N ;


  mkPN = overload {
    mkPN : (Anna : Str) -> PN = regPN ;
    mkPN : (Pilar : Str) -> Gender -> PN = mk2PN ;
    mkPN : N -> PN = \n -> lin PN {s = n.s ! Sg ; g = n.g} ;
    } ;
  mk2PN  : Str -> Gender -> PN ; -- Juan
  regPN : Str -> PN ;           -- feminine for "-a", otherwise masculine

-- To form a noun phrase that can also be plural,
-- you can use the worst-case function.

  makeNP : Str -> Gender -> Number -> NP ; 

  mkA = overload {
    mkA : (util : Str) -> A  = regA ;
    mkA : (espanol,espanola : Str) -> A  = mk2A ;
    mkA : (solo,sola,solos,solas,solamente : Str) -> A = mk5A ;
    mkA : (bueno : A) -> (mejor : A) -> A = mkADeg ;
    mkA : (blanco : A) -> (hueso : Str) -> A = \blanco,hueso -> blanco ** 
      { s = \\x,y => blanco.s ! x ! y ++ hueso } ;
    } ;

  mk5A : (solo,sola,solos,solas,solamente : Str) -> A ;
  mk2A : (espanol,espanola : Str) -> A ;
  regA : Str -> A ;
  mkADeg : A -> A -> A ;
  compADeg : A -> A ;
  regADeg : Str -> A ;
  prefA : A -> A ;
  prefixA = prefA ;

  mkV = overload {
    mkV : (pagar : Str) -> V = \s -> case s of {
     far + "se" => reflV (regV far) ;
      _ => regV s
      } ;
    mkV : (mostrar,muestro : Str) -> V = regAltV ;
    mkV : Verbum -> V = verboV ;

    mkV : V -> Str -> V = \v,p -> v ** {p = p} ;  ---- to recognize particles in dict, not yet in lincat V
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
