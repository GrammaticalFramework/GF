include numerals.Abs.gf ;
flags coding=hebrew ;

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
  {s = "/+" ++ x0.s ++ "+/"} ; -- the Hebrew environment

lin n2  =
  {s = table {(unit attr) => [] ; 
              (unit indep) => "snyM" ; 
              cons => "sny" ; 
              ten  => "osryM" ;
              hund => "matyM"} ; size = dual} ;
lin n3  =
  {s = table {(unit _) => "slsh" ; 
              cons => "slst" ; 
              ten  => "slsyM" ;
              hund => "sls" ++ "mawt"} ; size = small} ;
lin n4  =
  {s = table {(unit _) => "arboh" ; 
              cons => "arbot" ; 
              ten  => "arboyM" ;
              hund => "arbo" ++ "mawt"} ; size = small} ;
lin n5  =
  {s = table {(unit _) => "Hmsh" ; 
              cons => "Hmst" ; 
              ten  => "HmsyM" ;
              hund => "Hms" ++ "mawt"} ; size = small} ;
lin n6  =
  {s = table {(unit _) => "ssh" ; 
              cons => "sst" ; 
              ten  => "ssyM" ;
              hund => "ss" ++ "mawt"} ; size = small} ;
lin n7  =
  {s = table {(unit _) => "sboh" ; 
              cons => "sbot" ; 
              ten  => "sboyM" ;
              hund => "sbo" ++ "mawt"} ; size = small} ;
lin n8  =
  {s = table {(unit _) => "smnh" ; 
              cons => "smnt" ; 
              ten  => "smnyM" ;
              hund => "smnh" ++ "mawt"} ; size = small} ;
lin n9  =
  {s = table {(unit _) => "tsoh" ; 
              cons => "tsot" ; 
              ten  => "tsoyM" ;
              hund => "tso" ++ "mawt"} ; size = small} ;

lin pot01  =
  {s = table {hund => "mah"; (unit attr) => [] ; f => "aHd"} ; size = large} ;
lin pot0 d =
  {s = d.s ; size = d.size} ;
lin pot110  =
  {s = table {_ => "osr"} ; size = small} ;
lin pot111  =
  {s = table {_ => variants {"aHd" ++ "osr" ; "osty" ++ "osr"} } ; size = large} ;
lin pot1to19 d =
  {s =  table {_ => d.s ! unit indep ++ "osr"} ; size = large} ;
lin pot0as1 n =
  {s = table {p => n.s ! unit p} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => d.s ! ten} ; size = large} ;
lin pot1plus d e =
  {s = table {_ => d.s ! ten  ++ "w" ++ e.s ! unit indep} ; size = large} ;
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
  table {{small} => "alpyM" ; {dual} => "alpyM" ; _ => "alP"} ;
 
