include numerals.Abs.gf ;

param DForm = unit | ten | teen | spctwo | twenties;
param Size = sg | two | less100 | more100 ; 

-- From Herbert Penzl's Pashto book. There's no standard orthography of
-- Pashto so minor deviations may occur
-- yaw can occur beforer zar and sal but usually doesn't
-- [e] is yaw with two vertical under
-- [$] is Ha with three dots above
-- [X] is Sin with one dot below and one above
-- [A] shouldnt have dots 
-- [p] is be with three dots below like Persian
-- [G] is za/ra etc with one dot below and one above
-- [a] should not have a hamza
-- [P] is a Ha with a hamza above
-- [R] is an r with a ring below

lincat Digit = {s : DForm => Str ; size : Size} ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size } ; 

lin num x0 =
  {s = "/A" ++ x0.s ++ "A/"} ; -- the Extented-Arabic environment

oper mkNum : Str -> Str -> Str -> Lin Digit = 
  \dwA -> \cl -> \dwwls ->  
  {s = table {unit => dwA ; ten => cl ; teen => dwwls ; spctwo => dwA ; twenties => dwA + "wict"} ; size = less100 } ;

oper mkIrrNum : Str -> Str -> Str -> Str -> Str -> Lin Digit = 
  \dwA -> \cl -> \dwwls -> \dw -> \dr ->  
  {s = table {unit => dwA ; ten => cl ; teen => dwwls ; spctwo => dw ; twenties 
=> dr + "wict"} ; size = less100 } ;

-- lin n1 mkNum "yw" "ls" ... ;
lin n2 = {s = table {unit => "dwA" ; ten => "cl" ; teen => "dwwls" ; 
                     spctwo => "dw" ; twenties => "dwA" + "wict" } ; 
          size = two }; 
lin n3 = mkIrrNum "dry" "derc" "dyarls" "dry" "dr" ;
lin n4 = mkIrrNum "$lwr" "$lweXt" "$wrls" "$lwr" "$ler";
lin n5 = mkNum "pnPA" "pnPws" (variants { "pnPAls"; "pnPls"}) ;
lin n6 = mkNum "cpG" "cpetA" "spaRls" ;
lin n7 = mkNum "awA" "awya" (variants {"awAls"; "awls"}) ;
lin n8 = mkNum "atA" "atya" (variants {"atAls"; "atls"}) ;
lin n9 = mkNum "nA" "nwy" (variants {"nwls"; "nwns"}) ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "yw" ; 
                        spctwo => "yw" ; 
                        twenties => "yw" + "wict" ; 
                        _ => "dummy" } ; size = sg} ;
lin pot0 d = {s = table {f => d.s ! f} ; size = less100} ;
lin pot110 = {s = "ls" ; size = less100} ; 
lin pot111 = {s = "ywwls" ; size = less100} ;
lin pot1to19 d = {s = d.s ! teen ; size = less100} ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; size = less100} ;
lin pot1plus d e = {s = table {two => e.s ! twenties ;  
                               _ => e.s ! spctwo ++ (d.s ! ten) } ! d.size ; 
                    size = less100} ;
lin pot1as2 n = {s = n.s ; s2 = "dummy" ; size = n.size } ;
lin pot2 d = {s = (mkswA (d.s ! unit)) ! d.size ; s2 = (mklk (d.s ! unit)) ! d.size ; size = more100} ;
lin pot2plus d e = 
  {s = (mkvarswA (d.s ! unit)) ! d.size ++ "aw" ++ e.s ; 
   s2 = (mklk (d.s ! unit)) ! d.size ++ e.s ++ (mkzrA ! e.size) ; 
   size = more100} ;

lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = table { sg => "zr" ;
			  two => n.s ++ "zrA" ;
                          less100 => n.s ++ "zrA" ; 
                          more100 => n.s2 } ! n.size} ;
lin pot3plus n m = 
  {s = table { sg => variants {"zr" ; "yw" ++ "zr"} ;
	       two => n.s ++ "zrA" ; 
               less100 => n.s ++ "zrA" ; 
               more100 => n.s2 } ! n.size ++ maybeaw ! m.size ++ m.s} ;


oper mklk : Str -> Size => Str = \s -> table {sg => "lk" ; _ => s ++ "lk"} ;
oper maybeaw : Size => Str = table {more100 => [] ; _ => "aw"} ;
oper mkswA : Str -> Size => Str = \s -> table {sg => "sl" ; _ => s ++ "swA"} ;
oper mkvarswA : Str -> Size => Str = 
  \s -> table {sg => (variants {"sl" ; "yw" ++ "sl"}) ; _ => s ++ "swA"} ; 
oper mkzrA : Size => Str = table {sg => "zr" ; _ => "zrA"} ; 

