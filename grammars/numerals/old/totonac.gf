include numerals.Abs.gf ;

oper mk20Ten : Str -> Str -> Str -> Size -> LinDigit = 
  \tri -> \fiche -> \ext -> \sz -> 
  { s = table {unit => tri ; maaunit => "maa" ++ tri ; twenty => fiche ; extra => ext } ; even20 = ten ; size = sz} ;

oper mkEven20 : Str -> Str -> Str -> Size -> LinDigit = 
  \se -> \trifichid -> \ext -> \sz -> 
  { s = table {unit => se ; maaunit => "maa" ++ se ; twenty => trifichid ; extra => ext } ; even20 = even ; size = sz} ;

param Even20 = ten | even ;
param DForm = unit | maaunit | extra | twenty ;
param Size = one | two | three | four | five | pl ;
 
lincat Numeral = {s : Str} ;
oper LinDigit = {s : DForm => Str ; even20 : Even20 ; size : Size} ;

lincat Digit = LinDigit ; 
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; tenpsize : Size ; s2 : Str} ;
lincat Sub1000 = {s : Str } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;
lin n2  = mkEven20 "t~u3" "pus^um" [] two;  
lin n3  = mk20Ten "itun" ("pus^um" ++ "maa" ++ "kaawi") [] two;
lin n4  = mkEven20 "t~a~at" (variants {"pus^um" ++ "pus^um" ; "tiy~u~u" ++ "pus^um"}) [] three;
lin n5  = mk20Ten (variants {"kitis" ; "kic/is"}) 
                  (variants {("paha" ++ "sye<ntu" ++ "~a") ;
                            "pus^um" ++ "pus^um" ++ "maa" ++ "kaawi" ; 
                            "tiy~u~u" ++ "pus^um" ++ "maa" ++ "kaawi" }) [] three; 
lin n6  = mkEven20 "c^aas^an" 
                   (variants {("pus^um" ++ "pus^um" ++ "pus^um") ;
                              "tutun" ++ "pus^um" }) "~a" four;
lin n7  = mk20Ten "tuhun" (variants {("pus^um" ++ "pus^um" ++ "pus^um" ++ "lii" ++ "~a" ++ "kaawi" ) ; ("tutun" ++ "pus^um" ++ "maa" ++ "kaawi")}) [] four ;
lin n8  = mkEven20 "c/iyan" (variants {("t~a~ati" ++ "pus^um") ; ("maa" ++ "t~a~ati" ++ "pus^um")}) ("lii" ++ "~a") five ;
lin n9  = mk20Ten "nahaac/a" ("t~a~ati" ++ "pus^um" ++ "maa" ++ "kaawi") [] five;

oper addkaawi : Size => Str = table {sz => "maa" ++ "kaawi" ++ mk5twenty ! sz };

oper mk5twenty : Size => Str = table {
   one => variants {("maa" ++ "kic/is") ; "kic/is"} ++ "pus^um";
   two => "c^aas^an" ++ "pus^um"; 
   three => "tuhun" ++ "pus^um";
   four => "c/iyan" ++ "pus^um";
   _ => "nahaac/a" ++ "pus^um"
} ; 

oper mktwenty : Str -> Str -> Str -> Str -> Str -> Size => Str =
  \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> table {
  one => a1 ++ "pus^um" ;
  two => a2 ++ "pus^um" ; 
  three => a3 ++ "pus^um" ;
  four => a4 ++ "pus^um" ;
  _ => a5 ++ "pus^um" 
} ; 

oper get20 : Str -> Size -> Size -> Str = \df -> \sz1 -> \sz2 -> 
  table {one => mk5twenty ; 
         two => mktwenty ("maa" ++ "kaawi") 
                         ("maa" ++ "kaawi" ++ "tun") 
                         ("maa" ++ "kaawi" ++ "t~u3") 
                         ("maa" ++ "kaawi" ++ "itun") 
                         ("maa" ++ "kaawi" ++ "t~a~at") ; 
         three => addkaawi ; 
         _  => table {_ => df } } ! sz1 ! sz2 ;

lin pot01 =
  {s = table {unit => "tun" ; maaunit => "tun" ; tfive => "kic/is" ++ "pus^um" } ; even20 = ten ; size = one};
lin pot0 d =
  {s = d.s ; even20 = d.even20 ; size = one} ;
lin pot110 =
  {s = "kaawi" ; tenpsize = one ; s2 = "tun"} ;
lin pot111  =
  {s = "kaawi" ++ "tun" ; tenpsize = one ; s2 = "tun" } ;
lin pot1to19 d =
  {s = "kaawi" ++ d.s ! unit ; tenpsize = one ; s2 = d.s ! unit } ;
lin pot0as1 n =
  {s = n.s ! maaunit ; tenpsize = one ; s2 = n.s ! maaunit} ;
lin pot1 d =
  {s = d.s ! twenty ; 
   tenpsize = d.size ; 
   s2 = [] } ;

lin pot1plus d e =
  {s = table {even => d.s ! twenty ++ d.s ! extra ++ e.s ! maaunit;  
              ten => d.s ! twenty ++ e.s ! unit} ! (d.even20) ;
   tenpsize = d.size ; 
   s2 = table {even => e.s ! maaunit ; ten => e.s ! unit} ! d.even20} ;

lin pot1as2 n = {s = n.s}  ;

lin pot2 d = 
  {s = variants {get20 (d.s ! maaunit ++ "sye<ntu") d.size one ;
                 d.s ! maaunit ++ "sye<ntu" }};
lin pot2plus d e =
  {s = variants {(get20 (d.s ! maaunit ++ "sye<ntu") d.size e.tenpsize) ++ e.s2;
                 d.s ! maaunit ++ "sye<ntu" ++ e.s}} ;
lin pot2as3 n =
  {s = n.s } ;
lin pot3 n =
  {s = n.s ++ "mil" } ;
lin pot3plus n m =
  {s = n.s ++ "mil" ++ "lii" ++ "~a" ++ m.s } ; 



 