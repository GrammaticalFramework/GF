-- By Harald Hammarstr
-- Modification for Urdu Shafqat Virk


concrete NumeralHin of Numeral = CatHin [Numeral,Digits] ** open ResHin,CommonHindustani,ParamX, Prelude in {
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
          NOrd =>  Prelude.glue x0.s "वाँ" -- need to use mkOrd x0.s but it gives linking error 
          };
       n = x0.n
    } ;


oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "दो" "बीस" r2 ;
lin n3 = mkNum "तीन" "तीस" r3 ;
lin n4 = mkNum "चार" "चालीस" r4 ;
lin n5 = mkNum "पांच" "पचास" r5 ;
lin n6 = mkNum "छे" "साटh'" r6 ; 
lin n7 = mkNum "सात" "सततर" r7; 
lin n8 = mkNum "आठ" "अससी" r8;
lin n9 = mkNum "नौ" "नववे" r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "ह" ;
  r2 => a2 + "स" ;
  r3 => a3 + "तीस" ;
  r4 => a4 + "ालीस" ;
  r5 => a5 + "न" ;
  r6 => a6 + "सठ" ;
  r7 => a7 + "त्तर" ;
  r8 => a8 + "ासी" ;
  r9 => a9 + "ानwवे"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "ग्यार" "इककी" "इकत" "इकत" "इकयाव" "इक" "इकह" "इकय" "इकय" ; 
  r2 => mkR "बार" "बाई" "बत" "बैत" "बाव" "बा" "बह" "बय" "ब" ;
  r3 => mkR "तेर" "तेई" "तैं" "तैंत" "तिरप" "तिर" "तिह" "तिर" "तिर" ;
  r4 => mkR "चौद" "चौबी" "चौं" "चौव" "चww" "चौँ" "चौह" "चw+र" "चौर" ;
  r5 => mkR "पंदर" "पचची" "पैं" "पैंत" "पचप" "पैँ" "पिछ" "पच" "पिच" ;
  r6 => mkR "सोल" "चa'बबी" "छात" "छिय" "छपप" "छिया" "चिह" "छिय" "छिय" ;
  r7 => mkR "सतर" "सतताई" "सैं" "सैंत" "सताव" "सढ़" "सतह" "सत" "सत" ;
  r8 => mkR "अठार" "टh'ाई" "अढ़" "अढ़त" "अठाव" "अढ़" "अटह" "अठ" "अठ" ; 
  r9 => table {sg => "उननीस" ; r2 => "उनततीस" ; r3 => "उंतालीस" ; 
               r4 => "उंचास" ; r5 => "उनसठ" ; r6 => "उनहततर" ; 
               r7 => "उनससी" ; 
               r8 => "उनननवे" ; r9 => "निन्यानवे" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "एक" ; _ => "दमी" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "दस" ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = Pl} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = Pl} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = Pl} ;

lin pot1as2 n = {s = n.s ; s2 = "दमी" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "लाख" ; size = more100 ; n = Pl} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "लाख" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = Pl} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "हज़ार" ; 
                          more100 => n.s2 } ! n.size ; n = Pl} ;
lin pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "हज़ार" ; 
              more100 => n.s2 } ! n.size ++ m.s ; n = Pl} ;

lin D_0 = { s = "०" ; n = Sg};
lin D_1 = { s = "१" ; n = Sg};
lin D_2 = { s = "२" ; n = Pl};
lin D_3 = { s = "३" ; n = Pl};
lin D_4 = { s = "४" ; n = Pl};
lin D_5 = { s = "५" ; n = Pl};
lin D_6 = { s = "६" ; n = Pl};
lin D_7 = { s = "७" ; n = Pl};
lin D_8 = { s = "८" ; n = Pl};
lin D_9 = { s = "९" ; n = Pl};
lin IDig d = { s = \\_ => d.s ; n = d.n} ;
lin IIDig d dg = { s = \\df => Prelude.glue (dg.s ! df) d.s ; n = Pl }; 

oper ekhazar : Str = variants {"हज़ार" ; "एक" ++ "हज़ार"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "हज़ार"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "एक" ++ "सौ" ; _ => s ++ "सौ"} ! sz ;
}
