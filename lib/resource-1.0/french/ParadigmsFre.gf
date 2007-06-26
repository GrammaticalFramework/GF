--# -path=.:../romance:../common:../abstract:../../prelude

--1 French Lexical Paradigms
--
-- Aarne Ranta 2001 - 2006
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoFre.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
-- However, this function should only seldom be needed: we have a
-- separate module [``IrregFre`` ../../french/IrregFre.gf],
-- which covers all irregularly inflected verbs.

resource ParadigmsFre = 
  open 
    (Predef=Predef), 
    Prelude, 
    CommonRomance, 
    ResFre, 
    MorphoFre, 
    CatFre in {

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
-- 'dative' "à").

  accusative : Prep ;
  genitive   : Prep ;
  dative     : Prep ;

  mkPrep : Str -> Prep ;


--2 Nouns

  mkN : overload {

-- The regular function uses heuristics to compute the
-- plural and the gender from the singular. The plural 
-- heuristic currently
-- covers the cases "pas-pas", "prix-prix", "nez-nez", 
-- "bijou-bijoux", "cheveu-cheveux", "plateau-plateaux", "cheval-chevaux".
-- The gender heuristic is less reliable: it treats as feminine all
-- nouns ending with "e" and "ion", all others as masculine.

    mkN : (cheval : Str) -> N ;

-- Adding gender information widens the scope of the regular pattern.

    mkN : (foie : Str) -> Gender -> N ; 

-- In the worst case, both singular and plural forms and the gender are needed. 

    mkN : (oeil,yeux : Str) -> Gender -> N ;

--3 Compound nouns 
--
-- Some nouns are ones where the first part is inflected as a noun but
-- the second part is not inflected. e.g. "numéro de téléphone". 
-- They could be formed in syntax, but we give a shortcut here since
-- they are frequent in lexica.

    mkN : N -> Str -> N
  } ; 




--3 Relational nouns 
-- 
-- Relational nouns ("fille de x") need a case and a preposition. 

  mkN2 : N -> Prep -> N2 ;

-- The most common cases are the genitive "de" and the dative "à", 
-- with the empty preposition.

  deN2 : N -> N2 ;
  aN2  : N -> N2 ;

-- Three-place relational nouns ("la connection de x à y") need two prepositions.

  mkN3 : N -> Prep -> Prep -> N3 ;


--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "la vieille église de"). However, $N2$ and
-- $N3$ are purely lexical categories. But you can use the $AdvCN$
-- and $PrepNP$ constructions to build phrases like this.

-- 
--3 Proper names and noun phrases
--
-- Proper names need a string and a gender. If no gender is given, the
-- feminine is used for strings ending with "e", the masculine for other strings.

  mkPN  : overload {
    mkPN : Str -> PN ;
    mkPN : Str -> Gender -> PN
    } ;



--2 Adjectives

  mkA : overload {

-- For regular adjectives, all forms are derived from the
-- masculine singular. The heuristic takes into account certain
-- deviant endings: "banal-banale-banaux", "chinois-chinoise-chinois", 
-- "heureux-heureuse-heureux", "italien-italienne", "jeune-jeune",
-- "amer-amère", "carré- - -carrément", "joli- - -joliment".

    mkA : (cher : Str) -> A ;

-- Often just the feminine singular is deviant.

    mkA : (sec,seche : Str) -> A ;

-- This is the worst-case paradigm for the positive forms.

    mkA : (banal,banale,banaux,banalement : Str) -> A ;

-- If comparison forms are irregular (i.e. not formed by "plus", e.g.
-- "bon-meilleur"), the positive and comparative can be given as separate
-- adjectives.

    mkA : A -> A -> A
  } ;

-- The functions create by default postfix adjectives. To switch
-- them to prefix ones (i.e. ones placed before the noun in
-- modification, as in "petite maison"), the following function is
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

-- Some appear next to the verb (e.g. "toujours").

  mkAdV : Str -> AdV ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;


--2 Verbs
--
-- Irregular verbs are given in the module $IrregFre$. 
-- If a verb should be missing in that list, the module
-- $BeschFre$ gives all the patterns of the "Bescherelle" book.
-- 
-- Regular verbs are ones with the infinitive "er" or "ir", the
-- latter with plural present indicative forms as "finissons".
-- The regular verb function in the first conjugation recognizes
-- these endings, as well as the variations among
-- "aimer, céder, placer, peser, jeter, placer, manger, assiéger, payer".
--
-- Sometimes, however, it is not predictable which variant of the "er"
-- conjugation is to be selected. Then it is better to use the function
-- that gives the third person singular present indicative and future 
-- (("il") "jette", "jettera") as second argument.

  mkV : overload {
    mkV : (finir : Str) -> V ;
    mkV : (jeter,jette,jettera : Str) -> V ;

-- The $IrregFre$ list gives some verbs as two-place. These verbs can be
-- reused as one-place verbs.

    mkV : V2 -> V
  } ;

-- The function $mkV$ gives the default compound auxiliary "avoir".
-- To change it to "être", use the following function. 

  etreV : V -> V ;

-- This function turns a verb into reflexive, which implies the auxiliary "être".

  reflV : V -> V ;


--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). 

  mkV2 = overload {
    mkV2 : V -> V2 = dirV2 ;  
    mkV2 : V -> Prep -> V2 = mmkV2
  } ;


--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3 : overload {
    mkV3 : V -> V3 ;                -- donner,_,_
    mkV3 : V -> Prep -> V3 ;        -- placer,_,dans
    mkV3 : V -> Prep -> Prep -> V3  -- parler, à, de
    } ;

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ;
  mkVS  : V -> VS ;
  mkV2S : V -> Prep -> V2S ;
  mkVV  : V -> VV ;  -- plain infinitive: "je veux parler"
  deVV  : V -> VV ;  -- "j'essaie de parler"
  aVV   : V -> VV ;  -- "j'arrive à parler"
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
  AS, A2S, AV, A2V : Type ;

--.
--2 Definitions of the paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.


  Gender = MorphoFre.Gender ; 
  Number = MorphoFre.Number ;
  masculine = Masc ;
  feminine = Fem ;
  singular = Sg ;
  plural = Pl ;

  Preposition = Compl ;
  accusative = complAcc ** {lock_Prep = <>} ;
  genitive = complGen ** {lock_Prep = <>} ;
  dative = complDat ** {lock_Prep = <>} ;
  mkPrep p = {s = p ; c = Acc ; isDir = False ; lock_Prep = <>} ;

  --- obsolete
  Preposition : Type ;
  mkPreposition : Str -> Preposition ;
  mkPreposition = mkPrep ;

  regGenN : Str -> Gender -> N ;
  regN : Str -> N ;
  mk2N  : (oeil,yeux : Str) -> Gender -> N ;
  mk2N x y g = mkCNomIrreg x y g ** {lock_N = <>} ;
  regN x = regGenN x g where {
    g = case <x : Str> of {
     _ + ("e" | "ion") => Fem ;
     _ => Masc
     } 
    } ;
  regGenN x g = mkNomReg x g ** {lock_N = <>} ;
  compN : N -> Str -> N ;
  compN x y = {s = \\n => x.s ! n ++ y ; g = x.g ; lock_N = <>} ;

  mkN = overload {
    mkN : Str -> N = regN ;
    mkN : Str -> Gender -> N = regGenN ; 
    mkN : (oeil,yeux : Str) -> Gender -> N = mk2N ;
    mkN : N -> Str -> N = compN 
  } ; 


  mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;
  deN2 n = mkN2 n genitive ;
  aN2 n = mkN2 n dative ;
  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;

  regPN x = mk2PN x g where {
    g = case last x of {
      "e" => feminine ;
      _ => masculine
      }
    } ;

  mkPN = overload {
    mkPN : Str -> PN = regPN ;
    mkPN : Str -> Gender -> PN = \x,g -> {s = x ; g = g} ** {lock_PN = <>} ;
    } ;

  mk4A a b c d = compADeg {s = \\_ => (mkAdj a c b d).s ; isPre = False ; lock_A = <>} ;
  regA a = compADeg {s = \\_ => (mkAdjReg a).s ; isPre = False ; lock_A = <>} ;
  prefA a = {s = a.s ; isPre = True ; lock_A = <>} ;

  mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;

  mkA = overload {
    mkA : Str -> A = regA ;
    mkA : (sec,seche : Str) -> A = \sec,seche -> mk4A sec seche (sec + "s") (seche + "ment") ; 
    mkA : (banal,banale,banaux,banalement : Str) -> A = mk4A ;
    mkA : A -> A -> A = mkADeg
  };

  prefixA a = {s = a.s ; isPre = True ; lock_A = <>} ;

  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;

  regV x = let v = vvf (mkVerbReg x) in {s = v ; vtyp = VHabere ; lock_V = <>} ;
  reg3V x y z = let v = vvf (mkVerb3Reg x y z) in {s = v ; vtyp = VHabere ; lock_V = <>} ;
  etreV v = {s = v.s ; vtyp = VEsse ; lock_V = <>} ;
  reflV v = {s = v.s ; vtyp = VRefl ; lock_V = <>} ;

  mmkV3 v p q = v ** {c2 = p ; c3 = q ; lock_V3 = <>} ;
  dirV3 v p = mmkV3 v accusative p ;
  dirdirV3 v = dirV3 v dative ;

  mkV3 = overload {
    mkV3 : V -> V3 = dirdirV3 ;               -- donner,_,_
    mkV3 : V -> Prep -> V3 = dirV3 ;          -- placer,_,sur
    mkV3 : V -> Prep -> Prep -> V3 = mmkV3    -- parler, à, de
    } ;

  V0 : Type = V ;
  V2S, V2V, V2Q : Type = V2 ;
  AS, AV : Type = A ;
  A2S, A2V : Type = A2 ;

  mkV0  v = v ** {lock_V0 = <>} ;
  mkVS  v = v ** {m = \\_ => Indic ; lock_VS = <>} ;  ---- more moods
  mkV2S v p = mmkV2 v p ** {mn,mp = Indic ; lock_V2S = <>} ;
  mkVV  v = v ** {c2 = complAcc ; lock_VV = <>} ;
  deVV  v = v ** {c2 = complGen ; lock_VV = <>} ;
  aVV  v = v ** {c2 = complDat ; lock_VV = <>} ;
  mkV2V v p t = mmkV2 v p ** {c3 = t.p1  ; s3 = p.p2 ; lock_V2V = <>} ;
  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p q = mmkV3 v p q ** {lock_V2A = <>} ;
  mkVQ  v = v ** {lock_VQ = <>} ;
  mkV2Q v p = mmkV2 v p ** {lock_V2Q = <>} ;

  mkAS  v = v ** {lock_AS = <>} ; ---- more moods
  mkA2S v p = mkA2 v p ** {lock_A2S = <>} ;
  mkAV  v p = v ** {c = p.p1 ; s2 = p.p2 ; lock_AV = <>} ;
  mkA2V v p q = mkA2 v p ** {s3 = q.p2 ; c3 = q.p1 ; lock_A2V = <>} ;

--------------------------- obsolete

  mkNP : Str -> Gender -> Number -> NP ; 
  mkNP x g n = {s = (pn2np {s=x;g= g}).s; a = agrP3 g n ; hasClit = False} ** {lock_NP = <>} ;
  regPN : Str -> PN ; 
  mk2PN : Str -> Gender -> PN = \x,g -> {s = x ; g = g} ** {lock_PN = <>} ;

  mkADeg : A -> A -> A ;
  compADeg : A -> A ;

  regA : Str -> A ;
  mk4A : (banal,banale,banaux,banalement : Str) -> A ;

  prefA : A -> A ;

  mkADeg a b = 
    {s = table {Posit => a.s ! Posit ; _ => b.s ! Posit} ; isPre = a.isPre ; lock_A = <>} ;
  compADeg a = 
    {s = table {Posit => a.s ! Posit ; _ => \\f => "plus" ++ a.s ! Posit ! f} ; 
     isPre = a.isPre ;
     lock_A = <>} ;
  prefA a = {s = a.s ; isPre = True ; lock_A = <>} ;

  mkV = overload {
    mkV : Str -> V = regV ;
    mkV : (jeter,jette,jettera : Str) -> V = reg3V ;
    mkV : V2 -> V = v2V
  } ;

  regV : Str -> V ;
  reg3V : (jeter,jette,jettera : Str) -> V ;

  mmkV2 : V -> Prep -> V2 ;
  mmkV2 v p = v ** {c2 = p ; lock_V2 = <>} ;
  dirV2 : V -> V2 = \v -> mmkV2 v accusative ;
  v2V : V2 -> V ;
  v2V v = v ** {lock_V = <>} ;

  mmkV3    : V -> Prep -> Prep -> V3 ;  -- parler, à, de
  dirV3    : V -> Prep -> V3 ;          -- donner,_,à
  dirdirV3 : V -> V3 ;                  -- donner,_,_


} ;
