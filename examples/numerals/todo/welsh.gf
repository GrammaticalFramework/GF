concrete welsh of Numerals = {
-- include numerals.Abs.gf ;

-- The neo-base-10 system dauddeg, trideg, pedwardeg, pumdeg/hanner cant, chwedeg, saithdeg, wythdeg, nawdeg is
-- implemented as the second variant as it should be 

oper LinDigit = {s : DForm => Str ; even20 : Even20 ; size : Size} ;
oper LinSub100 = {s : Str ; size : Size} ;

oper mk20Ten : Str -> Str -> Str -> Str -> Size -> LinDigit = 
  \tri -> \trideg -> \fiche -> \triarddeg -> \sz -> 
  { s = table {unit => tri ; twenty => fiche ; teen => triarddeg ; ten => trideg} ; even20 = odd ; size = sz} ;

oper mkEven20 : Str -> Str -> Str -> Str -> Size -> LinDigit = 
  \tri -> \trideg -> \fiche -> \triarddeg -> \sz -> 
  { s = table {unit => tri ; twenty => fiche ; teen => triarddeg ; ten => trideg} ; even20 = even ; size = sz} ;

param Even20 = odd | even ;
param DForm = unit | ten | twenty | teen ;
param Size = sg | mutation | am | pl | five | overten;
 
lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = LinSub100 ;
lincat Sub1000 = LinSub100 ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;
lin n2  = mkEven20 "dau" "dauddeg" "hugain" "deuddeg" mutation ; 
lin n3  = mk20Ten "tri" "trideg" "hugain" ("tri" ++ "ar" ++ "deg") am ;
lin n4  = mkEven20 "pedwar" "pedwardeg" "deugain" ("pedwar" ++ "ar" ++ "ddeg") pl ;
lin n5  = mk20Ten ("pum" + p) "pumdeg" "deugain" "pymtheg" five ;
lin n6  = mkEven20 ("chwe" + ch) "chwedeg" "trigain" ("un" ++ "ar" ++ "bymtheg") am ;
lin n7  = mk20Ten "saith" "saithdeg" "trigain" ("dau" ++ "ar" ++ "bymtheg") pl ;
lin n8  = mkEven20 "wyth" "wythdeg" ("pedwar" ++ "ugain") "deunaw" pl ;
lin n9  = mk20Ten "naw" "nawdeg" ("pedwar" ++ "ugain") ("pedwar" ++ "ar" ++ "bymtheg") pl ;
oper AR : Str = pre {"ar" ; "a" / strs {"d"} } ; 
oper AG : Str = pre {"a" ; "ag" / strs {"a" ; "u" ; "i" ; "e" ; "o" ; "w"} } ; -- before vowel
oper ng : Str = pre {"g" ; "ng" / strs {"m"} } ;
oper t : Str = pre {[] ; "t" / strs {[]}} ; 
oper ch : Str = pre {[] ; "ch" / strs{[]}} ;
oper p : Str = pre {[] ; "p" / strs{[]}} ;

oper mkR : Str -> LinSub100 = \s1 -> {s = s1 ; size = overten } ;
oper mkR2 : Str -> Size -> LinSub100 = \s1 -> \sz -> {s = s1 ; size = table {mutation => mutation ; am => am ; _ => overten} ! sz } ;

lin pot01  =
  {s = table {unit => "un" ; _ => "dummy"} ; even20 = odd ; size = sg};
lin pot0 d = d ;
lin pot110 = {s = "de" + ng ; size = pl} ; 
lin pot111 = mkR (variants {"un" ++ "ar" ++ "ddeg" ; "undeg" ++ "un"}) ;
lin pot1to19 d = mkR (variants {d.s ! teen ; "undeg" ++ d.s ! unit}) ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = table {mutation => mkR (variants {"ugain" ; "dauddeg" }) ; 
                    five => mkR (variants {"hanner" ++ "cant" ; "deg" ++ "a" + "deugain" ; "pumdeg"}) ;
                    _ => mkR (variants { table {even => d.s ! twenty ; odd => "deg" ++ AR ++ d.s ! twenty} ! d.even20 ; d.s ! ten}) } ! d.size ; 
lin pot1plus d e = mkR2 (variants { table {even => e.s ! unit ++ AR ++ d.s ! twenty ; odd => e.s ! teen ++ AR ++ d.s ! twenty} ! d.even20 ; d.s ! ten}) e.size ; -- hugain
lin pot1as2 n = n ;
lin pot2 d = mkR ((CANT (d.s ! unit)) ! d.size) ;
lin pot2plus d e = mkR2 (((CANT (d.s ! unit)) ! d.size) ++ (maybeAG ! e.size) ++ e.s) e.size;
lin pot2as3 n =
  {s = n.s } ;
lin pot3 n =
  {s = (MIL n.s) ! n.size } ;
lin pot3plus n m =
  {s = (MIL n.s) ! n.size ++ m.s } ;

oper maybeAG : Size => Str = (table {overten => [] ; _ => AG} );
oper CANT : Str -> Size => Str = \s1 -> table {sg => "can" + t ; mutation => s1 ++ "gan" + t; am => s1 ++ "chan" + t ; _ => s1 ++ "can" + t} ;
oper MIL : Str -> Size => Str = \s1 -> table {sg => "mil" ; mutation => s1 ++ "fil" ; _ => s1 ++ "mil" } ;


}
