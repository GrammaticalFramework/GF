concrete hebrew_biblical of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=hebrew ;

param DForm = unit Place | cons  | ten | hund ;
param Size = small | large | dual ;
param Place = attr | indep  ;
lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str ; size : Size} ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Place => Str ; size : Size} ;
lincat Sub1000 = {s : Place => Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = [] ++ x0.s ++ []} ; -- the Hebrew environment

lin n2  =
  {s = table {(unit attr) => [] ; 
              (unit indep) => "שנים" ; 
              cons => "שני" ; 
              ten  => "עשרים" ;
              hund => "מאתים"} ; size = dual} ;
lin n3  =
  {s = table {(unit _) => "שלשה" ; 
              cons => "שלשת" ; 
              ten  => "שלשים" ;
              hund => "שלש" ++ "מאות"} ; size = small} ;
lin n4  =
  {s = table {(unit _) => "ארבעה" ; 
              cons => "ארבעת" ; 
              ten  => "ארבעים" ;
              hund => "ארבע" ++ "מאות"} ; size = small} ;
lin n5  =
  {s = table {(unit _) => "חמשה" ; 
              cons => "חמשת" ; 
              ten  => "חמשים" ;
              hund => "חמש" ++ "מאות"} ; size = small} ;
lin n6  =
  {s = table {(unit _) => "ששה" ; 
              cons => "ששת" ; 
              ten  => "ששים" ;
              hund => "שש" ++ "מאות"} ; size = small} ;
lin n7  =
  {s = table {(unit _) => "שבעה" ; 
              cons => "שבעת" ; 
              ten  => "שבעים" ;
              hund => "שבע" ++ "מאות"} ; size = small} ;
lin n8  =
  {s = table {(unit _) => "שמנה" ; 
              cons => "שמנת" ; 
              ten  => "שמנים" ;
              hund => "שמנה" ++ "מאות"} ; size = small} ;
lin n9  =
  {s = table {(unit _) => "תשעה" ; 
              cons => "תשעת" ; 
              ten  => "תשעים" ;
              hund => "תשע" ++ "מאות"} ; size = small} ;

lin pot01  =
  {s = table {hund => "מאה"; (unit attr) => [] ; f => "אחד"} ; size = large} ;
lin pot0 d =
  {s = d.s ; size = d.size} ;
lin pot110  =
  {s = table {_ => "עשר"} ; size = small} ;
lin pot111  =
  {s = table {_ => variants {"אחד" ++ "עשר" ; "עשתי" ++ "עשר"} } ; size = large} ;
lin pot1to19 d =
  {s =  table {_ => d.s ! unit indep ++ "עשר"} ; size = large} ;
lin pot0as1 n =
  {s = table {p => n.s ! unit p} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => d.s ! ten} ; size = large} ;
lin pot1plus d e =
  {s = table {_ => d.s ! ten  ++ "ו" ++ e.s ! unit indep} ; size = large} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {_ => d.s ! hund} ; size = large} ;
lin pot2plus d e =
  {s = table {_ => d.s ! hund ++ "ו" ++ e.s ! indep} ; size = large} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = n.s ! attr ++ Alf ! n.size} ;
lin pot3plus n m =
  {s = n.s ! attr ++ Alf ! n.size ++ "ו" ++ m.s ! indep} ;

oper Alf : Size => Str = 
  table {{small} => "אלפים" ; {dual} => "אלפים" ; _ => "אלף"} ;
 

}
