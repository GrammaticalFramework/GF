concrete maybrat of Numerals = {
-- include numerals.Abs.gf ;

oper LinDigit = {s : DForm => Str ; even20 : Even20 } ;

oper mk20Ten : Str -> Str -> Str -> LinDigit = \tri -> \t -> \h -> 
  { s = table {unit => tri ; unit2 => t ; twenty => "rae" ++ h } ; 
    even20 = ten};

oper mkEven20 : Str -> Str -> Str -> LinDigit = \se -> \t -> \h -> 
  { s = table {unit => se ; unit2 => t ; twenty => "rae" ++ h } ;
    even20 = even}; 

oper na = {s = "N/A"} ; 

param Even20 = ten | even ;
param DForm = unit | unit2 | twenty ;
 
lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str } ;
lincat Sub1000 = {s : Str } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;
lin n2  = mkEven20 (variants{"ewok"; "eok"}) 
                   ("krem" ++ "ewok") 
                   ("sait" ++ "yhai") ;
lin n3  = mk20Ten "tuf" 
                  ("krem" ++ "tuf") 
                  ("sait" ++ "yhai") ;
lin n4  = mkEven20 "tiet" 
                   ("krem" ++ "tiet") 
                   ("ewok" ++ "mhai") ;
lin n5  = mk20Ten (variants {"mat" ; "temsau"}) 
                  ("sau" ++ "muf") 
                  ("ewok" ++ "mhai") ;
lin n6  = mkEven20 ("krem" ++ "sau") 
                   ("sau" ++ "krem" ++ "sau") 
                   ("tuf" ++ "mhai") ;
lin n7  = mk20Ten ("krem" ++ "ewok") 
                  ("sau" ++ "krem" ++ "ewok") 
                  ("tuf" ++ "mhai") ;
lin n8  = mkEven20 ("krem" ++ "tuf") 
                   ("sau" ++ "krem" ++ "tuf") 
                   ("tiet" ++ "mhai") ;
lin n9  = mk20Ten ("krem" ++ "tiet") 
                  ("sau" ++ "krem" ++ "tiet") 
                  ("tiet" ++ "mhai") ;

lin pot01  =
  {s = table {unit => "sau" ; unit2 => "krem" ++ "sau" ; twenty => "dummy" } ; 
   even20 = ten };
lin pot0 d = d ;
lin pot110 = {s = "statem" } ;
lin pot111 = {s = "oo" ++ "krem" ++ "sau" } ;
lin pot1to19 d = {s = "oo" ++ d.s ! unit2 } ;
lin pot0as1 n = {s = n.s ! unit} ;
lin pot1 d =
  {s = table {even => d.s ! twenty ;  
              ten => (d.s ! twenty) ++ "statem"} ! d.even20} ;
lin pot1plus d e =
  {s = table {even => d.s ! twenty ++ e.s ! unit ;  
              ten => (d.s ! twenty) ++ (e.s ! unit2)} ! d.even20} ;

lin pot1as2 n = n ; 
lin pot2 d = na; 
lin pot2plus d e = na;
lin pot2as3 n = n ;
lin pot3 n = na ;
lin pot3plus n m = na ;

}
