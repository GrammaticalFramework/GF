include numerals.Abs.gf ;

-- unit + hundreds | mille are written together more often that not. 
-- ten + unit are written together!

param DForm = ental Pred | ton | tiotal | spctre;
param Num = sg | pl ;
param Pred = pred | indip ;

oper LinDigit = {s : DForm => Str} ;

lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; n : Num} ;
lincat Sub100 = {s : Str ; n : Num} ;
lincat Sub1000 = {s : Str ; n : Num} ;
lincat Sub1000000 = {s : Str} ;

oper vowel : Strs = strs {"u" ; "o"} ; -- uno e otto

oper mkTal : Str -> Str -> Str -> LinDigit = 
  \två -> \tolv -> \tjugo -> 
  {s = table {ental _ => två ; ton => tolv ; tiotal => tjugo ; spctre => två}} ;
oper ss : Str -> {s : Str} = \s -> {s = s} ;
oper spl : Str -> {s : Str ; n : Num} = \s -> {s = s ; n = pl} ;
oper mille : Str -> Num => Str = \s -> table {sg => "mille" ; pl => s ++ "mila"} ; -- Glue s + "mila"!

lin num x = x ;

lin n2 = mkTal "due"  "dodici"  ("vent" + pre {"i" ; [] / vowel}) ;
lin n3 = {s = table {ental _ => "tre" ; ton => "tredici" ; tiotal => ("trent" + pre {"a" ; [] / vowel}) ; spctre => "tré" } };
lin n4 = mkTal "quattro" "quattordici" ("quarant" + pre {"a" ; [] / vowel}) ;
lin n5 = mkTal "cinque" "quindici" ("cinquant" + pre {"a" ; [] / vowel}) ;
lin n6 = mkTal "sei" "sedici" ("sessant" + pre {"a" ; [] / vowel}) ;
lin n7 = mkTal "sette"  "diciassette" ("settant" + pre {"a" ; [] / vowel}) ;
lin n8 = mkTal "otto" "diciotto"   ("ottant" + pre {"a" ; [] / vowel}) ;
lin n9 = mkTal "nove"  "diciannove" ("novant" + pre {"a" ; [] / vowel});

lin pot01 = {s = table {ental pred => [] ; _  => "uno"} ; n = sg} ;
lin pot0 d = {s = table {f => d.s ! f} ; n = pl} ;
lin pot110 = spl "dieci" ;
lin pot111 = spl "undici" ;
lin pot1to19 d = spl (d.s ! ton) ;
lin pot0as1 n = {s = n.s ! ental indip ; n = n.n} ;
lin pot1 d = spl (d.s ! tiotal) ;
lin pot1plus d e = spl (d.s ! tiotal ++ e.s ! spctre) ; -- Glue!
lin pot1as2 n =  {s = n.s ; n = n.n} ;
lin pot2 d = spl (d.s ! ental pred ++ "cento") ; -- Glue!
lin pot2plus d e = spl (d.s ! ental pred ++ "cento" ++ e.s) ; -- Glue!
lin pot2as3 n = {s = n.s ; n = n.n}  ;
lin pot3 n = ss ((mille n.s) ! n.n) ;
lin pot3plus n m = ss ((mille n.s) ! n.n ++ m.s) ;

