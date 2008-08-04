concrete nenets of Numerals = {
-- include numerals.Abs.gf ;

-- #n-
-- #t-
-- #l-
-- #s' with , ontop of s
-- #N for n with a thing on the right leg i.e IPA [ng]
-- #|~ a vertical tilde in thge top right corner 
   
param DForm = unit | teen ; 
param Size = sg | nine | pl ;

oper LinDigit = {s : DForm => Str ; size : Size } ;
oper LinS100 = {s : Str ; size : Size} ;

lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = LinS100 ;
lincat Sub1000 = LinS100 ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s } ; -- TODO Encoding

oper mkNum : Str -> Str -> LinDigit =
  \u -> \t -> {s = table {unit => u ; teen => t } ; size = pl} ; 

lin n2 = mkNum (variants {"side"; "sidea"}) "sidejaNan-â|~" ;
lin n3 = mkNum (variants {"n-ahar" ; "nâr"}) "n-aharaNan-â|~" ;
lin n4 = mkNum (variants {"t-êt" ; "t-iet" ; "tiet"}) "t-êtaNan-â|~" ;
lin n5 = mkNum (variants {"saml-aN" ; "sambl-aN" ; "sambel-ank" }) 
               "saml-an-aNan-â|~"; 
lin n6 = mkNum "mat'" "mat-aNan-â|~";
lin n7 = mkNum (variants {"siu" ; "s'eu"}) "siujaNan-â|~" ;
lin n8 = mkNum "sidend-êt" "sidend-êtaNan-â|~" ;
lin n9 = {s = table {unit => variants {"hâsawaju'" ; "habeiju'"} ; 
                     teen => "hâsawajujaNan-â|~" } ; 
          size = nine} ;

oper ss : Str -> LinS100 = \s1 -> {s = s1 ; size = pl} ;

lin pot01 =
  {s = table {unit => variants {"~ob" ; "~opoi" } ; _ => "dummy" }; size = sg};
lin pot0 d = d ;
lin pot110 = ss (variants {"ju'" ; "lûcaju'" ; "lûsaju'" }) ;
lin pot111 = ss (variants {"~objaNan-â|~"; "~objaNn-â" ; "~objaNa"}) ;
lin pot1to19 d = ss (d.s ! teen) ; 
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = ss (ifnine d.size (d.s ! unit)) ;
lin pot1plus d e = ss ((ifnine d.size (d.s ! unit)) ++ (e.s ! unit)) ;
lin pot1as2 n = n ;
lin pot2 d = ss (mkjur d.size (d.s ! unit)) ;
lin pot2plus d e = ss ((mkjur d.size (d.s ! unit)) ++ e.s) ;
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = mkjuonar n.size n.s } ;
lin pot3plus n m = {s = (mkjuonar n.size n.s) ++ m.s } ;

oper mkjuonar : Size -> Str -> Str = \sz -> \attr ->
  table {nine => attr ++ "juonar" ;
         sg => variants {"juonar" ; "jônar" ; "ju" ++ "jur"} ; 
         pl => attr ++ "juonar" } ! sz ;
 
oper mkjur : Size -> Str -> Str = \sz -> \attr ->
  table {sg => "jur" ; _ => attr ++ "jur" } ! sz ;

oper ifnine : Size -> Str -> Str = \sz -> \attr ->
  table {nine => "hâsawajur" ; _ => attr ++ "ju'" } ! sz ;

}
