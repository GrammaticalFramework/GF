--# -path=.:../abstract:../../prelude

concrete NumeralsFin of Numerals = open TypesFin, MorphoFin, ParadigmsFin in {

lincat 
  Numeral, Sub1000000 = {s : NForm => Str ; n : Number} ;
  Digit = {s : NForm => Str} ;
  Sub10, Sub100, Sub1000 = {s : NumPlace => NForm => Str ; n : Number} ;

lin 
  num x = x ;
  n2 = mkSubst "a" "kaksi" "kahde" "kahte" "kahta" "kahteen" "kaksi" "kaksi"
    "kaksien" "kaksia" "kaksiin" ;
  n3 = mkSubst "a" "kolme" "kolme" "kolme" "kolmea" "kolmeen" "kolmi" "kolmi"
    "kolmien" "kolmia" "kolmiin" ;
  n4 = regN "neljä" ;
  n5 = reg3Noun "viisi" "viiden" "viisiä" ;
  n6 = reg3Noun "kuusi" "kuuden" "kuutta" ; 
  n7 = mkSubst "ä" "seitsemän" "seitsemä" "seitsemä" "seitsemää" 
    "seitsemään" "seitsemi" "seitsemi" "seitsemien" "seitsemiä"
    "seitsemiin" ;
  n8 = mkSubst "a" "kahdeksan" "kahdeksa" "kahdeksa" "kahdeksaa" 
    "kahdeksaan" "kahdeksi" "kahdeksi" "kahdeksien" "kahdeksia"
    "kahdeksiin" ;
  n9 = mkSubst "ä" "yhdeksän" "yhdeksä" "yhdeksä" "yhdeksää" 
    "yhdeksään" "yhdeksi" "yhdeksi" "yhdeksien" "yhdeksiä" "yhdeksiin" ;

  pot01 = 
   {s = table {
      NumAttr => \\_ => [] ; 
      NumIndep => yksiN.s
      } ;
    n = Sg
    } ;
  pot0 d = {n = Pl ; s = \\_ => d.s} ;
  pot110 =
   {s = \\_ => kymmenenN.s ;
    n = Pl
    } ;

  pot111 = {n = Pl ; s = \\_,c => yksiN.s ! c ++"toista"} ;
  pot1to19 d = {n = Pl ; s = \\_,c => d.s ! c ++"toista"} ;
  pot0as1 n = n ;

  pot1 d = {n = Pl ; s = \\_,c => d.s ! c ++ kymmentaN.s ! c} ;
  pot1plus d e = {
    n = Pl ; 
    s = \\_,c => d.s ! c ++ kymmentaN.s ! c ++ e.s ! NumIndep ! c
    } ;
  pot1as2 n = n ;
  pot2 d = {n = Pl ; s = \\_,c => d.s ! NumAttr ! c ++ sataaN.s ! d.n ! c} ; ----
  pot2plus d e = {
    n = Pl ; 
    s = \\_,c => d.s ! NumAttr ! c ++ sataaN.s ! d.n ! c ++ e.s ! NumIndep ! c
    } ;
  pot2as3 n = {n = n.n  ; s = n.s ! NumIndep} ;
  pot3 d = {n = Pl ; s = \\c => d.s ! NumAttr ! c ++ tuhattaN.s ! d.n ! c} ; ----
  pot3plus d e = {
    n = Pl ;
    s = \\c => d.s ! NumAttr ! c ++ tuhattaN.s ! d.n ! c ++ e.s ! NumIndep ! c
    } ;
}
