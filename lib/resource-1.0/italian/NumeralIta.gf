concrete NumeralIta of Numeral = CatIta ** 
  open CommonRomance, ResRomance, MorphoIta, Prelude in {

lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100 = {s : CardOrd => Str ; n : Number} ;
  Sub1000 = {s : CardOrd => Str ; n : Number} ;
  Sub1000000 = {s : CardOrd => Str ; n : Number} ;

lin num x = x ;

lin n2 = mkTal "due"     "dodici"      "venti"     "secondo" ;
lin n3 = mkTal "tre"     "tredici"     "trenta"    "terzo" ;
lin n4 = mkTal "quattro" "quattordici" "quaranta"  "quarto" ;
lin n5 = mkTal "cinque"  "quindici"    "cinquanta" "quinto" ;
lin n6 = mkTal "sei"     "sedici"      "sessanta"  "sesto" ;
lin n7 = mkTal "sette"   "diciassette" "settanta"  "settimo" ; --- diciasettesimo?
lin n8 = mkTal "otto"    "diciotto"    "ottanta"   "ottavo" ;
lin n9 = mkTal "nove"    "diciannove"  "novanta"   "nono" ;

lin pot01 = 
  let uno = (mkTal "uno" "undici" "dieci" "primo").s in
  {s =\\f,g => case f of {
     ental pred => [] ;
     _ => uno ! f ! g
     } ; 
   n = Pl} ;

lin pot0 d = {s = d.s ; n = Pl} ;
lin pot110 = spl ((mkTal "dieci" [] [] "decimo").s ! ental indip) ;
lin pot111 = spl ((mkTal "undici" [] [] "undicesimo").s ! ental indip) ;
lin pot1to19 d = spl (d.s ! ton) ;
lin pot0as1 n = {s = n.s ! ental indip ; n = n.n} ;
lin pot1 d = spl (d.s ! tiotal) ;
lin pot1plus d e = 
  {s = \\g => d.s ! tiotal ! NCard Masc ++ e.s ! ental indip ! g ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d = spl (\\co => d.s ! ental pred ! NCard Masc ++ 
  (mkTal "cento" [] [] "centesimo").s ! ental indip ! co) ;
lin pot2plus d e = 
  {s = \\g => d.s ! ental pred ! NCard Masc ++ "cento" ++ e.s ! g ; n = Pl} ;
lin pot2as3 n = n ;
lin pot3 n = spl (\\co => n.s ! NCard Masc ++ 
  (mkTal (mille ! n.n) [] [] "millesimo").s ! ental indip ! co) ;
lin pot3plus n m = {s = \\g => n.s ! NCard Masc ++ mille ! n.n ++ m.s ! g ; n = Pl} ;

oper
  mkTal : (x1,_,_,x4 : Str) -> {s : DForm => CardOrd => Str} =
    \due,dodici,venti,secondo -> {s = \\d,co => case <d,co> of {
       <ental _, NCard _>  => due ;
       <ental _, NOrd g n> => pronForms (adjSolo secondo) g n ;
       <tiotal,  NCard _>  => venti ;
       <tiotal,  NOrd g n> => regCard venti g n ;
       <ton,     NCard _>  => venti ;
       <ton,     NOrd g n> => regCard venti g n
       }
    } ;

  regCard : Str -> Gender -> Number -> Str = \venti ->
    pronForms (adjSolo (init venti + "esimo")) ;

  spl : (CardOrd => Str) -> {s : CardOrd => Str ; n : Number} = \s -> {
    s = s ;
    n = Pl
    } ;

oper mille : Number => Str = table {Sg => "mille" ; Pl => "mila"} ;
param DForm = ental Pred | ton | tiotal  ;
param Pred = pred | indip ;

}
