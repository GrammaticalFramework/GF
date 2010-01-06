--1 A Simple Danish Resource Morphology
--
-- Aarne Ranta 2002
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains copies of the most usual inflectional patterns
-- as defined in functional morphology (in the Haskell file $RulesSw.hs$).
--
-- We use the parameter types and word classes defined for morphology.

resource MorphoDan = CommonScand, ResDan ** open Prelude, Predef in {

oper

-- type synonyms

  Subst : Type = {s : Number => Species => Case => Str} ;
  Adj = Adjective ;

-- nouns

  mkSubstantive : (_,_,_,_ : Str) -> Subst = 
    \dreng, drengen, drenger, drengene -> 
    {s = nounForms dreng drengen drenger drengene} ;

  extNGen : Str -> Gender = \s -> case last s of {
    "n" => Utr ;
    _   => Neutr
    } ; 

  nDreng : Str -> Subst = \dreng ->
    mkSubstantive dreng (dreng + "en") (dreng + "e")  (dreng + "ene") **
      {h1 = Utr} ;

  nBil : Str -> Subst = \bil ->
    mkSubstantive bil (bil + "en") (bil + "er")  (bil + "erne") **
      {h1 = Utr} ;

  nUge : Str -> Subst = \uge ->
    mkSubstantive uge (uge + "n") (uge + "r")  (uge + "rne") **
      {h1 = Utr} ;

  nHus : Str -> Subst = \hus ->
    mkSubstantive hus (hus + "et") hus  (hus + "ene") **
      {h1 = Neutr} ;

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


-- verbs

  Verbum : Type = {s : VForm => Str} ;

  mkVerb6 : (_,_,_,_,_,_ : Str) -> Verbum = 
    \spise,spiser,spises,spiste,spist,spis -> {s = table {
       VI (VInfin v)       => mkVoice v spise ;
       VF (VPres Act)    => spiser ;
       VF (VPres Pass)   => spises ;
       VF (VPret v)      => mkVoice v spiste ;   --# notpresent
       VI (VSupin v)     => mkVoice v spist ;    --# notpresent
       VI (VPtPret (Strong (GSg _)) c) => mkCase c spist ;
       VI (VPtPret _ c)  => mkCase c (spist + "e") ;
       VF (VImper v)     => mkVoice v spis
       }
     } ;

  irregVerb : (drikke,drakk,drukket : Str) -> Verbum = 
    \drikke,drakk,drukket ->
    let
      drikk = init drikke ;
      drikker = case last (init drikke) of {
        "r" => drikk ;
        _   => drikke + "r"
        }
    in 
    mkVerb6 drikke drikker  (drikke + "s") drakk drukket (mkImper drikk) ; 

  regVerb : Str -> Str -> Verbum = \spise, spiste -> 
    let
      spis = init spise ;
      te   = Predef.dp 2 spiste
    in
    case te of {
      "te" => vSpis spis ;
      "de" => case last spise of {
         "e" => vHusk spis ;
         _   => vBo spise
         } ;
      _  => vHusk spis 
      } ;

  vHusk : Str -> Verbum = \husk -> 
    mkVerb6 (husk + "e") (husk + "er") (husk + "es") (husk + "ede") (husk + "et") 
      (mkImper husk) ;

  vSpis : Str -> Verbum = \spis -> 
    mkVerb6 (spis + "e") (spis + "er") (spis + "es") (spis + "te") (spis + "t") 
      (mkImper spis) ;

  vBo : Str -> Verbum = \bo -> 
    mkVerb6 bo (bo + "r") (bo + "es") (bo + "ede") (bo + "et") (mkImper bo) ;

-- Remove consonant duplication: "passe - pas"

  mkImper : Str -> Str = \s -> 
    if_then_Str (pbool2bool (Predef.eqStr (last s) (last (init s)))) (init s) s ;

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
    \två, tolv, tjugo, andra, tyvende -> 
    {s = table {
           ental  => cardOrd två andra ; 
           ton    => cardReg tolv  ;
           tiotal => cardOrd tjugo tyvende
           }
     } ;

  numPl : (CardOrd => Str) -> {s : CardOrd => Str ; n : Number} = \n ->
    {s = n ; n = Pl} ;

  invNum : CardOrd = NCard Neutr ;


}
