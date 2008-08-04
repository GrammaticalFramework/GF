concrete arabic_modern of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=arabic ;

--- flags unlexer=reverse ;
param DForm = unit Place | teen  | ten | hund ;
param Size = small | large | dual ;
param Place = attr | indep  ;
lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str ; size : Size} ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Place => Str ; size : Size} ;
lincat Sub1000 = {s : Place => Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = [] ++ x0.s ++ []} ; -- the Arabic environment

lin n2  =
  {s = table {(unit attr) => [] ; 
              (unit indep) => "ﺍﺛﻨﻴﻦ" ; 
              teen => "ﺍﺛﻨﻰ" ; 
              ten  => "ﻋﺸﺮﻳﻦ" ;
              hund => "ﻣﺎﺋﺘﻴﻦ"} ; size = dual} ;
lin n3  =
  {s = table {(unit _) => "ﺛﻼﺛﺔ" ; 
              teen => "ﺛﻼﺛﺔ" ; 
              ten  => "ﺛﻼﺛﻴﻦ" ;
              hund => "ﺛﻼﺛﻤﺎﺋﺔ"} ; size = small} ;
lin n4  =
  {s = table {(unit _) => "ﺃﺭﺑﻌﺔ" ; 
              teen => "ﺃﺭﺑﻌﺔ" ; 
              ten  => "ﺃﺭﺑﻌﻴﻦ" ;
              hund => "ﺃﺭﺑﻌﻤﺎﺋﺔ"} ; size = small} ;
lin n5  =
  {s = table {(unit _) => "ﺧﻤﺴﺔ" ; 
              teen => "ﺧﻤﺴﺔ" ; 
              ten  => "ﺧﻤﺴﻴﻦ" ;
              hund => "ﺧﻤﺴﻤﺎﺋﺔ"} ; size = small} ;
lin n6  =
  {s = table {(unit _) => "ﺳﺘﺔ" ; 
              teen => "ﺳﺘﺔ" ; 
              ten  => "ﺳﺘﻴﻦ" ;
              hund => "ﺳﺘﻤﺎﺋﺔ"} ; size = small} ;
lin n7  =
  {s = table {(unit _) => "ﺳﺒﻌﺔ" ; 
              teen => "ﺳﺒﻌﺔ" ; 
              ten  => "ﺳﺒﻌﻴﻦ" ;
              hund => "ﺳﺒﻌﻤﺎﺋﺔ"} ; size = small} ;
lin n8  =
  {s = table {(unit _) => "ﺛﻤﺎﻧﻴﺔ" ; 
              teen => "ﺛﻤﺎﻧﻴﺔ" ; 
              ten  => "ﺛﻤﺎﻧﻴﻦ" ;
              hund => "ﺛﻤﺎﻧﻤﺎﺋﺔ"} ; size = small} ;
lin n9  =
  {s = table {(unit _) => "ﺗﺴﻌﺔ" ; 
              teen => "ﺗﺴﻌﺔ" ; 
              ten  => "ﺗﺴﻌﻴﻦ" ;
              hund => "ﺗﺴﻌﻤﺎﺋﺔ"} ; size = small} ;

lin pot01  =
  {s = table {hund => "ﻣﺎﺋﺔ"; (unit attr) => [] ; f => "ﻭﺍﺣﺪ"} ; size = large} ;
lin pot0 d =
  {s = d.s ; size = d.size} ;
lin pot110  =
  {s = table {_ => "ﻋﺸﺮﺓ"} ; size = small} ;
lin pot111  =
  {s = table {_ => "ﺍﺣﺪ" ++ "ﻋﺸﺮ"} ; size = large} ;
lin pot1to19 d =
  {s =  table {_ => d.s ! teen ++ "ﻋﺸﺮ"} ; size = large} ;
lin pot0as1 n =
  {s = table {p => n.s ! unit p} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => d.s ! ten} ; size = large} ;
lin pot1plus d e =
  {s = table {_ => e.s ! unit indep ++ "ﻭ" ++ d.s ! ten} ; size = large} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {_ => d.s ! hund} ; size = large} ;
lin pot2plus d e =
  {s = table {_ => d.s ! hund ++ "ﻭ" ++ e.s ! indep} ; size = large} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = n.s ! attr ++ Alf ! n.size} ;
lin pot3plus n m =
  {s = n.s ! attr ++ Alf ! n.size ++ "ﻭ" ++ m.s ! indep} ;

oper Alf : Size => Str = 
  table {{small} => "ﺁﻻﻑ" ; {dual} => "ﺍﻟﻔﻴﻦ" ; _ => "ﺍﻟﻒ"} ;
 

}
