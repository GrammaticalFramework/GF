-- Kodagu
include numerals.Abs.gf ;

oper bind : Str -> Str -> Str = \a -> \b -> a ++ b ;

oper 
  vowel : Strs = strs {"o" ; "e" ; "a" ; "i" ; "u" ; "ï" ; "ë"} ;
  cons : Strs = 
    strs {"b" ; "g" ; "d" ; "p" ; "t" ; "k" ; "l" ; "r" ; "m" ; "n" ; "s" ; "ñ"} ;

  oper adi : Str = "a" + pre {"dï" ; "tt" / vowel} ;
  oper uri : Str = "u:" + pre {"rï" ; "yt.a" / cons ; "yt."/ vowel} ;
  laks : Str = "laks.a" + T ;
  ayra : Str = "a:yra" + T ;
  
  T : Str = pre {[] ; "t" / vowel ; "t" / cons} ;
  I : Str = pre {"ï" ; [] / vowel } ;-- ; "ï" / cons} ;

oper LinDigit = {s : DForm => Str };
oper LinS100 = {s : Place => Str };

param DForm = unit | ten | teen | hund | thou;
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
  {s = table {unit => u ; teen => tn ; ten => t+adi ; hund => h+uri ; thou => a+ayra} };

lin n2 = mkN "dan.d.ï" ("panneran.d."+I) "iruv" "inn" "i:r" ;
lin n3 = mkN "mu:ndï" ("padïmu:nd"+I) "nupp" "mu:n" "mu:v" ;
lin n4 = mkN "na:lï" ("padïna:l"+I) "na:p" "na:n" "na:l" ;
lin n5 = mkN "an~ji" "padïnan~ji" "aymb" "aññ" "ay" ;
lin n6 = mkN "a:rï" ("padïna:r"+I) "arup" "a:rïn" "a:r" ;
lin n7 = mkN "ë:lï" ("padïnë:l"+I) "ël.up" "ë:l.n" "ë:l." ;
lin n8 = mkN "ët.t.ï" ("padïnët.t."+I) "ëmb" "et.n" "et.t." ;
lin n9 = mkN "oymbadï" ("pattoymbad"+I) "tomb" "oymbayn" "oymbad" ;

oper ss : Str -> LinS100 = \s1 -> {s = table {p => s1 ; lak => bind s1 ayra }} ;

lin pot01 =
  {s = table {unit => "ondï" ; ---- pre {[] ; "ondï" / strs {[]}} ;
                               ---- equivalent by the sem. of pre. AR
              thou => variants {ayra ; "o:r" + ayra} ; 
              hund => "n" + uri ; 
              _ => "dummy"} };
lin pot0 d = d ; 
lin pot110 = ss ("patt"+I) ; 
lin pot111 = ss ("pannond"+I) ;
lin pot1to19 d = ss (d.s ! teen) ; 
lin pot0as1 n = {s = table {p => n.s ! unit ; lak => n.s ! thou } };
lin pot1 d = ss (d.s ! ten) ;
lin pot1plus d e = 
  {s = table {p => bind (d.s ! ten) (e.s ! unit) ; 
              lak => bind (d.s ! ten) (e.s ! thou)}} ;
lin pot1as2 n = n ;
lin pot2 d = 
  {s = table {p => d.s ! hund ; lak => bind (d.s ! unit) laks }};
lin pot2plus d e = 
  {s = table {p => bind (d.s ! hund) (e.s ! p) ; 
              lak => bind (bind (d.s ! unit) laks) (e.s ! lak)}} ;
lin pot2as3 n = {s = n.s ! p} ;
lin pot3 n = {s = n.s ! lak } ;
lin pot3plus n m = {s = bind (n.s ! lak) (m.s ! p) } ;
