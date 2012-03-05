-- By Harald Hammarstr
-- Modification for Urdu Shafqat Virk


concrete NumeralUrd of Numeral = CatUrd ** open ResUrd,CommonHindustani,ParamX, Prelude in {
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
          NOrd =>  x0.s ++ "waN" -- need to use mkOrd x0.s but it gives linking error 
          };
       n = x0.n
    } ;


oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "dw" "bys" r2 ;
lin n3 = mkNum "tyn" "tys" r3 ;
lin n4 = mkNum "car" "calys" r4 ;
lin n5 = mkNum "panc" "pcas" r5 ;
lin n6 = mkNum "ch'" "saTh'" r6 ; 
lin n7 = mkNum "sat" "str" r7; 
lin n8 = mkNum "ATh'" "asy" r8;
lin n9 = mkNum "nw" "nwE" r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "h" ;
  r2 => a2 + "ys" ;
  r3 => a3 + "tys" ;
  r4 => a4 + "alys" ;
  r5 => a5 + "n" ;
  r6 => a6 + "saTh'" ;
  r7 => a7 + "htr" ;
  r8 => a8 + "asy" ;
  r9 => a9 + "anwE"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "gyar" "ak" "akt" "akt" "akyaw" "ak" "ak" "aky" "aky" ; 
  r2 => mkR "bar" "bay" "bat" "bay" "baw" "ba" "ba" "bay" "b" ;
  r3 => mkR "tyr" "ty" "tyn" "tnt" "trp" "try" "t" "tr" "tr" ;
  r4 => mkR "cwd" "cwb" "cwn" "cwa" "cww" "cwn" "cwh" "cwr" "cwr" ;
  r5 => mkR "pndr" "pcy" "pyn" "pnta" "pcp" "pyn" "ph" "pc" "pc" ;
  r6 => mkR "swl" "ch'b" "ch't" "ch'y" "ch'p" "ch'ya" "ch'" "ch'y" "ch'y" ;
  r7 => mkR "str" "sta" "syn" "snt" "staw" "sta" "sr" "st" "sta" ;
  r8 => mkR "aTh'ar" "aTh'ay" "aR" "aRt" "aTh'aw" "aR" "aTh'" "aTh'" "aTh'" ; 
  r9 => table {sg => "anys" ; r2 => "antys" ; r3 => "antalys" ; 
               r4 => "ancas" ; r5 => "ansth'" ; r6 => "anhtr" ; 
               r7 => "anasy" ; 
               r8 => "ananwE" ; r9 => "nnanwE" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "ayk" ; _ => "dmy" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "ds" ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = Pl} ; --changed from d.n
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = Pl} ; --changed from d.n
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = Pl} ; --changed from d.n

lin pot1as2 n = {s = n.s ; s2 = "dmy" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "lakh'" ; size = more100 ; n = Pl} ; --changed from d.n
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "lakh'" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = Pl} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "hzar" ; 
                          more100 => n.s2 } ! n.size ; n = Pl} ; --changed from d.n
lin pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "hzar" ; 
              more100 => n.s2 } ! n.size ++ m.s ; n = Pl} ; --changed from d.n

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

oper ekhazar : Str = variants {"hzar" ; "ayk" ++ "hzar"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "hzar"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "ayk" ++ "sw" ; _ => s ++ "sw"} ! sz ;
}
