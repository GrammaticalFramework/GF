include numerals.Abs.gf ;

param DForm = unit | ten | teen ;

-- Have no idea about the orthography, taken from Univ. History of Numbers
-- Georges Ifrah p. 26


lincat Digit = {s : DForm => Str} ;
lincat Sub10 = {s : DForm => Str} ;

oper mkNum : Str -> Lin Digit = 
  \gnyis ->  
  {s = table {unit => gnyis ; teen => "bcu" ++ gnyis ; ten => gnyis ++ "bcu" }} ;

-- lin n1 mkNum "gcig" ;
lin n2 = mkNum "gnyis" ; 
lin n3 = mkNum "gsum" ;
lin n4 = mkNum "bzhi" ;
lin n5 = mkNum "lnga" ;
lin n6 = mkNum "drug" ;
lin n7 = mkNum "bdun" ;
lin n8 = mkNum "brgyad" ; 
lin n9 = mkNum "dgu" ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {f => "gcig"}} ;
lin pot0 d = {s = table {f => d.s ! f}} ;
lin pot110 = ss "bcu" ; 
lin pot111 = ss ("bcu" ++ "gcig");
lin pot1to19 d = {s = d.s ! teen } ;
lin pot0as1 n = {s = n.s ! unit } ;
lin pot1 d = {s = d.s ! ten } ;
lin pot1plus d e = {s = d.s ! ten ++ e.s ! unit} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! unit ++ "brgya"} ;
lin pot2plus d e = {s = d.s ! unit ++ "brgya" ++ e.s} ;

lin pot2as3 n = n ;
lin pot3 n = {s = n.s ++ "thousand"} ;
lin pot3plus n m = {s = n.s ++ "thousand" ++ m.s} ;

-- Don't know the word for thousand




