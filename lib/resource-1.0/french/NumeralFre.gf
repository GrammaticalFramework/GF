concrete NumeralFre of Numeral = CatFre ** 
  open CommonRomance, ResRomance, MorphoFre, Prelude in {

-- originally written in 1998, automatically translated to current notation...
-- last modified 24/1/2006, adding ordinals

-- Auxiliaries

oper
  digitPl : {s : DForm => Str; inh : DForm ; inh1 : Number} ->
            {s : CardOrd => DForm => Str ; inh : DForm ; inh1 : Number} = \d -> {
   s = \\co,df => let ds = d.s ! df in 
     case co of {
       NCard _ => ds ;
       NOrd _ _  => case last ds of {
         "q" => "uième" ;
         "e" => init ds + "ième" ;
         _ => ds + "ième"
         }
       } ;
       inh = d.inh ; inh1 = d.inh1
  } ;

  cardOrd : CardOrd -> Str -> Str -> Str = \co, x,y -> case co of {
    NCard _ => x ; 
    NOrd _ _ => y
    } ;

lincat 
  Digit = {s : CardOrd => DForm => Str ; inh : DForm ; inh1 : Number} ; 
  Sub10 = {s : CardOrd => {p1 : DForm ; p2 : Place} => Str ; inh : Number} ;
  Sub100 = {s : CardOrd => Place => Str} ;
  Sub1000 = {s : CardOrd => Place => Str} ;
  Sub1000000 = {s : CardOrd => Str} ;

lin num x0 = x0 ;

lin n2  =
  digitPl {inh = unit ; inh1 = Sg ; s = table {unit => "deux" ; teen => "douze" ; jten => "vingt" ; ten => "vingt" ; tenplus => "vingt"}} ;
lin n3  =
  digitPl {inh = unit ; inh1 = Sg ; s = table {unit => "trois" ; teen => "treize" ; jten => "trente" ; ten => "trente" ; tenplus => "trente"}} ;
lin n4  =
   digitPl {inh = unit ; inh1 = Sg ; s = table {unit => "quatre" ; teen => "quatorze" ; jten => "quarante" ; ten => "quarante" ; tenplus => "quarante"}} ;
lin n5  =
   digitPl {inh = unit ; inh1 = Sg ; s = table {unit => "cinq" ; teen => "quinze" ; jten => "cinquante" ; ten => "cinquante" ; tenplus => "cinquante"}} ;
lin n6  =
   digitPl {inh = unit ; inh1 = Sg ; s = table {unit => "six" ; teen => "seize" ; jten => "soixante" ; ten => "soixante" ; tenplus => "soixante"}} ;
lin n7  =
   digitPl {inh = teen ; inh1 = Sg ; s = table {unit => "sept" ; teen => "dix-sept" ; jten => "soixante-dix" ; ten => "soixante-dix" ; tenplus => "soixante"}} ;
lin n8  =
   digitPl {inh = unit ; inh1 = Pl ; s = table {unit => "huit" ; teen => "dix-huit" ; jten => "quatre-vingts" ; ten => "quatre-vingt" ; tenplus => "quatre-vingt"}} ;
lin n9  =
   digitPl {inh = teen ; inh1 = Pl ; s = table {unit => "neuf" ; teen => "dix-neuf" ; jten => "quatre-vingt-dix" ; ten => "quatre-vingt-dix" ; tenplus => "quatre-vingt"}} ;

lin pot01  =
  {inh = Sg ; s = \\g => let dix = cardOrd g "dix" "dixième" in table {
  {p1 = unit ; p2 = indep} => cardOrd g "un" "unième" ; {p1 = unit ; p2 = attr} => [] ; {p1 = teen ;
  p2 = indep} => cardOrd g "onze" "onzième" ; {p1 = teen ; p2 = attr} => [] ; {p1 = jten ;
  p2 = indep} => dix ; {p1 = jten ; p2 = attr} => [] ; {p1 = ten ;
  p2 = indep} => dix ; {p1 = ten ; p2 = attr} => [] ; {p1 = tenplus
  ; p2 = indep} => dix ; {p1 = tenplus ; p2 = attr} => []} ; n = Sg} ;
lin pot0 d =
  {inh = Pl ; s = \\g => table {{p1 = unit ; p2 = indep} => d.s ! g !  unit
  ; {p1 = unit ; p2 = attr} => d.s ! g ! unit ; {p1 = teen ; p2 = indep}
  => d.s ! g ! teen ; {p1 = teen ; p2 = attr} => d.s ! g ! teen ; {p1 = jten ;
  p2 = indep} => d.s ! g ! jten ; {p1 = jten ; p2 = attr} => d.s ! g ! jten ;
  {p1 = ten ; p2 = indep} => d.s ! g ! ten ; {p1 = ten ; p2 = attr} => d.s
  ! g ! ten ; {p1 = tenplus ; p2 = indep} => d.s ! g ! tenplus ; {p1 = tenplus
  ; p2 = attr} => d.s ! g ! tenplus} ; n = Pl} ;

lin pot110  =
  {s = \\g => table {_ => cardOrd g "dix" "dixième"} ; n = Pl} ;
lin pot111  =
  {s = \\g => table {_ => cardOrd g "onze" "onzième"} ; n = Pl} ;
lin pot1to19 d =
  {s = \\g => table {indep => d.s ! g ! teen ; attr => d.s ! g ! teen} ; n = Pl} ;
lin pot0as1 n =
  {s = \\g => table {indep => n.s ! g ! {p1 = unit ; p2 = indep} ;
  attr => n.s ! g ! {p1 = unit ; p2 = attr}} ; n = n.n} ;
lin pot1 d =
  {s = \\g => table {indep => d.s ! g ! jten ; attr => d.s ! g ! ten}
  ; n = Pl} ;
lin pot1plus d e =
  {s = \\g => table {indep => (d.s ! (NCard Masc) ! tenplus) ++ (table {{p1 = Sg
  ; p2 = Sg} => "et" ; {p1 = Sg ; p2 = pl} => "-" ; {p1 = Pl ; p2 =
  Sg} => "-" ; {p1 = Pl ; p2 = pl} => "-"} ! {p1 = d.inh1 ; p2 =
  e.inh}) ++ e.s ! g ! {p1 = d.inh ; p2 = indep} ; attr => (d.s ! (NCard Masc) !
  tenplus) ++ (table {{p1 = Sg ; p2 = Sg} => "et" ; {p1 = Sg ; p2 =
  pl} => "-" ; {p1 = Pl ; p2 = Sg} => "-" ; {p1 = Pl ; p2 = pl} =>
  "-"} ! {p1 = d.inh1 ; p2 = e.inh}) ++ e.s ! g ! {p1 = d.inh ; p2 =
  indep}} ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d =
  {s = \\g => table {indep => (d.s ! NCard Masc ! {p1 = unit ; p2 = attr})
  ++ table {Sg => cardOrd g "cent" "centième" ; Pl => cardOrd g "cents" "centième"} ! (d.inh) ; attr => (d.s !
  NCard Masc ! {p1 = unit ; p2 = attr}) ++ cardOrd g "cent" "centième"} ; n = Pl} ;
lin pot2plus d e =
  {s = \\g => table {indep => (d.s ! NCard Masc ! {p1 = unit ; p2 = attr})
  ++ "cent" ++ e.s ! g ! indep ; attr => (d.s ! NCard Masc ! {p1 = unit ; p2
  = attr}) ++ "cent" ++ e.s ! g ! indep} ; n = Pl} ;
lin pot2as3 n =
  {s = \\g => n.s ! g ! indep ; n = n.n} ;
lin pot3 n =
  {s = \\g => (n.s ! NCard Masc ! attr) ++ cardOrd g "mille" "millième" ; n = Pl} ;
lin pot3plus n m =
  {s = \\g => (n.s ! NCard Masc !  attr) ++  "mille" ++ m.s ! g ! indep ; n =
  Pl} ;

}