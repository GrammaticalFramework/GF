concrete malay of Numerals = {
-- Malay Numerals (Indonesian)
-- David Wahlstedt Sep 2002

-- include numerals.Abs.gf ;

param
 Place = attr  | indep  ;
 Nm = sg  | pl  ;

oper Num = {inh : Nm ; s : Place => Str} ;

lincat
 Numeral = {s : Str} ;
 Digit = {s : Str} ;
 Sub10 = Num ;
 Sub100 = Num ;
 Sub1000 = Num ;
 Sub1000000 = {s : Str} ;

oper
 ratus : Nm => Str =                               -- 100
   table {{sg} => "seratus" ; {pl} => "ratus"} ;

 ribu : Nm => Str =                                -- 1000
   table {{sg} => "seribu" ; {pl} => "ribu"} ;

 mkTab : Str -> Place => Str = \s -> table { _ => s } ;

 mkNum : Str -> Num = \s -> {inh = pl ; s = mkTab s} ;

 ss : Str -> { s : Str } = \s -> { s = s } ;

lin 
 num x0 = x0 ;

 n2  = ss "dua"      ;
 n3  = ss "tiga"     ;
 n4  = ss "empat"    ;
 n5  = ss "lima"     ;
 n6  = ss "enam"     ;
 n7  = ss "tujuh"    ;
 n8  = ss "delapan"  ;
 n9  = ss "sembilan" ;

 pot01 = {inh = sg ; s = table {{attr} => [] ; {indep} => "satu"}} ;

 pot0 d = mkNum d.s  ;

 pot110 = mkNum "sepuluh" ;

 pot111 = mkNum "sebelas" ;

 pot1to19 d = mkNum ( d.s ++ "belas" ) ;

 pot0as1 n = n ;

 pot1 d = mkNum ( d.s ++ "puluh" ) ;

 pot1plus d e = mkNum ( d.s ++ "puluh" ++ e.s ! indep ) ;

 pot1as2 n = n ;

 pot2 d = mkNum ( d.s ! attr ++ ratus ! d.inh ) ;

 pot2plus d e = mkNum ( d.s ! attr ++ ratus ! d.inh ++ e.s ! indep ) ;

 pot2as3 n = ss ( n.s ! indep ) ;

 pot3 n = ss ( n.s ! attr ++ ribu ! n.inh ) ;

 pot3plus n m = ss ( n.s ! attr ++ ribu ! n.inh ++ m.s ! indep ) ;

}
