concrete hindi of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=devanagari ;

param DForm = unit | ten ;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ;
param Size = sing | less100 | more100 ; 

oper LinDigit = {s : DForm => Str ; size : DSize} ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : DSize} ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size } ; 
lincat Sub1000000 = { s : Str } ;

lin num x0 =
  {s = [] ++ x0.s ++ []} ; -- the Devana:gari environment


-- H is for aspiration (h is a sepaarate letter)
-- M is anusvara
-- ~ is candrabindhu
-- c is is Eng. ch in e.g chop 
-- cH is chH
-- _: is length
-- T, D, R are the retroflexes

oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz } ;

-- lin n1 mkNum "एक" "ग्यारह" "दस" 
lin n2 = mkNum "दो" "बीस" r2 ;
lin n3 = mkNum "तीन" "तीस" r3 ;
lin n4 = mkNum "चार" "चालीस" r4 ;
lin n5 = mkNum "पाँ्न्च" "पचास" r5 ;
lin n6 = mkNum (variants {"छह" ; "छः" ; "छै"}) "साठ" r6 ; 
lin n7 = mkNum "सात" "सत्तर" r7; 
lin n8 = mkNum "आठ" "अस्सी" r8;
lin n9 = mkNum "नौ" (variants {"नव्वे" ; "नब्बे" }) r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "अह" ;
  r2 => a2 + "ईस" ;
  r3 => a3 + "तीस" ;
  r4 => a4 + "आलीस" ;
  r5 => a5 + "अन" ;
  r6 => a6 + "सठ" ;
  r7 => a7 + "हत्तर" ;
  r8 => a8 + "आसी" ;
  r9 => a9 + "आनवे"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "ग्यार" "इक्क" "इकत" "एक्त" "इक्याव" "इक" "इक" "इक्य" "इक्य" ; 
  r2 => mkR "बार" "बा" "बत" "बय" "बाव" "बा" "ब" "बय" "ब" ;
  r3 => mkR "तेर" "ते" "तैं" "तैंत" "तिर्प" "तिर" "ति" "तिर" "तिर" ;
  r4 => mkR "चौद" "चौब" "चौं" "चव" "चौप" "चौं" "चौ" "चौर" "चौर" ;
  r5 => mkR "पंद्र" "पच्च" "पैं" "पैंत" "पच्प" "पैं" "पच" "पच" "पच" ;
  r6 => mkR "सोल" "छब्ब" "छत" "छिय" "छप्प" "छिया" "छि" "छिय" "छिय" ;
  r7 => mkR (variants { "सत्त्र" ; "सत्र"}) "सत्ताव" "सैं" "सैंत" "सत्ता" "सर" "सत" (variants {"सत्त" ; "सत" }) "सत्त" ;
  r8 => mkR "अठार" "अट्ठा" "अR" "अR्त" "अट्ठाव" "अR" "अठ" (variants { "अट्ठ" ; "अठ" }) "अट्ठ" ; 
  r9 => table {sg => "उन्नीस" ; r2 => "उनतीस" ; r3 => "उनतालीस" ; 
               r4 => "उनचास" ; r5 => "उनसठ" ; r6 => "उनहत्तर" ; 
               r7 => (variants{"उन्नासी" ; "उन्यासी"}) ; 
               r8 => "नवासी" ; r9 => "निन्यानवे" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "एक" ; _ => "दुम्म्य" } ; size = sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "दस" ; size = less100} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => sing ; _ => less100} ! n.size } ;

lin pot1 d = {s = d.s ! ten ; size = less100} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100} ;

lin pot1as2 n = {s = n.s ; s2 = "दुम्म्य" ; size = n.size } ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "लाख" ; size = more100} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "लाख" ++ (mkhazar e.s e.size) ; 
   size = more100} ;

lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = table { sing => ekhazar ;
                          less100 => n.s ++ "हज़ार" ; 
                          more100 => n.s2 } ! n.size} ;
lin pot3plus n m = 
  {s = table {sing => ekhazar ;
              less100 => n.s ++ "हज़ार" ; 
              more100 => n.s2 } ! n.size ++ m.s} ;


oper ekhazar : Str = variants {"हज़ार" ; "एक" ++ "हज़ार"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {sing => ekhazar ; _ => s ++ "हज़ार"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "सौ" ; _ => s ++ "सौ"} ! sz ;

}
