concrete NumeralTur of Numeral = CatTur ** open ResTur in {

lincat 
  Digit = {s : DForm => Str} ;
  Sub10 = {s : DForm => Str ; n : Number} ;
  Sub100     = {s : Str ; n : Number} ;
  Sub1000    = {s : Str ; n : Number} ;
  Sub1000000 = {s : Str ; n : Number} ;

lin num x = x ;

lin n2 = mkNum "iki"   "yirmi"  ;
lin n3 = mkNum "üç"    "otuz"   ;
lin n4 = mkNum "dört"  "kırk"   ;
lin n5 = mkNum "beş"   "elli"   ;
lin n6 = mkNum "altı"  "altmış" ;
lin n7 = mkNum "yedi"  "yetmiş" ;
lin n8 = mkNum "sekiz" "seksen" ;
lin n9 = mkNum "dokuz" "doksan" ;
lin pot01 = mkNum "bir" "on" ** {n = Sg} ;
lin pot0 d = d ** {n = Pl} ;
lin pot110 = {s="on"; n = Pl} ;
lin pot111 = {s="on" ++ "&+" ++ "bir"; n = Pl} ;
lin pot1to19 d = {s = "on" ++ "&+" ++ d.s ! unit; n = Pl} ;
lin pot0as1 n = {s = n.s ! unit; n = n.n} ;
lin pot1 d = {s = d.s ! ten; n = Pl} ;
lin pot1plus d e = {s = d.s ! ten ++ e.s ! unit ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! unit ++ "&+" ++ "yüz"; n = Pl} ;
lin pot2plus d e = {s = d.s ! unit ++ "&+" ++ "yüz" ++ e.s ; n = Pl} ;
lin pot2as3 n = n ;
lin pot3 n = {s = n.s ++ "&+" ++ "bin" ; n = Pl} ;
lin pot3plus n m = {s = n.s ++ "&+" ++ "bin" ++ "&+" ++ m.s; n = Pl} ;
}
