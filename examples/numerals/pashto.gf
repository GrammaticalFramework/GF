concrete pashto of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=extendedarabic ;

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

lincat Numeral =    { s : Str } ;
oper LinDigit = {s : DForm => Str ; size : Size} ;
lincat Digit = LinDigit ;

lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size } ; 
lincat Sub1000000 = { s : Str } ;

lin num x0 =
  {s = [] ++ x0.s ++ []} ; -- the Extented-Arabic environment

oper mkNum : Str -> Str -> Str -> LinDigit = 
  \dwA -> \cl -> \dwwls ->  
  {s = table {unit => dwA ; ten => cl ; teen => dwwls ; spctwo => dwA ; twenties => dwA + "وىشت"} ; size = less100 } ;

oper mkIrrNum : Str -> Str -> Str -> Str -> Str -> LinDigit = 
  \dwA -> \cl -> \dwwls -> \dw -> \dr ->  
  {s = table {unit => dwA ; ten => cl ; teen => dwwls ; spctwo => dw ; twenties 
=> dr + "وىشت"} ; size = less100 } ;

-- lin n1 mkNum "يو" "لس" ... ;
lin n2 = {s = table {unit => "دوه" ; ten => "شل" ; teen => "دوولس" ; 
                     spctwo => "دو" ; twenties => "دوه" + "وىشت" } ; 
          size = two }; 
lin n3 = mkIrrNum "دري" "دۍرش" "ديارلس" "دري" "در" ;
lin n4 = mkIrrNum "څلور" "څلوۍښت" "څورلس" "څلور" "څلۍر";
lin n5 = mkNum "پنځه" "پنځوس" (variants { "پنځهلس"; "پنځلس"}) ;
lin n6 = mkNum "شپږ" "شپۍته" "سپاړلس" ;
lin n7 = mkNum "اوه" "اويا" (variants {"اوهلس"; "اولس"}) ;
lin n8 = mkNum "اته" "اتيا" (variants {"اتهلس"; "اتلس"}) ;
lin n9 = mkNum "نه" "نوي" (variants {"نولس"; "نونس"}) ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "يو" ; 
                        spctwo => "يو" ; 
                        twenties => "يو" + "وىشت" ; 
                        _ => "دuممي" } ; size = sg} ;
lin pot0 d = {s = table {f => d.s ! f} ; size = less100} ;
lin pot110 = {s = "لس" ; size = less100} ; 
lin pot111 = {s = "يوولس" ; size = less100} ;
lin pot1to19 d = {s = d.s ! teen ; size = less100} ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; size = less100} ;
lin pot1plus d e = {s = table {two => e.s ! twenties ;  
                               _ => e.s ! spctwo ++ (d.s ! ten) } ! d.size ; 
                    size = less100} ;
lin pot1as2 n = {s = n.s ; s2 = "دuممي" ; size = n.size } ;
lin pot2 d = {s = (mkswA (d.s ! unit)) ! d.size ; s2 = (mklk (d.s ! unit)) ! d.size ; size = more100} ;
lin pot2plus d e = 
  {s = (mkvarswA (d.s ! unit)) ! d.size ++ "او" ++ e.s ; 
   s2 = (mklk (d.s ! unit)) ! d.size ++ e.s ++ (mkzrA ! e.size) ; 
   size = more100} ;

lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = table { sg => "زر" ;
			  two => n.s ++ "زره" ;
                          less100 => n.s ++ "زره" ; 
                          more100 => n.s2 } ! n.size} ;
lin pot3plus n m = 
  {s = table { sg => variants {"زر" ; "يو" ++ "زر"} ;
	       two => n.s ++ "زره" ; 
               less100 => n.s ++ "زره" ; 
               more100 => n.s2 } ! n.size ++ maybeaw ! m.size ++ m.s} ;


oper mklk : Str -> Size => Str = \s -> table {sg => "لك" ; _ => s ++ "لك"} ;
oper maybeaw : Size => Str = table {more100 => [] ; _ => "او"} ;
oper mkswA : Str -> Size => Str = \s -> table {sg => "سل" ; _ => s ++ "سوه"} ;
oper mkvarswA : Str -> Size => Str = 
  \s -> table {sg => (variants {"سل" ; "يو" ++ "سل"}) ; _ => s ++ "سوه"} ; 
oper mkzrA : Size => Str = table {sg => "زر" ; _ => "زره"} ; 


}
