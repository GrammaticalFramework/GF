include numerals.Abs.gf ;

param DForm = ten | unit ;
param Size = sg | sub10 | pl | e10;

oper LinDigit = {s : DForm => Str ; s2 : Str ; size : Size} ;
oper LinS100 = {s : Str ; s2 : Str ; size : Size} ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = LinS100 ;
lincat Sub1000 = LinS100 ;
lincat Sub1000000 = {s : Str} ;

oper mkNum : Str -> LinDigit = \kunun ->
  {s = table {unit => kunun ; ten => "mOrta" ++ kunun } ; 
   s2 = "dubu" ++ kunun ; 
   size = sub10} ;

lin num x0 =
  {s = x0.s} ; -- TODO 

-- o.
-- O for IPA o in Eng. Cod

lin n2 = {s = table {unit => "cu" ; ten => "digidem" } ; s2 = "dubu" ++ "cu"; size = sub10} ;
lin n3 = mkNum "ago.zo." ;
lin n4 = mkNum "tozo" ;
lin n5 = mkNum "fo";
lin n6 = mkNum "dissi" ;
lin n7 = mkNum (variants {"tuduzu" ; "tudusu"}) ;
lin n8 = mkNum (variants {"osso" ; "yosso"}) ;
lin n9 = mkNum "issi";

oper olufu : Str = variants {"oluou" ; "olufu"} ;
oper ss : Str -> Str -> LinS100 = \a -> \b -> {s = a ; s2 = b ; size = pl} ; 
oper ss2 : Str -> Str -> LinS100 = \a -> \b -> {s = a ; s2 = b ; size = e10} ;

lin pot01 = {s = table {_ => "tro" }; s2 = "dubu" ; size = sg};
lin pot0 d = d ;
lin pot110 = ss2 "mOrdOm" []; 
lin pot111 = ss2 ("mOrdOm" ++ "sao" ++ "tro") ("dubu");
lin pot1to19 d = ss2 ("mOrdOm" ++ "sao" ++ d.s ! unit) ("dubu" ++ d.s ! unit);
lin pot0as1 n = {s = n.s ! unit ; s2 = n.s2 ; size = n.size} ;
lin pot1 d = ss (d.s ! ten) (d.s ! unit) ;
lin pot1plus d e = ss (d.s ! ten ++ "sao" ++ e.s ! unit) (d.s ! unit ++ e.s2) ; 
lin pot1as2 n = {s = n.s ; s2 = ifsub10 n.s2 ! n.size ; size = n.size };
lin pot2 d = ss (selsg "kidri" ("kidra" ++ d.s ! unit) ! d.size) 
                (olufu ++ d.s ! ten) ; 
lin pot2plus d e = 
  ss (selsg "kidri" ("kidra" ++ d.s ! unit) ! d.size ++ "sao" ++ e.s) 
     (olufu ++ d.s ! ten ++ "sao" ++ ifs10 ! e.size ++ e.s2) ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = n.s2}; 
lin pot3plus n m = {s = n.s2 ++ "sao" ++ m.s};

oper ifs10 : Size => Str = table {e10 => "tro" ; _ => []} ;
oper ifsub10 : Str -> Size => Str = \a ->
  table {pl => olufu ++ a; e10 => olufu ++ a ; _ => a } ;
oper selsg : Str -> Str -> Size => Str = \a -> \b ->
  table {sg => a ; _ => b} ; 