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


include numerals.Abs.gf ;

oper 
  vowel : Strs = strs {"o" ; "e" ; "a" ; "i" ; "u"} ;
  labial : Strs = strs {"m" ; "p"} ;
  retroflex : Strs = strs {"N" ; "T"} ;
  sandhi_u : Str = pre {"u" ; [] / vowel} ;
  sandhi_n : Str = pre {"n" ; "m" / labial} ;
  sandhi_spc_n : Str = pre {"n" ; "p" / labial} ;
  -- sandhi_N : Str = post {"n" ; "N" / retroflex } ;

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
  {s = "/T" ++ x0.s ++ "T/"} ; -- the Tamil environment

lin n2  =
  {s = table {teen => "panniraNTu" ; 
              unit => "iraNT" + sandhi_u ; 
              attr1 => "iru" ; 
              attr2 => variants {"iraNT" + sandhi_u ; "i:r"} } ; size = less100} ;
lin n3  =
  {s = table {teen => "patin" + "mu:nru" ; 
              unit => "mu:nr" + sandhi_u ; 
              attr1 => "mu" + sandhi_spc_n ;
              attr2 => "mu:l"} ; size = less100} ;
lin n4  =
  {s = table {teen => "pati" + variants { "Va:lu" ; "Va:nku" } ; 
              unit => variants { "Va:l" + sandhi_u ; "Va:nk" + sandhi_u } ;
              attr1 => "Va:r" ;
              attr2 => "Va:l"} ; size = four} ;
lin n5  =
  {s = table {teen => "patin" + "aindu" ;
              unit => "aint" + sandhi_u ; 
              attr1 => "ai" + sandhi_n ;
              attr2 => "aiy"} ; size = five} ;
lin n6  =
  {s = table {teen => "patin" + "a:ru" ; 
              unit => "a:r" + sandhi_u ; 
              attr1 => "aru" ;
              attr2 => "a:r"} ; size = less100} ;
lin n7  =
  {s = table {teen => "patin" + "e:Lu" ; 
              unit => "e:L" + sandhi_u ; 
              attr1 => "eLu" ;
              attr2 => "eL"} ; size = less100} ;
lin n8  =
  {s = table {teen => "patin" + "eTTu" ; 
              unit => "eTT" + sandhi_u ; 
              attr1  => "eN" ;
              attr2 => "eNN"} ; size = eight} ;
lin n9  =
  {s = table {teen => "patt" + "o:npatu" ; 
              unit => "o:npat" + sandhi_u ; 
              attr1 => "toN" ;
              attr2 => "o:npatin"} ; size = nine} ;

oper fiveh : Str = variants { "ainna:ru" ; "añña:ru"} ; 
oper fiveh_sandhi : Str = variants { "ainna:r" + sandhi_u ; "añña:r" + sandhi_u } ;

lin pot01  =
  {s = table {unit => "o:nru"; teen => "patin" + "o:nru" ; attr1 => "o:r" + sandhi_u ; attr2 => []} ; size = sg} ;
lin pot0 d =
  {s = d.s ; size = d.size} ;
lin pot110  =
  {s = table {_ => "pattu"} ; size = less100} ;
lin pot111  =
  {s = table {_ => "patin" + "o:nr" + sandhi_u} ; size = less100} ;
lin pot1to19 d =
  {s =  table {_ => d.s ! teen} ; size = less100} ;
lin pot0as1 n =
  {s = table {attr => n.s ! attr2 ; indep => n.s ! unit} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => table {nine => "toNNa:r" + sandhi_u ; _ => d.s ! attr1 ++ "patu"} ! d.size} ; size = less100} ;
lin pot1plus d e =
  {s = table {_ => table {nine => ("toNNa:r" + sandhi_u) ++ e.s ! unit; _ => d.s ! attr1 ++ "pat" + sandhi_u } ! d.size ++ e.s ! unit }; size = less100} ;
lin pot1as2 n =
  {s = table {indeptwo => n.s ! indep ; attrtwo => n.s ! attr ; preceded => n.s ! indep ; _ => "dummy"}; size = n.size} ;
lin pot2 d =
  {s = table {indeptwo => 
              table {nine => "toLLa:yiram" ; 
                     eight => "eNNa:ru" ;
		     four => "Va:Va:ru" ;
                     five => fiveh ;
                     sg => "Va:ru" ;   
                     _ => d.s ! attr1 ++ "Va:ru"} ! d.size ; 
              attrtwo =>
	      table {nine => "toLLa:yiratt" + sandhi_u ; 
                     eight => "eNNa:r" + sandhi_u ; 
                     four => "Va:Va:r" + sandhi_u;
                     five => fiveh_sandhi ;
                     _ => d.s ! attr1 ++ "Va:r" + sandhi_u} ! d.size ;
              preceded => 
              table {nine => "toLLa:yiram" ; 
                     eight => "eNNa:ru" ;
                     four => "Va:Va:ru" ;
                     five => fiveh ;
                     _ => d.s ! attr1 ++ "Va:ru"} ! d.size ;
	      lakhs => d.s ! unit ++ "ilaTcam" ; 
              lakhs2 => d.s ! unit ++ "ilaTcattu" } ;
       size = more100} ;
lin pot2plus d e =
  {s = table {indeptwo => 
              table {nine => ("toLLa:yiratt" + sandhi_u) ;
                     eight => ("eNNa:r" + sandhi_u) ;
                     four => ("Va:Va:r" + sandhi_u) ;
                     five => fiveh_sandhi ; 
                     sg => ("Va:r" + sandhi_u) ;
                     _ => d.s ! attr1 ++ ("Va:r" + sandhi_u) } ! d.size ++ e.s ! indep ;
              attrtwo =>
	      table {nine => ("toLLa:yiratt" + sandhi_u) ; 
                     eight => ("eNNa:r" + sandhi_u) ;
		     four => ("Va:Va:r" + sandhi_u) ;
                     five => fiveh_sandhi ; 
		     sg => ("Va:r" + sandhi_u) ;
                     _ => d.s ! attr1 ++ ("Va:r" + sandhi_u) } ! d.size ++ e.s ! indep ;
	      preceded => 
	      table {nine => ("toLLa:yiratt" + sandhi_u) ; 
                     eight => ("eNNa:r" + sandhi_u) ;
                     four => ("Va:Va:r" + sandhi_u) ;
		     five => fiveh_sandhi ;
                     _ => d.s ! attr1 ++ ("Va:r" + sandhi_u) } ! d.size ++ e.s ! indep ;
	      lakhs => d.s ! unit ++ ("ilaTcatt" + sandhi_u) ++ 
                       table {sg => "a:yiram" ; _ => e.s ! attr ++ "a:yiram" } ! e.size ;
	      lakhs2 => d.s ! unit ++ ("ilaTcatt" + sandhi_u) ++ 
                        table {sg => "a:yiratt" + sandhi_u ; _ => e.s ! attr ++ ("a:yiratt" + sandhi_u) } ! e.size} ; size = more100} ;

lin pot2as3 n =
  {s = n.s ! indeptwo} ;
lin pot3 n =
  {s = table {sg => "a:yiram" ; 
              more100 => n.s ! lakhs ;
              _ => n.s ! attrtwo ++ "a:yiram" } ! n.size } ;

lin pot3plus n m =
  {s = table {sg => "a:yiratt" + sandhi_u; 
              more100 => n.s ! lakhs2 ;
              _ => n.s ! attrtwo ++ "a:yiratt" + sandhi_u } ! n.size ++ m.s ! preceded} ;
 
