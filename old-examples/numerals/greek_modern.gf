include numerals.Abs.gf ;
flags coding=greek ;

-- Free variation on accents on m'ia and d'yo

oper vowel : Strs = strs {"e" ; "o" ; "a" ; "'e" ; "'o" ; "'a"} ;

param DForm = unit | fem | femteen | teen | ten | hundredneut | hundredfem ;
param Use = indep | femattr ;
param Size = sg | pl ;

lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str } ;
lincat Sub10 = {s : DForm => Str ; size : Size} ; 
lincat Sub100 = {s : Use => Str ; size : Size} ; 
lincat Sub1000 = {s : Use => Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = "//" ++ x0.s ++ "//"} ;  -- Greek environment

oper mkNum : Str -> Str -> Str -> Str -> Str -> Str -> Lin Digit =
  \dyo -> \dwdeka -> \eikosi -> \diakosi -> \dyofem -> \dwdekafem ->
  {s = table {unit => dyo ; teen => dwdeka ; ten => eikosi ; 
              hundredneut => diakosi + "a" ; hundredfem => diakosi + "ej" ; 
              fem => dyofem ; femteen => dwdekafem}} ;   

oper mkIndeclNum : Str -> Str -> Str -> Str -> Lin Digit =
  \dyo -> \dwdeka -> \eikosi -> \diakosi ->
  {s = table {unit => dyo ; teen => dwdeka ; ten => eikosi ; 
              hundredneut => diakosi + "a" ; hundredfem => diakosi + "ej" ; 
              fem => dyo ; femteen => dwdeka}} ;   

lin n2 = mkIndeclNum "d'yo" "d'wdeka" "e'ikosi" "diak'osi" ;
lin n3 = mkNum "tr'ia" "dekatr'ia" "tri'anta" "triak'osi" "tre'ij" "dekatre'is" ;
lin n4 = mkNum "t'essera" "dekat'essera" "sar'anta" "tetrak'osi" "t'esserij" "dekat'esserij" ;
lin n5 = mkIndeclNum "p'ente" "dekap'ente" "pen'hnta" "pentak'osi" ;
lin n6 = mkIndeclNum "'exi" (variants { "deka'exi" ; "deka'exi" }) "ex'hnta" "exak'osi" ;
lin n7 = mkIndeclNum (variants {"ept'a" ; "eft'a" }) "dekaeft'a" "ebdom'hnta" "eftak'osi" ;
lin n8 = mkIndeclNum "oct'w" "dekaoct'w" "ogd'onta" "octak'osi" ;
lin n9 = mkIndeclNum (variants {"enn'ea" ; "enn'ia" }) "dekaenn'ea" "enen'hnta" "enniak'osi" ;
lin pot01  =
  {s = table {unit => "'ena" ; fem => "m'ia" ; _ => "ekat'o" + pre {[] ; "n" / vowel}} ; size = sg} ;
lin pot0 d =
  {s = d.s ; size = pl} ;
lin pot110  = 
  {s = table {indep => "d'eka" ; femattr => "d'eka"} ; size = pl} ;
lin pot111  =
  {s = table {indep => "'enteka" ; femattr => "'enteka" } ; size = pl} ;
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
  \s -> table {sg => "c'ilia" ; pl => s ++ "cili'adej" } ;