include numerals.Abs.gf ;

-- No long consonants marked in the indigen. script
-- s is set intersection s
-- h is set union h
-- H is three-fork h
-- x is hook-looking h
-- L is sin-looking s
-- X is h looking like k with a roof
-- Z is zh
-- $ is sh
-- ) is the glottal stop hamza = independent vowel in word
-- ( is 3ayn 
-- Capitalis for ejectives KPTCS
-- stress not indicated in indigen. script

param DForm = unit | ten ;
param Size = sg | less100 | more100 ;
param Ending = zero | nonzero | tenzero; 
param S100 = tenp | tenpalf | unitp ;
param S1000 = indep | alf | tenm | tailform ;

oper LinDigit = {s : DForm => Str ; size : Size} ;

lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Str ; s2 : S100 => Str ; unitp_ending : Ending ; size : Size} ;
lincat Sub1000 = {s : S1000 => Str ; ending : Ending ; size : Size } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = "/E" ++ x0.s ++ "E/"} ; -- The Ethiopic script environment
lin n2 = mkNum "kïl)etu" "(ï$ra" ; 
lin n3 = mkNum "Lälastu" "Lälasa"  ;
lin n4 = mkNum ")ärba(tu" ")ärbï(a" ;
lin n5 = mkNum "xämïstu" "xämsa" ;
lin n6 = mkNum "sïdïstu" "sïssa" ;
lin n7 = mkNum (variants { "säb(ätu" ; "säb(atu" }) "säb(a" ;
lin n8 = mkNum (variants { "sämantu" ; "sämanitu" }) "sämanya" ;
lin n9 = mkNum (variants { "tïs(ätu" ; "täs(ätu" ; "täsa(tu" }) (variants {"täs(a" ; "tïs(a"}) ;

oper mkNum : Str -> Str -> LinDigit = \tva -> \tjugo ->
  {s = table {unit => tva ; ten => tjugo} ; size = less100 } ;

lin pot01  =
  {s = table {unit => ")äHädu" ; ten => "(ä$ärtu" } ; size = sg};
lin pot0 d = d ;
lin pot110 = {s = "(ä$ärtu" ; 
              s2 = table {tenp => "wä" ++ ")äHädu" ;
                          tenpalf => ")ïlf" ;
                          unitp => [] } ; 
              unitp_ending = zero ;
              size = less100} ;
lin pot111 = {s = "(ä$ärtu" ++ "wä" ++ ")äHädu" ; 
              s2 = table {tenp => "wä" ++ ")äHädu" ;
                          tenpalf => ")ïlf" ;
                          unitp => "(ä$ärtu" } ;
              unitp_ending = nonzero ;
              size = less100} ;
lin pot1to19 d = 
  {s = "(ä$ärtu" ++ "wä" ++ d.s ! unit ; 
   s2 = table {tenp => "wä" ++ ")äHädu" ;
               tenpalf => ")ïlf" ;
               unitp => d.s ! ten } ;
   unitp_ending = nonzero ;
   size = less100} ;
lin pot0as1 n = 
  {s = n.s ! unit ; 
   s2 = table {unitp => n.s ! ten ; _ => [] };
   unitp_ending = nonzero ; 
   size = n.size} ;
lin pot1 d = 
  {s = d.s ! ten ;
   s2 = table {tenp => "wä" ++ d.s ! unit ;
               tenpalf => d.s ! unit ++ ")ïlf" ;
               unitp => [] } ; 
   unitp_ending = tenzero ;
   size = less100} ;
lin pot1plus d e = 
  {s = d.s ! ten ++ "wä" ++ e.s ! unit ; 
   s2 = table {tenp => "wä" ++ d.s ! unit ;
               tenpalf => d.s ! unit ++ ")ïlf" ;
               unitp => e.s ! ten } ; 
   unitp_ending = nonzero ; 
   size = less100} ; 
lin pot1as2 n = 
  {s = table {indep => n.s ;
              tailform => n.s ;
              tenm => n.s2 ! unitp ;            
              alf => n.s2 ! tenpalf ++ n.s2 ! unitp } ; 
   ending = n.unitp_ending ;
   size = n.size} ;
lin pot2 d = 
  {s = table {indep => table {sg => "mï)t" ; _ => d.s ! unit ++ "mï)t" } ! d.size ;
              tenm => "dummy" ;
              alf => d.s ! ten ++ ")ïlf" ; 
              tailform => d.s ! unit ++ "mï)t" } ; 
   size = more100 ;
   ending = zero} ;
lin pot2plus d e = 
  {s = table {indep => table {sg => "mï)t" ; _ => d.s ! unit ++ "mï)t" } ! d.size ++ e.s ; 
              tenm => "dummy";
              alf => d.s ! ten ++ e.s2 ! tenp ++ ")ïlf" ++ e.s2 ! unitp ; 
              tailform => d.s ! unit ++ "mï)t" ++ e.s} ;	      
   size = more100 ;
   ending = e.unitp_ending } ;

lin pot2as3 n = {s = n.s ! indep } ;
lin pot3 n =
  {s = table {more100 => mkmit n.ending (n.s ! alf) ; _ => n.s ! tenm ++ "mï)t"} ! n.size} ;
lin pot3plus n m = 
  {s = table 
     {more100 => table {more100 => n.s ! alf ; less100 => n.s ! alf ;  _ => n.s ! tenm} ! n.size ++ 
                 table {zero => m.s ! indep ;
                        tenzero => m.s ! indep ; 
                        nonzero => "wä" ++ m.s ! tailform } ! n.ending;
      _ => table {more100 => mkmit n.ending (n.s ! alf) ;
                  less100 => n.s ! alf ++ table {nonzero => "mï)t" ; _ => []} ! n.ending ;
                  _ => n.s ! tenm ++ "mï)t"} ! n.size ++ m.s ! indep} ! m.size } ;

oper mkmit : Ending -> Str -> Str = \e -> \s -> table {zero => [] ; _ => s ++"mï)t" } ! e; 