concrete NumeralNep of Numeral = CatNep ** open ResNep, Prelude in {
-- By Harald Hammarstroem
-- Modification for Nepali by Dinesh Simkhada and Shafqat Virk - 2011
 flags coding=utf8 ;


param DForm = unit | ten ;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ;
param Size = singl | less100 | more100 ; 

oper LinDigit = {s : DForm => Str ; size : DSize ; n : Number} ;


lincat Dig = {s:Str ; n : Number} ;
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : DSize ; n : Number} ;
lincat Sub100 = {s : Str ; size : Size ; n : Number} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size ; n : Number } ; 
lincat Sub1000000 = {s : Str ; n : Number } ;

lin num x0 = 
    {s = table {
          NCard => x0.s ; 
          NOrd  => Prelude.glue x0.s "ौँ"  -- need to use mkOrd x0.s but it gives linking error 
          };
       n = x0.n
    } ; 



oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "दुई" "बीस"     r2 ;
lin n3 = mkNum "तीन"  "तीस"     r3 ;
lin n4 = mkNum "चार"  "चालीस"   r4 ;
lin n5 = mkNum "पाँच" "पचास"    r5 ;
lin n6 = mkNum "छ"    "साठी"    r6 ; 
lin n7 = mkNum "सात"  "सत्तरी" r7 ;  -- सत्तरी
lin n8 = mkNum "आठ"   "असी"     r8 ;
lin n9 = mkNum "नौ"   "नब्बे"  r9 ; 

oper 
  mkR : (a1,_,_,_,_,_,_,_,a9 : Str) -> DSize => Str = 
   \a1,a2,a3,a4,a5,a6,a7,a8,a9 -> table {
     sg => a1 ; 
     r2 => a2 ;
     r3 => a3 ;
     r4 => a4 ;
     r5 => a5 ;
     r6 => a6 ;
     r7 => a7 ;
     r8 => a8 ;
     r9 => a9
    } ; 

  -- REF http://dsal.uchicago.edu/dictionaries/schmidt/
  -- Ordinals from One - Hundred are irregular
  rows : DSize => DSize => Str = table {
    sg => mkR "एघार"       "एक्काइस" "एकतीस"   "एकचालीस"  "एकाउन्‍न"   "एकसठ्ठी"  "एकहत्तर"  "एकासी"   "एकान्‍नब्बे" ;  
    r2 => mkR "बाह्र"      "बाइस"      "बत्तीस"  "बयालीस"    "बाउन्‍न"     "बैसठ्ठी"   "बहत्तर"    "बयासी"    "बयान्‍नब्बे" ; 
    r3 => mkR "तेह्र"      "तेइस"     "तेत्तीस"  "त्रिचालीस" "त्रिपन्‍न" "त्रिसठ्ठी" "त्रिहत्तर" "त्रियासी" "त्रियान्‍नब्बे" ;
    r4 => mkR "चौध"         "चौबीस"     "चौंतीस"    "चवालीस"    "चवन्‍न"      "चौसठ्ठी"   "चौहत्तर"   "चौरासी"   "चौरान्‍नब्बे"; 
    r5 => mkR "पन्ध्र"    "पच्चीस"   "पैंतीस"    "पैंतालीस"  "पचपन्‍न"     "पैंसठ्ठी"  "पचहत्तर"   "पचासी"    "पन्चान्‍नब्बे" ; 
    r6 => mkR "सोह्र"      "छब्बीस"   "छत्तीस"   "छयालीस"    "छपन्‍न"      "छैंसठ्ठी"  "छयहत्तर"   "छयासी"    "छयान्‍नब्बे" ; 
    r7 => mkR "सत्र"       "सत्ताइस" "सौंतीस"    "सतचालीस"   "सन्ताउन्‍न" "सतसठ्ठी"   "सतहत्तर"   "सतासी"    "सन्तान्‍नब्बे" ; 
    r8 => mkR "अठार"        "अठ्ठाइस" "अठतीस"     "अठतालीस"   "अन्ठाउन्‍न" "अठसठ्ठी"   "अठहत्तर"   "अठासी"    "अन्ठान्‍नब्बे" ;
    r9 => mkR "उन्‍नाइस" "उनन्तीस"  "उनन्चालीस" "उनन्पचास" "उनन्साठी"    "उनन्सत्तरी" "उनासी"    "उनान्‍नब्बे" "उनान्सय"  
  } ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "एक" ; _ => "दमय" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "दस" ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = d.n} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = d.n} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = d.n} ;

lin pot1as2 n = {s = n.s ; s2 = "दमय" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "लाख" ; size = more100 ; n = d.n} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "लाख" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = d.n} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "हजार" ; 
                          more100 => n.s2 } ! n.size ; n = n.n} ;
lin pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "हजार" ; 
              more100 => n.s2 } ! n.size ++ m.s ; n = n.n} ;

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

lin IIDig d dg = { s = \\df => Prelude.glue d.s (dg.s ! df) ; n = Pl }; 

oper ekhazar : Str = variants {"एक" ++ "हजार" ; "हजार"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "हजार"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "एक" ++ "सय" ; _ => s ++ "सय"} ! sz ;
}
