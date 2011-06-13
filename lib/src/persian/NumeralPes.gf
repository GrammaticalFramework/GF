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
lin n2 = mkNum  "دو"     "دوازده"   "بیست"     "دویست" ;       
lin n3 = mkNum3   "سه"     "سیزده"    "سی"       "سیصد"   "سوم"  ;
lin n4 = mkNum  "چهار"   "چهارده"   "چهل"      "چهارصد"  ;
lin n5 = mkNum  "پنج"    "پانزده"   "پنجاه"    "پانصد"  ;
lin n6 = mkNum   "شش"     "شانزده"   "شصت"      "ششصد" ;
lin n7 = mkNum  "هفت"    "هفده"     "هفتاد"    "هفتصد"  ;
lin n8 = mkNum  "هشت"    "هجده"     "هشتاد"    "هشتصد"   ;
lin n9 = mkNum   "نه"     "نوزده"    "نود"      "نهصد"  ;

lin pot01 = mkNum3  "یک"   "یازده"  "ده"   "یکصد"   "هزار"    ** {n = Sg} ;

lin pot0 d = d ** {n = Pl} ;

lin pot110 = {s = table { NCard => "ده" ; 
                          NOrd   => "دهم" };
               n = Pl} ;
lin pot111 = {s = table { NCard => "یازده" ; 
                          NOrd   => "یازدهم" };
               n = Pl};

lin pot1to19 d = {s = d.s ! teen} ** {n = Pl} ;
lin pot0as1 n = {s = n.s ! unit}  ** {n = n.n} ;
lin pot1 d = {s = d.s ! ten} ** {n = Pl} ;

lin pot1plus d e = {
   s = \\o => d.s ! ten ! NCard ++"و" ++e.s ! unit ! o ; n = Pl} ;

lin pot1as2 n = n ;

lin pot2 d = {s = d.s ! hundreds}  ** {n = Pl} ;
lin pot2plus d e = {
  s = \\o => d.s ! hundreds ! NCard  ++ "و" ++ e.s ! o  ; n = Pl} ; -- remove "??"

lin pot2as3 n = n ;

lin pot3 n = { s = \\o => n.s ! NCard ++  "هزار" ; n = Pl} ;

lin pot3plus n m = {
  s = \\o => n.s ! NCard ++ "هزار" ++ "و" ++ m.s ! o; n = Pl} ; -- missing word "????????" after NCard

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
    D_0 = mkDig "0" ;
    D_1 = mk3Dig "1" "" Pl;
    D_2 = mk2Dig "2" "";
    D_3 = mk2Dig "3" "سوم" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;
   
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
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + "م") ;

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
       unit => table {NCard => two ; NOrd => (two + "مین") | (two + "م")};
       teen => table {NCard => twelve ; NOrd => (twelve + "مین") | (twelve + "م")} ; 
       ten  => table {NCard => twenty ; NOrd => (twenty + "مین") | (twenty + "م")};
       hundreds => table {NCard => twohundred ; NOrd => (twohundred +"مین") | (twohundred + "م")};
       thousands => table {NCard => (two + "هزار" ); NOrd => (two + "هزار" + "م") | (two + "هزار" +"مین" )}

    }};

 mkNum3 : Str -> Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} = 
    \two, twelve, twenty, twohundred, second->
    {s = table {
       unit => table {NCard => two ; NOrd => second};
       teen => table {NCard => twelve ; NOrd => (twelve + "مین") | (twelve + "م")} ; 
       ten  => table {NCard => twenty ; NOrd => (twenty + "مین") | (twenty + "م")};
       hundreds => table {NCard => twohundred ; NOrd => (twohundred +"مین") | (twohundred + "م")};
       thousands => table {NCard => (two + "هزار" ); NOrd => (two + "هزار" + "م") | (two + "هزار"+ "مین" )}

    }};
   


}
