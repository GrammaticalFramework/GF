-- Irula
include numerals.Abs.gf ;

oper bind : Str -> Str -> Str = \a -> \b -> a ++ b ;

oper 
  vowel : Strs = strs {"o" ; "e" ; "a" ; "i" ; "u" ; "ä" ; "ö"} ;
  cons : Strs = 
  strs {"b" ; "g" ; "d" ; "p" ; "t" ; "k" ; "l" ; "r" ; "m" ; "n" ; "s" ; "c"};
  oper adu : Str = "a" + pre {"du" ; "tt" / vowel} ;
  oper uru : Str = "u:" + pre {"r_u" ; "tti" / cons ; "tt"/ vowel} ;
  laks : Str = "lacca" + T ;
  ayira : Str = "a:yira" + T ;
  cavira : Str = variants {ayira ; "ca:vira" + T} ;  

  T : Str = pre {[] ; "tt" / vowel ; "tti" / cons} ;
  U : Str = pre {"u" ; [] / vowel } ;-- ; "ï" / cons} ;

oper LinDigit = {s : DForm => Str };
oper LinS100 = {s : Place => Str };

param DForm = unit | ten | teen | hund | thou | thou2;
param Place = p | lak ;

lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = LinS100 ;
lincat Sub1000 = LinS100 ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ; -- TODO

oper mkN : Str -> Str -> Str -> Str -> Str -> LinDigit = 
  \u -> \tn -> \t -> \h -> \a -> 
  {s = table {unit => u ; teen => tn ; ten => t+adu ; hund => h+uru ; thou => a+ayira ; thou2 => a+ayira} };

lin n2 = mkN (variants {"ren.d.u" ; "ran.d.u"}) ("pannen.d."+U) "iruv" "eran" "ren.d." ;
lin n3 = mkN "mu:nr_u" ("padimu:nr_"+U) "mupp" "munn" "mu:nr_" ;
lin n4 = mkN "nä:lu" ("padanä:l"+U) "na:pp" "nä:n" "nä:l" ;
lin n5 = mkN (variants {"anju" ; "anji"}) ("padananj"+U) "amb" "ayin" "anj" ;
lin n6 = mkN "a:ru" ("padana:r_"+U) "ar_uv" "ar_a" "a:r_" ;
lin n7 = mkN "e:l.u" ("padane:l."+U) "el.uv" "el.a" "e:l." ;
lin n8 = mkN "et.t.u" ("padanet.t."+U) "emb" "et.t.un" "et.t." ;
lin n9 = {s = table {unit => "ombadu" ; teen => "pattombad"+U ; 
                     ten => "ton.n."+uru ; hund => "tol.l."+ayira ;
                     thou => "ombadan" + ayira ; thou2 => "ombadan" + ayira }};

oper ss : Str -> LinS100 = \s1 -> {s = table {p => s1 ; lak => bind s1 cavira }} ;

lin pot01 =
  {s = table {unit => pre {[] ; "önr_u" / strs {[]}} ; 
              thou => cavira ;
              thou2 => "or" + ayira ; 
              hund => "n" + uru ; 
              _ => "dummy"} };
lin pot0 d = d ; 
lin pot110 = ss ("patt"+U) ; 
lin pot111 = ss ("padanon.n."+U) ;
lin pot1to19 d = ss (d.s ! teen) ; 
lin pot0as1 n = {s = table {p => n.s ! unit ; lak => n.s ! thou } };
lin pot1 d = ss (d.s ! ten) ;
lin pot1plus d e = 
  {s = table {p => bind (d.s ! ten) (e.s ! unit) ; 
              lak => bind (d.s ! ten) (e.s ! thou2)}} ;
lin pot1as2 n = n ;
lin pot2 d = 
  {s = table {p => d.s ! hund ; lak => bind (d.s ! unit) laks }};
lin pot2plus d e = 
  {s = table {p => bind (d.s ! hund) (e.s ! p) ; 
              lak => bind (bind (d.s ! unit) laks) (e.s ! lak)}} ;
lin pot2as3 n = {s = n.s ! p} ;
lin pot3 n = {s = n.s ! lak } ;
lin pot3plus n m = {s = bind (n.s ! lak) (m.s ! p) } ;
