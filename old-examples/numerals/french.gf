include numerals.Abs.gf ;

param DForm = unit  | teen  | jten  | ten  | tenplus  ;
param Nm = sg  | pl  ;
param Place = indep  | attr  ;


lincat Numeral = {s : Str} ;
lincat Digit = {inh : DForm ; inh1 : Nm ; s : DForm => Str} ;
lincat Sub10 = {inh : Nm ; s : {p1 : DForm ; p2 : Place} => Str} ;
lincat Sub100 = {s : Place => Str} ;
lincat Sub1000 = {s : Place => Str} ;
lincat Sub1000000 = {s : Str} ;

lin num x0 =
  {s = x0.s} ;
lin n2  =
  {inh = unit ; inh1 = sg ; s = table {unit => "deux" ; teen => "douze" ; jten => "vingt" ; ten => "vingt" ; tenplus => "vingt"}} ;
lin n3  =
  {inh = unit ; inh1 = sg ; s = table {unit => "trois" ; teen => "treize" ; jten => "trente" ; ten => "trente" ; tenplus => "trente"}} ;
lin n4  =
  {inh = unit ; inh1 = sg ; s = table {unit => "quatre" ; teen => "quatorze" ; jten => "quarante" ; ten => "quarante" ; tenplus => "quarante"}} ;
lin n5  =
  {inh = unit ; inh1 = sg ; s = table {unit => "cinq" ; teen => "quinze" ; jten => "cinquante" ; ten => "cinquante" ; tenplus => "cinquante"}} ;
lin n6  =
  {inh = unit ; inh1 = sg ; s = table {unit => "six" ; teen => "seize" ; jten => "soixante" ; ten => "soixante" ; tenplus => "soixante"}} ;
lin n7  =
  {inh = teen ; inh1 = sg ; s = table {unit => "sept" ; teen => "dix" ++ "-" ++ "sept" ; jten => "soixante" ++ "-" ++ "dix" ; ten => "soixante" ++ "-" ++ "dix" ; tenplus => "soixante"}} ;
lin n8  =
  {inh = unit ; inh1 = pl ; s = table {unit => "huit" ; teen => "dix" ++ "-" ++ "huit" ; jten => "quatre" ++ "-" ++ "vingts" ; ten => "quatre" ++ "-" ++ "vingt" ; tenplus => "quatre" ++ "-" ++ "vingt"}} ;
lin n9  =
  {inh = teen ; inh1 = pl ; s = table {unit => "neuf" ; teen => "dix" ++ "-" ++ "neuf" ; jten => "quatre" ++ "-" ++ "vingt" ++ "-" ++ "dix" ; ten => "quatre" ++ "-" ++ "vingt" ++ "-" ++ "dix" ; tenplus => "quatre" ++ "-" ++ "vingt"}} ;
lin pot01  =
  {inh = sg ; s = table {{p1 = unit ; p2 = indep} => "un" ; {p1 = unit ; p2 = attr} => [] ; {p1 = teen ; p2 = indep} => "onze" ; {p1 = teen ; p2 = attr} => [] ; {p1 = jten ; p2 = indep} => "dix" ; {p1 = jten ; p2 = attr} => [] ; {p1 = ten ; p2 = indep} => "dix" ; {p1 = ten ; p2 = attr} => [] ; {p1 = tenplus ; p2 = indep} => "dix" ; {p1 = tenplus ; p2 = attr} => []}} ;
lin pot0 d =
  {inh = pl ; s = table {{p1 = unit ; p2 = indep} => d.s ! unit ; {p1 = unit ; p2 = attr} => d.s ! unit ; {p1 = teen ; p2 = indep} => d.s ! teen ; {p1 = teen ; p2 = attr} => d.s ! teen ; {p1 = jten ; p2 = indep} => d.s ! jten ; {p1 = jten ; p2 = attr} => d.s ! jten ; {p1 = ten ; p2 = indep} => d.s ! ten ; {p1 = ten ; p2 = attr} => d.s ! ten ; {p1 = tenplus ; p2 = indep} => d.s ! tenplus ; {p1 = tenplus ; p2 = attr} => d.s ! tenplus}} ;
lin pot110  =
  {s = table {indep => "dix" ; attr => "dix"}} ;
lin pot111  =
  {s = table {indep => "onze" ; attr => "onze"}} ;
lin pot1to19 d =
  {s = table {indep => d.s ! teen ; attr => d.s ! teen}} ;
lin pot0as1 n =
  {s = table {indep => n.s ! {p1 = unit ; p2 = indep} ; attr => n.s ! {p1 = unit ; p2 = attr}}} ;
lin pot1 d =
  {s = table {indep => d.s ! jten ; attr => d.s ! ten}} ;
lin pot1plus d e =
  {s = table {indep => (d.s ! tenplus) ++ (table {{p1 = sg ; p2 = sg} => "et" ; {p1 = sg ; p2 = pl} => "-" ; {p1 = pl ; p2 = sg} => "-" ; {p1 = pl ; p2 = pl} => "-"} ! {p1 = d.inh1 ; p2 = e.inh}) ++ e.s ! {p1 = d.inh ; p2 = indep} ; attr => (d.s ! tenplus) ++ (table {{p1 = sg ; p2 = sg} => "et" ; {p1 = sg ; p2 = pl} => "-" ; {p1 = pl ; p2 = sg} => "-" ; {p1 = pl ; p2 = pl} => "-"} ! {p1 = d.inh1 ; p2 = e.inh}) ++ e.s ! {p1 = d.inh ; p2 = indep}}} ;
lin pot1as2 n =
  {s = table {indep => n.s ! indep ; attr => n.s ! attr}} ;
lin pot2 d =
  {s = table {indep => (d.s ! {p1 = unit ; p2 = attr}) ++ table {sg => "cent" ; pl => "cents"} ! (d.inh) ; attr => (d.s ! {p1 = unit ; p2 = attr}) ++ "cent"}} ;
lin pot2plus d e =
  {s = table {indep => (d.s ! {p1 = unit ; p2 = attr}) ++ "cent" ++ e.s ! indep ; attr => (d.s ! {p1 = unit ; p2 = attr}) ++ "cent" ++ e.s ! indep}} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = (n.s ! attr) ++ "mille"} ;
lin pot3plus n m =
  {s = (n.s ! attr) ++ "mille" ++ m.s ! indep} ;
