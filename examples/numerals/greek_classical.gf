include numerals.Abs.gf ;
flags coding=greek ;

-- Classical Greek (of Athens)
-- Aarne's transliteration
-- There are attested variant forms. kai:s between the elements in bigger ->
-- smaller order is also possible but not common.

param DForm = unit | tkismyr | teen | ten | hund | kisxil | kismyr | 
              tenkismyr | tenkis ;
param InterData = indep Order | xiliad | myriad Order ;
param Tenpart = kis1 | tkis1 ;
param Size = sg | pl | tenoverpl ;
param Order = des | asc; 
lincat Numeral = {s : Str} ;

oper LinDigit = {s : DForm => Str} ;
oper LinSub1000 = {s : InterData => Str ; size : Size} ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ;
		size : Size} ;
lincat Sub100 = {s : InterData => Str ; 
		 s1 : Tenpart => Str ; 
		 s2 : Str ;
		 size : Size} ;
lincat Sub1000 = LinSub1000 ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = "//" ++ x0.s ++ "//"} ;  -- Greek environment

oper mkNum : Str -> Str -> Str -> Str -> Str -> Str -> Str -> LinDigit =
  \dyo -> \dis -> \dwdekakis -> \dwdeka -> \eikosi -> \diakosioi -> 
  \eikosakis ->
             {s = table {unit => dyo ; 
                    tkismyr => dwdekakis + "m'yrioi" ; 
                    teen => dwdeka ; 
                    ten => eikosi ; 
                    hund => diakosioi ; 
                    kisxil => dis + "c'ilioi" ; 
                    kismyr => dis + "m'yrioi" ;
                    tenkis => eikosakis ; 
                    tenkismyr => eikosakis + "m'yrioi"} };

lin n2 = mkNum 
  "d'yo" 
  "dis" 
  "dwdekakis" 
  "d'wdeka" 
  "e)'ikosi" 
  "diak'osioi" 
  "e)ikos'akis" ;

lin n3 = mkNum 
  "tre~ij" 
  "tris" 
  "treiskaidekakis" 
  (variants {"tre~ij" ++ "ka`i" ++ "d'eka" ; "treiska'ideka"} ) 
  "tri'akonta" 
  "triak'osioi" 
  "triakont'akis" ;

lin n4 = mkNum 
  "t'ettarej" 
  "tetrakis" 
  "tettareskaidekakis" 
  (variants {"t'ettarej" ++ "ka`i" ++ "d'eka" ; "tettareska'ideka"})  
  "tettar'akonta" 
  "tetrak'osioi"
  "tettarakont'akis" ;

lin n5 = mkNum
  "p'ente"
  "pentakis" 
  "pentekaidekakis" 
  "penteka'ideka" 
  "pent'hkonta"
  "pentak'osioi" 
  "penthkont'akis" ;

lin n6 = mkNum 
  "('ex" 
  "(exakis" 
  "(ekkaidekakis" 
  "(ekka'ideka" 
  "(ex'hkonta"
  "(exak'osioi" 
  "(exhkont'akis" ;

lin n7 = mkNum
  "(ept'a"
  "(eptakis"
  "(eptakaidekakis" 
  "(eptaka'ideka"  
  "(ebdom'hkonta" 
  "(eptak'osioi" 
  "(ebdomhkont'akis" ;

lin n8 = mkNum 
  ")okt'w" 
  ")oktakis"
  ")oktwkaidekakis"
  ")oktwka'ideka"
  ")ogdo'hkonta"
  ")oktak'osioi" 
  ")ogdohkont'akis" ;

lin n9 = mkNum
  ")enn'ea" 
  ")enakis" 
  ")enneakaidekakis" 
  ")enneaka'ideka" 
  ")enen'hkonta" 
  ")enak'osioi" 
  ")enenhkont'akis" ;

lin pot01  =
  {s = table {hund => "(ekat'on" ;
              kisxil => "c'ilioi" ;
              kismyr => "('apax" + "m'yrioi" ;
              _ => "e('ij" } ; 
   size = sg} ;
lin pot0 d =
  {s = d.s ; size = pl} ;
lin pot110  =
  {s = table {xiliad => "dummy" ; 
              (myriad _) => "m'yrioi" ;
              (indep _) => "d'eka" };
   s1 = table {kis1 => "('apax" + "m'yrioi" ; tkis1 => "(endek'akis" + "m'yrioi"} ;
   s2 = [] ;
   size = tenoverpl} ;
lin pot111  =
  {s = table {xiliad => "dummy" ; 
              (myriad des) => "m'yrioi" ++ "c'ilioi" ; 
              (myriad asc) => "c'ilioi" ++ "ka`i" ++ "m'yrioi" ; 
              (indep _) => "('endeka" } ;
   s1 = table {kis1 => "('apax" + "m'yrioi" ; tkis1 => "(endek'akis" + "m'yrioi"} ;
   s2 = "c'ilioi" ;
   size = tenoverpl} ;
lin pot1to19 d =
  {s = table {xiliad => "dummy" ; 
              (myriad des) => "m'yrioi" ++ d.s ! kisxil ; 
	      (myriad asc) => d.s ! kisxil ++ "ka`i" ++ "m'yrioi" ;  
              (indep _) => d.s ! teen } ; 
   s1 = table {kis1 => "('apax" + "m'yrioi" ; tkis1 => "(endek'akis" + "m'yrioi" } ;
   s2 = d.s ! kisxil ; 
   size = tenoverpl} ;
lin pot0as1 n =
  {s = table {xiliad => n.s ! kisxil ; 
              (indep _) => n.s ! unit ;
	      (myriad _) => "dummy" } ;
   s1 = table {_ => []} ;
   s2 = n.s ! kisxil ;
   size = n.size} ;
lin pot1 d =
  {s = table {xiliad => "dummy" ; 
	      (myriad _) => d.s ! kismyr ; 
              (indep _) => d.s ! ten} ;
   s1 = table {kis1 => d.s ! kismyr ; tkis1 => d.s ! tkismyr } ;
   s2 = []; 
   size = tenoverpl} ;
lin pot1plus d e =
  {s = table {xiliad => "dummy" ;
              (myriad des) => d.s ! kismyr ++ e.s ! kisxil ;
	      (myriad asc) => e.s ! kisxil ++ "ka`i" ++ d.s ! kismyr ; 
              (indep des) => d.s ! ten ++ e.s ! unit ; 
              (indep asc) => e.s ! unit ++ "ka`i" ++ d.s ! ten } ; 
   s1 = table {kis1 => d.s ! kismyr ; tkis1 => d.s ! tkismyr } ;
   s2 = e.s ! kisxil ;
   size = tenoverpl} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {(indep _) => d.s ! hund ; 
              (myriad _) => d.s ! tenkismyr; 
              xiliad => "dummy"} ; 
   size = tenoverpl} ;
lin pot2plus d e =
  {s = table {(myriad _) => table {sg => e.s1 ! tkis1 ;
                                   pl => d.s ! tenkis ++ e.s1 ! kis1 ;
                                   tenoverpl => "dummy" } ! d.size ++ e.s2 ; 
              (indep des) => d.s ! hund ++ e.s ! indep des ;
              (indep asc) => (e.s ! indep asc) ++ "ka`i" ++ d.s ! hund ;
              xiliad => "dummy" } ; 
   size = tenoverpl} ;

lin pot2as3 n =
  {s = variants { n.s ! indep des ; n.s ! indep asc}} ;
lin pot3 n =
  {s = variants {(Myr n des) ! n.size ; (Myr n asc) ! n.size} } ;
lin pot3plus n m =
  {s = variants {(Myr n des) ! n.size ++ m.s ! indep des; 
                 m.s ! indep asc ++ "ka`i" ++ (Myr n asc) ! n.size }} ;

oper Myr : LinSub1000 -> Order -> Size => Str = \n -> \order ->
  table {sg => "c'ilioi" ; 
         pl => n.s ! xiliad ;
         tenoverpl => n.s ! myriad order} ;

