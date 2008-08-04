concrete greek_modern of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=greek ;

-- Free variation on accents on m'ia and d'yo

oper vowel : Strs = strs {"ε" ; "ο" ; "α" ; "έ" ; "ό" ; "ά"} ;

param DForm = unit | fem | femteen | teen | ten | hundredneut | hundredfem ;
param Use = indep | femattr ;
param Size = sg | pl ;

lincat Numeral = {s : Str} ;
oper LinDigit = {s : DForm => Str } ;
lincat Digit = LinDigit ;

lincat Sub10 = {s : DForm => Str ; size : Size} ; 
lincat Sub100 = {s : Use => Str ; size : Size} ; 
lincat Sub1000 = {s : Use => Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = [] ++ x0.s ++ []} ;  -- Greek environment

oper mkNum : Str -> Str -> Str -> Str -> Str -> Str -> LinDigit =
  \dyo -> \dwdeka -> \eikosi -> \diakosi -> \dyofem -> \dwdekafem ->
  {s = table {unit => dyo ; teen => dwdeka ; ten => eikosi ; 
              hundredneut => diakosi + "α" ; hundredfem => diakosi + "ες" ; 
              fem => dyofem ; femteen => dwdekafem}} ;   

oper mkIndeclNum : Str -> Str -> Str -> Str -> LinDigit =
  \dyo -> \dwdeka -> \eikosi -> \diakosi ->
  {s = table {unit => dyo ; teen => dwdeka ; ten => eikosi ; 
              hundredneut => diakosi + "α" ; hundredfem => diakosi + "ες" ; 
              fem => dyo ; femteen => dwdeka}} ;   

lin n2 = mkIndeclNum "δύο" "δώδεκα" "είκοσι" "διακόσι" ;
lin n3 = mkNum "τρία" "δεκατρία" "τριάντα" "τριακόσι" "τρείς" "δεκατρείσ" ;
lin n4 = mkNum "τέσσερα" "δεκατέσσερα" "σαράντα" "τετρακόσι" "τέσσερις" "δεκατέσσερις" ;
lin n5 = mkIndeclNum "πέντε" "δεκαπέντε" "πενήντα" "πεντακόσι" ;
lin n6 = mkIndeclNum "έξι" (variants { "δεκαέξι" ; "δεκαέξι" }) "εξήντα" "εξακόσι" ;
lin n7 = mkIndeclNum (variants {"επτά" ; "εφτά" }) "δεκαεφτά" "εβδομήντα" "εφτακόσι" ;
lin n8 = mkIndeclNum "οχτώ" "δεκαοχτώ" "ογδόντα" "οχτακόσι" ;
lin n9 = mkIndeclNum (variants {"εννέα" ; "εννία" }) "δεκαεννέα" "ενενήντα" "εννιακόσι" ;
lin pot01  =
  {s = table {unit => "ένα" ; fem => "μία" ; _ => "εκατό" + pre {[] ; "ν" / vowel}} ; size = sg} ;
lin pot0 d =
  {s = d.s ; size = pl} ;
lin pot110  = 
  {s = table {indep => "δέκα" ; femattr => "δέκα"} ; size = pl} ;
lin pot111  =
  {s = table {indep => "έντεκα" ; femattr => "έντεκα" } ; size = pl} ;
lin pot1to19 d =
  {s = table {indep => d.s ! teen; femattr => d.s ! femteen } ; size = pl} ;
lin pot0as1 n =
  {s = table {indep => n.s ! unit ; femattr => n.s ! fem } ; size = n.size} ;
lin pot1 d =
  {s = table {indep => d.s ! ten ; femattr => d.s ! ten } ; size = pl } ;
lin pot1plus d e =
  {s = table {indep => d.s ! ten ++ e.s ! unit ; femattr => d.s ! ten ++ e.s ! fem } ; size = pl} ;
lin pot1as2 n = n ;
lin pot2 d =
  {s = table {indep => d.s ! hundredneut ; femattr => d.s ! hundredfem} ; size = pl} ;
lin pot2plus d e =
  {s = table {indep => d.s ! hundredneut ++ e.s ! indep ; femattr => d.s ! hundredfem ++ e.s ! femattr} ; size = pl} ;
lin pot2as3 n =
  {s = n.s ! indep } ; 
lin pot3 n =
  {s = (Xilias (n.s ! femattr)) ! n.size} ;
lin pot3plus n m =
  {s = (Xilias (n.s ! femattr)) ! n.size ++ m.s ! indep} ; 

oper Xilias : Str -> Size => Str = 
  \s -> table {sg => "χίλια" ; pl => s ++ "χιλιάδες" } ;

}
