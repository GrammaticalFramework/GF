concrete sorani of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=extendedarabic ;

param DForm = unit | ten | teen | hund | kilurrest | kilurresthAzar ;
param Size = sg | less500 | fiveup | more500 ; 

-- From Manuel de Kurde (dialecte Sorani). 
-- 
-- [W] is waw with a horizontal line above
-- [E] is a ye with a horizonytal line above
-- [A] shouldnt have dots (= ta marbuta; also inside a word) 
-- [p] is be with three dots below like Persian
-- [j] is djim like normal, like arabic (not ye)
-- [O] is a waw with a hacek above
-- [F] is a fa with three dots above (i.e v)
-- [Z] is a zain with three dots above (i.e zh)
-- [I] is a ye with a horizontal line above
-- [C] is a djim with three dots below like Persian (i.e ch)
-- [c] is shin (i.e sh)
-- [H] is Arabic Ha (= djim without dots)

-- [P] is a Ha with a hamza above
-- [R] is an r with a ring below

lincat Numeral =    { s : Str } ;
oper LinDigit = {s : DForm => Str ; size : Size} ;
lincat Digit = LinDigit ;

lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size} ; 
lincat Sub1000000 = { s : Str } ;

lin num x0 =
  {s = [] ++ x0.s ++ []} ; -- the Arabic environment

oper mkNum : Str -> Str -> Str -> LinDigit = 
  \dwA -> \cl -> \dwwls ->  
  {s = table {unit => dwA ; ten => cl ; teen => dwwls ; hund => dwA + "سهد" ;
              kilurrest => "دuممي" ; kilurresthAzar => "دuممي" } ; size = less500};
 
oper mkNum6 : Str -> Str -> Str -> Str -> Str -> LinDigit = 
  \dwA -> \cl -> \dwwls -> \pEn -> \rest -> 
  {s = table {unit => dwA ; ten => cl ; teen => dwwls ; hund => pEn + "سهد" ;
              kilurrest => rest + "سهد" ; kilurresthAzar => rest + "سهد" ++ "ههزار"} ; size = fiveup} ;

-- lin n1 mkNum "يهك" "ده" variants { "يازده" ; "يانزه"} [] ;
lin n2 = mkNum "دۇ" "بىست" (variants { "دووازده" ; "دووانزه" }) ; 
lin n3 = mkNum "سى" "سى" (variants { "سىزده" ; "سيانزه" }) ;
lin n4 = mkNum "چووار" "ځل" "چووارده" ;
lin n5 = {s = table {unit => "پىنج" ; 
                     ten => "پهنجا" ; 
                     teen => (variants { "پازده" ; "پانزه" }) ; 
                     hund => "پىن" + "سهد"; 
                     kilurrest => [] ;
                     kilurresthAzar => [] } ;
          size = fiveup } ;

lin n6 = mkNum6 "شهش" "شهست" (variants { "شازده"; "شانزه"}) "شهش" [] ;
lin n7 = mkNum6 "حهوت" "حهفتا" "حهڤده" "حهو" "دۇ" ;
lin n8 = mkNum6 "ههشت" "ههشتا" "ههژده" "ههش" "سى" ;
lin n9 = mkNum6 "نۃ" "نهوهد" "نۃزده" "نۃ" "چووار" ; 

oper ss : Str -> {s : Str ; size : Size} = \s -> {s = s ; size = less500} ;

lin pot01 = {s = table {unit => "يهك" ; hund => "سهد" ; _ => "دuممي" } ; size = sg } ;
lin pot0 d = {s = table {f => d.s ! f} ; size = d.size} ;
lin pot110 = ss "ده" ; 
lin pot111 = ss (variants { "يازده" ; "يانزه"});
lin pot1to19 d = {s = d.s ! teen ; size = less500 } ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; size = less500} ;
lin pot1plus d e = {s = (d.s ! ten) ++ "و" ++ (e.s ! unit); size = less500} ;
lin pot1as2 n = {s = n.s ; s2 = "دuممي" ; size = n.size } ; 
lin pot2 d = {s = d.s ! hund ; s2 = "كلۇر" ++ d.s ! kilurresthAzar ; size = isover500 d.size} ;
lin pot2plus d e = 
  {s = d.s ! hund ++ e.s ; 
   s2 = "كلۇر" ++ d.s ! kilurrest ++ (mkhAzar e.s "دuممي") ! e.size ; 
   size = isover500 d.size} ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = (mkhAzar n.s n.s2) ! n.size } ;
lin pot3plus n m = {s =(mkhAzar n.s n.s2) ! n.size ++ m.s} ;

oper isover500 : Size -> Size = \sz -> 
  table {fiveup => more500 ; _ => less500} ! sz ; 

oper mkhAzar : Str -> Str -> Size => Str = \attr -> \kilur -> 
  table {sg => "ههزار" ; 
         fiveup => attr ++ "ههزار" ; 
         less500 => attr ++ "ههزار" ; 
         more500 => kilur} ;





}
