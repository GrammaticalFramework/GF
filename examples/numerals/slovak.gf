concrete slovak of Numerals = {
-- include numerals.Abs.gf ;

-- by Karol Ostrovsky, Chalmers
-- mechanically translated to new GF notation by AR

param DForm = unit  | teen  | ten  ;
param Place = indep  | prae  ;

lincat Numeral = {s : Str} ;
lincat Digit = {s : {p1 : DForm ; p2 : Place} => Str} ;
lincat Sub10 = {s : {p1 : DForm ; p2 : Place} => Str} ;
lincat Sub100 = {s : Place => Str} ;
lincat Sub1000 = {s : Place => Str} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;
lin n2  =
  {s = table {{p1 = unit ; p2 = indep} => "dva" ; {p1 = unit ; p2 = prae} => "dve" ; {p1 = teen ; p2 = indep} => "dvanast" ; {p1 = teen ; p2 = prae} => "dvanast" ; {p1 = ten ; p2 = indep} => "dvadsat" ; {p1 = ten ; p2 = prae} => "dvadsat"}} ;
lin n3  =
  {s = table {{p1 = unit ; p2 = indep} => "tri" ; {p1 = unit ; p2 = prae} => "tri" ; {p1 = teen ; p2 = indep} => "trinast" ; {p1 = teen ; p2 = prae} => "trinast" ; {p1 = ten ; p2 = indep} => "tridsat" ; {p1 = ten ; p2 = prae} => "tridsat"}} ;
lin n4  =
  {s = table {{p1 = unit ; p2 = indep} => "styri" ; {p1 = unit ; p2 = prae} => "styri" ; {p1 = teen ; p2 = indep} => "strnast" ; {p1 = teen ; p2 = prae} => "strnast" ; {p1 = ten ; p2 = indep} => "styridsat" ; {p1 = ten ; p2 = prae} => "styridsat"}} ;
lin n5  =
  {s = table {{p1 = unit ; p2 = indep} => "pat" ; {p1 = unit ; p2 = prae} => "pat" ; {p1 = teen ; p2 = indep} => "patnast" ; {p1 = teen ; p2 = prae} => "patnast" ; {p1 = ten ; p2 = indep} => "patdesiat" ; {p1 = ten ; p2 = prae} => "patdesiat"}} ;
lin n6  =
  {s = table {{p1 = unit ; p2 = indep} => "sest" ; {p1 = unit ; p2 = prae} => "sest" ; {p1 = teen ; p2 = indep} => "sestnast" ; {p1 = teen ; p2 = prae} => "sestnast" ; {p1 = ten ; p2 = indep} => "sestdesiat" ; {p1 = ten ; p2 = prae} => "sestdesiat"}} ;
lin n7  =
  {s = table {{p1 = unit ; p2 = indep} => "sedem" ; {p1 = unit ; p2 = prae} => "sedem" ; {p1 = teen ; p2 = indep} => "sedemnast" ; {p1 = teen ; p2 = prae} => "sedemnast" ; {p1 = ten ; p2 = indep} => "sedemdesiat" ; {p1 = ten ; p2 = prae} => "sedemdesiat"}} ;
lin n8  =
  {s = table {{p1 = unit ; p2 = indep} => "osem" ; {p1 = unit ; p2 = prae} => "osem" ; {p1 = teen ; p2 = indep} => "osemnast" ; {p1 = teen ; p2 = prae} => "osemnast" ; {p1 = ten ; p2 = indep} => "osemdesiat" ; {p1 = ten ; p2 = prae} => "osemdesiat"}} ;
lin n9  =
  {s = table {{p1 = unit ; p2 = indep} => "devat" ; {p1 = unit ; p2 = prae} => "devat" ; {p1 = teen ; p2 = indep} => "devatnast" ; {p1 = teen ; p2 = prae} => "devatnast" ; {p1 = ten ; p2 = indep} => "devatdesiat" ; {p1 = ten ; p2 = prae} => "devatdesiat"}} ;
lin pot01  =
  {s = table {{p1 = unit ; p2 = indep} => "jedna" ; {p1 = unit ; p2 = prae} => [] ; {p1 = teen ; p2 = indep} => "jedna" ; {p1 = teen ; p2 = prae} => [] ; {p1 = ten ; p2 = indep} => "jedna" ; {p1 = ten ; p2 = prae} => []}} ;
lin pot0 d =
  {s = table {{p1 = unit ; p2 = indep} => d.s ! {p1 = unit ; p2 = indep} ; {p1 = unit ; p2 = prae} => d.s ! {p1 = unit ; p2 = prae} ; {p1 = teen ; p2 = indep} => d.s ! {p1 = teen ; p2 = indep} ; {p1 = teen ; p2 = prae} => d.s ! {p1 = teen ; p2 = prae} ; {p1 = ten ; p2 = indep} => d.s ! {p1 = ten ; p2 = indep} ; {p1 = ten ; p2 = prae} => d.s ! {p1 = ten ; p2 = prae}}} ;
lin pot110  =
  {s = table {indep => "desat" ; prae => "desat"}} ;
lin pot111  =
  {s = table {indep => "jedenast" ; prae => "jedenast"}} ;
lin pot1to19 d =
  {s = table {indep => d.s ! {p1 = teen ; p2 = indep} ; prae => d.s ! {p1 = teen ; p2 = prae}}} ;
lin pot0as1 n =
  {s = table {indep => n.s ! {p1 = unit ; p2 = indep} ; prae => n.s ! {p1 = unit ; p2 = indep}}} ;
lin pot1 d =
  {s = table {indep => d.s ! {p1 = ten ; p2 = indep} ; prae => d.s ! {p1 = ten ; p2 = prae}}} ;
lin pot1plus d e =
  {s = table {indep => (d.s ! {p1 = ten ; p2 = indep}) ++ e.s ! {p1 = unit ; p2 = indep} ; prae => (d.s ! {p1 = ten ; p2 = prae}) ++ e.s ! {p1 = unit ; p2 = indep}}} ;
lin pot1as2 n =
  {s = table {indep => n.s ! indep ; prae => n.s ! indep}} ;
lin pot2 d =
  {s = table {indep => (d.s ! {p1 = unit ; p2 = prae}) ++ "sto" ; prae => (d.s ! {p1 = unit ; p2 = prae}) ++ "sto"}} ;
lin pot2plus d e =
  {s = table {indep => (d.s ! {p1 = unit ; p2 = prae}) ++ "sto" ++ e.s ! indep ; prae => (d.s ! {p1 = unit ; p2 = prae}) ++ "sto" ++ e.s ! indep}} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = (n.s ! prae) ++ "tisic"} ;
lin pot3plus n m =
  {s = (n.s ! prae) ++ "tisic" ++ m.s ! indep} ;

}
