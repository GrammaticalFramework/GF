--1 A Simple Norwegian Resource Morphology
--
-- Aarne Ranta 2002
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains copies of the most usual inflectional patterns
-- as defined in functional morphology (in the Haskell file $RulesSw.hs$).
--
-- We use the parameter types and word classes defined for morphology.

resource MorphoNor = CommonScand, ResNor ** open Prelude, Predef in {

-- genders

oper
  masc  = Utr Masc ;
  fem   = Utr Fem ;
  neutr = Neutr ;

-- type synonyms

  Subst : Type = {s : Number => Species => Case => Str} ;
  Adj = Adjective ;

-- nouns

  mkSubstantive : (_,_,_,_ : Str) -> Subst = 
    \dreng, drengen, drenger, drengene -> 
    {s = nounForms dreng drengen drenger drengene} ;

  extNGen : Str -> Gender = \s -> case last s of {
    "n" => Utr Masc ;
    "a" => Utr Fem ;
    _   => Neutr
    } ; 

  nBil : Str -> Subst = \bil ->
    mkSubstantive bil (bil + "en") (bil + "er")  (bil + "erne") **
      {h1 = masc} ;

  nUke : Str -> Subst = \uke ->
    mkSubstantive uke (init uke + "a") (uke + "r")  (uke + "ne") **
      {h1 = fem} ;

  nHus : Str -> Subst = \hus ->
    mkSubstantive hus (hus + "et") hus  (hus + "ene") **
      {h1 = neutr} ;

  nHotell : Str -> Subst = \hotell ->
    mkSubstantive hotell (hotell + "et") (hotell + "er")  (hotell + "ene") **
      {h1 = neutr} ;




-- adjectives

  mkAdject : (_,_,_,_,_ : Str) -> Adj = 
    \stor,stort,store,storre,storst -> {s = table {
       AF (APosit (Strong SgUtr )) c    => mkCase c stor ; 
       AF (APosit (Strong SgNeutr)) c   => mkCase c stort ;
       AF (APosit _) c                  => mkCase c store ;
       AF ACompar c                     => mkCase c storre ;
       AF (ASuperl SupStrong) c         => mkCase c storst ;
       AF (ASuperl SupWeak) c           => mkCase c (storst + "e")
       }
    } ;

  aRod : Str -> Adj = \rod -> 
    mkAdject rod (rod + "t") (rod + "e") (rod + "ere") (rod + "est") ;

  aAbstrakt : Str -> Adj = \abstrakt -> 
    mkAdject abstrakt abstrakt (abstrakt + "e") (abstrakt + "ere") (abstrakt + "est") ;

  aRask : Str -> Adj = \rask -> 
    mkAdject rask rask (rask + "e") (rask + "ere") (rask + "est") ;

  aBillig : Str -> Adj = \billig -> 
    mkAdject billig billig (billig + "e") (billig + "ere") (billig + "st") ;

-- verbs

  Verbum : Type = {s : VForm => Str} ;

  mkVerb6 : (_,_,_,_,_,_ : Str) -> Verbum = 
    \spise,spiser,spises,spiste,spist,spis -> {s = table {
       VI (VInfin v)       => mkVoice v spise ;
       VF (VPres Act)    => spiser ;
       VF (VPres Pass)   => spises ;
       VF (VPret v)      => mkVoice v spiste ;   --# notpresent
       VI (VSupin v)     => mkVoice v spist ;    --# notpresent
       VI (VPtPret (Strong (SgUtr | SgNeutr)) c) => mkCase c spist ;
       VI (VPtPret _ c)  => case last spist of {
         "a" => mkCase c spist ;
         _   => mkCase c (spist + "e")
         } ;
       VF (VImper v)     => mkVoice v spis
       }
     } ;

  vHusk : Str -> Verbum = \husk -> 
    let huska : Str = husk + "a"  ---- variants {husk + "a" ; husk + "et"} 
    in
    mkVerb6 (husk + "e") (husk + "er") (husk + "es") huska huska husk ;

  vSpis : Str -> Verbum = \spis -> 
    mkVerb6 (spis + "e") (spis + "er") (spis + "es") (spis + "te") (spis + "t") spis ;

  vLev : Str -> Verbum = \lev ->
    let lever = case last lev of {
      "r" => lev ;
      _   => lev + "er"
      }
    in 
    mkVerb6 (lev + "e") lever (lev + "es") (lev + "de") (lev + "d") lev ;

  vBo : Str -> Verbum = \bo -> 
    mkVerb6 bo (bo + "r") (bo + "es") (bo + "dde") (bo + "dd") bo ;

  regVerb : Str -> Str -> Verbum = \spise, spiste -> 
    let
      spis = init spise ;
      te   = dp 2 spiste
    in
    case te of {
      "te" => vSpis spis ;
      "de" => case last spise of {
         "e" => vLev spis ;
         _   => vBo spise
         } ;
      _  => vHusk spis 
      } ;


-- For $Numeral$.

param DForm = ental  | ton  | tiotal  ;

oper 
  LinDigit = {s : DForm => CardOrd => Str} ;

  cardOrd : Str -> Str -> CardOrd => Str = \tre,tredje ->
    table {
      NCard _ => tre ;
      NOrd a  => tredje ---- a
      } ;

  cardReg : Str -> CardOrd => Str = \syv ->
    cardOrd syv (syv + case last syv of {
      "n" => "de" ;
      "e" => "nde" ;
      _   => "ende"
      }) ;
      

  mkTal : (x1,_,_,_,x5 : Str) -> LinDigit = 
    \två, tolv, tjugo, andra, tolfte -> 
    {s = table {
           ental  => cardOrd två andra ; 
           ton    => cardOrd tolv tolfte ;
           tiotal => cardReg tjugo
           }
     } ;

  numPl : (CardOrd => Str) -> {s : CardOrd => Str ; n : Number} = \n ->
    {s = n ; n = Pl} ;

  invNum : CardOrd = NCard Neutr ;


}
