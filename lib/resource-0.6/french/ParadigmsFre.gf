--# -path=.:../romance:../abstract:../../prelude

--1 French Lexical Paradigms
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
-- The main difference with $MorphoFre.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, not stems, as string
-- arguments of the paradigms.
--
-- The following modules are presupposed:

resource ParadigmsFre = 
  open Prelude, (Types = TypesFre), SyntaxFre, MorphoFre, 
  ResourceFre in {

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender    : Type ;

  masculine : Gender ;
  feminine  : Gender ;

-- To abstract over number names, we define the following.

  singular : Number ;
  plural   : Number ;

-- To abstract over case names, we define the following. (Except for
-- some pronouns, the accusative is equal to the nominative, the
-- dative is formed by the preposition "à", and the genitive by the
-- preposition "de".)

  nominative : Case ;
  accusative : Case ;
  dative     : Case ;
  genitive   : Case ;


--2 Nouns

-- Worst case: two forms (singular + plural),
-- and the gender.

  mkN  : (_,_ : Str) -> Gender -> N ;   -- oeil, yeux, masculine

-- Often it is enough with one form. Some of them have a typical gender.

  nReg    : Str -> Gender -> N ; -- regular, e.g. maison, (maisons,) feminine
  nEau    : Str -> Gender -> N ; -- eau, (eaux,) feminine
  nCas    : Str -> Gender -> N ; -- cas, (cas,) masculine
  nCheval : Str -> N ;           -- cheval, (chevaux, masculine)

-- Nouns used as functions need a case and a preposition. The most common is "de".

  funPrep : N -> Preposition -> Fun ;
  funCase : N -> Case -> Fun ;
  funDe   : N -> Fun ;

-- Proper names, with their gender.

  mkPN : Str -> Gender -> PN ; -- Jean, masculine

-- On the top level, it is maybe $CN$ that is used rather than $N$, and
-- $NP$ rather than $PN$.

  mkCN  : N -> CN ;
  mkNP  : Str -> Gender -> NP ;


--2 Adjectives

-- Non-comparison one-place adjectives need three forms in the worst case.
-- A parameter tells if they are pre- or postpositions in modification.

  Position : Type ;
  prepos   : Position ;  
  postpos  : Position ;  

  mkAdj1 : (bon, bonne, bons, bien : Str) -> Position -> Adj1 ;

-- Usually it is enough to give the two singular forms. Fully regular adjectives
-- only need the masculine singular form.

  adj1Reg  : Str -> Position -> Adj1 ;
  adj1Cher : (cher, chère : Str) -> Position -> Adj1 ;

-- Two-place adjectives need a preposition and a case as extra arguments.

  mkAdj2 : Adj1 -> Preposition -> Case -> Adj2 ;  -- divisible par

-- Comparison adjectives may need two adjectives, corresponding to the
-- positive and other forms. 

  mkAdjDeg : (bon, meilleur : Adj1) -> AdjDeg ;

-- In the completely regular case, the comparison forms are constructed by
-- the particle "plus".

  aReg : Str -> Position -> AdjDeg ;     -- lent (, plus lent)

-- On top level, there are adjectival phrases. The most common case is
-- just to use a one-place adjective. 

  apReg : Str -> Position -> AP ;


--2 Verbs
--
-- The fragment only has present tense so far, but in all persons.
-- These are examples of standard conjugations are available. The full list
-- of Bescherelle conjugations is given in $MorphoFra.gf$, with all forms
-- (their type is $Verbum$). The present-tense forms can be extracted by the 
-- function $extractVerb$.

  vAimer   : Str -> V ;
  vFinir   : Str -> V ;
  vDormir  : Str -> V ;
  vCourir  : Str -> V ;
  vVenir   : Str -> V ;

  extractVerb : Verbum -> V ;

-- The verbs 'be' and 'have' are special.

  vEtre  : V ;
  vAvoir : V ;

-- Two-place verbs, and the special case with direct object. Notice that
-- a particle can be included in a $V$.

  mkTV  : V -> Preposition -> Case -> TV ;
  tvDir : V -> TV ;  

-- The idiom with "avoir" and an invariable noun, such as "peur", "faim",
-- and a two-place variant with "de" + complement.

  avoirChose   : Str -> V ;
  avoirChoseDe : Str -> TV ;

-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.

  Gender = SyntaxFre.Gender ;

  masculine = Types.Masc ;
  feminine  = Types.Fem ;

  nominative = Types.nominative ;
  accusative = Types.accusative ;
  genitive = Types.genitive ;
  dative = Types.dative ;

  singular = Types.singular ;
  plural = Types.plural ;

  mkN a b c = mkCNomIrreg a b c ** {lock_N = <>} ;

  nEau = \eau -> mkN eau (eau + "z") ;
  nCas = \cas -> mkN cas cas ;
  nReg = \cas -> mkN cas (cas + "s") ;
  nCheval = \cheval -> mkN cheval (Predef.tk 1 cheval + "ux") masculine ; 

  funPrep = \n,p -> n ** complement p ** {lock_Fun = <>} ;
  funCase = \n,p -> n ** complementCas p ** {lock_Fun = <>} ;
  funDe x = funCase x genitive ;
  mkPN s g = mkProperName s g ** {lock_PN = <>} ;
  mkCN = UseN ;
  mkNP s g = UsePN (mkPN s g) ;

  Position = Bool ;
  prepos = adjPre ;
  postpos = adjPost ;
  mkAdj1 = \x,y,z,u,p -> mkAdjective (mkAdj x y z u) p ** {lock_Adj1 = <>} ;
  adj1Reg = \lent -> mkAdj1 lent (lent+"e") (lent+"s") (lent+"ement") ;
  adj1Cher = \cher,chere -> mkAdj1 cher chere (cher+"s") (chere + "ment") ;

  mkAdj2 = \a,p,c -> mkAdjCompl a postpos {s2 = p ; c = c} ** {lock_Adj2 = <>} ;
  mkAdjDeg = \b,m -> mkAdjDegr (mkAdjComp b.s m.s) b.p ** {lock_AdjDeg = <>} ; 
  aReg = \a,p -> mkAdjDegrLong (adj1Reg a p) p ** {lock_AdjDeg = <>} ;
  apReg a p = adj1Reg a p ** {lock_AP = <>} ;

  vAimer = \s -> verbPres (conj1aimer s) ** {lock_V = <>} ;
  vFinir = \s -> verbPres (conj2finir s) ** {lock_V = <>} ;
  vDormir = \s -> verbPres (conj3dormir s) ** {lock_V = <>} ;
  vCourir = \s -> verbPres (conj3courir s) ** {lock_V = <>} ;
  vVenir = \s -> verbPres (conj3tenir s) ** {lock_V = <>} ;
  extractVerb v = verbPres v ** {lock_V = <>} ;
  vEtre = verbEtre ** {lock_V = <>} ;
  vAvoir = verbPres (conjAvoir "avoir") ** {lock_V = <>} ;

  mkTV v p c = mkTransVerb v p c ** {lock_TV = <>} ;
  tvDir v = mkTransVerbDir v ** {lock_TV = <>} ;

  avoirChose = \faim -> 
    {s = let {avoir = vAvoir.s} in \\v => avoir ! v ++ faim} ** {lock_V = <>} ;
  avoirChoseDe = \faim -> mkTV (avoirChose faim) [] genitive ** {lock_TV = <>} ;

}
