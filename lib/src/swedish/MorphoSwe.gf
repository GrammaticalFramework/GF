--# -path=.:../scandinavian:../common:../../prelude

--1 A Simple Swedish Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsSwe$, which
-- gives a higher-level access to this module.

resource MorphoSwe = CommonScand, ResSwe ** open Prelude, (Predef=Predef) in {


-- Verbs

-- Heuristic to infer all participle forms from one.  

oper
  ptPretAll : Str -> Str * Str = \funnen -> 
    case funnen of {
      ko  +"mmen" => <ko  +"mmet", ko  + "mna"> ; 
      vun  +"nen" => <vun  +"net", vun  + "na"> ; 
      bjud + "en" => <bjud + "et", bjud + "na"> ; 
      se   + "dd" => <se   + "tt", se   +"dda"> ;
      tal  + "ad" => <tal  + "at", tal  +"ade"> ;
      kaen +  "d" => <kaen +  "t", kaen + "da"> ;
      lekt        => <lekt,        lekt +  "a">
      } ;

  ptPretForms : Str -> AFormPos => Case => Str = \funnen -> \\a,c =>  
    let 
      funfun = ptPretAll funnen 
    in
    mkCase c (case a of {
      (Strong (GSg Utr)) => funnen ;
      (Strong (GSg Neutr)) => funfun.p1 ;
      _ => funfun.p2
      }
     ) ;

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

