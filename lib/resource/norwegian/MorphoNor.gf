--1 A Simple Norwegian Resource Morphology
--
-- Aarne Ranta 2002
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains copies of the most usual inflectional patterns
-- as defined in functional morphology (in the Haskell file $RulesSw.hs$).
--
-- We use the parameter types and word classes defined for morphology.

resource MorphoNor = open Predef, Prelude, TypesNor in {

-- Danish grammar source: http://users.cybercity.dk/~nmb3879/danish.html

-- genders

oper
  masc  = Utr Masc ;
  fem   = Utr NoMasc ;
  neutr = Neutr ;

-- nouns

oper
  mkSubstantive : (_,_,_,_ : Str) -> {s : SubstForm => Str} =
  \dreng, drengen, drenger, drengene -> {s = table {
     SF Sg Indef c => mkCase dreng ! c ;
     SF Sg Def   c => mkCase drengen ! c ;
     SF Pl Indef c => mkCase drenger ! c ;
     SF Pl Def   c => mkCase drengene ! c
     }
   } ;

  mkCase : Str -> Case => Str = \bil -> table {
    Nom => bil ;
    Gen => bil + "s"   --- but: hus --> hus
    } ;

  extNGen : Str -> NounGender = \s -> case last s of {
    "n" => NUtr Masc ;
    "a" => NUtr NoMasc ;
    _   => NNeutr
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

  mkAdjective : (_,_,_,_,_ : Str) -> Adj = 
    \stor,stort,store,storre,storst -> {s = table {
       AF (Posit (Strong (ASg (Utr _)))) c => mkCase stor ! c ; 
       AF (Posit (Strong (ASg Neutr))) c => mkCase stort ! c ;
       AF (Posit _) c                    => mkCase store ! c ;
       AF Compar c                       => mkCase storre ! c ;
       AF (Super SupStrong) c            => mkCase storst ! c ;
       AF (Super SupWeak) c              => mkCase (storst + "e") ! c
       }
    } ;

  aRod : Str -> Adj = \rod -> 
    mkAdjective rod (rod + "t") (rod + "e") (rod + "ere") (rod + "est") ;

  aAbstrakt : Str -> Adj = \abstrakt -> 
    mkAdjective abstrakt abstrakt (abstrakt + "e") (abstrakt + "ere") (abstrakt + "est") ;

  aRask : Str -> Adj = \rask -> 
    mkAdjective rask rask (rask + "e") (rask + "ere") (rask + "est") ;

  aBillig : Str -> Adj = \billig -> 
    mkAdjective billig billig (billig + "e") (billig + "ere") (billig + "st") ;

extractPositive : Adj -> {s : AdjFormPos => Case => Str} = \adj ->
  {s = \\a,c => adj.s ! (AF (Posit a) c)} ;

-- verbs

  mkVerb : (_,_,_,_,_,_ : Str) -> Verbum = 
    \spise,spiser,spises,spiste,spist,spis -> {s = table {
       VI (Inf v)       => mkVoice v spise ;
       VF (Pres Act)    => spiser ;
       VF (Pres Pass)   => spises ;
       VF (Pret v)      => mkVoice v spiste ;
       VI (Supin v)     => mkVoice v spist ;
       VI (PtPret (Strong (ASg _)) c) => mkCase spist ! c ;
       VI (PtPret _ c)  => case last spist of {
         "a" => mkCase spist ! c ;
         _   => mkCase (spist + "e") ! c
         } ;
       VF (Imper v)     => mkVoice v spis
       }
     } ;

  mkVoice : Voice -> Str -> Str = \v,s -> case v of {
    Act => s ;
    Pass => s + case last s of {
      "s" => "es" ;
      _   => "s"
      }
    } ;
  
  vHusk : Str -> Verbum = \husk -> 
    let huska : Str = husk + "a"  ---- variants {husk + "a" ; husk + "et"} 
    in
    mkVerb (husk + "e") (husk + "er") (husk + "es") huska huska husk ;

  vSpis : Str -> Verbum = \spis -> 
    mkVerb (spis + "e") (spis + "er") (spis + "es") (spis + "te") (spis + "t") spis ;

  vLev : Str -> Verbum = \lev -> 
    mkVerb (lev + "e") (lev + "er") (lev + "es") (lev + "de") (lev + "d") lev ;

  vBo : Str -> Verbum = \bo -> 
    mkVerb bo (bo + "r") (bo + "es") (bo + "dde") (bo + "dd") bo ;

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

  irregVerb : (drikke,drakk,drukket : Str) -> Verbum = 
    \drikke,drakk,drukket ->
    mkVerb drikke (drikke + "r")  (drikke + "s") drakk drukket (init drikke) ; 

-- pronouns

oper jag_32 : ProPN =
 {s = table {
    PNom => "jeg" ;
    PAcc => "meg" ;
    PGen (ASg (Utr Masc)) => "min" ;
    PGen (ASg (Utr NoMasc)) => "mi" ;
    PGen (ASg Neutr) => "mitt" ;
    PGen APl => "mine"
    } ;
  h1 = Utr Masc ; -- Masc doesn't matter
  h2 = Sg ;
  h3 = P1
  } ;

oper du_33 : ProPN =
 {s = table {
    PNom => "du" ;
    PAcc => "deg" ;
    PGen (ASg (Utr Masc)) => "din" ;
    PGen (ASg (Utr NoMasc)) => "di" ;
    PGen (ASg Neutr) => "ditt" ;
    PGen APl => "dine"
    } ;
  h1 = Utr Masc ;
  h2 = Sg ;
  h3 = P2
  } ;

oper han_34 : ProPN =
 {s = table {
    PNom => "han" ;
    PAcc => "ham" ;
    PGen (ASg (Utr _)) => "hans" ;
    PGen (ASg Neutr) => "hans" ;
    PGen APl => "hans"
    } ;
  h1 = masc ;
  h2 = Sg ;
  h3 = P3
  } ;
oper hon_35 : ProPN =
 {s = table {
    PNom => "hun" ;
    PAcc => "henne" ;
    PGen (ASg (Utr _)) => "hennes" ;
    PGen (ASg Neutr) => "hennes" ;
    PGen APl => "hennes"
    } ;
  h1 = fem ;
  h2 = Sg ;
  h3 = P3
  } ;

oper vi_36 : ProPN =
 {s = table {
    PNom => "vi" ;
    PAcc => "oss" ;
    PGen (ASg (Utr _)) => "vår" ;
    PGen (ASg Neutr) => "vårt" ;
    PGen APl => "våre"
    } ;
  h1 = Utr Masc ;
  h2 = Pl ;
  h3 = P1
  } ;

oper ni_37 : ProPN =
 {s = table {
    PNom => "dere" ;
    PAcc => "dere" ;
    PGen _ => "deres"
    } ;
  h1 = Utr Masc ;
  h2 = Pl ;
  h3 = P2
  } ;

oper de_38 : ProPN =
 {s = table {
    PNom => "de" ;
    PAcc => "dem" ;
    PGen _ => "deres"
    } ;
  h1 = Utr Masc ;
  h2 = Pl ;
  h3 = P3
  } ;

oper De_38 : ProPN =
 {s = table {
    PNom => "Dere" ;
    PAcc => "Dere" ;
    PGen _ => "Deres"
    } ;
  h1 = Utr Masc ;
  h2 = Sg ;
  h3 = P2
  } ;

oper den_39 : ProPN =
 {s = table {
    PNom => "de" ;
    PAcc => "den" ;
    PGen _ => "dens"
    } ;
  h1 = Utr Masc ;
  h2 = Sg ;
  h3 = P3
  } ;

oper det_40 : ProPN =
 {s = table {
    PNom => "det" ;
    PAcc => "det" ;
    PGen _ => "dets"
    } ;
  h1 = Neutr ;
  h2 = Sg ;
  h3 = P3
  } ;


-- from Numerals

param DForm = ental  | ton  | tiotal  ;

oper mkTal : Str -> Str -> Str -> {s : DForm => Str} = 
  \två -> \tolv -> \tjugo -> 
  {s = table {ental => två ; ton => tolv ; tiotal => tjugo}} ;
oper regTal : Str -> {s : DForm => Str} = \fem -> mkTal fem (fem + "ten") (fem + "ti") ;

}
