concrete NumeralSpa of Numeral = CatSpa ** 
  open CommonRomance, ResRomance, MorphoSpa, Prelude in {

lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100 = {s : CardOrd => Str ; n : Number} ;
  Sub1000 = {s : CardOrd => Str ; n : Number} ;
  Sub1000000 = {s : CardOrd => Str ; n : Number} ;

lin num x = x ;

lin n2 = 
  mkTal "dos"    "doce"       "veinte"    "doscientos"    
        "segundo" "duodécimo" "vigésimo" "ducentésimo" ;
lin n3 = 
  mkTal "tres"   "trece"      "treinta"   "trescientos"   
        "terzero" "decimotercero" "trigésimo" "tricentesimo" ;
lin n4 = 
  mkTal "cuatro" "catorce"    "cuarenta"  "cuatrocientos" 
        "cuarto" "decimocuarto" "cuadragésimo" "cuadringentesimo" ;
lin n5 = 
  mkTal "cinco"  "quince"     "cinquenta" "quinientos"
        "quinto" "decimoquinto" "quincuagésimo" "guingentésimo" ;
lin n6 = 
  mkTal "seis"   "dieciséis"  "sesenta"   "seiscientos"
        "sexto" "decimosexto" "sexagésimo" "sexcentesimo" ;
lin n7 = 
  mkTal "siete"  "diecisiéte" "setenta"   "setecientos"
        "séptimo" "decimoséptimo" "septuagésimo" "septingentesimo" ;
lin n8 = 
  mkTal "ocho"   "dieciocho"  "ochenta"   "ochocientos"
        "octavo" "decimoctavo" "octogésimo" "octingentésimo" ;
lin n9 = 
  mkTal "nueve"  "diecinueve" "noventa"   "novecientos"
        "noveno" "decimonoveno" "nonagésimo" "noningentésimo"  ;

lin pot01 = 
  let uno = (mkTal "uno" "once" "diez" "ciento" "primero" "undécimo"
  "décimo" "centésimo").s in
  {s =\\f,g => case <f,g> of {
     <ental pred,_> => [] ;
     <ental _, NCard Fem> => "una" ;
     <hundra False,  NCard _> => "cien" ;
     <hundra True,  NCard Fem> => "ciento" ;
     _ => uno ! f ! g
     } ; 
   n = Pl
   } ;

lin pot0 d = {s = d.s ; n = Pl} ;
lin pot110 = spl ((mkTal "diez" [] [] [] "decimo" [] [] []).s ! ental indip) ;
lin pot111 = spl ((mkTal "once" [] [] [] "undécimo" [] [] []).s ! ental indip) ;
lin pot1to19 d = spl (d.s ! ton) ;
lin pot0as1 n = {s = n.s ! ental indip ; n = n.n} ;
lin pot1 d = spl (d.s ! tiotal) ;
lin pot1plus d e = 
  {s = \\g => d.s ! tiotal ! g ++ y_CardOrd g ++ e.s ! ental indip ! g ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d = spl (d.s ! hundra False) ;
lin pot2plus d e = 
  {s = \\g => d.s ! hundra True ! g ++ e.s ! g ; n = Pl} ;
lin pot2as3 n = n ;
lin pot3 n = spl (\\g => n.s ! NCard Masc ++ mil g) ;
lin pot3plus n m = {s = \\g => n.s ! NCard Masc ++ mil g ++ m.s ! g ; n = Pl} ;

oper
  mkTal : (x1,_,_,_,_,_,_,x8 : Str) -> {s : DForm => CardOrd => Str} =
    \due,dodici,venti,ducento,secondo,dodicesimo,ventesimo,ducentesimo -> 
    {s = \\d,co => case <d,co> of {
       <ental _, NCard _>  => due ;
       <ental _, NOrd g n> => pronForms (adjSolo secondo) g n ;
       <tiotal,  NCard _>  => venti ;
       <tiotal,  NOrd g n> => regCard ventesimo g n ;
       <ton,     NCard _>  => venti ;
       <ton,     NOrd g n> => regCard ventesimo g n ;
       <hundra _,  NCard Masc> => ducento ;
       <hundra _,  NCard Fem> => Predef.tk 2 ducento + "as" ;
       <hundra _,  NOrd g n> => regCard ducentesimo g n
       }
    } ;

  regCard : Str -> Gender -> Number -> Str = \ventesimo ->
    pronForms (adjSolo ventesimo) ;

  spl : (CardOrd => Str) -> {s : CardOrd => Str ; n : Number} = \s -> {
    s = s ;
    n = Pl
    } ;

  mil : CardOrd -> Str = \g ->
    (mkTal "mil" [] [] [] "milésimo" [] [] []).s ! ental indip ! g ;

  y_CardOrd : CardOrd -> Str = \co -> case co of {
    NCard _ => "y" ;
    _ => []
    } ;

param 
  DForm = ental Pred | ton | tiotal | hundra Bool ;
  Pred = pred | indip ;

}
