concrete lamani of Numerals = {
-- include numerals.Abs.gf ;

-- the sporadic kam-forms not implemented (general minus formations are hardly possible to implement)

param DForm = unit | ten | teen | tene | next | inv ;
param Size = sg | two | five | seven | nine | e25 | e75 | e50s | e90s | other ; 

oper LinDigit = {s : DForm => Str ; s2 : Str ; size : Size} ;
oper LinSub100 = {s : Str ; s2 : Str ; s3 : Str ; size : Size} ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = LinSub100 ; 
lincat Sub1000 = {s : Str ; s2 : Str } ; 
lincat Sub1000000 = { s : Str } ;

lin num x0 =
  {s = x0.s } ; 

oper mkNum : Str -> Str -> Str -> Str -> Str -> LinDigit = 
  \do -> \baara -> \bis -> \nxt -> \inverse ->  
  {s = table {unit => do ; teen => baara ; ten => bis ; tene => bis + "e" ; next => nxt ; inv => inverse} ;
   s2 = do ++ "hajaar" ; 
   size = other } ;

oper mkNumS : Str -> Str -> Str -> Str -> Str -> Size -> LinDigit = 
  \do -> \baara -> \bis -> \nxt -> \inverse -> \sz -> 
  {s = table {unit => do ; teen => baara ; ten => bis ; tene => bis + "e" ; next => nxt ; inv => inverse} ;
   s2 = do ++ "hajaar" ; 
   size = sz } ;

-- lin n1 mkNum "ek" "gyaara" "das" 
lin n2 = mkNum "di" "baara" "vis" ("tin" ++ "se") "aaT" ;
lin n3 = mkNumS "tin" "tera" "tis" ("caar"++ "se") "saat" two ;
lin n4 = mkNum "caar" "cawda" "caaLis" ("paanc" ++ "se") "cho" ;
lin n5 = mkNumS "paanc" "pandra" "pacaas" ("cho" ++ "se") "paanc" five;
lin n6 = mkNum "cho" "sola" "saaT" ("saat" ++ "se") "caar" ;
lin n7 = mkNumS "saat" "satara" "sattar" ("aaT" ++ "se") "tin" seven ; 
lin n8 = mkNum "aaT" "aTara" "ãysi" ("naw" ++ "se") "di" ;
lin n9 = mkNumS "naw" "wagNis" "nawwad" "hajaar" "ek" nine;

oper ss : Str -> LinSub100 = \s1 -> {s = s1 ; s2 = s1 ++ "hajaar" ; s3 = s1 ; size = other} ;
oper sssize : Str -> Str -> Size -> LinSub100 = \s1 -> \aux -> \sz -> 
  {s = s1 ; s2 = s1 ++ "hajaar" ; s3 = aux ; size = sz} ;

oper spcsize : Size -> Size -> Size = \s1 -> \s2 -> 
   table {two => table {five => e25 ; _ => other} ;
          five => table {_ => e50s} ;   
          seven => table {five => e75 ; _ => other} ; 
          nine => table {_ => e90s} ; 
          _ => table {_ => other}} ! s1 ! s2 ; 

lin pot01 = {s = table {unit => "ek" ; next => "di" ; inv => "naw" ; _ => "dummy" } ; s2 = "hajaar" ; size = sg} ;
lin pot0 d = d ;
lin pot110 = ss "das" ;
lin pot111 = ss "gyaara" ;
lin pot1to19 d = ss (d.s ! teen) ;
lin pot0as1 n = {s = n.s ! unit ; s2 = n.s2 ; s3 = (n.s ! unit) ; size = n.size} ;

lin pot1 d = sssize (d.s ! ten) [] (table {five => e50s ; _ => other} ! d.size) ;
lin pot1plus d e = sssize (variants {(d.s ! tene) ++ "par" ++ (e.s ! unit) ; (d.s ! ten) ++ "an" ++ (e.s ! unit)}) (table {nine => e.s ! inv ; _ => e.s ! unit} ! d.size) (spcsize d.size e.size) ;

lin pot1as2 n = {s = n.s ; s2 = n.s2 } ;

lin pot2 d = {s = selsg d.size "so" ((d.s ! unit) ++ "se") ; 
              s2 = selsg d.size [] ((d.s ! unit) ++ "laak") } ;

lin pot2plus d e = 
  {s = mkso d.size e.size (table {e75 => d.s ! next ; e90s => d.s ! next ; _ => d.s ! unit} ! e.size) 
                          (table {e50s => e.s3 ; e90s => e.s3 ; _ => e.s } ! e.size) ; 
   s2 = (d.s ! unit) ++ "laak" ++ (selsg e.size "hajaar" (e.s ++ "hajaar")) } ;

lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = n.s2 } ;
lin pot3plus n m = {s = n.s2 ++ m.s } ;

oper selsg : Size -> Str -> Str -> Str = \sz -> \s1 -> \s2 -> table {sg => s1 ; _ => s2} ! sz ;

oper mkso : Size -> Size -> Str -> Str -> Str = \ds -> \es -> \auxd -> \auxe -> table {
  sg => table {e25 => "sawaa" + "se" ; 
               e50s => "DoD" ++ "se" ++ auxe ; 
               e75 => "pawNe" ++ auxd ; 
               e90s => variants { auxd ++ "kam" ++ auxe ; auxe ++ "kam" ++ auxd} ;
               _ => "ek" ++ "so" ++ auxe} ;
  two => table {e50s => "aDaai" ++ auxe ; 
                e25 => "sawaa" ++ auxd ++ "se" ; 
                e75 => "pawNe" ++ auxd ; 
                e90s => variants { auxd ++ "kam" ++ auxe ; auxe ++ "kam" ++ auxd} ; 
                _ => "do" ++ "se" ++ auxe} ;  
  _ => table {e50s => "saaDe" ++ auxd ++ "se" ++ auxe ; 
              e25 => "sawaa" ++ auxd ++ "se" ; 
              e75 => "pawNe" ++ auxd ; 
              e90s => variants { auxd ++ "kam" ++ auxe ; auxe ++ "kam" ++ auxd} ; 
              _ => auxd ++ "se" ++ auxe} 
  } ! ds ! es ;


}
