include numerals.Abs.gf ;

param DForm = unit | teen | ten | neuter ;
param Gen = com | neut ; 
param Size = sg | less10 | pl ;

oper LinDigit = {s : DForm => Str} ;

lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Gen => Str ; size : Size} ;
lincat Sub1000 = {s : Gen => Str ; size : Size} ;

oper mkNum : Str -> Str -> Str -> Str -> LinDigit = 
  \two -> \twelve -> \twenty -> \tvo -> 
  {s = table {unit => two ; teen => twelve ; ten => twenty ; neuter => tvo}} ;
oper regNum : Str -> LinDigit = 
  \fimm -> mkNum fimm (fimm + "tán") (fimm + "tíu") fimm;

oper ss : Str -> {s : Gen => Str ; size : Size} = \s -> {s = table {_ => s } ; size = pl};

lin num x = x ;
lin n2 = mkNum "tveir" "tólf" "tuttugu" "tvö" ;
lin n3 = mkNum "Þrír" "Þréttán" "Þrjátíu" "Þrjú" ;
lin n4 = mkNum "fjórir"  "fjórtán" "fjörutíu" "fjögur";
lin n5 = regNum "fimm" ;
lin n6 = regNum "sex" ;
lin n7 = mkNum "sjö" "sautján" "sjötíu" "sjö" ; 
lin n8 = mkNum "átta" "átján" "áttíu" "átta" ;
lin n9 = mkNum "níu" "nítján" "níutíu" "níu" ;

lin pot01 = {s = table {f => "einn"} ; size = sg } ;
lin pot0 d = {s = d.s ; size = less10 } ;
lin pot110 = ss "tíu" ;
lin pot111 = ss "ellefu" ;
lin pot1to19 d = ss (d.s ! teen) ;
lin pot0as1 n = {s = table {com => n.s ! unit ; neut => n.s ! neuter } ; size = n.size } ;
lin pot1 d = {s = table {_ => d.s ! ten } ; size = pl};
lin pot1plus d e = {s = table {com => d.s ! ten ++ "og" ++ e.s ! unit ; 
                               neut => d.s ! ten ++ "og" ++ e.s ! neuter} ; size = pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = table {_ => omitsg (d.s ! neuter) d.size ++ "hundrað" } ; size = pl} ; 
lin pot2plus d e = {s = table {f => omitsg (d.s ! neuter) d.size ++ "hundrað" ++ (maybeog) e.size ++ e.s ! f} ; size = pl} ; 

lin pot2as3 n = {s = n.s ! com } ;
lin pot3 n = {s = omitsg (n.s ! neut) n.size ++ "Þúsund"} ;
lin pot3plus n m = {s = omitsg (n.s ! neut) n.size ++ "Þúsund" ++ (maybeog m.size) ++ m.s ! com} ;


oper maybeog : Size -> Str = \sz -> table {pl => [] ; _ => "og" } ! sz ;  
oper omitsg : Str -> Size -> Str = \s -> \sz -> table {sg => [] ; _ => s } ! sz ;