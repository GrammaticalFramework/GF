concrete arabic_classical of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=arabic0600 ;

-- There is uncertainty as to wthere forms like 102 000 should be
-- hundred and thousand<DUAL> or hundred and two thousands<GEN.PL> or
-- as implemented hundred and two thousand<DUAL>

param DForm = unit Place | teen  | ten | hund ;
param Size = sg | pl | dual | eleventonineteen ;
param Place = attr | indep  ;
lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str ; size : Size} ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Place => Str ; size : Size} ;
lincat Sub1000 = {s : Place => Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = [] ++ x0.s ++ []} ; -- the Arabic0x0600 environment

lin n2  =
  {s = table {(unit attr) => [] ; 
              (unit indep) => "اثنان" ; 
              teen => "اثنا" ; 
              ten  => "عشرون" ;
              hund => "مائتان"} ; size = dual} ;
lin n3  =
  {s = table {(unit _) => "ثلاثة" ; 
              teen => "ثلاثة" ; 
              ten  => "ثلاثون" ;
              hund => variants {"ثلاث" ++ "مائة" ; "ثلاثمائة"}} ; 
   size = pl} ;
lin n4  =
  {s = table {(unit _) => "أربعة" ; 
              teen => "أربعة" ; 
              ten  => "أربعون" ;
              hund => variants {"أربع" ++ "مائة" ; "أربعمائة"}} ; 
   size = pl} ;
lin n5  =
  {s = table {(unit _) => "خمسة" ; 
              teen => "خمسة" ; 
              ten  => "خمسون" ;
              hund => variants {"خمس" ++ "مائة" ; "خمسمائة"}} ; size = pl} ;
lin n6  =
  {s = table {(unit _) => "ستة" ; 
              teen => "ستة" ; 
              ten  => "ستون" ;
              hund => variants {"ست" ++ "مائة" ; "ستمائة"}} ; size = pl} ;
lin n7  =
  {s = table {(unit _) => "سبعة" ; 
              teen => "سبعة" ; 
              ten  => "سبعون" ;
              hund => variants {"سبع" ++ "مائة" ; "سبعمائة"}} ; size = pl} ;
lin n8  =
  {s = table {(unit _) => "ثمانية" ; 
              teen => "ثمانية" ; 
              ten  => "ثمانون" ;
              hund => variants {"ثمان" ++ "مائة" ; "ثمانمائة"}} ; 
   size = pl} ;
lin n9  =
  {s = table {(unit _) => "تسعة" ; 
              teen => "تسعة" ; 
              ten  => "تسعون" ;
              hund => variants {"تسع" ++ "مائة" ; "تسعمائة"}} ; 
   size = pl} ;

lin pot01  =
  {s = table {hund => (variants {"مائة" ; "م0ة"} ) ; (unit attr) => [] ; f => "واحد"} ; size = sg} ;
lin pot0 d =
  {s = d.s ; size = d.size} ;
lin pot110  =
  {s = table {_ => "عشرة"} ; size = pl} ;
lin pot111  =
  {s = table {_ => "احد" ++ "عشر"} ; size = eleventonineteen} ;
lin pot1to19 d =
  {s =  table {_ => d.s ! teen ++ "عشر"} ; size = eleventonineteen} ;
lin pot0as1 n =
  {s = table {p => n.s ! unit p} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => d.s ! ten} ; size = eleventonineteen} ;
lin pot1plus d e =
  {s = table {_ => e.s ! unit indep ++ "و" ++ d.s ! ten} ; size = e.size} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {_ => d.s ! hund} ; size = pl} ;
lin pot2plus d e =
  {s = table {_ => d.s ! hund ++ "و" ++ e.s ! indep} ; size = e.size} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = n.s ! attr ++ Alf ! n.size} ;
lin pot3plus n m =
  {s = n.s ! attr ++ Alf ! n.size ++ "و" ++ m.s ! indep} ;

oper Alf : Size => Str = 
  table {{pl} => "آلاف" ; {dual} => "الفان" ; {eleventonineteen} => "الفا" ; sg => "الف"} ;
 

}
