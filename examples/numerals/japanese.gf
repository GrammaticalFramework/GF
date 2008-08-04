concrete japanese of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=japanese ;

param DForm = unit | attr | ten | hundred | thousand ; 
param Size = sg | pl | more10 ;
param S100 = tenp | senp ;
param S1000 = indep | man | sen;

-- Standard Romajii
-- Everything should be glued

lincat Numeral = {s : Str} ;
oper LinDigit = {s : DForm => Str ; size : Size } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ; 
lincat Sub100 = {s : Str ; s2 : S100 => Str; size : Size} ;
lincat Sub1000 = {s : S1000 => Str ; size : Size } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = [] ++ x0.s ++ []} ;

oper mkNum : Str -> LinDigit = \base -> 
  {s = table {unit => base ; attr => base ; ten => base + "ぢゅう" ; hundred => base + "ひゃく" ; thousand => base + "せん" } ; size = pl} ;

oper mkNum4 : Str -> Str -> Str -> Str -> LinDigit = \ni -> \base -> \nihyaku -> \nisen -> 
  {s = table {unit => ni ; attr => base ; ten => base + "ぢゅう" ; hundred => nihyaku ; thousand => nisen } ; size = pl} ;

oper mkNum2 : Str -> Str -> LinDigit = \yon -> \base -> 
  {s = table {unit => yon ; attr => base ; ten => base + "ぢゅう" ; hundred => base + "ひゃく" ; thousand => base + "せん" } ; size = pl} ;

-- lin n1 = mkNum "いち" ; 
lin n2 = mkNum "に" ;
lin n3 = mkNum4 "さん" "さん" "さんびゃく" "さんぜん" ;
lin n4 = mkNum2 (variants { "し" ; "よん" }) "よん" ;
lin n5 = mkNum "ご" ;
lin n6 = mkNum4 "ろく" "ろく" "ろっぴゃく" "ろくせん" ;
lin n7 = mkNum2 (variants {"なな" ; "しち" }) "なな" ;
lin n8 = mkNum4 "はち" "はち" "はっぴゃく" "はっせん" ;
lin n9 = mkNum2 (variants {"きゅう" ; "く" }) "きゅう"  ;

lin pot01  =
  {s = table {unit => "いち" ; attr => [] ; ten => "ぢゅう" ; hundred => "ひゃく" ; thousand => "せん"} ; size = sg };
lin pot0 d = d ;
lin pot110 = {s = "ぢゅう" ; s2 = table {tenp => "いち" + "まん" ; senp => []} ; size = more10} ;
lin pot111 = {s = "ぢゅう" + "いち" ; s2 = table {tenp => "いち" + "まん" ; senp => "せん"} ; size = more10} ;
lin pot1to19 d = {s = "ぢゅう" ++ d.s ! unit ; s2 = table {tenp => "いち" + "まん" ; senp => d.s ! thousand} ; size = more10} ; 
lin pot0as1 n = {s = n.s ! unit ; s2 = table {tenp => [] ; senp => n.s ! thousand} ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; s2 = table {tenp => d.s ! unit ++ "まん" ; senp => []} ; size = more10} ;
lin pot1plus d e = 
  {s = d.s ! ten ++ e.s ! unit ;
   s2 = table {tenp => d.s ! unit ++ "まん" ; senp => e.s ! thousand} ; 
   size = more10} ; 

lin pot1as2 n = {s = table {indep => n.s ; man => n.s2 ! tenp ++ n.s2 ! senp ; sen => n.s2 ! senp} ; size = n.size} ;
lin pot2 d = {s = table {indep => d.s ! hundred ; man => d.s ! ten ++ "まん" ; sen => "uっmy"} ; size = more10 };
lin pot2plus d e = {s = table {indep => d.s ! hundred ++ e.s ; man => d.s ! ten ++ e.s2 ! tenp ++ e.s2 ! senp ; sen => "uっmy" } ; size = more10 };
lin pot2as3 n = {s = n.s ! indep } ;
lin pot3 n = {s = table {more10 => n.s ! man ; _ => n.s ! sen} ! n.size} ;
lin pot3plus n m = {s = table {more10 => n.s ! man ; _ => n.s ! sen} ! n.size ++ m.s ! indep} ;


}
