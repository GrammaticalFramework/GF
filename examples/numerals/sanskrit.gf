include numerals.Abs.gf ;

param DForm = unit | ten ;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ; 
param Size = sing | dual | less10 | more100 | more10 ; 


oper 
  vowel : Strs = strs {"a" ; "e" ; "i" ; "u" ; "o"} ;  
  dental : Strs = strs {"n"; "t"; "d"} ;  
  labial : Strs = strs {"m"; "p"; "b"} ;
  velar : Strs = strs {"G"; "k"; "g"} ;
  affricate : Strs = strs {"ñ" ; "c"; "j" } ; 
  retroflex : Strs = strs {"N" ; "T" ; "D"; "S"} ;  
  sibilant : Strs = strs {"ç" ; "s"; "h"; "r"} ; -- r also
  unvoiced : Strs = strs {"k"; "p"; "c"; "t"} ; 

oper
  S : Str = pre {"S" ; "T" / unvoiced ; "D" / vowel } ;  
  as : Str = pre {"o" ; "as" / unvoiced ; "a;" / sibilant } ; 
  i : Str = pre {"i" ; "y" / vowel } ;
  am : Str = "a" + (pre {"m" ; "n" / dental ; "G" / velar ; "ñ" / affricate ; "N" / retroflex ; "M" / sibilant}) ;
  a_ : Str = pre { "a:" ; "a" / vowel } ; -- shortened if a follows (no other vowel occur initally)  
  r : Str = pre {"r" ; "s" / unvoiced ; "c" / affricate ; ";" / sibilant } ;
  t : Str = pre {"t" ; "c" / affricate ; "T" / retroflex } ;
  

LinDigit = {s : DForm => Str ; size : DSize} ;
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : DSize} ;
lincat Sub100 = {s : Str ; s2 : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size } ; 

lin num x0 =
  {s = "/&" ++ x0.s ++ "&/"} ; -- the Devanagari environment

oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \u -> \t -> \sz -> 
  {s = table {unit => u ; ten => t } ; size = sz } ;

-- lin n1 mkNum "eka" daca ... ;
lin n2 = mkNum "dva" viMcati r2 ;
lin n3 = mkNum ("tr" + i) triMcat r3 ;
lin n4 = mkNum ("catu" + r) catvariMcat r4 ;
lin n5 = mkNum "pañca" pancacat r5 ;
lin n6 = mkNum ("Sa" + S) SaSTi r6 ;
lin n7 = mkNum "sapta" saptati r7 ; 
lin n8 = mkNum "aSTa" aciti r8;
lin n9 = mkNum "nava" navati r9 ;

oper daca : Str = "daça" ;
oper viMcati : Str = "viMçat" + i;
oper triMcat : Str = "triMça" + t;
oper catvariMcat : Str = "catva:riMça" + t ;
oper pancacat : Str = "pañca:ça" + t;
oper SaSTi : Str = "SaST" + i;
oper saptati : Str = "saptat" + i ;
oper aciti : Str = "açi:t" + i ;
oper navati : Str = "navat" + i ;

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
  sg => variants {a1 + daca ; "u:na:" + viMcati} ;
  r2 => variants {a1 + viMcati ; "u:na:" + triMcat } ;
  r3 => variants {a1 + triMcat ; "u:na:" + catvariMcat } ;
  r4 => variants {a1 + catvariMcat ; "u:na:" + pancacat } ;
  r5 => variants {a1 + pancacat ; "u:na:" + SaSTi } ;
  r6 => variants {a1 + SaSTi ; "u:na:" + saptati } ;
  r7 => variants {a1 + saptati ; "u:na:" + aciti } ;
  r8 => variants {a1 + aciti ; "u:na:" + navati } ;
  r9 => variants {a1 + navati ; "u:na:" + cata } 
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
  sg => "SoDaça" ; 
  r2 => a1 + viMcati ;
  r3 => a1 + triMcat ;
  r4 => a1 + catvariMcat ; 
  r5 => a1 + pancacat ;
  r6 => a1 + SaSTi ;
  r7 => a1 + saptati ;  
  r8 => a1 + aciti ;
  r9 => "SoNNavat" + i 
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR1 ("ek" + a_) eka ; 
  r2 => mkR3 ("dv" + a_) ("dv" + i) ; 
  r3 => mkR3 ("tray" + as)  ("tr" + i) ; 
  r4 => mkR ("catu" + r) ;
  r5 => mkR "pañca" ;
  r6 => mkR6 ("Sa" + S) ;
  r7 => mkR "sapta" ;
  r8 => mkR3 ("aST" + a_) "aSTa" ; 
  r9 => mkR9 "nava"
} ;

oper eka : Str = "eka" ;

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

oper mksahasra2 : Size -> Str -> Str = \sz -> \s -> table {sing => "sahasr" + am ; dual => "dve" ++ "sahasre" ; _ => s ++ ("sahasra:N" + i)} ! sz ;
oper mksahasra : DSize -> Str -> Str = \sz -> \s -> table {sg => "sahasr" + am ; r2 => "dve" ++ "sahasre" ; _ => s ++ ("sahasra:N" + i)} ! sz ;
oper mkcata : DSize -> Str -> Str = \sz -> \s -> table {sg => cata ; r2 => variants {"dve" ++ "çate" ; "dvi:" + cata }; _ => s ++ ("çata:n" + i)} ! sz ;
oper mklakh : DSize -> Str -> Str = \sz -> \s -> table {sg => "lakS" + am ; r2 => "dve" ++ "lakSe" ; _ => s ++ ("lakSa:N" + i) } ! sz ;
oper mklakh2 : Size -> Str -> Str = \sz -> \s -> table {sing => "lakS" + am ; dual => "dve" ++ "lakSe" ; _ => s ++ ("lakSa:N" + i) } ! sz ;

oper mkayuta : DSize -> Str -> Str = \sz -> \s -> table {sg => "ayut" + am ; r2 => "dve" ++ "ayute" ; _ => s ++ ("ayuta:n" + i)} ! sz ;

oper adhikam : Str = "adHik" + am ;
oper ca : Str = "ca" ;
oper ayuta : Str = "ayut" + am ; 
oper cata : Str = "çat" + am ; 

oper hundredplusunit : Str -> Str -> Str = \hun -> \unit -> 
   variants {hun ++ unit ++ "ca" ; unit ++ adhikam ++ hun};

oper lakhplus : Str -> Str -> Str = \lakh -> \low -> lakh ++ low ++ ca ;

oper p3plus : Str -> Size -> Str -> Size -> Str = \b -> \bs -> \s -> \ss -> table {more10 => table {more10 => b ++ ca ++ s ++ ca ; _ => s ++ adhikam ++ b} ! ss;
  _ => table {more10 => b ++ s ++ ca ;  _ => s ++ b} ! ss } ! bs;

mkayutamore : Str -> DSize -> Str -> DSize -> Str = \d -> \ds -> \e -> \es ->
  variants {(mkayuta ds d) ++ (mksahasra es e) ; 
            mklakh2 more10 (rows ! es ! ds) } ;

