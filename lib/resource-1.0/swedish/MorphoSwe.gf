--# -path=.:../scandinavian:../common:../../prelude

--1 A Simple Swedish Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsSwe$, which
-- gives a higher-level access to this module.

resource MorphoSwe = CommonScand, ResSwe ** open Prelude, (Predef=Predef) in {

-- Nouns

oper

  mkNoun : (x1,_,_,x4 : Str) -> Noun =
  \apa,apan,apor,aporna ->  {
    s = nounForms apa apan apor aporna ;
    g = case last apan of {
      "n" => Utr ;
      _ => Neutr
      }
    } ;


-- School declensions.

  decl1Noun : Str -> Noun = \apa -> 
    let ap = init apa in
    mkNoun apa (apa + "n") (ap + "or") (ap + "orna") ;

  decl2Noun : Str -> Noun = \bil ->
    case last bil of {
      "e" => let pojk = init bil in 
             mkNoun bil (bil + "n") (pojk + "ar") (pojk + "arna") ;
      "o" | "u" | "y" => mkNoun bil (bil + "n") (bil + "ar") (bil + "arna") ;
      _ => mkNoun bil (bil + "en") (bil + "ar") (bil + "arna")
      } ;

  decl3Noun : Str -> Noun = \sak ->
    case last sak of {
      "e" => mkNoun sak (sak + "n") (sak +"r") (sak + "rna") ;
      "y" | "å" | "é" => mkNoun sak (sak + "n") (sak +"er") (sak + "erna") ;
      _ => mkNoun sak (sak + "en") (sak + "er") (sak + "erna")
      } ;

  decl4Noun : Str -> Noun = \rike ->
    mkNoun rike (rike + "t") (rike + "n") (rike + "na") ;

  decl5Noun : Str -> Noun = \lik ->
    mkNoun lik (lik + "et") lik (lik + "en") ;


-- Adjectives

adjIrreg : (x1,_,_,x4 : Str) -> Adjective ;
adjIrreg god gott battre bast = 
  mkAdjective god gott (god + "a") (god + "a") battre bast (bast + "a") ;

-- Often it is possible to derive the $Pos Sg Neutr$ form even if the
-- comparison forms are irregular.

adjIrreg3 : (x1,_,x3 : Str) -> Adjective ;
adjIrreg3 ung yngre yngst = adjIrreg ung (ung + "t") yngre yngst ;

-- Some adjectives must be given $Pos Sg Utr$ $Pos Sg Neutr$, and $Pos Pl$,
-- e.g. those ending with unstressed "en".

adjAlmostReg : (x1,_,x3: Str) -> Adjective ;
adjAlmostReg ljummen ljummet ljumma = 
  mkAdjective ljummen ljummet ljumma ljumma 
              (ljumma + "re") (ljumma + "st") (ljumma + "ste") ;

adjReg : Str -> Adjective = \fin -> 
  adjAlmostReg fin (fin + "t") (fin + "a") ;

adj2Reg : Str -> Str -> Adjective = \vid,vitt -> 
  adjAlmostReg vid vitt (vid + "a") ;


-- Verbs

-- A friendly form of $ResScand.mkVerb$, using the heuristic 
-- $ptPretForms$ to infer two forms.

  mkVerb6 : (x1,_,_,_,_,x6 : Str) -> Verb = 
   \finna,finner,finn,fann,funnit,funnen ->
    let 
      funn = ptPretForms funnen ;
      funnet = funn ! Strong SgNeutr ! Nom ;
      funna  = funn ! Strong Plg ! Nom 
    in
    mkVerb finna finner finn fann funnit funnen funnet funna **
   {vtype=VAct} ;

  ptPretForms : Str -> AFormPos => Case => Str = \funnen -> \\a,c =>  
  let 
    funn  = Predef.tk 2 funnen ;
    en    = Predef.dp 2 funnen ;
    funne = init funnen ;
    n     = last funnen ;
    m     = case last funn of {
      "n" => [] ;
      _ => "n"
      } ;
    funna = case en of {
     "en" => case a of {
       (Strong (SgUtr)) => funn + "en" ;
       (Strong (SgNeutr)) => funn + "et" ;
       -- (Weak (AxSg Masc)) => funn + m + "e" ;
       _ => funn + m + "a"
       } ;
     "dd" => case a of {
       (Strong (SgUtr)) => funn + "dd" ;
       (Strong (SgNeutr)) => funn + "tt" ;
       -- (Weak (AxSg Masc)) => funn + "dde" ;
       _ => funn + "dda"
       } ;
     "ad" => case a of {
       (Strong (SgUtr)) => funn + "ad" ;
       (Strong (SgNeutr)) => funn + "at" ;
       _ => funn + "ade"
       } ;
     _ => case n of {
       "d" => case a of {
         (Strong (SgUtr)) => funne + "d" ;
         (Strong (SgNeutr)) => funne + "t" ;
         -- (Weak (AxSg Masc)) => funne + "de" ;
         _ => funne + "da"
         } ;
       _ => case a of {
         (Strong (SgUtr)) => funne + "t" ;
         (Strong (SgNeutr)) => funne + "t" ;
         -- (Weak (AxSg Masc)) => funne + "te" ;
         _ => funne + "ta"
         }
      }
  }
  in 
  mkCase c funna ;

-- This is a general way to form irregular verbs.

  irregVerb : (_,_,_ : Str) -> Verb = \sälja, sålde, sålt -> 
    let
      a = last sälja ; 
      sälj = case a of {
        "a" => init sälja ;
        _ => sälja
        } ;
      er = case a of {
        "a" => "er" ;
        _ => "r"
        } ;
      såld = case Predef.dp 2 sålt of {
        "it" => Predef.tk 2 sålt + "en" ;
        "tt" => Predef.tk 2 sålt + "dd" ;
        _ => init sålt + "d"
        }
    in 
    mkVerb6 sälja (sälj + er) sälj sålde sålt såld ;

  regVerb : (_,_ : Str) -> Verb = \tala,talade -> 
    let 
      ade   = Predef.dp 3 talade ;
      de    = Predef.dp 2 ade ;
      tal   = init tala ;
      ta    = init tal ;
      forms = case ade of {
        "ade" => conj1 tala ;
        "dde" => case last tala of {
          "a" => mkVerb6 tala (tal + "er") tal (ta +"tte") (ta +"tt") (ta +"dd") ;
          _ => conj3 tala
          } ;
        "tte" => mkVerb6 tala (tal + "er") tal (ta +"tte") (ta +"tt") (ta +"tt") ;
        "nde" => mkVerb6 tala (tal + "er") tal (tal +"e") (ta +"t") tal ;
        "rde" => mkVerb6 tala tal tal (tal +"de") (tal +"t") (tal +"d") ;
        _ => case de of {
          "te" => conj2 tala ;
          _    => conj2d tala
          }
        }
      in forms ** {s1 = []} ;


-- school conjugations

conj1 : Str -> Verb = \tala ->
  mkVerb6 tala (tala + "r") tala (tala +"de") (tala +"t") (tala +"d") ;

conj2 : Str -> Verb = \leka ->
  let lek = init leka in
  mkVerb6 leka (lek + "er") lek (lek +"te") (lek +"t") (lek +"t") ;

conj2d : Str -> Verb = \gräva ->
  let gräv = init gräva in
  mkVerb6 gräva (gräv + "er") gräv (gräv +"de") (gräv +"t") (gräv +"d") ;

conj3 : Str -> Verb = \bo ->
  mkVerb6 bo (bo + "r") bo (bo +"dde") (bo +"tt") (bo +"dd") ;

-- for $Structural$

-- For $Numeral$.

param DForm = ental  | ton  | tiotal  ;

oper 
  LinDigit = {s : DForm => CardOrd => Str} ;

  cardOrd : Str -> Str -> CardOrd => Str = \tre,tredje ->
    table {
      NCard _ => tre ;
      NOrd a  => tredje ---- a
      } ;

  cardReg : Str -> CardOrd => Str = \tio ->
    cardOrd tio (tio + "nde") ;

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


} ;

