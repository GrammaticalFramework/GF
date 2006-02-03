concrete NumeralSpa of Numeral = CatSpa ** 
  open CommonRomance, ResRomance, MorphoSpa, Prelude in {

-- by Carlos Gonzalia, Chalmers, 1999
-- original source automatically translated to new GF by AR
-- modified by addition of gender and number 30/3/2005
---- ordinals and feminine hundreds missing 3/2/2006 AR


lincat Digit = {inh : Modif ; s : {p1 : DForm ; p2 : Modif} => Str} ;
lincat Sub10 = {s : {p1 : DForm ; p2 : Modif} => Gender => Str ; n : Number} ;
lincat Sub100 = {s : Gender => Str ; n : Number} ;
lincat Sub1000 = {s : Gender => Str ; n : Number} ;
lincat Sub1000000 = {s : Gender => Str ; n : Number} ;

lin num x = {
  s = table {
    NCard g  => x.s ! g ;
    NOrd _ _ => "número" ++ x.s ! Masc ---- TODO
    }
  } ;
lin n2  =
  {inh = mod ; s = table {{p1 = unit ; p2 = mod} => "dos" ; {p1 = unit ; p2 = unmod} => "dos" ; {p1 = unit ; p2 = conj} => "y" ++ "dos" ; {p1 = teen ; p2 = mod} => "doce" ; {p1 = teen ; p2 = unmod} => "doce" ; {p1 = teen ; p2 = conj} => "doce" ; {p1 = ten ; p2 = mod} => "veinti" ; {p1 = ten ; p2 = unmod} => "veinte" ; {p1 = ten ; p2 = conj} => "veinte" ; {p1 = hundred ; p2 = mod} => "doscientos" ; {p1 = hundred ; p2 = unmod} => "doscientos" ; {p1 = hundred ; p2 = conj} => "doscientos"}} ;
lin n3  =
  {inh = conj ; s = table {{p1 = unit ; p2 = mod} => "tres" ; {p1 = unit ; p2 = unmod} => "tres" ; {p1 = unit ; p2 = conj} => "y" ++ "tres" ; {p1 = teen ; p2 = mod} => "trece" ; {p1 = teen ; p2 = unmod} => "trece" ; {p1 = teen ; p2 = conj} => "trece" ; {p1 = ten ; p2 = mod} => "treinta" ; {p1 = ten ; p2 = unmod} => "treinta" ; {p1 = ten ; p2 = conj} => "treinta" ; {p1 = hundred ; p2 = mod} => "trescientos" ; {p1 = hundred ; p2 = unmod} => "trescientos" ; {p1 = hundred ; p2 = conj} => "trescientos"}} ;
lin n4  =
  {inh = conj ; s = table {{p1 = unit ; p2 = mod} => "cuatro" ; {p1 = unit ; p2 = unmod} => "cuatro" ; {p1 = unit ; p2 = conj} => "y" ++ "cuatro" ; {p1 = teen ; p2 = mod} => "catorce" ; {p1 = teen ; p2 = unmod} => "catorce" ; {p1 = teen ; p2 = conj} => "catorce" ; {p1 = ten ; p2 = mod} => "cuarenta" ; {p1 = ten ; p2 = unmod} => "cuarenta" ; {p1 = ten ; p2 = conj} => "cuarenta" ; {p1 = hundred ; p2 = mod} => "cuatrocientos" ; {p1 = hundred ; p2 = unmod} => "cuatrocientos" ; {p1 = hundred ; p2 = conj} => "cuatrocientos"}} ;
lin n5  =
  {inh = conj ; s = table {{p1 = unit ; p2 = mod} => "cinco" ; {p1 = unit ; p2 = unmod} => "cinco" ; {p1 = unit ; p2 = conj} => "y" ++ "cinco" ; {p1 = teen ; p2 = mod} => "quince" ; {p1 = teen ; p2 = unmod} => "quince" ; {p1 = teen ; p2 = conj} => "quince" ; {p1 = ten ; p2 = mod} => "cincuenta" ; {p1 = ten ; p2 = unmod} => "cincuenta" ; {p1 = ten ; p2 = conj} => "cincuenta" ; {p1 = hundred ; p2 = mod} => "quinientos" ; {p1 = hundred ; p2 = unmod} => "quinientos" ; {p1 = hundred ; p2 = conj} => "quinientos"}} ;
lin n6  =
  {inh = conj ; s = table {{p1 = unit ; p2 = mod} => "seis" ; {p1 = unit ; p2 = unmod} => "seis" ; {p1 = unit ; p2 = conj} => "y" ++ "seis" ; {p1 = teen ; p2 = mod} => "dieciseis" ; {p1 = teen ; p2 = unmod} => "dieciseis" ; {p1 = teen ; p2 = conj} => "dieciseis" ; {p1 = ten ; p2 = mod} => "sesenta" ; {p1 = ten ; p2 = unmod} => "sesenta" ; {p1 = ten ; p2 = conj} => "sesenta" ; {p1 = hundred ; p2 = mod} => "seiscientos" ; {p1 = hundred ; p2 = unmod} => "seiscientos" ; {p1 = hundred ; p2 = conj} => "seiscientos"}} ;
lin n7  =
  {inh = conj ; s = table {{p1 = unit ; p2 = mod} => "siete" ; {p1 = unit ; p2 = unmod} => "siete" ; {p1 = unit ; p2 = conj} => "y" ++ "siete" ; {p1 = teen ; p2 = mod} => "diecisiete" ; {p1 = teen ; p2 = unmod} => "diecisiete" ; {p1 = teen ; p2 = conj} => "diecisiete" ; {p1 = ten ; p2 = mod} => "setenta" ; {p1 = ten ; p2 = unmod} => "setenta" ; {p1 = ten ; p2 = conj} => "setenta" ; {p1 = hundred ; p2 = mod} => "setecientos" ; {p1 = hundred ; p2 = unmod} => "setecientos" ; {p1 = hundred ; p2 = conj} => "setecientos"}} ;
lin n8  =
  {inh = conj ; s = table {{p1 = unit ; p2 = mod} => "ocho" ; {p1 = unit ; p2 = unmod} => "ocho" ; {p1 = unit ; p2 = conj} => "y" ++ "ocho" ; {p1 = teen ; p2 = mod} => "dieciocho" ; {p1 = teen ; p2 = unmod} => "dieciocho" ; {p1 = teen ; p2 = conj} => "dieciocho" ; {p1 = ten ; p2 = mod} => "ochenta" ; {p1 = ten ; p2 = unmod} => "ochenta" ; {p1 = ten ; p2 = conj} => "ochenta" ; {p1 = hundred ; p2 = mod} => "ochocientos" ; {p1 = hundred ; p2 = unmod} => "ochocientos" ; {p1 = hundred ; p2 = conj} => "ochocientos"}} ;
lin n9  =
  {inh = conj ; s = table {{p1 = unit ; p2 = mod} => "nueve" ; {p1 = unit ; p2 = unmod} => "nueve" ; {p1 = unit ; p2 = conj} => "y" ++ "nueve" ; {p1 = teen ; p2 = mod} => "diecinueve" ; {p1 = teen ; p2 = unmod} => "diecinueve" ; {p1 = teen ; p2 = conj} => "diecinueve" ; {p1 = ten ; p2 = mod} => "noventa" ; {p1 = ten ; p2 = unmod} => "noventa" ; {p1 = ten ; p2 = conj} => "noventa" ; {p1 = hundred ; p2 = mod} => "novecientos" ; {p1 = hundred ; p2 = unmod} => "novecientos" ; {p1 = hundred ; p2 = conj} => "novecientos"}} ;
lin pot01  =
  {s = table {{p1 = unit ; p2 = mod} => uno ; {p1 = unit ; p2 = unmod}
  => uno ; {p1 = unit ; p2 = conj} => yuno ; {p1 = teen ; p2 = mod} =>
  uno ; {p1 = teen ; p2 = unmod} => uno ; {p1 = teen ; p2 = conj} =>
  yuno ; {p1 = ten ; p2 = mod} => uno ; {p1 = ten ; p2 = unmod} => uno
  ; {p1 = ten ; p2 = conj} => yuno ; {p1 = hundred ; p2 = mod} => 
  \\_ => "ciento" ; {p1 = hundred ; p2 = unmod} => \\_ => "cien" ; {p1 = hundred ; p2 = conj} => yuno} ; n = Sg} ;
lin pot0 d =
  {s = \\f,g => d.s ! f ; n = Pl} ;
lin pot110  =
  spl "diez" ;
lin pot111  =
  spl "once" ;
lin pot1to19 d =
  spl (d.s ! {p1 = teen ; p2 = unmod}) ;
lin pot0as1 n =
  {s = n.s ! {p1 = unit ; p2 = unmod} ; n = n.n} ;
lin pot1 d =
  spl (d.s ! {p1 = ten ; p2 = unmod}) ;
lin pot1plus d e =
  {s = \\g => (d.s ! {p1 = ten ; p2 = mod}) ++ e.s ! {p1 = unit ; p2 =
  d.inh} ! g ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d =
  spl (d.s ! {p1 = hundred ; p2 = unmod} ! Masc) ;
lin pot2plus d e =
  {s = \\g => (d.s ! {p1 = hundred ; p2 = mod}) ! Masc ++ e.s ! g ; n = Pl} ;
lin pot2as3 n = n ;
lin pot3 n =
  spl (n.s ! Masc ++ "mil") ;
lin pot3plus n m =
  {s = \\g => n.s ! Masc ++ "mil" ++ m.s ! g ; n = Pl} ;

param DForm = unit  | teen  | ten  | hundred  ;
param Modif = mod  | unmod  | conj  ;

oper spl : Str -> {s : Gender => Str ; n : Number} = \s -> {s = \\_ =>
  s ; n = Pl} ;

  uno  : Gender => Str = table {Masc => "uno" ; Fem => "una"} ;
  yuno : Gender => Str = \\g => "y" ++ uno ! g ;

}
