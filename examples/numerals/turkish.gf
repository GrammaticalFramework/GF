include numerals.Abs.gf ;

param DForm = unit | ten | teen ;
param Size = sg | pl ;

-- ç is c with a cedille (obviously)
-- s, is s with a cedille 
-- I is i without a dot 
-- g% is yumus,ak ge (i.e a g with a breve)

-- The hundreds and trheir qualif can be written together e.g ikiyüz
-- aswelll as ten + unit e.g yirmibir 

lincat Digit = {s : DForm => Str } ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Str ; size : Size } ;
lincat Sub1000 = {s : Str ; size : Size } ;

oper mkNum : Str -> Str -> Lin Digit = 
  \iki -> \yirmi ->  
  {s = table {unit => iki ; teen => (variants {"on" + iki ; "on" ++ iki})  ; ten => yirmi } } ;

lin num x = {s = "/L" ++ x.s ++ "L/" } ;

-- lin n1 mkNum "bir" "dA" ;
lin n2 = mkNum "iki" "yirmi" ; 
lin n3 = mkNum "üç" "otuz" ;
lin n4 = mkNum "dört" "kIrk" ;
lin n5 = mkNum "bes," "elli" ;
lin n6 = mkNum "altI" "altmIs," ;
lin n7 = mkNum "yedi" "yetmis," ;
lin n8 = mkNum "sekiz" "seksen" ;
lin n9 = mkNum "dokuz" "doksan" ; 

oper ss : Str -> {s : Str ; size : Size} = \s -> {s = s ; size = pl} ;

lin pot01 = {s = table {f => "bir"} ; size = sg} ;
lin pot0 d = {s = table {f => d.s ! f} ; size = pl} ;
lin pot110 = ss "on" ; 
lin pot111 = ss (variants { "on" ++ "bir" ; "onbir"});
lin pot1to19 d = {s = d.s ! teen ; size = pl} ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; size = pl} ;
lin pot1plus d e = {s = d.s ! ten ++ e.s ! unit; size = pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = table {sg => [] ; _ => d.s ! unit} ! d.size ++ "yüz" ; size = pl} ;
lin pot2plus d e = {s = table {sg => [] ; _ => d.s ! unit} ! d.size ++ "yüz" ++ e.s ; size = pl} ;

lin pot2as3 n = n ;
lin pot3 n = {s = table {sg => [] ; _ => n.s } ! n.size ++ "bin"} ;
lin pot3plus n m = {s = table {sg => [] ; _ => n.s } ! n.size ++ "bin" ++ m.s} ;





