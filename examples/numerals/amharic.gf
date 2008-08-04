concrete amharic of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=ethiopic ;

-- 14, 15 have variants in pronounciation {asraratt, asrammIst}

-- No long consonants marked in the indigen. script
-- s is set intersection s
-- h is set union h
-- H is three-fork h
-- x is hook-looking h
-- L is sin-looking s
-- X is h looking like k with a roof
-- ) is chair-vowel i.e historically glottal stop
-- ( is round-shape vowel sign i.e historically 3ayn
-- Z is zh
-- $ is sh
-- N is n~
-- I is i" ዕ6ትህ ሮውእ
-- አ ኢስ ኣ" (1st row)
-- Capitalis for ejectives KPTCS


param DForm = unit | ten ;
param Size = sg | pl | tenplus ;
param S100 = indep | tenpart | tenelfu | sihpart ;

oper LinDigit = {s : DForm => Str ; size : Size} ;
oper LinSub100 = {s : S100 => Str ; size : Size} ;

lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = LinSub100 ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size } ;
lincat Sub1000000 = {s : Str} ;

oper mkNum : Str -> Str -> LinDigit = \hulatt -> \haya ->
  {s = table {unit => hulatt ; ten => haya} ; size = pl} ;

lin num x0 =
  {s = [] ++ x0.s ++ []} ;
lin n2 = mkNum "ሁለት" (variants {"ሃያ" ; "ሓያ" ; "ኃያ" ; "ካያ" }) ; 
lin n3 = mkNum "ሦስት" "ሠላሳ"  ;
lin n4 = mkNum "ኣራት" "ኣርባ" ;
lin n5 = mkNum "ኣምስት" (variants { "ኣምሳ" ; "ኃምሳ" }) ;
lin n6 = mkNum "ስድስት" (variants { "ስድሳ" ; "ስልሳ" }) ;
lin n7 = mkNum "ሰባት" "ሰባ" ;
lin n8 = mkNum "ስምንት" "ሰማንያ" ;
lin n9 = mkNum "ዘጠኝ" "ዘጠና" ;

oper ss1 : Str -> Str -> Str -> LinSub100 = \assir -> \ten -> \unitpart -> 
  {s = table {indep => assir ; tenpart => ten ; tenelfu => [] ; sihpart => unitpart} ; size = tenplus } ;
  
oper ss : Str -> Str -> Str -> LinSub100 = \assir -> \ten -> \unitpart -> 
  {s = table {indep => assir ; tenpart => ten ; tenelfu => ten ; sihpart => unitpart} ; size = tenplus } ;

lin pot01  =
  {s = table {unit => "ኣንድ" ; ten => "ኣስራ" }; size = sg};
lin pot0 d = d ;
lin pot110 = ss1 "ኣስር" "ኣንድ" [] ; 
lin pot111 = ss1 (variants {"ኣስራንድ" ; "ኣስራ" ++ "ኣንድ" }) "ኣንድ" Sih ;
lin pot1to19 d = ss1 ("ኣስራ" ++ d.s ! unit) "ኣንድ" (mkSih d.size (d.s ! unit)) ;
lin pot0as1 n = {s = table {indep => n.s ! unit ; sihpart => mkSih n.size (n.s ! unit) ; _ => [] } ; size = n.size} ;
lin pot1 d = ss (d.s ! ten) (d.s ! unit) [] ; 
lin pot1plus d e = ss ((d.s ! ten) ++ (e.s ! unit)) 
                      (d.s ! unit) 
                      (mkSih e.size (e.s ! unit)); 

lin pot1as2 n = {s = n.s ! indep ; s2 = n.s ! tenelfu ++ "እሌፍ" ++ n.s ! sihpart ; size = n.size} ;

lin pot2 d = {s = (sel d.size [] (d.s ! unit)) ++ "መቶ" ; 
	      s2 = sel d.size "ኣስር" (d.s ! ten) ; size = tenplus} ;
lin pot2plus d e = {s = (sel d.size [] (d.s ! unit)) ++ "መቶ" ++ e.s ! indep ; s2 = d.s ! ten ++ e.s ! tenpart ++ "እሌፍ" ++ e.s ! sihpart ; size = tenplus} ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = table {pl => n.s ++ Sih ; sg => Sih ; tenplus => n.s2 } ! n.size} ;
lin pot3plus n m = {s = table {pl => n.s ++ Sih ; sg => Sih ; tenplus => n.s2 } ! n.size ++ m.s} ;

oper Sih : Str = variants {"ሺህ" ; "ሺ"} ;

oper mkSih : Size -> Str -> Str = \sz -> \attr -> (sel sz [] attr) ++ Sih ;

oper sel : Size -> Str -> Str -> Str = \sz -> \a -> \b -> table {sg => a ; _ => b} ! sz ; 

}
