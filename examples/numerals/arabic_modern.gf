include numerals.Abs.gf ;
flags coding=arabic ;

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
  {s = "/-" ++ x0.s ++ "-/"} ; -- the Arabic environment

lin n2  =
  {s = table {(unit attr) => [] ; 
              (unit indep) => "avnyn" ; 
              teen => "avnj" ; 
              ten  => "ocryn" ;
              hund => "maOtyn"} ; size = dual} ;
lin n3  =
  {s = table {(unit _) => "vlavA" ; 
              teen => "vlavA" ; 
              ten  => "vlavyn" ;
              hund => "vlavmaOA"} ; size = small} ;
lin n4  =
  {s = table {(unit _) => "urboA" ; 
              teen => "urboA" ; 
              ten  => "urboyn" ;
              hund => "urbomaOA"} ; size = small} ;
lin n5  =
  {s = table {(unit _) => "CmsA" ; 
              teen => "CmsA" ; 
              ten  => "Cmsyn" ;
              hund => "CmsmaOA"} ; size = small} ;
lin n6  =
  {s = table {(unit _) => "stA" ; 
              teen => "stA" ; 
              ten  => "styn" ;
              hund => "stmaOA"} ; size = small} ;
lin n7  =
  {s = table {(unit _) => "sboA" ; 
              teen => "sboA" ; 
              ten  => "sboyn" ;
              hund => "sbomaOA"} ; size = small} ;
lin n8  =
  {s = table {(unit _) => "vmanyA" ; 
              teen => "vmanyA" ; 
              ten  => "vmanyn" ;
              hund => "vmanmaOA"} ; size = small} ;
lin n9  =
  {s = table {(unit _) => "tsoA" ; 
              teen => "tsoA" ; 
              ten  => "tsoyn" ;
              hund => "tsomaOA"} ; size = small} ;

lin pot01  =
  {s = table {hund => "maOA"; (unit attr) => [] ; f => "waHd"} ; size = large} ;
lin pot0 d =
  {s = d.s ; size = d.size} ;
lin pot110  =
  {s = table {_ => "ocrA"} ; size = small} ;
lin pot111  =
  {s = table {_ => "aHd" ++ "ocr"} ; size = large} ;
lin pot1to19 d =
  {s =  table {_ => d.s ! teen ++ "ocr"} ; size = large} ;
lin pot0as1 n =
  {s = table {p => n.s ! unit p} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => d.s ! ten} ; size = large} ;
lin pot1plus d e =
  {s = table {_ => e.s ! unit indep ++ "w" ++ d.s ! ten} ; size = large} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {_ => d.s ! hund} ; size = large} ;
lin pot2plus d e =
  {s = table {_ => d.s ! hund ++ "w" ++ e.s ! indep} ; size = large} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = n.s ! attr ++ Alf ! n.size} ;
lin pot3plus n m =
  {s = n.s ! attr ++ Alf ! n.size ++ "w" ++ m.s ! indep} ;

oper Alf : Size => Str = 
  table {{small} => "Ulaf" ; {dual} => "alfyn" ; _ => "alf"} ;
 
