--1 A Simple Danish Resource Morphology
--
-- Aarne Ranta 2002
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains copies of the most usual inflectional patterns
-- as defined in functional morphology (in the Haskell file $RulesSw.hs$).
--
-- We use the parameter types and word classes defined for morphology.

resource MorphoDan = open Prelude, TypesDan in {

-- Danish grammar source: http://users.cybercity.dk/~nmb3879/danish.html

-- nouns

oper
  mkSubstantive : (_,_,_,_ : Str) -> {s : SubstForm => Str} =
  \dreng, drengen, drenge, drengene -> {s = table {
     SF Sg Indef c => mkCase dreng ! c ;
     SF Sg Def   c => mkCase drengen ! c ;
     SF Pl Indef c => mkCase drenge ! c ;
     SF Pl Def   c => mkCase drengene ! c
     }
   } ;

  mkCase : Str -> Case => Str = \bil -> table {
    Nom => bil ;
    Gen => bil + "s"   --- but: hus --> hus
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

  mkAdjective : (_,_,_,_,_ : Str) -> Adj = 
    \stor,stort,store,storre,storst -> {s = table {
       AF (Posit (Strong (ASg Utr))) c   => mkCase stor ! c ; 
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

-- verbs

  mkVerb : (_,_,_,_,_,_ : Str) -> Verbum = 
    \spise,spiser,spises,spiste,spist,spis -> {s = table {
       VI (Inf v)       => mkVoice v spise ;
       VF (Pres Act)    => spiser ;
       VF (Pres Pass)   => spises ;
       VF (Pret v)      => mkVoice v spiste ;
       VI (Supin v)     => mkVoice v spist ;
       VI (PtPret _ c)  => mkCase spist ! c ; ---- GenNum
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
    mkVerb (husk + "e") (husk + "er") (husk + "es") (husk + "ede") (husk + "et") husk ;

  vSpis : Str -> Verbum = \spis -> 
    mkVerb (spis + "e") (spis + "er") (spis + "es") (spis + "te") (spis + "t") spis ;

  vBo : Str -> Verbum = \bo -> 
    mkVerb bo (bo + "r") (bo + "es") (bo + "ede") (bo + "et") bo ;

-- pronouns

oper jag_32 : ProPN =
 {s = table {
    PNom => "jeg" ;
    PAcc => "mig" ;
    PGen (ASg Utr) => "min" ;
    PGen (ASg Neutr) => "mit" ;
    PGen APl => "mine"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P1
  } ;

oper du_33 : ProPN =
 {s = table {
    PNom => "du" ;
    PAcc => "dig" ;
    PGen (ASg Utr) => "din" ;
    PGen (ASg Neutr) => "dit" ;
    PGen APl => "dine"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P2
  } ;

oper han_34 : ProPN =
 {s = table {
    PNom => "han" ;
    PAcc => "ham" ;
    PGen (ASg Utr) => "hans" ;
    PGen (ASg Neutr) => "hans" ;
    PGen APl => "hans"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P3
  } ;
oper hon_35 : ProPN =
 {s = table {
    PNom => "hun" ;
    PAcc => "hende" ;
    PGen (ASg Utr) => "hendes" ;
    PGen (ASg Neutr) => "hendes" ;
    PGen APl => "hendes"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P3
  } ;

oper vi_36 : ProPN =
 {s = table {
    PNom => "vi" ;
    PAcc => "os" ;
    PGen _ => "vores"
    } ;
  h1 = Utr ;
  h2 = Pl ;
  h3 = P1
  } ;

oper ni_37 : ProPN =
 {s = table {
    PNom => "i" ;
    PAcc => "jer" ;
    PGen _ => "jeres"
    } ;
  h1 = Utr ;
  h2 = Pl ;
  h3 = P2
  } ;

oper de_38 : ProPN =
 {s = table {
    PNom => "de" ;
    PAcc => "dem" ;
    PGen _ => "deres"
    } ;
  h1 = Utr ;
  h2 = Pl ;
  h3 = P3
  } ;

oper De_38 : ProPN =
 {s = table {
    PNom => "De" ;
    PAcc => "Dem" ;
    PGen _ => "Deres"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P2
  } ;

oper den_39 : ProPN =
 {s = table {
    PNom => "den" ;
    PAcc => "den" ;
    PGen _ => "dens"
    } ;
  h1 = Utr ;
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
  \to, tolv, tyve -> 
  {s = table {ental => to ; ton => tolv ; tiotal => tyve}} ;
oper regTal : Str ->  {s : DForm => Str} = \fem -> mkTal fem (fem + "ton") (fem + "tio") ;
  numPl : Str -> {s : Gender => Str ; n : Number} = \n ->
    {s = \\_ => n ; n = Pl} ;


}
