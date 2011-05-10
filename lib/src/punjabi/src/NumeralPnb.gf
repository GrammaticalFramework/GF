concrete NumeralPnb of Numeral = CatPnb ** open ResPnb, Prelude in {
-- By Harald Hammarstroem
-- Modification for Punjabi by Shafqat Virk
 flags coding=utf8 ;



param DForm = unit | ten ;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ;
param Size = singl | less100 | more100 ; 

oper LinDigit = {s : DForm => Str ; size : DSize ; n : Number} ;


lincat Dig = { s:Str ; n : Number};
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : DSize ; n : Number} ;
lincat Sub100 = {s : Str ; size : Size ; n : Number} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size ; n : Number } ; 
lincat Sub1000000 = { s : Str ; n : Number } ;

lin num x0 = 
    {s = table {
          NCard =>   x0.s ; 
          NOrd =>  x0.s ++ "waN" -- (mkOrd x0.s)  need to use mkOrd which will make irregular ordinals but it gives path error
          };
       n = x0.n
    } ;
oper mkOrd : Str -> Str =
 \s -> case s of {
                    "ak"                  => "pyla";
                    "dw"                  => "dwja";
                    "tn"                => "dwja";
                    "car"                => "cwth'a";
                    _                     =>  s ++ "waN"
                  };
--  {s = \\_ => x0.s ; n = x0.n} ; 


oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "dw" "wy" r2 ;
lin n3 = mkNum "tn" "try" r3 ;
lin n4 = mkNum "car" "caly" r4 ;
lin n5 = mkNum "pnj" "pnjah" r5 ;
lin n6 = mkNum "ch'" "sTh'" r6 ; 
lin n7 = mkNum "st" "str" r7; 
lin n8 = mkNum "aTh'" "asy" r8;
lin n9 = mkNum "nw" "nbE" r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "aN" ;
  r2 => a2 + "y" ;
  r3 => a3 + "y" ;
  r4 => a4 + "aly" ;
  r5 => a5 + "nja" ;
  r6 => a6 + "Th'" ;
  r7 => a7 + "tr" ;
  r8 => a8 + "asy" ;
  r9 => a9 + "anwE"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "gyar" "akk" "akt" "akta" "akw" "aka" "akh" "ak" "aky" ; 
  r2 => mkR "bar" "ba" "bt" "bay" "by" "bw" "bh" "by" "b" ;
  r3 => mkR "tyr" "ty" "tyt" "tnt" "trt" "trw" "tyh" "tyr" "tr" ;
  r4 => mkR "cwd" "cwb" "cwt" "cwa" "cwt" "cwr" "cwh" "cwr" "cwr" ;
  r5 => mkR "pndr" "pnj" "pynt" "pnta" "pcw" "pyn" "pnj" "pnj" "pc" ;
  r6 => mkR "swl" "ch'b" "ch't" "ch'y" "ch'w" "ch'ya" "ch'h" "ch'y" "ch'y" ;
  r7 => mkR "star" "sta" "synt" "snt" "snt" "stw" "st" "st" "st" ;
  r8 => mkR "aTh'ar" "aTh'a" "aTh't" "aRt" "aTh'w" "aTh'a" "aTh'" "aTh'" "aTh'" ; 
  r9 => table {sg => "any" ; r2 => "anty" ; r3 => "antaly" ; 
               r4 => "anaja" ; r5 => "anaTh'" ; r6 => "anhtr" ; 
               r7 => "anasy" ; 
               r8 => "ananwE" ; r9 => "nRynwE" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "ak" ; _ => "dmy" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "ds" ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = d.n} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = d.n} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = d.n} ;

lin pot1as2 n = {s = n.s ; s2 = "dmy" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "lkh'" ; size = more100 ; n = d.n} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "lkh'" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = d.n} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "hzar" ; 
                          more100 => n.s2 } ! n.size ; n = n.n} ;
lin pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "hzar" ; 
              more100 => n.s2 } ! n.size ++ m.s ; n = n.n} ;

lin D_0 = { s = "N0" ; n = Sg};
lin D_1 = { s = "N1" ; n = Sg};
lin D_2 = { s = "N2" ; n = Pl};
lin D_3 = { s = "N3" ; n = Pl};
lin D_4 = { s = "N4" ; n = Pl};
lin D_5 = { s = "N5" ; n = Pl};
lin D_6 = { s = "N6" ; n = Pl};
lin D_7 = { s = "N7" ; n = Pl};
lin D_8 = { s = "N8" ; n = Pl};
lin D_9 = { s = "N9" ; n = Pl};
lin IDig d = { s = \\_ => d.s ; n = d.n} ;
lin IIDig d dg = { s = \\df => Prelude.glue (dg.s ! df) d.s ; n = Pl }; 

oper ekhazar : Str = variants {"hzar" ; "ak" ++ "hzar"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "hzar"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "ak" ++ "sw" ; _ => s ++ "sw"} ! sz ;
}
