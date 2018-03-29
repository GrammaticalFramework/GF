--# -path=.:../romance:../common:../abstract:../../prelude

--1 Portuguese Lexical Paradigms
--
--
-- This is an API for the user of the resource grammar for adding
-- lexical items. It gives functions for forming expressions of open
-- categories: nouns, adjectives, verbs.
--
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$.
--
-- The main difference with $MorphoPor.gf$ is that the types referred
-- to are compiled resource grammar types. We have moreover had the
-- design principle of always having existing forms, rather than
-- stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the
-- following: first we give a handful of patterns that aim to cover
-- all regular cases. Then we give a worst-case function $mkC$, which
-- serves as an escape to construct the most irregular words of type
-- $C$. For verbs, there is a fairly complete list of irregular verbs
-- in [``IrregPor`` ../../portuguese/IrregPor.gf].

resource ParadigmsPor =
  open
    (Predef=Predef),
    Prelude,
    MorphoPor,
    BeschPor,
    CatPor in {

  flags optimize=all ;
        coding=utf8 ;

--2 Parameters
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender : Type ;
  Gender = MorphoPor.Gender ;

  masculine : Gender ;
  masculine = Masc ;

  feminine  : Gender ;
  feminine = Fem ;

-- To abstract over number names, we define the following.

  Number : Type ;
  Number = MorphoPor.Number ;

  singular : Number ;
  singular = Sg ;

  plural   : Number ;
  plural = Pl ;

-- Prepositions used in many-argument functions are either strings
-- (including the 'accusative' empty string) or strings that
-- amalgamate with the following word (the 'genitive' "de" and the
-- 'dative' "a").

  accusative : Prep ; -- direct object
  accusative = complAcc ** {lock_Prep = <>} ;

  genitive   : Prep ; -- preposition "de" and its contractions
  genitive = complGen ** {lock_Prep = <>} ;

  dative     : Prep ; -- preposition "a" and its contractions
  dative = complDat ** {lock_Prep = <>} ;

  mkPrep = overload {
    mkPrep : Str -> Prep = -- other preposition
      \p -> {s = p ; c = Acc ; isDir = False ; lock_Prep = <>} ;
    mkPrep : Str -> Prep -> Prep =
      -- compound prepositions, e.g. "antes de", made as mkPrep
      -- "antes" genitive
      \p,c -> {s = p ; c = c.c ; isDir = False ; lock_Prep = <>}
  } ;


--2 Nouns

  regN : Str -> N ;
  regN x = mkNomReg x ** {lock_N = <>} ;

  femN  : N -> N ;
  femN x = {s = x.s ; g = feminine ; lock_N = <>} ;

  mascN : N -> N ;
  mascN x = {s = x.s ; g = masculine ; lock_N = <>} ;

  mk2N : (bastão, bastões : Str) -> Gender -> N ;
  mk2N x y g = mkNounIrreg x y g ** {lock_N = <>} ;

  --- [] update this docstring
  -- The regular function takes the singular form and the gender, and
  -- computes the plural and the gender by a heuristic.  The heuristic
  -- says that the gender is feminine for nouns ending with "a" or
  -- "z", and masculine for all other words.  Nouns ending with "a",
  -- "o", "e" have the plural with "s", those ending with "z" have
  -- "ces" in plural; all other nouns have "es" as plural ending. The
  -- accent is not dealt with.
  mkN = overload {
    -- predictable; "-a" for feminine, otherwise Masculine
    mkN : (luz : Str) -> N = regN ;
    -- force plural
    mkN : (alemão, alemães : Str) -> N =
      \s,p -> regN s ** {s = numForms s p} ;
    -- force gender
    mkN : Str -> Gender -> N =
      \s,g -> regN s ** {g = g};
    -- The worst case has two forms (singular + plural) and the
    -- gender.
    mkN : (bastão,bastões : Str) -> Gender -> N = mk2N
    } ;

--3 Compound nouns
--
-- Some nouns are ones where the first part is inflected as a noun but
-- the second part is not inflected. e.g. "número de telefone".  They
-- could be formed in syntax, but we give a shortcut here since they
-- are frequent in lexica.

  compN : N -> Str -> N ; -- compound, e.g. "número" + "de telefone"
  compN x y = {s = \\n => x.s ! n ++ y ; g = x.g ; lock_N = <>} ;

--3 Relational nouns
--
-- Relational nouns ("filha de x") need a case and a preposition.

  mkN2 : N -> Prep -> N2 ; -- relational noun with prepositio
  mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;

-- The most common cases are the genitive "de" and the dative "a",
-- with the empty preposition.

  deN2 : N -> N2 ; -- relational noun with preposition "de"
  deN2 n = mkN2 n genitive ;

  aN2  : N -> N2 ; -- relational noun with preposition "a"
  aN2 n = mkN2 n dative ;

-- Three-place relational nouns ("a conexão de x a y") need two
-- prepositions.
  mkN3 : N -> Prep -> Prep -> N3 ; -- prepositions for two complements
  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;

--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "the old town hall of"). However, $N2$ and
-- $N3$ are purely lexical categories. But you can use the $AdvCN$ and
-- $PrepNP$ constructions to build phrases like this.

--
--3 Proper names and noun phrases
--
-- Proper names need a string and a gender.  The default gender is
-- feminine for names ending with "a", otherwise masculine.

  regPN : Str -> PN ; -- feminine for "-a", otherwise masculine
  regPN x = mk2PN x g where {
    g = case last x of {
      "a" => feminine ;
      _ => masculine
      }
    } ;

  mk2PN  : Str -> Gender -> PN ; -- Pilar
  mk2PN x g = {s = x ; g = g} ** {lock_PN = <>} ;

  mkPN = overload {
    -- feminine for "-a"
    mkPN : (Anna : Str) -> PN = regPN ;
    -- force gender
    mkPN : (Pilar : Str) -> Gender -> PN = mk2PN ;
    -- gender from Noun
    mkPN : N -> PN = \n -> lin PN {s = n.s ! Sg ; g = n.g} ;
    } ;

--2 Adjectives
  compADeg : A -> A ;
  compADeg a = {s = table {Posit => a.s ! Posit ;
                           _ => \\f => "mais" ++
                             a.s ! Posit ! f} ;
                isPre = a.isPre ; lock_A = <>} ;

{-  superlADeg : A -> A ;
  superlADeg a = {s = table {Posit => a.s ! Posit ;
                             Compar => a.s ! Compar ;
                             Superl => a.s ! Compar}} ;
    -}

  -- redundant
--  regADeg : Str -> A ;
--  regADeg a = compADeg (regA a) ;

  regA : Str -> A ;
  regA a = compADeg {s = \\_ => (mkAdjReg a).s ; isPre = False ;
                     lock_A = <>} ;

  mk2A : (espanhol,espanhola : Str) -> A ;
  mk2A a b = compADeg {s = \\_ => (mkAdj2N (mkN a) (mkN b) (b + "mente")).s ; isPre = False ;
                       lock_A = <>} ;

  mk5A : (solo,sola,solos,solas,solamente : Str) -> A ;
  mk5A a b c d e = compADeg {s = \\_ => (mkAdj a b c d e).s ;
                             isPre = False ; lock_A = <>} ;

  mkADeg : A -> A -> A ;
  mkADeg a b = {s = table {Posit => a.s ! Posit ;
                           _ => b.s ! Posit} ;
                isPre = a.isPre ; lock_A = <>} ;


  mkA = overload {

-- For regular adjectives, all forms are derived from the masculine
-- singular. The types of adjectives that are recognized are "alto",
-- "fuerte", "util". Comparison is formed by "mas".
    mkA : (bobo : Str) -> A  = regA ; -- predictable adjective

-- Some adjectives need the feminine form separately.
    mkA : (espanhol,espanhola : Str) -> A  = mk2A ;

-- One-place adjectives compared with "mais" need five forms in the
-- worst case (masc and fem singular, masc plural, adverbial).
    mkA : (bobo,boba,bobos,bobas,bobamente : Str) -> A = mk5A ;

-- In the worst case, two separate adjectives are given: the positive
-- ("bueno"), and the comparative ("mejor").
    -- special comparison with "mais" as default
    mkA : (bom : A) -> (melhor : A) -> A = mkADeg ;
    } ;

-- The functions above create postfix adjectives. To switch them to
-- prefix ones (i.e. ones placed before the noun in modification, as
-- in "bom vinho"), the following function is provided.

    prefixA : A -> A ; -- adjective before noun (default after noun)
    prefixA = prefA ;

    prefA : A -> A ;
    prefA a = {s = a.s ; isPre = True ; lock_A = <>} ;

--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

  mkA2 : A -> Prep -> A2 ; -- e.g. "casado" + dative
  mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;

--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position after
-- the verb.

  mkAdv : Str -> Adv ;
  mkAdv x = ss x ** {lock_Adv = <>} ;

-- Some appear next to the verb (e.g. "sempre").

  mkAdV : Str -> AdV ;
  mkAdV x = ss x ** {lock_AdV = <>} ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  mkAdN : Str -> AdN ;
  mkAdN x = ss x ** {lock_AdN = <>} ;

--2 Verbs

  regV : Str -> V ;
  regV v = -- cortar actuar cazar guiar pagar sacar
    let
      xr = Predef.dp 2 v ; -- -ar
      z  = Predef.dp 1 (Predef.tk 2 v) ; -- i in -iar
      verb = case xr of {
        "ir" => case z of {
          "g" => redigir_52 v ;
          "a" => sair_68 v ;
          "u" => distribuir_73 v ;
          _ => garantir_6 v
          } ;
        "er" => case z of {
          "c" => aquecer_25 v ;
          _ => vender_5 v
            } ;
        "ar" => case z of {
          "e" => recear_15 v ;
          "i" => anunciar_16 v ;
          "o" => perdoar_20 v ;
          "u" => averiguar_21 v ;
          _ => comprar_4 v
          } ;
        "or" => pôr_45 v ;
        _ => comprar_4 v -- hole
        }
    in verboV verb ;

{-  regAltV : (mostrar,muestro : Str) -> V ;
  regAltV x y = case x of {
    _ + "ar" => verboV (regAlternV x y) ;
    _  => verboV (regAlternVEr x y)
    } ;
-}
  verboV : Verbum -> V ;
  verboV ve = verbBesch ve ** {vtyp = VHabere ; p = [] ;
                               lock_V = <>} ;

  mkV = overload {
--- [ ] update
-- Regular verbs are ones inflected like "cortar", "dever", or
-- "partir".  The regular verb function is the first conjugation
-- ("ar") recognizes the variations corresponding to the patterns
-- "actuar, cazar, guiar, pagar, sacar". The module $BeschPor$ gives
-- the complete set of "Bescherelle" conjugations.

    mkV : (pagar : Str) -> V = \s -> case s of {
      chamar + "-se" => reflV (regV chamar) ;
      _ => regV s
      } ; -- regular in "-ar", "-er", "-ir"

-- Verbs with vowel alternation in the stem - easiest to give with two
-- forms, e.g. "mostrar"/"muestro".
  --  mkV : (mostrar,muestro : Str) -> V = regAltV ;
  -- rm'ed as is uncommon in Por

-- Most irregular verbs are found in $IrregPor$. If this is not
-- enough, the module $BeschPor$ gives all the patterns of the
-- "Bescherelle" book. To use them in the category $V$, wrap them with
-- the function

    mkV : Verbum -> V = -- import verb constructed with BeschPor
      verboV ;

    -- particle verb
    mkV : V -> Str -> V =
      \v,p -> v ** {p = p} ;  -- to recognize particles in dict, not
                              -- yet in lincat V
    } ;

-- To form reflexive verbs:

  reflV : V -> V ; -- reflexive verb
  reflV v = v ** {vtyp = VRefl} ;

-- Verbs with a deviant passive participle: just give the participle
-- in masculine singular form as second argument.

  special_ppV : V -> Str -> V ;
  -- deviant past participle, e.g. abrir - aberto
  special_ppV ve pa = {
    s = table {
      VPart g n => (adjPreto pa).s ! AF g n ;
      p => ve.s ! p
      } ;
    lock_V = <> ;
    p = ve.p ;
    vtyp = VHabere
    } ;


--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with
-- direct object.  (transitive verbs).
  dirV2 : V -> V2 ;
  dirV2 v = mk2V2 v accusative ;

  mk2V2  : V -> Prep -> V2 ;
  mk2V2 v p = lin V2 (v ** {c2 = p}) ;

  mkV2 = overload {
    mkV2 : Str -> V2 = -- regular, direct object
      \s -> dirV2 (regV s) ;
    mkV2 : V -> V2 = dirV2 ; -- direct object
    mkV2 : V -> Prep -> V2 = mk2V2 -- other object
    } ;

-- You can reuse a $V2$ verb in $V$.

  v2V : V2 -> V ;
  v2V v = lin V v ;

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3 = overload {
    mkV3 : V -> V3 = dirdirV3 ; -- donner (+ accusative + dative)
    mkV3 : V -> Prep -> V3 = dirV3 ; -- placer (+ accusative) + dans
    mkV3 : V -> Prep -> Prep -> V3 = mmkV3 -- parler + dative + genitive
    } ;

  dirV3    : V -> Prep -> V3 ;
  -- e.g. dar,(accusative),a
  dirV3 v p = mmkV3 v accusative p ;

  dirdirV3 : V -> V3 ;
  -- e.g. dar,(dative),(accusative)
  dirdirV3 v = mmkV3 v dative accusative ;

  mmkV3 : V -> Prep -> Prep -> V3 ;
  -- falar a (fulano) de (cicrano)
  mmkV3 v p q = v ** {c2 = p ; c3 = q ; lock_V3 = <>} ;

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ; --%
  mkV0  v = v ** {lock_V0 = <>} ;

  mkVS  : V -> VS ;
  mkVS  v = v ** {m = \\_ => Indic ; lock_VS = <>} ;  ---- more moods

  mkVV  : V -> VV ;
  -- plain infinitive: "quero falar"
  mkVV  v = v ** {c2 = complAcc ; lock_VV = <>} ;

  deVV  : V -> VV ;
  -- "terminar de falar"
  deVV  v = v ** {c2 = complGen ; lock_VV = <>} ;

  aVV   : V -> VV ;
  -- "aprender a falar"
  aVV  v = v ** {c2 = complDat ; lock_VV = <>} ;

  mkVA  : V -> VA ;
  mkVA  v = v ** {lock_VA = <>} ;

  mkVQ  : V -> VQ ;
  mkVQ  v = v ** {lock_VQ = <>} ;

  mkV2Q : V -> Prep -> V2Q ;
  mkV2Q v p = mk2V2 v p ** {lock_V2Q = <>} ;

  mmkV2 : V -> Prep -> V2 ;
  mmkV2 v p = v ** {c2 = p ; lock_V2 = <>} ;

  mkV2S = overload {
    mkV2S : V -> V2S =
      \v -> mmkV2 v dative ** {mn,mp = Indic ; lock_V2S = <>} ;
    mkV2S : V -> Prep -> V2S =
      \v,p -> mmkV2 v p ** {mn,mp = Indic ; lock_V2S = <>} ;
    } ;

  mkV2V = overload {
    mkV2V : V -> V2V =
      \v -> mmkV3 v accusative dative ** {lock_V2V = <>} ;
    mkV2V : V -> Prep -> Prep -> V2V =
      \v,p,q -> mmkV3 v p q ** {lock_V2V = <>} ;
    } ;

  mkV2A = overload {
    mkV2A : V -> V2A =
      \v -> mmkV3 v accusative dative ** {lock_V2A = <>} ;
    mkV2A : V -> Prep -> Prep -> V2A =
      \v,p,q -> mmkV3 v p q ** {lock_V2A = <>} ;
    } ;

  mkAS  : A -> AS ; --%
  mkAS  v = v ** {lock_AS = <>} ; ---- more moods

  mkA2S : A -> Prep -> A2S ; --%
  mkA2S v p = mkA2 v p ** {lock_A2S = <>} ;

  mkAV  : A -> Prep -> AV ; --%
  mkAV  v p = v ** {c = p.p1 ; s2 = p.p2 ; lock_AV = <>} ;

  mkA2V : A -> Prep -> Prep -> A2V ; --%
  mkA2V v p q = mkA2 v p ** {s3 = q.p2 ; c3 = q.p1 ; lock_A2V = <>} ;

-- Notice: $V0$ is just $V$.

  V0 : Type ; --%
  V0 : Type = V ;

-- Notice: categories $AS, A2S, AV, A2V$ are just $A$, and the second
-- argument is given as an adverb.
  AS, A2S, AV, A2V  : Type ; --%
  AS, AV : Type = A ;
  A2S, A2V : Type = A2 ;


  ---
  -- orphan definitions

-- To form a noun phrase that can also be plural,
-- you can use the worst-case function.
  makeNP : Str -> Gender -> Number -> NP ;
  makeNP x g n = {s = (pn2np (mk2PN x g)).s;
                  a = agrP3 g n ;
                  hasClit = False ;
                  isPol = False ;
                  isNeg = False} ** {lock_NP = <>} ;

  reflVerboV : Verbum -> V = \ve -> reflV (verboV ve) ;

} ;
