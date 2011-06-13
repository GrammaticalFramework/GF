--# -path=.:../abstract:../common:
concrete NumeralPes of Numeral = CatPes [Numeral,Digits] ** open ResPes,Prelude in {

flags coding = utf8;

param DForm = unit | teen | ten | hundreds |thousands;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ;
param Size = singl | less100 | more100 ; 


lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100     = {s : CardOrd => Str ; n : Number} ;
  Sub1000    = {s : CardOrd => Str ; n : Number} ;
  Sub1000000 = {s : CardOrd => Str ; n : Number} ;

lin num x = x ;
-- 2     12     20    200             
lin n2 = mkNum  "dv"     "dvAzdh"   "byst"     "dvyst" ;       
lin n3 = mkNum3   "sh"     "syzdh"    "sy"       "sySd"   "svm"  ;
lin n4 = mkNum  "c^hAr"   "c^hArdh"   "c^hl"      "c^hArSd"  ;
lin n5 = mkNum  "pnj"    "pAnzdh"   "pnjAh"    "pAnSd"  ;
lin n6 = mkNum   "CC"     "CAnzdh"   "CSt"      "CCSd" ;
lin n7 = mkNum  "hft"    "hfdh"     "hftAd"    "hftSd"  ;
lin n8 = mkNum  "hCt"    "hjdh"     "hCtAd"    "hCtSd"   ;
lin n9 = mkNum   "nh"     "nvzdh"    "nvd"      "nhSd"  ;

lin pot01 = mkNum3  "yk"   "yAzdh"  "dh"   "ykSd"   "hzAr"    ** {n = Sg} ;

lin pot0 d = d ** {n = Pl} ;

lin pot110 = {s = table { NCard => "dh" ; 
                          NOrd   => "dhm" };
               n = Pl} ;
lin pot111 = {s = table { NCard => "yAzdh" ; 
                          NOrd   => "yAzdhm" };
               n = Pl};

lin pot1to19 d = {s = d.s ! teen} ** {n = Pl} ;
lin pot0as1 n = {s = n.s ! unit}  ** {n = n.n} ;
lin pot1 d = {s = d.s ! ten} ** {n = Pl} ;

lin pot1plus d e = {
   s = \\o => d.s ! ten ! NCard ++"v" ++e.s ! unit ! o ; n = Pl} ;

lin pot1as2 n = n ;

lin pot2 d = {s = d.s ! hundreds}  ** {n = Pl} ;
lin pot2plus d e = {
  s = \\o => d.s ! hundreds ! NCard  ++ "v" ++ e.s ! o  ; n = Pl} ; -- remove "??"

lin pot2as3 n = n ;

lin pot3 n = { s = \\o => n.s ! NCard ++  "hzAr" ; n = Pl} ;

lin pot3plus n m = {
  s = \\o => n.s ! NCard ++ "hzAr" ++ "v" ++ m.s ! o; n = Pl} ; -- missing word "????????" after NCard

-- numerals as sequences of digits

  lincat 
    Dig = TDigit ;
   
  lin
    IDig d = d ** {tail = T1} ;
{-
   IIDig d i = {
      s = \\o,c => d.s ! NCard  ++ commaIf i.tail ++ i.s ! o ! c ;
      n = Pl ;
 --     tail = inc i.tail
    } ;
-}
    D_0 = mkDig "?" ;
    D_1 = mk3Dig "?" "" Pl;
    D_2 = mk2Dig "?" "";
    D_3 = mk2Dig "?" "svm" ;
    D_4 = mkDig "?" ;
    D_5 = mkDig "?" ;
    D_6 = mkDig "?" ;
    D_7 = mkDig "?" ;
    D_8 = mkDig "?" ;
    D_9 = mkDig "?" ;
   
  --  lin IDig d = { s = \\_ => d.s ; n = Sg} ;
    lin IIDig d dg = { s = \\df => d.s ! NCard ++ dg.s ! df   ; n = Pl}; 

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

    mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o Pl ;
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + "m") ;

    mk3Dig : Str -> Str -> Number -> TDigit = \c,o,n -> {
     -- s = table {NCard => regGenitiveS c ; NOrd => regGenitiveS o} ;
       s = table {NCard => c ; NOrd =>  o} ;
      n = n
      } ;

 oper   TDigit = {
      n : Number ;
      s : CardOrd => Str
    } ;


oper 
 mkNum : Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} = 
    \two, twelve, twenty, twohundred->
    {s = table {
       unit => table {NCard => two ; NOrd => (two + "myn") | (two + "m")};
       teen => table {NCard => twelve ; NOrd => (twelve + "myn") | (twelve + "m")} ; 
       ten  => table {NCard => twenty ; NOrd => (twenty + "myn") | (twenty + "m")};
       hundreds => table {NCard => twohundred ; NOrd => (twohundred +"myn") | (twohundred + "m")};
       thousands => table {NCard => (two + "hzAr" ); NOrd => (two + "hzAr" + "m") | (two + "hzAr" +"myn" )}

    }};

 mkNum3 : Str -> Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} = 
    \two, twelve, twenty, twohundred, second->
    {s = table {
       unit => table {NCard => two ; NOrd => second};
       teen => table {NCard => twelve ; NOrd => (twelve + "myn") | (twelve + "m")} ; 
       ten  => table {NCard => twenty ; NOrd => (twenty + "myn") | (twenty + "m")};
       hundreds => table {NCard => twohundred ; NOrd => (twohundred +"myn") | (twohundred + "m")};
       thousands => table {NCard => (two + "hzAr" ); NOrd => (two + "hzAr" + "m") | (two + "hzAr"+ "myn" )}

    }};
   


}
