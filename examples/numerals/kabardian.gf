-- Kabardian

-- W is superscript w (= IPA labialisation)
-- & is schwa upside down e
-- s' 
-- L is lambda
-- L is lambda with dash across
-- x^ is x with ^ ontop
-- G is gamma

include numerals.Abs.gf ;

param DForm = unit | unite | unitra | teen | ten | tenra | hund | thou;

oper LinDigit = {s : DForm => Str };
oper LinS100 = {s : Str; s2 : Str } ;
lincat Digit =      LinDigit ;
lincat Sub10 =      LinDigit ;
lincat Sub100 =     LinS100 ;
lincat Sub1000 =    LinS100 ;

oper mkNum : Str -> LinDigit = \dwa -> 
  {s = table {unit => dwa ; unite => dwa + "&" ; unitra => dwa + "&ra" ; 
              ten => dwa + "&s'" ; tenra => dwa + "&s'ra" ;
              teen => "p's''&" + "k'W&" + dwa ; 
              hund => "s'a" + "&y" + dwa ; 
              thou => variants {"m&yn"+"&y"+dwa ; dwa+"a"+"s''a"++"m&yn"}}};

oper mkNum2 : Str -> LinDigit = \dwa -> 
  {s = table {unit => dwa ; unite => dwa + "&" ; unitra => dwa + "&ra" ; 
              ten => dwa + "as'" ; tenra => dwa + "as'ra" ;
              teen => "p's''&"+"k'W&"+"t'" ;
              hund => "s'a" + "&y" + "t'" ; 
              thou => variants {"m&yn"+"&y"+"t'" ; dwa+"a"+"s''a"++"m&yn"}}};

oper mkNum3 : Str -> LinDigit = \dwa -> 
  {s = table {unit => dwa ; unite => dwa + "&" ; unitra => dwa + "&ra" ; 
              ten => dwa + "as'" ; tenra => dwa + "as'ra" ;
              teen => "p's''&"+"k'W&"+dwa ;
              hund => "s'a" + "&y" + dwa ; 
              thou => variants {"m&yn"+"&y"+dwa ; dwa+"a"+"s''a"++"m&yn"}}};

lin num x = {s = x.s } ; -- TODO ;

lin n2 = mkNum2 "t'?W" ;
lin n3 = mkNum3 "s'" ;
lin n4 = mkNum "p'L-'" ;
lin n5 = mkNum "tx^W" ;
lin n6 = mkNum "x^"; 
lin n7 = mkNum "bL" ;
lin n8 = mkNum "y" ;
lin n9 = mkNum "bGW" ;

oper bind : Str -> Str -> Str = \s1 -> \s2 -> s1 ++ s2 ;

lin pot01 = 
  {s = table {unit => "z" ; unite => "z&" ; unitra => "z&" + "ra" ;
              teen => "p's''&"+"k'W&"+"z" ; ten => "dummy" ; tenra => "dummy" ;
              hund => "s'a" ; thou => "m&yn"}};

oper ss : Str -> LinS100 = \f ->
  {s = f ; s2 = variants {("m&yn"+"&y") ++ f ; (bind f "as'a") ++ "m&yn"}};

lin pot0 d = d ;
lin pot110 = 
  {s = "p's''&" ; 
   s2 = variants {"m&yn"+"&y"+"p's''" ; "p's''"+"a"+"s''a"++"m&yn"}};
lin pot111 = ss ("p's''&"+"k'W&"+"z") ;
lin pot1to19 d = ss (d.s ! teen) ;
lin pot0as1 n = {s = n.s ! unite ; s2 = n.s ! thou } ;
lin pot1 d = ss (variants {(d.s ! ten) ; (d.s ! unite) ++ "p's''&wa"}) ; 
  -- extra variant p's''ay = 80
lin pot1plus d e = ss ((d.s ! tenra) ++ (e.s ! unitra)) ;
lin pot1as2 n = n ;
lin pot2 d = ss (d.s ! hund) ; 
lin pot2plus d e = ss ((d.s ! hund) ++ e.s) ; 
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = n.s2} ;
lin pot3plus n m = {s = n.s2 ++ m.s} ;
