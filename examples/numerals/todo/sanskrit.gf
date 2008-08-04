concrete sanskrit of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=devanagari ;

param DForm = unit | ten ;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ; 
param Size = sing | dual | less10 | more100 | more10 ; 


oper 
  vowel : Strs = strs {"अ" ; "ए" ; "इ" ; "उ" ; "ओ"} ;  
  dental : Strs = strs {"न"; "त"; "द"} ;  
  labial : Strs = strs {"म"; "प"; "ब"} ;
  velar : Strs = strs {"ग़"; "क"; "ग"} ;
  affricate : Strs = strs {"ञ" ; "च"; "ज" } ; 
  retroflex : Strs = strs {"ण" ; "ट" ; "ड"; "ष"} ;  
  sibilant : Strs = strs {"श" ; "स"; "ह"; "र"} ; -- r also
  unvoiced : Strs = strs {"क"; "प"; "च"; "त"} ; 

oper
  S : Str = pre {"ष" ; "ट" / unvoiced ; "ड" / vowel } ;  
  as : Str = pre {"ओ" ; "अस" / unvoiced ; "अः" / sibilant } ; 
  i : Str = pre {"इ" ; "य" / vowel } ;
  am : Str = "अ" + (pre {"म" ; "न" / dental ; "ग़" / velar ; "ञ" / affricate ; "ण" / retroflex ; "ं" / sibilant}) ;
  a_ : Str = pre { "आ" ; "अ" / vowel } ; -- shortened if a follows (no other vowel occur initally)  
  r : Str = pre {"र" ; "स" / unvoiced ; "च" / affricate ; "ः" / sibilant } ;
  t : Str = pre {"त" ; "च" / affricate ; "ट" / retroflex } ;
  

LinDigit = {s : DForm => Str ; size : DSize} ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : DSize} ;
lincat Sub100 = {s : Str ; s2 : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size } ; 
lincat Sub1000000 = { s : Str } ;

lin num x0 =
  {s = [] ++ x0.s ++ []} ; -- the Devanagari environment

oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \u -> \t -> \sz -> 
  {s = table {unit => u ; ten => t } ; size = sz } ;

-- lin n1 mkNum "एक" daca ... ;
lin n2 = mkNum "द्व" viMcati r2 ;
lin n3 = mkNum ("त्र" + i) triMcat r3 ;
lin n4 = mkNum ("चतु" + r) catvariMcat r4 ;
lin n5 = mkNum "पञ्च" pancacat r5 ;
lin n6 = mkNum ("ष" + S) SaSTi r6 ;
lin n7 = mkNum "सप्त" saptati r7 ; 
lin n8 = mkNum "अष्ट" aciti r8;
lin n9 = mkNum "नव" navati r9 ;

oper daca : Str = "दश" ;
oper viMcati : Str = "विंशत" + i;
oper triMcat : Str = "त्रिंश" + t;
oper catvariMcat : Str = "चत्वारिंश" + t ;
oper pancacat : Str = "पञ्चाश" + t;
oper SaSTi : Str = "षष्ट" + i;
oper saptati : Str = "सप्तत" + i ;
oper aciti : Str = "अशीत" + i ;
oper navati : Str = "नवत" + i ;

oper mkR1 : Str -> Str -> DSize => Str = \a1 -> \a2 -> table {
  sg => a1 + daca ;
  r2 => a2 + viMcati ;
  r3 => a2 + triMcat ;
  r4 => a2 + catvariMcat ;
  r5 => a2 + pancacat ;
  r6 => a2 + SaSTi ;
  r7 => a2 + saptati ;
  r8 => a2 + aciti ;
  r9 => a2 + navati 
} ;

oper mkR : Str -> DSize => Str = \a1 -> table {
  sg => a1 + daca ;
  r2 => a1 + viMcati ;
  r3 => a1 + triMcat ;
  r4 => a1 + catvariMcat ;
  r5 => a1 + pancacat ;
  r6 => a1 + SaSTi ;
  r7 => a1 + saptati ;
  r8 => a1 + aciti ;
  r9 => a1 + navati 
} ;

oper mkR9 : Str -> DSize => Str = \a1 -> table {
  sg => variants {a1 + daca ; "ऊना" + viMcati} ;
  r2 => variants {a1 + viMcati ; "ऊना" + triMcat } ;
  r3 => variants {a1 + triMcat ; "ऊना" + catvariMcat } ;
  r4 => variants {a1 + catvariMcat ; "ऊना" + pancacat } ;
  r5 => variants {a1 + pancacat ; "ऊना" + SaSTi } ;
  r6 => variants {a1 + SaSTi ; "ऊना" + saptati } ;
  r7 => variants {a1 + saptati ; "ऊना" + aciti } ;
  r8 => variants {a1 + aciti ; "ऊना" + navati } ;
  r9 => variants {a1 + navati ; "ऊना" + cata } 
} ;

oper mkR3 : Str -> Str -> DSize => Str = \a1 -> \a2 -> table {
  sg => a1 + daca ;
  r2 => a1 + viMcati ;
  r3 => a1 + triMcat ;
  r4 => variants { a2 + catvariMcat ; a1 + catvariMcat } ; 
  r5 => variants { a2 + pancacat ; a1 + pancacat } ;
  r6 => variants { a2 + SaSTi ; a1 + SaSTi } ;
  r7 => variants { a2 + saptati ; a1 + saptati } ;  
  r8 => a2 + aciti ;
  r9 => variants { a2 + navati ; a1 + navati } 
} ;

oper mkR6 : Str -> DSize => Str = \a1 -> table {
  sg => "षोडश" ; 
  r2 => a1 + viMcati ;
  r3 => a1 + triMcat ;
  r4 => a1 + catvariMcat ; 
  r5 => a1 + pancacat ;
  r6 => a1 + SaSTi ;
  r7 => a1 + saptati ;  
  r8 => a1 + aciti ;
  r9 => "षोण्णवत" + i 
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR1 ("एक" + a_) eka ; 
  r2 => mkR3 ("द्व" + a_) ("द्व" + i) ; 
  r3 => mkR3 ("त्रय" + as)  ("त्र" + i) ; 
  r4 => mkR ("चतु" + r) ;
  r5 => mkR "पञ्च" ;
  r6 => mkR6 ("ष" + S) ;
  r7 => mkR "सप्त" ;
  r8 => mkR3 ("अष्ट" + a_) "अष्ट" ; 
  r9 => mkR9 "नव"
} ;

oper eka : Str = "एक" ;

lin pot01 = {s = table {unit => eka ; ten => daca } ; size = sg} ;
lin pot0 d = d ;
lin pot110 = {s = daca ; s2 = variants { ayuta ; mksahasra2 more10 daca }; size = more10} ; 
lin pot111 = {s = rows ! sg ! sg ; 
              s2 = mkayutamore eka sg eka sg ; 
              size = more10} ;
lin pot1to19 d = 
  {s = rows ! d.size ! sg ; 
   s2 = mkayutamore eka sg (d.s ! unit) d.size; 
   size = more10} ;
lin pot0as1 n = {s = n.s ! unit ; 
                 s2 = mksahasra n.size (n.s ! unit) ; 
                 size = table {sg => sing ; r2 => dual ; _ => less10} ! n.size };
lin pot1 d = {s = d.s ! ten ; 
              s2 = variants {mkayuta d.size (d.s ! unit) ; mksahasra2 more10 (d.s ! ten) } ; 
              size = more10} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; 
                    s2 = mkayutamore (d.s ! unit) d.size (e.s ! unit) e.size ; 
                    size = more10} ;
lin pot1as2 n = {s = n.s ; s2 = n.s2 ; size = n.size } ;
lin pot2 d = 
  {s = mkcata d.size (d.s ! unit);  
   s2 = mklakh d.size (d.s ! unit) ; 
   size = more100} ;

lin pot2plus d e = 
  {s = hundredplusunit (mkcata d.size (d.s ! unit)) e.s ; 
   s2 = lakhplus (mklakh d.size (d.s ! unit)) e.s2 ; 
   size = more100} ;

lin pot2as3 n = {s = n.s } ;
lin pot3 n = 
  {s = table {more10 => n.s2 ; 
              _  => mksahasra2 n.size n.s } ! n.size} ;

lin pot3plus n m = 
  {s = p3plus (table {more10 => n.s2 ; _  => mksahasra2 n.size n.s } ! n.size) n.size m.s m.size} ;

oper mksahasra2 : Size -> Str -> Str = \sz -> \s -> table {sing => "सहस्र" + am ; dual => "द्वे" ++ "सहस्रे" ; _ => s ++ ("सहस्राण" + i)} ! sz ;
oper mksahasra : DSize -> Str -> Str = \sz -> \s -> table {sg => "सहस्र" + am ; r2 => "द्वे" ++ "सहस्रे" ; _ => s ++ ("सहस्राण" + i)} ! sz ;
oper mkcata : DSize -> Str -> Str = \sz -> \s -> table {sg => cata ; r2 => variants {"द्वे" ++ "शते" ; "द्वी" + cata }; _ => s ++ ("शतान" + i)} ! sz ;
oper mklakh : DSize -> Str -> Str = \sz -> \s -> table {sg => "लक्ष" + am ; r2 => "द्वे" ++ "लक्षे" ; _ => s ++ ("लक्षाण" + i) } ! sz ;
oper mklakh2 : Size -> Str -> Str = \sz -> \s -> table {sing => "लक्ष" + am ; dual => "द्वे" ++ "लक्षे" ; _ => s ++ ("लक्षाण" + i) } ! sz ;

oper mkayuta : DSize -> Str -> Str = \sz -> \s -> table {sg => "अयुत" + am ; r2 => "द्वे" ++ "अयुते" ; _ => s ++ ("अयुतान" + i)} ! sz ;

oper adhikam : Str = "अधिक" + am ;
oper ca : Str = "च" ;
oper ayuta : Str = "अयुत" + am ; 
oper cata : Str = "शत" + am ; 

oper hundredplusunit : Str -> Str -> Str = \hun -> \unit -> 
   variants {hun ++ unit ++ "च" ; unit ++ adhikam ++ hun};

oper lakhplus : Str -> Str -> Str = \lakh -> \low -> lakh ++ low ++ ca ;

oper p3plus : Str -> Size -> Str -> Size -> Str = \b -> \bs -> \s -> \ss -> table {more10 => table {more10 => b ++ ca ++ s ++ ca ; _ => s ++ adhikam ++ b} ! ss;
  _ => table {more10 => b ++ s ++ ca ;  _ => s ++ b} ! ss } ! bs;

mkayutamore : Str -> DSize -> Str -> DSize -> Str = \d -> \ds -> \e -> \es ->
  variants {(mkayuta ds d) ++ (mksahasra es e) ; 
            mklakh2 more10 (rows ! es ! ds) } ;


}
