include numerals.Abs.gf ;
flags coding=latinasupplement ;

-- D^ is from implosive d IPA symbol
-- N Num 

param Size = sg | two | three | other ;

oper LinDigit = {s : Str ; size : Size} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = LinDigit ;
lincat Sub1000 = LinDigit ;
lincat Sub1000000 = {s : Str} ;

oper mkNum : Str -> LinDigit = \kunun ->
  {s = kunun ; size = other} ;

lin num x0 =
  {s = "/L" ++ x0.s ++ "L/"} ; -- for D^ 

lin n2 = {s = variants {"póllów" ; "fóllów"} ; size = two }; 
lin n3 = {s = "kúnún" ; size = three }  ;
lin n4 = mkNum (variants {"pòD^òw" ; "fòD^òw"}) ;
lin n5 = mkNum (variants {"páaD^í" ; "fáaD^í"}) ;
lin n6 = mkNum (variants {"páyíndì" ; "fáyíndì"}) ;
lin n7 = mkNum (variants {"pópíllów" ; "fópíllów"}) ;
lin n8 = mkNum (variants {"pówùrD^ów" ; "fówùrD^ów"}) ;
lin n9 = mkNum "làmbáD^à" ;

oper thirty : Str = variants {("kúu" ++ "kúnún") ; "tàlàatín"} ;
oper two100 : Str = variants {"dálmágí" ++ "póllów" ; "mèetán"} ;
oper thousand : Str = variants {("dálmágí" ++ "kúmó") ; "dùbúk" ; "dúbúk"} ;

lin pot01  =
  {s = "múndí" ; size = sg};
lin pot0 d = d ;
lin pot110 = mkNum "kúmó" ; 
lin pot111 = mkNum ("kúmó" ++ "kán" ++ "múndí") ;
lin pot1to19 d = mkNum ((variants {"kúmó" ++ "kán" ; "tùrò"}) ++ d.s ) ;
lin pot0as1 n = n ;
lin pot1 d = mkNum (table {three => thirty ; _ => "kúu" ++ d.s} ! d.size) ; 
lin pot1plus d e = mkNum ((table {three => thirty ; _ => "kúu" ++ d.s} ! d.size) ++ "kán" ++ e.s) ;
lin pot1as2 n = n ;
lin pot2 d = mkNum (table {sg => (variants {"dálmágí" ; "dálmák"}) ; two => two100 ; _ => "dálmágí" ++ d.s } ! d.size) ; 
lin pot2plus d e = mkNum ((table {two => two100 ; sg => (variants {"dálmágí" ; "dálmák"}) ; _ => "dálmágí" ++ d.s } ! d.size) ++ "kán" ++ e.s) ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = table {sg => thousand ; _ => "dùbúk" ++ n.s} ! n.size } ;
lin pot3plus n m = {s = table {sg => thousand ; _ => "dùbúk" ++ n.s} ! n.size ++ m.s} ;