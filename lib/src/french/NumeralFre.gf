concrete NumeralFre of Numeral = CatFre [Numeral,Digits] ** 
  open CommonRomance, ResRomance, MorphoFre, Prelude in {

-- originally written in 1998, automatically translated to current notation...
-- last modified 24/1/2006, adding ordinals

-- Auxiliaries

oper
  digitPl : {s : DForm => Str; inh : DForm ; n : Number} ->
            {s : CardOrd => DForm => Str ; inh : DForm ; n : Number} = \d -> {
   s = \\co,df => let ds = d.s ! df in 
     case co of {
       NCard _ => ds ;
       NOrd _ _  => case last ds of {
         "q" => ds + "uième" ;
         "e" => init ds + "ième" ;
         _ => ds + "ième"
         }
       } ;
       inh = d.inh ; n = d.n
  } ;

  cardOrdG : CardOrd -> (_,_,_,_,_,_ : Str) -> Str = 
    \co,x,xf,sm,sf,pm,pf -> case co of {
    NCard Masc => x ; 
    NCard Fem => xf ; 
    NOrd Masc Sg => sm ;
    NOrd Fem  Sg => sf ;
    NOrd Masc Pl => pm ;
    NOrd Fem  Pl => pf
    } ;

  cardOrd : CardOrd -> Str -> Str -> Str = \co, x,y -> case co of {
    NCard _ => x ; 
    NOrd _ _ => y
    } ;

param DForm = unit  | teen  | jten  | ten  | tenplus  ;
param Placement = indep  | postpo | attr  ;

lincat 
  Digit = {s : CardOrd => DForm => Str ; inh : DForm ; n : Number} ; 
  Sub10 = {s : CardOrd => (DForm * Placement) => Str ; inh : Number} ;
  Sub100 = {s : CardOrd => Placement => Str ; n : Number} ;
  Sub1000 = {s : CardOrd => Placement => Str ; n : Number} ;
  Sub1000000 = {s : CardOrd => Str ; n : Number} ;

lin num x0 = x0 ;

lin n2  =
  digitPl {inh = unit ; n = Sg ; s = table {unit => "deux" ; teen => "douze" ; jten => "vingt" ; ten => "vingt" ; tenplus => "vingt"}} ;
lin n3  =
  digitPl {inh = unit ; n = Sg ; s = table {unit => "trois" ; teen => "treize" ; jten => "trente" ; ten => "trente" ; tenplus => "trente"}} ;
lin n4  =
  digitPl {inh = unit ; n = Sg ; s = table {unit => "quatre" ; teen => "quatorze" ; jten => "quarante" ; ten => "quarante" ; tenplus => "quarante"}} ;
lin n5  =
   digitPl {inh = unit ; n = Sg ; s = table {unit => "cinq" ; teen => "quinze" ; jten => "cinquante" ; ten => "cinquante" ; tenplus => "cinquante"}} ;
lin n6  =
   digitPl {inh = unit ; n = Sg ; s = table {unit => "six" ; teen => "seize" ; jten => "soixante" ; ten => "soixante" ; tenplus => "soixante"}} ;
lin n7  =
   digitPl {inh = teen ; n = Sg ; s = table {unit => "sept" ; teen => "dix-sept" ; jten => "soixante-dix" ; ten => "soixante-dix" ; tenplus => "soixante"}} ;
lin n8  =
   digitPl {inh = unit ; n = Pl ; s = table {unit => "huit" ; teen => "dix-huit" ; jten => "quatre-vingts" ; ten => "quatre-vingt" ; tenplus => "quatre-vingt"}} ;
lin n9  =
   digitPl {inh = teen ; n = Pl ; s = table {unit => "neuf" ; teen => "dix-neuf" ; jten => "quatre-vingt-dix" ; ten => "quatre-vingt-dix" ; tenplus => "quatre-vingt"}} ;

lin pot01  =
  {inh = Sg ; s = \\g => let dix = cardOrd g "dix" "dixième" in table {
  {p1 = unit ; p2 = indep} => 
     cardOrdG g "un" "une" "premier" "première" "premiers" "premières" ; 
  {p1 = unit ; p2 = postpo} => 
     cardOrdG g "un" "une" "unième"  "unième"  "unième"  "unième" ;
  {p1 = unit ; p2 = attr} => [] ; 
  {p1 = teen ; p2 = indep | postpo} => cardOrd g "onze" "onzième" ; 
  {p1 = teen ; p2 = attr} => [] ; 
  {p1 = jten ; p2 = indep | postpo} => dix ; 
  {p1 = jten ; p2 = attr} => [] ; 
  {p1 = ten  ; p2 = indep | postpo} => dix ; 
  {p1 = ten ; p2 = attr} => [] ; 
  {p1 = tenplus ; p2 = indep | postpo} => dix ; 
  {p1 = tenplus ; p2 = attr} => []} ; 
  n = Sg} ;
lin pot0 d =
  {inh = Pl ; s = \\g => table {
    {p1 = unit ; p2 = indep | postpo} => d.s ! g !  unit ; 
    {p1 = unit ; p2 = attr} => d.s ! g ! unit ; 
    {p1 = teen ; p2 = indep | postpo} => d.s ! g ! teen ; 
    {p1 = teen ; p2 = attr} => d.s ! g ! teen ; 
    {p1 = jten ; p2 = indep | postpo} => d.s ! g ! jten ; 
    {p1 = jten ; p2 = attr} => d.s ! g ! jten ;
    {p1 = ten ; p2 = indep | postpo} => d.s ! g ! ten ; 
    {p1 = ten ; p2 = attr} => d.s ! g ! ten ; 
    {p1 = tenplus ; p2 = indep | postpo} => d.s ! g ! tenplus ; 
    {p1 = tenplus ; p2 = attr} => d.s ! g ! tenplus} ; n = Pl} ;

lin pot110  =
  {s = \\g => table {_ => cardOrd g "dix" "dixième"} ; n = Pl} ;
lin pot111  =
  {s = \\g => table {_ => cardOrd g "onze" "onzième"} ; n = Pl} ;
lin pot1to19 d =
  {s = \\g => table {indep | postpo => d.s ! g ! teen ; attr => d.s ! g ! teen} ; n = Pl} ;
lin pot0as1 n =
  {s = \\g => table {
  p@(indep | postpo) => n.s ! g ! {p1 = unit ; p2 = p} ;
  attr => n.s ! g ! {p1 = unit ; p2 = attr}} ; n = n.inh} ;
lin pot1 d =
  {s = \\g => table {indep | postpo => d.s ! g ! jten ; attr => d.s ! g ! ten}
  ; n = Pl} ;
lin pot1plus d e =
  {s = \\g => table {
  p@(indep | postpo) => (d.s ! (NCard Masc) ! tenplus) ++ (table {{p1 = Sg
  ; p2 = Sg} => "et" ; {p1 = Sg ; p2 = pl} => "-" ; {p1 = Pl ; p2 =
  Sg} => "-" ; {p1 = Pl ; p2 = pl} => "-"} ! {p1 = d.n ; p2 =
  e.inh}) ++ e.s ! g ! {p1 = d.inh ; p2 = p} ; 
  attr => (d.s ! (NCard Masc) !
  tenplus) ++ (table {{p1 = Sg ; p2 = Sg} => "et" ; {p1 = Sg ; p2 =
  pl} => "-" ; {p1 = Pl ; p2 = Sg} => "-" ; {p1 = Pl ; p2 = pl} =>
  "-"} ! {p1 = d.n ; p2 = e.inh}) ++ e.s ! g ! {p1 = d.inh ; p2 =
  indep}} ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d =
  {s = \\g => table {indep | postpo => (d.s ! NCard Masc ! {p1 = unit ; p2 = attr})
  ++ table {Sg => cardOrd g "cent" "centième" ; Pl => cardOrd g "cents" "centième"} ! (d.inh) ; attr => (d.s !
  NCard Masc ! {p1 = unit ; p2 = attr}) ++ cardOrd g "cent" "centième"} ; n = Pl} ;
lin pot2plus d e =
  {s = \\g => table {
    attr => (d.s ! NCard Masc ! {p1 = unit ; p2 = attr}) ++ "cent" ++ e.s ! g ! indep ;
    p => (d.s ! NCard Masc ! {p1 = unit ; p2 = attr}) ++ "cent" ++ e.s ! g ! p 
   } ; 
   n = Pl 
  } ;
lin pot2as3 n =
  {s = \\g => n.s ! g ! indep ; n = n.n} ;
lin pot3 n =
  {s = \\g => (n.s ! NCard Masc ! attr) ++ cardOrd g "mille" "millième" ; n = Pl} ;
lin pot3plus n m =
  {s = \\g => (n.s ! NCard Masc !  attr) ++  "mille" ++ m.s ! g ! postpo ; n =
  Pl} ;


-- numerals as sequences of digits

  lincat 
    Dig = TDigit ;

  lin
    IDig d = d ;

    IIDig d i = {
      s = \\o => d.s ! NCard Masc ++ i.s ! o ;
      n = Pl
    } ;

    D_0 = mkDig "0" ;
    D_1 = mk3Dig "1" "1er" Sg ; ---- gender
    D_2 = mk2Dig "2" "2ème" ;
    D_3 = mk2Dig "3" "3ème" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;

  oper
    mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o Pl ;
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + "ème") ;

    mk3Dig : Str -> Str -> Number -> TDigit = \c,o,n -> {
      s = table {NCard _ => c ; NOrd _ _ => o} ; ---- gender
      n = n
      } ;

    TDigit = {
      n : Number ;
      s : CardOrd => Str
    } ;

}
