include numerals.Abs.gf ;

oper bind : Str -> Str -> Str = \s1 -> \s2 -> s1 ++ s2;

param DForm = unit | teen | bform | ten | hundred | agg ;

-- Sorry no tibetan script but the adhoc transliteration should be phonematic
-- 21 has an extra variant namely nyerchi'

oper LinDigit = {s : DForm => Str} ;

lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; s2 : Str} ;
lincat Sub1000 = {s : Str ; s2 : Str} ;

oper mkNum : Str -> Str -> Str -> Str -> LinDigit = 
  \u -> \tn -> \b -> \t ->  
  {s = table {unit => u ; teen => tn ; bform => b + "chu" ; ten => t ; hundred => b + "g~ya" ; agg => "t.'a'" ++ u}} ;

-- lin n1 mkNum "chi'" "chug/chi'"  ;
lin n2 = 
{s = table {unit => "n~yi:" ; teen => "chug/n~yi:" ; ten => "tsag/" ; 
            bform => "nyishu" ; hundred => (variants {"nyibg~ya"; "nyi:bg~ya"}) ; 
            agg => "t.'a'" ++ "n~yi:" } };
lin n3 = mkNum "sum" "chug/sum" "sum" "sog/" ;
lin n4 = mkNum "z~hyi" "chubz~hyi" (variants {"z~hyib" ; "z~hib"}) "z/hye" ; 
lin n5 = mkNum "n~ga" "chö:n~ga" "n~gab" "nga" ;
lin n6 = mkNum "d.u'" "chud.u'" "d.ug/" "re";
lin n7 = mkNum "d~ün" "chubd~ün" "d~ün" "d/ön";
lin n8 = mkNum "g~yä'" "chobg~yä'" "g~yä'" "g/ya"; 
lin n9 = mkNum "g~u" "chug~u" "g~ub" "g/o";

oper dang : Str = "d/ang" ;
oper tampa : Str -> Str = \s -> (variants {s; s ++ "t'ampa"});

lin num x = {s = "/X" ++ x.s ++ "X/" }; -- extra diacritics translation 

lin pot01 = 
  {s = table {hundred => "g~ya" ; agg => (variants {[] ; "t'a'"}) ; _ => "chi'"}} ;
lin pot0 d = d ; 
lin pot110 = {s = tampa "chu" ; s2 = variants {"t.'i" ; "t.'it.'a'"}} ; 
lin pot111 = 
  {s = "chug/chi'" ; 
   s2 = variants {"t.'i" ; "t.'it.'a'"} ++ dang ++ variants {"t~ong'i" ; "t~ongt.'a'"}} ;
lin pot1to19 d = {s = d.s ! teen ; s2 = variants {"t.'i" ; "t.'it.'a'"} ++ mkagg (d.s ! agg) "t~ong"} ;
lin pot0as1 n = {s = n.s ! unit ; s2 = mkagg (n.s ! agg) "t~ong"} ;
lin pot1 d = {s = tampa (d.s ! bform) ; s2 = mkagg (d.s ! agg) "t.'i"} ;
lin pot1plus d e = 
  {s = variants { d.s ! bform ++ (bind (d.s ! ten) (e.s ! unit)) ; 
       (bind (d.s ! ten) (e.s ! unit))} ; 
   s2 = mkagg (d.s ! agg) "t.'i" ++ dang ++ mkagg (e.s ! agg) "t~ong"} ;
lin pot1as2 n = {s = n.s ; s2 = n.s2 } ;
lin pot2 d = {s = d.s ! hundred ; s2 = mkagg (d.s ! agg) "b~um" } ;
lin pot2plus d e = {s = d.s ! hundred ++ dang ++ e.s ;
                    s2 = mkagg (d.s ! agg) "b~um" ++ dang ++ e.s2} ;
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = n.s2 } ; 
lin pot3plus n m = {s = n.s2 ++ dang ++ m.s} ;

oper mkagg : Str -> Str -> Str = \attr -> \s -> bind s attr ;




