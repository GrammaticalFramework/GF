concrete greek_classical of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=greek ;

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
  {s = [] ++ x0.s ++ []} ;  -- Greek environment

oper mkNum : Str -> Str -> Str -> Str -> Str -> Str -> Str -> LinDigit =
  \dyo -> \dis -> \dwdekakis -> \dwdeka -> \eikosi -> \diakosioi -> 
  \eikosakis ->
             {s = table {unit => dyo ; 
                    tkismyr => dwdekakis + "μύριοι" ; 
                    teen => dwdeka ; 
                    ten => eikosi ; 
                    hund => diakosioi ; 
                    kisxil => dis + "χίλιοι" ; 
                    kismyr => dis + "μύριοι" ;
                    tenkis => eikosakis ; 
                    tenkismyr => eikosakis + "μύριοι"} };

lin n2 = mkNum 
  "δύο" 
  "δισ" 
  "δωδεκακισ" 
  "δώδεκα" 
  "εἴκοσι" 
  "διακόσιοι" 
  "εἰκοσάκισ" ;

lin n3 = mkNum 
  "τρεῖς" 
  "τρισ" 
  "τρεισκαιδεκακισ" 
  (variants {"τρεῖς" ++ "καὶ" ++ "δέκα" ; "τρεισκαίδεκα"} ) 
  "τριάκοντα" 
  "τριακόσιοι" 
  "τριακοντάκισ" ;

lin n4 = mkNum 
  "τέτταρες" 
  "τετρακισ" 
  "τετταρεσκαιδεκακισ" 
  (variants {"τέτταρες" ++ "καὶ" ++ "δέκα" ; "τετταρεσκαίδεκα"})  
  "τετταράκοντα" 
  "τετρακόσιοι"
  "τετταρακοντάκισ" ;

lin n5 = mkNum
  "πέντε"
  "πεντακισ" 
  "πεντεκαιδεκακισ" 
  "πεντεκαίδεκα" 
  "πεντήκοντα"
  "πεντακόσιοι" 
  "πεντηκοντάκισ" ;

lin n6 = mkNum 
  "ἕξ" 
  "ἑξακισ" 
  "ἑκκαιδεκακισ" 
  "ἑκκαίδεκα" 
  "ἑξήκοντα"
  "ἑξακόσιοι" 
  "ἑξηκοντάκισ" ;

lin n7 = mkNum
  "ἑπτά"
  "ἑπτακισ"
  "ἑπτακαιδεκακισ" 
  "ἑπτακαίδεκα"  
  "ἑβδομήκοντα" 
  "ἑπτακόσιοι" 
  "ἑβδομηκοντάκισ" ;

lin n8 = mkNum 
  "ὀκτώ" 
  "ὀκτακισ"
  "ὀκτωκαιδεκακισ"
  "ὀκτωκαίδεκα"
  "ὀγδοήκοντα"
  "ὀκτακόσιοι" 
  "ὀγδοηκοντάκισ" ;

lin n9 = mkNum
  "ἐννέα" 
  "ἐνακισ" 
  "ἐννεακαιδεκακισ" 
  "ἐννεακαίδεκα" 
  "ἐνενήκοντα" 
  "ἐνακόσιοι" 
  "ἐνενηκοντάκισ" ;

lin pot01  =
  {s = table {hund => "ἑκατόν" ;
              kisxil => "χίλιοι" ;
              kismyr => "ἅπαξ" + "μύριοι" ;
              _ => "εἵς" } ; 
   size = sg} ;
lin pot0 d =
  {s = d.s ; size = pl} ;
lin pot110  =
  {s = table {xiliad => "δψμμυ" ; 
              (myriad _) => "μύριοι" ;
              (indep _) => "δέκα" };
   s1 = table {kis1 => "ἅπαξ" + "μύριοι" ; tkis1 => "ἑνδεκάκισ" + "μύριοι"} ;
   s2 = [] ;
   size = tenoverpl} ;
lin pot111  =
  {s = table {xiliad => "δψμμυ" ; 
              (myriad des) => "μύριοι" ++ "χίλιοι" ; 
              (myriad asc) => "χίλιοι" ++ "καὶ" ++ "μύριοι" ; 
              (indep _) => "ἕνδεκα" } ;
   s1 = table {kis1 => "ἅπαξ" + "μύριοι" ; tkis1 => "ἑνδεκάκισ" + "μύριοι"} ;
   s2 = "χίλιοι" ;
   size = tenoverpl} ;
lin pot1to19 d =
  {s = table {xiliad => "δψμμυ" ; 
              (myriad des) => "μύριοι" ++ d.s ! kisxil ; 
	      (myriad asc) => d.s ! kisxil ++ "καὶ" ++ "μύριοι" ;  
              (indep _) => d.s ! teen } ; 
   s1 = table {kis1 => "ἅπαξ" + "μύριοι" ; tkis1 => "ἑνδεκάκισ" + "μύριοι" } ;
   s2 = d.s ! kisxil ; 
   size = tenoverpl} ;
lin pot0as1 n =
  {s = table {xiliad => n.s ! kisxil ; 
              (indep _) => n.s ! unit ;
	      (myriad _) => "δψμμυ" } ;
   s1 = table {_ => []} ;
   s2 = n.s ! kisxil ;
   size = n.size} ;
lin pot1 d =
  {s = table {xiliad => "δψμμυ" ; 
	      (myriad _) => d.s ! kismyr ; 
              (indep _) => d.s ! ten} ;
   s1 = table {kis1 => d.s ! kismyr ; tkis1 => d.s ! tkismyr } ;
   s2 = []; 
   size = tenoverpl} ;
lin pot1plus d e =
  {s = table {xiliad => "δψμμυ" ;
              (myriad des) => d.s ! kismyr ++ e.s ! kisxil ;
	      (myriad asc) => e.s ! kisxil ++ "καὶ" ++ d.s ! kismyr ; 
              (indep des) => d.s ! ten ++ e.s ! unit ; 
              (indep asc) => e.s ! unit ++ "καὶ" ++ d.s ! ten } ; 
   s1 = table {kis1 => d.s ! kismyr ; tkis1 => d.s ! tkismyr } ;
   s2 = e.s ! kisxil ;
   size = tenoverpl} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {(indep _) => d.s ! hund ; 
              (myriad _) => d.s ! tenkismyr; 
              xiliad => "δψμμυ"} ; 
   size = tenoverpl} ;
lin pot2plus d e =
  {s = table {(myriad _) => table {sg => e.s1 ! tkis1 ;
                                   pl => d.s ! tenkis ++ e.s1 ! kis1 ;
                                   tenoverpl => "δψμμυ" } ! d.size ++ e.s2 ; 
              (indep des) => d.s ! hund ++ e.s ! indep des ;
              (indep asc) => (e.s ! indep asc) ++ "καὶ" ++ d.s ! hund ;
              xiliad => "δψμμυ" } ; 
   size = tenoverpl} ;

lin pot2as3 n =
  {s = variants { n.s ! indep des ; n.s ! indep asc}} ;
lin pot3 n =
  {s = variants {(Myr n des) ! n.size ; (Myr n asc) ! n.size} } ;
lin pot3plus n m =
  {s = variants {(Myr n des) ! n.size ++ m.s ! indep des; 
                 m.s ! indep asc ++ "καὶ" ++ (Myr n asc) ! n.size }} ;

oper Myr : LinSub1000 -> Order -> Size => Str = \n -> \order ->
  table {sg => "χίλιοι" ; 
         pl => n.s ! xiliad ;
         tenoverpl => n.s ! myriad order} ;


}
