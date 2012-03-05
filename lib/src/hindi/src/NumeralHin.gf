-- By Harald Hammarstr
-- Modification for Urdu Shafqat Virk


concrete NumeralHin of Numeral = CatHin ** open ResHin,CommonHindustani,ParamX, Prelude in {
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
          NOrd =>  Prelude.glue x0.s "va:n~" -- need to use mkOrd x0.s but it gives linking error 
          };
       n = x0.n
    } ;


oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "do:" "bi:s" r2 ;
lin n3 = mkNum "ti:n" "ti:s" r3 ;
lin n4 = mkNum "ca:r" "ca:li:s" r4 ;
lin n5 = mkNum "pa:m.c" "pca:s" r5 ;
lin n6 = mkNum "c'e:" "sa:Th'" r6 ; 
lin n7 = mkNum "sa:t" "sattar" r7; 
lin n8 = mkNum "A:T'" "Assi:" r8;
lin n9 = mkNum "no+" "navve:" r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "ah" ;
  r2 => a2 + "s" ;
  r3 => a3 + "ti:s" ;
  r4 => a4 + "a:li:s" ;
  r5 => a5 + "n" ;
  r6 => a6 + "saT'" ;
  r7 => a7 + "atX,tar" ;
  r8 => a8 + "a:si:" ;
  r9 => a9 + "a:nawve:"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "gX,ya:r" "Ikki:" "Ikat" "Ikt" "Ikya:va" "Ik" "Ikh" "Iky" "Iky" ; 
  r2 => mkR "ba:r" "ba:I:" "bat" "be+t" "ba:va" "ba:" "bah" "bay" "b" ;
  r3 => mkR "te:r" "te:I:" "te+m." "te+m.t" "tirpa" "tir" "tih" "tir" "tir" ;
  r4 => mkR "co+d" "co+bi:" "co+m." "co+va" "cww" "co+n~" "co+h" "cw+r" "co+r" ;
  r5 => mkR "pam.dr" "pacci:" "pe+m." "pe+m.t" "pacpa" "pe+n~" "pic'" "pac" "pic" ;
  r6 => mkR "so:l" "ca'bbi:" "c'a:t" "c'iy" "c'ppa" "c'iya:" "cih" "c'iy" "c'iy" ;
  r7 => mkR "satr" "satta:I:" "se+m." "se+m.t" "sata:va" "saR'" "sath" "sat" "sat" ;
  r8 => mkR "AT'a:r" "aTh'a:I:" "AR'" "AR't" "AT'a:v" "AR'" "ATh" "AT'" "AT'" ; 
  r9 => table {sg => "Unni:s" ; r2 => "Unatti:s" ; r3 => "Um.ta:li:s" ; 
               r4 => "Um.ca:s" ; r5 => "UnsaT'" ; r6 => "Unhattar" ; 
               r7 => "Unassi:" ; 
               r8 => "Unannave:" ; r9 => "ninX,ya:nave:" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "E:k" ; _ => "dmi:" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "ds" ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = Pl} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = Pl} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = Pl} ;

lin pot1as2 n = {s = n.s ; s2 = "dmi:" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "la:k'" ; size = more100 ; n = Pl} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "la:k'" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = Pl} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "haza:r" ; 
                          more100 => n.s2 } ! n.size ; n = Pl} ;
lin pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "haza:r" ; 
              more100 => n.s2 } ! n.size ++ m.s ; n = Pl} ;

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

oper ekhazar : Str = variants {"haza:r" ; "E:k" ++ "haza:r"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "haza:r"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "E:k" ++ "so+" ; _ => s ++ "so+"} ! sz ;
}
