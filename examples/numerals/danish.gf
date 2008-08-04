concrete danish of Numerals = {
-- include numerals.Abs.gf ;

-- AR 12/10/2002 following www.geocities.com/tsca.geo/dansk/dknummer.html

param DForm = ental  | ton  | tiotal  ;

lincat Numeral = {s : Str} ;
oper LinDigit = {s : DForm => Str} ;
lincat Digit = LinDigit ;

lincat Sub10 = {s : DForm => Str} ;
lincat Sub100 = {s : Str} ;
lincat Sub1000 = {s : Str} ;
lincat Sub1000000 = {s : Str} ;

oper mkTal : Str -> Str -> Str -> LinDigit = 
  \to, tolv, tyve -> 
  {s = table {ental => to ; ton => tolv ; tiotal => tyve}} ;
oper regTal : Str -> LinDigit = \fem -> mkTal fem (fem + "ton") (fem + "tio") ;
oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin num x = x ;

lin n2 = mkTal "to"   "tolv"    "tyve" ;
lin n3 = mkTal "tre"  "tretten" "tredive" ;
lin n4 = mkTal "fire" "fjorten" "fyrre" ;
lin n5 = mkTal "fem"  "femten"  "halvtreds" ;
lin n6 = mkTal "seks" "seksten" "tres" ;
lin n7 = mkTal "syv"  "sytten"  "halvfjerds" ;
lin n8 = mkTal "otte" "atten"   "firs" ;
lin n9 = mkTal "ni"   "nitten"  "halvfems" ;

lin pot01 = {s = table {f => "en"}} ; ---
lin pot0 d = {s = table {f => d.s ! f}} ;
lin pot110 = ss "ti" ;
lin pot111 = ss "elleve" ;
lin pot1to19 d = ss (d.s ! ton) ;
lin pot0as1 n = ss (n.s ! ental) ;
lin pot1 d = ss (d.s ! tiotal) ;
lin pot1plus d e = ss (e.s ! ental ++ "og" ++ d.s ! tiotal) ;
lin pot1as2 n = n ;
lin pot2 d = ss (d.s ! ental ++ "hundrede") ;
lin pot2plus d e = ss (d.s ! ental ++ "hundrede" ++ "og" ++ e.s) ;
lin pot2as3 n = n ;
lin pot3 n = ss (n.s ++ "tusind") ;
lin pot3plus n m = ss (n.s ++ "tusind" ++ "og" ++ m.s) ; ---

}
