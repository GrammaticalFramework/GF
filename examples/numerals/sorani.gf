include numerals.Abs.gf ;

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

lincat Digit = {s : DForm => Str ; size : Size} ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size} ; 

lin num x0 =
  {s = "/A" ++ x0.s ++ "A/"} ; -- the Arabic environment

oper mkNum : Str -> Str -> Str -> Lin Digit = 
  \dwA -> \cl -> \dwwls ->  
  {s = table {unit => dwA ; ten => cl ; teen => dwwls ; hund => dwA + "sAd" ;
              kilurrest => "dummy" ; kilurresthAzar => "dummy" } ; size = less500};
 
oper mkNum6 : Str -> Str -> Str -> Str -> Str -> Lin Digit = 
  \dwA -> \cl -> \dwwls -> \pEn -> \rest -> 
  {s = table {unit => dwA ; ten => cl ; teen => dwwls ; hund => pEn + "sAd" ;
              kilurrest => rest + "sAd" ; kilurresthAzar => rest + "sAd" ++ "hAzar"} ; size = fiveup} ;

-- lin n1 mkNum "yAk" "dA" variants { "yazdA" ; "yanzA"} [] ;
lin n2 = mkNum "dW" "bIst" (variants { "dwwazdA" ; "dwwanzA" }) ; 
lin n3 = mkNum "sE" "sI" (variants { "sEzdA" ; "syanzA" }) ;
lin n4 = mkNum "Cwwar" "Pl" "CwwardA" ;
lin n5 = {s = table {unit => "pEnj" ; 
                     ten => "pAnja" ; 
                     teen => (variants { "pazdA" ; "panzA" }) ; 
                     hund => "pEn" + "sAd"; 
                     kilurrest => [] ;
                     kilurresthAzar => [] } ;
          size = fiveup } ;

lin n6 = mkNum6 "cAc" "cAst" (variants { "cazdA"; "canzA"}) "cAc" [] ;
lin n7 = mkNum6 "HAwt" "HAfta" "HAFdA" "HAw" "dW" ;
lin n8 = mkNum6 "hAct" "hActa" "hAZdA" "hAc" "sE" ;
lin n9 = mkNum6 "nO" "nAwAd" "nOzdA" "nO" "Cwwar" ; 

oper ss : Str -> {s : Str ; size : Size} = \s -> {s = s ; size = less500} ;

lin pot01 = {s = table {unit => "yAk" ; hund => "sAd" ; _ => "dummy" } ; size = sg } ;
lin pot0 d = {s = table {f => d.s ! f} ; size = d.size} ;
lin pot110 = ss "dA" ; 
lin pot111 = ss (variants { "yazdA" ; "yanzA"});
lin pot1to19 d = {s = d.s ! teen ; size = less500 } ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; size = less500} ;
lin pot1plus d e = {s = (d.s ! ten) ++ "w" ++ (e.s ! unit); size = less500} ;
lin pot1as2 n = {s = n.s ; s2 = "dummy" ; size = n.size } ; 
lin pot2 d = {s = d.s ! hund ; s2 = "klWr" ++ d.s ! kilurresthAzar ; size = isover500 d.size} ;
lin pot2plus d e = 
  {s = d.s ! hund ++ e.s ; 
   s2 = "klWr" ++ d.s ! kilurrest ++ (mkhAzar e.s "dummy") ! e.size ; 
   size = isover500 d.size} ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = (mkhAzar n.s n.s2) ! n.size } ;
lin pot3plus n m = {s =(mkhAzar n.s n.s2) ! n.size ++ m.s} ;

oper isover500 : Size -> Size = \sz -> 
  table {fiveup => more500 ; _ => less500} ! sz ; 

oper mkhAzar : Str -> Str -> Size => Str = \attr -> \kilur -> 
  table {sg => "hAzar" ; 
         fiveup => attr ++ "hAzar" ; 
         less500 => attr ++ "hAzar" ; 
         more500 => kilur} ;




