include numerals.Abs.gf ;

param DForm = unit  | teen  | ten | hund ;
param Place = attr  | indep  ;
param Size = sg | pl ;
lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str} ;
lincat Sub10 = {s : Place => DForm => Str ; size : Size} ;
lincat Sub100 = {s : Place => Str ; size : Size} ;
lincat Sub1000 = {s : Place => Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = "//" ++ x0.s ++ "//"} ;  -- Greek environment

lin n2  =
  {s = table {{unit} => "d'yo" ; 
              {teen} => "d'wdeka" ; 
              {ten}  => "e)'ikosi" ;
              {hund} => "diak'osioi"}} ;
lin n3  =
  {s = table {{unit} => "tre~ij" ; 
              {teen} => "tre~ij" ++ "ka`i" ++ "d'eka" ; 
              {ten}  => "tri'akonta" ;
              {hund} => "triak'osioi"}} ;
lin n4  =
  {s = table {{unit} => "t'ettarej" ; 
              {teen} => "t'ettarej" ++ "ka`i" ++ "d'eka" ; 
              {ten}  => "tettar'akonta" ;
              {hund} => "tetrak'osioi"}} ;
lin n5  =
  {s = table {{unit} => "p'ente" ; 
              {teen} => "penteka'ideka" ; 
              {ten}  => "pent'hkonta" ;
              {hund} => "pentak'osioi"}} ;
lin n6  =
  {s = table {{unit} => "('ex" ; 
              {teen} => "(ekka'ideka" ; 
              {ten}  => "(ex'hkonta" ;
              {hund} => "(exak'osioi"}} ;
lin n7  =
  {s = table {{unit} => "(ept'a" ; 
              {teen} => "(eptaka'ideka" ; 
              {ten}  => "(ebdom'hkonta" ;
              {hund} => "(eptak'osioi"}} ;
lin n8  =
  {s = table {{unit} => ")okt'w" ; 
              {teen} => ")oktwka'ideka" ; 
              {ten}  => ")ogdo'hkonta" ;
              {hund} => ")oktako'sioi"}} ;
lin n9  =
  {s = table {{unit} => ")enn'ea" ; 
              {teen} => ")enneaka'ideka" ; 
              {ten}  => ")enen'hkonta" ;
              {hund} => ")enak'osioi"}} ;


lin pot01  =
  {s = table {{attr} => table {{hund} => "(ekat'on" ; _ => []} ; 
              _ => table {{hund} => "(ekat'on" ; f => "e('ij"}} ; size = sg} ;
lin pot0 d =
  {s = table {_ => d.s} ; size = pl} ;
lin pot110  =
  {s = table {_ => "d'eka"} ; size = pl} ;
lin pot111  =
  {s = table {_ => "('endeka"} ; size = pl} ;
lin pot1to19 d =
  {s = table {_ => d.s ! teen} ; size = pl} ;
lin pot0as1 n =
  {s = table {p => n.s ! p ! unit} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => d.s ! ten} ; size = pl} ;
lin pot1plus d e =
  {s = table {_ => d.s ! ten ++ e.s ! indep ! unit} ; size = pl} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {p => d.s ! p ! hund} ; size = pl} ;
lin pot2plus d e =
  {s = table {p => d.s ! p ! hund ++ e.s ! indep} ; size = pl} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = n.s ! attr ++ "c'ilioi"} ;
lin pot3plus n m =
  {s = n.s ! attr ++ "c'ilioi" ++ m.s ! indep} ;

--- TODO
---  2000 discilioi-3
--- 10000 myrioi-3
--- 20000 dismyrioi-3


