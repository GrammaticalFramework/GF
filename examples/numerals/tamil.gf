concrete tamil of Numerals = {
flags coding = utf8 ;
-- Tamil
-- Ad hoc transcr.
-- when there is something bigger maybe a:yiram should be preceded
-- by an o:ru

-- c is sh/ch etc
-- s is sanskr. s'
-- S is sanskr. s.
-- G is velar n i.e [ng]
-- V regular n in e.g [na:ru] 
-- n one ring n
-- N two ring n
-- ñ
-- l
-- L (like N but without the middle ring)
-- M is retroflex l with the char that looks a bit like m (e.g l in Tamil)


-- include numerals.Abs.gf ;
-- flags coding=tamil ;

oper 
  vowel : Strs = strs {"ஒ" ; "எ" ; "அ" ; "இ" ; "உ"} ;
  labial : Strs = strs {"மௌ" ; "பௌ"} ;
  retroflex : Strs = strs {"ணௌ" ; "டௌ"} ;
  sandhi_u : Str = pre {"உ" ; [] / vowel} ;
  sandhi_n : Str = pre {"னௌ" ; "மௌ" / labial} ;
  sandhi_spc_n : Str = pre {"னௌ" ; "பௌ" / labial} ;
  -- sandhi_N : Str = post {"னௌ" ; "ணௌ" / retroflex } ;

param DForm = unit | attr1 | attr2 | teen ;
param Size = sg | four | five | eight | nine | more100 | less100 ;
param Place = attr | indep ;
param Sub1000Data = attrtwo | indeptwo | preceded | lakhs | lakhs2 ; 

lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str ; size : Size} ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Place => Str ; size : Size} ;
lincat Sub1000 = {s : Sub1000Data => Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = [] ++ x0.s ++ []} ; -- the Tamil environment

lin n2  =
  {s = table {teen => "பனௌனாரணௌடீ" ; 
              unit => "இரணௌடௌ" + sandhi_u ; 
              attr1 => "இரீ" ; 
              attr2 => variants {"இரணௌடௌ" + sandhi_u ; "ஈரௌ"} } ; size = less100} ;
lin n3  =
  {s = table {teen => "பதானௌ" + "முனௌரீ" ; 
              unit => "முனௌரௌ" + sandhi_u ; 
              attr1 => "மீ" + sandhi_spc_n ;
              attr2 => "முறௌ"} ; size = less100} ;
lin n4  =
  {s = table {teen => "பதா" + variants { "ந஽றீ" ; "ந஽னௌகீ" } ; 
              unit => variants { "ந஽றௌ" + sandhi_u ; "ந஽னௌகௌ" + sandhi_u } ;
              attr1 => "ந஽ரௌ" ;
              attr2 => "ந஽றௌ"} ; size = four} ;
lin n5  =
  {s = table {teen => "பதானௌ" + "ஐனௌdீ" ;
              unit => "ஐனௌதௌ" + sandhi_u ; 
              attr1 => "ஐ" + sandhi_n ;
              attr2 => "ஐயௌ"} ; size = five} ;
lin n6  =
  {s = table {teen => "பதானௌ" + "ஆரீ" ; 
              unit => "ஆரௌ" + sandhi_u ; 
              attr1 => "அரீ" ;
              attr2 => "ஆரௌ"} ; size = less100} ;
lin n7  =
  {s = table {teen => "பதானௌ" + "ஏலீ" ; 
              unit => "ஏலௌ" + sandhi_u ; 
              attr1 => "எலீ" ;
              attr2 => "எலௌ"} ; size = less100} ;
lin n8  =
  {s = table {teen => "பதானௌ" + "எடௌடீ" ; 
              unit => "எடௌடௌ" + sandhi_u ; 
              attr1  => "எணௌ" ;
              attr2 => "எணௌணௌ"} ; size = eight} ;
lin n9  =
  {s = table {teen => "பதௌதௌ" + "ஓனௌபதீ" ; 
              unit => "ஓனௌபதௌ" + sandhi_u ; 
              attr1 => "த௉ணௌ" ;
              attr2 => "ஓனௌபதானௌ"} ; size = nine} ;

oper fiveh : Str = variants { "ஐனௌன஽ரீ" ; "அஞௌஞ஽ரீ"} ; 
oper fiveh_sandhi : Str = variants { "ஐனௌன஽ரௌ" + sandhi_u ; "அஞௌஞ஽ரௌ" + sandhi_u } ;

lin pot01  =
  {s = table {unit => "ஓனௌரீ"; teen => "பதானௌ" + "ஓனௌரீ" ; attr1 => "ஓரௌ" + sandhi_u ; attr2 => []} ; size = sg} ;
lin pot0 d =
  {s = d.s ; size = d.size} ;
lin pot110  =
  {s = table {_ => "பதௌதீ"} ; size = less100} ;
lin pot111  =
  {s = table {_ => "பதானௌ" + "ஓனௌரௌ" + sandhi_u} ; size = less100} ;
lin pot1to19 d =
  {s =  table {_ => d.s ! teen} ; size = less100} ;
lin pot0as1 n =
  {s = table {attr => n.s ! attr2 ; indep => n.s ! unit} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => table {nine => "த௉ணௌண஽ரௌ" + sandhi_u ; _ => d.s ! attr1 ++ "பதீ"} ! d.size} ; size = less100} ;
lin pot1plus d e =
  {s = table {_ => table {nine => ("த௉ணௌண஽ரௌ" + sandhi_u) ++ e.s ! unit; _ => d.s ! attr1 ++ "பதௌ" + sandhi_u } ! d.size ++ e.s ! unit }; size = less100} ;
lin pot1as2 n =
  {s = table {indeptwo => n.s ! indep ; attrtwo => n.s ! attr ; preceded => n.s ! indep ; _ => "dீமௌமௌயௌ"}; size = n.size} ;
lin pot2 d =
  {s = table {indeptwo => 
              table {nine => "த௉லௌல஽யாரமௌ" ; 
                     eight => "எணௌண஽ரீ" ;
		     four => "ந஽ந஽ரீ" ;
                     five => fiveh ;
                     sg => "ந஽ரீ" ;   
                     _ => d.s ! attr1 ++ "ந஽ரீ"} ! d.size ; 
              attrtwo =>
	      table {nine => "த௉லௌல஽யாரதௌதௌ" + sandhi_u ; 
                     eight => "எணௌண஽ரௌ" + sandhi_u ; 
                     four => "ந஽ந஽ரௌ" + sandhi_u;
                     five => fiveh_sandhi ;
                     _ => d.s ! attr1 ++ "ந஽ரௌ" + sandhi_u} ! d.size ;
              preceded => 
              table {nine => "த௉லௌல஽யாரமௌ" ; 
                     eight => "எணௌண஽ரீ" ;
                     four => "ந஽ந஽ரீ" ;
                     five => fiveh ;
                     _ => d.s ! attr1 ++ "ந஽ரீ"} ! d.size ;
	      lakhs => d.s ! unit ++ "இறடௌசமௌ" ; 
              lakhs2 => d.s ! unit ++ "இறடௌசதௌதீ" } ;
       size = more100} ;
lin pot2plus d e =
  {s = table {indeptwo => 
              table {nine => ("த௉லௌல஽யாரதௌதௌ" + sandhi_u) ;
                     eight => ("எணௌண஽ரௌ" + sandhi_u) ;
                     four => ("ந஽ந஽ரௌ" + sandhi_u) ;
                     five => fiveh_sandhi ; 
                     sg => ("ந஽ரௌ" + sandhi_u) ;
                     _ => d.s ! attr1 ++ ("ந஽ரௌ" + sandhi_u) } ! d.size ++ e.s ! indep ;
              attrtwo =>
	      table {nine => ("த௉லௌல஽யாரதௌதௌ" + sandhi_u) ; 
                     eight => ("எணௌண஽ரௌ" + sandhi_u) ;
		     four => ("ந஽ந஽ரௌ" + sandhi_u) ;
                     five => fiveh_sandhi ; 
		     sg => ("ந஽ரௌ" + sandhi_u) ;
                     _ => d.s ! attr1 ++ ("ந஽ரௌ" + sandhi_u) } ! d.size ++ e.s ! indep ;
	      preceded => 
	      table {nine => ("த௉லௌல஽யாரதௌதௌ" + sandhi_u) ; 
                     eight => ("எணௌண஽ரௌ" + sandhi_u) ;
                     four => ("ந஽ந஽ரௌ" + sandhi_u) ;
		     five => fiveh_sandhi ;
                     _ => d.s ! attr1 ++ ("ந஽ரௌ" + sandhi_u) } ! d.size ++ e.s ! indep ;
	      lakhs => d.s ! unit ++ ("இறடௌசதௌதௌ" + sandhi_u) ++ 
                       table {sg => "ஆயாரமௌ" ; _ => e.s ! attr ++ "ஆயாரமௌ" } ! e.size ;
	      lakhs2 => d.s ! unit ++ ("இறடௌசதௌதௌ" + sandhi_u) ++ 
                        table {sg => "ஆயாரதௌதௌ" + sandhi_u ; _ => e.s ! attr ++ ("ஆயாரதௌதௌ" + sandhi_u) } ! e.size} ; size = more100} ;

lin pot2as3 n =
  {s = n.s ! indeptwo} ;
lin pot3 n =
  {s = table {sg => "ஆயாரமௌ" ; 
              more100 => n.s ! lakhs ;
              _ => n.s ! attrtwo ++ "ஆயாரமௌ" } ! n.size } ;

lin pot3plus n m =
  {s = table {sg => "ஆயாரதௌதௌ" + sandhi_u; 
              more100 => n.s ! lakhs2 ;
              _ => n.s ! attrtwo ++ "ஆயாரதௌதௌ" + sandhi_u } ! n.size ++ m.s ! preceded} ;
 

}
