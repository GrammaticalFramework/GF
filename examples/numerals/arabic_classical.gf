include numerals.Abs.gf ;

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
  {s = "/6" ++ x0.s ++ "6/"} ; -- the Arabic0x0600 environment

lin n2  =
  {s = table {(unit attr) => [] ; 
              (unit indep) => "avnan" ; 
              teen => "avna" ; 
              ten  => "ocrwn" ;
              hund => "maOtan"} ; size = dual} ;
lin n3  =
  {s = table {(unit _) => "vlavA" ; 
              teen => "vlavA" ; 
              ten  => "vlavwn" ;
              hund => variants {"vlav" ++ "maOA" ; "vlavmaOA"}} ; 
   size = pl} ;
lin n4  =
  {s = table {(unit _) => "urboA" ; 
              teen => "urboA" ; 
              ten  => "urbown" ;
              hund => variants {"urbo" ++ "maOA" ; "urbomaOA"}} ; 
   size = pl} ;
lin n5  =
  {s = table {(unit _) => "CmsA" ; 
              teen => "CmsA" ; 
              ten  => "Cmswn" ;
              hund => variants {"Cms" ++ "maOA" ; "CmsmaOA"}} ; size = pl} ;
lin n6  =
  {s = table {(unit _) => "stA" ; 
              teen => "stA" ; 
              ten  => "stwn" ;
              hund => variants {"st" ++ "maOA" ; "stmaOA"}} ; size = pl} ;
lin n7  =
  {s = table {(unit _) => "sboA" ; 
              teen => "sboA" ; 
              ten  => "sbown" ;
              hund => variants {"sbo" ++ "maOA" ; "sbomaOA"}} ; size = pl} ;
lin n8  =
  {s = table {(unit _) => "vmanyA" ; 
              teen => "vmanyA" ; 
              ten  => "vmanwn" ;
              hund => variants {"vman" ++ "maOA" ; "vmanmaOA"}} ; 
   size = pl} ;
lin n9  =
  {s = table {(unit _) => "tsoA" ; 
              teen => "tsoA" ; 
              ten  => "tsown" ;
              hund => variants {"tso" ++ "maOA" ; "tsomaOA"}} ; 
   size = pl} ;

lin pot01  =
  {s = table {hund => (variants {"maOA" ; "m0A"} ) ; (unit attr) => [] ; f => "waHd"} ; size = sg} ;
lin pot0 d =
  {s = d.s ; size = d.size} ;
lin pot110  =
  {s = table {_ => "ocrA"} ; size = pl} ;
lin pot111  =
  {s = table {_ => "aHd" ++ "ocr"} ; size = eleventonineteen} ;
lin pot1to19 d =
  {s =  table {_ => d.s ! teen ++ "ocr"} ; size = eleventonineteen} ;
lin pot0as1 n =
  {s = table {p => n.s ! unit p} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => d.s ! ten} ; size = eleventonineteen} ;
lin pot1plus d e =
  {s = table {_ => e.s ! unit indep ++ "w" ++ d.s ! ten} ; size = e.size} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {_ => d.s ! hund} ; size = pl} ;
lin pot2plus d e =
  {s = table {_ => d.s ! hund ++ "w" ++ e.s ! indep} ; size = e.size} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = n.s ! attr ++ Alf ! n.size} ;
lin pot3plus n m =
  {s = n.s ! attr ++ Alf ! n.size ++ "w" ++ m.s ! indep} ;

oper Alf : Size => Str = 
  table {{pl} => "Ulaf" ; {dual} => "alfan" ; {eleventonineteen} => "alfa" ; sg => "alf"} ;
 
