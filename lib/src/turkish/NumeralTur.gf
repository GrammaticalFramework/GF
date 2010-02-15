--# -path=.:../abstract:../common:../../prelude

concrete NumeralTur of Numeral = CatTur ** open Prelude, ResTur, ParadigmsTur in {

flags
  coding = utf8 ;

lincat
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number ; blank : Str} ; -- the field blank is used to get rid of metavariables at parsing
  Sub100     = {s : CardOrd => Str ; n : Number ; blank : Str} ;
  Sub1000    = {s : CardOrd => Str ; n : Number ; blank : Str} ;
  Sub1000000 = {s : CardOrd => Str ; n : Number} ;

lin num x = x ;

lin n2 = mkNum "iki"   "yirmi"  ;
lin n3 = mkNum "üç"    "otuz" "üçüncü"   "otuzuncu" ;
lin n4 = mkNum "dört"  "kırk" "dördüncü" "kırkıncı" ;
lin n5 = mkNum "beş"   "elli"   ;
lin n6 = mkNum "altı"  "altmış" ;
lin n7 = mkNum "yedi"  "yetmiş" ;
lin n8 = mkNum "sekiz" "seksen" ;
lin n9 = mkNum "dokuz" "doksan" ;
lin pot01 = mkNum "bir" "on" "birinci" "onuncu" ** {n = Sg; blank = []} ;
lin pot0 d = d ** {n = Pl; blank = []} ;
lin pot110 = {s = pot01.s ! ten; n = Pl; blank = []} ;
lin pot111 = {s = \\t => "on" ++ pot01.s ! unit ! t; n = Pl; blank = []} ;
lin pot1to19 d = {s = \\t => "on" ++ d.s ! unit ! t; n = Pl; blank = []} ;
lin pot0as1 n = {s = \\t => n.s ! unit ! t; n = n.n ; blank = n.blank} ;
lin pot1 d = {s = d.s ! ten; n = Pl ; blank = []} ;
lin pot1plus d e = {s = \\t => d.s ! ten ! NCard ++ e.s ! unit ! t; n = Pl; blank = e.blank} ;
lin pot1as2 n = n ;
lin pot2 d = {s = \\t => case d.n of {
                           Sg => d.blank ;
                           Pl => d.s ! unit ! NCard
                         } ++ (mkNum "yüz" "yüz").s ! unit ! t; n = Pl; blank = d.blank} ;
lin pot2plus d e = {s = \\t => case d.n of {
                                Sg => d.blank ;
                                Pl => d.s ! unit ! NCard
                               } ++ "yüz" ++ e.s ! t ; n = Pl; blank = d.blank} ;
lin pot2as3 n = n ;
lin pot3 n = {s = \\t => case n.n of {
                           Sg => n.blank ;
                           Pl => n.s ! NCard
                         } ++ (mkNum "bin" "bin").s ! unit ! t; n = Pl} ;
lin pot3plus n m = {s = \\t => case n.n of {
			         Sg => n.blank ;
			         Pl => n.s ! NCard
			       } ++ "bin" ++ m.s ! t; n = Pl} ;
lincat
  Dig = {s : CardOrd => Str ; n : Number} ;
lin
  IDig d = d ** {tail = T1};
  IIDig d ds =
    { s = \\t => d.s ! NCard ++ commaIf ds.tail ++ ds.s ! t; n = Pl; tail = inc ds.tail} ;

  D_0 = mkDig "0" ;
  D_1 = mkDig "1" "1." Sg;
  D_2 = mkDig "2" ;
  D_3 = mkDig "3" ;
  D_4 = mkDig "4" ;
  D_5 = mkDig "5" ;
  D_6 = mkDig "6" ;
  D_7 = mkDig "7" ;
  D_8 = mkDig "8" ;
  D_9 = mkDig "9" ;
oper
  commaIf : DTail -> Str = \t -> case t of {
				   T3 => "," ;
				   _ => []
	                         } ;

  inc : DTail -> DTail = \t -> case t of {
				 T1 => T2 ;
				 T2 => T3 ;
				 T3 => T1
			       } ;
}
