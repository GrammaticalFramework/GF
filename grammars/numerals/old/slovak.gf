include numerals.Abs.gf ;

-- [c^], [s^], [c']

param Size = sg | twothreefour | fiveup ;
param DForm = unit | teen | ten | hundred ; 

lincat Digit = {s : DForm => Str ; size : Size} ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Str; size : Size } ;
lincat Sub1000 = {s : Str; size : Size } ;

oper mkNum : Str -> Str -> Str -> Size -> Lin Digit = 
  \dva -> \dvanast -> \dvadsat -> \sz -> 
  { s = table {unit => dva ; teen => dvanast ; ten => dvadsat ; hund =>
dva + "sto" };
    size = sz
  };

oper mkRegNum : Str -> Lin Digit = \unit -> 
  mkNum unit (unit + "nást'") (unit + "desiat") fiveup ; 

lin num x = {s = "/L" ++ x.s ++ "L/" } ; -- Latin A supplement encoding

lin n2 = mkNum "dva" "dvanást'" "dvadsat'" twothreefour ;
lin n3 = mkNum "tri" "trinást'" "tridsat'" twothreefour ;
lin n4 = mkNum "s^tyri" "s^trnást'" "s^tyridsat'" twothreefour ;
lin n5 = mkNum "pät'" "pätnást'" "pädesiat" fiveup ;
lin n6 = mkNum "s^est'" "s^estnást'" "s^estdesiat" fiveup ;
lin n7 = mkRegNum "sedem" ;
lin n8 = mkRegNum "osem" ;
lin n9 = mkNum "devät'" "devätnást'" "devätdesiat" fiveup ;

lin pot01 = {s = table {unit => "jeden" ; hundred => "sto" ; _ => "dummy" } ;
             size = sg } ; 
lin pot0 d = d ; 
lin pot110 = {s = "desät'" ; size = fiveup } ;
lin pot111 = {s = "jedenást'" ; size = fiveup };
lin pot1to19 d = {s = d.s ! teen ; size = fiveup} ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; size = fiveup} ;
lin pot1plus d e = {s = variants { d.s ! ten ++ e.s ! unit ; e.s ! unit ++ "a" ++ d.s ! ten} ; size = tfSize e.size} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! hundred ; size = fiveup} ;
lin pot2plus d e = {s = d.s ! hundred ++ e.s ; size = tfSize e.size} ;
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = (mkTh n.s) ! n.size} ;
lin pot3plus n m = {s = (mkTh n.s) ! n.size ++ m.s} ;

oper tfSize : Size -> Size = \sz -> 
  table {sg => fiveup ; other => other} ! sz ; 

oper mkTh : Str -> Size => Str = \attr -> 
  table {sg => "tisíc" ; 
         twothreefour => attr ++ "tisíce" ; 
         fiveup => attr ++ "tisíc" } ;
