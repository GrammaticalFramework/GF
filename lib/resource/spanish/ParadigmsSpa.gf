--# -path=.:../romance:../abstract:../../prelude

--1 Spanish Lexical Paradigms
--
-- Aarne Ranta 2003
--
-- This is an API to the user of the resource grammar 
-- for adding lexical items. It give shortcuts for forming
-- expressions of basic categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $resource.Abs.gf$. 
--
-- The main difference with $MorphoIta.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, not stems, as string
-- arguments of the paradigms.
--
-- The following modules are presupposed:

resource ParadigmsSpa = 
  open Prelude, (Types = TypesSpa), SyntaxSpa, MorphoSpa, 
  ResourceSpa in {

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Bool      : Type ;
  Gender    : Type ;

  masculine : Gender ;
  feminine  : Gender ;

-- To abstract over number names, we define the following.

  Number    : Type ;

  singular : Number ;
  plural   : Number ;

-- To abstract over case names, we define the following. (Except for
-- some pronouns, the accusative is equal to the nominative, the
-- dative is formed by the preposition "a", and the genitive by the
-- preposition "di".)

  Case    : Type ;

  nominative : Case ;
  accusative : Case ;
  dative     : Case ;
  genitive   : Case ;

  prep_a   : Case ;
  prep_de  : Case ;


--2 Nouns

-- Worst case: two forms (singular + plural),
-- and the gender.

  mkN  : (_,_ : Str) -> Gender -> N ;   -- uomo, uomini, masculine

-- Often it is enough with one form. If it ends with
-- "o" or "a", no gender is needed; if with something else, 
-- the gender must be given.

  nVino  : Str -> N ;           -- vino  (, vinos, masculine)
  nRana  : Str -> N ;           -- rana  (, ranas, feminine)
  nPilar : Str -> Gender -> N ; -- pilar (, pilares), masculine
  nTram  : Str -> Gender -> N ; -- tram  (, tram), masculine

-- Nouns used as functions need a case and a preposition. The most common is "di".
-- Recall that the prepositions "a", "di", "da", "in", "su", "con" are treated 
-- as part of the case (cf. above).

  funPrep : N -> Preposition -> N2 ;
  funCase : N -> Case -> N2 ;
  funDe   : N -> N2 ;

-- Proper names, with their gender.

  mkPN : Str -> Gender -> PN ; -- Giovanni, masculine

-- On the top level, it is maybe $CN$ that is used rather than $N$, and
-- $NP$ rather than $PN$.

  mkCN  : N -> CN ;
  mkNP  : Str -> Gender -> NP ;


--2 Adjectives

-- Non-comparison one-place adjectives need four forms in the worst case.
-- A parameter tells if they are pre- or postpositions in modification.

  Position : Type ;
  prepos : Position ;  
  postpos : Position ;  

  mkA1 : (solo,sola,soli,sole,solamente : Str) -> Position -> A1 ;

-- Adjectives ending with "o" and "e", and invariable adjectives, 
-- are the most important regular patterns.

  adj1Solo : (solo : Str) -> Bool -> A1 ;
  adj1Util : (a,b : Str) -> Bool -> A1 ;
  adj1Blu  : (blu  : Str) -> Bool -> A1 ;


-- Two-place adjectives need a preposition and a case as extra arguments.

  mkA2 : A1 -> Preposition -> Case -> A2 ;  -- divisibile per

-- Comparison adjectives may need two adjectives, corresponding to the
-- positive and other forms. 

  mkADeg : (buono, migliore : A1) -> ADeg ;

-- In the completely regular case, the comparison forms are constructed by
-- the particle "più".

  aSolo : Str -> Position -> ADeg ;    -- lento (, più lento)
  aUtil : Str -> Str -> Position -> ADeg ;    -- grave (, più grave)
  aBlu  : Str -> Position -> ADeg ;    -- blu   (, più blu)

-- On top level, there are adjectival phrases. The most common case is
-- just to use a one-place adjective. 

  apSolo : Str -> Position -> AP ;
  apUtil : Str -> Str -> Position -> AP ;
  apBlu  : Str -> Position -> AP ;


--2 Verbs
--
-- The fragment only has present tense so far, but in all persons.
-- The worst case needs nine forms (and is not very user-friendly).

----  mkV : (_,_,_,_,_,_,_,_,_ : Str) -> V ;

-- These are examples of standard conjugations. Other conjugations
-- can be extracted from the Italian functional morphology, which has full
-- "Bescherelle" tables.

  vAmar   : Str -> V ;
  vVender : Str -> V ;
----  vFinire  : Str -> V ;
----  vCorrere : (_,_ : Str) -> V ;

-- The verbs 'be' and 'have' are special.

  vSer   : V ;
  vHaber : V ;

-- Two-place verbs, and the special case with direct object. Notice that
-- a particle can be included in a $V$.

  mkV2  : V -> Preposition -> Case -> V2 ;
  tvDir : V -> V2 ;  

-- The idiom with "avere" and an invariable noun, such as "paura", "fame",
-- and a two-place variant with "di" + complement.

  averCosa   : Str -> V ;
  averCosaDe : Str -> V2 ;

-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.
  Bool   = Prelude.Bool ;
  Gender = SyntaxSpa.Gender ;
  Case = SyntaxSpa.Case ;
  Number = SyntaxSpa.Number ;

  masculine = Masc ;
  feminine  = Fem ;
  nominative = Types.nominative ;
  accusative = Types.accusative ;
  genitive = Types.genitive ;
  dative = Types.dative ;

  singular = Types.singular ;
  plural = Types.plural ;
  prep_a = Types.CPrep P_a ;
  prep_de = Types.CPrep Types.P_de ;

  singular = Types.singular ;
  plural = Types.plural ;

  mkN a b g = mkCNomIrreg a b g ** {lock_N = <>} ;

  nVino = \vino -> mkCNom (nomVino vino) masculine ** {lock_N = <>} ;
  nRana = \rana -> mkCNom (nomVino rana) feminine ** {lock_N = <>} ;
  nPilar = \x,g -> mkCNom (nomPilar x) g ** {lock_N = <>} ;
  nTram = \tram,g -> mkCNom (nomTram tram) g ** {lock_N = <>} ;
    
  funPrep = \n,p -> n ** complement p ** {lock_N2 = <>} ;
  funCase = \n,p -> n ** complementCas p ** {lock_N2 = <>} ;
  funDe a = funGen a ** {lock_N2 = <>} ;
  mkPN s g = mkProperName s g ** {lock_PN = <>} ;
  mkCN = UseN ;
  mkNP s g = UsePN (mkPN s g) ;

  Position = Bool ;
  prepos = adjPre ;
  postpos = adjPost ;
  mkA1 = \x,y,z,u,v,p -> mkAdjective (mkAdj x y z u v) p ** {lock_A1 = <>} ;
  adj1Solo = \a,p -> mkAdjective (adjSolo a) p ** {lock_A1 = <>} ;
  adj1Util = \a,b,p -> mkAdjective (adjUtil a b) p ** {lock_A1 = <>} ;
  adj1Blu = \a,p -> mkAdjective (adjBlu a) p ** {lock_A1 = <>} ;
  mkA2 = \a,p,c -> mkAdjCompl a postpos {s2 = p ; c = c} ** {lock_A2 = <>} ;
  mkADeg = \b,m -> mkAdjDegr (mkAdjComp b.s m.s) b.p ** {lock_ADeg = <>} ; 
  aSolo = \a,p -> mkAdjDegrLong (adjSolo a) p ** {lock_ADeg = <>} ;
  aUtil = \a,b,p -> mkAdjDegrLong (adjUtil a b) p ** {lock_ADeg = <>} ;
  aBlu = \a,p -> mkAdjDegrLong (adjBlu a) p ** {lock_ADeg = <>} ;
  apSolo a p = adj1Solo a p ** {lock_AP = <>} ;
  apUtil a b p = adj1Util a b p ** {lock_AP = <>} ;
  apBlu a p = adj1Blu a p ** {lock_AP = <>} ;

--  mkV a b c d e f g h i = mkVerbPres a b c d e f g h i ** {lock_V = <>} ;
  vAmar x = verbPres (zurrar_3 x) AHabere ** {lock_V = <>} ;
  vVender x = verbPres (vender_4 x) AHabere ** {lock_V = <>} ;
--  vFinire x = verbFinire x ** {lock_V = <>} ;
--  vCorrere x y = verbCorrere x y ** {lock_V = <>} ;
  vSer = verbSer ** {lock_V = <>} ;
  vHaber = verbHaber ** {lock_V = <>} ;
  mkV2 a b c = mkTransVerb a b c ** {lock_V2 = <>} ;
  tvDir c = mkTransVerbDir c ** {lock_V2 = <>} ;

  averCosa = \fame -> 
    {s = let {aver = vHaber.s} in \\v => aver ! v ++ fame} **
    {aux=AHabere ; lock_V = <>} ;
  averCosaDe = \fame -> mkV2 (averCosa fame) [] prep_de ** {lock_TV = <>} ;

}
