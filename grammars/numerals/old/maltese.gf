include numerals.Abs.gf ;

param DForm = unit | teen | teenil | ten | hund ;
param Size = sg | pl | dual ;

oper LinDigit = {s: DForm => Str ; s2 : Str ; size : Size } ;
oper Form = {s : Str ; s2 : Str ; size : Size } ;

lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = Form ;
lincat Sub1000 = Form ;
lincat Sub1000000 = {s : Str} ;

lin num x = x ; -- TODO 

oper mkN : Str -> Str -> Str -> Str -> Str -> LinDigit = \u -> \tn -> \t -> \h -> \e ->
  {s = table {unit => u ; teen => tn + "ax" ; teenil => tn + "ax" + "il" ; 
              ten => t ; hund => h ++ "mija"} ; s2 = e ; size = pl }; 

lin n2 =
  {s = table {unit => "tnejn" ; 
              teen => "tnax" ; teenil => "tnax-il" ;
              ten  => "gh-oxrin" ;
              hund => "mitejn"} ; s2 = "tnejn" ; size = dual} ;
lin n3 = mkN "tlieta" "tlett" "tletin" "tliet" "tlitt";
lin n4 = mkN "erbgh-a" "erbat" "erbgh-in" "erba'" "erbat";
lin n5 = mkN "h-amsa" "h-mist" "h-amsin" "h-ames" "h-amest" ;
lin n6 = mkN "sitta" "sitt" "sitt" "sitt" "sitt"; 
lin n7 = mkN "sebgh-a" "sbat" "sbebgh-in" "seba'" "sebat" ;
lin n8 = mkN "tmienja" "tmint" "tmenin" "tmien" "tmint" ; 
lin n9 = mkN "disgh-a" "dsat" "disgh-in" "disa'" "disat"; 

oper ss : Str -> Form = \s1 -> {s = s1 ; s2 = s1 ; size = pl };
oper ss2 : Str -> Str -> Form = \a -> \b -> {s = a ; s2 = b ; size = pl };

lin pot01  =
  {s = table {unit => "wieh-ed" ; teen => "h-dax" ; _ => "mija" } ; 
   s2 = "wieh-ed" ; 
   size = sg};
lin pot0 d = d; 
lin pot110 = ss "gh-axra" ; 
lin pot111 = ss2 "h-dax" "h-dax-il"; 
lin pot1to19 d = ss2 (d.s ! teen) (d.s ! teenil);
lin pot0as1 n = {s = n.s ! unit ; s2 = n.s2 ; size = n.size} ;
lin pot1 d = ss (d.s ! ten) ;
lin pot1plus d e = ss ((e.s ! unit) ++ "u" ++ (d.s ! ten)) ;
lin pot1as2 n = n ;
lin pot2 d = ss (d.s ! hund) ;
lin pot2plus d e = ss2 ((d.s ! hund) ++ "u" ++ e.s) 
                       ((d.s ! hund) ++ "u" ++ e.s2) ;
lin pot2as3 n = {s = n.s } ;
lin pot3 n = { s = (elf n.s2) ! n.size } ; 
lin pot3plus n m = { s = (elf n.s2) ! n.size ++ m.s} ;

oper elf : Str -> Size => Str = \attr ->
  table {pl => attr ++ "elef" ; dual => "elfejn" ; sg => "elf"} ;
 
