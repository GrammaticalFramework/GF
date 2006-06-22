--# -path=.:../scandinavian:../abstract:../../prelude

--1 Swedish Lexical Paradigms
--
-- Aarne Ranta 2003
--
-- This is an API to the user of the resource grammar 
-- for adding lexical items. It give shortcuts for forming
-- expressions of basic categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoSwe.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, not stems, as string
-- arguments of the paradigms.
--
-- The following modules are presupposed:

resource ParadigmsSwe = open (Predef=Predef), Prelude, MorphoSwe, SyntaxSwe, ResourceSwe in {

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender  : Type ;
  utrum   : Gender ;
  neutrum : Gender ;

  Sex  : Type ;

  masculine    : Sex ;
  nonmasculine : Sex ;

-- To abstract over case names, we define the following.

  Case  : Type ;

  nominative : Case ;
  genitive   : Case ;

-- To abstract over number names, we define the following.
  Number  : Type ;

  singular : Number ;
  plural   : Number ;



--2 Nouns

-- Worst case: give all nominative forms and the gender.
-- The genitive is formed automatically, even when the nominative
-- ends with an "s".

  mkN  : (_,_,_,_ : Str) -> Gender -> Sex -> N ; 
                                 -- man, mannen, män, männen

-- Here are some common patterns, corresponding to school-gramamr declensions.
-- Except $nPojke$, $nKarl$, and $nMurare$, 
-- they are defined to be $nonmasculine$, which means that they don't create
-- the definite adjective form with "e" but with "a".

  nApa    : Str -> N ;   -- apa    (apan, apor, aporna) ; utrum
  nBil    : Str -> N ;   -- bil    (bilen, bilar, bilarna) ; utrum
  nKarl   : Str -> N ;   -- karl   (karlen, karlar, karlarna) ; utrum ; masculine
  nPojke  : Str -> N ;   -- pojke  (pojken, pojkar, pojkarna) ; utrum ; masculine
  nNyckel : Str -> N ;   -- nyckel (nyckeln, nycklar, nycklarna) ; utrum
  nRisk   : Str -> N ;   -- risk   (risken, risker, riskerna) ; utrum
  nDike   : Str -> N ;   -- dike   (diket, diken, dikena) ; neutrum
  nRep    : Str -> N ;   -- rep    (repet, rep, repen) ; neutrum
  nPapper : Str -> N ;   -- papper (pappret, papper, pappren) ; neutrum
  nMurare : Str -> N ;   -- murare (muraren, murare, murarna) ; utrum ; masculine
  nKikare : Str -> N ;   -- kikare (kikaren, kikare, kikarna) ; utrum

-- Nouns used as functions need a preposition. The most common ones are "av",
-- "på", and "till". A preposition is a string.

  mkN2   : N -> Str -> N2 ;
  funAv   : N -> N2 ;
  funPaa  : N -> N2 ;
  funTill : N -> N2 ;

-- Proper names, with their possibly
-- irregular genitive. The regular genitive is  "s", omitted after "s".

  mkPN  : (_,_ : Str) -> Gender -> Sex -> PN ;  -- Karolus, Karoli
  pnReg : Str -> Gender -> Sex -> PN ;          -- Johan,Johans ; Johannes, Johannes
  pnS   : Str -> Gender -> Sex -> PN ;          -- "Burger King(s)"

-- On the top level, it is maybe $CN$ that is used rather than $N$, and
-- $NP$ rather than $PN$.

  mkCN  : N -> CN ;
  mkNP  : (Karolus, Karoli : Str) -> Gender -> NP ;

  npReg : Str -> Gender -> NP ;   -- Johann, Johanns


--2 Adjectives

-- Non-comparison one-place adjectives need four forms in the worst case:
-- strong singular, weak singular, plural.

  mkA : (_,_,_,_ : Str) -> A ; -- liten, litet, lilla, små

-- Special cases needing one form each are: regular adjectives,
-- adjectives with unstressed "e" in the last syllable, those
-- ending with "n" as a further special case, and invariable
-- adjectives.

  adjReg    : Str -> A ;          -- billig (billigt, billiga, billiga)
  adjNykter : Str -> A ;          -- nykter (nyktert, nyktra, nyktra) 
  adjGalen  : Str -> A ;          -- galen  (galet, galna, galna) 
  adjInvar  : Str -> A ;          -- bra

-- Two-place adjectives need a preposition and a case as extra arguments.

  mkA2    : A -> Str -> A2 ;  -- delbar, med
  mkA2Reg : Str  -> Str -> A2 ;  -- 

-- Comparison adjectives may need the three four forms for the positive case, plus
-- three more forms for the comparison cases.

  mkADeg : (liten, litet, lilla, sma, mindre, minst, minsta : Str) -> ADeg ;

-- Some comparison adjectives are completely regular.

  aReg : Str -> ADeg ;

-- On top level, there are adjectival phrases. The most common case is
-- just to use a one-place adjective. The variation in $adjGen$ is taken
-- into account.

  apReg : Str -> AP ;

--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position not
-- before the verb. Some can be preverbal (e.g. "alltid").

  mkAdv : Str -> Adv ;
  mkAdvPre : Str -> Adv ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ;
  mkAdS : Str -> AdS ;

-- Prepositional phrases are another productive form of adverbials.

  mkPP : Str -> NP -> Adv ;


--2 Verbs
--
-- The fragment only has present tense so far.
-- The worst case needs three forms: the infinitive, the indicative, and the
-- imperative.

  Voice: Type;

  passive : Voice;
  active: Voice;

  mkV : (_,_,_,_,_,_ : Str) -> V ;   -- vara, är, var; trivas, trivs, trivs

-- The main conjugations need one string each.

  vKoka   : Str -> V ;          -- tala (talar, tala)
  vSteka  : Str -> V ;          -- leka (leker, lek)
----  vBo     : Str -> V ;          -- bo   (bor, bo)

----  vAndas  : Str -> V ;          -- andas [all forms the same: also "slåss"]
----  vTrivas : Str -> V ;          -- trivas (trivs, trivs)

-- The verbs 'be' and 'have' are special.

  vVara  : V ;
  vHa    : V ;

-- Particle verbs are formed by putting together a verb and a particle.
-- If the verb already has a particle, it is replaced by the new one.

  mkPartV : V -> Str -> V ;     -- stänga av ;

-- Two-place verbs, and the special case with direct object. 

  mkV2     : V -> Str -> V2 ;   -- tycka, om
  tvDir    : V -> V2 ;          -- gilla

-- Ditransitive verbs.

  mkV3     : V -> Str -> Str -> V3 ;   -- prata, med, om
  v3Dir    : V -> Str -> V3 ;          -- ge,_,till
  v3DirDir : V -> V3 ;                 -- ge,_,_

-- Sentence complement verbs.

  mkVS     : V -> VS ;                 -- säga (att ...)

-- Verb phrase complement verbs.

  vvInf    : V -> VV ;                 -- orka (spela)
  vvAtt    : V -> VV ;                 -- gilla (att spela)
  vvBoth   : V -> VV ;                 -- försöka (spela | att spela)
  

-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.

  Gender = SyntaxSwe.Gender ;
  Sex = SyntaxSwe.Sex ;
  Case = SyntaxSwe.Case ;
  Number = SyntaxSwe.Number ;
  Voice = SyntaxSwe.Voice ;

  utrum = Utr ;
  neutrum = Neutr ;
  masculine = Masc ;
  nonmasculine = NoMasc ;
  nominative = Nom ;
  genitive = Gen ;
  singular = Sg ;
  plural = Pl ;

  active = Act;
  passive = Pass;

  mkN = \apa, apan, apor, aporna, g, x -> let
    {nom = table {
       SF Sg Indef _ => apa ;
       SF Sg Def _ => apan ;
       SF Pl Indef _ => apor ;
       SF Pl Def _ => aporna 
       }
    } in 
   {s = \\n,d,c => mkCase c (nom ! SF n d Nom) ;
    g = gensex g x ; lock_N = <>
   } ;

  -- auxiliaries
  mkGenit : Tok -> Tok = \s -> ifTok Tok (Predef.dp 1 s) "s" s (s + "s") ;
  mkCase : Case -> Tok -> Tok = \c,t -> case c of {
    Nom => t ;
    Gen => mkGenit t 
    } ;

  nApa = \apa -> 
    let {apor = Predef.tk 1 apa + "or"} in
    mkN apa (apa + "n") apor (apor + "na") utrum nonmasculine ;

  nBil = \bil -> 
    mkN bil (bil + "en") (bil + "ar") (bil + "arna") utrum nonmasculine ;
  nKarl = \bil -> 
    mkN bil (bil + "en") (bil + "ar") (bil + "arna") utrum masculine ;
  nPojke = \pojke -> 
    let {bil = Predef.tk 1 pojke} in
    mkN pojke (bil + "en") (bil + "ar") (bil + "arna") utrum masculine ;
  nNyckel = \cykel -> 
    let {cykl = Predef.tk 2 cykel + Predef.dp 1 cykel} in
    mkN cykel (cykel + "n") (cykl + "ar") (cykl + "arna") utrum nonmasculine ;
  nRisk = \bil ->
    mkN bil (bil + "en") (bil + "er") (bil + "erna") utrum nonmasculine ;
  nDike = \dike ->
    mkN dike (dike + "t") (dike + "n") (dike + "na") neutrum nonmasculine ;
  nRep = \rep -> 
    mkN rep (rep + "et") rep (rep + "en") neutrum nonmasculine ;
  nPapper = \cykel ->
    let {cykl = Predef.tk 2 cykel + Predef.dp 1 cykel} in
    mkN cykel (cykl + "et") cykel (cykl + "en") neutrum nonmasculine ;
  nMurare = \murare -> 
    let {murar = Predef.tk 1 murare} in
    mkN murare (murar + "en") murare (murar + "na") utrum masculine ;
  nKikare = \murare -> 
    let {murar = Predef.tk 1 murare} in
    mkN murare (murar + "en") murare (murar + "na") utrum nonmasculine ;


  mkN2 x y =  mkFun x y ** {lock_N2 = <>} ;
  funAv = \f -> mkN2 f "av" ;
  funPaa = \f -> mkN2 f "på" ;
  funTill = \f -> mkN2 f "till" ;

  mkPN = \karolus, karoli, g, x -> 
    {s = table {Gen => karoli ; _ => karolus} ; g = gensex g x ; lock_PN = <>} ;
  pnReg = \horst -> 
    mkPN horst (ifTok Tok (Predef.dp 1 horst) "s" horst (horst + "s")) ;
  pnS = \bk ->
    mkPN bk (bk + "s") ;

  mkCN = UseN ;
  mkNP = \a,b,g -> UsePN (mkPN a b g nonmasculine) ; -- gender irrelevant in NP
  npReg = \s,g -> UsePN (pnReg s g nonmasculine) ;

  mkA = \liten, litet, lilla, små -> 
  {s = table {
    Strong (ASg Utr) => \\c => mkCase c liten ;
    Strong (ASg Neutr) => \\c => mkCase c litet ;
    Strong APl => \\c => mkCase c små ;
    Weak (AxSg Masc) => \\c => mkCase c (Predef.tk 1 lilla + "e") ;
    Weak _ => \\c => mkCase c lilla
    } ;
   lock_A = <>
  } ;

  adjReg = \billig -> mkA billig (billig + "t") (billig + "a") (billig + "a") ;
  adjNykter = \nykter -> 
    let {nyktr = Predef.tk 2 nykter + Predef.dp 1 nykter} in
    mkA nykter (nykter + "t") (nyktr + "a") (nyktr + "a") ;
  adjGalen = \galen -> 
    let {gal = Predef.tk 2 galen} in
    mkA galen (gal + "et") (gal + "na") (gal + "na") ;
  adjInvar = \bra -> {s = \\_,_ => bra ; lock_A = <>} ;

  mkA2 = \a,p -> a ** {s2 = p ; lock_A2 = <>} ;
  mkA2Reg = \a -> mkA2 (adjReg a) ;

  mkADeg = \liten, litet, lilla, sma, mindre, minst, minsta -> 
   let {lit = (mkA liten litet lilla sma).s} in
   {s = table {
     AF (Posit f) c => lit ! f ! c ;
     AF Compar c    => mkCase c mindre ;
     AF (Super SupStrong) c => mkCase c minst ;
     AF (Super SupWeak) c => mkCase c minsta --- masculine!
     } ;
    lock_ADeg = <>
   } ;

  aReg = \fin -> mkADeg fin 
    (fin + "t") (fin + "a") (fin + "a") (fin + "are") (fin + "ast") (fin + "aste") ;

  apReg = \s -> UseA (adjReg s) ;

  mkAdv a = advPost a ** {lock_Adv = <>} ;
  mkAdvPre a = advPre a ** {lock_Adv = <>} ;
  mkPP x y = prepPhrase x y ** {lock_Adv = <>} ;
  mkAdA a = ss a ** {lock_AdA = <>} ;
  mkAdS a = ss a ** {lock_AdS = <>} ;

  mkV x y z a b c = mkVerb x y z a b c ** {lock_V = <>} ;
  vKoka = \tala -> vTala (Predef.tk 1 tala)  ** {s1 = [] ; lock_V = <>} ;
  vSteka = \leka -> vLeka (Predef.tk 1 leka)  ** {s1 = [] ; lock_V = <>} ;
----   vBo = \bo -> mkV bo (bo+"r") bo ;
----  vAndas = \andas -> mkV andas andas andas ;
----  vTrivas = \trivas -> 
----    let {trivs = Predef.tk 1 trivas + "s"} in mkV trivas trivs trivs ;
  vVara = verbVara ** {s1 = [] ; lock_V = <>} ;
  vHa = verbHava ** {s1 = [] ; lock_V = <>} ;
  mkPartV v p = {s = v.s ; s1 = p ; lock_V = <>} ;
  mkV2 x y = mkTransVerb x y ** {lock_V2 = <>} ;
  tvDir = \v -> mkV2 v [] ;
  mkV3 x y z = mkDitransVerb x y z ** {lock_V3 = <>} ;
  v3Dir x y = mkV3 x [] y ;
  v3DirDir x = v3Dir x [] ;

  mkVS v  = v ** {lock_VS = <>} ;
  vvInf v = v ** {isAux = True ; lock_VV = <>} ;
  vvAtt v = v ** {isAux = False ; lock_VV = <>} ;
  vvBoth v = v ** {isAux = variants {False ; True} ; lock_VV = <>} ;

  gensex : Gender -> Sex -> NounGender = \g,x -> case g of {
    Utr => NUtr x ;
    _ => NNeutr
    } ;

} ;
